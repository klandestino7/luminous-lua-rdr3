RegisterNetEvent("Distress")
AddEventHandler("Distress",function(css,title,mensagem,position)
	SendNUIMessage({ css = css, title = title, mensagem = mensagem, position = position  })
end)

local nome = { DOWNT = 'Downtown',
DTVINE = 'Downtown Vinewood',
AIRP = 'Los Santos International Airport',
ALAMO = 'Alamo Sea',
ALTA = 'Alta',
ARMYB = 'Fort Zancudo',
BANHAMC = 'Banham Canyon Dr',
BANNING = 'Banning',
BEACH = 'Vespucci Beach',
BHAMCA = 'Banham Canyon',
BRADP = 'Braddock Pass',
BRADT = 'Braddock Tunnel',
BURTON = 'Burton',
CALAFB = 'Calafia Bridge',
CANNY = 'Raton Canyon',
CCREAK = 'Cassidy Creek',
CHAMH = 'Chamberlain Hills',
CHIL = 'Vinewood Hills',
CHU = 'Chumash',
CMSW = 'Chiliad Mountain State Wilderness',
CYPRE = 'Cypress Flats',
DAVIS = 'Davis',
DELBE = 'Del Perro Beach',
DELPE = 'Del Perro',
DELSOL = 'La Puerta',
DESRT = 'Grand Senora Desert',
DOWNT = 'Downtown',
DTVINE = 'Downtown Vinewood',
EAST_V = 'East Vinewood',
EBURO = 'El Burro Heights',
ELGORL = 'El Gordo Lighthouse',
ELYSIAN = 'Elysian Island',
GALFISH = 'Galilee',
GOLF = 'GWC and Golfing Society',
GRAPES = 'Grapeseed',
GREATC = 'Great Chaparral',
HARMO = 'Harmony',
HAWICK = 'Hawick',
HORS = 'Vinewood Racetrack',
HUMLAB = 'Humane Labs and Research',
JAIL = 'Bolingbroke Penitentiary',
KOREAT = 'Little Seoul',
LACT = 'Land Act Reservoir',
LAGO = 'Lago Zancudo',
LDAM = 'Land Act Dam',
LEGSQU = 'Legion Square',
LMESA = 'La Mesa',
LOSPUER = 'La Puerta',
MIRR = 'Mirror Park',
MORN = 'Morningwood',
MOVIE = 'Richards Majestic',
MTCHIL = 'Mount Chiliad',
MTGORDO = 'Mount Gordo',
MTJOSE = 'Mount Josiah',
MURRI = 'Murrieta Heights',
NCHU = 'North Chumash',
NOOSE = 'N.O.O.S.E',
OCEANA = 'Pacific Ocean',
PALCOV = 'Paleto Cove',
PALETO = 'Paleto Bay',
PALFOR = 'Paleto Forest',
PALHIGH = 'Palomino Highlands',
PALMPOW = 'Palmer-Taylor Power Station',
PBLUFF = 'Pacific Bluffs',
PBOX = 'Pillbox Hill',
PROCOB = 'Procopio Beach',
RANCHO = 'Rancho',
RGLEN = 'Richman Glen',
RICHM = 'Richman',
ROCKF = 'Rockford Hills',
RTRAK = 'Redwood Lights Track',
SANAND = 'San Andreas',
SANCHIA = 'San Chianski Mountain Range',
SANDY = 'Sandy Shores',
SKID = 'Mission Row',
SLAB = 'Stab City',
STAD = 'Maze Bank Arena',
STRAW = 'Strawberry',
TATAMO = 'Tataviam Mountains',
TERMINA = 'Terminal',
TEXTI = 'Textile City',
TONGVAH = 'Tongva Hills',
TONGVAV = 'Tongva Valley',
VCANA = 'Vespucci Canals',
VESP = 'Vespucci',
VINE = 'Vinewood',
WINDF = 'Ron Alternates Wind Farm',
WVINE = 'West Vinewood',
ZANCUDO = 'Zancudo River',
ZP_ORT = 'Port of South Los Santos',
ZQ_UAR = 'Davis Quartz' }

RegisterCommand('enviar', function()
	local player = (GetEntityCoords(PlayerPedId()))
	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(player.x, player.y, player.z))
	local zonehash = GetNameOfZone(player.x, player.y, player.z)
	local zonenome = tostring(nome.zonehash)
	local num = GetZoneAtCoords(player.x, player.y, player.z)
	local ruas = street .. " Nº" .. num .. ", " .. nome[zonehash]
	TriggerEvent('Distress', 'sucesso2', 'Polícia', 'Assalto a Joalheria', ruas)
	TriggerEvent('blipALERTRED', player)

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


RegisterNetEvent('blipALERTGREEN')
AddEventHandler('blipALERTGREEN', function(targetCoords)
	--if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 160.0)

		SetBlipHighDetail(gunshotBlip, true)
		SetBlipSprite (gunshotBlip, 10)
		SetBlipColour (gunshotBlip, 2)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(50 * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)
			ShowOutlineIndicatorOnBlip(gunshotBlip, true)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	--end
end)
