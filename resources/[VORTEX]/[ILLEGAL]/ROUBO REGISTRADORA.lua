RPF2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   �      �$     �$     y   8  y     �   @  �  / client.lua config.lua fxmanifest.lua                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          --------------------
local Oczekiwanie = 0
local Kradne = 0
local procent = 40
local uciek = 0
local cooldown = 0
local powiadom = 0
local sheriff_ilosc = 0
local anim = true
--------------------
local infoSheriff = 35 -- przy ilu pozostalych sekundach ma dawac info na policje
local czasCooldown = 45 * 1000

function NaliczCooldown()
    cooldown = 1
    Citizen.Wait(czasCooldown)
    cooldown = 0
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Oczekiwanie)

        local pedCoords = GetEntityCoords(PlayerPedId())
        local objectId = GetClosestObjectOfType(pedCoords, 2.5, GetHashKey("P_REGISTER03X"), false)
        local objectCoords = GetEntityCoords(objectId)
        local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, objectCoords.x, objectCoords.y, objectCoords.z)

        if dist <= 20.0 then
            Oczekiwanie = 0
        else
            Oczekiwanie = 500
        end
        if dist <= 1.5 and cooldown == 0 then
            DrawText3D(objectCoords.x, objectCoords.y, objectCoords.z+0.5,'Press [ENTER] to rob')
        end

        if DoesEntityExist(objectId) and IsControlJustPressed(1, 0xC7B5340A) and cooldown == 0 and dist <= 1.1  then
            TriggerServerEvent("wwrp_shopRobbery:sheriffs_call")
            RegisterNetEvent('wwrp_shopRobbery:sheriffs_back')
            AddEventHandler('wwrp_shopRobbery:sheriffs_back', function(amount)
                sheriff_ilosc = amount
            end)
            Wait(500)
            print(sheriff_ilosc)
            if sheriff_ilosc >= 1 then
                local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                if Kradne == 0 then
                    Kradne = 1
					 TriggerEvent("redemrp_notification:start","Press [Delete] to cancel" , 3, "error")
					anim = true
					FreezeEntityPosition(PlayerPedId() , true)
                    for i=1, 2857, 1 do
                        local pedCoords = GetEntityCoords(PlayerPedId())
                        local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, objectCoords.x, objectCoords.y, objectCoords.z)
                        if dist <= 2.5 then
                            Citizen.Wait(5)
                            local pedCoords2 = GetEntityCoords(GetPlayerPed(-1))
                            procent = procent - 0.014
                            DrawText3D2(pedCoords.x, pedCoords.y, pedCoords.z+1, math.floor(procent)..' seconds left.')
                            if powiadom == 0 and math.floor(procent) < infoSheriff then
                                powiadom = 1
                                TriggerServerEvent("wwrp_shopRobbery:CallToSherif", pedCoords.x, pedCoords.y, pedCoords.z, GetCurentTownName())
                                print("called")
                            end
                        else
                            if uciek == 0 then
                                uciek = 1
                                TriggerEvent("redemrp_notification:start"," The robbery has been cancelled!" , 5, "error")
                            end
                        end
						      if uciek == 0 and math.floor(procent) < 10 and anim == true then
								Animacja()
								anim = false
                            end
                    end
                    Kradne = 0
                    procent = 40
                    ClearPedTasks(GetPlayerPed(-1))
                    if uciek == 0 then
                        TriggerServerEvent("wwrp_shopRobbery:AddSomeMoney")
						 FreezeEntityPosition(PlayerPedId() , false)
                    end
                    uciek = 0
                else
                end
                powiadom = 0
                NaliczCooldown()
            else
                TriggerEvent("redemrp_notification:start"," There aren't enough sheriffs "..sheriff_ilosc.."/2" , 2, "error")
            end

        end 


    end
end)



Citizen.CreateThread(function()
    while true do
		Citizen.Wait(Oczekiwanie)
			if IsControlJustPressed(0, 0x4AF4D473) then
			print(Kradne)
				if Kradne == "1" or  Kradne == 1 then
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
    
	local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    TaskPlayAnim(PlayerPedId(), dict, "enter_picklock_step_in", 1.0, 8.0, -1, 1, 0, false, false, false)
	 Citizen.Wait(1000)
	local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
	 AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.05, -0.07, -0.05, -140.0, 60.0, 0.0, true, true, false, true, 1, true)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
	DeleteObject(tempObj2)
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


RegisterNetEvent('wwrp_shopRobbery:InfoSheriff')
AddEventHandler('wwrp_shopRobbery:InfoSheriff', function(x, y, z, zone)
    AllowSonarBlips(true)
    TriggerEvent("redemrp_notification:start", "Robbery in progress at "..zone , 5, "error")
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


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Config = {}
Config.Sheriff = 1
Config.DoorList = {
{
		doorName = 'P_DOORl3X',
		objCoords  = vector3(1285.14, -1303.12, 76.04),
		objYaw = -35.0,
		locked = false,
		distance = 3.0
	},
	
	{
		doorName = 'P_DOOR_VAL_BANKVAULT',
		objCoords  = vector3(1282.53, -1309.12, 76.03),
		objYaw = -250.0,
		CharDetonateHeading = 233.82,
		xOffset = 0,
		yOffset = 1,
		ClosedRotation = -135.0,
		detonate = false,
		distance = 3.0
	},

	
	
	{
		textCoords = vector3(1296.27, -1299.02, 76.03),
		locked = false,
		distance = 2.5,
		doors = {
			{
			--	objName = 'v_ilev_ph_door01',
				objYaw = 231.0,
				objCoords = vector3(1296.27, -1299.02, 76.03)
			},

			{
			-- objName = 'v_ilev_ph_door002',
				objYaw = -91.0,
				objCoords = vector3(1294.54, -1297.59, 76.03)
			}
		}
	},


}

Config.SafeList = {

	{
		heading = 234.96,
		locked = false,
		coords = vector3(1288.4, -1313.8, 75.84)
	},
	
	{
		heading = 234.96,
		locked = false,
		coords = vector3(1287.0, -1315.52, 75.84)
	},
	
	{
		heading = 234.96,
		locked = false,
		coords = vector3(1287.59, -1314.73, 75.84)
	}


}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


client_scripts {
	'config.lua',
	'client.lua'
}
server_scripts {
	'config.lua',
	'server.lua'	
}
dependency 'redem_roleplay'
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             