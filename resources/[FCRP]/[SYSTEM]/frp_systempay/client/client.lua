local minute = 20
local added = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		minute = minute - 1
		added = false
		if minute == 0 and not added then
			minute = 20
			TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(Config.xpuser)) 
			TriggerServerEvent('FRP:SYSTEMPAY:money')
			added = true
		end
	end
end)