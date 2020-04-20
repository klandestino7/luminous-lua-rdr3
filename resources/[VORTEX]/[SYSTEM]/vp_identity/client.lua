local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")
Identity = {}
local charT = {}

local choosePed = nil

RegisterNetEvent("VP:IDENTITY:charList")
AddEventHandler(
    "VP:IDENTITY:charList",
    function(characters)
        
        cAPI.setAsInitialized(false)

        ShutdownLoadingScreen()
        createCamera()
        SendNUIMessage({type = 2}) -- clear UI
        Wait(2500)
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = 1,
                list = characters
            }
        )
        for i = 0, #characters do
            local DadosChar = characters[i]
            if DadosChar ~= nil then
                charT = {
                    json.decode(DadosChar.charTable),
                    json.decode(DadosChar.SkinMdf or '[]'),
                    json.decode(DadosChar.clothes)
                }
                Wait(100)
                createPeds()
            end
        end
    end
)

function createPeds(ch)
    --  for _, k in pairs(charT) do

    RequestModel(charT[1].model)
    while not HasModelLoaded(charT[1].model) do
        Citizen.Wait(10)
    end

    choosePed = CreatePed(GetHashKey(charT[1].model), 1063.119140625, 1594.8400878906, 370.02581787109, 333.18, false, 0)
    Citizen.InvokeNative(0x283978A15512B2FE, choosePed, true)
    Citizen.InvokeNative(0x58A850EAEE20FAA3, choosePed)

    NetworkSetEntityInvisibleToNetwork(choosePed, true)
    SetVehicleHasBeenOwnedByPlayer(choosePed, true)
    SetModelAsNoLongerNeeded(choosePed)

    if charT[3] ~= "{}" then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, tonumber(charT[3]), true, true, true) -- PANTS
    else
        if charT.model == "mp_female" then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, 0x10F5497A, true, true, true) -- PANTS
            Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, 0x14511493, true, true, true) -- COAT
            Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, 0xD03D522, true, true, true) -- BOOT
        else
            Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, 0x10051C7, true, true, true) -- PANTS
            Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, 0x12E51663, true, true, true) -- COAT
            Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed, 0x192C2A4B, true, true, true) -- BOOT
        end
    end

    -- if DeletePed then
    --     DeleteEntity(choosePed)
    -- end
    --  end
end

RegisterNUICallback(
    "createCharacter",
    function()
        SetNuiFocus(false, false)
        TriggerEvent("VP:CHARCREATION:starting")
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
        DeleteEntity(choosePed)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    end
)

RegisterNUICallback(
    "deleteCharacter",
    function(id)
        TriggerServerEvent("VP:IDENTITY:deleteCharacter", id)
    end
)

function createCamera()
    DisplayHud(false)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 1062.78, 1597.82, 373.29)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1062.78, 1597.82, 373.29, 0.00, 0.00, 168.00, 100.00, false, 0) -- CAMERA COORDS
    PointCamAtCoord(cam, 1062.78, 1597.82, 373.29)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end
