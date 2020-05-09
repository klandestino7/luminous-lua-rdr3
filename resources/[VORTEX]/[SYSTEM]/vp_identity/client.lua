local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")
Identity = {}
local charT = {}
local DeletePed = false
local choosePed = {}
local peds = {}
RegisterNetEvent("VP:IDENTITY:charList")
AddEventHandler(
    "VP:IDENTITY:charList",
    function(characters)
        
        cAPI.setAsInitialized(false)
        DeletePed = false
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
      --  for i = 0, #characters do
            local DadosChar = characters

       -- print(DadosChar[1].charid,)
            -- if DadosChar ~= nil then
            --     charT = {
            --         json.decode(DadosChar.charTable),
            --         json.decode(DadosChar.SkinMdf),
            --         DadosChar.clothes,
            --         DadosChar.charid
            --     }
            if DadosChar == nil then
                
            else
                if #DadosChar == 1 then
                    peds = {  
                    {genrer = json.decode(DadosChar[1].SkinMdf).model, x = 1062.20, y = 1591.10, z = 369.42 - 0.98, h = 350.77, skin = json.decode(DadosChar[1].SkinMdf).modSkin, facef = json.decode(DadosChar[1].SkinMdf).features, pedsize = json.decode(DadosChar[1].SkinMdf).pedSize, bodySize = json.decode(DadosChar[1].SkinMdf).bodySize , clothes = DadosChar[1].clothes },
                    -- {genrer = json.decode(DadosChar[2].charTable).model, x = 1061.10, y = 1591.20,  z = 369.36 - 0.98, h = 320.77, skin = DadosChar[2].SkinMdf, clothes = DadosChar[2].clothes }
                    }  
                end      
                if #DadosChar == 2  then
                    peds = {  
                        {genrer = json.decode(DadosChar[1].SkinMdf).model, x = 1062.20, y = 1591.10, z = 369.42 - 0.98, h = 350.77, skin = json.decode(DadosChar[1].SkinMdf).modSkin, facef = json.decode(DadosChar[1].SkinMdf).features, pedsize = json.decode(DadosChar[1].SkinMdf).pedSize, bodySize = json.decode(DadosChar[1].SkinMdf).bodySize, clothes = DadosChar[1].clothes },
                        {genrer = json.decode(DadosChar[2].SkinMdf).model, x = 1061.10, y = 1591.20,  z = 369.36 - 0.98, h = 320.77, skin = json.decode(DadosChar[2].SkinMdf).modSkin, facef = json.decode(DadosChar[2].SkinMdf).features, pedsize = json.decode(DadosChar[2].SkinMdf).pedSize, bodySize = json.decode(DadosChar[2].SkinMdf).bodySize, clothes = DadosChar[2].clothes },
                    }  
                end 
               createPeds()                    
            end

      --  end
         
    end
)


function createPeds()
    for k, v in pairs(peds) do
        local waiting = 0
        local hash = GetHashKey(peds[k].genrer)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
        
        choosePed[k] = CreatePed(GetHashKey(peds[k].genrer), peds[k].x, peds[k].y, peds[k].z - 0.5, peds[k].h, false, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, choosePed[k], true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, choosePed[k])
        NetworkSetEntityInvisibleToNetwork(choosePed[k], true)
        SetVehicleHasBeenOwnedByPlayer(choosePed[k], true)
        SetModelAsNoLongerNeeded(hash)

        cAPI.SetBodyType(choosePed[k], peds[k].bodySize)
        Wait(130)
        cAPI.SetSkin(choosePed[k], peds[k].skin)
        Wait(300)
        cAPI.SetFaceFeature(choosePed[k], json.decode(peds[k].facef))
        Wait(30)        
        cAPI.SetPedSize(choosePed[k], peds[k].pedsize)   

        if peds[k].clothes ~= "{}" then
            for key, value in pairs(json.decode(peds[k].clothes)) do      
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k], tonumber(value), true,true,true)
            end
        else   
            if peds[k].genrer == 'mp_female' then
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x10F5497A,true,true,true) -- PANTS
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x14511493,true,true,true) -- COAT
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0xD03D522,true,true,true) -- BOOT
            else
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x10051C7,true,true,true) -- PANTS
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x12E51663,true,true,true) -- COAT
                Citizen.InvokeNative(0xD3A7B003ED343FD9, choosePed[k],0x192C2A4B,true,true,true) -- BOOT
            end
        end

        Citizen.CreateThread(
            function()
            while true do
                Citizen.Wait(100)
                if DeletePed then
                    DeleteEntity(choosePed[k])
                    break
                end
            end
        end)
    end
end

RegisterNUICallback(
    "createCharacter",
    function()
        SetNuiFocus(false, false)
        TriggerEvent("VP:CHARCREATION:starting")
        DeletePed = true
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
        DeletePed = true
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            DeletePed = true
        end
    end
)

RegisterNUICallback(
    "deleteCharacter",
    function(id)
        TriggerServerEvent("VP:IDENTITY:deleteCharacter", id)
    end
)

RegisterCommand('Deletarenti', function()
    print('deletou')
    DeletePed = true
end)

function createCamera()
    DisplayHud(false)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 1060.94, 1597.82, 373.29)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1062.48, 1592.20, 369.79, -10.00, 0.00, 168.00, 100.00, false, 0) -- CAMERA COORDS
    PointCamAtCoord(cam, 1062.48, 1592.20, 369.79)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end
