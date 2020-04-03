local itemDatas = {}
local names = {}

-- local defaultItemData = API.ItemData'????????', '????????', 0.1)

function API.getItemDataFromId(id)
    return itemDatas[id]
end

function API.getItemDataFromName(name)
    if names[name] ~= nil then
        return itemDatas[names[name]]
    end
end

function API.getAmmoTypeFromWeaponType(weapon)
    weapon = weapon:upper()

    local ammo = nil

    if weapon == "WEAPON_MOONSHINEJUG" then
        ammo = "AMMO_MOONSHINEJUG"
    end

    if weapon == "WEAPON_FISHINGROD" then
        ammo = "AMMO_FISHINGROD"
    end

    if weapon == "WEAPON_THROWN_THROWING_KNIVES" then
        ammo = "AMMO_THROWING_KNIVES"
    end

    if weapon == "WEAPON_THROWN_TOMAHAWK" then
        ammo = "AMMO_TOMAHAWK"
    end

    if weapon == "WEAPON_THROWN_TOMAHAWK_ANCIENT" then
        ammo = "AMMO_TOMAHAWK_ANCIENT"
    end

    if weapon == "WEAPON_MOONSHINEJUG" then
        ammo = "AMMO_MOONSHINEJUG"
    end

    if weapon:find("_PISTOL_") then
        ammo = "AMMO_PISTOL"
    end

    if weapon:find("_REPEATER_") or weapon:find("WEAPON_RIFLE_VARMINT") then
        ammo = "AMMO_REPEATER"
    end

    if weapon:find("_REVOLVER_") then
        ammo = "AMMO_REVOLVER"
    end

    if weapon:find("_RIFLE_") then
        ammo = "AMMO_RIFLE"
    end

    if weapon:find("_SHOTGUN_") then
        ammo = "AMMO_SHOTGUN"
    end

    if weapon:find("WEAPON_BOW") then
        ammo = "AMMO_ARROW"
    end

    if weapon:find("WEAPON_THROWN_DYNAMITE") then
        ammo = "AMMO_DYNAMITE"
    end

    if weapon:find("WEAPON_THROWN_MOLOTOV") then
        ammo = "AMMO_MOLOTOV"
    end

    return ammo
end

Citizen.CreateThread(
    function()
        for id, values in pairs(ItemList) do
            local ItemData = API.ItemData(id, values.name, values.type, values.weight or 0.1, values.description)

            if values.type == "food" then
                ItemData.triggerOnUse = function(this, User, amount)
                    local hungerVar = values.hungerVar

                    API.varyHunger(User:getSource(), hungerVar)
                    -- TaskPlayScenario eating
                    -- Wait for Scenario to end
                    -- varyHunger

                    return true
                end
            elseif values.type == "beverage" then
                ItemData.triggerOnUse = function(this, User, amount)
                    local thirstVar = values.thirstVar

                    API.varyThirst(User:getSource(), thirstVar)
                    -- TaskPlayScenario drinkin
                    -- Wait for Scenario to end
                    -- varyThirst

                    return true
                end
            elseif values.type == "tonic" then
                ItemData.triggerOnUse = function(this, User, amount)
                    local var = values.var
                    print(id)
                    if id == "tonic_medicine" or id == "tonic" or id == "tonic_potent_medicine" then
                        print(var)
                        cAPI.varyHealth(User:getSource(), var)
                    end

                    if id == "special_tonic" or id == "tonic_special_medicine" or id == "tonic_special_horse_stimulant_crafted" then
                        print(var)
                        cAPI.varyStamina(User:getSource(), var)
                        cAPI.varyEye(User:getSource(), var)
                    end

                    return true
                end
            elseif id == "chest_small" then
                ItemData.triggerOnUse = function(this, User, amount)
                    local var = values.var

                    TriggerEvent("FCRP:CHESTS:StartPlayerPlacement", User:getSource(), var)

                    return true
                end
            elseif id == "chest_medium" then
                ItemData.triggerOnUse = function(this, User, amount)
                    local var = values.var

                    TriggerEvent("FCRP:CHESTS:StartPlayerPlacement", User:getSource(), var)

                    return true
                end
            elseif id == "chest_large" then
                ItemData.triggerOnUse = function(this, User, amount)
                    local var = values.var

                    TriggerEvent("FCRP:CHESTS:StartPlayerPlacement", User:getSource(), var)

                    return true
                end
            end

            if values.type == "weapon" then
                ItemData.triggerOnEnterHotbar = function(this, User, amount)
                    local source = User:getSource()
                    local uWeapons = cAPI.getWeapons(source)

                    local fixedWeaponId = "weapon_" .. id

                    if uWeapons[fixedWeaponId] then
                        User:notify("Arma já está equipada")
                        return false
                    end

                    User:notify("Giving player weapon")
                    Citizen.CreateThread(
                        function()
                            User:giveWeapon(fixedWeaponId, 1)
                        end
                    )

                    return true
                end

                -- Remove from the thread
                -- to prevent weapon not showing
                -- when switching weapons on the hotbar
                ItemData.triggerOnLeaveHotbar = function(this, User)
                    local source = User:getSource()

                    local fixedWeaponId = "weapon_" .. id

                    Citizen.CreateThread(
                        function()
                            User:removeWeapon(fixedWeaponId)
                        end
                    )

                    return true
                end
            elseif values.type == "ammo" then
                ItemData.triggerOnEnterHotbar = function(this, User, amount)
                    local source = User:getSource()
                    local uWeapons = cAPI.getWeapons(source)

                    local supportedWeapon = nil
                    local equipedAmmo = 0

                    for weapon, ammo in pairs(uWeapons) do
                        local ammoType = API.getAmmoTypeFromWeaponType(weapon)
                        if ammoType == id:upper() then
                            supportedWeapon = weapon
                            equipedAmmo = ammo
                            break
                        end
                    end

                    if supportedWeapon == nil then
                        User:notify("Nenhuma arma equipada suporta este tipo de munição!")
                        return false
                    end

                    User:notify("Giving player weapon")
                    Citizen.CreateThread(
                        function()
                            User:giveWeapon(supportedWeapon, amount)
                        end
                    )

                    return true
                end
            end

            itemDatas[id] = ItemData
            names[values.name] = id
        end
    end
)
