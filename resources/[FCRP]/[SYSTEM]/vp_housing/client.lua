local doorStates = {}
-- [doorId] = {doorState, doorHash, doorVector, doorPair}

local closestDoorId

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            closestDoorId = nil

            local ped = PlayerPedId()
            local pedVector = GetEntityCoords(ped)

            for doorId, values in pairs() do
                -- local doorState = values[1]
                local doorHash = values[2]
                local doorVector = values[3]

                local dist = #(pedVector - doorVector)
                if #(pedVector - doorVector) <= 50 then
                    if closestDoorId ~= nil and doorStates[closestDoorId][4] ~= doorId and dist < #(pedVector - doorStates[closestDoorId][3]) then
                        closestDoorId = doorId
                    else
                        closestDoorId = doorId
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3)

            if closestDoorId ~= nil then
                local ped = PlayerPedId()
                local pedVector = GetEntityCoords(ped)

                local values = doorStates[closestDoorId]
                local doorState = values[1]
                local doorHash = values[2]
                local doorVector = values[3]

                local dist = #(pedVector - doorVector)

                if dist <= 1.5 then
                    if IsControlJustPressed(0, 0x4BC9DABB) then -- PushToTalk N ?
                        TriggerServerEvent("VP:HOUSING:TryToToggleDoorState", doorId)
                    end
                    -- if IsControlJustPressed(0, 0x4BC9DABB) then -- PushToTalk N ?
                    --     TriggerServerEvent("VP:HOUSING:TryToLockpickDoor", doorId)
                    -- end
                end
            end
        end
    end
)

RegisterNetEvent("VP:HOUSING:SetDoorState")
AddEventHandler(
    "VP:HOUSING:SetDoorState",
    function(doorId, doorState)
        doorStates[doorId][1] = doorState

        local doorHash = doorStates[doorId][2]

        Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
        DoorSystemSetDoorState(doorHash, doorState == true and 0 or 1)
    end
)
