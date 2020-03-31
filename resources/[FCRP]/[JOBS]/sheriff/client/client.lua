
keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
	['G'] = 0x5415BE48,
	['E'] = 0xDFF812F9
}

local job = {}
---------------------------
-- POLICE MANAGEMENT API --
---------------------------


--[[Citizen.CreateThread(function()
	Wait(0)
	for k,v in pairs(Config.Coords) do
		Citizen.InvokeNative(0x554d9d53f696d002, -1595050198, v)
	end
end)]]
 



Citizen.CreateThread(function()
		WarMenu.CreateMenu('OfficerMenu', 'Painel do Oficial')
		WarMenu.SetSubTitle('OfficerMenu', 'Opções')
		WarMenu.CreateSubMenu('Armored', 'OfficerMenu', 'Armamento')
		WarMenu.CreateSubMenu('vehicle', 'OfficerMenu', 'Transporte.')
      while true do		
  		Citizen.Wait(0)
  		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
  		if WarMenu.IsMenuOpened('OfficerMenu') then
			if WarMenu.MenuButton('Armas', 'Armored') then 	end	
			if WarMenu.MenuButton('Transportes', 'vehicle') then 	end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('Armored') then 
			if WarMenu.Button('Pistola Mauser') then
				TriggerEvent('give:weapon', 'WEAPON_PISTOL_MAUSER')
			elseif WarMenu.Button('Bolt action rifle') then
				TriggerEvent('give:weapon', 'WEAPON_RIFLE_BOLTACTION')
			elseif WarMenu.Button('Pump shotgun') then
				TriggerEvent('give:weapon', 'WEAPON_SHOTGUN_PUMP')
			end
				WarMenu.Display()
		elseif WarMenu.IsMenuOpened('vehicle') then 
			if WarMenu.Button('Carroça 2') then
				SpawnVehicle('POLICEWAGON01X', GetPlayerPed())
			elseif WarMenu.Button('Carroça Cela') then
				SpawnVehicle('WAGONPRISON01X', GetPlayerPed())
			elseif WarMenu.Button('Carrça Carga') then
				SpawnVehicle('supplywagon', GetPlayerPed())
			end
				WarMenu.Display()
		end
	end
end)

Citizen.CreateThread(function()
      while true do		
  		Citizen.Wait(0)
	  	local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
	for k,v in pairs(Config.DVCoords) do


			if Vdist(coords, v) < 2 then
				DrawTxt("Aperte [S] para guardar o veículo", 0.30, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
				if IsControlJustReleased(0, keys['S']) then
					local playerPed = PlayerPedId()
				    local vehicle   = GetVehiclePedIsIn(playerPed, false)

				    if IsPedInAnyVehicle(playerPed, true) then
				        vehicle = GetVehiclePedIsIn(playerPed, false)
				    end

				    if DoesEntityExist(vehicle) then
				        DeleteVehicle(vehicle)
				    end

				end
			end	
		end
	end
end)

RegisterNetEvent('sheriff:openmenu')
AddEventHandler('sheriff:openmenu', function()
	  	local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
	for k,v in pairs(Config.Coords) do
		if Vdist(coords, v) < 10 then
			--	DrawTxt("Aperte [S] para guardar o veículo", 0.30, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
			WarMenu.OpenMenu('OfficerMenu')
		end
	end
end)



RegisterNetEvent('sheriff:checkjob')
AddEventHandler('sheriff:checkjob', function(playerjob)	
local playerPed = PlayerPedId()	
local _source = source
local job = playerjob

	print(job)

end)


function SpawnVehicle(Vmodel,ply)
    local veh = GetHashKey(Vmodel)
    local coords = GetEntityCoords(ply)
    local head = "0.77"
    Citizen.CreateThread(function()
        RequestModel(veh)
        while not HasModelLoaded(veh) do
            Wait(1000)
            print("Loading Model: "..Vmodel.."Loading Hash: "..veh)
        end
        if HasModelLoaded(veh) then
            local car = CreateVehicle(veh,coords.x+2,coords.y+2,coords.z,head,true,true,false,true)
            print("Model spawned Succes: "..Vmodel)
        end
    end)
end

RegisterNetEvent('give:weapon')
AddEventHandler('give:weapon', function(weapon)
    Citizen.CreateThread(function()
        local weapon = GetHashKey(weapon)
		local playerPed = PlayerPedId()
        Wait(1000)
		GiveDelayedWeaponToPed(playerPed, weapon, 100, true, 2)
    end)
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end


-- Variables
local handcuffed = false
local officer = -1
local id = 'This user did not set their ID!'



RegisterNetEvent('sheriff:unrestrain')
AddEventHandler('sheriff:unrestrain', function()
	if Handcuffed then
		local playerPed = PlayerPedId()
		
		Handcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

	end
end)



------------------------------------------------------------------------
-- ALGEMAS E CHAVES
------------------------------------------------------------------------


RegisterCommand('handclear', function(source)
     ped = GetPlayerPed(-1)
     local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")
        ClearPedTasks(ped)
        SetEnableHandcuffs(ped, false)
        UncuffPed(ped)

        --[[
        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end ]]

end)


-- Locals
local cuffed = false
local dict = "TASK_ARREST_PED"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_female")
local maleHash = GetHashKey("mp_male")
local IsLockpicking    = false
local handcuffed = false


RegisterNetEvent('sheriff:vehiclep')
AddEventHandler('sheriff:vehiclep', function()
	local coords    = GetEntityCoords(PlayerPedId())
 	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end
			if freeSeat ~= nil then
					SetPedIntoVehicle(PlayerPedId(), vehicle, 2)
				TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Você foi colocado dentro do veículo')
				--DragStatus.IsDragged = false
			end
		end
	end
end)


RegisterNetEvent('sheriff:playercheck')
AddEventHandler('sheriff:playercheck', function()

  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
	  	if player == handcuffed then
	  		--TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
	  	else
	    	TriggerServerEvent('sheriff:puting', GetPlayerServerId(player))
		end
	else
		--TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')

  end
end)

RegisterCommand('algema', function(source, args, rawCommand)

	local hash = args[1]
	local model2 = GetHashKey(tonumber(hash))
	
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
	end
	
	Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  tonumber(hash), true, true, true)	
end)

-- Sätt på handklovar
RegisterNetEvent('sheriff:cuff')
AddEventHandler('sheriff:cuff', function()
    ped = GetPlayerPed(-1)
	ped2 = PlayerPedId()
	
	-- 	if GetEntityModel(ped) == femaleHash then

	-- 		Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  tonumber(hash), true, true, true)

    --       --  prevFemaleVariation = GetPedDrawableVariation(ped, 7)
    --         SetPedComponentVariation(ped, 7, 25, 0, 0)
    --     elseif GetEntityModel(ped) == maleHash then
    --   --      prevMaleVariation = GetPedDrawableVariation(ped, 7)
    --         SetPedComponentVariation(ped, 7, 41, 0, 0)
    --     end 

        SetEnableHandcuffs(ped2, true)

    handcuffed = true
    cuffed = not cuffed
    changed = true
end)


RegisterNetEvent('sheriff:uncuff')
AddEventHandler('sheriff:uncuff', function()
    ped = GetPlayerPed(-1)
    ped2 = PlayerPedId()  


     	ClearPedTasks(ped)
        SetEnableHandcuffs(ped2, false)
		UncuffPed(ped2)
		
        --[[
        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end ]]

    cuffed = not cuffed
    handcuffed = false
    changed = true
end)

RegisterNetEvent('sheriff:cuffcheck')
AddEventHandler('sheriff:cuffcheck', function()
  local player, distance = GetClosestPlayer()
  if distance ~= -1 and distance <= 3.0 then   
  	if PlayerPedId() == handcuffed == true then
	 	TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Já está algemado.')
	else
		TriggerServerEvent('sheriff:cuffing', GetPlayerServerId(player))
	end
    	TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Você Algemou. (' .. GetPlayerName(player) .. ')')
  else
  --  TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

RegisterNetEvent('sheriff:nyckelcheck')
AddEventHandler('sheriff:nyckelcheck', function()    
    ped1 = GetClosestPlayer()
    local player, distance = GetClosestPlayer()
    local players = GetPlayerServerId(source)
    if distance ~= -1 and distance <= 3.0 then
			TriggerServerEvent('sheriff:unlocking', GetPlayerServerId(player))
			TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Você soltou. (' .. GetPlayerName(player) .. ')')
			print('passou aqui uncuff')
        else
        --    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem próximo está algemado')            
        end
end)

RegisterNetEvent('sheriff:unlockingcuffs')
AddEventHandler('sheriff:unlockingcuffs', function()
  local player, distance = GetClosestPlayer()
	local ped = GetPlayerPed(-1)

	if IsLockpicking == false then
		FreezeEntityPosition(player,  true)
		FreezeEntityPosition(ped,  true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
		IsLockpicking = true
		Wait(30000)
		IsLockpicking = false
		FreezeEntityPosition(player,  false)
		FreezeEntityPosition(ped,  false)
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('sheriff:unlocking', GetPlayerServerId(player))
        TriggerEvent("fc_notify:start", "Algemas quebradas" , 5, "success")
	else
        TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, '"Você já está quebrando as algemas') 
	end
end)

-- ??
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not changed then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped)
            if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(0)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        else
            changed = false
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = PlayerPedId()
        if cuffed then
			DisableControlAction(0, 0x8FFC75D6, true) -- SHIFT
			DisableControlAction(0, 0xD9D0E1C0, true) -- espaço
        end
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = PlayerPedId()
        if IsControlJustPressed(2, 0xE8342FF2) then -- Hold ALT      
			TriggerServerEvent('sheriff:checkjob')
		end
    end
end)

-- RegisterNetEvent('sheriff:result')
-- AddEventHandler('sheriff:result', function(value)    
-- 	print(value)
-- end)

------------------------------------------------------------------------
-- ALGEMAS E CHAVES
------------------------------------------------------------------------


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






RegisterCommand('drag', function(source, args, rawCommand)
		closestPlayer, closestdistance = GetClosestPlayer()
		if closest ~= nil and DoesEntityExist(GetPlayerPed(closestPlayer)) then
			if closestdistance -1 and closestdistance < 3 then
				local closestID = GetPlayerServerId(closestPlayer)
				TriggerEvent('chatMessage', 'Police System', {255, 255, 255}, 'You are dragging the nearest player. (' .. GetPlayerName(closestPlayer) .. ')')
				TriggerServerEvent('dragServer', closestID)
			else
				TriggerEvent('chatMessage', 'Police System', {255, 255, 255}, 'Nearest player is too far away')
			end
		end
end)

RegisterCommand('undrag', function()
		closest, distance = GetClosestPlayer()
		if closest ~= nil and DoesEntityExist(GetPlayerPed(closest)) then
			if distance -1 and distance < 3 then
				TriggerEvent('chatMessage', 'Police System', {255, 255, 255}, 'You are no longer dragging the nearest player. (' .. GetPlayerName(closest) .. ')')
				local closestID = GetPlayerServerId(closest)
				TriggerServerEvent('unDragServer', closestID)
			else
				TriggerEvent('chatMessage', 'Police System', {255, 255, 255}, 'Nearest player is too far away')
			end
		end
end)


RegisterNetEvent('dragClient')
AddEventHandler('dragClient', function(closestID)
	local officer = GetClosestPlayer()
	local officerPed = GetPlayerPed(GetPlayerFromServerId(officer))
	local pP = GetPlayerPed(-1)
	drag = true
	if handcuffed == true then
		while drag == true do
			Citizen.Wait(0)
			if IsPedDeadOrDying then
				drag = false
			end
			AttachEntityToEntity(pP, officerPed, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		end
	end
end)

RegisterNetEvent('unDragClient')
AddEventHandler('unDragClient', function(closestID)
	local pP = GetPlayerPed(-1)
	drag = false
	DetachEntity(pP, true, false)
end)

RegisterNetEvent('putInClient')
AddEventHandler('putInClient', function(closestID, veh)
	local pP = GetPlayerPed(-1)
	local pos = GetEntityCoords(pP)
	local entityWorld = GetOffsetFromEntityInWorldCoords(pP, 0.0, 20.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	if vehicleHandle ~= nil then
		SetPedIntoVehicle(pP, vehicleHandle, 1)
	end
end)

RegisterNetEvent('showIDClient')
AddEventHandler('showIDClient', function()
	TriggerEvent('chatMessage', 'ID', {255, 255, 255}, GetPlayerName(sourceID) .. ' has showed you their ID.')
end)



function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end