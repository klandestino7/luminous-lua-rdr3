-- local crimesAsString = {
--     "CRIME_ARSON",
--     "CRIME_ASSAULT",
--     "CRIME_ASSAULT_ANIMAL",
--     "CRIME_ASSAULT_CORPSE",
--     "CRIME_ASSAULT_HORSE",
--     "CRIME_ASSAULT_LAW",
--     "CRIME_ASSAULT_LIVESTOCK",
--     "CRIME_BANK_ROBBERY",
--     "CRIME_BURGLARY",
--     "CRIME_CHEATING",
--     "CRIME_DISTURBANCE",
--     "CRIME_EXPLOSION",
--     "CRIME_GRAVE_ROBBERY",
--     "CRIME_HASSLE",
--     "CRIME_HIT_AND_RUN",
--     "CRIME_HIT_AND_RUN_LAW",
--     "CRIME_INTIMIDATION",
--     "CRIME_JACK_HORSE",
--     "CRIME_JACK_VEHICLE",
--     "CRIME_JAIL_BREAK",
--     "CRIME_KIDNAPPING",
--     "CRIME_KIDNAPPING_LAW",
--     "CRIME_LASSO_ASSAULT",
--     "CRIME_LAW_IS_THREATENED",
--     "CRIME_LOITERING",
--     "CRIME_LOOTING",
--     "CRIME_MURDER",
--     "CRIME_MURDER_ANIMAL",
--     "CRIME_MURDER_HORSE",
--     "CRIME_MURDER_LAW",
--     "CRIME_MURDER_LIVESTOCK",
--     "CRIME_NONE",
--     "CRIME_PROPERTY_DESTRUCTION",
--     "CRIME_RESIST_ARREST",
--     "CRIME_ROBBERY",
--     "CRIME_STAGECOACH_ROBBERY",
--     "CRIME_STOLEN_GOODS",
--     "CRIME_THEFT",
--     "CRIME_THEFT_HORSE",
--     "CRIME_THEFT_LIVESTOCK",
--     "CRIME_THEFT_VEHICLE",
--     "CRIME_THREATEN",
--     "CRIME_THREATEN_LAW",
--     "CRIME_TRAIN_ROBBERY",
--     "CRIME_TRAMPLE",
--     "CRIME_TRAMPLE_LAW",
--     "CRIME_TRESPASSING",
--     "CRIME_UNARMED_ASSAULT",
--     "CRIME_VANDALISM",
--     "CRIME_VANDALISM_VEHICLE",
--     "CRIME_VEHICLE_DESTRUCTION",
--     "CRIME_WANTED_LEVEL_UP_DEBUG_HIGH",
--     "CRIME_WANTED_LEVEL_UP_DEBUG_LOW"
-- }

-- function CrimeHashToCrime(Hash)
--     for i = 1, #crimesAsString do
--         if GetHashKey(crimesAsString[i]) == Hash then
--             return crimesAsString[i]
--         end
--     end
-- end

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)

--             local crimeCommited = Citizen.InvokeNative(0x259CE340A8738814, PlayerId())

--             local is_ = Citizen.InvokeNative(0xAD401C63158ACBAA, PlayerId())

--             if is_ then
--                 exports["vp_witness"]:N_0xCBFB4951F2E3934C()
--             end

--             -- exports["vp_witness"]:N_0x532C5FDDB986EE5C()

--             for i = 1, #crimesAsString do
--                 Citizen.InvokeNative(0xF611DE44AEB36A1D, GetHashKey(crimesAsString[i]), false)
--             end

--             print(Citizen.InvokeNative(0x69E181772886F48B, PlayerId()))
--             print(Citizen.InvokeNative(0xF0FBFB9AB15F7734, PlayerId(), 0, 0))
--             print(Citizen.InvokeNative(0x148E7AC8141C9E64, PlayerId()))
--             print(Citizen.InvokeNative(0x9945A3E2528A02E8, PlayerId()))
--             print(Citizen.InvokeNative(0x9D5C9A5A3321B128, PlayerId()))
--             print(Citizen.InvokeNative(0xAD401C63158ACBAA, PlayerId()))
--             print(Citizen.InvokeNative(0xDD5FD601481F648B, PlayerId()))
--             print("  ", PlayerId())

--             DrawTxt(booltostring(is_), 0.65, 0.05 + (0 * 0.025), 0.4, 0.4, true, 255, 255, 255, 255, false)
--             DrawTxt((crimeCommited == false and "0" or crimeCommited), 0.65, 0.05 + (1 * 0.025), 0.4, 0.4, true, 255, 255, 255, 255, false)
--             DrawTxt(CrimeHashToCrime(crimeCommited), 0.65, 0.05 + (2 * 0.025), 0.4, 0.4, true, 255, 255, 255, 255, false)
--         end
--     end
-- )

-- function booltostring(bool)
--     return bool == false and "false" or "true"
-- end

-- --[[
--     0xDAEFDFDB2AEECE37
--     _GET_CRIME_SEVERENESS, _GET_CRIME_TIMESTAMP

-- ]]
-- function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
--     local str = CreateVarString(10, "LITERAL_STRING", str)
--     SetTextScale(w, h)
--     SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
--     SetTextCentre(centre)
--     if enableShadow then
--         SetTextDropshadow(1, 0, 0, 0, 255)
--     end
--     Citizen.InvokeNative(0xADA9255D, 4)
--     DisplayText(str, x, y)
-- end

-- local saviorHumanNpc

local saviorHumanNpc

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local playerPed = PlayerPedId()

            if GetEntityHealth(playerPed) <= 0 then
                if saviorHumanNpc == nil then
                    local playerPosition = GetEntityCoords(playerPed)

                    local drugStorePosition, drugsStoreDistance = GetClosestDrugStore(playerPosition)

                    if drugsStoreDistance > 10.0 then
                        local humanNpcs = GetClosestHumanNpcs(50.0)

                        for _, humanNpc in pairs(humanNpcs) do
                            if HasEntityClearLosToEntity(humanNpc, playerPed, 0) then
                                if not IsPedDeadOrDying(humanNpc, 1) then
                                    if not NativeIsPedLassoed(humanNpc) then
                                        if not IsPedInCombat(humanNpc, 0) then
                                            local npcMount = GetMount(humanNpc)
                                            if npcMount ~= 0 then
                                                -- saviorHumanNpc = humanNpc
                                                -- HandleSaviorNpc(humanNpc, npcMount, drugStorePosition)

                                                saviorHumanNpc = humanNpc

                                                local humanNpcPosition = GetEntityCoords(humanNpc)

                                                SetEntityAsMissionEntity(humanNpc, true, true)
                                                NetworkRequestControlOfEntity(humanNpc)

                                                taskSequence = OpenSequenceTask()
                                                TaskSetBlockingOfNonTemporaryEvents(0, true)
                                                TaskGoToEntity(0, playerPed, -1, 1.2, 1.5, 2.0, 0)
                                                TaskPickupCarriableEntity(0, playerPed)
                                                TaskPlaceCarriedEntityOnMount(0, playerPed, npcMount, 7)
                                                Citizen.InvokeNative(0x92DB0739813C5186, 0, npcMount, -1, -1, 2.0, 1, 0, 0)

                                                TaskGoToCoordAnyMeansExtraParams(0, drugStorePosition, 3.0, 0, false, 524311, -1.0, 0, 1101004800, 800, 1112014848)

                                                TaskDumpCarriableFromParent(0, npcMount, playerPed)
                                                Citizen.InvokeNative(0x92DB0739813C5186, 0, npcMount, -1, -1, 2.0, 1, 0, 0)

                                                TaskGoToCoordAnyMeansExtraParams(0, humanNpcPosition, 3.0, 0, false, 524311, -1.0, 0, 1101004800, 800, 1112014848)

                                                TaskSetBlockingOfNonTemporaryEvents(0, false)
                                                CloseSequenceTask(taskSequence)

                                                TaskPerformSequence(humanNpc, taskSequence)

                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if GetSequenceProgress(saviorHumanNpc) == -1 then
                        saviorHumanNpc = nil
                        SetEntityAsMissionEntity(humanNpc, false, false)
                    end
                end
            end
        end
    end
)

local drugstores = {
    vec3(-282.673, 797.344, 118.868),
    vec3(-1803.430, -421.097, 157.387),
    vec3(2739.827, -1231.289, 49.689)
}

function GetClosestDrugStore(playerPosition)
    local lastIndex
    local lastDistance

    for i = 1, #drugstores do
        local v = drugstores[i]

        local dist = #(playerPosition - v)
        if lastIndex == nil or dist < lastDistance then
            lastIndex = i
            lastDistance = dist
        end
    end

    return drugstores[lastIndex], lastDistance
end

function IsPedBeingCarried(ped)
    return NativeGetCarrierAsPed(ped) ~= 0
end

function NativeGetCarrierAsPed(ped)
    return Citizen.InvokeNative(0x09B83E68DE004CD4, ped, Citizen.ResultAsInteger())
end

function NativeIsPedLassoed(ped)
    return Citizen.InvokeNative(0x9682F850056C9ADE, ped)
end

function GetClosestHumanNpcs(radius)
    local r = {}

    local playerPed = PlayerPedId()

    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(playerPed), radius, itemSet, 1, Citizen.ResultAsInteger())
    -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if IsEntityAPed(entity) and IsPedHuman(entity) and not IsPedDeadOrDying(entity, 0) then
                if IsPedAPlayer(entity) and entity ~= playerPed then
                    r = {}
                    break
                end
                table.insert(r, entity)
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return r
end

-- RegisterCommand(
--     "teste",
--     function()
--         local pedModelHash = GetHashKey("CS_LENNY")
--         if not IsModelValid(pedModelHash) then
--             print("model is not valid")
--             return
--         end

--         if not HasModelLoaded(pedModelHash) then
--             RequestModel(pedModelHash)
--             while not HasModelLoaded(pedModelHash) do
--                 Citizen.Wait(10)
--             end
--         end

--         local ped = CreatePed(pedModelHash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 1, 0)
--         Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
--         Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)

--         pedModelHash = GetHashKey("A_C_Horse_AmericanPaint_Overo")
--         if not IsModelValid(pedModelHash) then
--             print("model is not valid")
--             return
--         end

--         if not HasModelLoaded(pedModelHash) then
--             RequestModel(pedModelHash)
--             while not HasModelLoaded(pedModelHash) do
--                 Citizen.Wait(10)
--             end
--         end

--         local mount = CreatePed(pedModelHash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 1, 0)
--         Citizen.InvokeNative(0x283978A15512B2FE, mount, true)
--         Citizen.InvokeNative(0x58A850EAEE20FAA3, mount)

--         Citizen.InvokeNative(0x028F76B6E78246EB, ped, mount, -1, true)

--         -- SetPedOnMount(ped, mount, -1, true)
--         -- TaskMountAnimal(ped, mount, 0, 0, 0, 0, 0, 0)
--     end,
--     false
-- )
