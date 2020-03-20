local items = {}
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 47) and not opened then
                TriggerServerEvent('FCRP:INVENTORY:open')
                Citizen.CreateThread(function()
                    while opened == true do 
                        Citizen.Wait(10)
                            DisableControlAction(0,24, true) -- disable attack
                            DisableControlAction(0,25, true) -- disable aim
                    end
                end)
                opened = true
            end
        end
    end
)

RegisterNetEvent('FCRP:INVENTORY:closeInv')
AddEventHandler(
    'FCRP:INVENTORY:closeInv',
    function()
        closeInv()
    end
)

RegisterNetEvent('FCRP:INVENTORY:openAsPrimary')
AddEventHandler(
    'FCRP:INVENTORY:openAsPrimary',
    function(items)
        Citizen.CreateThread(function()           
        end)
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        SendNUIMessage(
            {
                action = 'clearPrimary',
                primaryItems = items
            }
        )
    end
)

RegisterNetEvent('FCRP:INVENTORY:openAsSecondary')
AddEventHandler(
    'FCRP:INVENTORY:openAsSecondary',
    function(items)
        Citizen.CreateThread(function()
        end)
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        SendNUIMessage(
            {
                action = 'clearSecondary',
                secondaryItems = items
            }
        )
    end
)

RegisterNetEvent('FCRP:INVENTORY:PrimarySyncItemAmount')
AddEventHandler(
    'FCRP:INVENTORY:PrimarySyncItemAmount',
    function(id, amount, name)
        SendNUIMessage(
            {
                primaryItems = {{id = id, amount = amount, name = name}}
            }
        )
    end
)

RegisterNetEvent('FCRP:INVENTORY:SecondarySyncItemAmount')
AddEventHandler(
    'FCRP:INVENTORY:SecondarySyncItemAmount',
    function(id, amount, name)
        SendNUIMessage(
            {
                secondaryItems = {{id = id, amount = amount, name = name}}
            }
        )
    end
)

RegisterNUICallback(
    'useItem',
    function(data)
        TriggerServerEvent('FCRP:INVENTORY:useItem', data)
    end
)

RegisterNUICallback(
    'dropItem',
    function(data)
        TriggerServerEvent('FCRP:INVENTORY:dropItem', data)
    end
)

RegisterNUICallback(
    'sendItemToPrimary',
    function(cb)
        local id = cb.id
        local amount = cb.amount
        TriggerServerEvent('FCRP:INVENTORY:sendItemToPrimary', id, amount)
    end
)

RegisterNUICallback(
    'sendItemToSecondary',
    function(cb)
        local id = cb.id
        local amount = cb.amount
        TriggerServerEvent('FCRP:INVENTORY:sendItemToSecondary', id, amount)
    end
)

RegisterNUICallback(
    'NUIFocusOff',
    function()
        closeInv()
    end
)

AddEventHandler(
    'onResourceStart',
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        closeInv()
    end
)

function closeInv()


    EnableControlAction(0,24, true) -- disable attack
    EnableControlAction(0,25, true) -- disable aim


    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    
    SendNUIMessage(
        {
            action = 'hide'
        }
    )
    opened = false
    TriggerServerEvent('FCRP:INVENTORY:Close')
end
