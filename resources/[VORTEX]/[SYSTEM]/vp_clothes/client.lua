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

local spurs_m = {} -- SPURS
local spurs_f = {}

local chaps_m = {}
local chaps_f = {}

local cloaks_m = {}
local cloaks_f = {}

local spats_m = {}
local spats_f = {}

local eyewear_m = {}
local eyewear_f = {}

local access_m = {}
local access_f = {}

local neckties_m = {}
local neckties_f = {}

local bracelets_m = {}
local bracelets_f = {}

local loadouts_m = {}
local loadouts_f = {}

local suspenders_m = {}
local suspenders_f = {}

local gauntlets_m = {}
local gauntlets_f = {}

local belts_m = {}
local belts_f = {}

local ponchos_m = {}
local ponchos_f = {}

local offhand_m = {}
local offhand_f = {}

local beltbuckle_m = {}
local beltbuckle_f = {}

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
            elseif v.category == "spurs" then
                table.insert(spurs_m, v.Hash)
            elseif v.category == "chaps" then
                table.insert(chaps_m, v.Hash)
            elseif v.category == "cloaks" then
                table.insert(cloaks_m, v.Hash)
            elseif v.category == "spats" then
                table.insert(spats_m, v.Hash)
            elseif v.category == "eyewear" then
                table.insert(eyewear_m, v.Hash)
            elseif v.category == "access" then
                table.insert(access_m, v.Hash)
            elseif v.category == "neckties" then
                table.insert(neckties_m, v.Hash)
            elseif v.category == "bracelets" then
                table.insert(bracelets_m, v.Hash)
            elseif v.category == "loadouts" then
                table.insert(loadouts_m, v.Hash)
            elseif v.category == "suspenders" then
                table.insert(suspenders_m, v.Hash)
            elseif v.category == "gauntlets" then
                table.insert(gauntlets_m, v.Hash)
            elseif v.category == "belts" then
                table.insert(belts_m, v.Hash)
            elseif v.category == "ponchos" then
                table.insert(ponchos_m, v.Hash)                
            elseif v.category == "offhand" then
                table.insert(offhand_m, v.Hash)
            elseif v.category == "beltbuckle" then
                table.insert(beltbuckle_m, v.Hash)                
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
            elseif v.category == "spurs" then
                table.insert(spurs_f, v.Hash)
            elseif v.category == "chaps" then
                table.insert(chaps_f, v.Hash)
            elseif v.category == "cloaks" then
                table.insert(cloaks_f, v.Hash)
            elseif v.category == "spats" then
                table.insert(spats_f, v.Hash)
            elseif v.category == "eyewear" then
                table.insert(eyewear_f, v.Hash)
            elseif v.category == "access" then
                table.insert(access_f, v.Hash)
            elseif v.category == "neckties" then
                table.insert(neckties_f, v.Hash)
            elseif v.category == "bracelets" then
                table.insert(bracelets_f, v.Hash)
            elseif v.category == "loadouts" then
                table.insert(loadouts_f, v.Hash)
            elseif v.category == "suspenders" then
                table.insert(suspenders_f, v.Hash)
            elseif v.category == "gauntlets" then
                table.insert(gauntlets_f, v.Hash)
            elseif v.category == "belts" then
                table.insert(belts_f, v.Hash)
            elseif v.category == "ponchos" then
                table.insert(ponchos_f, v.Hash)
            elseif v.category == "offhand" then
                table.insert(offhand_f, v.Hash)
            elseif v.category == "beltbuckle" then
                table.insert(beltbuckle_f, v.Hash)
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

-- RegisterNetEvent('VP:CHARCREATION:starting')
-- AddEventHandler(
--     'VP:CHARCREATION:starting',
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

spursUsing = nil
chapsUsing = nil
spatsUsing = nil
eyewearUsing = nil
accessUsing = nil
necktiesUsing = nil
braceletsUsing = nil
suspendersUsing = nil
gauntletsUsing = nil
beltsUsing = nil
ponchosUsing = nil
offhandUsing = nil
beltbuckleUsing = nil

RegisterNUICallback(
    'Chapeu',
    function(data)        
        zoom = 1.5
        offset = 0.5
        if tonumber(data.id) == 0 then
            num = 0
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
            num = 0
            ShirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_m[num])               
                setcloth(hash) 
                ShirtsUsing = ("0x" .. shirts_m[num])                 
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
            num = 0    
            VestsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. vests_m[num])               
                setcloth(hash)                  
                VestsUsing = ("0x" .. vests_m[num]) 
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
            num = 0
            PantsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
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
            num = 0
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
            num = 0
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
            num = 0
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
            num = 0
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
--             num = 0
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
            num = 0
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
            num = 0
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
            num = 0
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

RegisterNUICallback(
    'Beltbuckle',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            beltbuckleUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0) -- beltbuckle REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. beltbuckle_m[num])               
                setcloth(hash)        
                beltbuckleUsing = ("0x" .. beltbuckle_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. beltbuckle_f[num])               
                setcloth(hash)   
                beltbuckleUsing = ("0x" .. beltbuckle_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Offhand',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            offhandUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0) -- offhand REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. offhand_m[num])               
                setcloth(hash)        
                offhandUsing = ("0x" .. offhand_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. offhand_f[num])               
                setcloth(hash)   
                offhandUsing = ("0x" .. offhand_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Ponchos',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            ponchosUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0) -- ponchos REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. ponchos_m[num])               
                setcloth(hash)        
                ponchosUsing = ("0x" .. ponchos_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. ponchos_f[num])               
                setcloth(hash)   
                ponchosUsing = ("0x" .. ponchos_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Belts',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            beltsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0) -- Belts REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. belts_m[num])               
                setcloth(hash)        
                beltsUsing = ("0x" .. belts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. belts_f[num])               
                setcloth(hash)   
                beltsUsing = ("0x" .. belts_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Gauntlets',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            gauntletsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0) -- Gauntlets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. gauntlets_m[num])               
                setcloth(hash)        
                gauntletsUsing = ("0x" .. gauntlets_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gauntlets_f[num])               
                setcloth(hash)   
                gauntletsUsing = ("0x" .. gauntlets_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Suspenders',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            suspendersUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0) -- Suspenders REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. suspenders_m[num])               
                setcloth(hash)        
                suspendersUsing = ("0x" .. suspenders_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. suspenders_f[num])               
                setcloth(hash)   
                suspendersUsing = ("0x" .. suspenders_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Bracelets',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            braceletsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0) -- Bracelets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. bracelets_m[num])               
                setcloth(hash)        
                braceletsUsing = ("0x" .. bracelets_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. bracelets_f[num])               
                setcloth(hash)   
                braceletsUsing = ("0x" .. bracelets_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Neckties',
    function(data)        
        zoom = 2.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            necktiesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0) -- Neckties REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. neckties_m[num])               
                setcloth(hash)        
                necktiesUsing = ("0x" .. neckties_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. neckties_f[num])               
                setcloth(hash)   
                necktiesUsing = ("0x" .. neckties_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Access',
    function(data)        
        zoom = 2.5
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            accessUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0) -- Access REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. access_m[num])               
                setcloth(hash)        
                accessUsing = ("0x" .. access_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. access_f[num])               
                setcloth(hash)   
                accessUsing = ("0x" .. access_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Eyewear',
    function(data)        
        zoom = 1.5
        offset = 0.5
        if tonumber(data.id) == 0 then
            num = 0
            eyewearUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0) -- Eyewear REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. eyewear_m[num])               
                setcloth(hash)        
                eyewearUsing = ("0x" .. eyewear_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. eyewear_f[num])               
                setcloth(hash)   
                eyewearUsing = ("0x" .. eyewear_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Chaps',
    function(data)        
        zoom = 2.1
        offset = -0.5
        if tonumber(data.id) == 0 then
            num = 0
            chapsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0) -- Chaps REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. chaps_m[num])               
                setcloth(hash)        
                chapsUsing = ("0x" .. chaps_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. chaps_f[num])               
                setcloth(hash)   
                chapsUsing = ("0x" .. chaps_f[num])
            end
        end        
    end
)

RegisterNUICallback(
    'Spurs',
    function(data)        
        zoom = 1.5
        offset = -0.7
        if tonumber(data.id) == 0 then
            num = 0
            spursUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0) -- SPURS REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == 'mp_male' then
                local num = tonumber(data.id)
                hash = ("0x" .. spurs_m[num])               
                setcloth(hash)        
                spursUsing = ("0x" .. spurs_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. spurs_f[num])               
                setcloth(hash)   
                spursUsing = ("0x" .. spurs_f[num])
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
            ['gunbelts'] = GunbeltsUsing,                        
            ['spurs'] = spursUsing,
            ['chaps'] = chapsUsing,
            ['spats'] = spatsUsing,
            ['eyewear'] = eyewearUsing,
            ['access'] = accessUsing,
            ['neckties'] = necktiesUsing,
            ['bracelets'] = braceletsUsing,
            ['suspenders'] = suspendersUsing,
            ['gauntlets'] = gauntletsUsing,
            ['belts'] = beltsUsing,
            ['ponchos'] = ponchosUsing,
            ['gunbelts'] = offhandUsing,
            ['offhand'] = beltbuckleUsing
        }
        if dados ~= nil then
            local pdado = #dados
            TriggerServerEvent('VP:STORECLOTHES:buy', tonumber(pdado*0.2))
        end
        TriggerServerEvent('VP:CLOTHES:saveCloth', dados)
        closeAll()
    end
)


RegisterCommand('clotheat', function()
    local bandana = 0x34E62EF6
    print(bandana)
Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  bandana, true, true, true)

end)
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
