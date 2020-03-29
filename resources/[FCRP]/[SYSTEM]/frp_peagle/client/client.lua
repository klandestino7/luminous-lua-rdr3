
RegisterCommand('checkplayers', function()
    local players = {}
    ptable = GetPlayers()
    for _, i in ipairs(ptable) do
        table.insert(players,  GetPlayerServerId(i) .. GetPlayerName(i))
    end    

    print(table.concat(players))
end)



RegisterServerEvent('FRP:PEAGLE:checkJOB')
AddEventHandler('FRP:PEAGLE:checkJOB', function()

    local pigeon = CreatePed('A_C_Pigeon', GetEntityCoords(PlayerPedId()), 92.0, false, true, true, true);
    Citizen.InvokeNative(0x283978A15512B2FE, pigeon, true)    

    ClearPedTasks(pigeon)
    ClearPedSecondaryTask(pigeon)
    ClearPedTasksImmediately(pigeon)
    SetPedFleeAttributes(pigeon, 0,0)
    TaskWanderStandard(pigeon, 1, 0)
    TaskSetBlockingOfNonTemporaryEvents(pigeon, 1)
    SetEntityAsMissionEntity(pigeon)
    Wait(2000)

    TaskFlyToCoord(pigeon, 0, 62.92,42.51,102.15+80, 1, 0);
    Wait(5000)

    TaskFlyToCoord(pigeon, 0, 62.92,42.51,102.15+30, 1, 0);

    Wait(2000)

    print('voar')

    TaskGoToEntity(pigeon, PlayerPedId(), -1, 1, 2.0, 0, 0)

    while true do
        Citizen.Wait(100)
        Citizen.InvokeNative(0xA5C38736C426FCB8, pigeon, true)
        mensagemp = false
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local ec = GetEntityCoords(pigeon)
        local myV = vector3(coords.x, coords.y, coords.z)
        local dst = #(vector3(ec.x,ec.y,ec.z) - myV)
        local ed = coords.x, coords.y, coords.z

        print(dst)
        if dst < 20 then
            print('pegar mensagem')
            for _, prompt in pairs(prompts) do
                if PromptHasHoldModeCompleted(prompt) then
                    mensagemp = true
                end
            end
        else
            print('nao')
        end

        if mensagemp then
            TaskFlyToCoord(pigeon, 0, 62.92,42.51,102.15+80, 1, 0);
            Citizen.Wait(10000)
            DeleteEntity(pigeon)
        end
        

        if IsControlJustPressed(2, 0xE8342FF2) then -- Hold ALT    
            --   TaskGoToEntity(pigeon, PlayerPedId(), -1, 1, 2.0, 0, 0)
            local playc = GetEntityCoords(PlayerPedId())
            TaskFlyToCoord(pigeon, 0, playc.x,playc.y,playc.z, 2, 0);
        end     
    end
    
end)



-- Key Controls
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for _, prompt in pairs(prompts) do
                if PromptHasHoldModeCompleted(prompt) then
                    Citizen.Wait(0)
                    mensagemp = true
                end
            end
        end
    end
)    




values = GetEntityCoords(pigeon)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
                values = GetEntityCoords(pigeon)
                local prompt = PromptRegisterBegin()
                PromptSetControlAction(prompt, 0xE8342FF2)
                PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Comprar Armas'))
                PromptSetEnabled(prompt, 1)
                PromptSetVisible(prompt, 1)
                PromptSetHoldMode(prompt, 1)
                PromptSetPosition(prompt, values[1], values[2], values[3])
                N_0x0c718001b77ca468(prompt, 3.0)
                -- PrompContextSetSize(prompt, 3.0)
                PromptRegisterEnd(prompt)
                table.insert(prompts, prompt)
        end
    end
)
    
AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end)


function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end