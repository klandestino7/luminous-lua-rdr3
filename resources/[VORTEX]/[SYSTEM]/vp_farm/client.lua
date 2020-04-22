local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

-- local plants = {
-- "CRP_ARTICHOKE_AA_SIM",
-- "CRP_BROCCOLI_AA_SIM",
-- "CRP_CARROTS_AA_SIM",
-- "CRP_CORNSTALKS_AA_SIM",
-- "CRP_CORNSTALKS_AB_SIM",
-- "CRP_CORNSTALKS_AC_SIM",
-- "CRP_CORNSTALKS_BA_SIM",
-- "CRP_CORNSTALKS_BB_SIM",
-- "CRP_CORNSTALKS_BC_SIM",
-- "CRP_CORNSTALKS_BD_SIM",
-- "CRP_CORNSTALKS_CA_SIM",
-- "CRP_CORNSTALKS_CB_SIM",
-- "CRP_CORNSTALKS_CC_SIM",
-- "CRP_CORNSTALKS_CD",
-- "CRP_COTTON_AD_SIM",
-- "CRP_COTTON_BA_SIM",
-- "CRP_COTTON_BB_SIM",
-- "CRP_COTTON_BC_SIM",
-- "CRP_COTTON_BD_SIM",
-- "CRP_COTTON_BE_SIM",
-- "CRP_COTTON_PLANT_AF_P",
-- "CRP_SUGARCANE_AA_SIM",
-- "CRP_SUGARCANE_AB_SIM",
-- "CRP_SUGARCANE_AC_SIM",
-- "CRP_SUGARCANE_AD_SIM",
-- "CRP_SUGARCANE_AE_P",
-- "CRP_SUGARCANE_AF_P",
-- "CRP_TOBACCOPLANT_AA_SIM",
-- "CRP_TOBACCOPLANT_AB_SIM",
-- "CRP_TOBACCOPLANT_AC_SIM"
-- "CRP_TOBACCOPLANT_BA_SIM",
-- "CRP_TOBACCOPLANT_BB_SIM",
-- "CRP_TOBACCOPLANT_BC_SIM",
-- "CRP_WHEAT_STK_AB_SIM"
-- }

local farmsRows = {
    ["tobacco:1"] = {
        numSpots = 50,
        type = "tobacco",
        {
            vec3(1193.196, -1866.593, 51.696),
            vec3(1193.505, -1931.186, 50.453)
        },
        {
            vec3(1190.7213134766, -1931.3920898438, 50.299518585205),
            vec3(1191.1247558594, -1866.9914550781, 51.370296478271)
        }
    }
}

local spotsData = {
    ["farm01"] = {
        1,
        2,
        3
    }
}

local registeredFarmAreas = {}
local spotsToDraw = {}
local drawnObjects = {}

local tempPlacementObject
local tempPlacementSeedType

AddEventHandler(
    "VP:AREA:PlayerEnteredArea",
    function(areaId)
        if areaId == "tobacco:1" then
            if spotsData == nil then
                TriggerServerEvent("VP:FARM:AskForFarmsInfo")
            end
        end
    end
)

AddEventHandler(
    "VP:AREA:PlayerLeftArea",
    function(areaId)
        if areaId == "tobacco:1" then
            if spotsData ~= nil then
                spotsData = nil
            end
        end
    end
)

RegisterNetEvent("VP:FARM:SetFarmsInfo")
AddEventHandler(
    "VP:FARM:SetFarmsInfo",
    function(info)
        spotsData = info
    end
)

RegisterNetEvent("VP:FARM:SetSpot")
AddEventHandler(
    "VP:FARM:SetSpot",
    function(farmAreaId, spotId, age, timesWatered)
        if drawnObjects[farmAreaId] then
            if drawnObjects[farmAreaId][spotId] then
                DeleteEntity(drawnObjects[farmAreaId][spotId])
                drawnObjects[farmAreaId][spotId] = nil
            end
        end

        if age ~= 0 then
            spotsData[farmAreaId][spotId] = {age, timesWatered}

            if drawnObjects[farmAreaId] then
                local type = getFarmAreaType(farmAreaId)
                local object = CreateObject(getModelFromTypeAndAge(type, age), spotsToDraw[farmAreaId][spotId], false, true, false)

                drawnObjects[farmAreaId][spotId] = object
            end
        else
            spotsData[farmAreaId][spotId] = nil
        end
    end
)

RegisterNetEvent("VP:FARM:StartPlacingSeed")
AddEventHandler(
    "VP:FARM:StartPlacingSeed",
    function(seedType)

        -- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), 3000, true, false, false, false)

        if tempPlacementObject ~= nil then
            DeleteEntity(tempPlacementObject)
        end

        tempPlacementSeedType = seedType
        tempPlacementObject = CreateObject(getModelFromTypeAndAge(seedType, 1), GetEntityCoords(PlayerPedId()), false, true, false)
    end
)

Citizen.CreateThread(
    function()
        registerFarmAreas()

        while true do
            Citizen.Wait(1000)

                local ped = PlayerPedId()
                local pedVector = GetEntityCoords(ped)

                for areaId, area in pairs(registeredFarmAreas) do
                    local distToCenter = #(pedVector - area.center)
                    if distToCenter <= 100 and spotsData ~= nil and spotsData[areaId] then
                        if spotsToDraw[areaId] == nil then
                            local numSpots = farmsRows[areaId].numSpots
                            local type = getFarmAreaType(areaId)

                            local dObjects = drawnObjects[areaId] or {}
                            local newSpots = {}

                            local atSpotId = 1
                            for _, v in pairs(farmsRows[areaId]) do
                                if tonumber(_) ~= nil then
                                    local a = v[1]
                                    local b = v[2]

                                    local d = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)) / numSpots
                                    local fi = math.atan2(b.y - a.y, b.x - a.x)

                                    for i = 0, numSpots do
                                        local x = a.x + i * d * math.cos(fi)
                                        local y = a.y + i * d * math.sin(fi)
                                        local _, z, _ = GetGroundZAndNormalFor_3dCoord(x, y, a.z)

                                        local vec = vec3(x, y, z)

                                        if spotsData[areaId][atSpotId] ~= nil then
                                            local age = spotsData[areaId][atSpotId][1]
                                            local object = CreateObject(getModelFromTypeAndAge(type, age), vec, false, true, false)
                                            dObjects[atSpotId] = object
                                        end

                                        newSpots[atSpotId] = vec
                                        atSpotId = atSpotId + 1
                                    end
                                end
                            end

                            spotsToDraw[areaId] = newSpots
                            drawnObjects[areaId] = dObjects
                        end
                    else
                        if spotsToDraw[areaId] then
                            spotsToDraw[areaId] = nil
                        end
                    end
                end

                for areaId, objects in pairs(drawnObjects) do
                    if not spotsToDraw[areaId] then
                        for _, object in pairs(objects) do
                            DeleteEntity(object)
                        end
                        drawnObjects[areaId] = nil
                    end
                end
        end
    end
)

Citizen.CreateThread(
    function()
        local aimMaxDistance = 5
        local upVector = vec3(0, 0, 1.5)

        local aimingAtSpotId
        local insideFarmAreaId

        while true do
            Citizen.Wait(0)

            if spotsData ~= nil then
                local ped = PlayerPedId()

                local pedVector = GetEntityCoords(ped)

                local cameraRotation = GetGameplayCamRot()
                local cameraCoord = GetGameplayCamCoord()
                local direction = RotationToDirection(cameraRotation)
                local aimingAtVector = vec3(cameraCoord.x + direction.x * aimMaxDistance, cameraCoord.y + direction.y * aimMaxDistance, cameraCoord.z + direction.z * aimMaxDistance)

                local rayHandle = StartShapeTestRay(pedVector, aimingAtVector, 1, ped, 0)
                local _, hit, endCoords, _, _ = GetShapeTestResult(rayHandle)

                if hit == 1 then
                    aimingAtVector = endCoords
                end

                local placeFakeEntityAt = aimingAtVector

                insideFarmAreaId = nil
                aimingAtSpotId = nil

                for areaId, spots in pairs(spotsToDraw) do
                    for spotId, spotVector in pairs(spots) do
                        local dist = #(aimingAtVector - spotVector)
                        if dist <= 5.0 then
                            insideFarmAreaId = areaId
                            if drawnObjects[areaId] == nil or drawnObjects[areaId][spotId] == nil then
                                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, spotVector, spotVector + upVector, 75, 213, 147, 255)
                                if dist <= 0.5 then
                                    placeFakeEntityAt = spotVector
                                    aimingAtSpotId = spotId
                                end
                            else
                                if drawnObjects[areaId][spotId] ~= nil then
                                    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, spotVector, spotVector + upVector, 227, 60, 4, 255)
                                end
                            end
                        end
                    end
                end

                if tempPlacementObject ~= nil then
                    SetEntityCoords(tempPlacementObject, placeFakeEntityAt, 0, 0, 0, 0)
                end

            -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pedVector, placeFakeEntityAt, 75, 213, 147, 255)
            end

            if tempPlacementObject ~= nil then
                if IsControlJustPressed(1, 0x07CE1E61) then -- LMB
                    if insideFarmAreaId ~= nil and aimingAtSpotId ~= nil then
                        TriggerServerEvent("VP:FARM:TryToPlantSeed", tempPlacementSeedType, insideFarmAreaId, aimingAtSpotId)
                        DeleteEntity(tempPlacementObject)
                        tempPlacementObject = nil
                    end
                else
                    if IsControlJustPressed(1, 0xF84FA74F) then -- RMB
                        DeleteEntity(tempPlacementObject)
                        tempPlacementObject = nil
                    end
                end
            end
        end
    end
)

function registerFarmAreas()
    local area =
        cAPI.RegisterArea(
        "tobacco:1",
        {
            fade = 400, -- The alpha value goes from the specified value to zero, where zero is reached when you are this many meters from the center point
            height = 2.0,
            color = {255, 0, 0, 60},
            border = {255, 255, 255, 0},
            fade = 0,
            wallFade = 0,
            threshold = 3.25,
            numbered = false,
            label = nil,
            vec3(1213.1748046875, -1933.7641601563, 50.883361816406),
            vec3(1180.1209716797, -1933.4191894531, 46.45288848877),
            vec3(1178.4110107422, -1868.1365966797, 49.457942962646),
            vec3(1213.6978759766, -1864.6276855469, 52.218460083008)
        }
    )

    registeredFarmAreas["tobacco:1"] = area

    Citizen.CreateThread(
        function()
            while true do
                Citizen.Wait(0)
                area.draw()
            end
        end
    )
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function getModelFromTypeAndAge(type, age)
    if type == "tobacco" then
        if age == 1 then
            return "CRP_TOBACCOPLANT_AA_SIM"
        end
        if age == 2 then
            return "CRP_TOBACCOPLANT_AB_SIM"
        end
        if age == 3 then
            return "CRP_TOBACCOPLANT_AC_SIM"
        end
    end
end

function getFarmAreaType(farmAreaId)
    local farmtype = farmAreaId:sub(0, farmAreaId:find(":") - 1)
    return farmtype
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, objects in pairs(drawnObjects) do
                for _, object in pairs(objects) do
                    DeleteEntity(object)
                end
            end
            DeleteEntity(tempPlacementObject)
        end
    end
)
