local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local DoorInfo	= {}

RegisterServerEvent('VP:DOORLOCK:updatedoorsv')
AddEventHandler('VP:DOORLOCK:updatedoorsv', function(src, doorID, cb)
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()	
	
		local auth = Config.DoorList[doorID].authorizedJobs[1]
		local jobaut = Character:hasGroup(tostring(auth))
		local iddoor = Config.DoorList[doorID]
			print(jobaut)
		if jobaut == true then
			if not IsAuthorized(tostring(auth), iddoor) then				
				User:notify('Você não está autorizado')
			return
			end
			TriggerClientEvent('VP:DOORLOCK:changedoor', _source, doorID)
		end
        
end)

RegisterServerEvent('VP:DOORLOCK:updateState')
AddEventHandler('VP:DOORLOCK:updateState', function(src, doorID, state, cb)
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()	
	local auth = Config.DoorList[doorID].authorizedJobs[1]
	local jobaut = Character:hasGroup(tostring(auth))
	local iddoor = Config.DoorList[doorID]

		if type(doorID) ~= 'number' then
			return
		end

		if jobaut == true then
			if not IsAuthorized(tostring(auth), iddoor) then				
			return
			end			
		end

		DoorInfo[doorID] = {}

		DoorInfo[doorID].state = state
		DoorInfo[doorID].doorID = doorID

		TriggerClientEvent('VP:DOORLOCK:setState', -1, doorID, state)
   
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end

	return false
end

