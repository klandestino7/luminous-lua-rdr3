local itemDatas = {}
local names = {}

local defaultItemData = API.ItemData('????????', '????????', 0.1)

function API.getItemDataFromId(id)
    return itemDatas[id] or defaultItemData
end

function API.getItemDataFromName(name)
    if names[name] ~= nil then
        return itemDatas[names[name]] or defaultItemData
    end
    return defaultItemData
end

Citizen.CreateThread(
    function()
        for id, values in pairs(ItemList) do
            local ItemData = API.ItemData(id, values.name, values.weight or 0.1, values.subtitle)

            if id:find('weapon_') then
                ItemData:onUse(
                    function(this, User, amount)
                        local source = User:getSource()
                        local uWeapons = cAPI.getWeapons(source)

                        print('ye')

                        print(uWeapons)
                        print(uWeapons[id:upper()])
                        if uWeapons[id:upper()] then
                            print('equipda')
                            User:notify('Arma já está equipada')
                            return false
                        end

                        print("yeas")

                        Citizen.CreateThread(
                            function()
                                print('gave')
                                User:notify(ItemData:getName() .. ' equipada!')
                                User:giveWeapon(id, 0, false)
                                print('gvaye')
                            end
                        )

                        print('returnd')
                        return true
                    end
                )
            end

            if id:find('ammo_') then
                ItemData:onUse(
                    function(this, User, amount)
                        local source = User:getSource()
                        local uWeapons = cAPI.getWeapons(source)
                        local formattedId = id:gsub('ammo_', 'weapon_'):upper()

                        if uWeapons[formattedId] == nil then
                            User:notify('Nenhuma arma equipada suporta este tipo de munição!')
                            return false
                        end

                        local equipedAmmo = uWeapons[formattedId]

                        Citizen.CreateThread(
                            function()
                                User:giveWeapon(formattedId, equipedAmmo + amount)
                            end
                        )
                        return true
                    end
                )
            end

            if values.type == 'food' then
                ItemData:onUse(
                    function(this, User, amount)
                        local hungerVar = values.hungerVar

                        API.varyHunger(User:getSource(), hungerVar)
                        -- TaskPlayScenario eating
                        -- Wait for Scenario to end
                        -- varyHunger

                        return true
                    end
                )
            end

            if values.type == 'beverage' then
                ItemData:onUse(
                    function(this, User, amount)
                        local thirstVar = values.thirstVar

                        API.varyThirst(User:getSource(), thirstVar)
                        -- TaskPlayScenario drinkin
                        -- Wait for Scenario to end
                        -- varyThirst

                        return true
                    end
                )
            end

            if id:find('tonic_') then
                ItemData:onUse(
                    function(this, User, amount)
                        local var = values.var
                        if id == 'medicine' or id == 'tonic' or id == 'potent_medicine' then
                            cAPI.varyHealth(User:getSource(), var)
                        end

                        if id == 'special_tonic' or id == 'special_medicine' or id == 'special_horse_stimulant_crafted' then
                            cAPI.varyStamina(User:getSource(), var)
                        end

                        return true
                    end
                )
            end

            itemDatas[id] = ItemData
            names[values.name] = id
        end
    end
)