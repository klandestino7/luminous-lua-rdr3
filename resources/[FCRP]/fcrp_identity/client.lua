local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')
Identity = {}

RegisterNetEvent('FCRP:IDENTITY:charList')
AddEventHandler('FCRP:IDENTITY:charList', function(characters)
    createCamera()
    SendNUIMessage({type = 2}) -- clear UI
    Wait(2500)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 1,
        list = characters
    })      
end)

RegisterNUICallback('createCharacter', function()
    SetNuiFocus(false, false)
    TriggerEvent('crz_creator:starting')
end)

RegisterNUICallback('selectCharacter', function(id)
    SetNuiFocus(false, false)
    TriggerServerEvent('FCRP:IDENTITY:selectCharacter', id)
    cAPI.StartFade(500)
    Citizen.Wait(500)
end)

RegisterNUICallback('deleteCharacter', function(id)
    TriggerServerEvent('FCRP:IDENTITY:deleteCharacter', id)
end)

function createCamera()
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -663.57,792.06,246.38, 300.00,0.00,0.00, 100.00, false, 0) -- CAMERA COORDS
    PointCamAtCoord(cam, -663.57,710.67,246.38)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end