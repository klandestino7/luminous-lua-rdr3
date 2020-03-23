RegisterNetEvent("Distress")
AddEventHandler("Distress",function(css,mensagem)
	SendNUIMessage({ css = css, mensagem = mensagem })
end)


RegisterCommand('enviar', function()
	local player = (GetEntityCoords(PlayerPedId()))
--	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(player.x, player.y, player.z))
--	local zonehash = GetNameOfZone(player.x, player.y, player.z)
--	local zonenome = tostring(nome.zonehash)
--	local num = GetZoneAtCoords(player.x, player.y, player.z)
--	local ruas = street .. " Nº" .. num .. ", " .. nome[zonehash]
	TriggerEvent('Distress', 'sucesso', 'Assalto a Joalheria')
--	TriggerEvent('blipALERTRED', player)

	--PlaySound(-1, "Team_Vehicle_Destroyed", "DLC_LOW2_Sumo_Soundset", 0, 0, 1);
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