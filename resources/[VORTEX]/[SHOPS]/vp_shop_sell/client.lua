local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local closestShopId
local closestShopVector

local sentFirstData = false

Citizen.CreateThread(
    function()
        for shopId, shopLocations in pairs(Config.ShopLocations) do
            -- for _, locationData in pairs(shopLocations) do
            --     local x, y, z, _ = table.unpack(locationData)
            --     local blip = AddBlipForCoord(x, y, z)
            --     SetBlipSprite(blip, 110)
            --     SetBlipDisplay(blip, 4)
            --     SetBlipScale(blip, 0.7)
            --     SetBlipAsShortRange(blip, true)
            --     BeginTextCommandSetBlipName("STRING")
            --     AddTextComponentSubstringPlayerName("map_blip")
            --     EndTextCommandSetBlipName(blip)
            -- end
        end

        while true do
            Citizen.Wait(1000)

            closestShopId = nil
            closestShopVector = nil

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            for shopId, shopLocations in pairs(Config.ShopLocations) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(pCoords - vec)
                    if dist <= 50 then
                        closestShopId = shopId
                        closestShopVector = vec
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if closestShopId ~= nil then

                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                if #(pCoords - closestShopVector) <= 1.5 then
                    if IsControlJustPressed(0, 0xDFF812F9) then
                        if sentFirstData == true then
                            SendNUIMessage(
                                {
                                    display = true,
                                    shopId = closestShopId
                                }
                            )
                        else
                            local temp_ConfigShopData = Config.ShopDatas

                            for _, shopData in pairs(temp_ConfigShopData) do
                                for key, value in pairs(shopData) do
                                    if key ~= "name" then
                                        for _, shopItemData in pairs(value) do
                                            local itemData = ItemList[shopItemData[1]]
                                            if itemData then
                                                shopItemData[4] = itemData.name
                                                shopItemData[5] = itemData.weight
                                            end
                                        end
                                    end
                                end
                            end

                            SendNUIMessage(
                                {
                                    display = true,
                                    shopId = closestShopId,
                                    firstTimeData = temp_ConfigShopData
                                }
                            )
                            sentFirstData = true
                        end
                        SetNuiFocus(true, true)
                        -- PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)
                    end
                end
            end
        end
    end
)

RegisterNUICallback(
    "buyItem",
    function(data, cb)
        TriggerServerEvent("VP:SHOP:TryToSell", data.shopId, data.itemId, data.withGold)
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
