
local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- -- jail command
-- TriggerEvent('redem:addGroupCommand', 'jail1', 'admin', function(source, args, user)	


-- 	if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
-- 		TriggerEvent('fc_jail:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
-- 	else
-- 		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ID ou Tempo Inválido!' } } )
-- 	end


-- end, function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
-- end, {help = "Put a player in jail", params = {{name = "id", help = "target id"}, {name = "time", help = "jail time in minutes"}}})



RegisterCommand(
    "jail",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") and args[1] then
            local tplayer = API.getUserSource(parseInt(args[1]))
            if tplayer then
                TriggerEvent('fc_jail:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
            end
        end
    end
)


-- -- unjail
-- TriggerEvent('redem:addGroupCommand', 'unjail', 'admin', function(source, args, user)
-- 	if args[1] then
-- 		if GetPlayerName(args[1]) ~= nil then
-- 			TriggerEvent('fc_jail:unjailQuest', tonumber(args[1]))
-- 		else
-- 			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID!' } } )
-- 		end
-- 	else
-- 		TriggerEvent('fc_jail:unjailQuest', source)
-- 	end
-- end, function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
-- end, {help = "Unjail people from jail", params = {{name = "id", help = "target id"}}})




-- send to jail and register in database
RegisterServerEvent('fc_jail:sendToJail')
AddEventHandler('fc_jail:sendToJail', function(target, jailTime)
	local _source = source -- cannot parse source to client trigger for some weird reason
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()		
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier
	local nome = Character:getName()

--	TriggerClientEvent('chat:addMessage', -1, { args = { 'JUSTIÇA', nome.. ' está agora preso por '.. jailTime ..' minutos', GetPlayerName(_source), tonumber(jailTime / 60) }, color = { 147, 196, 109 } })
--	TriggerClientEvent('esx_policejob:unrestrain', target)
	print(jailTime)	
	TriggerClientEvent('fc_jail:jail', target, jailTime)
end)






-- should the player be in jail?
RegisterServerEvent('fc_jail:checkJail')
AddEventHandler('fc_jail:checkJail', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()		
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier
	local nome = Character:getName()
	local time = 2
--	TriggerClientEvent('chat:addMessage', -1, { args = { 'JUSTIÇA', nome.. ' está agora preso por '.. time ..' minutos', GetPlayerName(_source), tonumber(time / 60) }, color = { 147, 196, 109 } })
--	TriggerClientEvent('fc_jail:jail', _source, time )
	
end) 

-- unjail via command
RegisterServerEvent('fc_jail:unjailQuest')
AddEventHandler('fc_jail:unjailQuest', function(source)
	if source ~= nil then
		unjail(source)
	end
end)

-- unjail after time served
RegisterServerEvent('fc_jail:unjailTime')
AddEventHandler('fc_jail:unjailTime', function()
	unjail(source)
end)

-- -- keep jailtime updated
-- RegisterServerEvent('fc_jail:updateRemaining')
-- AddEventHandler('fc_jail:updateRemaining', function(jailTime)
-- 	local identifier = GetPlayerIdentifiers(source)[1]
-- 	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier = @identifier', {
-- 		['@identifier'] = identifier
-- 	}, function(result)
-- 		if result[1] then
-- 			MySQL.Async.execute('UPDATE jail SET jail_time = @jailTime WHERE identifier = @identifier', {
-- 				['@identifier'] = identifier,
-- 				['@jailTime'] = jailTime
-- 			})
-- 		end
-- 	end)
-- end)

-- function unjail(target)
-- 	local identifier = GetPlayerIdentifiers(target)[1]
-- 	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier = @identifier', {
-- 		['@identifier'] = identifier
-- 	}, function(result)
-- 		if result[1] then
-- 			MySQL.Async.execute('DELETE from jail WHERE identifier = @identifier', {
-- 				['@identifier'] = identifier
-- 			})

-- 			TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('unjailed', GetPlayerName(target)) }, color = { 147, 196, 109 } })
-- 		end
-- 	end)

-- 	TriggerClientEvent('fc_jail:unjail', target)
-- end
