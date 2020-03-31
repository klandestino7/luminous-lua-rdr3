local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local DoorInfo	= {}

RegisterServerEvent('FRP:DOORLOCK:updatedoorsv')
AddEventHandler('FRP:DOORLOCK:updatedoorsv', function(src, doorID, cb)
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
			TriggerClientEvent('FRP:DOORLOCK:changedoor', _source, doorID)
		end
        
end)

RegisterServerEvent('FRP:DOORLOCK:updateState')
AddEventHandler('FRP:DOORLOCK:updateState', function(src, doorID, state, cb)
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

		TriggerClientEvent('FRP:DOORLOCK:setState', -1, doorID, state)
   
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end

	return false
end

