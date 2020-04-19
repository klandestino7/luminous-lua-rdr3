local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('VP:CLOTHES:saveCloth')
AddEventHandler('VP:CLOTHES:saveCloth', function(dados)
    local _source = source
    print(json.encode(dados))
    local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
    if Character ~= nil then
        for k, v in pairs(dados) do
            Character:setData(Character:getId(), 'clothes', k, v)
        end
        --User:setCharacter(Character:getId()) -- Will draw itself
    end
end)