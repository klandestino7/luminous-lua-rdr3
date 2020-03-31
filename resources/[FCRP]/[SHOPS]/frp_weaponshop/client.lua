local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ""
local CurrentActionData = {}
local ShopOpen = false
local ammon = nil
local hasWeaponLicense = true
local prompts = {}
local weaponShopPrompt = false

RegisterNetEvent("frp_weaponshop:sendShop")
AddEventHandler(
    "frp_weaponshop:sendShop",
    function(shopItems)
        for k, v in pairs(shopItems) do
            Config.Zones[k].Items = v
        end
    end
)

function OpenShopMenu(zone)
    local elements = {}
    ShopOpen = true

    SendNUIMessage(
        {
            display = true,
            clear = true
        }
    )

    SetNuiFocus(true, true)

    local zona = Config.Zones[zone].Items

    for typeTable, itemList in pairs(zona) do
        for index, itemData in pairs(itemList) do
            SendNUIMessage(
                {
                    items = itemData
                }
            )
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
    PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)
end

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

AddEventHandler(
    "frp_weaponshop:hasEnteredMarker",
    function(zone)
        if zone == "GunShop" or zone == "BlackWeashop" then
            CurrentAction = "shop_menu"
            CurrentActionMsg = "shop_menu_prompt"
            CurrentActionData = {zone = zone}
        end
    end
)

AddEventHandler(
    "frp_weaponshop:hasExitedMarker",
    function(zone)
        CurrentAction = nil
    end
)

-- Enter / Exit marker events
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            local isInMarker, currentZone = false, nil

            for k, v in pairs(Config.Zones) do
                for i = 1, #v.Locations, 1 do
                    if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.Size.x then
                        isInMarker, ShopItems, currentZone, LastZone = true, v.Items, k, k
                    end
                end
            end
            if isInMarker and not HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = true
                TriggerEvent("frp_weaponshop:hasEnteredMarker", currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent("frp_weaponshop:hasExitedMarker", LastZone)
            end
        end
    end
)

-- Key Controls
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for _, prompt in pairs(prompts) do
                if PromptHasHoldModeCompleted(prompt) then
                    Citizen.Wait(0)
                    OpenShopMenu(CurrentActionData.zone)
                --print('open')
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        for _, v in pairs(Config.Zones) do
            for i = 1, #v.Locations, 1 do
                local values = v.Locations[i]
                local blip = N_0x554d9d53f696d002(1664425300, values[1], values[2], values[3])
                SetBlipSprite(blip, -145868367, 1)
                Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Loja de Armas")

                local prompt = PromptRegisterBegin()
                PromptSetControlAction(prompt, 0xE8342FF2)
                PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Comprar Armas"))
                PromptSetEnabled(prompt, 1)
                PromptSetVisible(prompt, 1)
                PromptSetHoldMode(prompt, 1)
                PromptSetPosition(prompt, values[1], values[2], values[3])
                N_0x0c718001b77ca468(prompt, 3.0)
                -- PrompContextSetSize(prompt, 3.0)
                PromptRegisterEnd(prompt)
                table.insert(prompts, prompt)
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)

RegisterNUICallback(
    "buyItem",
    function(data)
        TriggerServerEvent("FC:WEAPONSHOP:BuyWeapon", data.itemId, tonumber(data.gold))      
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

RegisterNUICallback(
    "focusOff",
    function(data, cb)
        SetNuiFocus(false, false)
        ShopOpen = false
    end
)

RegisterCommand(
    "off",
    function()
        SetNuiFocus(false, false)
        ShopOpen = false
        display = false
        clear = false
        print(ShopOpen, display, clear)
    end
)
