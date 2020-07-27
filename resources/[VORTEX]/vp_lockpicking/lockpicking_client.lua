local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local gui = false
local currentlyInGame = false
local passed = false

local doorHashBeingLockpicked

RegisterNetEvent("VP:LOCKPICK:StartLockpicking")
AddEventHandler(
    "VP:LOCKPICK:StartLockpicking",
    function()
        local doorHash = exports.vp_doorcontainer:GetRegisteredDoorHashInRadius(1.5, 1)

        if doorHash then
            local doorEntity = Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)

            doorHashBeingLockpicked = doorHash

            lockpick(100, 10, 10, 10)
        else
            cAPI.notify("error", "Nenhum trancada porta por perto!")
        end
    end
)

function lockpick(pickhealth, pickdamage, pickPadding, distance)
    openGui()
    play(pickhealth, pickdamage, pickPadding, distance)
    currentlyInGame = true
    while currentlyInGame do
        Wait(400)
        if IsEntityDead(PlayerPedId()) then
            closeGui()
        end
    end

    if passed then
        return 100
    else
        return 0
    end
end

function openGui()
    gui = true
    SetNuiFocus(true, true)
    SendNUIMessage({openPhone = true})
end

function play(pickhealth, pickdamage, pickPadding, distance)
    SendNUIMessage({openSection = "playgame", health = pickhealth, damage = pickdamage, padding = pickPadding, solveDist = distance})
end

function CloseGui()
    currentlyInGame = false
    gui = false
    SetNuiFocus(false, false)
    SendNUIMessage({openPhone = false})
end

-- NUI Callback Methods
RegisterNUICallback(
    "close",
    function(data, cb)
        passed = false
        CloseGui()
        cb("ok")

        doorHashBeingLockpicked = nil
    end
)

RegisterNUICallback(
    "failure",
    function(data, cb)
        passed = false
        CloseGui()
        cb("ok")

        doorHashBeingLockpicked = nil

        TriggerServerEvent("VP:LOCKPICKING:FailedLockpicking")
    end
)

RegisterNUICallback(
    "complete",
    function(data, cb)
        passed = true
        CloseGui()
        cb("ok")

        TriggerServerEvent("VP:LOCKPICKING:SuccededLockpicking", doorHashBeingLockpicked)

        doorHashBeingLockpicked = nil
    end
)
