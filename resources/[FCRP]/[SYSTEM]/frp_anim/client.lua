Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(0,0x8CC9CD42 ))  then
            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
    
                RequestAnimDict( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" )
    
                while ( not HasAnimDictLoaded( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" ) ) do 
                    Citizen.Wait( 100 )
                end
    
                if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                    ClearPedSecondaryTask(ped)
                else
                    TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 8.0, -8.0, 120000, 31, 0, true, 0, false, 0, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsControlPressed(1, 0x26E9DC00) then -- Z
        Citizen.InvokeNative(0xAE99FB955581844A, PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
      end
    end
end)

Citizen.CreateThread(function()
    local ply = PlayerPedId()
    local plyped = GetPlayerPed(ply)
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xD8F73058) then --[U]
                ClearPedTasks(ply)
            end
            if IsControlPressed(0, 0xF3830D8E) then
                RequestAnimDict("mech_loco_m@generic@reaction@pointing@unarmed@stand")
                while not HasAnimDictLoaded("mech_loco_m@generic@reaction@pointing@unarmed@stand") do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(PlayerPedId(), "mech_loco_m@generic@reaction@pointing@unarmed@stand", "point_fwd_0", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
            end
        end
    end)
    
RegisterCommand("anotar", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0);    
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_WRITE_NOTEBOOK"), 200000,false,false, false, false)    
end)

RegisterCommand("bandana", function(source, args, rawCommand)
    RequestAnimDict("mech_inventory@equip_facemask@fallbacks")
    while not HasAnimDictLoaded("mech_inventory@equip_facemask@fallbacks") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), "mech_inventory@equip_facemask@fallbacks", "bandana_enter_r", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
end)

RegisterCommand("bandana2", function(source, args, rawCommand)
    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
end)


RegisterCommand("vomitar", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0);
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_VOMIT"), 100000,true,false, false, false)
end)

RegisterCommand("fumar", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0);
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SMOKE"), 100000,true,false, false, false)
end)

RegisterCommand("fumar1", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SMOKE_CIGAR"), 100000,true,false, false, false)
end)

RegisterCommand("beber", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_DRINK_DRUNK"), 100000,true,false, false, false)
end)

RegisterCommand("lerf", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_READING_JOURNAL"), 100000,true,false, false, false)
end)

RegisterCommand("afumar", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_LEAN_RAILING_SMOKING"), 100000,true,false, false, false)
end)

RegisterCommand("awhisky", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINK_FLASK"), 100000,true,false, false, false)    
end)

RegisterCommand("ataca", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINK_CHAMPAGNE"), 100000,true,false, false, false)
end)

RegisterCommand("acerveja", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINKING_INTERACTION"), 100000,true,false, false, false)
end)

RegisterCommand("awhisky2", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINKING_DRUNK"), 100000,true,false, false, false)
end)

RegisterCommand("ajanela", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_WINDOW"), 100000,true,false, false, false)
end)

RegisterCommand("amesa", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_TABLE"), 100000,true,false, false, false)
end)

RegisterCommand("adormir", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_CAMP_JACK_ES_SLEEP"), 100000,true,false, false, false)
end)

RegisterCommand("adeitar", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_CAMP_JACK_ES_SLEEP"), 100000,true,false, false, false)
end)

RegisterCommand("anim", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_TREE_CHOP_RAYFIRE"), 100,true,false, false, false)
end)

RegisterCommand("anim2", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_HUMAN_SEAT_CHAIR_FAN"), 100,true,false, false, false)
end)

RegisterCommand("anim3", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_FAN"), 100,true,false, false, false)
end)

RegisterCommand("violao", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_HUMAN_SEAT_CHAIR_GUITAR"), 100000,true,false, false, false)
end)
