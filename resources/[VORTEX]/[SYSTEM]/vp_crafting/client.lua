
local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Tunnel.getInterface('API')
cAPI = Proxy.getInterface('API')

local prompt

RegisterNetEvent("VP:CRAFTING:OpenMenu")
AddEventHandler(
    "VP:CRAFTING:OpenMenu",
    function(ownedParts)
        local parsedItemNames = {}

        local craftingItems = Config

        ----------------------------- DATA FORMAT
        -- ownedParts
        -- {
        --     id1 = amount,
        --     id2 = amount,
        -- }

        -- craftingItems
        -- {
        --     id1 = {
        --         canCraft = false
        --         craftingParts = {
        --             cId1 = amount
        --         }
        --     }
        --     id2 = {
        --         canCraft = true
        --         craftingParts = {
        --             cId1 = amount
        --             cId2 = amount
        --         }
        --     }
        -- }

        -- parsedItemNames
        -- {
        --     id1 = 'Maça'
        --     id2 = 'Vara de Pesca'
        -- }
        ----------------------------- DATA FORMAT

        -- if not wasOpenedBefore then

        for id, values in pairs(Config) do
            if ItemList[id] then
                parsedItemNames[id] = ItemList[id].name
                local canCraft = true
                for idCPart, amountNeeded in pairs(values) do
                    parsedItemNames[idCPart] = ItemList[idCPart].name
                --     if ownedParts[idCPart] == nil or ownedParts[idCPart] < amountNeeded then
                --         canCraft = false
                    -- end
                end
                craftingItems[id].canCraft = canCraft
            end
        end
        
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = "open",
                craftingItems = craftingItems,
                -- ownedParts = ownedParts,
                parsedItemNames = parsedItemNames
            }
        )
        -- wasOpenedBefore = true
        -- else
    end
)

RegisterNetEvent("VP:CRAFTING:SyncOnCraft")
AddEventHandler(
    "VP:CRAFTING:SyncOnCraft",
    function(updatedOwnedItems)
        local updatedCraftingStatus = {}

        for id, values in pairs(Config) do
            local canCraft = true
            for idCPart, amountNeeded in pairs(values) do
                if updatedOwnedItems[idCPart] < amountNeeded then
                    canCraft = false
                    break
                end
            end
            updatedCraftingStatus[id] = canCraft
        end

        SendNUIMessage(
            {
                action = "update",
                updatedOwnedItems = updatedOwnedItems,
                updatedCraftingStatus = updatedCraftingStatus
            }
        )
    end
)


local freeAimingPromptGroup = GetRandomIntInRange(0, 0xffffff)
local freeAimingPromptGroupName = CreateVarString(10, 'LITERAL_STRING', "Ações")

Citizen.CreateThread(
    function()
        -- initiatePrompt()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xF84FA74F) then
                -- TriggerServerEvent("VP:CRAFTING:Open")
                TriggerEvent("VP:CRAFTING:OpenMenu")
            end

            -- if IsPlayerFreeAiming(PlayerId()) then
            -- if IsControlPressed(0, 0xC13A6564) or IsControlPressed(0, 0x8B3FA65E) then
            --     print('yes')
            --     PromptSetActiveGroupThisFrame(freeAimingPromptGroup, freeAimingPromptGroupName)
            -- end

            -- if PromptIsJustPressed(prompt) then
            --     TriggerServerEvent("VP:CRAFTING:Open")
            -- end
        end
    end
)

RegisterNUICallback(
    "craft",
    function(data)
        TriggerServerEvent("VP:CRAFTING:Craft", data.id)
    end
)

RegisterNUICallback(
    "close",
    function()
        SetNuiFocus(false, false)
    end
)

function initiatePrompt()
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xDFF812F9)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Crafting"))
    PromptSetEnabled(prompt, 1)
    PromptSetVisible(prompt, 1)
    PromptSetStandardMode(prompt, 1)
    PromptSetGroup(prompt, freeAimingPromptGroup)
    PromptRegisterEnd(prompt)
end


AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        PromptDelete(prompt)
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "close"
            }
        )
    end
)