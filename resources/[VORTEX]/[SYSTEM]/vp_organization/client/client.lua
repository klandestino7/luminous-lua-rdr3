local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterCommand(
    "myOrgGov",
    function(source, args, raw)
        print(cAPI.getMyOrg()["governo"].id)
    end,
    false
)

RegisterCommand(
    "governo",
    function(source, args, raw)
        if cAPI.getMyOrg()["governo"] ~= nil then
            TriggerServerEvent("VP:ORGANIZATION:ViewOrg", cAPI.getMyOrg()["governo"].id)
        else
            SendNUIMessage({
                type = 'governo',
                hasOrg = false
            })
            SetNuiFocus(true, true)
        end
    end,
    false
)

RegisterCommand(
    "ilegal",
    function(source, args, raw)
        if cAPI.getMyOrg()["ilegal"] ~= nil then
            TriggerServerEvent("VP:ORGANIZATION:ViewOrg", cAPI.getMyOrg()["ilegal"].id)
        else
            SendNUIMessage({
                type = 'ilegal',
                hasOrg = false
            })
            SetNuiFocus(true, true)
        end
    end,
    false
)

TriggerServerEvent(
    "VP:ORGANIZATION:ViewOrg",
    function(orgComplete)
        SendNUIMessage({
            action = orgComplete.type,
            hasOrg = true,
            name = orgComplete.name,
            rank = cAPI.getMyOrg()[orgComplete.type].rank,
            members = orgComplete.members
        })
        SetNuiFocus(true, true)
    end
)
