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



Citizen.CreateThread(
    function()
        for id, values in pairs(ItemList) do
            local ItemData = API.ItemData(id, values.name, values.type, values.weight or 0.1, values.description, values.stack)

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

            -- if values.type == "weapon" then
            --     ItemData.triggerOnEnterHotbar = function(this, User, amount)
            --         local source = User:getSource()
            --         local uWeapons = cAPI.getWeapons(source)

            --         local fixedWeaponId = "weapon_" .. id

            --         if uWeapons[fixedWeaponId] then
            --             User:notify("Arma já está equipada")
            --             return false
            --         end

            --         User:notify("Giving player weapon")
            --         Citizen.CreateThread(
            --             function()
            --                 User:giveWeapon(fixedWeaponId, 1)
            --             end
            --         )

            --         return true
            --     end

            --     -- Remove from the thread
            --     -- to prevent weapon not showing
            --     -- when switching weapons on the hotbar
            --     ItemData.triggerOnLeaveHotbar = function(this, User)
            --         local source = User:getSource()

            --         local fixedWeaponId = "weapon_" .. id

            --         Citizen.CreateThread(
            --             function()
            --                 User:removeWeapon(fixedWeaponId)
            --             end
            --         )

            --         return true
            --     end
            -- else
            if values.type == "ammo" then
                ItemData.triggerOnEnterHotbar = function(this, User, amount, slotToItemId)
                    print('tiggered', User, amount, slotToItemId)
                    local source = User:getSource()
                    local uWeapons = cAPI.getWeapons(source)

                    local weaponId = "weapon_" .. slotToItemId

                    local ammoType = API.getAmmoTypeFromWeaponType(weaponId)
                    print('ammotype', ammoType)
                    if ammoType == nil or ammoType ~= id:upper() then
                        User:notify("Essa arma não suporta esse tipo de munição!")
                        return false
                    end


                    User:notify("Giving player weapon")
                    Citizen.CreateThread(
                        function()
                            User:giveWeapon(weaponId, amount)
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
