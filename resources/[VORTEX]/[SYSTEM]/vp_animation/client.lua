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

    if IsControlPressed(1, 0x4CC0E2FE) then
        RequestAnimDict("mech_loco_m@generic@reaction@pointing@unarmed@stand")
        while not HasAnimDictLoaded("mech_loco_m@generic@reaction@pointing@unarmed@stand") do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), "mech_loco_m@generic@reaction@pointing@unarmed@stand", "point_fwd_0", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
    end

    --   if IsControlPressed(1, 0x4CC0E2FE) then -- B
    --     print("apertou")
    --     RequestAnimDict("script_hideout@six_point_cabin@rob_discuss")
    --     while not HasAnimDictLoaded("script_hideout@six_point_cabin@rob_discuss") do
    --         Citizen.Wait(100)
    --     end
    --     TaskPlayAnim(PlayerPedId(), "script_hideout@six_point_cabin@rob_discuss", "conversation_1_1_pedc", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
    --   end

    end
end)

RegisterCommand("clipset", function(source, args, rawCommand)
    N_0x03ddbf2d73799f9e("CLIPSET@MECH_GRAPPLE@UNARMED@_MALE@_AMBIENT@_HEALTHY@MOUNTED@INTIMIDATION@LOCO@ATTACKER")
    local retval, clipset =N_0x85b8f04555ab49b8("CLIPSET@MECH_GRAPPLE@UNARMED@_MALE@_AMBIENT@_HEALTHY@MOUNTED@INTIMIDATION@LOCO@ATTACKER")
    
    print(clipset)
    
end)




Citizen.CreateThread(function()
    local ply = PlayerPedId()
    local plyped = GetPlayerPed(ply)
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xD8F73058) then --[U]
                ClearPedTasks(ply)
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

local Bandana = false

RegisterCommand("bandana2", function(source, args, rawCommand)
    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end

    if not Bandana then  
        TaskPlayAnim(PlayerPedId(), "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 2300, 31, 0, true, 0, false, 0, false)
        Wait(2000)
        print('colocou')
        Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), 879715242)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
        Bandana = true        
    else
        TaskPlayAnim(PlayerPedId(), "mech_inventory@clothing@bandana", "NECK_2_FACE", 8.0, 8.0, 2300, 31, 0, true, 0, false, 0, false)
        Wait(2000)
        print('tirou')
        Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), -972364774)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false) 
        Bandana = false
    end
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


RegisterCommand("bale", function(source, args, rawCommand)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_BALE_PUT_DOWN_1_MALE_A"), 100000,true,false, false, false)
end)


RegisterCommand('whiskey', function(source, args)
    local propEntity = CreateObject(GetHashKey('p_bottleJD01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

    local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('ID_PH_R_HAND'), GetHashKey('EAT_STEW_BOWL_TABLE_BASE'), 1, 0, -1.0)
    local istask = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D,PlayerPedId())
    print(istask)

end)

RegisterCommand('champs', function(source, args)
    local propEntity = CreateObject(GetHashKey('p_glass001x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

    TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_glass001x_PH_R_HAND'), GetHashKey('DRINK_CHAMPAGNE_HOLD'), 1, 0, -1.0)
end)
RegisterCommand('beer', function(source, args)
    local propEntity = CreateObject(GetHashKey('p_bottleBeer01a'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

    local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD'), 1, 0, -1.0)
end)

RegisterCommand('coffee', function(source, args)
    local propEntity = CreateObject(GetHashKey('p_mugCoffee01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

    local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_mugCoffee01x_ph_r_hand'), GetHashKey('DRINK_COFFEE_HOLD'), 1, 0, -1.0)

end)

RegisterCommand('stew', function(source, args)
local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)

Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)

Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)

TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)

Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
end)


RegisterCommand("bale2", function(source, args, rawCommand)
    local model = "p_haybale03x"
    if IsModelValid(model) then
        if not HasModelLoaded(model) then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(10)
            end
        end
    end

    local coords = GetEntityCoords(PlayerPedId()) + (GetEntityForwardVector(PlayerPedId()) * 0.7)
    local object = CreateObject(model, coords, true, true, false, false, true)
    PlaceObjectOnGroundProperly(object)

    Citizen.InvokeNative(0x3BBDD6143FF16F98, PlayerPedId(), object, "p_hayBale03x_PH_R_HAND", "WORLD_HUMAN_COTTONBALE_PICKUP_2", 0, 0)

    
end)


