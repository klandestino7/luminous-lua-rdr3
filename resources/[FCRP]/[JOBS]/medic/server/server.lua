
RegisterCommand('curar', function(source)
	local source = source
	TriggerEvent("redemrp:getPlayerFromId", source, function(user)
		local medicjob = user.getJob()
		if medicjob == 'medic' then
			TriggerClientEvent('fc_medicjob:revivecheck', source)
			user.addMoney(tonumber(5))
			user.addXP(tonumber(10))	
		else
			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um médico') 
		end 
	end)
end)

RegisterServerEvent('fc_medicjob:revivecallback2')
AddEventHandler('fc_medicjob:revivecallback2', function(target)
	TriggerClientEvent('fc_medicjob:revive2', target)
end)



 --[[
RegisterServerEvent('fc_medicjob:revive1')
AddEventHandler('fc_medicjob:revive1', function(target)
	local source = source

TriggerEvent("redemrp:getPlayerFromId", source, function(user)
	local medicjob = user.getJob()

	if medicjob == 'medico' then

		TriggerEvent('fc_medicjob:revive2', target)

	else
	 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um médico') 
	end 

	if handcuffs == true then
		TriggerEvent('fc_handcuffs:prender', target)
	end

end)
end)  ]]

RegisterServerEvent('fc_medicjob:revive2')
AddEventHandler('fc_medicjob:revive2', function(target)
		TriggerClientEvent('fc_medicjob:revive2', target)
end)