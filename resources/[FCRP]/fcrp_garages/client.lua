local nearestGarageId

local personalVehicles = {}
local staticVehicles = {}

local insideGarageId
local insideGarageType

local tryingToLeaveWithVehicle = false
local tryingToEnterWithVehicle = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            if nearestGarageId ~= nil then
                if #(pCoords - table.unpack(GarageList[nearestGarageId].position)) > 2.5 then
                    nearestGarageId = nil
                end
            end

            for garageId, data in pairs(GarageList) do
                local x, y, z, _ = table.unpack(data.position)

                if #(pCoords - vec3(x, y, z)) <= 5.0 then
                    nearestGarageId = garageId
                end
            end
        end
    end
)

function Initialize(scaleform)
    local scaleform = "mp_car_stats_01"
    scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("RE-7B")
    PushScaleformMovieFunctionParameterString("Tracked and Insured")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Acceleration")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Traction")
    PushScaleformMovieFunctionParameterInt(68)
    PushScaleformMovieFunctionParameterInt(60)
    PushScaleformMovieFunctionParameterInt(40)
    PushScaleformMovieFunctionParameterInt(70)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

Citizen.CreateThread(
    function()
        local scaleform = Initialize()
        while true do
            Citizen.Wait(3)

            veh = GetVehiclePedIsUsing(PlayerPedId())
            veh2 = GetPlayersLastVehicle()
            ped = PlayerPedId()
            x, y, z = table.unpack(GetEntityCoords(veh2, true))
            xrot, yrot, zrot = table.unpack(GetEntityRotation(veh2, 1))
            DrawScaleformMovie_3d(scaleform, x, y, z + 5.0, xrot, 180.0, zrot, 0.0, 1.0, 0.0, 5.0, 4.0, 5.0, 0)

            if nearestGarageId ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)
                local eX, eY, eZ, eH = table.unpack(GarageList[nearestGarageId].position)

                if #(pCoords - vec3(eX, eY, eZ)) <= 15.0 then
                    DrawMarker(23, eX, eY, eZ - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 120, 142, 140, 255, 0, 0, 0, 0, 0, 0, 0)
                    if IsControlJustPressed(0, 38) then -- E
                        local vehiclePedIsin = GetVehiclePedIsIn(ped, false)

                        if vehiclePedIsin == 0 then
                            TriggerServerEvent("FCRP:GARAGES:TryToEnterGarage", nearestGarageId)
                            print("Trying to enter garage ", nearestGarageId)
                        else
                            local vehicleH = GetEntityHeading(vehiclePedIsin)
                            if math.abs(vehicleH - eH) <= 30 then
                                if tryingToEnterWithVehicle == false then
                                    tryingToEnterWithVehicle = true
                                    TriggerServerEvent("FCRP:GARAGES:TryToEnterGarageWithVehicle", nearestGarageId, "police")
                                    print("Trying to enter garage with vehicle", nearestGarageId, vehiclePedIsin)
                                end
                            end
                        end
                    end
                else
                    nearestGarageId = nil
                end
            end

            if insideGarageId ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)
                local eX, eY, eZ = table.unpack(GarageTypes[insideGarageType].enterPos)
                if #(pCoords - vec3(eX, eY, eZ)) <= 1.5 and IsControlJustPressed(0, 38) then
                    TriggerEvent("FCRP:GARAGES:LeaveGarage", false, nil)
                    print("Left garage without any vehicle")
                end

                local selectedVehicle = GetVehiclePedIsIn(ped, false)

                for staticVehicleModel, staticVehicle in pairs(staticVehicles) do
                    local vCoords = GetEntityCoords(staticVehicle)

                    if selectedVehicle == nil then
                        if #(pCoords - vCoords) <= 2 then
                        --
                        -- Display vehicle info
                        --
                        end
                    else
                        if selectedVehicle == staticVehicle then
                            if IsVehicleEngineStarting(selectedVehicle) and tryingToLeaveWithVehicle == false then
                                tryingToLeaveWithVehicle = true
                                TriggerServerEvent("FCRP:GARAGES:TryToLeaveGarageWithVehicle", insideGarageId, staticVehicleModel)
                                print("Trying to leave garage with a vehicle")
                            end
                        end
                    end
                end
            end
        end
    end
)

-- !! Try to store the peds vehicle on the server before triggering this function
RegisterNetEvent("FCRP:GARAGES:EnterGarage")
AddEventHandler(
    "FCRP:GARAGES:EnterGarage",
    function(garageId, ownedVehicles, enterWithVehicle_model)
        if insideGarageId ~= nil then
            return
        end

        local garageType = GarageList[garageId].type
        local garageSlots = getGarageTypeData_slots(GarageList[garageId].type)

        local eX, eY, eZ, eH = table.unpack(getGarageTypeData_enterPos(garageType))
        ClearAreaOfVehicles(eX, eY, eZ, 50, false, false, false, false, false)
        RequestCollisionAtCoord(eX, eY, eZ)

        for _, data in pairs(ownedVehicles) do
            if garageSlots[_] == nil then
                break
            end

            local ownedVehicleModel = data.model
            local ownedVehicleMods = data.mods or {}

            local x, y, z, h = table.unpack(garageSlots[_])
            spawnVehicle(ownedVehicleModel, x, y, z, h + 0.0001, true, ownedVehicleMods)
        end

        local ped = PlayerPedId()

        NetworkFadeInEntity(ped, 1)

        DoScreenFadeOut(1000)
        NetworkFadeOutEntity(ped, true, false)

        local vehiclePedIsin = GetVehiclePedIsIn(ped, false)
        if enterWithVehicle_model ~= nil then
            local x, y, z = table.unpack(GarageList[garageId].position)
            TaskVehicleDriveToCoord(ped, vehiclePedIsin, x, y, z, 30.0, 1.0, GetEntityModel(vehiclePedIsin), 1074528293, 1.0, true)
            BringVehicleToHalt(vehiclePedIsin, 3.0, 2000, 0)
            NetworkFadeOutEntity(vehiclePedIsin, true, false)
            personalVehicles[enterWithVehicle_model] = nil
        end

        Citizen.Wait(1000)

        SetEntityCoordsNoOffset(ped, eX, eY, eZ + 0.97, 0, 0, 0, false)
        SetEntityHeading(ped, h)

        if enterWithVehicle_model ~= nil then
            DeleteEntity(vehiclePedIsin)
        end

        DoScreenFadeIn(1000)
        NetworkFadeInEntity(ped, 0)

        nearestGarageId = nil
        insideGarageId = garageId
        insideGarageType = garageType
        tryingToEnterWithVehicle = false
        tryingToLeaveWithVehicle = false
    end
)
RegisterNetEvent("FCRP:GARAGES:LeaveGarage")
AddEventHandler(
    "FCRP:GARAGES:LeaveGarage",
    function(leaveWithVehicle, vehicleModel)
        DoScreenFadeOut(1000)

        Citizen.Wait(1000)

        local ped = PlayerPedId()
        local x, y, z, h = table.unpack(GarageList[insideGarageId].position)

        DoScreenFadeOut(1000)
        NetworkFadeOutEntity(ped, true, false)

        if leaveWithVehicle then
            local vehicle = staticVehicles[vehicleModel]
            NetworkFadeOutEntity(vehicle, true, false)
        end

        Citizen.Wait(1000)

        if leaveWithVehicle then
            local vehicle = staticVehicles[vehicleModel]
            staticVehicles[vehicleModel] = nil
            personalVehicles[vehicleModel] = vehicle

            SetEntityCoords(ped, x, y, z, 0, 0, 0, 0)
            SetEntityHeading(ped, h + 180)

            local forwardVector = GetEntityForwardVector(ped)
            local spawnPos = GetEntityCoords(ped) + (forwardVector * 3.5)
            local sX, sY, sZ = table.unpack(spawnPos)
            local _, groundsZ = GetGroundZFor_3dCoord(sX, sY, sZ, 0)
            spawnPos = vec3(spawnPos.xy, groundsZ ~= 0 and groundsZ or sZ)

            SetEntityCoords(vehicle, spawnPos, 0, 0, 0, 0)

            SetEntityHeading(vehicle, h + 180)
            SetVehicleOnGroundProperly(vehicle)

            FreezeEntityPosition(vehicle, false)
            SetEntityInvincible(vehicle, false)

            SetPedIntoVehicle(ped, vehicle, -1)

            NetworkFadeInEntity(vehicle, 1)
        else
            SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 0, false)
            SetEntityHeading(ped, h + 180)
        end

        DoScreenFadeIn(1000)
        NetworkFadeInEntity(ped, 1)

        insideGarageId = nil
        insideGarageType = nil
        tryingToEnterWithVehicle = false
        tryingToLeaveWithVehicle = false

        for _, vehicle in pairs(staticVehicles) do
            DeleteVehicle(vehicle)
        end

        staticVehicles = {}
    end
)

function spawnVehicle(model, x, y, z, h, isStatic, mods)
    if not isStatic then
        if personalVehicles[model] then
            print("Veículo desse modelo já se encontra fora da gargem")
            return
        end
    end

    local modelHash = GetHashKey(model)

    if not IsModelValid(modelHash) then
        print("Modelo de veículo " .. model .. " é invalido")
        return
    end

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end
    end

    local entity = CreateVehicle(modelHash, x, y, z, heading, not isStatic, false)
    SetEntityHeading(entity, h)
    -- if mods then
    --     setVehicleMods(entity, mods)
    -- end

    if isStatic then
        FreezeEntityPosition(entity, true)
        SetEntityInvincible(entity, true)
        SetVehicleDoorsLockedForPlayer(entity, PlayerId(), false)
        table.insert(staticVehicles, entity)
    else
        personalVehicles[model] = entity
    end

    return entity
end

function setVehicleMods(mods)
    for mod, value in pairs(mods) do
    end
end

function getGarageTypeData_enterPos(garageType)
    return GarageTypes[garageType].enterPos
end

function getGarageTypeData_exitPos(garageType)
    return getGarageTypeData_enterPos(garageType)
end

function getGarageTypeData_slots(garageType)
    return GarageTypes[garageType].slots
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
            return
        end

        for _, vehicle in pairs(staticVehicles) do
            DeleteVehicle(vehicle)
        end

        staticVehicles = {}
    end
)

-- Citizen.CreateThread(
--     function()
-- DoScreenFadeIn(0)
-- SetEntityCoords(PlayerPedId(), 332.671173, -132.98793, 66.273, 0, 0, 0, 0)
--     end
-- )

RegisterCommand(
    "dv",
    function(source, args, rawCommand)
        local v = getNearestVehicle(10)
        -- DeleteEntity(v)
        getVehicleData(v)
    end,
    false
)

function getAllVehicles()
    local vehs = {}
    local it, veh = FindFirstVehicle()
    if veh then
        table.insert(vehs, veh)
    end
    local ok
    repeat
        ok, veh = FindNextVehicle(it)
        if ok and veh then
            table.insert(vehs, veh)
        end
    until not ok
    EndFindVehicle(it)
    return vehs
end

function getNearestVehicles(radius)
    local r = {}
    local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
    for _, veh in pairs(getAllVehicles()) do
        local x, y, z = table.unpack(GetEntityCoords(veh))
        local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
        if distance <= radius then
            r[veh] = distance
        end
    end
    return r
end

function getNearestVehicle(radius)
    local veh
    local vehs = getNearestVehicles(radius)
    local min = radius + 0.0001
    for _veh, dist in pairs(vehs) do
        if dist < min then
            min = dist
            veh = _veh
        end
    end
    return veh
end

-- local function getVehicleMods(vehicle)
--     local mods = {}
--     for i = 0, 49 do
--         table.insert(mods, GetVehicleMod(vehicle, i))
--     end

--     return mods
-- end

-- function getVehicleData(vehicle)
--     local dataTable = {}

--     local primaryColor, secondaryColor = GetVehicleColours(vehicle)
--     local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
--     local nR, nG, nB = GetVehicleNeonLightsColour(vehicle)
--     local tR, tG, tB = GetVehicleTyreSmokeColor(vehicle)
--     local pR, pG, pB = GetVehicleCustomPrimaryColour(vehicle)
--     local sR, sG, sB = GetVehicleCustomSecondaryColour(vehicle)

-- local dataTable = {
--     primaryColor,
--     secondaryColor,
--     pearlescentColor,
--     wheelColor,
--     -- GetVehicleNumberPlateText(vehicle), -- String
--     GetVehicleNumberPlateTextIndex(vehicle), -- plateIndex
--     {
--         nR,
--         nG,
--         nB
--     },
--     {
--         tR,
--         tG,
--         tB
--     },
--     {
--         pR,
--         pG,
--         pB
--     },
--     {
--         sR,
--         sG,
--         sB
--     },
--     getVehicleMods(vehicle), -- Unpacked list of every vehicle mod
--     IsToggleModOn(vehicle, 18), -- Turbo
--     IsToggleModOn(vehicle, 20), -- Smoke
--     IsToggleModOn(vehicle, 22), -- Beams
--     GetVehicleWindowTint(vehicle), -- Window Tint
--     IsVehicleNeonLightEnabled(veh, 0), -- Left
--     IsVehicleNeonLightEnabled(veh, 1), -- Right
--     IsVehicleNeonLightEnabled(veh, 2), -- Front
--     IsVehicleNeonLightEnabled(veh, 3), -- Back
--     GetVehicleModVariation(vehicle, 23), -- Tyres Variation
--     GetVehicleTyresCanBurst(vehicle), -- isTyreBulletproof
--     GetVehicleWheelType(vehicle) -- wheelType
-- }

--     -- for k, v in pairs(dataTable) do
--     --     print(k, v)
--     -- end

--     local data = "["
--     for index, value in pairs(dataTable) do
--         local toAppend = value

--         if toAppend == false then
--             toAppend = 0
--         end

--         if toAppend == true then
--             toAppend = 1
--         end

--         if type(value) == "table" then
--             -- @ref 1 = (index + 1) + #value = 67
--             for _, v in pairs(value) do
--                 data = data .. v .. ","
--             end
--         else
--             data = data .. toAppend .. ","
--         end
--     end

--     local len = data:len()
--     if data:sub(len, len) == "," then
--         data = data:sub(1, len - 1)
--     end

--     data = data .. "]"

--     print(data)

--     setVehicleData(vehicle, data)
-- end

-- function setVehicleData(vehicle, data)
--     SetVehicleModKit(vehicle, 0)

--     local array = json.decode(data)

--     local i = 0
--     function n()
--         i = i + 1
--         return tonumber(array[i]) or array[i]
--     end

--     SetVehicleColours(vehicle, n(), n())
--     SetVehicleExtraColours(vehicle, n(), n())
--     SetVehicleNumberPlateTextIndex(vehicle, n())
--     SetVehicleNeonLightsColour(vehicle, n(), n(), n())
--     SetVehicleTyreSmokeColor(vehicle, n(), n(), n())
--     SetVehicleCustomPrimaryColour(vehicle, n(), n(), n())
--     SetVehicleCustomSecondaryColour(vehicle, n(), n(), n())
--     -- 67 = @ref 1
--     for index = i + 1, 67 do
--         local modIndex = (index - i) - 1
--         if modIndex ~= 18 and modIndex ~= 20 and modIndex ~= 22 and modIndex ~= 46 then
--             SetVehicleMod(vehicle, modIndex, array[index])
--         end
--     end
--     i = 68

--     ToggleVehicleMod(veh, 18, n()) -- Turbo
--     ToggleVehicleMod(veh, 20, n()) -- Smoke
--     ToggleVehicleMod(veh, 22, n()) -- Beams

--     SetVehicleWindowTint(vehicle, n())

--     SetVehicleNeonLightEnabled(vehicle, 0, n()) -- Left
--     SetVehicleNeonLightEnabled(vehicle, 1, n()) -- Right
--     SetVehicleNeonLightEnabled(vehicle, 2, n()) -- Front
--     SetVehicleNeonLightEnabled(vehicle, 34, n()) -- Back

--     local tyres = n()
--     local tyresVariation = n()

--     SetVehicleMod(veh, 23, tonumber(custom.tyres), n())
--     SetVehicleMod(veh, 24, tonumber(custom.tyres), n())
-- end

-- function unpack(t, i)
--     i = i or 1
--     if t[i] ~= nil then
--         return t[i], unpack(t, i + 1)
--     end
-- end
