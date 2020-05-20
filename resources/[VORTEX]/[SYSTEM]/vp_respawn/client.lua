local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local respawned = false
local firstjoin = true
local pressed = false
local PressDeath = false
local isDead = false
local deathEndingTime
local isInjure = false
local up = false
local deathCause = nil
local damageBone = {0}
local LoopCause = false
local InstaCause = nil
local InstaDeath = false
local BodyPartDamage = {0}
local prompts = {}
local promptGroup

local InstaDeathCauses = {
	"WEAPON_EXPLOSION",
	"WEAPON_FIRE",

}

local DeathCauses = {
	"WEAPON_HORSE",
	"WEAPON_DEER",
	"WEAPON_FIRE",
	"WEAPON_MOONSHINEJUG_MP",
	"WEAPON_EXPLOSION",
	"WEAPON_FALL", -- -842959696
	"WEAPON_POISON",
	"WEAPON_THROWN_POISONBOTTLE",
	"WEAPON_UNARMED",
	"WEAPON_RUN_OVER_BY_CAR",
	"WEAPON_BLEEDING",
	"WEAPON_DROWNING",
	"WEAPON_DROWNING_IN_VEHICLE",
	"WEAPON_MACHINERY",
	"weapon_moonshinejug",
	"weapon_bow",
	"weapon_melee_knife_hunter",
	"weapon_melee_lantern_electric",
	"weapon_melee_torch",
	"weapon_melee_broken_sword",
	"weapon_melee_hatchet",
	"weapon_melee_cleaver",
	"weapon_melee_ancient_hatchet",
	"weapon_melee_hatchet_viking",
	"weapon_melee_hatchet_hewing",
	"weapon_melee_hatchet_double_bit",
	"weapon_melee_hatchet_double_bit_rusted",
	"weapon_melee_hatchet_hunter",
	"weapon_melee_hatchet_hunter_rusted",
	"weapon_melee_knife_john",
	"weapon_melee_knife",
	"weapon_melee_knife_jawbone",
	"weapon_melee_knife_miner",
	"weapon_melee_knife_civil_war",
	"weapon_melee_knife_bear",
	"weapon_melee_knife_vampire",
	"weapon_melee_machete",
	"weapon_pistol_m1899",
	"weapon_pistol_mauser",
	"weapon_pistol_mauser_drunk",
	"weapon_pistol_semiauto",
	"weapon_pistol_volcanic",
	"weapon_revolver_cattleman",
	"weapon_revolver_cattleman_john",
	"weapon_revolver_cattleman_mexican",
	"weapon_revolver_cattleman_pig",
	"weapon_revolver_doubleaction",
	"weapon_revolver_doubleaction_exotic",
	"weapon_revolver_doubleaction_gambler",
	"weapon_revolver_doubleaction_micah",
	"weapon_revolver_lemat",
	"weapon_revolver_schofield",
	"weapon_revolver_schofield_golden",
	"weapon_revolver_schofield_calloway",
	"weapon_repeater_winchester",
	"weapon_repeater_carbine",
	"weapon_repeater_evans",
	"weapon_rifle_boltaction",
	"weapon_rifle_springfield",
	"weapon_rifle_varmint",
	"weapon_sniperrifle_carcano",
	"weapon_sniperrifle_rollingblock",
	"weapon_sniperrifle_rollingblock_exotic",
	"weapon_shotgun_doublebarrel",
	"weapon_shotgun_doublebarrel_exotic",
	"weapon_shotgun_pump",
	"weapon_shotgun_repeating",
	"weapon_shotgun_sawedoff",
	"weapon_shotgun_semiauto",
	"weapon_thrown_throwing_knives",
	"weapon_thrown_dynamite",
	"weapon_thrown_molotov",
	"weapon_thrown_tomahawk",
	"weapon_thrown_tomahawk_ancient"
}


local vitalBones = {
	'cabeça',
	'pescoço',
	'coluna'
}

local allbones = {
	['cabeça'] = {
		21030,
	},
	['pescoço'] = {
		14283,
		14284,
		14285,
	},
	['coluna'] = {	
		14410,
		14411,
		14412,
		14413,
		14414,
		14415,
		14416,
		11569,
		56200,
	},
	['maoesquerda'] = {
		41403,
		41404,
		41405,
		41323,
		41324,
		41325,
		41326,
		41307,
		41308,
		41309,
		41310,
		41355,
		41356,
		41357,
		41358,
		41339,
		41340,
		41341,
		41342,
		34606
	},
	['maodireita'] = {
		16827,
		16828,
		16829,
		16747,
		16748,
		16749,
		16750,
		16731,
		16732,
		16733,
		16734,
		16779,
		16780,
		16781,
		16782,
		16763,
		16764,
		16765,
		16766,
		22798
	},
	['braçodireito'] = {
		54187,	
		46065
	},
	['braçoesquerdo'] = {
		53675,
		37873
	},
	['pernadireita'] = {
		6884,
		43312,	
		54802
	},
	['pedireito'] = {
		33646,
		41273,
		18013,
		18029
	},
	['peesquerdo'] = {
		45454,
		53081,
		11440,
		11456
	},	
	['pernaesquerda'] = {
		65478,
		55120,
		30226
	},
	['genitaria'] = {
		10208,
		10209,
		39035
	}
}

Citizen.CreateThread(
	function()
		local lastHealth = GetEntityHealth(PlayerPedId())
		while true do
			Citizen.Wait(100)		
			if lastHealth ~= GetEntityHealth(PlayerPedId()) then

				local retVal, boneIndex = GetPedLastDamageBone(PlayerPedId())
				if boneIndex ~= 0 then
					table.insert(damageBone, boneIndex)
				end

				lastHealth = GetEntityHealth(PlayerPedId())
				-- print(json.encode(damageBone))

				for _, key in pairs(DeathCauses) do							
					if GetHashKey(key) == GetPedCauseOfDeath(PlayerPedId()) then
						deathCause = key
						-- print('death ' .. deathCause)
					end
				end

				for _, key in pairs(InstaDeathCauses) do
					if GetHashKey(key) == GetPedCauseOfDeath(PlayerPedId()) then
						InstaCause = key
						-- print('insta ' .. InstaCause)
					end					
				end


				for key, value in pairs(allbones) do	
					for _, index in pairs(value) do 
						for _, dam in pairs(damageBone)	do
							if dam == index then
								table.insert(BodyPartDamage, key)
							end
						end	
					end
				end

			end
		end
end)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0) -- DO NOT REMOVE
			local player = PlayerId()
			if IsPlayerDead(player) and isDead == false then
				Citizen.Wait(0) -- DO NOT REMOVE
				isDead = true
				deathEndingTime = GetGameTimer() + Config.RespawnTime
				--NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
			end
		end
	end
)

RegisterCommand(
	"kys",
	function()
		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
		local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
		Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
	end
)

RegisterNetEvent("VP:RESPAWN:revive")
AddEventHandler(
	"VP:RESPAWN:revive",
	function()
		NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
		isDead = false
		isInjure = false
		DestroyAllCams(true)
		clearDeath()
	end
)

RegisterNetEvent("VP:RESPAWN:PlayerDead")
AddEventHandler(
	"VP:RESPAWN:PlayerDead",
	function()
		Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
	end
)

local Locations = {
	[1] = vector3(-285.262, 806.542, 119.576), -- VALENTINE
	[2] = vector3(-1806.069, -426.045, 158.973), -- STRAWBERRY
	[3] = vector3(2725.834, -1224.180, 50.367) -- SAINT DENNIS
}

local prompts = {}
local promptGroup

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if isDead then
				if deathEndingTime > GetGameTimer() then
					if not LoopCause then						
						for BodyPart, v in pairs(allbones) do			
							for _, bonesId in pairs(v) do
								for _, BD in pairs(damageBone) do	
									for _, vital in pairs(vitalBones) do										
										for kBody, DamBody in pairs(BodyPartDamage) do		
											if DamBody == vital then									
												if deathCause == InstaCause then
													--print('insta1')
													InstaDeath = true
													LoopCause = true
												else						
												--	print('noinsta1')		
													InstaDeath = false
													LoopCause = true									
												end			
											else
												if deathCause == InstaCause then
												--	print('insta2')
													InstaDeath = true
													LoopCause = true
												else			
												--	print('noinsta2')							
													InstaDeath = false		
													LoopCause = true								
												end	
											end
										end
									end	
								end
							end
						end
						LoopCause = true
					end
					if InstaDeath then
						DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.15, 0.8, 0, 0, 0, 250, 1)
						DrawTxt("~e~MORTO", 0.50, 0.04, 0.8, 0.8, true, 255, 255, 255, 255, true)
						DrawTxt(Config.LocaleTimer, 0.50, 0.095, 0.4, 0.4, true, 255, 255, 255, 255, true)
						DrawTxt("" .. tonumber(string.format("%.0f", (((GetGameTimer() - deathEndingTime) * -1) / 1000))), 0.50, 0.12, 0.5, 0.5, true, 255, 255, 255, 255, true)			
					else
						DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.15, 0.8, 0, 0, 0, 250, 1)
						DrawTxt(Config.LocaleDead, 0.50, 0.04, 0.8, 0.8, true, 255, 255, 255, 255, true)
						DrawTxt("Levantando em", 0.50, 0.095, 0.4, 0.4, true, 255, 255, 255, 255, true)
						DrawTxt("" .. tonumber(string.format("%.0f", (((GetGameTimer() - deathEndingTime) * -1) / 1000))), 0.50, 0.12, 0.5, 0.5, true, 255, 255, 255, 255, true)	
					end
					DisableAllControlActions(0)
					DisableAllControlActions(1)
					DisableAllControlActions(2)
					Citizen.InvokeNative(0xFA08722A5EA82DA7, Config.Timecycle)
					Citizen.InvokeNative(0xFDB74C9CC54C3F37, Config.TimecycleStrenght)
					DestroyAllCams(true)
					DisplayHud(false)
					DisplayRadar(false)
				else
					if InstaDeath then
						isInjure = true
						PressDeath = true
						up = false
					else						
						isInjure = true
						up = true						
					end
				end
				--SetPedToRagdollWithFall(PlayerPedId(), Config.RespawnTime, Config.RespawnTime,0 , -0.440, -0.890, 0, 2, 0,0,0,0,0,0)
				--SetPedToRagdoll(PlayerPedId(), Config.RespawnTime, Config.RespawnTime, 0, 0, 0, 0)
				DestroyAllCams(true)
			end
			if isInjure then
				isDead = false
				Citizen.InvokeNative(0xFA08722A5EA82DA7, Config.Timecycle)
				Citizen.InvokeNative(0xFDB74C9CC54C3F37, Config.TimecycleStrenght)
				DisplayHud(true)
				DisplayRadar(true)
				if up then
					NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
					Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 1)
					SetEntityHealth(PlayerPedId(), 1)
					cAPI.Toast("alert", "Você está ferido, procure por ajuda médica")
					LoopCause = false
					isDead = false
					Uptime()
				end
				if PressDeath then
					local closestIndex
					local lowestDist
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					initRespawnPrompt()
					for _, prompt in pairs(prompts) do
						if PromptHasHoldModeCompleted(prompt) then						
							for index, vector in pairs(Locations) do
								local dst = #(vector - coords)
								if lowestDist == nil or dst < lowestDist then
									lowestDist = dst
									closestIndex = index
									PressDeath = false
									isInjure = false
								end
							end
							TriggerServerEvent("VP:Respawn:checkgroup", closestIndex)
						end
					end
				end
			end
		end
	end
)

function initRespawnPrompt()
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Você está morto.')
	local prompt = PromptRegisterBegin()
	PromptSetActiveGroupThisFrame(promptGroup, varStringCasa)
	PromptSetControlAction(prompt, 0xE8342FF2)
	PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Renascer'))
	PromptSetStandardMode(prompt, true)    
	PromptSetEnabled(prompt, 1)
	PromptSetVisible(prompt, 1)
	PromptSetHoldMode(prompt, 1)
	N_0x0c718001b77ca468(prompt, 3.0)
	PromptSetGroup(prompt, promptGroup)
	PromptRegisterEnd(prompt)
	table.insert(prompts, prompt)
end


function Uptime()
	local AliveTime = math.random(13, 18) * 60000
	local UpTime = GetGameTimer() + AliveTime
	while true do
	Citizen.Wait(0)
		if UpTime < GetGameTimer() then		
			SetEntityHealth(PlayerPedId(), 0)
			PressDeath = true
			break
		else
			if isDead then
				isInjure = true				
				PressDeath = true				
				isDead = false
			end
			if isInjure then
				up = true
			else
				break
			end
			DisableControlAction(0, 0x8FFC75D6, true) -- sprint
			DisableControlAction(0, 0xD9D0E1C0, true) -- jump
		end
	end
end

RegisterNetEvent("FRP_respawn:respawnvip")
AddEventHandler(
	"FRP_respawn:respawnvip",
	function()
		clearDeath()
		SendNUIMessage(
			{
				type = 1,
				showMap = true
			}
		)
		SetNuiFocus(true, true)
		-- remove all items
		TriggerServerEvent("VP:Respawn:_Dead")
	end
)

RegisterCommand('testemo', function()


	
end)


RegisterNetEvent("VP:RESPAWN:CheckDeath")
AddEventHandler(
	"VP:RESPAWN:CheckDeath",
	function()

	local data = {
		deathCause,
		InstaDeath,
		BodyPartDamage
	}			


	local player, distance = GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('VP:MEDIC:StatusDeath', GetPlayerServerId(player), data)
	end

	end
)

RegisterNetEvent("FRP_respawn:respawn")
AddEventHandler(
	"FRP_respawn:respawn",
	function(spawn)
		clearDeath()
		TriggerServerEvent("VP:Respawn:_Dead")
		DoScreenFadeOut(500)
		-- print(Locations[spawn])
		NetworkResurrectLocalPlayer(Locations[spawn], 59.95, true, true, false)
		SetEntityCoordsNoOffset(ped, Locations[spawn], false, false, false, true)
		SetEntityCoords(ped, Locations[spawn])

		DoScreenFadeIn(500)
	end
)

function clearDeath()
	isInjure = false
	isDead = false
	LoopCause = false	
	deathEndingTime = nil
	up = false	
	UpTime = nil
	InstaDeath = false
	InstaCause = nil
	deathCause = nil
	damageBone = {0}
	BodyPartDamage = {0}
	ClearTimecycleModifier()
	DisplayHud(true)
	DisplayRadar(true)
	TriggerServerEvent("VP:RESPAWN:onPlayerDeath")
	for _, prompt in pairs(prompts) do
		PromptDelete(prompt)
	end
end

RegisterNUICallback(
	"select",
	function(spawn, cb)
		local coords = Config[spawn][math.random(#Config[spawn])]
		local ped = PlayerPedId()
		SetEntityCoords(ped, coords.x, coords.y, coords.z)
		SetNuiFocus(false, false)
		SendNUIMessage(
			{
				type = 1,
				showMap = false
			}
		)
		FreezeEntityPosition(ped, false)
		ShutdownLoadingScreen()
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 59.95, true, true, false)
		local ped = PlayerPedId()
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
		ClearPedTasksImmediately(ped)
		ClearPlayerWantedLevel(PlayerId())
		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(PlayerId(), false)
		SetEntityVisible(ped, true)
		SetEntityCollision(ped, true)
		TriggerEvent("playerSpawned", spawn)
		Citizen.InvokeNative(0xF808475FA571D823, true)
		NetworkSetFriendlyFireOption(true)
		TriggerEvent("redemrp_respawn:camera", coords)
	end
)

RegisterNetEvent("redemrp_respawn:camera")
AddEventHandler(
	"redemrp_respawn:camera",
	function(cord)
		DoScreenFadeIn(500)
		local coords = cord
		SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, 0)
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
		PointCamAtCoord(cam, coords.x, coords.y, coords.z + 200)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 1, true, true)
		DoScreenFadeIn(500)
		Citizen.Wait(500)
		cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
		PointCamAtCoord(cam3, coords.x, coords.y, coords.z + 200)
		SetCamActiveWithInterp(cam3, cam, 3700, true, true)
		Citizen.Wait(3700)

		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
		PointCamAtCoord(cam2, coords.x, coords.y, coords.z + 2)
		SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
		RenderScriptCams(false, true, 500, true, true)
		Citizen.Wait(500)
		SetCamActive(cam, false)
		DestroyCam(cam, true)
		DestroyCam(cam2, true)
		DestroyCam(cam3, true)
		Citizen.Wait(3000)
	end
)

--=============================================================-- DRAW TEXT SECTION--=============================================================--
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	--Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, 1)
	DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
	return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if resourceName == GetCurrentResourceName() then
			for _, prompt in pairs(prompts) do
				PromptDelete(prompt)
			end
		end
	end
)

function isNearPlayer()
	local player, distance = GetClosestPlayer()
	if distance ~= -1 and distance <= 2.0 then
	    return player, distance
	else
	    return false
	end
	return false
end


function GetPlayers()
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(target)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end