local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Tunnel.getInterface('API')
cAPI = Proxy.getInterface('API')

local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local ShopOpen = false
local ammon = nil
local hasWeaponLicense = true

RegisterNetEvent('nc_weaponshop:sendShop')
AddEventHandler('nc_weaponshop:sendShop', function(shopItems)
    for k,v in pairs(shopItems) do
        Config.Zones[k].Items = v
    end
end)

function OpenShopMenu(zone)
    local elements = {}
    ShopOpen = true

    SendNUIMessage({
        display = true,
        clear = true
    })

    SetNuiFocus(true, true)

    local zona = Config.Zones[zone].Items

    for typeTable, itemList in pairs(zona) do
        for index, itemData in pairs(itemList) do
            SendNUIMessage({
                items = itemData
            })    
        end
        -- if typeTable == "Weapon" then
        --     for index, itemData in pairs(itemList) do
        --         SendNUIMessage({
        --             weapon = itemData
        --         })                
        --     end
        -- end
        -- if typeTable == "Ammo" then
        --     for _, itemData in pairs(itemList) do
        --         SendNUIMessage({
        --             ammo = itemData
        --         })
        --     end
        -- end
        -- if typeTable == "Melee" then
        --     for _, itemData in pairs(itemList) do
        --         SendNUIMessage({
        --             melee = itemData
        --         })
        --     end
        -- end
    end
    PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
end




RegisterCommand("go", function()
    wanted_model="cs_dreyfuss"
    modelHash = GetHashKey(wanted_model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end    
        ammon = CreatePed(5, modelHash , 22.79,-1105.52,29.79, 160.0, false, false)
        SetEntityAsMissionEntity(ammon)
        Wait(1500)
        SetPedDesiredHeading(ammon, 160.0)        
end, false)


AddEventHandler('nc_weaponshop:hasEnteredMarker', function(zone)
    if zone == 'GunShop' or zone == 'BlackWeashop' then
        CurrentAction     = 'shop_menu'
        CurrentActionMsg  = 'shop_menu_prompt'
        CurrentActionData = { zone = zone }
    end
end)

AddEventHandler('nc_weaponshop:hasExitedMarker', function(zone)
    CurrentAction = nil

end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if ShopOpen then

        end
    end
end)

-- Create Blips
Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        if v.Legal then
            for i = 1, #v.Locations, 1 do
                local blip = AddBlipForCoord(v.Locations[i])
                SetBlipSprite (blip, 110)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 0.7)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName('map_blip')
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)

-- Display markers
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Locations, 1 do
                if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.DrawDistance) then
                    DrawMarker(Config.Type, v.Locations[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                end
            end
        end
    end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        local isInMarker, currentZone = false, nil

        for k,v in pairs(Config.Zones) do
            for i=1, #v.Locations, 1 do
                if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.Size.x then
                    isInMarker, ShopItems, currentZone, LastZone = true, v.Items, k, k
                end
            end
        end
        if isInMarker and not HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = true
            TriggerEvent('nc_weaponshop:hasEnteredMarker', currentZone)
        end
        
        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('nc_weaponshop:hasExitedMarker', LastZone)
        end
    end
end)

-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction ~= nil then         
            if IsControlJustReleased(0, 38) then
                if CurrentAction == 'shop_menu' then
                    if Config.LicenseEnable and Config.Zones[CurrentActionData.zone].Legal then        
                            if hasWeaponLicense then
                                OpenShopMenu(CurrentActionData.zone)
                            else
                            --    exports['mythic_notify']:SendAlert('inform', 'Nie posiadasz licencji!', 2500, { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' })
                            end
                         GetPlayerServerId(PlayerId(), 'weapon')
                    else
                        OpenShopMenu(CurrentActionData.zone)
                    end
                end
                CurrentAction = nil
            end
        end
    end
end)

RegisterNUICallback('buyItem', function(data, cb)    
    PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
    local animLib = "mp_cop_armoury"
    RequestAnimDict(animLib)    
    local weaponHash = data.itemId
    print(weaponHash)
    NetworkRequestControlOfEntity(ammon)
    TaskPlayAnim(ammon, "mp_cop_armoury", 'pistol_on_counter_cop', 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
    GiveWeaponToPed(ammon, GetHashKey(weaponHash), 1, false, true)
    SetCurrentPedWeapon(ammon, GetHashKey(weaponHash), true)
    TaskPlayAnim(PlayerPedId(), "mp_cop_armoury", 'pistol_on_counter', 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
    Citizen.Wait(2000)
    RemoveWeaponFromPed(ammon, GetHashKey(weaponHash))
    Citizen.Wait(15)
    GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponHash), Config.ReceiveAmmo, false, true)        
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)
    ClearPedTasks(ammon)               
    Citizen.Wait(3000) 
end)

RegisterNUICallback('focusOff', function(data, cb)
    SetNuiFocus(false, false)
end)       