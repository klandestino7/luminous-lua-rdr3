local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local hash
local nearestPlayers

RegisterNetEvent("FCRP:POSSE:SetPosse")
AddEventHandler(
    "FCRP:POSSE:SetPosse",
    function(id)
        if id ~= nil then
            local _, h = AddRelationshipGroup('posse:' .. id)
            hash = b
            SetPedRelationshipGroupHash(ped, hash)
        else
            hash = nil
            SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if hash ~= nil then
                local ped = PlayerPedId()
                if GetPedRelationshipGroupHash(ped) ~= hash then
                    SetPedRelationshipGroupHash(ped, hash)
                end

                nearestPlayers = cAPI.getNearestPlayers(5)
            end
        end
    end
)

RegisterNetEvent("FCRP:POSSE:OpenMenu")
AddEventHandler(
    "FCRP:POSSE:OpenMenu",
    function(data, clanName)
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = "open",
                clanName = clanName,
                data = data,
                nearestPlayers = nearestPlayers
            }
        )
    end
)

RegisterNetEvent("FCRP:POSSE:CloseMenu")
AddEventHandler(
    "FCRP:POSSE:CloseMenu",
    function()
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "close"
            }
        )
    end
)
RegisterNUICallback(
    "NUICallbackOff",
    function()
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback(
    "promote",
    function(charId)
        TriggerServerEvent("FCRP:POSSE:Promote", charId)
    end
)

RegisterNUICallback(
    "demote",
    function(charId)
        TriggerServerEvent("FCRP:POSSE:Demote", charId)
    end
)

RegisterNUICallback(
    "kick",
    function(charId)
        TriggerServerEvent("FCRP:POSSE:Kick", charId)
    end
)

RegisterNUICallback(
    "leave",
    function()
        TriggerServerEvent("FCRP:POSSE:Leave")
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "close"
            }
        )
        SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    end
)
