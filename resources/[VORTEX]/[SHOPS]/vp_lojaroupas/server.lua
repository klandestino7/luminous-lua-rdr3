local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("VP:STORECLOTHES:checkmoney")
AddEventHandler(
    "VP:STORECLOTHES:checkmoney",
    function(price)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        -- if Inventory:getItemAmount('money') < 200 then
        --     User:notify('Dinheiro insuficiente!')
        --     return
        -- end
        TriggerClientEvent("VP:STORECLOTHES:open", _source)
    end
)

RegisterServerEvent("VP:STORECLOTHES:buy")
AddEventHandler(
    "VP:STORECLOTHES:buy",
    function(price)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        -- if Inventory:getItemAmount('money') < price*100 then
        --     User:notify('Dinheiro insuficiente!')
        --     return
        -- end
        User:notify("dollar", -(price * 100))

        --	Inventory:removeItem(-1, 'money', price*100)
    end
)
