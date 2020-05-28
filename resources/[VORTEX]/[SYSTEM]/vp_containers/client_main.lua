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
                -- draw('extra')
                -- draw('trade-player')
                -- draw('trade-trader')
                -- draw('crafting')
                -- draw("shop")


                -- ContainerTryToAddItem("inventory", {"w_lasso"})

                -- Wait(2000)

                -- ContainerTryToRemoveItem("inventory", "w_lasso", 1)
            end
        end
    end
)

Containers = {}

Containers["inventory"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 9 * 3,
    containerTitle = "Inventory",
    containerIsOpen = false,
    containerHasPages = true,
    containerMaxWeight = 20.0
}

Containers["hotbar"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4
}

Containers["extra"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 9 * 3,
    containerTitle = "Extra",
    containerIsOpen = false,
    containerHasPages = true,
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
    containerTitle = "Shop",
    containerIsOpen = false
}

Containers["trade-player"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4 * 2,
    containerTitle = "You",
    containerIsOpen = false
}

Containers["trade-trader"] = {
    containerItemPool = {},
    containerActivePage = 1,
    containerNumIndices = 4 * 2,
    containerTitle = "key_value",
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
        ContainerHotbarOnDraw()
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

        local itemContainerData_from = Containers[container_from].containerItemPool[slot_from]
        local itemContainerData_to = Containers[container_to].containerItemPool[slot_to]

        local itemHash_from = ContainerGetItemHashAtIndex(container_from, slot_from)
        local itemHash_to = ContainerGetItemHashAtIndex(container_to, slot_to)

        if not ContainerIsItemValidForIndex(container_to, itemHash_from, slot_to) or not ContainerIsItemValidForIndex(container_from, itemHash_to, slot_from) then
            draw(container_from)
            return
        end

        local itemType_from = ItemGetType(itemHash_from)
        local itemType_to = ItemGetType(itemHash_to)

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
                            local itemId_from = ItemGetIdFromHash(itemHash_from)
                            local itemId_to = ItemGetIdFromHash(itemHash_to)
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

function switchContainerSlots(st1, st2)
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
            1
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

function IsThrownInvalidException(v)
    if tonumber(v) == nil and v:find("invalid") then
        return true
    end

    return false
end

function ContainerHotbarOnDraw()
    -- cAPI.replaceWeapons({})
    for _, v in pairs(Containers["hotbar"].containerItemPool) do
        local itemId = ItemPoolHash[v[1]]
        local itemAmmoInClip = v[2] or 1
        local itemAmmoInWeapon = v[3] or 1
        local weaponModel = itemId:gsub("w_", "weapon_")
        local weaponHash = GetHashKey(weaponModel)

        -- print("gave weapon", weaponModel)

        GiveWeaponToPed(PlayerPedId(), weaponHash, itemAmmoInWeapon, false, false)
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() or resourceName == "_core" then
            SetNuiFocus(false, false)
            SendNUIMessage(
                {
                    messageType = "hide"
                }
            )
        end
    end
)
