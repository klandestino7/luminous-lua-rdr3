-- Citizen.CreateThread(
--     function()
--         local l = {
--             1,
--             2,
--             3,
--             4,
--             5,
--             {
--                 6,
--                 7,
--                 8
--             },
--             9,
--             10
--         }

--         local s = json.encode(l)
--         print(s)

--         local e = json.decode(s)
--         for k, v in pairs(e) do
--             print(v)
--         end
--     end
-- )

RegisterNetEvent("FCRP:GARAGES:TryToEnterGarage")
AddEventHandler(
    "FCRP:GARAGES:TryToEnterGarage",
    function(garageId)
        local _source = source
        -- Might want to add a Player Position Check, to prevent exploits

        -- local rows = ... -- Query to get every User vehicle that is on `garageId`

        local rows = {
            {
                model = "zentorno",
                mods = {}
            },
            {
                model = "t20",
                mods = {}
            },
            {
                model = "police",
                mods = {}
            }
        }

        TriggerClientEvent("FCRP:GARAGES:EnterGarage", _source, garageId, rows)
    end
)

RegisterNetEvent("FCRP:GARAGES:TryToEnterGarageWithVehicle")
AddEventHandler(
    "FCRP:GARAGES:TryToEnterGarageWithVehicle",
    function(garageId, vehicle_plate)
        local _source = source
        -- Might want to add a Player Position Check, to prevent exploits

        -- local rows = ... -- Query to get every User has vehicle with plate `vehicle_plate` and has space in the garage

        local rows = {
            {
                model = "zentorno",
                mods = {}
            },
            {
                model = "t20",
                mods = {}
            },
            {
                model = "police",
                mods = {}
            },
            {
                model = tryingToEnterVehicleModel,
                mods = {}
            }
        }

        TriggerClientEvent("FCRP:GARAGES:EnterGarage", _source, garageId, rows, tryingToEnterVehicle_model)
    end
)

RegisterNetEvent("FCRP:GARAGES:TryToLeaveGarage")
AddEventHandler(
    "FCRP:GARAGES:TryToLeaveGarage",
    function(garageId)
        local _source = source

        TriggerClientEvent("FCRP:GARAGES:LeaveGarage", _source, false, nil)
    end
)

RegisterNetEvent("FCRP:GARAGES:TryToLeaveGarageWithVehicle")
AddEventHandler(
    "FCRP:GARAGES:TryToLeaveGarageWithVehicle",
    function(garageId, vehicleModel, vehiclePlate)
        local _source = source

        if vehicleModel ~= nil then
            -- local rows = ... -- Verify if player owns a vehicle with plate `vehiclePlate` and at `garageId` garage

            -- if #rows > 0 then
            TriggerClientEvent("FCRP:GARAGES:LeaveGarage", _source, true, vehicleModel)
            return
        -- end
        end

        TriggerClientEvent("FCRP:GARAGES:LeaveGarage", _source, false, vehicleModel)
    end
)