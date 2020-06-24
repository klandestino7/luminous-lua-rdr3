local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

Showing = false

RegisterNetEvent("VP:DOCUMENTS:opening")
AddEventHandler(
    "VP:DOCUMENTS:opening",
    function(data)   
        SendNUIMessage(
            {
                action = "show",
                infos = data
            }
        )
        Wait(15000)
        Showing = false
end)

RegisterNetEvent("VP:DOCUMENTS:close")
AddEventHandler(
    "VP:DOCUMENTS:close",
    function(data)   
        SendNUIMessage(
            {
                action = "hide",
                infos = data
            }
        )
end)

RegisterCommand('meuid', function(source)
    if not Showing then
        TriggerServerEvent("VP:DOCUMENTS:getCharInfo", GetPlayerServerId())
        Showing = true
    else
        TriggerEvent("VP:DOCUMENTS:close")
        Showing = false
    end
end)

RegisterCommand('pedirid', function(source)
    local targetPlayerServerId = cAPI.getNearestPlayer(1.5)
        
    if targetPlayerServerId == nil then
        cAPI.notify('error', 'Ninguem por perto')
        return
    end

    if not Showing then
        TriggerServerEvent("VP:DOCUMENTS:requestCharInfo", targetPlayerServerId)
        Showing = true
    else
        TriggerEvent("VP:DOCUMENTS:close")
        Showing = false
    end
end)

RegisterCommand('fecharid', function(source)
    TriggerEvent("VP:DOCUMENTS:close")
    Showing = false
end)

