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
            Horse:setData(Horse:getId() , 'clothes', k, v)
        end
    end

end)

RegisterNetEvent('FCRP:HORSESHOP:AskForMyHorses')
AddEventHandler(
    'FCRP:HORSESHOP:AskForMyHorses',
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local horses = Character:getHorses() or {}

        if #horses <= 0 then
            return
        end

        local Horse = Character:getHorse()
        Horse:getId() 
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

        TriggerClientEvent('FCRP:HORSESHOP:ReceiveHorsesData', _source, horses)
        TriggerClientEvent('FCRP:HORSESHOP:CHAMOUH', _source)
    end
)