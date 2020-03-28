
Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(Config.time * 60000) -- Change this value for the frequency of paycheck (600000 = 10 minutes)
		TriggerServerEvent('fcxp:systemxp', tonumber(Config.xpuser)) 
	end
end)



local minute = 30
local added = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		minute = minute - 1
		added = false
		if minute == 0 and not added  then
			minute = 30
			TriggerServerEvent('crz_salario:start')
			added = true
		end
	end
end)


--[[
RegisterCommand('givexp', function(source, args)
    local count = tonumber(args[1])
    TriggerServerEvent('fcxp:systemxp', count)
    print(count)
end) ]]
