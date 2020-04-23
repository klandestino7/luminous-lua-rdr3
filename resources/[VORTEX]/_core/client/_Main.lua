local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = {}
Tunnel.bindInterface("API", cAPI)
Proxy.addInterface("API", cAPI)

initializedPlayer = false

AddEventHandler(
	"playerSpawned",
	function()
		TriggerServerEvent("pre_playerSpawned")
	end
)

AddEventHandler(
	"onClientMapStart",
	function()
		print("client map initialized")
		-- exports.spawnmanager:setAutoSpawn(true)
		-- exports.spawnmanager:forceRespawn()
	end
)

AddEventHandler(
	"onResourceStart",
	function(resourceName)
		if (GetCurrentResourceName() ~= resourceName) then
			return
		end
		TriggerServerEvent("API:addReconnectPlayer")
	end
)

-- Citizen.CreateThread(
-- 	function()
-- 		SetMinimapHideFow(true)
-- 		Citizen.InvokeNative(0x63E7279D04160477, true)
-- 		Citizen.InvokeNative("0x1E5B70E53DB661E5", 1122662550, 347053089, 0, "Faroeste", "Roleplay", "Bem-vindo!")
-- 	end
-- )

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            Citizen.InvokeNative(0xF808475FA571D823, true) --enable friendly fire
            NetworkSetFriendlyFireOption(true)

            SetRelationshipBetweenGroups(5, "PLAYER", "PLAYER")

            local ped = PlayerPedId()

            if IsPedOnMount(ped) or IsPedInAnyVehicle(ped, false) then
                SetRelationshipBetweenGroups(1, "PLAYER", "PLAYER")
                 Citizen.Wait(2000)
            elseif IsPedGettingIntoAVehicle(ped) or Citizen.InvokeNative(0x95CBC65780DE7EB1, ped, false) then                 
                SetRelationshipBetweenGroups(1, "PLAYER", "PLAYER")
                Citizen.Wait(1000)
            else
                SetRelationshipBetweenGroups(5, "PLAYER", "PLAYER")
            end            

            DisableControlAction(0, 0x580C4473, true) -- hud disable
            DisableControlAction(0, 0xCF8A4ECA, true) -- hud disable

            DisableControlAction(0, 0x41AC83D1, true) -- loot
            DisableControlAction(0, 0x399C6619, true) -- loot 2
            -- DisableControlAction(0, 0x27D1C284, false) -- loot 3
            -- DisableControlAction(0, 0x14DB6C5E, true) -- loot vehicle
            -- DisableControlAction(0, 0xC23D7B9E, false) -- loot ammo
            DisableControlAction(0, 0xFF8109D8, true) -- loot Alive
            --   DisableControlAction(0, 0xD2CC4644, true) -- soltar corda
            DisableControlAction(0, 0x6E9734E8, true) -- DESATIVAR DESISTIR
            DisableControlAction(0, 0x295175BF, true) -- DESATIVAR SOLTAR DA CORDA
        end
    end
)


Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10000)
			if initializedPlayer then
				local playerPed = PlayerPedId()
				if playerPed and playerPed ~= -1 then
					local x, y, z = table.unpack(GetEntityCoords(playerPed))
					x = tonumber(string.format("%.3f", x))
					y = tonumber(string.format("%.3f", y))
					z = tonumber(string.format("%.3f", z))
					TriggerServerEvent("updatePosOnServerForPlayer", x, y, z)
				end
			end
		end
	end
)

function cAPI.getPosition()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	return x, y, z
end

function cAPI.teleport(x, y, z, spawn)
	SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
end

function cAPI.GetCurrentTownName()
	local pedCoords = GetEntityCoords(PlayerPedId())
	local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)

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
	elseif town_hash == false then
		return "Cidade Fantasma"
	end
end

-- return vx,vy,vz
function cAPI.getSpeed()
	local vx, vy, vz = table.unpack(GetEntityVelocity(PlayerPedId()))
	return math.sqrt(vx * vx + vy * vy + vz * vz)
end

function cAPI.CWanted(reward)
	local Wanted = true
	if reward == 0 then
		return false
	end
	return reward
end

function cAPI.getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading * math.pi / 180.0)
	local y = math.cos(heading * math.pi / 180.0)
	local z = math.sin(pitch * math.pi / 180.0)
	local len = math.sqrt(x * x + y * y + z * z)
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end
	return x, y, z
end

function cAPI.GetCoordsFromCam(distance)
	local rot = GetGameplayCamRot(2)
	local coord = GetGameplayCamCoord()

	local tZ = rot.z * 0.0174532924
	local tX = rot.x * 0.0174532924
	local num = math.abs(math.cos(tX))

	newCoordX = coord.x + (-math.sin(tZ)) * (num + distance)
	newCoordY = coord.y + (math.cos(tZ)) * (num + distance)
	newCoordZ = coord.z + (math.sin(tX) * 8.0)
	return newCoordX, newCoordY, newCoordZ
end

function cAPI.Target(Distance, Ped)
	local Entity = nil
	local camCoords = GetGameplayCamCoord()
	local farCoordsX, farCoordsY, farCoordsZ = cAPI.GetCoordsFromCam(Distance)
	local RayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ, -1, Ped, 0)
	local A, B, C, D, Entity = GetShapeTestResult(RayHandle)
	return Entity, farCoordsX, farCoordsY, farCoordsZ
end

function cAPI.GetEntInFrontOfPlayer(Distance, Ped)
	local Ent = nil
	local CoA = GetEntityCoords(Ped, 1)
	local CoB = GetOffsetFromEntityInWorldCoords(Ped, 0.0, Distance, 0.0)
	local RayHandle = StartShapeTestRay(CoA.x, CoA.y, CoA.z, CoB.x, CoB.y, CoB.z, -1, Ped, 0)
	local A, B, C, D, Ent = GetShapeTestResult(RayHandle)
	return Ent
end

function cAPI.getNearestPlayers(radius)
	local r = {}
	local ped = PlayerPedId()
	local pid = PlayerId()
	local pCoords = GetEntityCoords(ped)

	for _, v in pairs(GetActivePlayers()) do
		local player = GetPlayerFromServerId(v)
		local pPed = GetPlayerPed(player)
		local pPCoords = GetEntityCoords(pPed)
		local distance = #(pCoords - pPCoords)
		if distance <= radius then
			r[GetPlayerServerId(player)] = distance
		end
	end

	-- for k, v in pairs(players) do
	-- 	local player = GetPlayerFromServerId(k)
	-- 	if v and player ~= pid and NetworkIsPlayerConnected(player) then
	-- 		local oped = GetPlayerPed(player)
	-- 		local x, y, z = table.unpack(GetEntityCoords(oped, true))
	-- 		local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
	-- 		if distance <= radius then
	-- 			r[GetPlayerServerId(player)] = distance
	-- 		end
	-- 	end
	-- end
	return r
end

function cAPI.getNearestPlayer(radius)
	local p = nil
	local players = cAPI.getNearestPlayers(radius)
	local min = radius + 10.0
	for k, v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end

local weaponModels = {
	"weapon_kit_camera",
	"WEAPON_KIT_BINOCULARS",
	"weapon_melee_knife_hunter",
	"weapon_moonshinejug",
	"weapon_melee_lantern_electric",
	"weapon_melee_torch",
	"weapon_melee_broken_sword",
	"weapon_fishingrod",
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
	"weapon_thrown_throwing_knives",
	"weapon_melee_knife_miner",
	"weapon_melee_knife_civil_war",
	"weapon_melee_knife_bear",
	"weapon_melee_knife_vampire",
	"weapon_lasso",
	"weapon_melee_machete",
	"weapon_thrown_tomahawk",
	"weapon_thrown_tomahawk_ancient",
	"weapon_pistol_m1899",
	"weapon_pistol_mauser",
	"weapon_pistol_mauser_drunk",
	"weapon_pistol_semiauto",
	"weapon_pistol_volcanic",
	"weapon_repeater_carbine",
	"weapon_repeater_evans",
	"weapon_repeater_henry",
	"weapon_rifle_varmint",
	"weapon_repeater_winchester",
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
	"weapon_rifle_boltaction",
	"weapon_sniperrifle_carcano",
	"weapon_sniperrifle_rollingblock",
	"weapon_sniperrifle_rollingblock_exotic",
	"weapon_rifle_springfield",
	"weapon_shotgun_doublebarrel",
	"weapon_shotgun_doublebarrel_exotic",
	"weapon_shotgun_pump",
	"weapon_shotgun_repeating",
	"weapon_shotgun_sawedoff",
	"weapon_shotgun_semiauto",
	"weapon_bow",
	"weapon_thrown_dynamite",
	"weapon_thrown_molotov"
}

function cAPI.getWeapons()
	local ped = PlayerPedId()

	local ammo_types = {}

	local weapons = {}
	for k, v in pairs(weaponModels) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped, hash) then
			local atype = GetPedAmmoTypeFromWeapon(ped, hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapons[v] = GetAmmoInPedWeapon(ped, hash)
			else
				weapons[v] = 0
			end
		end
	end

	return weapons
end

-- function cAPI.removeWeapon(weapon)
-- 	local weapons = cAPI.getWeapons()
-- 	if weapons[weapon] then
-- 		weapons[weapon] = nil
-- 	end
-- 	cAPI.replaceWeapons(weapons)
-- end

function cAPI.replaceWeapons(weapons)
	local old_weapons = cAPI.getWeapons()
	cAPI.giveWeapons(weapons, true)
	return old_weapons
end

function cAPI.giveWeapon(weapon, ammo, clear_before)
	cAPI.giveWeapons(
		{
			weapon = ammo
		},
		clear_before
	)
end

function cAPI.giveWeapons(weapons, clear_before)
	local ped = PlayerPedId()

	if clear_before then
		RemoveAllPedWeapons(ped, true, true)
	end

	for weapon, ammo in pairs(weapons) do
		local hash = GetHashKey(weapon)

		GiveWeaponToPed_2(PlayerPedId(), hash, ammo or 0, false, true, GetWeapontypeGroup(hash), ammo > 0, 0.5, 1.0, 0, true, 0, 0)
		Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), hash, 0, false, true)
		Citizen.InvokeNative(0x5FD1E1F011E76D7E, PlayerPedId(), GetPedAmmoTypeFromWeapon(PlayerPedId(), hash), ammo)
	end
end

function cAPI.setArmour(amount)
	SetPedArmour(PlayerPedId(), amount)
end

function cAPI.getArmour()
	return GetPedArmour(PlayerPedId())
end

function cAPI.setHealth(amount)
	SetEntityHealth(PlayerPedId(), math.floor(amount))
end

function cAPI.getHealth()
	return GetEntityHealth(PlayerPedId())
end

local prompResult = nil

function cAPI.prompt(title, default_text)
	SendNUIMessage({act = "prompt", title = title, text = tostring(default_text)})
	SetNuiFocus(true)
	while prompResult == nil do
		Citizen.Wait(10)
	end
	local _temp = prompResult
	prompResult = nil
	return _temp
end

RegisterNUICallback(
	"prompt",
	function(data, cb)
		if data.act == "close" then
			SetNuiFocus(false)
			prompResult = data.result
		end
	end
)

local requests = {}

function cAPI.request(text, time)
	local id = math.random(999999)
	SendNUIMessage({act = "request", id = id, text = tostring(text), time = time})

	-- !!! OPTIMIZATION
	-- Stop the loop while the time has passed

	while requests[id] == nil do
		Citizen.Wait(10)
	end

	local _temp = requests[id] or false
	requests[id] = nil
	return _temp
end

RegisterNUICallback(
	"request",
	function(data, cb)
		if data.act == "response" then
			requests[data.id] = data.ok
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(3)
			if IsControlJustPressed(1, 166) then
				SendNUIMessage({act = "event", event = "yes"})
			end
			if IsControlJustPressed(1, 167) then
				SendNUIMessage({act = "event", event = "no"})
			end
		end
	end
)

local noclip = false
local noclip_speed = 10.0

function cAPI.toggleNoclip()
	noclip = not noclip
	if noclip then
		SetEntityInvincible(PlayerPedId(), true)
		SetEntityVisible(PlayerPedId(), false, false)
		NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
	else
		SetEntityInvincible(PlayerPedId(), false)
		SetEntityVisible(PlayerPedId(), true, false)
		NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			SetEntityMaxHealth(PlayerPedId(), 150)
			SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
			if noclip then
				local ped = PlayerPedId()
				local x, y, z = cAPI.getPosition()
				local dx, dy, dz = cAPI.getCamDirection()
				local speed = noclip_speed
				SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

				if IsControlPressed(0, 0x8FD015D8) then
					x = x + speed * dx
					y = y + speed * dy
					z = z + speed * dz
				end

				if IsControlPressed(0, 0xD27782E3) then
					x = x - speed * dx
					y = y - speed * dy
					z = z - speed * dz
				end

				if IsControlPressed(0, 0x8FFC75D6) then -- SHIFT
					noclip_speed = 10.0
				elseif IsControlPressed(0, 0xDB096B85) then -- CTRL
					noclip_speed = 0.2
				else
					noclip_speed = 1.0
				end

				SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
			end
		end
	end
)

function cAPI.teleportToWaypoint()
	if not IsWaypointActive() then
		return
	end

	local x, y, z = table.unpack(GetWaypointCoords())

	local ground
	local groundFound = false
	local groundCheckHeights = {
		0.0,
		50.0,
		100.0,
		150.0,
		200.0,
		250.0,
		300.0,
		350.0,
		400.0,
		450.0,
		500.0,
		550.0,
		600.0,
		650.0,
		700.0,
		750.0,
		800.0,
		850.0,
		900.0,
		950.0,
		1000.0,
		1050.0,
		1100.0
	}

	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped) then
		ped = veh
	end

	for i, height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped, x, y, height, 0, 0, 1)

		RequestCollisionAtCoord(x, y, z)
		while not HasCollisionLoadedAroundEntity(ped) do
			RequestCollisionAtCoord(x, y, z)
			Citizen.Wait(1)
		end
		Citizen.Wait(20)

		ground, z = GetGroundZFor_3dCoord(x, y, height)
		if ground then
			z = z + 1.0
			groundFound = true
			break
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0)
	end

	RequestCollisionAtCoord(x, y, z)
	while not HasCollisionLoadedAroundEntity(ped) do
		RequestCollisionAtCoord(x, y, z)
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
end

function cAPI.playAnim(dict, anim, speed)
	if not IsEntityPlayingAnim(PlayerPedId(), dict, anim) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
		end
		TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
	end
end

function cAPI.createVehicle(Vmodel)
	local veh = GetHashKey(Vmodel)
	local ply = GetPlayerPed()
	local coords = GetEntityCoords(ply)
	local head = GetEntityHeading(ply)
	Citizen.CreateThread(
		function()
			RequestModel(veh)
			while not HasModelLoaded(veh) do
				Wait(1000)
				print("Loading Model: " .. Vmodel .. "Loading Hash: " .. veh)
			end
			if HasModelLoaded(veh) then
				local car = CreateVehicle(veh, coords.x - 2, coords.y, coords.z, head, true, true, false, true)
				print("Model spawned Succes: " .. Vmodel)
			end
		end
	)
end

function cAPI.isPlayingAnimation(dict, anim)
	local ped = PlayerPedId()
	return IsEntityPlayingAnim(ped, dict, anim, 3)
end

function cAPI.clientConnected(bool)
	if bool then
		ShutdownLoadingScreenNui()
		ShutdownLoadingScreen()
	end
end

function cAPI.notify(_message)
	local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
	SetTextScale(0.25, 0.25)
	SetTextCentre(1)
	Citizen.InvokeNative(0xFA233F8FE190514C, str)
	Citizen.InvokeNative(0xE9990552DEC71600)
end

function cAPI.DrawText(str, x, y, w, h, enableShadow, r, g, b, a, centre, font)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	SetTextScale(w, h)
	SetTextColor(math.floor(r), math.floor(g), math.floor(b), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, font)
	DisplayText(str, x, y)
end

function cAPI.Temperatura()
	local _source = source
	local ent = GetPlayerPed(_source)
	local pp = GetEntityCoords(ent)
	local temperatura = GetTemperatureAtCoords(tonumber(pp.x), tonumber(pp.y), tonumber(pp.z))
	local vida = GetEntityHealth(PlayerPedId())
	if vida <= 5 then
		-- print('chegou')
	else
		if temperatura < -5 then
			Wait(5000)
			Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "Cold_Stamina", 1, -1)
			local pl = Citizen.InvokeNative(0x217E9DC48139933D)
			local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
			Citizen.InvokeNative(0x697157CED63F18D4, ped, 5, false, true, true)
			print("está muito frio")
		else
			Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), "Cold_Stamina", 0, 0)
		end
		if temperatura > 40 then
			Wait(5000)
			local pl = Citizen.InvokeNative(0x217E9DC48139933D)
			local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
			Citizen.InvokeNative(0x697157CED63F18D4, ped, 5, false, true, true)
			print("está muito calor")
		end
	end
end

function cAPI.LoadModel(hash)
	local waiting = 0
	while not HasModelLoaded(hash) do
		waiting = waiting + 100
		Citizen.Wait(100)
		if waiting > 100 then
			RequestModel(hash)
			break
		end
	end
	return true
end

function cAPI.varyHealth(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped) + variation)
	Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, n)
end

function cAPI.varyStamina(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped) + variation)
	Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, n)
end

function cAPI.varyEye(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped) + variation)
	Citizen.InvokeNative(0xC6258F41D86676E0, ped, 2, n)
end

function cAPI.StartFade(timer)
	DoScreenFadeOut(timer)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function cAPI.EndFade(timer)
	ShutdownLoadingScreen()
	DoScreenFadeIn(timer)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

function cAPI.CameraWithSpawnEffect(coords)
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
	PointCamAtCoord(cam, coords.x, coords.y, coords.z + 200)
	SetCamActive(cam, true)
	cAPI.EndFade(500)
	RenderScriptCams(true, false, 1, true, true)
	Citizen.Wait(500)
	cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
	PointCamAtCoord(cam3, coords.x, coords.y, coords.z + 200)
	SetCamActiveWithInterp(cam3, cam, 3900, true, true)
	Citizen.Wait(3900)
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
	PointCamAtCoord(cam2, coords.x, coords.y, coords.z + 2)
	SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
	RenderScriptCams(false, true, 500, true, true)
	SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z + 0.5)
	Citizen.Wait(500)
	Citizen.Wait(3000)
	DestroyAllCams(true)
end
