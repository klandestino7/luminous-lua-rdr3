function HandleDrink()
    if mount == playerHorse then
        TaskDismountAnimal(PlayerPedId(), 1, 0, 0, 0, 0)
        Citizen.CreateThread(
            function()
                while GetScriptTaskStatus(PlayerPedId(), 0x1DE2A7BD, 0) == 1 do
                    Wait(100)
                end
                ActionDrink()
            end
        )
    else
        local horsePosition = GetEntityCoords(playerHorse)

        if #(GetEntityCoords(PlayerPedId()) - horsePosition) <= 5.0 then
            ActionDrink()

            local horserRider = Citizen.InvokeNative(0xB676EFDA03DADA52, playerHorse, 0, Citizen.ResultAsInteger())
            if horserRider ~= 0 then
                TaskDismountAnimal(horserRider, 1, 0, 0, 0, 0)
                Citizen.CreateThread(
                    function()
                        while GetScriptTaskStatus(horserRider, 0x1DE2A7BD, 0) == 1 do
                            Wait(100)
                        end
                        ActionDrink()
                    end
                )
            else
                ActionDrink()
            end
        end
    end
end

function ActionDrink()
    if CanHorseDrink() then
        -- WORLD_ANIMAL_HORSE_DRINK_GROUND_DOMESTIC

        TaskStartScenarioInPlace(playerHorse, GetHashKey("WORLD_ANIMAL_DONKEY_DRINK_GROUND"), 20000, true, false, false, false)

        Citizen.CreateThread(
            function()
                while true do
                    Wait(250)

                    local v = NativeGetHorseStaminaCore()
                    NativeSetHorseStaminaCore(v + 1)

                    if GetScriptTaskStatus(playerHorse, 0x3B3A458F, 0) ~= 1 then
                        cAPI.Toast("alert", "Cavalo parou de beber porque a animação acabou")
                        break
                    end

                    if v == 100 then
                        cAPI.Toast("alert", "Cavalo parou de beber porque o core está cheio")
                        ClearPedTasks(playerHorse)
                        break
                    end
                end
            end
        )
    end
end

function CanHorseDrink()
    return HasWaterNearHorseHead() and NativeGetHorseStaminaCore() < 100
end

function HasWaterNearHorseHead()
    local min, max = GetModelDimensions(GetEntityModel(playerHorse))

    local horseCoords = GetEntityCoords(playerHorse)

    local z = min.z

    local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))

    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)

    local groundCoords = vec3(bonePosition.xy, A.z)

    local waterPosition = vec3(table.unpack(exports["vp_horse"]:js_native(bonePosition.x, bonePosition.y, bonePosition.z, groundCoords.x, groundCoords.y, groundCoords.z)))

    if waterPosition.x == 127 and waterPosition.y == 0 and waterPosition.z == 0 then
        return false
    end

    -- local w = bonePosition - waterPosition

    -- print(w)

    -- if math.abs(w.z) < 1.5 then
    if IsPedSwimming(playerHorse) then
        cAPI.Toast("error", "Fundo demais")
        return false
    end

    return true
end

-- WORLD_ANIMAL_HORSE_DRINK_GROUND
-- WORLD_ANIMAL_HORSE_DRINK_GROUND_DOMESTIC
-- WORLD_ANIMAL_HORSE_GRAZING
-- WORLD_ANIMAL_HORSE_GRAZING_CAMP
-- WORLD_ANIMAL_HORSE_GRAZING_DOMESTIC
-- WORLD_ANIMAL_HORSE_INJURED_ON_GROUND
-- WORLD_ANIMAL_HORSE_INJURED_ON_GROUND_RIGHT
-- WORLD_ANIMAL_HORSE_RESTING_DOMESTIC
-- WORLD_ANIMAL_HORSE_SLEEPING
-- WORLD_ANIMAL_HORSE_SLEEPING_DOMESTIC
-- WORLD_ANIMAL_HORSE_WALLOW
