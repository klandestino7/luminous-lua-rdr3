RegisterNetEvent('VP:CHESTS:StartPlayerPlacement')
RegisterNetEvent('VP:CHESTS:SyncChest')
RegisterNetEvent('VP:CHESTS:SyncMultipleChests')

AddEventHandler(
    'VP:CHESTS:StartPlayerPlacement',
    function(source, capacity)
        print('VP:CHESTS:StartPlayerPlacement')
        createTempEntity(capacity)
    end
)

AddEventHandler(
    'VP:CHESTS:SyncChest',
    function(chestId, capacity, x, y, z, h)
        print(chestId, capacity, x, y, z, h)
        Chest(chestId, capacity, x, y, z, h)
    end
)

AddEventHandler(
    'VP:CHESTS:SyncMultipleChests',
    function(array)
        for chestId, values in pairs(array) do
            Chest(chestId, values[1], values[2], values[3], values[4], values[5])
        end
    end
)

local tempEntity
local tempCapacity

function createTempEntity(capacity)
    if tempEntity ~= nil then
        DeleteEntity(tempEntity)
    end

    local forwardVector = GetEntityForwardVector(ped)
    local vec = GetEntityCoords(ped) + forwardVector * 3.0
    tempEntity = CreateObject(getModelFromCapacity(capacity), vec, false, true, false)
    tempCapacity = capacity
    SetEntityAlpha(tempEntity, 110, false)
    print('createTempEntity')
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
    --DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
    local rayhandle = CastRayPointToPoint(coords, coords + (forward_vector * 10.0), -1, -1, 0)
    local retVal, hit, endCoords, surfaceNormal, entityHit = GetRaycastResult(rayhandle)

    return hit, endCoords
end

function drawTempEntity()
    if tempEntity ~= nil then
        local ped = PlayerPedId()

        -- local hit, groundCoords = GetGroundOnViewingDistance()

        -- print(hit, groundCoords)
        -- if hit and GetEntityCoords(tempEntity).xy ~= groundCoords.xy then
        local forwardVector = GetEntityForwardVector(ped)
        local vec = (GetEntityCoords(ped) + forwardVector * 3.0)

        if GetEntityCoords(tempEntity).xy ~= vec.xy then
            SetEntityCoords(tempEntity, vec, 0, 0, 0, false)
            PlaceObjectOnGroundProperly(tempEntity)
        end

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

            x = tonumber(string.format('%.2f', x))
            y = tonumber(string.format('%.2f', y))
            z = tonumber(string.format('%.2f', z))
            h = tonumber(string.format('%.2f', h))

            TriggerServerEvent('VP:CHESTS:EndPlayerPlacement1', tempCapacity, x, y, z, h)

            tempCapacity = nil
        end

        if Citizen.InvokeNative(0x50F940259D3841E6, 1, 0xF84FA74F) then -- RMB

            DeleteEntity(tempEntity)
            tempEntity = nil
            tempCapacity = nil
            TriggerServerEvent('VP:CHESTS:EndPlayerPlacement1', nil, nil, nil, nil, nil)
        end
    end
end

local renderedChests = {}
local cachedChests = {}

function Chest(id, capacity, x, y, z, h)
    local chest = {id = id, capacity = capacity, x = x, y = y, z = z, h = h}

    if #(GetEntityCoords(PlayerPedId()) - vec3(x, y, z)) <= 10.0 then
        render(chest)
    else
        cache(chest)
    end
end

function isRendering(self)
    return self.entity ~= nil
end

function render(self)
    local entity = CreateObject(getModelFromCapacity(self.capacity), self.x, self.y, self.z, false, true, false)
    SetEntityHeading(entity, self.h)
    PlaceObjectOnGroundProperly(entity)
    self.entity = entity
    renderedChests[self.id] = self
    cachedChests[self.id] = nil
end

function cache(self)
    if self.entity ~= nil then
        DeleteEntity(self.entity)
    end

    self.entity = nil
    renderedChests[self.id] = nil
    cachedChests[self.id] = self
end

function getModelFromCapacity(capacity)
    if capacity == 25 then
        return 'P_TRUNK02X'
    end

    if capacity == 50 then
        return 'P_TRUNK04X'
    end

    if capacity == 100 then
        return 'P_TRUNKVAR01X'
    end

    return 'P_TRUNK02X'
end

local distanceToClosestChest = -1
local closestChestId
local closestChest

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            Citizen.CreateThread(
                function()
                    for chestId, chest in pairs(cachedChests) do
                        local x = chest.x
                        local y = chest.y
                        local z = chest.z
                        local dist = #(pCoords - vec3(x, y, z))

                        if dist <= 50 then
                            render(chest)
                        end
                    end
                end
            )

            Citizen.CreateThread(
                function()
                    for chestId, chest in pairs(renderedChests) do
                        local x = chest.x
                        local y = chest.y
                        local z = chest.z
                        local dist = #(pCoords - vec3(x, y, z))

                        if dist >= 50 then
                            cache(chest)

                            if closestChestId ~= nil and closestChestId == chestId then
                                closestChestId = nil
                                closestChest = nil
                            end
                        else
                            if ((distanceToClosestChest == -1 and dist <= 1.5) or dist < distanceToClosestChest) and closestChestId ~= chestId then
                                closestChestId = chestId
                                closestChest = chest
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

            if closestChestId ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                local x = closestChest.x
                local y = closestChest.y
                local z = closestChest.z
                local dist = #(pCoords - vec3(x, y, z))

                if dist > 1.5 then
                    closestChestId = nil
                else
                    if IsControlJustPressed(2, 0xCEFD9220) then -- E
                        TriggerServerEvent('VP:CHESTS:Open', closestChestId)
                    end
                end
            end

            drawTempEntity()
        end
    end
)

-- function DrawText3D(x, y, z, text)
--     local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
--     local px, py, pz = table.unpack(GetGameplayCamCoord())

--     SetTextScale(0.35, 0.35)
--     SetTextFontForCurrentCommand(1)
--     SetTextColor(255, 255, 255, 215)
--     local str = CreateVarString(10, 'LITERAL_STRING', text, Citizen.ResultAsLong())
--     SetTextCentre(1)
--     DisplayText(str, _x, _y)
--     local factor = (string.len(text)) / 150
--     DrawSprite('menu_textures', 'translate_bg_1a', _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 5, 5, 5, 190, 0)
-- end

AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end

        for _, chest in pairs(renderedChests) do
            DeleteEntity(chest.entity)
        end
    end
)

Citizen.CreateThreadNow(
    function()
        TriggerServerEvent('VP:CHESTS:AskForSync')
    end
)
