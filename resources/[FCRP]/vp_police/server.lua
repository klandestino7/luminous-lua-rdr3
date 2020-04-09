local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("VP:POLICE:TryToHandcuff")
AddEventHandler(
    "VP:POLICE:TryToHandcuff",
    function(targetServerId)
        local _source = source
        local User = API.getUserFromSource(_source)

        if User:hasGroupOrInheritance("recruit") then
            cAPI.player_ToggleHandcuff(targetServerId)
        end
    end
)
