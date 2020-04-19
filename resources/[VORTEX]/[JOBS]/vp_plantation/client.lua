RegisterNetEvent("VP:PLANTATION:StartPlayerPlacement")
RegisterNetEvent("VP:PLANTATION:SyncPlant")
RegisterNetEvent("VP:PLANTATION:SyncMultiplePlants")

AddEventHandler(
    "VP:PLANTATION:StartPlayerPlacement",
    function(source, type)
        print("VP:PLANTATION:StartPlayerPlacement")
        createTempEntity(type)
    end
)


AddEventHandler(
    "VP:PLANTATION:SyncPlant",
    function(plantId, type, x, y, z, h)
        Plant(plantId, type, x, y, z, h)
    end
)

AddEventHandler(
    "VP:PLANTATION:SyncMultiplePlants",
    function(array)
        for plantId, values in pairs(array) do
            Plant(plantId, values[1], values[2], values[3], values[4], values[5])
        end
    end
)

local tempEntity
local tempType

function createTempEntity(type)
    if tempEntity ~= nil then
        DeleteEntity(tempEntity)
    end

    local forwardVector = GetEntityForwardVector(ped)
    local vec = GetEntityCoords(ped) + forwardVector * 3.0
    tempEntity = CreateObject(getModelFromCapacity(type), vec, false, true, false)
    tempType = type
    SetEntityAlpha(tempEntity, 110, false)
    print("createTempEntity")
end

function RotAnglesToVec(rot) -- input vector3
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

function GetGroundOnViewingDistance()
    local coords = GetGameplayCamCoord()
    local forward_vector = RotAnglesToVec(GetGameplayCamRot(2))
  --  DrawLine(coords, coords + (forward_vector * 10.0), 255, 0, 0, 255) -- debug line to show LOS of cam
    local rayhandle = StartShapeTestRay(coords, coords + (forward_vector * 10.0), -1, -1, 0)
    local retVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayhandle)

    return hit, endCoords, entityHit
end

function drawTempEntity()
    if tempEntity ~= nil then
        local ped = PlayerPedId()

        -- local forwardVector = GetEntityForwardVector(ped)
        -- local vec = (GetEntityCoords(ped) + forwardVector * 3.0)

        local hit, groundCoords, groundHash = GetGroundOnViewingDistance()

        -- if hit and GetEntityCoords(tempEntity).xy ~= groundCoords.xy then
        --     if GetEntityCoords(tempEntity).xy ~= vec.xy then
        --         SetEntityCoords(tempEntity, vec, 0, 0, 0, false)
        --         PlaceObjectOnGroundProperly(tempEntity)
        --     end
        -- end

        if hit == 1 then
            print(groundHash)
            if GetEntityCoords(tempEntity).xy ~= groundCoords.xy then
                SetEntityCoords(tempEntity, groundCoords, 0, 0, 0, false)
                PlaceObjectOnGroundProperly(tempEntity)
            end
        else
            local coords = GetGameplayCamCoord()
            local forward_vector = RotAnglesToVec(GetGameplayCamRot(2))
            local vec = coords + (forward_vector * 10.0)

            if GetEntityCoords(tempEntity).xy ~= vec.xy then
                SetEntityCoords(tempEntity, vec, 0, 0, 0, false)
                PlaceObjectOnGroundProperly(tempEntity)
            end
        end

        DisableControlAction(0, 14, true) -- SCROLL DOWN
        DisableControlAction(0, 15, true) -- SCROLL UP
        DisableControlAction(0, 16, true) -- SCROLL DOWN
        DisableControlAction(0, 17, true) -- SCROLL UP
        DisableControlAction(0, 24, true) -- LMB
        DisableControlAction(0, 25, true) -- RMB

        if IsControlJustPressed(2, 0x62800C92) then -- SCROLL UP
            SetEntityHeading(tempEntity, GetEntityHeading(tempEntity) + 10)
            PlaceObjectOnGroundProperly(tempEntity)
        end

        if IsControlJustPressed(2, 0x8BDE7443) then -- SCROLL DOWN
            SetEntityHeading(tempEntity, GetEntityHeading(tempEntity) - 10)
            PlaceObjectOnGroundProperly(tempEntity)
        end

        if Citizen.InvokeNative(0x50F940259D3841E6, 1, 0x07CE1E61) then -- LMB
            x, y, z = table.unpack(GetEntityCoords(tempEntity))
            local h = GetEntityHeading(tempEntity)

            DeleteEntity(tempEntity)
            tempEntity = nil

            x = tonumber(string.format("%.2f", x))
            y = tonumber(string.format("%.2f", y))
            z = tonumber(string.format("%.2f", z))
            h = tonumber(string.format("%.2f", h))
            TriggerServerEvent("VP:PLANTATION:EndPlayerPlacement", tempType, x, y, z, h)

            tempType = nil
        end

        if Citizen.InvokeNative(0x50F940259D3841E6, 1, 0xF84FA74F) then -- RMB
            DeleteEntity(tempEntity)
            tempEntity = nil
            tempType = nil
            TriggerServerEvent("VP:PLANTATION:EndPlayerPlacement", nil, nil, nil, nil, nil)
        end
    end
end

local renderedPlants = {}
local cachedPlants = {}

function Plant(id, type, x, y, z, h)
    local plant = {id = id, type = type, x = x, y = y, z = z, h = h}

    if #(GetEntityCoords(PlayerPedId()) - vec3(x, y, z)) <= 10.0 then
        render(plant)
    else
        cache(plant)
    end
end

function isRendering(self)
    return self.entity ~= nil
end

function render(self)
    local entity = CreateObject(getModelFromCapacity(self.type), self.x, self.y, self.z, false, true, false)
    SetEntityHeading(entity, self.h)
    PlaceObjectOnGroundProperly(entity)
    self.entity = entity
    renderedPlants[self.id] = self
    cachedPlants[self.id] = nil
end

function cache(self)
    if self.entity ~= nil then
        DeleteEntity(self.entity)
    end

    self.entity = nil
    renderedPlants[self.id] = nil
    cachedPlants[self.id] = self
end

function getModelFromCapacity(type)
    if type == 25 then
        return "CRP_CORNSTALKS_CB_SIM"
    end

    if type == 50 then
        return "CRP_SUGARCANE_AA_SIM"
    end

    if type == 100 then
        return "CRP_TOBACCOPLANT_AA_SIM"
    end

    return "CRP_CORNSTALKS_CB_SIM"
end

local distanceToClosestPlant = -1
local closestPlantId
local closestPlant

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            Citizen.CreateThread(
                function()
                    for plantId, plant in pairs(cachedPlants) do
                        local x = plant.x
                        local y = plant.y
                        local z = plant.z
                        local dist = #(pCoords - vec3(x, y, z))

                        if dist <= 50 then
                            render(plant)
                        end
                    end
                end
            )

            Citizen.CreateThread(
                function()
                    for plantId, plant in pairs(renderedPlants) do
                        local x = plant.x
                        local y = plant.y
                        local z = plant.z
                        local dist = #(pCoords - vec3(x, y, z))

                        if dist >= 50 then
                            cache(plant)

                            if closestPlantId ~= nil and closestPlantId == plantId then
                                closestPlantId = nil
                                closestPlant = nil
                            end
                        else
                            if ((distanceToClosestPlant == -1 and dist <= 1.5) or dist < distanceToClosestPlant) and closestPlantId ~= plantId then
                                closestPlantId = plantId
                                closestPlant = plant
                            end
                        end
                    end
                end
            )
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3)

            if closestPlantId ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                local x = closestPlant.x
                local y = closestPlant.y
                local z = closestPlant.z
                local dist = #(pCoords - vec3(x, y, z))

                if dist > 1.5 then
                    closestPlantId = nil
                else
                    if IsControlJustPressed(2, 0xCEFD9220) then -- E
                        TriggerServerEvent("VP:PLANTATION:Open", closestPlantId)
                    end
                end
            end

            drawTempEntity()
        end
    end
)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str, _x, _y)
    local factor = (string.len(text)) / 150
    DrawSprite("menu_textures", "translate_bg_1a", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 5, 5, 5, 190, 0)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end

        for _, plant in pairs(renderedPlants) do
            DeleteEntity(plant.entity)
        end
    end
)

Citizen.CreateThreadNow(
    function()
        TriggerServerEvent("VP:PLANTATION:AskForSync")
    end
)
