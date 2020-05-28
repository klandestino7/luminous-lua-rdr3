local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

ItemPoolHash = {}

function joaat(t)
    return exports["vp_containers"]:js_joaat(t)
end

Citizen.CreateThread(
    function()
        for itemId, _ in pairs(ItemPool) do
            ItemPoolHash[joaat(itemId)] = itemId
        end

        -- print(json.encode(ItemPoolHash))

        Wait(1000)

        SendNUIMessage(
            {
                messageType = "updateItemPool",
                message = ItemPool,
                message2 = ItemPoolHash
            }
        )

        Wait(1000)
        FakeLoadInventoryItems()
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xC1989F95) then
                if inAShop then
                    draw("shop")
                end
                draw("inventory")

                print('validindex', ContainerGetFirstValidIndexForItem('inventory', 'w_lasso'))
            end
        end
    end
)

Containers = {}

Containers["inventory"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 9 * 3,
    containerTitle = "Inventário",
    containerIsOpen = false,
    containerHasPages = true,
    containerMaxWeight = 20.0
}

Containers["hotbar"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4
}

Containers["crafting"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 3 * 3,
    containerTitle = "Crafting",
    containerIsOpen = false
}

Containers["shop"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 5 * 3,
    containerTitle = "Loja",
    containerIsOpen = false
}

function draw(container)
    Containers[container].containerIsOpen = true

    local cData = Containers[container]
    local message = {
        messageType = "drawContainer",
        container = container,
        containerItemPool = cData.containerItemPool,
        containerNumIndexes = cData.containerNumIndices,
        containerActivePage = cData.containerActivePage
    }

    if cData.containerTitle then
        message.containerTitle = cData.containerTitle
    end

    if cData.containerMaxWeight then
        message.containerMaxWeight = cData.containerMaxWeight
    end

    SendNUIMessage(message)

    -- Atualizar as armas da hotbar quando atualizar ela !!
    if container == "hotbar" then
        cAPI.replaceWeapons({})
        for _, v in pairs(Containers["hotbar"].containerItemPool) do
            local itemId = ItemPoolHash[v[1]]
            local itemAmmoInClip = v[2] or 1
            local itemAmmoInWeapon = v[3] or 1
            local weaponModel = itemId:gsub("w_", "weapon_")
            -- local weaponHash = GetHashKey(weaponModel)
            cAPI.giveWeapon(weaponModel, itemAmmoInClip + itemAmmoInWeapon, false)
        end
    else
        SetNuiFocus(true, true)
    end
end

function stopdrawing(container)
    Containers[container].containerIsOpen = false

    SendNUIMessage(
        {
            messageType = "hide",
            container = container
        }
    )
end

RegisterNUICallback(
    "container_changepage",
    function(cb)
        local container = cb.container
        local activepage = cb.activepage

        Containers[container].containerActivePage = activepage

        draw(container)
    end
)

RegisterNUICallback(
    "container_dropdraggable",
    function(cb)
        local container_from = cb.container_from
        local container_to = cb.container_to

        local slot_from = tonumber(cb.slot_from)
        local slot_to = tonumber(cb.slot_to)

        print(slot_from, slot_to)

        local itemContainerData_from = Containers[container_from].containerItemPool[slot_from]
        local itemContainerData_to = Containers[container_to].containerItemPool[slot_to]

        local itemHash_from = ContainerGetItemHashAtIndex(container_from, slot_from)
        local itemHash_to = ContainerGetItemHashAtIndex(container_to, slot_to)

        if not ContainerIsItemValidForIndex(container_to, itemHash_from, slot_to) or not ContainerIsItemValidForIndex(container_from, itemHash_to, slot_from) then
            draw(container_from)
            return
        end

        local itemType_from = GetItemType(itemHash_from)
        local itemType_to = GetItemType(itemHash_to)

        -- O item que a gente está tentando mover existe, então
        -- continua a execuçao do codigo
        -- if IsThrownInvalidException(itemHash_from) == false then
        if container_to == "inventory" then
            if container_from == "inventory" then -- Troca de slots do inventario para o inventario
                switchContainerSlots({"inventory", slot_to}, {"inventory", slot_from})

                TriggerServerEvent("VP:CONTAINERS:INVENTORY:TryToSwitchSlot", slot_from, slot_to)
            end

            --[[
                    Tirando item da hotbar para enviar para o inventario
                ]]
            if container_from == "hotbar" then
                --[[
                        Não há nenhum item no slot onde eu quero colocar o item
                    ]]
                print("yes")
                switchContainerSlots({"inventory", slot_to}, {"hotbar", slot_from})
            --[[
                            Verificar caso esteja trocando com outra arma, fazer a troca completa
                        ]]
            end

            if container_from == "shop" then
                -- TriggerServerEvent "TryToBuyItem"
                Containers["inventory"].containerItemPool[slot_to] = Containers["shop"].containerItemPool[slot_from]
            end
        end

        if container_to == "hotbar" then
            if container_from == "inventory" then
                if IsThrownInvalidException(itemHash_to) then -- Slot da hotbar estava vazio, adiciona o item no slot caso seja uma arma
                    if ContainerIsItemValidForIndex("hotbar", itemHash_from, slot_to) then
                        switchContainerSlots({"hotbar", slot_to}, {"inventory", slot_from})
                    end
                else
                    if ContainerIsItemValidForIndex("hotbar", itemHash_from, slot_to) then -- Trocou uma arma de lugar com a outra na hotbar para o inventario
                        switchContainerSlots({"hotbar", slot_to}, {"inventory", slot_from})
                    elseif itemType_from == "ammo" then -- Dropou munição em cima de uma arma na hotbar, para recarregar
                        if itemType_to == "weapon" then
                            local itemId_from = GetItemIdFromHash(itemHash_from)
                            local itemId_to = GetItemIdFromHash(itemHash_to)
                            local weaponModel = itemId_to:gsub("w_", "weapon_")

                            if doesWeaponAcceptsAmmo(weaponModel, itemId_from) then
                                local weaponHash = GetHashKey(weaponModel)

                                local ammoWeaponToIncrease = Containers["inventory"].containerItemPool[slot_from]
                                local oldWeaponAmmoCount = Containers["hotbar"].containerItemPool[slot_to][3]

                                Containers["inventory"].containerItemPool[slot_from] = nil
                                Containers["hotbar"].containerItemPool[slot_to][3] = oldWeaponAmmoCount + ammoWeaponToIncrease
                            end
                        end
                    end
                end
            end
        end
        -- end

        draw(container_from)
        draw(container_to)
    end
)

RegisterNUICallback(
    "focusoff",
    function(cb)
        SetNuiFocus(false, false)

        for container, d in pairs(Containers) do
            if container ~= "hotbar" then
                Containers[container].containerIsOpen = false
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SetNuiFocus(false, false)
            SendNUIMessage(
                {
                    messageType = "hide"
                }
            )
        end
    end
)

function switchContainerSlots(st1, st2)
    print("switching", json.encode(st1), json.encode(st2))

    local copy1 = Containers[st1[1]].containerItemPool[st1[2]]

    Containers[st1[1]].containerItemPool[st1[2]] = Containers[st2[1]].containerItemPool[st2[2]]
    Containers[st2[1]].containerItemPool[st2[2]] = copy1
end

function doesWeaponAcceptsAmmo(weaponModel, ammoModel)
    return true
end

function FakeLoadInventoryItems()
    Containers["inventory"].containerItemPool = {
        [82] = {
            joaat("w_shotgun_doublebarrel"),
            0,
            0
        },
        [83] = {
            joaat("a_shotgun"),
            20
        },
        [84] = {
            joaat("w_lasso")
        }
    }

    Containers["hotbar"].containerItemPool = {
        [1] = {
            joaat("w_shotgun_doublebarrel"),
            0,
            0
        },
        [3] = {
            joaat("w_molotov")
        },
        [4] = {
            joaat("w_lasso")
        }
    }

    -- draw('inventory')
    draw("hotbar")
end

-- SHARED

function ContainerIsItemValidForIndex(container, item, index)
    --[[
        Item é nulo, então é valido para qualquer slot
    ]]
    if IsThrownInvalidException(item) then
        return true
    end

    local itemType = GetItemType(item)

    if Containers[container].containerHasPages then
        local numIndices = Containers[container].containerNumIndices

        -- Mantimentos
        if (index >= 1) and (index <= numIndices * 1) then
            if itemType == "generic" or itemType == "consumable" then
                return true
            end
            return false
        end
        -- Tonicos
        if (index >= (numIndices * 1)) and (index < (numIndices * 2) - 1) then
            if itemType == "tonic" or itemType == "boost" then
                return true
            end
            return false
        end
        -- Mantimentos
        if (index >= (numIndices * 2)) and (index < (numIndices * 3) - 1) then
            if itemType == "food" or itemType == "beverage" then
                return true
            end
            return false
        end
        -- Equipamentos
        if (index >= (numIndices * 3)) and (index < (numIndices * 4) - 1) then
            if itemType == "weapon" or itemType == "weapon_melee" or itemType == "weapon_thrown" or itemType == "ammo" then
                return true
            end
            return false
        end
        -- Kits
        if (index >= (numIndices * 4)) and (index < (numIndices * 5) - 1) then
            if itemType == "kit" then
                return true
            end
            return false
        end
        -- Alto Valor
        if (index >= (numIndices * 5)) and (index < (numIndices * 6) - 1) then
            if itemType == "valuable" or itemType == "boost" then
                return true
            end
            return false
        end
        -- Documentos
        if (index >= (numIndices * 6)) and (index < (numIndices * 7) - 1) then
            if itemType == "document" or itemType == "map" then
                return true
            end
            return false
        end

        return false
    end

    if container == "hotbar" then
        if index == 1 or index == 2 then
            if itemType == "weapon" then
                return true
            end
        end
        if index == 3 or index == 4 then
            if itemType == "melee" or itemType == "throwable" then
                return true
            end
        end
        if index == 5 then
            return false
        end
        return false
    end

    if container == "crafting" then
        -- Crafting Output
        if index == 10 then
            return false
        end
    end

    if container == "trade-trader" then
        return false
    end

    return false
end

function ContainerGetFirstValidIndexForItem(container, item)
    local itemType = GetItemType(item)

    if not tonumber(item) then
        item = GetItemHashFromId(item)
    end

    print(container, item, itemType)

    local containerItemPool = Containers[container].containerItemPool
    local numIndices = Containers[container].containerNumIndices

    local function loopthrough(s, e)
        print('looping', s, e, item)
        for i = s, e do
            if containerItemPool[i] == nil or containerItemPool[i][1] == item then
                return i
            end
        end
        return nil
    end

    if itemType == "generic" or itemType == "consumable" then
        return loopthrough(1, numIndices)
    end
    -- Tonicos
    if itemType == "tonic" or itemType == "boost" then
        return loopthrough((numIndices * 1) + 1, (numIndices * 2))
    end
    -- Mantimentos
    if itemType == "food" or itemType == "beverage" then
        return loopthrough((numIndices * 2) + 1, (numIndices * 3))
    end
    -- Equipamentos
    if itemType == "weapon" or itemType == "weapon_melee" or itemType == "weapon_thrown" or itemType == "ammo" then
        return loopthrough((numIndices * 3) + 1, (numIndices * 4))
    end
    -- Kits
    if itemType == "kit" then
        return loopthrough((numIndices * 4) + 1, (numIndices * 5))
    end
    -- Alto Valor
    if itemType == "valuable" or itemType == "boost" then
        return loopthrough((numIndices * 5) + 1, (numIndices * 6))
    end
    -- Documentos
    if itemType == "document" or itemType == "map" then
        return loopthrough((numIndices * 6) + 1, (numIndices * 7))
    end

    return nil
end

-- function ContainerGetValidIndicesForItem(container, item)

--     local itemType = GetItemType(item)

--     if itemType ==
-- end

function ContainerIsValid(container)
    return Containers[container] ~= nil
end

function ContainerGetItemAtIndex(container, index)
    return Containers[container].containerItemPool[index]
end

function ContainerGetItemHashAtIndex(container, index)
    local ret

    if ContainerIsValid(container) then
        if ContainerGetItemAtIndex(container, index) ~= nil then
            ret = ContainerGetItemAtIndex(container, index)[1]
        else
            ret = "invalid item"
        end
    else
        ret = "invalid container"
    end

    return ret
end

function ContainerSetItemPool(container, itempool)
    Containers[container].containerItemPool = itempool
end

function ContainerSetTitle(container, title)
    Containers[container].containerTitle = title
end

function GetItemData(item)
    local d
    if tonumber(item) then
        -- item is a itemHash
        d = ItemPool[ItemPoolHash[item]]
    else
        -- item is a itemId
        d = ItemPool[item]
    end
    return d or {}
end

function GetItemHashFromId(itemId)
    return ItemPoolHash[joaat(itemId)] ~= nil and joaat(itemId) or "invalid item id"
end

function GetItemIdFromHash(itemHash)
    return ItemPoolHash[itemHash] or "invalid item hash"
end

function GetItemName(item)
    return GetItemData(item).name or "invalid item name"
end

function GetItemType(item)
    return GetItemData(item).type or "invalid item type"
end

function GetItemMaxStackSize(item)
    return GetItemData(item).maxStackSize or "invalid item type"
end

function IsThrownInvalidException(v)
    if tonumber(v) == nil and v:find("invalid") then
        return true
    end

    return false
end

---------
-- SERVER
---------
