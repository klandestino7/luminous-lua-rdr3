local Tunnel = module("_core","libs/Tunnel")
local Proxy = module("_core","libs/Proxy")
fcRP = Proxy.getInterface("API_Core")
fcRPCli = Tunnel.getInterface("API_Core")

RegisterServerEvent('fcrp_shops:buyedItem')
AddEventHandler('fcrp_shops:buyedItem', function(item)
    local _source = source
end)