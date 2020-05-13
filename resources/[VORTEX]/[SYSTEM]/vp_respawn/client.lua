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

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0) -- DO NOT REMOVE
			local player = PlayerId()
			if IsPlayerDead(player) and isDead == false then
				Citizen.Wait(0) -- DO NOT REMOVE
				isDead = true				
				up = true
				deathEndingTime = GetGameTimer() + Config.RespawnTime	
				--NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
			end
		end
	end
)

RegisterCommand('kys', function()
	local pl = Citizen.InvokeNative(0x217E9DC48139933D)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
    Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
end)

RegisterNetEvent('VP:RESPAWN:revive')
AddEventHandler('VP:RESPAWN:revive', function()
	NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
	isDead = false
	isInjure = false
	DestroyAllCams(true)
	clearDeath()
end)

RegisterNetEvent('VP:RESPAWN:PlayerDead')
AddEventHandler('VP:RESPAWN:PlayerDead', function()
	Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)	
end)

local Locations = {
    [1] = vector3(-285.262,806.542,119.576),  -- VALENTINE
	[2] = vector3(-1806.069,-426.045,158.973), -- STRAWBERRY
	[3] = vector3(2725.834,-1224.180,50.367), -- SAINT DENNIS
}

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if isDead then
				-- DO NOT REMOVE
			--	Citizen.InvokeNative(0xFA08722A5EA82DA7, Config.Timecycle)
			--	Citizen.InvokeNative(0xFDB74C9CC54C3F37, Config.TimecycleStrenght)
			--	Citizen.InvokeNative(0x405224591DF02025, 0.50, 0.475, 1.0, 0.22, 1, 1, 1, 100, true, true)
				if deathEndingTime > GetGameTimer() then					
					DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.90, 0.20, 0.15, 0.8, 0, 0, 0, 250, 1)
					DrawTxt(Config.LocaleDead, 0.50, 0.84, 0.8, 0.8, true, 255, 255, 255, 255, true)
					DrawTxt(Config.LocaleTimer, 0.50, 0.895, 0.4, 0.4, true, 255, 255, 255, 255, true)
					DrawTxt('' .. tonumber(string.format('%.0f', (((GetGameTimer() - deathEndingTime) * -1) / 1000))), 0.50, 0.92, 0.5, 0.5, true, 255, 255, 255, 255, true)
					DisableAllControlActions(0)
					DisableAllControlActions(1)
					DisableAllControlActions(2)
					DestroyAllCams(true)			
					DisplayHud(false)
					DisplayRadar(false)	
				else				
					isInjure = true		
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
					cAPI.notify("alert", "Segure ALT para Renacer")
				end
				if PressDeath then
					local closestIndex
					local lowestDist
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					if IsControlJustPressed(0, 0xE8342FF2) then
						for index, vector in pairs(Locations) do
							local dst = #(vector - coords)						
							if lowestDist == nil or dst < lowestDist then
								lowestDist = dst
								closestIndex = index
								PressDeath = false			
								isInjure = false								
							end    
						end						
						TriggerServerEvent('VP:Respawn:checkgroup', closestIndex)
					end
				end
			end			
		end
	end
)

RegisterNetEvent('FRP_respawn:respawnvip')
AddEventHandler(
	'FRP_respawn:respawnvip',
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
		TriggerServerEvent('VP:Respawn:_Dead')
	end
)

RegisterNetEvent('FRP_respawn:respawn')
AddEventHandler(
	'FRP_respawn:respawn',
	function(spawn)		
		clearDeath()	
		TriggerServerEvent('VP:Respawn:_Dead')
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
	ClearTimecycleModifier()
	DisplayHud(true)
	DisplayRadar(true)
	TriggerServerEvent('VP:RESPAWN:onPlayerDeath')
end


RegisterNUICallback(
	'select',
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
		TriggerEvent('playerSpawned', spawn)
		Citizen.InvokeNative(0xF808475FA571D823, true)
		NetworkSetFriendlyFireOption(true)
		TriggerEvent('redemrp_respawn:camera', coords)
	end
)

RegisterNetEvent('redemrp_respawn:camera')
AddEventHandler(
	'redemrp_respawn:camera',
	function(cord)
		DoScreenFadeIn(500)
		local coords = cord
		SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, 0)
		cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
		PointCamAtCoord(cam, coords.x, coords.y, coords.z + 200)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 1, true, true)
		DoScreenFadeIn(500)
		Citizen.Wait(500)
		cam3 = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
		PointCamAtCoord(cam3, coords.x, coords.y, coords.z + 200)
		SetCamActiveWithInterp(cam3, cam, 3700, true, true)
		Citizen.Wait(3700)

		cam2 = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
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
	local str = CreateVarString(10, 'LITERAL_STRING', str)

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
