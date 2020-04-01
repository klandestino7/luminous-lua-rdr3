local items = {}
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent('FCRP:INVENTORY:open')
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
    function(items, Weight, Capacity)
        for _, v in pairs(items) do
            v.name = ItemList[v.id].name
        end
        SetNuiFocus(true, true)
        print(Weight, Capacity)
        SendNUIMessage(
            {
                action = 'clearPrimary',
                primaryItems = items,
                primaryWeight = Weight,
                primaryCapacity = Capacity
            }
        )
    end
)

RegisterNetEvent('FCRP:INVENTORY:openAsSecondary')
AddEventHandler(
    'FCRP:INVENTORY:openAsSecondary',
    function(items, Weight, Capacity)
        SetNuiFocus(true, true)
        for _, v in pairs(items) do
            v.name = ItemList[v.id].name
        end
        SendNUIMessage(
            {
                action = 'clearSecondary',
                secondaryItems = items,
                secondaryWeight = Weight,
                secondaryCapacity = Capacity
            }
        )
    end
)

RegisterNetEvent('FCRP:INVENTORY:PrimarySyncItemAmount')
AddEventHandler(
    'FCRP:INVENTORY:PrimarySyncItemAmount',
    function(id, amount)
        local name = ItemList[id].name
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
    function(id, amount)
        local name = ItemList[id].name
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
    SetNuiFocus(false, false)
    SendNUIMessage(
        {
            action = 'hide'
        }
    )
    opened = false
    TriggerServerEvent('FCRP:INVENTORY:Close')
end

RegisterNetEvent('frp_inventory:removeWeapons')
AddEventHandler('frp_inventory:removeWeapons', function()
    local var, model = GetCurrentPedWeapon(PlayerPedId())
    RemoveAllPedWeapons(PlayerPedId(), false, true)
end)


Citizen.CreateThread(
    function()
        local prompt = PromptRegisterBegin()
        local promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Usar Item'))
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetHoldMode(prompt, 1)
        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)

        -- prompt2 = PromptRegisterBegin()
        -- local promptGroup = GetRandomIntInRange(0, 0xffffff)
        -- PromptSetControlAction(prompt2, 0x7F8D09B8)
        -- PromptSetText(prompt2, CreateVarString(10, 'LITERAL_STRING', 'Dropar Item'))
        -- PromptSetEnabled(prompt2, 1)
        -- PromptSetVisible(prompt2, 1)
        -- PromptSetHoldMode(prompt2, 1)
        -- PromptSetGroup(prompt2, promptGroup)
        -- PromptRegisterEnd(prompt2)
        while true do
            Citizen.Wait(0)
            if opened then
                PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, 'LITERAL_STRING', 'Inventário'))
            end
        end
    end
)
