-- 1006.160,-1772.393,47.620

local windows = {
    -- HOUSE:2
    {-1484366741, vec3(-5206.49, -3493.25, -21.63)},
    {-1484366741, vec3(-5207.82, -3488.29, -21.63)},
    {1757176412, vec3(1365.99, -874.96, 70.09)},
    -- HOUSE:3
    {958665900, vec3(1133.95, -983.34, 69.41)}
}

local cDoorGroup
local cDoorIndex

Citizen.CreateThread(
    function()
        -- local ped = PlayerPedId()
        -- local pedVec3 = GetEntityCoords(ped)

        while true do
            for _, v in pairs(windows) do
                local windowModel = v[1]
                local windowVec3 = v[2]

                -- if #(pedVec3 - windowVec3) <= 100 then
                local window = GetClosestObjectOfType(windowVec3, 1.0, windowModel, false, 0, 0)
                if window ~= 0 then
                    SetEntityInvincible(window, true)
                end
                -- end
            end
            Citizen.Wait(1000)
        end
    end
)

local isMenuOpen = false

local prompt_open
local prompt_group_open

local prompt_buy_dollar
local prompt_buy_gold
local prompt_group_buy

local houseCam

local nearAValidPlace = false

local idOfHouseBeingShowcased
local nameOfHouseBeingShowcased

Citizen.CreateThread(
    function()
        local places = {
            vec3(-810.601, -1277.494, 43.638)
        }

        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            nearAValidPlace = false

            for _, v in pairs(places) do
                local dist = #(pCoords - v)
                if dist <= 1.5 then
                    nearAValidPlace = true
                    break
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        initiatePrompt()

        WarMenu.CreateMenu("menu_houses", "Estabulo")
        WarMenu.SetSubTitle("menu_houses", "Selecione uma Opção")
        WarMenu.CreateSubMenu("ownedhouses", "menu_houses", "Minhas Casas")
        WarMenu.CreateSubMenu("availablehouses", "menu_houses", "Casas Disponíveis")

        local selectedHouseId

        -- initiateCameraAtHouseId("house:1")

        local availableHouses = {
            ["house:1"] = {"Mansão Braithwaite", 20.0, 1.0, vec3(1011.094, -1772.385, 47.592), 34.0},
            ["house:2"] = {"Chalé Renegado", 20.0, 1.0, vec3(1370.606, -874.264, 70.132), 25.0},
            ["house:3"] = {"Recanto Dormente", 20.0, 1.0, vec3(1135.113, -979.852, 69.398), 25.0},
            -- ["house:4"] = {"Crackolandia", 20, 1.0, vec3(2497.916,-420.914,44.371), 20.0},
        }

        while true do
            Citizen.Wait(0)

            if nearAValidPlace then
                if houseCam == nil then
                    local isOpen = false

                    if PromptHasHoldModeCompleted(prompt_open) then
                        PromptSetEnabled(prompt_open, false)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(1000)
                                PromptSetEnabled(prompt_open, true)
                            end
                        )

                        WarMenu.OpenMenu("menu_houses")
                    end

                    if WarMenu.IsMenuOpened("menu_houses") then
                        isOpen = true

                        WarMenu.MenuButton("Minhas Casas", "ownedhouses")
                        if WarMenu.MenuButton("Casas Disponíveis", "availablehouses") then
                        end

                        WarMenu.Display()
                    end

                    if WarMenu.IsMenuOpened("ownedhouses") then
                        isOpen = true

                        if selectedHouseId ~= nil then
                            selectedHouseId = nil
                        end

                        WarMenu.Display()
                    end

                    if WarMenu.IsMenuOpened("availablehouses") then
                        isOpen = true

                        for houseId, v in pairs(availableHouses) do
                            if WarMenu.Button(v[1]) then
                                selectedHouseId = houseId
                                idOfHouseBeingShowcased = houseId
                                nameOfHouseBeingShowcased = v[1]
                                PromptSetText(prompt_buy_dollar, CreateVarString(10, "LITERAL_STRING", "$" .. v[2]))
                                PromptSetEnabled(prompt_buy_dollar, true)
                                PromptSetText(prompt_buy_gold, CreateVarString(10, "LITERAL_STRING", "~t4~G" .. v[3]))
                                PromptSetEnabled(prompt_buy_gold, true)
                                initiateCameraAtCenter(GetEntityCoords(PlayerPedId()), v[4], v[5])
                                break
                            end
                        end

                        WarMenu.Display()
                    end

                    isMenuOpen = isOpen

                    if not isMenuOpen then
                        PromptSetActiveGroupThisFrame(prompt_group_open, CreateVarString(10, "LITERAL_STRING", "Casas"))
                    end
                else
                    PromptSetActiveGroupThisFrame(prompt_group_buy, CreateVarString(10, "LITERAL_STRING", nameOfHouseBeingShowcased))

                    local withGold = false
                    local promptBuyPressed

                    if PromptHasHoldModeCompleted(prompt_buy_dollar) then
                        promptBuyPressed = prompt_buy_dollar
                        withGold = false
                    end

                    if PromptHasHoldModeCompleted(prompt_buy_gold) then
                        promptBuyPressed = prompt_buy_gold
                        withGold = true
                    end

                    if promptBuyPressed ~= nil then
                        PromptSetEnabled(promptBuyPressed, false)
                        TriggerServerEvent("VP:HOUSING:TryToBuyHouse", idOfHouseBeingShowcased, withGold)

                        destroy()
                        WarMenu.OpenMenu("availablehouses")
                        promptBuyPressed = nil
                    end

                    if PromptIsJustPressed(prompt_cancel) then
                        destroy()
                        WarMenu.OpenMenu("availablehouses")
                    end
                end
            end
        end
    end
)

function initiatePrompt()
    prompt_open = PromptRegisterBegin()
    prompt_group_open = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt_open, 0xDFF812F9)
    PromptSetText(prompt_open, CreateVarString(10, "LITERAL_STRING", "Abrir"))
    PromptSetEnabled(prompt_open, 1)
    PromptSetVisible(prompt_open, 1)
    -- PromptSetPosition(prompt, )
    -- N_0x0c718001b77ca468(prompt, 2.0)
    PromptSetHoldMode(prompt_open, 1)
    PromptSetGroup(prompt_open, prompt_group_open)
    PromptRegisterEnd(prompt_open)

    prompt_group_buy = GetRandomIntInRange(0, 0xffffff)

    prompt_cancel = PromptRegisterBegin()
    PromptSetControlAction(prompt_cancel, 0xDFF812F9)
    PromptSetText(prompt_cancel, CreateVarString(10, "LITERAL_STRING", "Voltar"))
    PromptSetEnabled(prompt_cancel, 1)
    PromptSetVisible(prompt_cancel, 1)
    PromptSetStandardMode(prompt_cancel, 1)
    PromptSetGroup(prompt_cancel, prompt_group_buy)
    PromptRegisterEnd(prompt_cancel)

    prompt_buy_dollar = PromptRegisterBegin()
    PromptSetControlAction(prompt_buy_dollar, 0x07CE1E61) -- LMB
    PromptSetText(prompt_buy_dollar, CreateVarString(10, "LITERAL_STRING", "$"))
    PromptSetEnabled(prompt_buy_dollar, 1)
    PromptSetVisible(prompt_buy_dollar, 1)
    PromptSetHoldMode(prompt_buy_dollar, 1)
    PromptSetGroup(prompt_buy_dollar, prompt_group_buy)
    PromptRegisterEnd(prompt_buy_dollar)

    prompt_buy_gold = PromptRegisterBegin()
    PromptSetControlAction(prompt_buy_gold, 0xF84FA74F) -- RMB
    PromptSetText(prompt_buy_gold, CreateVarString(10, "LITERAL_STRING", "~t4~G"))
    PromptSetEnabled(prompt_buy_gold, 1)
    PromptSetVisible(prompt_buy_gold, 1)
    PromptSetHoldMode(prompt_buy_gold, 1)
    PromptSetGroup(prompt_buy_gold, prompt_group_buy)
    PromptRegisterEnd(prompt_buy_gold)
end

function initiateCameraAtCenter(coordsFrom, center, r)
    SetCamActive(houseCam, false)
    DestroyCam(houseCam, true)
    houseCam = nil

    -- houseCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",coordsFrom, 300.00, 0.00, 0.00, 60.0, false, 2) -- CAMERA COORDS
    -- PointCamAtCoord(houseCam, center)
    -- SetCamActive(houseCam, true)

    local minHeightAboveGround = 3.5

    local Cx = center.x
    local Cy = center.y
    local z = center.z + minHeightAboveGround

    X_deg0 = Cx + (r * math.cos(0))
    Y_deg0 = Cy + (r * math.sin(0))

    -- local initialCam = houseCam

    houseCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", vec3(X_deg0, Y_deg0, z), 300.00, 0.00, 0.00, 60.0, false, 2) -- CAMERA COORDS
    PointCamAtCoord(houseCam, center)
    -- SetCamActiveWithInterp(houseCam, initialCam, 60000, true, true)
    SetCamActive(houseCam, true)

    RenderScriptCams(true, true, 1, true, true)
    -- RenderScriptCams(true, true, 500, true, true)

    SetFocusPosAndVel(center, 0.0, 0.0, 0.0)

    Citizen.CreateThread(
        function()
            while houseCam ~= nil do
                Citizen.Wait(0)
                if IsCamRendering(houseCam) and houseCam ~= nil then
                    if initialCam ~= nil then
                        SetCamActive(initialCam, false)
                        DestroyCam(initialCam, true)
                        initialCam = nil
                    end

                    for i = 0, 32 do
                        if NetworkIsPlayerActive(i) then
                            SetPlayerInvisibleLocally(i, true)
                        end
                    end

                    for i = 0, 360, 0.50 do
                        i = math.rad(i)
                        local X_deg0 = Cx + (r * math.cos(i))
                        local Y_deg0 = Cy + (r * math.sin(i))

                        local camVec = vec3(X_deg0, Y_deg0, z)

                        local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(camVec.x, camVec.y, camVec.z)

                        if math.abs(z - groundZ) < minHeightAboveGround then
                            camVec = vec3(camVec.xy, groundZ + minHeightAboveGround)
                        end

                        Wait(0)
                        -- SetEntityCoords(PlayerPedId(), camVec, 0, 0, 0, 0)
                        SetCamCoord(houseCam, camVec.x, camVec.y, camVec.z)
                        PointCamAtCoord(houseCam, center)
                        -- PointCamAtCoord(houseCam, center)

                        -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, center, vec3(X_deg0, Y_deg0, y), 255, 0, 0, 255)
                    end
                end
            end
        end
    )
end

function destroy()
    SetCamActive(houseCam, false)
    DestroyCam(houseCam, true)
    houseCam = nil
    idOfHouseBeingShowcased = nil
    nameOfHouseBeingShowcased = nil
    ClearFocus()

    for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
            SetPlayerInvisibleLocally(i, false)
        end
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            PromptDelete(prompt_open)
            PromptDelete(prompt_buy_dollar)
            PromptDelete(prompt_buy_gold)
            PromptDelete(prompt_cancel)
            destroy()
        end
    end
)
