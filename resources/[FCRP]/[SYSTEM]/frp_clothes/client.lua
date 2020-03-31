adding = true
clothes = false
inCustomization = false
cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = PlayerPedId()
sex = nil
zoom = 2.5
offset = 0.2

local adding2 = true
local adding = true

local hats_m = {} --hat
local hats_f = {}
----------------------------------------------------------------------------------------------------------------------------
local shirts_m = {} --shirt
local shirts_f = {}
--------------------------------------------------------------------------------------------------------------------------------------
local vests_m = {} --vest
local vests_f = {}
--------------------------------------------
local pants_m = {} --pants
local pants_f = {}
------------------------------------------
local masks_m = {} --mask
local masks_f = {}
------------------------------------------
local coats_m = {} --boots
local coats_f = {}
-----------------------------------------
local boots_m = {} --coats
local boots_f = {}
---------------------------------------
local legs_m = {} --coats
local legs_f = {}

local gloves_m = {} --coats
local gloves_f = {}

local torsos_m = {}
local torsos_f = {}

local neckwear_m = {}
local neckwear_f = {}

local gunbelts_m = {}
local gunbelts_f = {}

local mustache_m = {}

local skirts_f = {}
--

Citizen.CreateThread(function()
    while adding do
        Citizen.Wait(0)
        --print("Dzieje sie")
        for i, v in ipairs(MaleComp) do
            if v.category == "hats" then
                table.insert(hats_m, v.Hash)
            elseif v.category == "shirts" then
                table.insert(shirts_m, v.Hash)
            elseif v.category == "vests" then
                table.insert(vests_m, v.Hash)
            elseif v.category == "pants" then
                table.insert(pants_m, v.Hash)
            elseif v.category == "masks" then
                table.insert(masks_m, v.Hash)
            elseif v.category == "coats" then
                table.insert(coats_m, v.Hash)
            elseif v.category == "boots" then
                table.insert(boots_m, v.Hash)
            elseif v.category == "torsos" then
                table.insert(torsos_m, v.Hash)
            elseif v.category == "legs" then
                table.insert(legs_m, v.Hash)
			elseif v.category == "gloves" then
                table.insert(gloves_m, v.Hash)
			elseif v.category == "neckwear" then
                table.insert(neckwear_m, v.Hash)
            elseif v.category == "gunbelts" then
                table.insert(gunbelts_m, v.Hash)
            elseif v.category == "mustache" then
                table.insert(mustache_m, v.Hash)
            end
        end
        adding = false
    end
end)


Citizen.CreateThread(function()
    while adding2 do
        Citizen.Wait(0)
        --print("Dzieje sie 2")
        for i, v in ipairs(FemaleComp) do
            if v.category == "hats" then
                table.insert(hats_f, v.hash)
            elseif v.category == "shirts" then
                table.insert(shirts_f, v.hash)
            elseif v.category == "vests" then
                table.insert(vests_f, v.hash)
            elseif v.category == "pants" then
                table.insert(pants_f, v.hash)
            elseif v.category == "boots" then
                table.insert(boots_f, v.hash)
            elseif v.category == "masks" then
                table.insert(masks_f, v.hash)
            elseif v.category == "coats" then
                table.insert(coats_f, v.hash)
            elseif v.category == "skirts" then
                table.insert(skirts_f, v.hash)
            elseif v.category == "torsos" then
                table.insert(torsos_f, v.hash)
            elseif v.category == "legs" then
                table.insert(legs_f, v.hash)
			elseif v.category == "gloves" then
                table.insert(gloves_f, v.hash)
			elseif v.category == "neckwear" then
                table.insert(neckwear_f, v.hash)
            elseif v.category == "gunbelts" then
                table.insert(gunbelts_f, v.hash)
            else end
        end
        adding2 = false
    end
end)

RegisterCommand("clothe", function(source, args)
    inCustomization = true
   clothes = true
   hided = false
   SetEntityHeading(PlayerPedId(), 334) 
end)



RegisterNetEvent('clothes:open')
AddEventHandler('clothes:open', function()
    inCustomization = true
    clothes = true
    hided = false
    SetEntityHeading(PlayerPedId(), 334) 
end)

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    print(pedRot)
    SetEntityHeading(PlayerPedId(), pedRot % 360)

end

RegisterNUICallback('rotate', function(data, cb)
    print('foi')
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)            
            if inCustomization and not hided then
                SetNuiFocus(true, true)
                local hashm = GetEntityModel(PlayerPedId())
                local fm = -171876066
                if hashm ~= fm then
                    sex = 'mp_female'
                else    
                    sex = 'mp_male'
                end
                camera(zoom, offset)
                SendNUIMessage(
                    {
                        action = 'showCreate',
                        gender = sex
                    }
                )
            end
        end
    end
)

-- RegisterNetEvent('crz_creator:starting')
-- AddEventHandler(
--     'crz_creator:starting',
--     function()
--         clothes = true
--        -- NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
--       --  SetEntityVisible(PlayerPedId(), false)
--       --  SetEntityCoords(PlayerPedId(), -561.8157, -3780.966, 239.0805)
--     end
-- )

AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = 'hideOnly'
            }
        )
    end
)

function createCam(creatorType)
    for k, v in pairs(cams) do
        if cams[k].type == creatorType then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', cams[k].x, cams[k].y, cams[k].z, cams[k].rx, cams[k].ry, cams[k].rz, cams[k].fov, false, 0) -- CAMERA COORDS
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 3000, true, false)
            createPeds()
        end
    end
end


function camera(zoom, offset)
    DestroyAllCams(true)
        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)
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

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x-0.6, pos.y, coords.z + camOffset, 300.00,0.00,0.00, 40.00, false, 0)
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
    'CloseCreator',
    function()
        -- SendNUIMessage(
        --     {
        --         action = 'hideCreate'
        --     }
        -- )
        inCustomization = false
        clothes = false
      --  SetEntityVisible(PlayerPedId(), true)
      --  NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)

        cam = nil
    end
)

HatUsing = nil
ShirtsUsing = nil
VestsUsing = nil
PantsUsing = nil
BootsUsing = nil
MasksUsing = nil
CoatsUsing = nil
SkirtsUsing = nil
LegsUsing = nil
GlovesUsing = nil
NeckwearUsing = nil
GunbeltsUsing = nil

RegisterNUICallback(
    'Chapeu',
    function(data)        
        zoom = 1.5
        offset = 0.5
        if tonumber(data.id) == 0 then
            num = nil
            HatUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. hats_m[num])               
                setcloth(hash)        
                HatUsing = ("0x" .. hats_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. hats_f[num])               
                setcloth(hash)   
                HatUsing = ("0x" .. hats_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Camisa',
    function(data)
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            ShirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_m[num])               
                setcloth(hash) 
                ShirtsUsing = ("0x" .. shirts_f[num])                 
            else
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_f[num])               
                setcloth(hash)  
                ShirtsUsing = ("0x" .. shirts_f[num]) 
            end
        end
    end
)

RegisterNUICallback(
    'Colete',
    function(data)
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil    
            VestsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. vests_m[num])               
                setcloth(hash)                  
                VestsUsing = ("0x" .. vests_f[num]) 
            else
                local num = tonumber(data.id)
                hash = ("0x" .. vests_f[num])               
                setcloth(hash)   
                VestsUsing = ("0x" .. vests_f[num]) 
            end
        end 
    end
)

RegisterNUICallback(
    'Calca',
    function(data)
        zoom = 2.1
        offset = -0.5
        if tonumber(data.id) == 0 then
            num = nil
            PantsUsing = num
           -- Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Set target category, here the hash is for hats
           -- Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. pants_m[num])               
                setcloth(hash)    
                PantsUsing = ("0x" .. pants_m[num])       
            else
                local num = tonumber(data.id)
                hash = ("0x" .. pants_f[num])               
                setcloth(hash)   
                PantsUsing = ("0x" .. pants_f[num])  
            end             
        end
    end
)

RegisterNUICallback(
    'Sapato',
    function(data)
        zoom = 1.5
        offset = -0.7
        if tonumber(data.id) == 0 then
            num = nil
            BootsUsing = num            
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0) -- Set target category
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- REMOVE COMPONENT
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. boots_m[num])               
                setcloth(hash)                 
                BootsUsing = ("0x" .. boots_m[num])  
            else
                local num = tonumber(data.id)
                hash = ("0x" .. boots_f[num])               
                setcloth(hash)   
                BootsUsing = ("0x" .. boots_f[num]) 
            end
        end
    end
)

RegisterNUICallback(
    'Mascara',
    function(data)   
        zoom = 1.5
        offset = 0.5
        if tonumber(data.id) == 0 then
            num = nil
            MasksUsing = num           
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7505EF42, 0) -- Set target category, here the hash is for hats            
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. masks_m[num])               
                setcloth(hash)                
                MasksUsing = ("0x" .. masks_m[num])  
            else
                local num = tonumber(data.id)
                hash = ("0x" .. masks_f[num])               
                setcloth(hash)   
                MasksUsing = ("0x" .. masks_f[num])
            end
        end
    end
)

RegisterNUICallback(
    'Casaco',
    function(data)
        zoom = 2.2
        offset = 0.1
        if tonumber(data.id) == 0 then
            num = nil
            CoatsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. coats_m[num])               
                setcloth(hash)                
                CoatsUsing = ("0x" .. coats_m[num])  
            else
                local num = tonumber(data.id)
                hash = ("0x" .. coats_f[num])               
                setcloth(hash)   
                CoatsUsing = ("0x" .. coats_f[num])
            end
        end
    end
)

RegisterNUICallback(
    'Saia',
    function(data)       
        zoom = 2.1
        offset = -0.4
        if tonumber(data.id) == 0 then
            num = nil
            SkirtsUsing = num
                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0) -- Set target category, here the hash is for hats
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                -- local num = tonumber(data.id)
                -- hash = ("0x" .. mustache_m[num])               
                -- setcloth(hash)                  
            else
                local num = tonumber(data.id)
                hash = ("0x" .. skirts_f[num])               
                setcloth(hash)   
                SkirtsUsing = ("0x" .. skirts_f[num])
            end
        end
    end
)

-- RegisterNUICallback(
--     'Legs',
--     function(data)
--         if tonumber(data.id) == 0 then
--             num = nil
--             LegsUsing = num
--         else
--             if sex == 'mp_male' then
--                 local num = tonumber(data.id)
--                 hash = ("0x" .. legs_m[num])               
--                 setcloth(hash)       
--                 LegsUsing = ("0x" .. legs_m[num])           
--             else
--                 local num = tonumber(data.id)
--                 hash = ("0x" .. legs_f[num])               
--                 setcloth(hash)  
--                 LegsUsing = ("0x" .. legs_f[num]) 
--             end
--         end
--     end
-- )

RegisterNUICallback(
    'Luva',
    function(data)
        zoom = 2.0
        offset = -0.3
        if tonumber(data.id) == 0 then
            num = nil
            GlovesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. gloves_m[num])               
                setcloth(hash)       
                GlovesUsing = ("0x" .. gloves_m[num])           
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gloves_f[num])               
                setcloth(hash)   
                GlovesUsing = ("0x" .. gloves_f[num])
            end
        end
    end
)

RegisterNUICallback(
    'Bandana',
    function(data)   
        zoom = 1.5
        offset = 0.5
        if tonumber(data.id) == 0 then
            num = nil
            NeckwearUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. neckwear_m[num])               
                setcloth(hash)    
                NeckwearUsing = ("0x" .. neckwear_m[num])              
            else
                local num = tonumber(data.id)
                hash = ("0x" .. neckwear_f[num])               
                setcloth(hash)   
                NeckwearUsing = ("0x" .. neckwear_f[num])  
            end
        end
    end
)

RegisterNUICallback(
    'Coldre',
    function(data)
        zoom = 2.0
        offset = -0.3
        if tonumber(data.id) == 0 then
            num = nil
            GunbeltsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. gunbelts_m[num])               
                setcloth(hash)      
                GunbeltsUsing = ("0x" .. gunbelts_m[num])              
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gunbelts_f[num])               
                setcloth(hash)  
                GunbeltsUsing = ("0x" .. gunbelts_f[num])   
            end
        end
    end
)

function setcloth(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  tonumber(hash), true, true, true)
end



RegisterNUICallback(
    'Confirm',
    function()
        local dados = {
            ['hat'] = HatUsing,
            ['shirts'] = ShirtsUsing,
            ['vests'] = VestsUsing,
            ['pants'] = PantsUsing,
            ['boots'] = BootsUsing,
            ['masks'] = MasksUsing,
            ['coats'] = CoatsUsing,
            ['skirts'] = SkirtsUsing,
            ['legs'] = LegsUsing,
            ['gloves'] = GlovesUsing,
            ['neckwear'] = NeckwearUsing,
            ['gunbelts'] = GunbeltsUsing
        }
        if dados ~= nil then
            TriggerServerEvent('clothes:buy')
        end
        TriggerServerEvent('frp_clothes:saveCloth', dados)
        closeAll()
    end
)

function closeAll()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)
    -- SendNUIMessage(
    --     {
    --         action = 'hideOnly'
    --     }
    -- )
  
end
