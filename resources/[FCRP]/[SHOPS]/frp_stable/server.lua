local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('FRP:STABLE:saveHorse')
AddEventHandler('FRP:STABLE:saveHorse', function(dados)
    local _source = source
    print(json.encode(dados))
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()	
    local Horse = Character:getHorse()
    
    if Horse ~= nil then
        for k, v in pairs(dados) do
           -- Horse:setModif(Horse:getId(), dados)
           Horse:setData(Horse:getId(), 'modif', k, v)      
        end
    end

end)

RegisterNetEvent('FRP:STABLE:AskForMyHorses')
AddEventHandler(
    'FRP:STABLE:AskForMyHorses',
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local horses = Character:getHorses() or {}

        if #horses <= 0 then
            return
        end

        local Horse = Character:getHorse()

        local selectedHorseId
        if Horse ~= nil then
            selectedHorseId = Horse:getId() 
        end

        for _, data in pairs(horses) do
            if selectedHorseId ~= nil and data.id == selectedHorseId then
                data.selected = true
            end
            data.charid = nil
        end

        TriggerClientEvent('FRP:STABLE:ReceiveHorsesData', _source, horses)
        TriggerClientEvent('FRP:STABLE:callhorse', _source)
    end
)