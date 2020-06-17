
local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local expectativa = 0
local roubo = 0
local procent = 40
local cancelou = 0
local cooldown = 0
local powiadom = 0
local sheriff_count = 0
local anim = true
local faca = false
--------------------
local infoSheriff = 35 -- com quantos segundos faltam para dar informações à polícia
local TimeCooldown = 45 * 1000

function NaliczCooldown()
    cooldown = 1
    Citizen.Wait(TimeCooldown)
    cooldown = 0
end

RegisterNetEvent('ROUBO:sheriffs_back')
AddEventHandler('ROUBO:sheriffs_back', function(amount)
    sheriff_count = amount
end)

RegisterNetEvent('ROUBO:item_back')
AddEventHandler('ROUBO:item_back', function(amount)
    faca = amount
end)


Citizen.CreateThread(function()
    local hashUnarmed = GetHashKey("WEAPON_UNARMED")

    while true do
        Citizen.Wait(expectativa)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local Registradora = GetHashKey("P_REGISTER05X") or GetHashKey("P_REGISTER03X") or GetHashKey("")
        local objectId = GetClosestObjectOfType(pedCoords, 2.5, GetHashKey("P_REGISTER03X"), false)
		local objectCoords = GetEntityCoords(objectId)		
		local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, objectCoords.x, objectCoords.y, objectCoords.z)
		
        if dist <= 20.0 then
            expectativa = 0
        else
            expectativa = 500
		end
        local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)
        
       -- if weaponHash ~= hashUnarmed then
            if dist <= 1.5 and cooldown == 0 then
                DrawText3D(objectCoords.x, objectCoords.y, objectCoords.z+0.5,'Aperte [ENTER] para roubar')
            end

            if DoesEntityExist(objectId) and IsControlJustPressed(1, 0xC7B5340A) and cooldown == 0 and dist <= 1.1  then	     

                TriggerServerEvent("ROUBO:sheriffs_call")    
                TriggerServerEvent("ROUBO:itemcheck")
                print(faca)

                -- if faca == false then   
                --     return
                -- end

                Wait(500)
                if sheriff_count >= 1 then
                    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    if roubo == 0 then
                        roubo = 1
                        --TriggerEvent("redemrp_notification:start","Press [Delete] to cancel" , 3, "error")
                        anim = true  

                        FreezeEntityPosition(PlayerPedId() , true)
                        for i=1, 2857, 1 do
                            local pedCoords = GetEntityCoords(PlayerPedId())
                            local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, objectCoords.x, objectCoords.y, objectCoords.z)
                            if dist <= 2.5 then
                                Citizen.Wait(5)
                                local pedCoords2 = GetEntityCoords(GetPlayerPed(-1))
                                procent = procent - 0.014
                                DrawText(math.floor(procent)..' segundos restantes.', 0.925, 0.96, 0.4, 0.4, false, 255, 255, 255, 145, 1, 7)                            
                                -- DrawText3D2(pedCoords.x, pedCoords.y, pedCoords.z+1, )
                                if powiadom == 0 and math.floor(procent) < infoSheriff then                                   
                                    TriggerServerEvent("ROUBO:CallToSherif", pedCoords.x, pedCoords.y, pedCoords.z, GetCurentTownName()) 
                                    powiadom = 1
                                end
                            else
                                if cancelou == 0 then
                                    cancelou = 1
                                    --TriggerEvent("redemrp_notification:start"," The robbery has been cancelled!" , 5, "error")
                                end
                            end
                            if cancelou == 0 and anim == true then                             
                                Animacja()
                                anim = false
                            end
                        end
                        roubo = 0
                        procent = 40
                        ClearPedTasks(GetPlayerPed(-1))
                        if cancelou == 0 then
                            TriggerServerEvent("ROUBO:AddSomeMoney")
                            FreezeEntityPosition(PlayerPedId() , false)
                        end
                        cancelou = 0
                    else
                    end
                    powiadom = 0
                    NaliczCooldown()
                else
                    --TriggerEvent("redemrp_notification:start"," There aren't enough sheriffs "..sheriff_count.."/2" , 2, "error")
                end

            end
       -- end 


    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(expectativa)
			if IsControlJustPressed(0, 0x4AF4D473) then
			print(roubo)
            if roubo == "1" or  roubo == 1 then
                FreezeEntityPosition(PlayerPedId() , false)
                anim = false
            end	
		end	
	end		
end)

RegisterCommand('core', function(source, args)
Animacja()
end)

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

function Animacja()
    print('animou')
Citizen.CreateThread(function()		
    local dict = "mech_pickup@loot@cash_register@open"
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)
	local prop = GetHashKey("P_KNIFE02X")
	RequestAnimDict(dict)
	
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end		
	if not HasModelLoaded(prop) then
        RequestModel(prop)
    end
    while not HasModelLoaded(prop) do
        Citizen.Wait(1)
	end    
    
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), 1, 0,0,0)

	local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    TaskPlayAnim(PlayerPedId(), dict, "enter_picklock_step_in", 1.0, 8.0, -1, 1, 0, false, false, false)
	 Citizen.Wait(1000)
	local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
	 AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.05, -0.07, -0.05, -140.0, 60.0, 0.0, true, true, false, true, 1, true)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    DeleteObject(tempObj2)
    anim = true
    end)

end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextDropshadow(1, 0, 0, 0, 255)
    Citizen.InvokeNative(0xADA9255D, font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end


function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=GetHudScreenPositionFromWorldPosition(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function GetCurentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    end
end


RegisterNetEvent('ROUBO:InfoSheriff')
AddEventHandler('ROUBO:InfoSheriff', function(x, y, z, zone)
    AllowSonarBlips(true)
    --TriggerEvent("redemrp_notification:start", "Robbery in progress at "..zone , 5, "error")
    local time = 60
    Citizen.CreateThread(function()
        while time > 0 do
            Wait(1000)
            ForceSonarBlipsThisFrame()
            local coords = GetEntityCoords(PlayerPedId())
            TriggerSonarBlip(348490638, x, y, z)
            time = time - 1
        end
    end)
end)