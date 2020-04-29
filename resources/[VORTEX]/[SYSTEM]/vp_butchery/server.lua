local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local sellables = {
    [`A_C_Wolf_Medium`] = 100,
}

RegisterNetEvent("VP:BUTCHER:TryToSell")
AddEventHandler(
    "VP:BUTCHER:TryToSell",
    function(entType, entModel, entity, quality)
        local _source = source
        
        local payment = sellables[entModel] or 175

        -- if payment == nil then
        --     TriggerClientEvent('VP:BUTCHER:EntityNotAccepted', _source, entity)
        --     print('nao vendivel')
        --     return
        -- end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        Inventory:addItem('money', payment)

        local text = 'este animal'
    
        if entType == 3 then
            text = 'esta pele'
        end

        User:notify('Você recebeu $' .. payment .. ' por ' .. text .. '!')
    end
)
