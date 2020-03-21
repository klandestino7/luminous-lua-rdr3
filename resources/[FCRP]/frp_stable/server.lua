local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('frp_stable:saveHorse')
AddEventHandler('frp_stable:saveHorse', function(dados)
    local _source = source
    print(json.encode(dados))
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()	
    local Horse = Character:getHorse()
        
    if Character ~= nil then
        for k, v in pairs(dados) do
            print(Horse:getId())
            print(k)
            Horse:setData(Horse:getId() , 'clothes', k, v)
        end
    end

end)
