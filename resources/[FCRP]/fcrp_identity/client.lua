local Proxy = module('_core', 'libs/Proxy')
local Tunnel = module('_core', 'libs/Tunnel')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

RegisterNetEvent('fcrp_identity:charList')
AddEventHandler('fcrp_identity:charList', function(characters)
    --cAPI.createCamera()
    SendNUIMessage({type = 2}) -- clear UI
    Wait(1000)
    SetNuiFocus(true, true)
       SendNUIMessage({
        type = 1,
        list = characters
    })      
end)

RegisterNUICallback('createCharacter', function()
    SetNuiFocus(false, false)
    TriggerEvent('fcrp_creator:createCharacter')
end)

RegisterNUICallback('selectCharacter', function(id)
    SetNuiFocus(false, false)
    TriggerServerEvent('fcrp_identity:selectCharacter', id)
    cAPI.StartFade(500)
end)

RegisterNUICallback('deleteCharacter', function(id)
    TriggerServerEvent('fcrp_identity:deleteCharacter', id)
end)
