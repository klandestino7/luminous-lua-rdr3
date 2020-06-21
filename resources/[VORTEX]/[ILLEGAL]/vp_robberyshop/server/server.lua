local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


local robberyTimer = 0
local cops = 0
local copsIds = {}

RegisterServerEvent('VP:ROBREG:checkTheRobbery')
AddEventHandler('VP:ROBREG:checkTheRobbery', function(atmInfo)	

	local atmInfo = atmInfo
--
	local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()    

    local PoliceON = #API.getUsersByGroup("trooper") 
    local SheriffON = #API.getUsersByGroup("sheriff")
	print(PoliceON+SheriffON)

	-- for i=1, #xPlayers, 1 do
	-- 	local checkPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 	if checkPlayer.job.name == 'police' then
	-- 		cops = math.floor(cops + 1)
	-- 		copsIds[i] = xPlayers[i]
	-- 	end
	-- end
	print(json.encode(atmInfo))
	if PoliceON+SheriffON < Config.copsRequired then

		TriggerClientEvent('VP:NOTIFY:Simple', source, "Esta loja não pode ser roubada, não há policiais disponíveis.", 10000)		

	elseif (os.time()- Config.ATMS[atmInfo[1]]['wasRobbed']) <= Config.robberyInterval then

		local timeInterval = Config.robberyInterval - (os.time()-Config.ATMS[atmInfo[1]]['wasRobbed'])
		local timeUnit

		if math.floor(timeInterval/60) < 1 then
			timeUnit = 's'
		else
			timeInterval = math.floor(timeInterval/60)
			timeUnit = 'm'
		end

		TriggerClientEvent('VP:NOTIFY:Simple', source, "Este caixa está vazio, aguarde " .. timeInterval .. timeUnit, 10000)
	--	TriggerClientEvent('Notify', source, 'negado',  Locales[Config.Locale]['empty_atm'] .. timeInterval .. timeUnit )

	else
		-- local faca = Inventory:getItemAmount("melee_knife")
		-- if faca < 1 then
		-- 	TriggerClientEvent('VP:NOTIFY:Simple', source, "Você não pussi uma faca.", 10000)
		-- 	return
		-- end
		Config.ATMS[atmInfo[1]]['wasRobbed'] = os.time()
		
		TriggerClientEvent('VP:ROBREG:startTheRobbery', source, atmInfo)

		TriggerClientEvent('VP:ROBREG:warnThePolice', -1, atmInfo)
		TriggerClientEvent('VP:ROBREG:PlayAlarm', -1, atmInfo[2], atmInfo[3], atmInfo[4])
		
	end	
end)


RegisterServerEvent('VP:ROBREG:finishedTheRobbery')
AddEventHandler('VP:ROBREG:finishedTheRobbery', function(money)

	-- for k,v in pairs(copsIds) do
	-- 	local copPlayer = GetPlayerIdentifier(tonumber(v), 0)

	-- 	if copPlayer then
	-- 		local playerId = tonumber(v)
	-- 		TriggerClientEvent('VP:ROBREG:removeRobBlip', -1)

	-- 	--	TriggerClientEvent('chatMessage', playerId, _U('police_title'), Config.policeColor, _U('police_warning_finished'))
	-- --		TriggerClientEvent('Police', playerId, 'importante2', _U('police_warning_finished'))
	-- 	end
	-- end
	--TriggerClientEvent('VP:ROBREG:removeRobBlip', -1)
	TriggerClientEvent('VP:ROBREG:cancelfreeze', source)
	TriggerClientEvent('VP:NOTIFY:Simple', source, "Você roubou ".. money..".", 10000)

--	TriggerClientEvent('Notify', source, 'importante',  Locales[Config.Locale]['robbery_stolen_warning']  )
--	TriggerClientEvent('esx:showNotification', source, string.format( Locales[Config.Locale]['robbery_stolen_warning'], money ) )
end)



RegisterServerEvent('VP:ROBREG:cancelTheRobbery')
AddEventHandler('VP:ROBREG:cancelTheRobbery', function(money)

	-- for k,v in pairs(copsIds) do
	-- 	local copPlayer = GetPlayerIdentifier(tonumber(v), 0)
	-- 	if copPlayer then
	-- 		local playerId = tonumber(v)
	-- 		TriggerClientEvent('VP:ROBREG:removeRobBlip', playerId)
	-- 		--TriggerClientEvent('chatMessage', playerId, _U('police_title'), Config.policeColor, _U('police_warning_cancelled'))
	-- 		TriggerClientEvent('Police', playerId, 'importante2', _U('police_warning_cancelled'))
	-- 	end
	-- end

	TriggerClientEvent('VP:ROBREG:cancelfreeze', source)
	TriggerClientEvent('VP:NOTIFY:Simple', source, "O roubo foi cancelado, você conseguiu apenas $ ".. money..".", 10000)

--	TriggerClientEvent('Notify', source, 'negado',  Locales[Config.Locale]['robbery_stolen_cancel'] ..money )
	--TriggerClientEvent('esx:showNotification', source, string.format( Locales[Config.Locale]['robbery_stolen_cancel'], money ))
end)



RegisterServerEvent('VP:ROBREG:giveRobbedMoney')
AddEventHandler('VP:ROBREG:giveRobbedMoney', function(money)
	local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()
	Inventory:addItem('money', money*100)	
end)