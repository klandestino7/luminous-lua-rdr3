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
local damageBone = nil

local prompt
local promptGroup
local promptGroupName

local causes = {
	"WEAPON_HORSE",
	"WEAPON_DEER",
	"WEAPON_FIRE",
	"WEAPON_MOONSHINEJUG_MP",
	"WEAPON_THROWN_MOLOTOV",
	"WEAPON_THROWN_DYNAMITE",
	"WEAPON_EXPLOSION",
	"WEAPON_FALL", -- -842959696
	"WEAPON_POISON",
	"WEAPON_THROWN_POISONBOTTLE",
	"WEAPON_UNARMED",
	"WEAPON_RUN_OVER_BY_CAR",
	"WEAPON_BLEEDING",
	"WEAPON_DROWNING",
	"WEAPON_DROWNING_IN_VEHICLE",
	"WEAPON_LASSO_REINFORCED",
	"WEAPON_LASSO",
	"WEAPON_MACHINERY"
}

local bones = {
	21030, --'skel_head',
	14283, --'skel_neck0',
	14284, --'skel_neck1',
	14285, --'skel_neck2', -- -842959696
	14410, --'skel_spine0',
	14411, --'skel_spine1',
	14412, --'skel_spine2',
	14413, --'skel_spine3',
	14414, --'skel_spine4',
	14415, --'skel_spine5',
	14416, --'skel_spine6',
	11569, --'SKEL_Spine_Root',
	46065 --'skel_r_upperarm',
}

local allbones = {
	["skel_head"] = {bone_index = 144, bone_id = 21030},
	["skel_l_calf"] = {bone_index = 3, bone_id = 55120},
	["skel_l_clavicle"] = {bone_index = 192, bone_id = 30226},
	["SKEL_L_Finger00"] = {bone_index = 225, bone_id = 41403},
	["SKEL_L_Finger01"] = {bone_index = 226, bone_id = 41404},
	["SKEL_L_Finger02"] = {bone_index = 227, bone_id = 41405},
	["SKEL_L_Finger10"] = {bone_index = 218, bone_id = 41323},
	["SKEL_L_Finger11"] = {bone_index = 219, bone_id = 41324},
	["SKEL_L_Finger12"] = {bone_index = 220, bone_id = 41325},
	["SKEL_L_Finger13"] = {bone_index = 221, bone_id = 41326},
	["SKEL_L_Finger20"] = {bone_index = 211, bone_id = 41307},
	["SKEL_L_Finger21"] = {bone_index = 212, bone_id = 41308},
	["SKEL_L_Finger22"] = {bone_index = 213, bone_id = 41309},
	["SKEL_L_Finger23"] = {bone_index = 214, bone_id = 41310},
	["SKEL_L_Finger30"] = {bone_index = 204, bone_id = 41355},
	["SKEL_L_Finger31"] = {bone_index = 205, bone_id = 41356},
	["SKEL_L_Finger32"] = {bone_index = 206, bone_id = 41357},
	["SKEL_L_Finger33"] = {bone_index = 207, bone_id = 41358},
	["SKEL_L_Finger40"] = {bone_index = 196, bone_id = 41339},
	["SKEL_L_Finger41"] = {bone_index = 197, bone_id = 41340},
	["SKEL_L_Finger42"] = {bone_index = 198, bone_id = 41341},
	["SKEL_L_Finger43"] = {bone_index = 199, bone_id = 41342},
	["skel_l_foot"] = {bone_index = 4, bone_id = 45454},
	["skel_l_forearm"] = {bone_index = 194, bone_id = 53675},
	["skel_l_hand"] = {bone_index = 195, bone_id = 34606},
	["skel_l_thigh"] = {bone_index = 2, bone_id = 65478},
	["SKEL_L_Toe0"] = {bone_index = 5, bone_id = 53081},
	["SKEL_L_Toe10"] = {bone_index = 7, bone_id = 11440},
	["SKEL_L_Toe20"] = {bone_index = 6, bone_id = 11456},
	["skel_l_upperarm"] = {bone_index = 193, bone_id = 37873},
	["skel_neck0"] = {bone_index = 138, bone_id = 14283},
	["SKEL_Neck1"] = {bone_index = 142, bone_id = 14284},
	["SKEL_Neck2"] = {bone_index = 143, bone_id = 14285},
	["skel_pelvis"] = {bone_index = 1, bone_id = 56200},
	["SKEL_Penis00"] = {bone_index = 83, bone_id = 10208},
	["SKEL_Penis01"] = {bone_index = 84, bone_id = 10209},
	["SKEL_Penis_Trans"] = {bone_index = 82, bone_id = 39035},
	["skel_r_calf"] = {bone_index = 34, bone_id = 43312},
	["skel_r_clavicle"] = {bone_index = 290, bone_id = 54802},
	["SKEL_R_Finger00"] = {bone_index = 294, bone_id = 16827},
	["SKEL_R_Finger01"] = {bone_index = 295, bone_id = 16828},
	["SKEL_R_Finger02"] = {bone_index = 296, bone_id = 16829},
	["SKEL_R_Finger10"] = {bone_index = 299, bone_id = 16747},
	["SKEL_R_Finger11"] = {bone_index = 300, bone_id = 16748},
	["SKEL_R_Finger12"] = {bone_index = 301, bone_id = 16749},
	["SKEL_R_Finger13"] = {bone_index = 302, bone_id = 16750},
	["SKEL_R_Finger20"] = {bone_index = 306, bone_id = 16731},
	["SKEL_R_Finger21"] = {bone_index = 307, bone_id = 16732},
	["SKEL_R_Finger22"] = {bone_index = 308, bone_id = 16733},
	["SKEL_R_Finger23"] = {bone_index = 309, bone_id = 16734},
	["SKEL_R_Finger30"] = {bone_index = 313, bone_id = 16779},
	["SKEL_R_Finger31"] = {bone_index = 314, bone_id = 16780},
	["SKEL_R_Finger32"] = {bone_index = 315, bone_id = 16781},
	["SKEL_R_Finger33"] = {bone_index = 316, bone_id = 16782},
	["SKEL_R_Finger40"] = {bone_index = 320, bone_id = 16763},
	["SKEL_R_Finger41"] = {bone_index = 321, bone_id = 16764},
	["SKEL_R_Finger42"] = {bone_index = 322, bone_id = 16765},
	["SKEL_R_Finger43"] = {bone_index = 323, bone_id = 16766},
	["skel_r_foot"] = {bone_index = 35, bone_id = 33646},
	["skel_r_forearm"] = {bone_index = 292, bone_id = 54187},
	["skel_r_hand"] = {bone_index = 293, bone_id = 22798},
	["skel_r_thigh"] = {bone_index = 33, bone_id = 6884},
	["SKEL_R_Toe0"] = {bone_index = 36, bone_id = 41273},
	["SKEL_R_Toe10"] = {bone_index = 37, bone_id = 18013},
	["SKEL_R_Toe20"] = {bone_index = 38, bone_id = 18029},
	["skel_r_upperarm"] = {bone_index = 291, bone_id = 46065},
	["skel_spine0"] = {bone_index = 131, bone_id = 14410},
	["skel_spine1"] = {bone_index = 132, bone_id = 14411},
	["skel_spine2"] = {bone_index = 133, bone_id = 14412},
	["SKEL_Spine3"] = {bone_index = 134, bone_id = 14413},
	["skel_spine4"] = {bone_index = 135, bone_id = 14414},
	["SKEL_Spine5"] = {bone_index = 136, bone_id = 14415},
	["SKEL_Spine6"] = {bone_index = 137, bone_id = 14416},
	["SKEL_Spine_Root"] = {bone_index = 130, bone_id = 11569}
}

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
		PressDeath = false
		up = false
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

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if isDead then
				if not isCaused then
					for _, k in pairs(causes) do
						if GetHashKey(k) == GetPedCauseOfDeath(PlayerPedId()) then
							deathCause = k
						end
					end
					local retVal, boneIndex = GetPedLastDamageBone(PlayerPedId())
					for _, k in pairs(bones) do
						if k == boneIndex then
							damageBone = k
						end
					end
					isCaused = true
				end
				if deathEndingTime > GetGameTimer() then
					if damageBone ~= nil then
						DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.20, 0.15, 0.8, 0, 0, 0, 250, 1)
						DrawTxt("~e~MORTO", 0.50, 0.04, 0.8, 0.8, true, 255, 255, 255, 255, true)
						DrawTxt(Config.LocaleTimer, 0.50, 0.095, 0.4, 0.4, true, 255, 255, 255, 255, true)
						DrawTxt("" .. tonumber(string.format("%.0f", (((GetGameTimer() - deathEndingTime) * -1) / 1000))), 0.50, 0.12, 0.5, 0.5, true, 255, 255, 255, 255, true)
					else
						if deathCause == (GetHashKey("WEAPON_EXPLOSION") or GetHashKey("WEAPON_FIRE") or GetHashKey("WEAPON_THROWN_MOLOTOV") or GetHashKey("WEAPON_THROWN_DYNAMITE")) then
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
					end
					DisableAllControlActions(0)
					DisableAllControlActions(1)
					DisableAllControlActions(2)
					DestroyAllCams(true)
					DisplayHud(false)
					DisplayRadar(false)
				else
					if damageBone ~= nil then
						isInjure = true
						PressDeath = true
						up = false
					else
						if deathCause == (GetHashKey("WEAPON_EXPLOSION") or GetHashKey("WEAPON_FIRE") or GetHashKey("WEAPON_THROWN_MOLOTOV") or GetHashKey("WEAPON_THROWN_DYNAMITE")) then
							isInjure = true
							PressDeath = true
							up = false
						else
							isInjure = true
							up = true
						end
					end
				end
				--SetPedToRagdollWithFall(PlayerPedId(), Config.RespawnTime, Config.RespawnTime,0 , -0.440, -0.890, 0, 2, 0,0,0,0,0,0)
				--SetPedToRagdoll(PlayerPedId(), Config.RespawnTime, Config.RespawnTime, 0, 0, 0, 0)
				DestroyAllCams(true)
			end

			if isInjure then
				Citizen.InvokeNative(0xFA08722A5EA82DA7, Config.Timecycle)
				Citizen.InvokeNative(0xFDB74C9CC54C3F37, Config.TimecycleStrenght)
				DisableControlAction(0, 0x8FFC75D6, true) -- sprint
				DisableControlAction(0, 0xD9D0E1C0, true) -- jump
				DisplayHud(true)
				DisplayRadar(true)
				if up then
					NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
					Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 1)
					SetEntityHealth(PlayerPedId(), 1)
					cAPI.notify("alert", "Você está ferido, procure por ajuda médica")
					up = false
					local AliveTime = math.random(13, 18) * 60000
					Wait(AliveTime)
					isInjure = false
					SetEntityHealth(PlayerPedId(), 0)
					PressDeath = true
				end
				if PressDeath then
					local closestIndex
					local lowestDist
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)

					initRespawnPrompt()

					PromptSetActiveGroupThisFrame(promptGroup, promptGroupName)

					if PromptHasHoldModeCompleted(prompt) then
						PromptDelete(prompt)
						prompt = nil
						promptGroup = nil
						promptGroupName = nil
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
)

function initRespawnPrompt()
	if prompt == nil then
		promptGroupName = CreateVarString(10, "LITERAL_STRING", "Você está morto.")

		prompt = PromptRegisterBegin()
		promptGroup = GetRandomIntInRange(0, 0xE8342FF2)
		PromptSetControlAction(prompt, 0xCEFD9220)
		PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Renascer"))
		PromptSetEnabled(prompt, 1)
		PromptSetVisible(prompt, 1)
		PromptSetHoldMode(prompt, 1)
		PromptSetGroup(prompt, promptGroup)
		PromptRegisterEnd(prompt)
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

RegisterNetEvent("FRP_respawn:respawn")
AddEventHandler(
	"FRP_respawn:respawn",
	function(spawn)
		clearDeath()
		TriggerServerEvent("VP:Respawn:_Dead")
		DoScreenFadeOut(500)

		print(Locations[spawn])

		NetworkResurrectLocalPlayer(Locations[spawn], 59.95, true, true, false)
		SetEntityCoordsNoOffset(ped, Locations[spawn], false, false, false, true)
		SetEntityCoords(ped, Locations[spawn])

		DoScreenFadeIn(500)
	end
)

function clearDeath()
	isInjure = false
	isDead = false
	deathEndingTime = nil
	damageBone = nil
	ClearTimecycleModifier()
	DisplayHud(true)
	DisplayRadar(true)
	TriggerServerEvent("VP:RESPAWN:onPlayerDeath")
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
			if prompt ~= nil then
				PromptDelete(prompt)
			end
		end
	end
)
