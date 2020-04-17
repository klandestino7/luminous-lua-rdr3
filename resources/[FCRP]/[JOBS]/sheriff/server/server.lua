local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- RegisterServerEvent('FRP:SHERIFF:checkjob')
-- AddEventHandler('FRP:SHERIFF:checkjob', function()
-- 	local _source = source
-- 	local User = API.getUserFromSource(_source)
-- 	local Character = User:getCharacter()	
-- 	local job = Character:hasGroup('police')		

-- 	if job then
		
-- 	else
-- 		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
-- 	end 
-- end)


RegisterServerEvent('FRP:SHERIFF:checkjob')
AddEventHandler('FRP:SHERIFF:checkjob', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local police = Character:hasGroup('police')		
	local sheriff = Character:hasGroup('sheriff')		

	if police then
		TriggerClientEvent('FRP:SHERIFF:PoliceCheck', _source, police)
	end
	if sheriff then
		TriggerClientEvent('FRP:SHERIFF:SheriffCheck', _source, sheriff)
	end
end)



RegisterServerEvent('FRP:SHERIFF:soltar')
AddEventHandler('FRP:SHERIFF:soltar', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local policejob = Character:hasGroup('police')		

	--TriggerClientEvent('FRP:SHERIFF:result', _source, policejob)	

	local policejob = Character:hasGroup('police')	
	if policejob == false then
		TriggerEvent('FRP:SHERIFF:soltar', target)
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
		TriggerClientEvent('FRP:SHERIFF:playercheck', source)
		--xPlayer.removeInventoryItem('handcuffs', 1)
	--	else
	--	 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
	--	end 
	end)
end)


RegisterServerEvent('FRP:SHERIFF:puting')
AddEventHandler('FRP:SHERIFF:puting', function(target)

  TriggerClientEvent('FRP:SHERIFF:vehiclep', target)
 --TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
 -- TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
end)

RegisterServerEvent('FRP:SHERIFF:outing')
AddEventHandler('FRP:SHERIFF:outing', function(target)

  TriggerClientEvent('FRP:SHERIFF:vehicleout', target)
end)

RegisterServerEvent('FRP:SHERIFF:putInVehicle')
AddEventHandler('FRP:SHERIFF:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		
	else
		print(('FRP:SHERIFF: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterCommand('testservjob', function(source)
	TriggerEvent('FRP:SHERIFF:checkjob', source)
end)


RegisterServerEvent('FRP:SHERIFF:cuffing')
AddEventHandler('FRP:SHERIFF:cuffing', function(source)

  TriggerClientEvent('FRP:SHERIFF:cuff', source)
 --TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
  --TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
end)


RegisterServerEvent('FRP:SHERIFF:unlocking')
AddEventHandler('FRP:SHERIFF:unlocking', function(source)
  TriggerClientEvent('FRP:SHERIFF:uncuff', source)
  
end)

RegisterServerEvent('FRP:SHERIFF:soltar')
AddEventHandler('FRP:SHERIFF:soltar', function(target)
	TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)  	
end) 

RegisterCommand('soltar', function(target)
	TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
		--xPlayer.removeInventoryItem('handcuffs', 1)  
end)
	

	RegisterServerEvent('FRP:SHERIFF:unlocking')
AddEventHandler('FRP:SHERIFF:unlocking', function(source)

  TriggerClientEvent('FRP:SHERIFF:uncuff', source)
  TriggerClientEvent("ic_sound:source",source,'uncuff',0.1)   

end)




-- RegisterCommand('prender', function(source)
-- 	local _source = source
-- 	local User = API.getUserFromSource(source)
-- 	local Character = User:getCharacter()	

-- 	handcuffs = false
-- 		local policejob = Character:hasGroup('police')
-- 		if policejob == true then			
-- 			TriggerClientEvent('FRP:SHERIFF:cuffcheck', source)
-- 			handcuffs = true
-- 		else
-- 			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial') 
-- 		end 
-- 		if handcuffs == true then
-- 			TriggerEvent('FRP:SHERIFF:prender', target)
-- 		end
-- end)


-- RegisterServerEvent('FRP:SHERIFF:checkjob')
-- AddEventHandler('FRP:SHERIFF:checkjob', function(source, playerjob)
-- local _source = source

-- TriggerEvent("redemrp:getPlayerFromId", _source, function(user)

-- 	playerjob = user.getJob()

-- 	TriggerClientEvent('FRP:SHERIFF:checkjob', _source, playerjob)
-- 	end)
-- end)



-- RegisterServerEvent('FRP:SHERIFF:soltar')
-- AddEventHandler('FRP:SHERIFF:prender', function(target)
-- 	TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
-- end)

-- RegisterCommand('soltar', function(target)

-- 	TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)  
-- end)


-- RegisterServerEvent('FRP:SHERIFF:remove')
-- AddEventHandler('FRP:SHERIFF:remove', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)
-- end)
-- end)

-- RegisterServerEvent('FRP:SHERIFF:give')
-- AddEventHandler('FRP:SHERIFF:give', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.addInventoryItem('handcuffs', 1)
-- end)
-- end)



--  --[[
-- ESX.RegisterUsableItem('key', function(target)	
--     TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
--     --TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)    
--  --   TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)

-- end)]]

-- --[[
-- ESX.RegisterUsableItem('blowpipe', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(target)	
-- 	TriggerClientEvent('FRP:SHERIFF:unlockingcuffs', source)
-- 	xPlayer.removeInventoryItem('blowpipe', 1)
-- end) ]]






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

