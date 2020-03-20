local IsJailed = false
local unjail = false
local JailTime = 0
local fastTimer = 0
local JailLocation = 3372.48, -667.09, 46.41



RegisterNetEvent('fc_jail:jail')
AddEventHandler('fc_jail:jail', function(jailTime)
	if IsJailed then -- don't allow multiple jails
		return
	end

	JailTime = jailTime
	local playerPed = PlayerPedId()
	if DoesEntityExist(playerPed) then
		Citizen.CreateThread(function()
			local pP = PlayerPedId()
			local entity = GetPlayerPed()
			local pedplayer = GetEntityModel(entity)
    		local maleped = -171876066			
			print(tostring(pedplayer))	
			-- Assign jail skin to user		
				if pedplayer == maleped then
					--print('HOMEM SKIN')						
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x5BA76CCF,true,true,true) -- CAMISA	
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x216612F0,true,true,true) -- CALÇA
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0xF082E23A,true,true,true) -- SAPATO		
				else
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x10F5497A,true,true,true) -- PANTS
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x14511493,true,true,true) -- COAT
					--print('MULHER SKIN')
				end
			-- Clear player
			--SetPedArmour(playerPed, 0)
			--ClearPedBloodDamage(playerPed)
			--ResetPedVisibleDamage(playerPed)
			--ClearPedLastWeaponDamage(playerPed)
			--ResetPedMovementClipset(playerPed, 0)
			
			print(playerPed)
			SetEntityCoords(playerPed,  3372.48, -667.09, 46.41)

			IsJailed = true
			unjail = false

			while JailTime > 0 and not unjail do
				playerPed = PlayerPedId()
				SetEntityInvincible(PlayerPed, false)
				RemoveAllPedWeapons(playerPed, true)
				if IsPedInAnyVehicle(playerPed, false) then
					ClearPedTasksImmediately(playerPed)
				end
				if JailTime % 100 == 0 then
					TriggerServerEvent('fc_jail:updateRemaining', JailTime)
				end
				Citizen.Wait(20000)
				-- Is the player trying to escape?
				if Vdist(GetEntityCoords(playerPed), 3372.48, -667.09, 46.41) > 70 then
					SetEntityCoords(playerPed, 3372.48, -667.09, 46.41)
					TriggerEvent('chat:addMessage', { args = { _U('judge'), _U('escape_attempt') }, color = { 147, 196, 109 } })
				end				
				JailTime = JailTime - 20
			end

			-- jail time served
			TriggerServerEvent('fc_jail:unjailTime', -1)
			SetEntityCoords(playerPed, Config.JailBlip)
			IsJailed = false
			-- Change back the user skin
		--	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		--		TriggerEvent('skinchanger:loadSkin', skin)
		--	end)
		end)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if JailTime > 0 and IsJailed then
			if fastTimer < 0 then
				fastTimer = JailTime
			end
	--	DrawTxt(Config.LocaleTimer .. " " .. tonumber(string.format("%.0f", (((GetGameTimer() - timer) * -1)/1000))), 0.50, 0.80, 0.7, 0.7, true, 255, 255, 255, 255, true) 
			
			DrawTxt('Ainda falta ' .. tonumber(string.format("%.0f",fastTimer)) .. ' segundos para você ser libertado.', 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
			--draw2dText('Restam', tonumber(fastTimer)), { 0.175, 0.955 } )
			fastTimer = fastTimer - 0.01

		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('fc_jail:unjail')
AddEventHandler('fc_jail:unjail', function(source)
	unjail = true
	JailTime = 0
	fastTimer = 0
	local playerPed = PlayerPedId()
	SetEntityInvincible(PlayerPed, false)
	SetEntityCoords(playerPed, 2929.51, -1252.1, 42.28)
	Citizen.Wait(1000)
	TriggerServerEvent("redemrp_clothing:loadClothes", 1, function(cb)
	end)
end)

-- When player respawns / joins
AddEventHandler('playerSpawned', function(spawn)
	if IsJailed then
		SetEntityCoords(PlayerPedId(), JailLocation)
	else
		TriggerServerEvent('fc_jail:checkJail')
	end
end)

-- When script starts
Citizen.CreateThread(function()
	Citizen.Wait(2000) -- wait for mysql-async to be ready, this should be enough time
	TriggerServerEvent('fc_jail:checkJail')
end)


--[[
Citizen.CreateThread(function()
	Wait(0)
	for k,v in pairs(Config.JailBlip) do
		Citizen.InvokeNative(0x554d9d53f696d002, 168093330, v)
	end
end) ]]

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end


