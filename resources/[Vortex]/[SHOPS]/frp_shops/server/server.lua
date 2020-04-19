local Tunnel = module("_core","lib/Tunnel")
local Proxy = module("_core","lib/Proxy")
fcRP = Proxy.getInterface("API_Core")
fcRPCli = Tunnel.getInterface("API_Core")

RegisterServerEvent('frp_shops:buyedItem')
AddEventHandler('frp_shops:buyedItem', function(item)
    local _source = source
end)