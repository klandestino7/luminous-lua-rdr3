local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

adding = true
horsesp = false
inCustomization = false
cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = cAPI.getHorseEnt()
sex = nil
zoom = 4.0
offset = 0.2

local adding = true
local saddles = {}
local saddlecloths = {}
local stirrups = {}
local bags = {}
local manes = {}
local horsetails = {}
local acshorn = {}
local acsluggage = {}

Citizen.CreateThread(
    function()
        while adding do
            Citizen.Wait(0)
            for i, v in ipairs(HorseComp) do
                if v.category == "Saddles" then
                    table.insert(saddles, v.Hash)
                elseif v.category == "Saddlecloths" then
                    table.insert(saddlecloths, v.Hash)
                elseif v.category == "Stirrups" then
                    table.insert(stirrups, v.Hash)
                elseif v.category == "Bags" then
                    table.insert(bags, v.Hash)
                elseif v.category == "Manes" then
                    table.insert(manes, v.Hash)
                elseif v.category == "HorseTails" then
                    table.insert(horsetails, v.Hash)
                elseif v.category == "AcsHorn" then
                    table.insert(acshorn, v.Hash)
                elseif v.category == "AcsLuggage" then
                    table.insert(acsluggage, v.Hash)
                end
            end
            adding = false
        end
    end
)

RegisterCommand(
    "horsemodf",
    function(source, args)
        inCustomization = true
        horsesp = true
        SetEntityHeading(cAPI.getHorseEnt(), 334)
        TriggerServerEvent("FRP:STABLE:AskForMyHorses")
    end
)

function rotation(dir)
    local pedRot = GetEntityHeading(cAPI.getHorseEnt()) + dir
    SetEntityHeading(cAPI.getHorseEnt(), pedRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        print("foi")
        if (data["key"] == "left") then
            rotation(20)
        else
            rotation(-20)
        end
        cb("ok")
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if inCustomization and not hided then
                SetNuiFocus(true, true)
            
                local hashm = GetEntityModel(cAPI.getHorseEnt())
                


                if hashm ~= nil and IsPedOnMount(PlayerPedId()) then
                    camera(zoom, offset)
                end



                SetEntityVisible(PlayerPedId(), false)

                SendNUIMessage(
                    {
                        action = "showCreate"
                    }
                )
            end
        end
    end
)
AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "hideOnly"
            }
        )
    end
)

function createCam(creatorType)
    for k, v in pairs(cams) do
        if cams[k].type == creatorType then
            cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cams[k].x, cams[k].y, cams[k].z, cams[k].rx, cams[k].ry, cams[k].rz, cams[k].fov, false, 0) -- CAMERA COORDS
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 3000, true, false)
            createPeds()
        end
    end
end

function camera(zoom, offset)
    DestroyAllCams(true)
    local playerPed = cAPI.getHorseEnt()
    local coords = GetEntityCoords(playerPed)
    local heading = 45.0
    local zoomOffset = zoom
    local camOffset = offset
    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }
    --    print(theta.x)
    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }
    --   print(pos.x)
    local angleToLook = heading - 140.0
    if angleToLook > 360 then
        angleToLook = angleToLook - 360
    elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
    end
    --   print(angleToLook)
    angleToLook = angleToLook * math.pi / 180.0
    local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
    }
    --    print(thetaToLook.x)
    local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y)
    }
    --  print(posToLook.x)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x - 0.6, pos.y, coords.z + camOffset, 300.00, 0.00, 0.00, 40.00, false, 0)
    PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    DisplayHud(false)
    DisplayRadar(false)
end

function createPeds()
    for k, v in pairs(peds) do
        if choosePed[k] == nil then
            local waiting = 0
            local hash = GetHashKey(peds[k].genrer)
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(10)
            end
            choosePed[k] = CreatePed(GetHashKey(peds[k].genrer), peds[k].x, peds[k].y, peds[k].z - 0.5, peds[k].h, false, 0)
            Citizen.InvokeNative(0x283978A15512B2FE, choosePed[k], true)
            Citizen.InvokeNative(0x58A850EAEE20FAA3, choosePed[k])
            -- NetworkSetEntityInvisibleToNetwork(choosePed[k], true)
            SetVehicleHasBeenOwnedByPlayer(choosePed[k], true)
            SetModelAsNoLongerNeeded(choosePed[k])
        end
    end
end

RegisterNUICallback(
    "CloseStable",
    function()
        SendNUIMessage(
            {
                action = "hideCreate"
            }
        )
        inCustomization = false
        horsesp = false
        --  SetEntityVisible(cAPI.getHorseEnt(), true)
        --  NetworkSetEntityInvisibleToNetwork(cAPI.getHorseEnt(), false)
        cam = nil
        SetEntityVisible(PlayerPedId(), true)
    end
)

SaddlesUsing = nil
SaddleclothsUsing = nil
StirrupsUsing = nil
BagsUsing = nil
ManesUsing = nil
HorseTailsUsing = nil
AcsHornUsing = nil
AcsLuggageUsing = nil

RegisterNUICallback(
    "Saddles",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            SaddlesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0xBAA7E618, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddles[num])
            cAPI.stablecloth(hash)
            SaddlesUsing = ("0x" .. saddles[num])
        end
    end
)

RegisterNUICallback(
    "Saddlecloths",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            SaddleclothsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0x17CEB41A, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddlecloths[num])
            cAPI.stablecloth(hash)
            SaddleclothsUsing = ("0x" .. saddlecloths[num])
        end
    end
)

RegisterNUICallback(
    "Stirrups",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            StirrupsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0xDA6DADCA, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. stirrups[num])
            cAPI.stablecloth(hash)
            StirrupsUsing = ("0x" .. stirrups[num])
        end
    end
)

RegisterNUICallback(
    "Bags",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            BagsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0x80451C25, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. bags[num])
            cAPI.stablecloth(hash)
            BagsUsing = ("0x" .. bags[num])
        end
    end
)

RegisterNUICallback(
    "Manes",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            ManesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0xAA0217AB, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. manes[num])
            cAPI.stablecloth(hash)
            ManesUsing = ("0x" .. manes[num])
        end
    end
)

RegisterNUICallback(
    "HorseTails",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            HorseTailsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0xA63CAE10, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. horsetails[num])
            cAPI.stablecloth(hash)
            HorseTailsUsing = ("0x" .. horsetails[num])
        end
    end
)

RegisterNUICallback(
    "AcsHorn",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            AcsHornUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0x5447332, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acshorn[num])
            cAPI.stablecloth(hash)
            AcsHornUsing = ("0x" .. acshorn[num])
        end
    end
)

RegisterNUICallback(
    "AcsLuggage",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            AcsLuggageUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.getHorseEnt(), 0xEFB31921, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.getHorseEnt(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acsluggage[num])
            cAPI.stablecloth(hash)
            AcsLuggageUsing = ("0x" .. acsluggage[num])
        end
    end
)

myHorses = {}

RegisterNUICallback(
    "Myhorses",
    function(data)
        TriggerServerEvent("FRP:STABLE:SelectHorseWithId", data.id)
    end
)

RegisterNetEvent("FRP:STABLE:callhorse")
AddEventHandler(
    "FRP:STABLE:callhorse",
    function()
        for _, horseData in pairs(myHorses) do
            --	print(json.encode(horseData))
            SendNUIMessage(
                {
                    nomeHorse = horseData.name,
                    modelHorse = horseData.model,
                    idHorse = horseData.id
                }
            )
        end
    end
)

RegisterNetEvent("FRP:STABLE:ReceiveHorsesData")
AddEventHandler(
    "FRP:STABLE:ReceiveHorsesData",
    function(data)
        myHorses = data
    end
)

RegisterNetEvent("FRP:STABLE:SelectHORSE")
AddEventHandler(
    "FRP:STABLE:SelectHORSE",
    function(data)
        TriggerServerEvent("FRP:STABLE:SelectHorseWithId", data.id)
    end
)

RegisterNUICallback(
    "Confirm",
    function()
        local dados = {
            -- ['saddles'] = SaddlesUsing,
            -- ['saddlescloths'] = SaddleclothsUsing,
            -- ['stirrups'] = StirrupsUsing,
            -- ['bags'] = BagsUsing,
            -- ['manes'] = ManesUsing,
            -- ['horsetails'] = HorseTailsUsing,
            -- ['acshorn'] = AcsHornUsing,
            -- ['ascluggage'] = AcsLuggageUsing
            SaddlesUsing,
            SaddleclothsUsing,
            StirrupsUsing,
            BagsUsing,
            ManesUsing,
            HorseTailsUsing,
            AcsHornUsing,
            AcsLuggageUsing
        }
        TriggerServerEvent("FRP:STABLE:UpdateHorseComponents", dados)
        SetEntityVisible(PlayerPedId(), true)
        closeAll()
    end
)

SaddlesUsing = nil
SaddleclothsUsing = nil
StirrupsUsing = nil
BagsUsing = nil
ManesUsing = nil
HorseTailsUsing = nil
AcsHornUsing = nil
AcsLuggageUsing = nil

function camera(zoom, offset)
    DestroyAllCams(true)
    local playerPed = cAPI.getHorseEnt()
    local coords = GetEntityCoords(playerPed)
    local heading = 45.0
    local zoomOffset = zoom
    local camOffset = offset
    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }
    --    print(theta.x)
    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }
    --   print(pos.x)
    local angleToLook = heading - 140.0
    if angleToLook > 360 then
        angleToLook = angleToLook - 360
    elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
    end
    --   print(angleToLook)
    angleToLook = angleToLook * math.pi / 180.0
    local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
    }
    --    print(thetaToLook.x)
    local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y)
    }
    --  print(posToLook.x)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x - 0.6, pos.y, coords.z + camOffset + 2.0, 300.00, 0.00, 0.00, 40.00, false, 0)
    PointCamAtCoord(cam, posToLook.x, posToLook.y + 2.0, coords.z + camOffset - 1.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    DisplayHud(false)
    DisplayRadar(false)
end

function closeAll()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)
    SendNUIMessage(
        {
            action = "hideOnly"
        }
    )
    horsesp = false
    inCustomization = false

    choosePed = {}
    local ped = cAPI.getHorseEnt()
    --  SetEntityVisible(ped, true)
    --  NetworkSetEntityInvisibleToNetwork(ped, false)
end

--- /// ARRASTAR CAVALO

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             if IsControlPressed(2, 0xE8342FF2) then -- Hold ALT
--                 print("askoasko")
--                 CompendiumHorseBonding(PlayerPedId(), cAPI.getHorseEnt())
--                 print(CompendiumHorseBonding(PlayerPedId(), cAPI.getHorseEnt()))
--             --  TaskArrestPed(cAPI.getHorseEnt(), PlayerPedId())
--             end
--         end
--     end
-- )
