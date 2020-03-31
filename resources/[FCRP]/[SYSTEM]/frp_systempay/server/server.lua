local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')
API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local salario = {
	{"police", "0", 10},
	{"user", "0", 10},
	{"medic", "0", 10}
  }

  
local xp = {
	{"admin", 20},
	{"user", 20},
	{"vip1", 20*1.10},
	{"vip2", 20*1.20},
	{"vip3", 20*1.30}
}

local perdaxp = {
	{"admin", 20},
	{"user", 20},
	{"vip1", 20*1.10},
	{"vip2", 20*1.20},
	{"vip3", 20*1.30}
}

RegisterServerEvent('FRP:SYSTEMPAY:money')
AddEventHandler('FRP:SYSTEMPAY:money', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()

	local Inventory = User:getCharacter():getInventory()
	local call = json.decode(Character:getData(Character:getId(), 'charTable', 'banco'))	

	for i,v in pairs(salario) do
		local job = Character:hasGroup(v[1])
		if job then			
			Character:setData(Character:getId(), 'charTable', 'banco', tonumber(call+(v[3]*100)))
			TriggerClientEvent('chatMessage',_source,"SALARIO",{65,255,135},"Sua recompensa de ^1$"..v[3].." ^0 foi depositada no banco.")
		end
	end
end)


RegisterServerEvent("FRP:SYSTEMPAY:xp")
AddEventHandler('FRP:SYSTEMPAY:xp', function(count)
    local countxp = count    
	local _source = tonumber(source)
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()

	for i,v in pairs(xp) do
		local group = Character:hasGroup(v[1])
		if group then			
			Character:addXp(tonumber(v[2]))
		end
	end
	print("XP Distribuido com Sucesso.")
end)



RegisterServerEvent("FRP:SYSTEMPAY:removedeath")
AddEventHandler('FRP:SYSTEMPAY:removedeath', function(source)

	local _source = source
	local countxp = count    
	
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()
	local xp = Character:getXp()

	if Character:hasGroup('vip3') then
		Character:removeXp(xp*0.05)
	elseif Character:hasGroup('vip2') then
		Character:removeXp(xp*0.10)
	elseif Character:hasGroup('vip1') then
		Character:removeXp(xp*0.15)
	elseif Character:hasGroup('admin') then
		Character:removeXp(xp*0.20)
	elseif Character:hasGroup('user') then
		Character:removeXp(xp*0.20)
	end
end)
