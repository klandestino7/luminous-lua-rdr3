local lastSelectedVehicleEntity

local hashListLoadedOnMemory = {}

local inTheShop = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3)

            local ped = PlayerPedId()
            local dist = #(vec3(-44.80, -1097.82, 26.42) - GetEntityCoords(ped))

            if dist <= 50.0 then
                DrawMarker(23, -44.80, -1097.82, 26.42 - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 200, 10, 10, 100, 0, 0, 0, 0, 0, 0, 0)
                if dist <= 1.5 then
                    if IsControlJustPressed(0, 38) then
                        -- inTheShop = true

                        -- SendNUIMessage(
                        --     {
                        --         type = "display"
                        --     }
                        -- )

                        -- SetNuiFocus(true, true)

                        -- RequestCollisionAtCoord(x, y, z)

                        -- SetEntityVisible(ped, false, 0)
                        SetEntityCoords(ped, 404.90, -949.58, -99.71, 0, 0, 0, false)

                        -- cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 404.60, -945.44, -97.50, 360.00, 0.00, 0.00, 60.00, false, 0)
                        -- PointCamAtCoord(cam, 404.90, -949.58, -99.71)
                        -- SetCamActive(cam, true)
                        -- RenderScriptCams(true, false, 1, true, true)
                        -- DisplayHud(false)
                        -- DisplayRadar(false)

                        -- updateSelectedVehicle("t20")

                        -- while inTheShop do
                        --     Citizen.Wait(0)
                        -- end

                        -- if lastSelectedVehicleEntity ~= nil then
                        --     DeleteEntity(lastSelectedVehicleEntity)
                        -- end

                        -- SetEntityVisible(ped, true, 0)
                        -- SetEntityCoords(ped, -44.80, -1097.82, 26.42, 0, 0, 0, false)
                    end
                end
            end
        end
    end
)

function updateSelectedVehicle(model)
    local hash = GetHashKey(model)

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end

    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end

    lastSelectedVehicleEntity = CreateVehicle(hash, 404.90, -949.58, -99.71, 10, 0, 1)
    SetEntityHeading(lastSelectedVehicleEntity, 60.117)
end

RegisterNUICallback(
    "Select",
    function(data, cb)
    end
)

RegisterNUICallback(
    "Buy",
    function(data, cb)
    end
)

RegisterNUICallback(
    "Close",
    function(data, cb)
        inTheShop = false

        if lastSelectedVehicleEntity ~= nil then
            DeleteEntity(lastSelectedVehicleEntity)
        end

        if #hashListLoadedOnMemory > 0 then
            for _, hash in pairs(hashListLoadedOnMemory) do
                SetModelAsNoLongerNeeded(hash)
            end
        end
    end
)

RegisterCommand(
    "h",
    function(a, b, c)
        print(GetEntityHeading(GetVehiclePedIsIn(PlayerPedId(), false)))
        DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
    end,
    false
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SendNUIMessage(
                {
                    type = "hide"
                }
            )
            SetNuiFocus(false, false)

            if inTheShop then
                if lastSelectedVehicleEntity ~= nil then
                    DeleteEntity(lastSelectedVehicleEntity)
                end

                local ped = PlayerPedId()
                SetEntityVisible(ped, false, 0)
                SetEntityCoords(ped, -44.80, -1097.82, 26.42, 0, 0, 0, false)
                DestroyAllCams(true)
            end
        end
    end
)
