local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('fcrp_clothes:saveCloth')
AddEventHandler('fcrp_clothes:saveCloth', function(dados)
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