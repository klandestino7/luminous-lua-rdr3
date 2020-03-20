local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('FCRP:MUGGIN:TryToMug')
AddEventHandler(
    'FCRP:MUGGIN:TryToMug',
    function(targetSource)
        local _source = source

        local sourcePed = GetPlayerPed(_source)
        local targetPed = GetPlayerPed(targetSource)

        if #(GetEntityCoords(sourcePed) - GetEntityCoords(targetPed)) <= 5 then

            local User = API.getUserFromSource(_source)
            local UserTarget = API.getUserFromSource(targetSource)

            local weaponsTarget = cAPI.replaceWeapons(targetSource, {})

            -- ||||| OPTIMIZATION
            -- Modify Inventory:AddItem Query to INSERT a list of items

            local Inventory = User:getCharacter():getInventory()
            local InventoryTarget = UserTarget:getCharacter():getInventory()

            for id, amount in pairs(InventoryTarget:getItems()) do
                if InventoryTarget:removeItem(id, amount) then
                    Inventory:addItem(id, amount)
                    User:notify('+ x' .. amount .. ' ' .. API.getItemDataFromId(id):getName())
                end
            end

            for weapon, ammo in pairs(weaponsTarget) do
                Inventory:addItem(weapon, 1)
                local ammoType = getAmmoTypeFromWeaponType(weapon)
                if ammoType ~= nil then
                    Inventory:addItem(ammoType, ammo)
                end
            end

            UserTarget:notify("Você foi assaltado!")
        end
    end
)
