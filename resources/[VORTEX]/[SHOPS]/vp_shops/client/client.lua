local fcrpShopGroup = GetRandomIntInRange(0, 0xffffff)
local fcrpShopPrompt = false
local blip = {}
Citizen.CreateThread(function()
    WarMenu.CreateMenu('fcrpShop', 'Loja')
    WarMenu.CreateSubMenu('dollar', 'fcrpShop', 'Comprar por Dolar')
    WarMenu.CreateSubMenu('gold', 'fcrpShop', 'Comprar por Gold')
    while true do
        Citizen.Wait(0)
        for k,v in pairs(Config.Shops) do
            if blip[k] == nil then
                CreateBlip(k, Config.Shops[k].position, Config.Shops[k].shopName, Config.Shops[k].shopSprite)
            end
            WarMenu.SetSubTitle('fcrpShop', Config.Shops[k].shopName)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Shops[k].position.x, Config.Shops[k].position.y,Config.Shops[k].position.z, false) <= 2 then
                if WarMenu.IsMenuOpened('fcrpShop') then
                    if WarMenu.MenuButton('Comprar por Dolar', 'dollar') then
                    end
                    if WarMenu.MenuButton('Comprar por Gold', 'gold') then
                    end
                    WarMenu.Display()
                elseif WarMenu.IsMenuOpened('dollar') then 
                    for y,e in pairs(Config.Shops[k].items) do
                        if WarMenu.Button(Config.Shops[k].items[y].itemName..'~pa~ '..Config.Shops[k].items[y].money..' $') then
                            TriggerServerEvent('frp_shops:buyedItem', false, Config.Shops[k].items[y])
                        end
                    end
                    WarMenu.Display()
                elseif WarMenu.IsMenuOpened('gold') then 
                    for y,e in pairs(Config.Shops[k].items) do
                        if WarMenu.Button(Config.Shops[k].items[y].itemName..'~pa~ '..Config.Shops[k].items[y].gold..' *') then
                            TriggerServerEvent('frp_shops:buyedItem', true, Config.Shops[k].items[y])
                        end
                    end
                    WarMenu.Display()
                end
                if not WarMenu.IsMenuOpened('fcrpShop') then
                    PromptSetActiveGroupThisFrame(fcrpShopGroup, CreateVarString(10, 'LITERAL_STRING', Config.Shops[k].shopName))
                    if PromptHasHoldModeCompleted(fcrpShopPrompt) then
                        WarMenu.OpenMenu('fcrpShop')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('frp_shops:message')
AddEventHandler('frp_shops:message', function(message)
    DisplayHelp(message)
end)

--------------------------------------------------------
----------------VARIAVEIS UTILIZAVEIS-------------------
--------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    SetupfcrpShopPrompts()
end)

function SetupfcrpShopPrompts()
    if not PromptIsValid(fcrpShopPrompt) then
        fcrpShopPrompt = PromptRegisterBegin()
        PromptSetControlAction(fcrpShopPrompt, 0xE8342FF2)
        PromptSetText(fcrpShopPrompt, CreateVarString(10, 'LITERAL_STRING', 'Abrir'))
        PromptSetEnabled(fcrpShopPrompt, 1)
        PromptSetVisible(fcrpShopPrompt, 1)
        PromptSetHoldMode(fcrpShopPrompt, 1)
        PromptSetGroup(fcrpShopPrompt, fcrpShopGroup)
        PromptRegisterEnd(fcrpShopPrompt)
    end
end

function DisplayHelp(_message)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
    SetTextScale(0.25, 0.25)
    SetTextCentre(1)
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end

function CreateBlip(id, pos, name, sprite)
    blip[id] = N_0x554d9d53f696d002(1664425300, pos.x, pos.y, pos.z)
    SetBlipSprite(blip[id], sprite, 1)
    SetBlipScale(blip[id], 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip[id], name)
end