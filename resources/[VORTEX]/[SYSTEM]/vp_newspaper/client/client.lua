RegisterCommand('jornal',function()
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0);    

    
-- RequestAnimDict("AMB_REST_LEAN@WORLD_HUMAN_LEAN@BARREL@READ_NEWSPAPER@MALE_A")
-- while not HasAnimDictLoaded("AMB_REST_LEAN@WORLD_HUMAN_LEAN@BARREL@READ_NEWSPAPER@MALE_A") do
--     Citizen.Wait(100)
-- end
-- TaskPlayAnim(PlayerPedId(), "AMB_REST_LEAN@WORLD_HUMAN_LEAN@BARREL@READ_NEWSPAPER@MALE_A", "base", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
 

SendNUIMessage(
        {
            action = 'show'
        }
    )
    SetNuiFocus(true, true)

end)

RegisterNUICallback('close', function()   
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetNuiFocus(false, false)
end)