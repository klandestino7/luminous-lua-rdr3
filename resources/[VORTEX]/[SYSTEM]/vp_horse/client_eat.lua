local eating = false

function HandleEat()
    if mount == playerHorse then
        TaskDismountAnimal(PlayerPedId(), 1, 0, 0, 0, 0)
        Citizen.CreateThread(
            function()
                while GetScriptTaskStatus(PlayerPedId(), 0x1DE2A7BD, 0) == 1 do
                    Wait(100)
                end
                ActionEat()
            end
        )
    else
        local horsePosition = GetEntityCoords(playerHorse)

        if #(GetEntityCoords(PlayerPedId()) - horsePosition) <= 5.0 then
            ActionEat()

            local horserRider = Citizen.InvokeNative(0xB676EFDA03DADA52, playerHorse, 0, Citizen.ResultAsInteger())
            if horserRider ~= 0 then
                TaskDismountAnimal(horserRider, 1, 0, 0, 0, 0)
                Citizen.CreateThread(
                    function()
                        while GetScriptTaskStatus(horserRider, 0x1DE2A7BD, 0) == 1 do
                            Wait(100)
                        end
                        ActionEat()
                    end
                )
            else
                ActionEat()
            end
        end
    end
end

function ActionEat()
    if CanHorseEat() then
        -- TaskStartScenarioInPlace(playerHorse, GetHashKey("WORLD_ANIMAL_HORSE_GRAZING_CAMP"), 10000, true, false, false, false)

        -- /spawnprop s_horsnack_carrot01x

        -- OPENSEQUENCETASK ??????? do it in js

        -- local horseRider = Citizen.InvokeNative(0xB676EFDA03DADA52, playerHorse, 0, Citizen.ResultAsInteger())

        -- TaskAnimalInteraction(horseRider, playerHorse, GetHashKey("INTERACTION_PICKUPPLANT"), GetHashKey("s_horsnack_carrot01x"), 0)

        -- eating = true

        -- Citizen.CreateThread(
        --     function()
        --         Wait(3500)
        --         TaskAnimalInteraction(horseRider, playerHorse, GetHashKey("INTERACTION_FOOD"), GetHashKey("s_horsnack_carrot01x"), 1)

        --         Wait(2000)
        --         eating = false

        --         local v = NativeGetHorseStaminaCore()
        --         NativeSetHorseStaminaCore(v + 70)
        --     end
        -- )

        TaskStartScenarioInPlace(playerHorse, GetHashKey("WORLD_ANIMAL_DONKEY_GRAZING"), 20000, true, false, false, false)

        Citizen.CreateThread(
            function()
                while true do
                    Wait(250)

                    local v = NativeGetHorseStaminaCore()
                    NativeSetHorseStaminaCore(v + 1)

                    if GetScriptTaskStatus(playerHorse, 0x3B3A458F, 0) ~= 1 then
                        cAPI.Toast("alert", "Cavalo parou de comer porque a animação acabou")
                        break
                    end

                    if v == 100 then
                        cAPI.Toast("alert", "Cavalo parou de comer porque o core está cheio")
                        ClearPedTasks(playerHorse)
                        break
                    end
                end
            end
        )
    end
end

function CanHorseEat()
    return HasVegetationNearHorseHead() and NativeGetHorseStaminaCore() < 100 and eating == false
end

function HasVegetationNearHorseHead()
    local min, max = GetModelDimensions(GetEntityModel(playerHorse))

    local horseCoords = GetEntityCoords(playerHorse)

    local z = min.z

    local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))

    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)

    local groundCoords = vec3(bonePosition.xy, A.z)

    local shapeTestRay = StartShapeTestRay(bonePosition, groundCoords, 256, playerHorse, 0)

    local retVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTestRay)

    if hit == 0 then
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
