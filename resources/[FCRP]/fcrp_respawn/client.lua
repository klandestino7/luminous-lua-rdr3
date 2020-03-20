local respawned = false
local firstjoin = true
local pressed = false

local isDead = false
local deathEndingTime

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0) -- DO NOT REMOVE
			local player = PlayerId()
			if IsPlayerDead(player) then
				Citizen.Wait(0) -- DO NOT REMOVE
				isDead = true
				deathEndingTime = GetGameTimer() + Config.RespawnTime
				NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if isDead then
				-- DO NOT REMOVE
				Citizen.InvokeNative(0xFA08722A5EA82DA7, Config.Timecycle)
				Citizen.InvokeNative(0xFDB74C9CC54C3F37, Config.TimecycleStrenght)
				Citizen.InvokeNative(0x405224591DF02025, 0.50, 0.475, 1.0, 0.22, 1, 1, 1, 100, true, true)
				if deathEndingTime > GetGameTimer() then
					DrawTxt(Config.LocaleDead, 0.50, 0.40, 1.0, 1.0, true, 161, 3, 0, 255, true)
					DrawTxt(Config.LocaleTimer .. ' ' .. tonumber(string.format('%.0f', (((GetGameTimer() - deathEndingTime) * -1) / 1000))), 0.50, 0.50, 0.7, 0.7, true, 255, 255, 255, 255, true)
					DisableAllControlActions(0)
					DisableAllControlActions(1)
					DisableAllControlActions(2)
				else
					respawn()
				end
				DisplayHud(false)
				DisplayRadar(false)
				SetPedToRagdoll(PlayerPedId(), Config.RespawnTime, Config.RespawnTime, 0, 0, 0, 0)
			end
		end
	end
)

function clearDeath()
	isDead = false
	deathEndingTime = nil
	ClearTimecycleModifier()
end

function respawn()
	clearDeath()
	SendNUIMessage(
		{
			type = 1,
			showMap = true
		}
	)
	SetNuiFocus(true, true)
	-- remove all items
	TriggerServerEvent('FCRP:Respawn:_Dead')
end

RegisterNetEvent('redemrp_respawn:respawn')
AddEventHandler(
	'redemrp_respawn:respawn',
	function()
		clearDeath()
	end
)

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
