Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(200)
            if playerHorse ~= 0 then
                local horseCoords = GetEntityCoords(playerHorse)
                -- print(NativeGetHorseStaminaCore(), IsPointOnRoad(horseCoords, 0))

                if not IsPointOnRoad(horseCoords, 0) then
                    local v = NativeGetHorseStaminaCore()

                    -- if IsPedWalking(playerHorse) then
                    --     NativeSetHorseStaminaCore(v - 1)
                    -- else
                    if IsPedSprinting(playerHorse) then
                        NativeSetHorseStaminaCore(v - 1)
                    end
                end
            end
        end
    end
)
