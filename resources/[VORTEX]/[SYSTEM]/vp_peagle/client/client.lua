local pigeons = {}



RegisterNetEvent("VP:PEAGLE:GetCoords")
AddEventHandler(
    "VP:PEAGLE:GetCoords",
    function(tplayer,Mensagem)
    local ped = PlayerPedId()
    local Coords = GetEntityCoords(ped)
    TriggerServerEvent("VP:PEAGLE:ReceiveCoords", Coords, tplayer, Mensagem)
end)




RegisterNetEvent('VP:PEAGLE:ReceiveMenssage')
AddEventHandler('VP:PEAGLE:ReceiveMenssage', function(PlayerCoords, text)
        local back = true
        local Notified = false
        local pigeon = CreatePed("A_C_Pigeon", PlayerCoords, 92.0, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, pigeon, true)

        ClearPedTasks(pigeon)
        ClearPedSecondaryTask(pigeon)
        ClearPedTasksImmediately(pigeon)
        SetPedFleeAttributes(pigeon, 0, 0)
        TaskWanderStandard(pigeon, 1, 0)
        TaskSetBlockingOfNonTemporaryEvents(pigeon, 1)
        SetEntityAsMissionEntity(pigeon)
        Wait(2000)
        TaskFlyToCoord(pigeon, 0, 62.92, 42.51, 102.15 + 10, 1, 0)

        while true do
            Citizen.Wait(1)
            Citizen.InvokeNative(0xA5C38736C426FCB8, pigeon, true)

            while true do
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                local ec = GetEntityCoords(pigeon)
                local myV = vector3(coords.x, coords.y, coords.z)
                local dst = #(vector3(ec.x, ec.y, ec.z) - myV)
                local ed = coords.x, coords.y, coords.z
                Citizen.Wait(2)
                local playc = GetEntityCoords(PlayerPedId())

                if back then
                    TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 1, 0)
                end                
               
                if dst < 60 then

                    if not Notified then
                        TriggerEvent('VP:NOTIFY:Simple', 'Você tem uma pombo mensagem. Pressione ALT para chamar o pombo.', 5000)
                        Notified = true
                    end

                    if Notified and dst > 4 then
                        Wait(15000)
                        TaskGoToEntity(pigeon, PlayerPedId(), -1, 2.5, 2, 0, 0)
                    end                    

                    if IsControlJustPressed(0, 0xE8342FF2) then -- Hold ALT
                        TaskWhistleAnim(PlayerPedId(), -433953410, 1971704925)                        
                        back = false
                        TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 2, 0)                         
                        if dst < 3.5 then
                            local carriable = Citizen.InvokeNative(0xF0B4F759F35CC7F5, pigeon, Citizen.InvokeNative(0x34F008A7E48C496B, pigeon, 2), 0, 0, 512)
                            TaskPickupCarriableEntity(PlayerPedId(), carriable)  
                            openGuiRead(text)
                        end
                    end                  

                end
            end
        end
    end
)



function openGuiRead(text)
    local veh = GetVehiclePedIsUsing(PlayerPedId())
    if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
          SetPlayerControl(PlayerId(), 0, 0)
          isUiOpen = true
          Citizen.Trace("OPENING")
          SendNUIMessage({
              action = 'openNotepadRead',
              TextRead = text,
          })
          SetNuiFocus(true, true)
    end  
  end


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
