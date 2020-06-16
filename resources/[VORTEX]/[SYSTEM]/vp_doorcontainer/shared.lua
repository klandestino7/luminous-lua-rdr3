local SERVER = IsDuplicityVersion()
local CLIENT = not SERVER

-- doorHash { doorState | doorPair | doorMinGroup }
local doorStates = {
    -- MANSÃO
    -- [1595076728] = {false, 1439227364},
    -- [1439227364] = {false, 1595076728},
    -- [530930529] = {false, 1299101427},
    -- [1299101427] = {false, 530930529},
    -- [764233269] = {false},
    -- [2504431014] = {false},
    -- HOUSE:1
    [1282705079] = {false},
    [1511858696] = {false},
    -- HOUSE:2
    [3929468747] = {false},
    -- HOUSE:3
    [2847752952] = {false, 1963415953},
    [1963415953] = {false, 2847752952},
    -- HOUSE:4
    [52014802] = {false},
    -- HOUSE:5
    [3268076220] = {false},
    -- HOUSE:6
    [1434140379] = {false},
    -- HOUSE:7
    [1934463007] = {false},
    -----------------------------------
    -- OFFICER/JAIL
    [1207903970] = {false},
    [902070893] = {false},
    [831345624] = {false},
    [2677989449] = {false},
    [2984805596] = {false},
    [1711767580] = {false},
    [1995743734] = {false},
    [2515591150] = {false},
    [3365520707] = {false},
    [2167775834] = {false},
    [2514996158] = {false},
    [2810801921] = {false},
    [3410720590] = {false, 3821185084},
    [3821185084] = {false, 3410720590},
    [1878514758] = {false},
    [1147152658] = {false},
    [1514359658] = {false},
    [1821044729] = {false},
    [1508776842] = {false},
    [295355979] = {false},
    [193903155] = {false},
    [395506985] = {false},
    [1988748538] = {false},
    [1657401918] = {false},
    [1502928852] = {false},
    [2212368673] = {false},
    -----------------------------------
    -- SHERIFF
    [349074475] = {false},
    -- BANKS DOORS
    [3317756151] = {true, 3088209306},
    [3088209306] = {true, 3317756151},
    [2158285782] = {true, 1733501235},
    [1733501235] = {true, 2158285782},
    [2089945615] = {true, 2817024187},
    [2817024187] = {true, 2089945615},
    [1751238140] = {false},
    [531022111] = {true},
    -- GUNSMITH VALENTINE
    [2042647667] = {false},
    [475159788] = {false},
    -- MEDIC VALENTINE
    [3439738919] = {false},
    -- STABLE VALENTINEVALENTINE
    [1132010214] = {false, 1876749464},
    [1331491364] = {false, 1876749464}
}

-- TALVEZ MUDAR O SISTEMA PARA O CLIENT SÓ PEDIR O SYNC
-- DE x PORTA QUANDO ELE ESTIVER PROXIMO DA PORTA!

Citizen.CreateThread(
    function()
        if SERVER then
            local Tunnel = module("_core", "lib/Tunnel")
            local Proxy = module("_core", "lib/Proxy")

            API = Proxy.getInterface("API")
            cAPI = Tunnel.getInterface("API")

            function setControllableDoorsForGroup(group, doorHashArray)
                for _, doorHash in pairs(doorHashArray) do
                    if doorStates[doorHash] then
                        doorStates[doorHash][3] = group
                    end
                end
            end

            -- setControllableDoorsForGroup(
            --     "house:1",
            --     {
            --         1595076728,
            --         1439227364,
            --         530930529,
            --         1299101427,
            --         764233269,
            --         2504431014
            --     }
            -- )

            setControllableDoorsForGroup(
                "house:1",
                {
                    1282705079,
                    1511858696
                }
            )

            setControllableDoorsForGroup(
                "house:2",
                {
                    3929468747
                }
            )

            setControllableDoorsForGroup(
                "house:3",
                {
                    2847752952,
                    1963415953
                }
            )

            setControllableDoorsForGroup(
                "house:4",
                {
                    52014802
                }
            )

            setControllableDoorsForGroup(
                "house:5",
                {
                    3268076220
                }
            )

            setControllableDoorsForGroup(
                "house:6",
                {
                    1434140379
                }
            )

            setControllableDoorsForGroup(
                "house:7",
                {
                    1934463007
                }
            )

            -- setControllableDoorsForGroup(
            --     "house:4",
            --     {
            --         1377231573
            --     }
            -- )

            setControllableDoorsForGroup(
                "trooper",
                {
                    1207903970,
                    902070893,
                    831345624,
                    2677989449,
                    2984805596,
                    1711767580,
                    1995743734,
                    2515591150,
                    3365520707,
                    2167775834,
                    2514996158,
                    2810801921,
                    3410720590,
                    3821185084,
                    1878514758,
                    1147152658,
                    1514359658,
                    1821044729,
                    1508776842,
                    295355979,
                    193903155,
                    395506985,
                    1988748538,
                    1657401918,
                    1502928852,
                    2212368673
                }
            )

            setControllableDoorsForGroup(
                "sheriff",
                {
                    349074475,
                    1751238140
                }
            )

            RegisterNetEvent("VP:DOORSTATECONTAINER:TryToToggleDoorState")
            AddEventHandler(
                "VP:DOORSTATECONTAINER:TryToToggleDoorState",
                function(doorHash)
                    local _source = source
                    local User = API.getUserFromSource(_source)

                    if not doorStates[doorHash] then
                        User:notify("error", "ERROR PORTA REGISTRADA???")
                        return
                    end

                    local doorGroup = "admin"

                    if doorStates[doorHash][3] ~= nil then
                        doorGroup = doorStates[doorHash][3]
                    end

                    local Character = User:getCharacter()
                    if Character == nil or not Character:hasGroupOrInheritance(doorGroup) then
                        User:notify("error", "Você não pode abrir esta porta")
                        return
                    end

                    local newDoorState = not doorStates[doorHash][1]
                    doorStates[doorHash][1] = newDoorState

                    if doorStates[doorHash][2] ~= nil then
                        local doorPair = doorStates[doorHash][2]
                        print("Porta " .. doorHash .. " com par, porém o par não foi definido ...")
                        if doorStates[doorPair][1] then
                            doorStates[doorPair][1] = newDoorState
                        end
                    end

                    TriggerClientEvent("VP:DOORSTATECONTAINER:SetDoorState", -1, doorHash, newDoorState)
                end
            )

            AddEventHandler(
                "API:playerSpawned",
                function(source, user_id, isFirstSpawn)
                    if isFirstSpawn then
                        local _temp = deepcopy(doorStates)
                        for _, v in pairs(_temp) do
                            v[3] = nil
                        end

                        TriggerClientEvent("VP:DOORSTATECONTAINER:SetMultipleDoorsState", source, _temp)
                    end
                end
            )

            Citizen.CreateThread(
                function()
                    Citizen.Wait(2000)

                    local _temp = deepcopy(doorStates)
                    for _, v in pairs(_temp) do
                        v[3] = nil
                    end

                    TriggerClientEvent("VP:DOORSTATECONTAINER:SetMultipleDoorsState", -1, _temp)
                end
            )
        elseif CLIENT then
            RegisterNetEvent("VP:DOORSTATECONTAINER:SetDoorState")
            AddEventHandler(
                "VP:DOORSTATECONTAINER:SetDoorState",
                function(doorHash, doorState)
                    doorStates[doorHash][1] = doorState

                    RegisterDoorSomething(doorHash)
                    DoorSystemSetDoorState(doorHash, doorState == true and 0 or 1)

                    if doorStates[doorHash][2] ~= nil then
                        local doorPair = doorStates[doorHash][2]
                        doorStates[doorPair][1] = doorState

                        RegisterDoorSomething(doorPair)
                        DoorSystemSetDoorState(doorPair, doorState == true and 0 or 1)
                    end
                end
            )

            RegisterNetEvent("VP:DOORSTATECONTAINER:SetMultipleDoorsState")
            AddEventHandler(
                "VP:DOORSTATECONTAINER:SetMultipleDoorsState",
                function(_doorStates)
                    doorStates = _doorStates
                end
            )

            local closestDoorHash

            Citizen.CreateThread(
                function()
                    while true do
                        local ped = PlayerPedId()
                        local pCoords = GetEntityCoords(ped)

                        local dist
                        for doorHash, values in pairs(doorStates) do
                            local doorEntity = GetDoorEntity(doorHash)

                            if DoesEntityExist(doorEntity) then
                                local doorState = values[1]

                                RegisterDoorSomething(doorHash)
                                DoorSystemSetDoorState(doorHash, doorState == true and 0 or 1)

                                local _dist = #(pCoords - GetEntityCoords(doorEntity))

                                if _dist <= 50 and (dist == nil or _dist < dist) then
                                    dist = _dist
                                    closestDoorHash = doorHash
                                end
                            end
                        end

                        if dist == nil then
                            closestDoorHash = nil
                        end

                        Citizen.Wait(1000)
                    end
                end
            )

            local prompt_group_open
            local prompt_open

            local prompt_group_close
            local prompt_close

            -- local prompt_group_name = CreateVarString(10, "LITERAL_STRING", "Porta")

            Citizen.CreateThread(
                function()
                    initPrompts()

                    while true do
                        Citizen.Wait(0)

                        if closestDoorHash ~= nil then
                            local doorEntity = GetDoorEntity(closestDoorHash)

                            local ped = PlayerPedId()
                            local pCoords = GetEntityCoords(ped)

                            local dist = #(pCoords - GetEntityCoords(doorEntity))

                            if dist <= 1.7 then
                                local playingUnlockAnimation = IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3)

                                -- drawHandle(doorEntity)

                                if HasEntityClearLosToEntityInFront(ped, doorEntity, 0) and not playingUnlockAnimation then
                                    local doorState = doorStates[closestDoorHash][1]

                                    if doorState == true then
                                        PromptSetActiveGroupThisFrame(prompt_group_close, CreateVarString(10, "LITERAL_STRING", "Porta"))

                                        if PromptHasHoldModeCompleted(prompt_close) then
                                            PromptSetEnabled(prompt_close, false)
                                            Citizen.CreateThread(
                                                function()
                                                    Citizen.Wait(250)
                                                    PromptSetEnabled(prompt_close, true)
                                                end
                                            )

                                            unlockAnimation()
                                            TriggerServerEvent("VP:DOORSTATECONTAINER:TryToToggleDoorState", closestDoorHash)
                                        end
                                    else
                                        PromptSetActiveGroupThisFrame(prompt_group_open, CreateVarString(10, "LITERAL_STRING", "Porta"))

                                        if PromptHasHoldModeCompleted(prompt_open) then
                                            PromptSetEnabled(prompt_open, false)
                                            Citizen.CreateThread(
                                                function()
                                                    Citizen.Wait(250)
                                                    PromptSetEnabled(prompt_open, true)
                                                end
                                            )

                                            unlockAnimation()
                                            TriggerServerEvent("VP:DOORSTATECONTAINER:TryToToggleDoorState", closestDoorHash)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            )

            function initPrompts()
                prompt_group_open = GetRandomIntInRange(0, 0xffffff)

                prompt_open = PromptRegisterBegin()
                PromptSetControlAction(prompt_open, 0xDFF812F9)
                PromptSetText(prompt_open, CreateVarString(10, "LITERAL_STRING", "Abrir"))
                PromptSetEnabled(prompt_open, true)
                PromptSetVisible(prompt_open, true)
                PromptSetHoldMode(prompt_open, true)
                PromptSetGroup(prompt_open, prompt_group_open)
                PromptRegisterEnd(prompt_open)

                prompt_group_close = GetRandomIntInRange(0, 0xffffff)

                prompt_close = PromptRegisterBegin()
                PromptSetControlAction(prompt_close, 0xDFF812F9)
                PromptSetText(prompt_close, CreateVarString(10, "LITERAL_STRING", "Fechar"))
                PromptSetEnabled(prompt_close, true)
                PromptSetVisible(prompt_close, true)
                PromptSetHoldMode(prompt_close, true)
                PromptSetGroup(prompt_close, prompt_group_close)
                PromptRegisterEnd(prompt_close)
            end

            function unlockAnimation()
                local dict = "script_common@jail_cell@unlock@key"
                if not HasAnimDictLoaded(dict) then
                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(10)
                    end
                end

                local ped = PlayerPedId()

                local prop = CreateObject("P_KEY02X", GetEntityCoords(ped) + vec3(0, 0, 0.2), true, true, true)
                local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")

                TaskPlayAnim(ped, "script_common@jail_cell@unlock@key", "action", 8.0, -8.0, 2500, 31, 0, true, 0, false, 0, false)
                Wait(750)
                AttachEntityToEntity(prop, ped, boneIndex, 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true)

                while IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3) do
                    Wait(100)
                end

                DeleteObject(prop)
            end

            function GetDoorEntity(doorHash)
                return Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)
            end

            function RegisterDoorSomething(doorHash)
                Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
            end

            -- function drawHandle(entity)
            --     local offset = GetOffsetFromEntityInWorldCoords(entity, 1.05, 0.0, 1.0)
            --     Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(entity), offset, 255, 0, 0, 255)
            --     Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(PlayerPedId()), offset, 255, 0, 0, 255)
            -- end

            AddEventHandler(
                "onResourceStop",
                function(resourceName)
                    if GetCurrentResourceName() == resourceName then
                        PromptDelete(prompt_open)
                        PromptDelete(prompt_close)
                    end
                end
            )
        end
    end
)
