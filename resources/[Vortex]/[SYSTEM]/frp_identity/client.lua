local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')
Identity = {}

RegisterNetEvent('VP:IDENTITY:charList')
AddEventHandler('VP:IDENTITY:charList', function(characters,gold,money)
    ShutdownLoadingScreen()
    createCamera()
    SendNUIMessage({type = 2}) -- clear UI
    Wait(2500)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 1,
        list = characters,
        igold = gold,
        imoney = money
    })      
end)

RegisterNUICallback('createCharacter', function()
    SetNuiFocus(false, false)
    TriggerEvent('VP:CHARCREATION:starting')
end)

RegisterNUICallback('selectCharacter', function(id)
    SetNuiFocus(false, false)
    DisplayHud(true)
    TriggerServerEvent('VP:IDENTITY:selectCharacter', id)
    cAPI.StartFade(500)
    Citizen.Wait(500)
end)

RegisterNUICallback('deleteCharacter', function(id)
    TriggerServerEvent('VP:IDENTITY:deleteCharacter', id)
end)

function createCamera()
    DisplayHud(false)
    SetEntityCoords(PlayerPedId(), 1062.78,1597.82,373.29)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",1062.78,1597.82,373.29, 0.00,0.00,168.00,100.00, false, 0) -- CAMERA COORDS
    PointCamAtCoord(cam, 1062.78,1597.82,373.29)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end