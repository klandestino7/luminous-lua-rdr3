local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:PEAGLE:checkJOB')
AddEventHandler('FRP:PEAGLE:checkJOB', function()

end)