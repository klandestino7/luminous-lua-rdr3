--Copyright ZAUB1
--N'hesitez pas a rejoindre mon discord : https://discord.gg/yFuSEGj
--Et a me contacter directement pour tout bug ou suggestions

--ESX INIT--


--EVENTS--

-- RegisterServerEvent('VP:DELIVERY:pourboire') --Paie a la livraison d'une pizza + pourboire eventuel
-- AddEventHandler('VP:DELIVERY:pourboire', function(pourboire)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	xPlayer.addMoney(pourboire)
-- end)

-- RegisterServerEvent("VP:DELIVERY:paiefinale") --Paie "bonus" lors de la fin de service
-- AddEventHandler("VP:DELIVERY:paiefinale", function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	local flouzefin = math.random(10, 100)

-- 	xPlayer.addMoney(flouzefin)

-- 	TriggerClientEvent("pNotify:SendNotification", source, {
-- 		text = "Voici votre petit bonus final : " .. flouzefin .. "$",
-- 		type = "success",
-- 		queue = "global",
-- 		timeout = 4000,
-- 		layout = "bottomRight"
-- 	})
-- end)

-- RegisterServerEvent("VP:DELIVERY:itemadd") --Ajout temporaire de l'item "pizza"
-- AddEventHandler("VP:DELIVERY:itemadd", function(nbPizza)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	xPlayer.addInventoryItem('pizza', tonumber(nbPizza))
-- end)

-- RegisterServerEvent("VP:DELIVERY:itemrm") --Rm de l'item "pizza"
-- AddEventHandler("VP:DELIVERY:itemrm", function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	xPlayer.removeInventoryItem('pizza', 1)
-- end)

-- RegisterServerEvent("VP:DELIVERY:deleteAllPizz") --Rm de l'item "pizza"
-- AddEventHandler("VP:DELIVERY:deleteAllPizz", function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
		
-- 	local pizzanbr = xPlayer.getInventoryItem('pizza').count
	
-- 	xPlayer.removeInventoryItem('pizza', pizzanbr)
-- end)
