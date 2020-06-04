local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local prompt

RegisterNetEvent("VP:CRAFTING:OpenMenu")
AddEventHandler(
    "VP:CRAFTING:OpenMenu",
    function(playerItems)
        print(ownedParts)

        local parsedItemNames = {}

        local craftingItems = deepcopy(Config)

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

        local ItemNamePool = {}
        local ItemDescripPool = {}

        for itemId, neededForCrafting in pairs(Config) do
            if ItemList[itemId] then
                local craftable = true

                if ItemNamePool[itemId] == nil then
                    ItemNamePool[itemId] = ItemList[itemId].name
                end

                if ItemDescripPool[itemId] == nil then
                    ItemDescripPool[itemId] = ItemList[itemId].description
                end

                for craftingItem, min in pairs(neededForCrafting) do
                    if ItemNamePool[craftingItem] == nil then
                        print("hasnt been added to name pool", craftingItem)
                        ItemNamePool[craftingItem] = ItemList[craftingItem].name
                    end

                    if playerItems[craftingItem] == nil or playerItems[craftingItem] < min then
                        craftable = false
                    end
                end

                craftingItems[itemId].canCraft = craftable
            end
<<<<<<< HEAD
        end

=======
        end        
>>>>>>> a6fae5dee86199371c6cee64a60d572ed5239881
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = "open",
                craftingItems = craftingItems,
                ownedParts = playerItems,
                parsedItemNames = ItemNamePool,
                ItemDesciption = ItemDescripPool
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
local freeAimingPromptGroupName = CreateVarString(10, "LITERAL_STRING", "Ações")

Citizen.CreateThread(
    function()
        -- initiatePrompt()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0x5966D52A) then
                if not NativePromptIsControlActionActive(0x5966D52A) then
                    TriggerServerEvent("VP:CRAFTING:Open")
                end
            end
        end
    end
)

function NativePromptIsControlActionActive(control)
    return Citizen.InvokeNative(0x1BE19185B8AFE299, control)
end

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
