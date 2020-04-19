local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('VP:PEAGLE:checkJOB')
AddEventHandler('VP:PEAGLE:checkJOB', function()

end)
