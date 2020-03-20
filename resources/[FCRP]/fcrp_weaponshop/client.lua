local weaponShopGroup = GetRandomIntInRange(0, 0xffffff)
local weaponShopPrompt = false

local shops = {
    {-281.58, 780.66, 118.53}, --VALENTINE
    {1322.87, -1321.48, 76.89}, --RHODES
    {2715.91, -1285.65, 48.63}, --SAINT DENIS
    {2946.53, 1319.66, 44.82}, --ANNESBURG
    {-5508.16, -2964.47, -0.63} --TUMBLEWEED,
}

local prompts = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for _, prompt in pairs(prompts) do
                if PromptHasHoldModeCompleted(prompt) then
                    Citizen.Wait(0)
                    WarMenu.OpenMenu('weaponshop')
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        for _, values in pairs(shops) do
            local blip = N_0x554d9d53f696d002(1664425300, values[1], values[2], values[3])
            SetBlipSprite(blip, -145868367, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Loja de Armas')

            local prompt = PromptRegisterBegin()
            PromptSetControlAction(prompt, 0xE8342FF2)
            PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Abrir'))
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
)

AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)

local weapons = {
    [1] = 'Machado ~pa~$5',
    [2] = 'Faca ~pa~$2',
    [3] = 'Lasso ~pa~$30',
    [4] = 'Tocha ~pa~$5',
    [5] = 'Vara de pescar ~pa~$15',
    [6] = 'Lanterna eletrica ~pa~$10',
    [7] = 'Arco ~pa~$25',
    [8] = 'Revolver Vaqueiro ~pa~$20',
    [9] = 'Carabina de Repetição ~pa~$80',
    [10] = 'Rifle Springfield ~pa~$120'
}

local ammo = {
    [1] = '20 Munições de revolver ~pa~$10',
    [2] = '20 Munições de pistola ~pa~$15',
    [3] = '10 Munições de carabina ~pa~$20',
    [4] = '10 Munições de rifle ~pa~$25',
    [5] = '20 Flechas ~pa~$30',
    [6] = '10 Munições de shotguns ~pa~$35'
}

Citizen.CreateThread(
    function()
        WarMenu.CreateMenu('weaponshop', 'Loja de Armas')
        WarMenu.SetSubTitle('weaponshop', 'Selecione uma Opção')
        WarMenu.CreateSubMenu('melee', 'weaponshop', 'Armas brancas')
        WarMenu.CreateSubMenu('revolvers', 'weaponshop', 'Revolvers')
        WarMenu.CreateSubMenu('repeater', 'weaponshop', 'Arma de repetição')
        WarMenu.CreateSubMenu('rifles', 'weaponshop', 'Rifles')
        WarMenu.CreateSubMenu('ammo', 'weaponshop', 'Munição')

        while true do
            if WarMenu.IsMenuOpened('weaponshop') then
                WarMenu.MenuButton('Armas branca', 'melee')
                WarMenu.MenuButton('Revolvers', 'revolvers')
                WarMenu.MenuButton('Pistolas', 'pistols')
                WarMenu.MenuButton('Arma de repetição', 'repeater')
                WarMenu.MenuButton('Rifles', 'rifles')
                WarMenu.MenuButton('Armas Gold', 'armasgold')
                WarMenu.MenuButton('Munição', 'ammo')
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('melee') then
                for i = 1, 7 do
                    if WarMenu.Button(weapons[i]) then
                        TriggerServerEvent('FCRP:WEAPONSHOP:BuyWeapon', i)
                        WarMenu.CloseMenu()
                    end
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('revolvers') then
                for i = 8, 8 do
                    if WarMenu.Button(weapons[i]) then
                        TriggerServerEvent('FCRP:WEAPONSHOP:BuyWeapon', i)
                        WarMenu.CloseMenu()
                    end
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('repeater') then
                for i = 9, 9 do
                    if WarMenu.Button(weapons[i]) then
                        TriggerServerEvent('FCRP:WEAPONSHOP:BuyWeapon', i)
                        WarMenu.CloseMenu()
                    end
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('rifles') then
                for i = 10, 10 do
                    if WarMenu.Button(weapons[i]) then
                        TriggerServerEvent('FCRP:WEAPONSHOP:BuyWeapon', i)
                        WarMenu.CloseMenu()
                    end
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('ammo') then
                for i = 1, #ammo do
                    if WarMenu.Button(ammo[i]) then
                        TriggerServerEvent('FCRP:WEAPONSHOP:BuyAmmo', i)
                        WarMenu.CloseMenu()
                    end
                end
                WarMenu.Display()
            end
            Citizen.Wait(0)
        end
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str, Citizen.ResultAsLong())
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
