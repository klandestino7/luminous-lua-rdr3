local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local nearAShop = nil

local sentFirstData = false

local desiredHeading = nil

Citizen.CreateThread(
    function()
        for shopId, shopLocations in pairs(Config.ShopLocations) do
            for _, locationData in pairs(shopLocations) do
                local x, y, z, _ = table.unpack(locationData)
                local blip = AddBlipForCoord(x, y, z)
                SetBlipSprite(blip, 110)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.7)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName("map_blip")
                EndTextCommandSetBlipName(blip)
            end
        end

        while true do
            Citizen.Wait(1000)

            nearAShop = false
            -- print('desiredHeading is nil')
            desiredHeading = nil

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            local lastNearDistance = 50

            for shopId, shopLocations in pairs(Config.ShopLocations) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(pCoords - vec)
                    if dist <= lastNearDistance then
                        lastNearDistance = dist
                        nearAShop = true
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3)

            if nearAShop ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                for shopId, shopLocations in pairs(Config.ShopLocations) do
                    for _, locationData in pairs(shopLocations) do
                        local x, y, z, h = table.unpack(locationData)
                        local vec = vec3(x, y, z - 0.97)
                        local dist = #(pCoords - vec)
                        if dist <= 50.0 then
                            DrawMarker(Config.Type, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                            if dist <= 1.5 then
                                -- if h ~= nil then
                                -- TaskPedSlideToCoord(ped, x, y, z, h, 1000)
                                --     TaskAchieveHeading(ped, h, 500)
                                -- end

                                if IsControlJustPressed(0, 38) then
                                    if sentFirstData == true then
                                        SendNUIMessage(
                                            {
                                                display = true,
                                                shopId = shopId
                                            }
                                        )
                                    else
                                        local temp_ConfigShopData = Config.ShopDatas

                                        for _, shopData in pairs(temp_ConfigShopData) do
                                            for _, shopItemData in pairs(shopData.weapon) do
                                                local itemData = ItemList[shopItemData.itemId]
                                                if itemData then
                                                    shopItemData.name = itemData.name
                                                end
                                            end
                                            for _, shopItemData in pairs(shopData.ammo) do
                                                local itemData = ItemList[shopItemData.itemId]
                                                if itemData then
                                                    shopItemData.name = itemData.name
                                                end
                                            end
                                            for _, shopItemData in pairs(shopData.melee) do
                                                local itemData = ItemList[shopItemData.itemId]
                                                if itemData then
                                                    shopItemData.name = itemData.name
                                                end
                                            end
                                        end

                                        SendNUIMessage(
                                            {
                                                display = true,
                                                shopId = shopId,
                                                firstTimeData = temp_ConfigShopData
                                            }
                                        )
                                        sentFirstData = true
                                    end
                                    desiredHeading = h
                                    -- print(h, desiredHeading)
                                    SetNuiFocus(true, true)
                                    PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)

RegisterCommand(
    "go",
    function()
        wanted_model = "cs_dreyfuss"
        modelHash = GetHashKey(wanted_model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(1)
        end
        ammon = CreatePed(5, modelHash, 22.79, -1105.52, 29.79, 160.0, false, false)
        SetEntityAsMissionEntity(ammon)
        Wait(1500)
        SetPedDesiredHeading(ammon, 160.0)
    end,
    false
)

RegisterNUICallback(
    "buyItem",
    function(data, cb)
        TriggerServerEvent("CK:WEAPONSHOP:TryToBuy", data.shopId, data.itemId)
    end
)

RegisterNetEvent("CK:WEAPONSHOP:BuyingAnimation")
AddEventHandler(
    "CK:WEAPONSHOP:BuyingAnimation",
    function(itemId)
        PlaySoundFrontend(-1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", false)

        local animDict = "mp_cop_armoury"
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(10)
        end

        local ped = PlayerPedId()
        local objectHash
        local lastAmmoCount = nil
        local gaveWeapon = false

        -- print(itemId)

        if itemId:find("weapon_") then
            objectHash = GetHashKey(itemId)
        else
            -- objectHash = GetHashKey("prop_box_ammo01a")
            objectHash = GetHashKey("WEAPON_BRIEFCASE")
        end

        if HasPedGotWeapon(ped, objectHash, false) then
            lastAmmoCount = GetAmmoInPedWeapon(ped, objectHash)
        end

        -- RequestModel(objectHash)
        -- while not HasModelLoaded(objectHash) do
        --     Citizen.Wait(10)
        -- end

        -- TaskPlayAnim(ammon, "mp_cop_armoury", "pistol_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
        -- GiveWeaponToPed(ammon, GetHashKey(weaponHash), 1, false, true)
        -- SetCurrentPedWeapon(ammon, GetHashKey(weaponHash), true)

        SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"), true)
        -- SetPedCurrentWeaponVisible(ped, false, false, 0, 0)
        TaskAchieveHeading(ped, desiredHeading, 1000)
        -- print('desiredHeading', desiredHeading)
        desiredHeading = nil
        -- print('desiredHeading is nil')

        -- Citizen.Wait(1100)

        TaskPlayAnim(ped, "mp_cop_armoury", "pistol_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

        Citizen.Wait(3100)

        -- RemoveWeaponFromPed(ammon, GetHashKey(weaponHash))
        -- SetPedCurrentWeaponVisible(ped, true, false, 0, 0)

        Citizen.Wait(15)

        if not HasPedGotWeapon(ped, objectHash, false) then
            GiveWeaponToPed(ped, objectHash, 1, false, true)
            gaveWeapon = true
        end

        SetCurrentPedWeapon(ped, objectHash, true)

        print("gaveWeapon", gaveWeapon)
        if gaveWeapon then
            while IsEntityPlayingAnim(ped, "mp_cop_armoury", "pistol_on_counter", 3) do
                Citizen.Wait(0)
            end

            SetPedAmmo(ped, objectHash, 0)

            print(lastAmmoCount)
            if lastAmmoCount ~= nil and lastAmmoCount > 0 then
                GiveWeaponToPed(ped, objectHash, lastAmmoCount, false, true)
            else
                RemoveWeaponFromPed(ped, objectHash)
            end
        end

        -- ClearPedTasks(ammon)
    end
)

RegisterNUICallback(
    "focusOff",
    function(data, cb)
        SetNuiFocus(false, false)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SendNUIMessage(
                {
                    display = false
                }
            )
            SetNuiFocus(false, false)
        end
    end
)

RegisterCommand(
    "h",
    function(source, args, rawCommand)
        print(GetEntityHeading(PlayerPedId()))
    end,
    false
)
