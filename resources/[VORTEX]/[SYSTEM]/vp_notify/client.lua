RegisterNetEvent("VP:NOTIFY:Toast")
AddEventHandler("VP:NOTIFY:Toast",function(icon,title,mensagem)
	--SendNUIMessage({ css = css, mensagem = mensagem })	
	if icon == "alert" then
		exports['vp_notify']:DisplayLeftNotification(title,
		mensagem,
		'HUD_TOASTS',
		'toast_mp_status_change',
		10000)	
	end

	if icon == "verify" then
		exports['vp_notify']:DisplayLeftNotification(title,
		mensagem,
		'generic_textures',
		'tick',
		10000)	
	end

	if icon == "locked" then
		exports['vp_notify']:DisplayLeftNotification(title,
		mensagem,
		'menu_textures',
		'stamp_locked_rank',
		10000)	
	end

	if icon == "star" then
		exports['vp_notify']:DisplayLeftNotification(title,
		mensagem,
		'generic_textures',
		'star',
		10000)	
	end	
	
	if icon == "horse" then
		exports['vp_notify']:DisplayLeftNotification(title,
		mensagem,
		'HUD_TOASTS',
		'toast_horse_bond',
		10000)	
	end
end)

RegisterNetEvent("VP:NOTIFY:Simple")
AddEventHandler("VP:NOTIFY:Simple",function(mensagem, time)
	SendNUIMessage({ css = 'sucesso', mensagem = mensagem, time =  time })
	exports['vp_notify']:DisplayLocationNotification(text,locale,10000)	
end)

RegisterCommand('enviar', function()
	local player = (GetEntityCoords(PlayerPedId()))
--	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(player.x, player.y, player.z))
--	local zonehash = GetNameOfZone(player.x, player.y, player.z)
--	local zonenome = tostring(nome.zonehash)
--	local num = GetZoneAtCoords(player.x, player.y, player.z)
--	local ruas = street .. " Nº" .. num .. ", " .. nome[zonehash]
	TriggerEvent('VP:NOTIFY:Simple', 'Aqui é Blackwater, a primeira cidade na qual você vai conhecer. Nela você poderá encontrar diversas lojas de departamento, como a loja de roupas, cabeleireiro, departamento de polícia, entre outros. Mas lembre-se de que há um mundo imenso para você explorar!', 18000)
	Wait(10000)
--	TriggerEvent('VP:NOTIFY:Toast','star', 'Roubo', 'Assalto a Joalheria')
--	TriggerEvent('blipALERTRED', player)

end)

RegisterNetEvent('blipALERTRED')
AddEventHandler('blipALERTRED', function(targetCoords)
	--if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 160.0)

		SetBlipHighDetail(gunshotBlip, true)
		SetBlipSprite (gunshotBlip, 10)
		SetBlipColour (gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(50 * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)
			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	--end
end)