local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('sheriff:checkjob')
AddEventHandler('sheriff:checkjob', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local policejob = Character:hasGroup('police')		

	--TriggerClientEvent('sheriff:result', _source, policejob)	

	local policejob = Character:hasGroup('police')	
	if policejob == false then
		TriggerClientEvent('sheriff:cuffcheck', source)
	else
		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
	end 
end)


RegisterServerEvent('sheriff:soltar')
AddEventHandler('sheriff:soltar', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local policejob = Character:hasGroup('police')		

	--TriggerClientEvent('sheriff:result', _source, policejob)	

	local policejob = Character:hasGroup('police')	
	if policejob == false then
		TriggerEvent('sheriff:soltar', target)
	else
		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
	end 
end)


-- RegisterCommand('prender', function(source, args)
-- 	local source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", source, function(user)
-- 		local policejob = user.getJob()
-- 	if policejob == 'police' then
-- 	if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
-- 		TriggerEvent('fc_jail:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
-- 	else
-- 		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ID ou Tempo Inválido!' } } )
-- 	end
-- 	else
-- 		 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
-- 		end 
-- 	end)
-- end)


RegisterCommand('colocar', function(source)
	local source = source
	TriggerEvent("redemrp:getPlayerFromId", source, function(user)
		local policejob = user.getJob()
	--	if policejob == 'police' then
		TriggerClientEvent('sheriff:playercheck', source)
		--xPlayer.removeInventoryItem('handcuffs', 1)
	--	else
	--	 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
	--	end 
	end)
end)


RegisterServerEvent('sheriff:puting')
AddEventHandler('sheriff:puting', function(target)

  TriggerClientEvent('sheriff:vehiclep', target)
 --TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
 -- TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
end)



RegisterServerEvent('sheriff:putInVehicle')
AddEventHandler('sheriff:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		
	else
		print(('sheriff: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)



RegisterCommand('menupolice', function(source)
	local _source = source

	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
		local policejob = user.getJob()
		if policejob == 'police' then
			TriggerClientEvent('sheriff:openmenu', _source)
		else
		 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
		end 
	end)
end)


RegisterCommand('testservjob', function(source)
	TriggerEvent('sheriff:checkjob', source)
end)



-- RegisterCommand('prender', function(source)
-- 	local _source = source
-- 	local User = API.getUserFromSource(source)
-- 	local Character = User:getCharacter()	

-- 	handcuffs = false
-- 		local policejob = Character:hasGroup('police')
-- 		if policejob == true then			
-- 			TriggerClientEvent('sheriff:cuffcheck', source)
-- 			handcuffs = true
-- 		else
-- 			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
-- 		end 
-- 		if handcuffs == true then
-- 			TriggerEvent('sheriff:prender', target)
-- 		end
-- end)


-- RegisterServerEvent('sheriff:checkjob')
-- AddEventHandler('sheriff:checkjob', function(source, playerjob)
-- local _source = source

-- TriggerEvent("redemrp:getPlayerFromId", _source, function(user)

-- 	playerjob = user.getJob()

-- 	TriggerClientEvent('sheriff:checkjob', _source, playerjob)
-- 	end)
-- end)



-- RegisterServerEvent('sheriff:soltar')
-- AddEventHandler('sheriff:prender', function(target)
-- 	TriggerClientEvent('sheriff:nyckelcheck', target)
-- end)

-- RegisterCommand('soltar', function(target)

-- 	TriggerClientEvent('sheriff:nyckelcheck', target)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)  
-- end)


-- RegisterServerEvent('sheriff:remove')
-- AddEventHandler('sheriff:remove', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)
-- end)
-- end)

-- RegisterServerEvent('sheriff:give')
-- AddEventHandler('sheriff:give', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.addInventoryItem('handcuffs', 1)
-- end)
-- end)


-- RegisterServerEvent('sheriff:cuffing')
-- AddEventHandler('sheriff:cuffing', function(source)

--   TriggerClientEvent('sheriff:cuff', source)
--  --TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
--   TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
-- end)

--  --[[
-- ESX.RegisterUsableItem('key', function(target)	
--     TriggerClientEvent('sheriff:nyckelcheck', target)
--     --TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)    
--  --   TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)

-- end)]]

-- --[[
-- ESX.RegisterUsableItem('blowpipe', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(target)	
-- 	TriggerClientEvent('sheriff:unlockingcuffs', source)
-- 	xPlayer.removeInventoryItem('blowpipe', 1)
-- end) ]]

-- RegisterServerEvent('sheriff:unlocking')
-- AddEventHandler('sheriff:unlocking', function(source)

--   TriggerClientEvent('sheriff:uncuff', source)
--   --TriggerClientEvent("ic_sound:source",source,'uncuff',0.1)   
--   -- 	local xPlayer = ESX.GetPlayerFromId(target)
-- 	--xPlayer.addInventoryItem('handcuffs', 1)

-- end)






-- RegisterServerEvent('dragServer')
-- AddEventHandler('dragServer', function(closestID)
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 		if user.getGroup() == "admin" then
-- 			TriggerClientEvent('dragClient', closestID, source)
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('unDragServer')
-- AddEventHandler('unDragServer', function(closestID)
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 		if user.getGroup() == "admin" then
-- 			TriggerClientEvent('unDragClient', closestID)
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('putInServer')
-- AddEventHandler('putInServer', function(closestID)
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 		if user.getGroup() == "admin" then
-- 			TriggerClientEvent('putInClient', closestID)
-- 		end
-- 	end)
-- end)

