local nearestGarageId

local personalVehicles = {}
local staticVehicles = {}

local insideGarageId
local insideGarageType

-- 405.9228,-954.1149,-99.6627

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

function Initialize()
    local scaleform = "mp_car_stats_01"
    scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("T20")
    PushScaleformMovieFunctionParameterString("Tracked and Insured")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Acceleration")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Traction")
    PushScaleformMovieFunctionParameterInt(50)
    PushScaleformMovieFunctionParameterInt(50)
    PushScaleformMovieFunctionParameterInt(50)
    PushScaleformMovieFunctionParameterInt(50)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

Citizen.CreateThread(
    function()
        local scaleform = Initialize()
        while true do
            Citizen.Wait(3)

            local veh = GetVehiclePedIsUsing(PlayerPedId())
            local veh2 = GetPlayersLastVehicle()
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(veh2, true))
            local xrot, yrot, zrot = table.unpack(GetEntityRotation(veh2, 2))
            DrawScaleformMovie_3d(scaleform, x , y , z +4, xrot, 180.0, zrot, 0.0, 1.0, 0.0, 5.0, 4.0, 5.0, 0)

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

local function getVehicleMods(vehicle)
    local mods = {}
    for i = 0, 49 do
        table.insert(mods, GetVehicleMod(vehicle, i))
    end

    return mods
end

function getVehicleData(vehicle)
    local dataTable = {}

    local primaryColor, secondaryColor = GetVehicleColours(vehicle)
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    local nR, nG, nB = GetVehicleNeonLightsColour(vehicle)
    local tR, tG, tB = GetVehicleTyreSmokeColor(vehicle)
    local pR, pG, pB = GetVehicleCustomPrimaryColour(vehicle)
    local sR, sG, sB = GetVehicleCustomSecondaryColour(vehicle)

    local dataTable = {
        primaryColor,
        secondaryColor,
        pearlescentColor,
        wheelColor,
        nR,
        nG,
        nB,
        tR,
        tG,
        tB,
        pR,
        pG,
        pB,
        sR,
        sG,
        sB,
        -- GetVehicleNumberPlateText(vehicle), -- String
        GetVehicleNumberPlateTextIndex(vehicle), -- plateIndex
        IsToggleModOn(vehicle, 18), -- Turbo
        IsToggleModOn(vehicle, 20), -- Smoke
        IsToggleModOn(vehicle, 22), -- Beams
        GetVehicleWindowTint(vehicle), -- Window Tint
        IsVehicleNeonLightEnabled(veh, 0), -- Left
        IsVehicleNeonLightEnabled(veh, 1), -- Right
        IsVehicleNeonLightEnabled(veh, 2), -- Front
        IsVehicleNeonLightEnabled(veh, 3), -- Back
        GetVehicleWheelType(vehicle), -- wheelType
        GetVehicleModVariation(vehicle, 23) -- Tyres Variation
    }

    local mods = getVehicleMods(vehicle)

    for _, v in pairs(mods) do
        table.insert(dataTable, v)
    end

    local encoded = encode(dataTable)

    print(encoded)

    if firstEncoded == nil then
        firstEncoded = encoded
    end
end

function setVehicleData(vehicle, data)
    local decoded = decode(data)

    SetVehicleColours(vehicle, decoded[1], decoded[2])
    SetVehicleExtraColours(vehicle, decoded[3], decoded[4])
    SetVehicleNeonLightsColour(vehicle, decoded[5], decoded[6], decoded[7])
    SetVehicleTyreSmokeColor(vehicle, decoded[8], decoded[9], decoded[10])
    SetVehicleCustomPrimaryColour(vehicle, decoded[11], decoded[12], decoded[13])
    SetVehicleCustomSecondaryColour(vehicle, decoded[14], decoded[15], decoded[16])
    SetVehicleNumberPlateTextIndex(vehicle, decoded[17])
    ToggleVehicleMod(vehicle, 18, decoded[18])
    ToggleVehicleMod(vehicle, 20, decoded[19])
    ToggleVehicleMod(vehicle, 22, decoded[20])
    SetVehicleWindowTint(vehicle, decoded[21])
    SetVehicleNeonLightEnabled(vehicle, 0, decoded[22])
    SetVehicleNeonLightEnabled(vehicle, 1, decoded[23])
    SetVehicleNeonLightEnabled(vehicle, 2, decoded[24])
    SetVehicleNeonLightEnabled(vehicle, 3, decoded[25])
    SetVehicleWheelType(vehicle, decoded[26])
    -- decoded[27] GetVehicleModVariation

    for i = 28, #decoded do
        SetVehicleMod(vehicle, i - 28, decoded[i], decoded[27])
    end
end

function encode(t)
    local _t = {}

    local lastValue = nil
    local timesLastValue = 0

    for _, value in pairs(t) do
        if type(value) == "boolean" then
            value = value == true and "1" or "0"
        end

        if value == lastValue then
            timesLastValue = timesLastValue + 1

            if _ == #t then
                if timesLastValue > 1 then
                    table.insert(_t, lastValue .. "x" .. timesLastValue)
                else
                    table.insert(_t, lastValue)
                end
            end
        else
            if lastValue ~= nil then
                if timesLastValue > 1 then
                    table.insert(_t, lastValue .. "x" .. timesLastValue)
                else
                    table.insert(_t, lastValue)
                end
            end

            lastValue = value
            timesLastValue = 1
        end
    end

    return json.encode(_t)
end

function decode(s)
    local t = json.decode(s)
    local _t = {}

    for _, v in pairs(t) do
        if string.find(v, "x") then
            local c = v:find("x")
            local d = tonumber(v:sub(0, c - 1))
            local x = tonumber(v:sub(c + 1))

            for i = 0, x - 1 do
                table.insert(_t, d)
            end
        else
            table.insert(_t, v)
        end
    end

    return _t
end

-- AddEventHandler(
--     "entityCreating",
--     function(a, b)
--         print(a, b)
--     end
-- )

-- RegisterCommand(
--     "dv",
--     function(source, args, rawCommand)
--         local v = getNearestVehicle(10)
--         -- DeleteEntity(v)
--         getVehicleData(v)
--     end,
--     false
-- )

-- RegisterCommand(
--     "load",
--     function(source, args, rawCommand)
--         if firstEncoded ~= nil then
--             local v = getNearestVehicle(10)
--             setVehicleData(v, firstEncoded)
--         end
--     end,
--     false
-- )
