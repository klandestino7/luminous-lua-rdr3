local pigeons = {}

RegisterNetEvent("VP:PIGEONPOST:Init")
AddEventHandler(
    "VP:PIGEONPOST:Init",
    function()
        local ped = PlayerPedId()
        local sCoords = GetEntityCoords(ped) + (GetEntityForwardVector(ped) * 0.7)

        local pigeon = CreatePed("A_C_Pigeon", sCoords, GetEntityHeading(ped), true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, pigeon, true)

        ClearPedTasks(pigeon)
        ClearPedSecondaryTask(pigeon)
        ClearPedTasksImmediately(pigeon)
        SetPedFleeAttributes(pigeon, 0, 0)
        TaskWanderStandard(pigeon, 1, 0)
        TaskSetBlockingOfNonTemporaryEvents(pigeon, 1)

        table.insert(pigeons, pigeon)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if #pigeons > 0 then
                local ped = PlayerPedId()
                local sCoords = GetEntityCoords(ped) + (GetEntityForwardVector(ped) * 0.7)
                for _, pigeon in pairs(pigeons) do
                    if not IsEntityInAir(pigeon, 0) then
                        TaskGoStraightToCoord(pigeon, sCoords, 10.0, 5000, 180.0, 1.0)
                    else
                        
                    end
                end
            end
        end
    end
)

RegisterCommand(
    "checkplayers",
    function()
        local players = {}
        ptable = GetPlayers()
        for _, i in ipairs(ptable) do
            table.insert(players, GetPlayerServerId(i) .. GetPlayerName(i))
        end

        print(table.concat(players))
    end
)

RegisterCommand(
    "peagle",
    function()
        -- RegisterServerEvent('VP:PEAGLE:checkJOB')
        -- AddEventHandler('VP:PEAGLE:checkJOB', function()

        local back = true

        local pigeon = CreatePed("A_C_Pigeon", GetEntityCoords(PlayerPedId()), 92.0, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, pigeon, true)

        ClearPedTasks(pigeon)
        ClearPedSecondaryTask(pigeon)
        ClearPedTasksImmediately(pigeon)
        SetPedFleeAttributes(pigeon, 0, 0)
        TaskWanderStandard(pigeon, 1, 0)
        TaskSetBlockingOfNonTemporaryEvents(pigeon, 1)
        SetEntityAsMissionEntity(pigeon)
        Wait(2000)
        TaskFlyToCoord(pigeon, 0, 62.92, 42.51, 102.15 + 30, 1, 0)

        while true do
            Citizen.Wait(1)
            Citizen.InvokeNative(0xA5C38736C426FCB8, pigeon, true)
            mensagemp = false

            while true do
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                local ec = GetEntityCoords(pigeon)
                local myV = vector3(coords.x, coords.y, coords.z)
                local dst = #(vector3(ec.x, ec.y, ec.z) - myV)
                local ed = coords.x, coords.y, coords.z
                Citizen.Wait(2)
                if back then
                    local playc = GetEntityCoords(PlayerPedId())
                    TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 1, 0)
                end
                print(dst)
                if dst < 40 then
                    if IsControlJustPressed(0, 0xE8342FF2) then -- Hold ALT
                        back = false
                        TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 2, 0)
                        if dst < 2 then
                            local carriable = Citizen.InvokeNative(0xF0B4F759F35CC7F5, pigeon, Citizen.InvokeNative(0x34F008A7E48C496B, pigeon, 2), 0, 0, 512)
                            TaskPickupCarriableEntity(PlayerPedId(), carriable)
                            Wait(2000)
                            break
                        end
                    end
                else
                    print("nao")
                end
            end
        end
    end
)

-- -- Key Controls
-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             for _, prompt in pairs(prompts) do
--                 if PromptHasHoldModeCompleted(prompt) then
--                     Citizen.Wait(0)
--                     mensagemp = true
--                 end
--             end
--         end
--     end
-- )

-- values = GetEntityCoords(pigeon)
-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(10)
--                 values = GetEntityCoords(pigeon)
--                 local prompt = PromptRegisterBegin()
--                 PromptSetControlAction(prompt, 0xE8342FF2)
--                 PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Comprar Armas'))
--                 PromptSetEnabled(prompt, 1)
--                 PromptSetVisible(prompt, 1)
--                 PromptSetHoldMode(prompt, 1)
--                 PromptSetPosition(prompt, values[1], values[2], values[3])
--                 N_0x0c718001b77ca468(prompt, 3.0)
--                 -- PrompContextSetSize(prompt, 3.0)
--                 PromptRegisterEnd(prompt)
--                 table.insert(prompts, prompt)
--         end
--     end
-- -- )

-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
--             end
--         end
--     end)

-- function GetPlayers()
--     local players = {}

--     for i = 0, 256 do
--         if NetworkIsPlayerActive(i) then
--             table.insert(players, i)
--         end
--     end

--     return players
-- end
