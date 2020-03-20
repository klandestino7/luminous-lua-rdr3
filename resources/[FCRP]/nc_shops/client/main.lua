local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Tunnel.getInterface('API')
cAPI = Proxy.getInterface('API')

local hasAlreadyEnteredMarker, lastZone
local currentAction, currentActionMsg, currentActionData = nil, nil, {}


function OpenShopMenu(zone)
	local elements = {}
	
	SetNuiFocus(true, true)
	SendNUIMessage({
		display = true,
	})
	for i=1, #Config.Zones[zone].Items, 1 do
		local item = Config.Zones[zone].Items[i]
		SendNUIMessage({
			itemLabel = item.itemName,
			item =  item.itemId,
			level =  item.level,
			price =  item.money,
			imglink =  item.imglink,
			zone =  zone
		})
	end
end

AddEventHandler('nc_shops:hasEnteredMarker', function(zone)
	currentAction     = 'shop_menu'
	currentActionMsg  = 'press_menu'
	currentActionData = {zone = zone}
end)

AddEventHandler('nc_shops:hasExitedMarker', function(zone)
	SendNUIMessage({
		display = false,
		clear = true
	})

	currentAction = false

	SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(1, 177) then
			SendNUIMessage({
				display = false,
				clear = true
			})
			currentAction = false

			SetNuiFocus(false, false)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		for i = 1, #v.Pos, 1 do
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
			SetBlipSprite (blip, 59)
			SetBlipScale  (blip, 0.7)
			SetBlipColour (blip, 2)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName('shops')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, false

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true)

				if distance < Config.DrawDistance then
					letSleep = false

					if distance < Config.Size.x then
						isInMarker  = true
						currentZone = k
						lastZone    = k
					end
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('nc_shops:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('nc_shops:hasExitedMarker', lastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if currentAction then
			--ESX.ShowHelpNotification(currentActionMsg)

			if IsControlJustReleased(0, 38) then
				if currentAction == 'shop_menu' then
					OpenShopMenu(currentActionData.zone)
				end

				currentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNUICallback('buyItem', function(data, cb)
	TriggerServerEvent('nc_shops:buyItem', data.item, 1, data.zone)
end)

RegisterNUICallback('focusOff', function(data, cb)
	SetNuiFocus(false, false)
end)