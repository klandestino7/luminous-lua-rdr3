local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local fakePeds = {}

RegisterNetEvent("VP:IDENTITY:DisplayCharSelection")
AddEventHandler(
    "VP:IDENTITY:DisplayCharSelection",
    function(characterArray)
        Destroy()

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        cAPI.PlayerAsInitialized(false)

        ShutdownLoadingScreen()
        createCamera()

        SendNUIMessage({type = 2}) -- clear UI

        Wait(2500)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = 1,
                list = characterArray
            }
        )

        local fakePedCoords = {
            vec3(1062.20, 1591.10, 369.42 - 0.98),
            vec3(1061.10, 1591.20, 369.36 - 0.98)
        }

        if characterArray ~= nil then
            for index, values in pairs(characterArray) do
                local skinMdf = json.decode(values.SkinMdf)

                local pModel = GetHashKey(skinMdf.model)
                local pBodySize = tonumber(skinMdf.bodySize)
                local pSkin = json.decode(skinMdf.modSkin)
                local pFaceFeatures = json.decode(skinMdf.features)
                local pScale = tonumber(skinMdf.pedSize)
             --   local pClothing = json.decode(values.clothes)
                local pClothing

                if json.decode(values.clothes).Outfit ~= nil then 
                    if tonumber(json.decode(values.clothes).Outfit) <= 100 then
                        pClothing = tonumber(json.decode(values.clothes).Outfit)
                    end                   
                else
                    pClothing = json.decode(values.clothes)    
                end
            
                if not HasModelLoaded(pModel) then
                    RequestModel(pModel)
                    while not HasModelLoaded(pModel) do
                        Citizen.Wait(10)
                    end
                end

                local ped = CreatePed(pModel, fakePedCoords[index], 350.77, 0, 0)

                Citizen.Wait(100)

                cAPI.SetPedBodyType(ped, pBodySize)

                cAPI.SetSkin(ped, pSkin)

                cAPI.SetPedFaceFeature(ped, pFaceFeatures) 
                
                cAPI.SetPedScale(ped, pScale)

                cAPI.SetPedClothing(ped, pClothing)

                table.insert(fakePeds, ped)
            end
        end
    end
)

function Destroy()
    for _, ped in pairs(fakePeds) do
        DeleteEntity(ped)
    end

    if cam ~= nil then
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
    end

    FreezeEntityPosition(PlayerPedId(), false)
    fakePeds = {}
end

RegisterNUICallback(
    "createCharacter",
    function()
        SetNuiFocus(false, false)
        TriggerEvent("VP:CHARCREATION:starting")
        Destroy()
    end
)

RegisterNUICallback(
    "selectCharacter",
    function(id)
        SetNuiFocus(false, false)
        DisplayHud(true)
        TriggerServerEvent("VP:IDENTITY:selectCharacter", id)
        cAPI.StartFade(500)
        Citizen.Wait(500)
        Destroy()
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityInvincible(PlayerPedId(), false)
        Wait(1800)
        cAPI.EndFade(500)
    end
)

RegisterNUICallback(
    "deleteCharacter",
    function(id)
        TriggerServerEvent("VP:IDENTITY:deleteCharacter", id)
        TriggerEvent("VP:NOTIFY:Simple", "Personagem deletado.")
    end
)

RegisterCommand(
    "Deletarenti",
    function()
        print("deletou")
        Destroy()
    end
)

function createCamera()
    DisplayHud(false)

    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 1060.94, 1597.82, 373.00)
    FreezeEntityPosition(PlayerPedId(), true)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1062.48, 1592.20, 369.79, -10.00, 0.00, 168.00, 95.00, false, 0) -- CAMERA COORDS
    PointCamAtCoord(cam, 1062.48, 1592.20, 369.79)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() or resourceName == "_core" then
            Destroy()
        end
    end
)
