local keys = {
    ["S"] = 0xD27782E3,
        ["W"] = 0x8FD015D8,
            ["LALT"] = 0x8AAA0AD4,
}

local prompts = {}

RegisterCommand('dv', function()
    local playerPed = PlayerPedId()
    local vehicle   = GetVehiclePedIsIn(playerPed, false)

    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    end

    if DoesEntityExist(vehicle) then
        DeleteVehicle(vehicle)
    end
end)

RegisterNetEvent('clothe:loadtenue')
AddEventHandler('clothe:loadtenue', function(kek) 
    SetPedOutfitPreset(PlayerPedId(), kek) 
    ---TriggerServerEvent("redemrp_skin:createSkin", kek) -- save on db work
end)

RegisterCommand('model', function(source, args)
    local modelo = args[1]
    local model = GetHashKey(modelo)        
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)               
    end
    SetPlayerModel(PlayerId(), model, true)
    Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
end)

-- Citizen.CreateThread(function()
--     local pigeon = CreatePed('A_C_Pigeon', GetEntityCoords(PlayerPedId()), 92.0, false, true, true, true);
--     Citizen.InvokeNative(0x283978A15512B2FE, pigeon, true)
    
--     ClearPedTasks(pigeon)
--     ClearPedSecondaryTask(pigeon)
--     ClearPedTasksImmediately(pigeon)
--     SetPedFleeAttributes(pigeon, 0,0)
--     TaskWanderStandard(pigeon, 1, 0)
--     TaskSetBlockingOfNonTemporaryEvents(pigeon, 1)
--     SetEntityAsMissionEntity(pigeon)
--     Wait(2000)

--     TaskFlyToCoord(pigeon, 0, 62.92,42.51,102.15+80, 1, 0);
--     Wait(5000)

--     TaskFlyToCoord(pigeon, 0, 62.92,42.51,102.15+30, 1, 0);

--     Wait(2000)
--     print('voar')

--     TaskGoToEntity(pigeon, PlayerPedId(), -1, 1, 2.0, 0, 0)

--     --print(GetEntityType(PlayerPedId()))
    
--     -- ClearPedTasksImmediately(pigeon)
--     -- TaskGoToEntity(pigeon, PlayerPedId(), -1, 1, 2.0, 0, 0)
--     -- ClearPedTasks(pigeon, 1, 0)
--     -- SetEntityInvincible(pigeon, true)

--     while true do
--         Citizen.Wait(100)
--         Citizen.InvokeNative(0xA5C38736C426FCB8, pigeon, true)
--         mensagemp = false
--         local player = PlayerPedId()
--         local coords = GetEntityCoords(player)
--         local ec = GetEntityCoords(pigeon)
--         local myV = vector3(coords.x, coords.y, coords.z)
--         local dst = #(vector3(ec.x,ec.y,ec.z) - myV)
--         local ed = coords.x, coords.y, coords.z

--         print(dst)
--         if dst < 20 then
--             print('pegar mensagem')
--             for _, prompt in pairs(prompts) do
--                 if PromptHasHoldModeCompleted(prompt) then
--                     mensagemp = true
--                 end
--             end
--         else
--             print('nao')
--         end

--         if mensagemp then
--             TaskFlyToCoord(pigeon, 0, 62.92,42.51,102.15+80, 1, 0);
--             Citizen.Wait(10000)
--             DeleteEntity(pigeon)
--         end
        

--         if IsControlJustPressed(2, 0xE8342FF2) then -- Hold ALT    
--             --   TaskGoToEntity(pigeon, PlayerPedId(), -1, 1, 2.0, 0, 0)
--             local playc = GetEntityCoords(PlayerPedId())
--             TaskFlyToCoord(pigeon, 0, playc.x,playc.y,playc.z, 2, 0);
--         end     
--     end

-- end)


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
-- )
    
-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
--             end
--         end
--     end)


-- local towns = {
--     [1] = { ["distance"] = 160.0, ["x"] = -300.00, ["y"] = 790.00, ["z"] = 117.00, ["name"] = "Valentine"},
--     [2] = { ["distance"] = 60.0, ["x"] = -1790.00, ["y"] = -404.00, ["z"] = 117.00, ["name"] = "Strawberry"},
--     [3] = { ["distance"] = 60.0, ["x"] = -812.00, ["y"] = -1294.00, ["z"] = 61.00, ["name"] = "Blackwater"},
--     [4] = { ["distance"] = 60.0, ["x"] = -3676.00, ["y"] = -2601.00, ["z"] = 00.00, ["name"] = "Armadillo"},
--     [5] = { ["distance"] = 180.0, ["x"] = -5510.00, ["y"] = -2939.00, ["z"] = 10.00, ["name"] = "Tumbleweed"},
--     [6] = { ["distance"] = 200.0, ["x"] = 1353.00, ["y"] = -1268.00, ["z"] = 80.00, ["name"] = "Rhodes"},
--     [7] = { ["distance"] = 500.0, ["x"] = 2604.00, ["y"] = -1177.00, ["z"] = 117.00, ["name"] = "Saint Denis"},
-- }

-- local NotifyIn = false
-- local NotifyOut = false
-- local insideTown = false

-- Citizen.CreateThread(function()
--     while true do
--         for i = 1, #towns do
--             Wait(500)
--             local player = PlayerPedId()
--             local coords = GetEntityCoords(player)
--             local myV = vector3(coords.x, coords.y, coords.z)
--             local dst = #(vector3(towns[i]["x"], towns[i]["y"], towns[i]["z"]) - myV)

--             if dst < towns[i]["distance"] then
--                 if not NotifyIn then                      
--                     insideTown = true
--                     TriggerEvent("frp_notify:start", 'Bem-vindo a '..towns[i]["name"], 5)                
--                     NotifyIn = true
--                     NotifyOut = false
--                 elseif dst > towns[i]["distance"] then
--                     insideTown = false
--                 end
--             else
--                 if not NotifyOut then
--                     NotifyIn = false
--                     NotifyOut = true
--                 end
--             end
--         end
--     end
--     return
-- end)
