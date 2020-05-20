local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = nil
sex = nil
zoom = 4.0
offset = 0.2
DeleteeEntity = true
local InterP = true


cameraUsing = {
    {
        name = "Horse",
        x=0.2,
        y=0.0,
        z=1.8,
    },
    {
        name = "Olhos",
        x=0.0,
        y=-0.4,
        z=0.65,
    },
}

function OpenStable()
        inCustomization = true
        horsesp = true


        SetEntityHeading(cAPI.GetPlayerHorse(), 334)
        DeleteeEntity = true
        SetNuiFocus(true, true)
        InterP = true

        local hashm = GetEntityModel(cAPI.GetPlayerHorse())

        if hashm ~= nil and IsPedOnMount(PlayerPedId()) then
            createCamera(PlayerPedId())
        else    
            createCamera(PlayerPedId())
        end
      --  SetEntityVisible(PlayerPedId(), false)
        if not alreadySentShopData then
            SendNUIMessage(
                {
                    action = "show",
                    shopData = getShopData()
                }
            )
        else
            SendNUIMessage(
                {
                    action = "show"
                }
            )
        end        
        TriggerServerEvent("VP:STABLE:AskForMyHorses")
end


local promptGroup
local varStringCasa = CreateVarString(10, "LITERAL_STRING", "Estabulo")
local blip
local prompts = {}
local SpawnPoint = {}
local StablePoint = {}
local HeadingPoint
local CamPos = {}
Citizen.CreateThread(function()
	while true do
		Wait(1)		
        local coords = GetEntityCoords(PlayerPedId())        
        for _, prompt in pairs(prompts) do
            if PromptIsJustPressed(prompt) then     
                for k, v in pairs(Config.Stables) do
                    if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 7 then           
                        HeadingPoint = v.Heading
                        StablePoint = {v.Pos.x, v.Pos.y, v.Pos.z}
                        CamPos = {v.SpawnPoint.CamPos.x, v.SpawnPoint.CamPos.y}
                        SpawnPoint = {x = v.SpawnPoint.Pos.x, y = v.SpawnPoint.Pos.y , z = v.SpawnPoint.Pos.z, h = v.SpawnPoint.Heading}
                        Wait(300)
                    end  
                end
                OpenStable()
            end
        end
	end
end)


Citizen.CreateThread(
    function()
        for _, v in pairs(Config.Stables) do
           -- blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, -145868367, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Estábulo')
            local prompt = PromptRegisterBegin()
            PromptSetActiveGroupThisFrame(promptGroup, varStringCasa)
            PromptSetControlAction(prompt, 0xE8342FF2)
            PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Acessar Estábulo'))
            PromptSetStandardMode(prompt, true)    
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetHoldMode(prompt, 1)
            PromptSetPosition(prompt, v.Pos.x, v.Pos.y, v.Pos.z)
            N_0x0c718001b77ca468(prompt, 3.0)
            PromptSetGroup(prompt, promptGroup)
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
                RemoveBlip(blip)
            end
        end

    end)


-- function deletePrompt()
--     if prompt ~= nil then
--         PromptSetVisible(prompt, false)
--         PromptSetEnabled(prompt, false)
--         PromptDelete(prompt)
--         prompt = nil
--         promptGroup = nil
--     end
-- end

function rotation(dir)
    local pedRot = GetEntityHeading(cAPI.GetPlayerHorse()) + dir
    SetEntityHeading(cAPI.GetPlayerHorse(), pedRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(20)
        else
            rotation(-20)
        end
        cb("ok")
    end
)

-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
-- 			end		
--         end
--     end
-- )


AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "hide"
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


RegisterNUICallback(
    "Saddles",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = nil
            SaddlesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0xBAA7E618, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddles[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0x17CEB41A, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddlecloths[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0xDA6DADCA, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. stirrups[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0x80451C25, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. bags[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0xAA0217AB, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. manes[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0xA63CAE10, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. horsetails[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0x5447332, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acshorn[num])
            cAPI.SetHorseComponentEnabled(hash)
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
            Citizen.InvokeNative(0xD710A5007C2AC539, cAPI.GetPlayerHorse(), 0xEFB31921, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, cAPI.GetPlayerHorse(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acsluggage[num])
            cAPI.SetHorseComponentEnabled(hash)
            AcsLuggageUsing = ("0x" .. acsluggage[num])
        end
    end
)

myHorses = {}

RegisterNUICallback(
    "selectHorse",
    function(data)
        TriggerServerEvent("VP:STABLE:SelectHorseWithId", tonumber(data.horseId))
    end
)

RegisterNetEvent("VP:STABLE:ReceiveHorsesData")
AddEventHandler(
    "VP:STABLE:ReceiveHorsesData",
    function(data)
        SendNUIMessage(
            {
                myHorsesData = data
            }
        )
    end
)

RegisterNetEvent("VP:STABLE:SelectHORSE")
AddEventHandler(
    "VP:STABLE:SelectHORSE",
    function(data)
        TriggerServerEvent("VP:STABLE:SelectHorseWithId", data.id)
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
        TriggerServerEvent("VP:STABLE:UpdateHorseComponents", dados)
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


function closeAll()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    horsesp = false
    inCustomization = false

    choosePed = {}
    local ped = cAPI.GetPlayerHorse()
    --  SetEntityVisible(ped, true)
    --  NetworkSetEntityInvisibleToNetwork(ped, false)
end

--- /// ARRASTAR CAVALO


local alreadySentShopData = false

function getShopData()
    alreadySentShopData = true

    local ret = {
        {
            name = "Cavalos de Equitação",
            ["A_C_HORSE_MORGAN_FLAXENCHESTNUT"] = {"Burrinho", 5, 17},
            ["A_C_Horse_KentuckySaddle_Grey"] = {"Kentucky Saddle (Cinza)", 20, 50},
            ["A_C_Horse_Morgan_Palomino"] = {"Morgan", 21, 55},

        },
        {
            name = "Cavalos de Corrida",
            ["A_C_Horse_Thoroughbred_DappleGrey"] = {"Thoroughbred", 47, 130},
            ["A_C_Horse_Nokota_ReverseDappleRoan"] = {"Nokota, o ágil.", 135, 450},
            ["A_C_Horse_AmericanStandardbred_Buckskin"] = {"Standardbred Americano", 47, 130},

        },
        {
            name = "Cavalos de Guerra",
            ["A_C_Horse_Andalusian_DarkBay"] = {"Andalusian (Preto Cintilante)", 50, 140},
            ["A_C_Horse_Andalusian_Perlino"] = {"Andalusian (Celeste)", 50, 140},
        },
        {
            name = "Cavalos de Carga",
            ["A_C_Horse_AmericanPaint_Overo"] = {"American Paint (Cor-de-pinto)", 47, 130},
            ["A_C_Horse_AmericanPaint_Tobiano"] = {"American Paint (Tobiano)", 50, 140},
            ["A_C_Horse_Appaloosa_Blanket"] = {"Appaloosa", 73, 200},    
        },
        {
            name = "Cavalos Frontline (Tanques)",
            ["A_C_Horse_Belgian_BlondChestnut"] = {"Belga (Castanho-Claro)", 30, 120},
            ["A_C_Horse_Belgian_MealyChestnut"] = {"Belga (Loiro)", 30, 120},
            ["A_C_Horse_Shire_LightGrey"] = {"Shire (Branco Acizentado)", 35, 130},
            ["A_C_Horse_SuffolkPunch_RedChestnut"] = {"Suffolk Punch (Castanho Avermelhado)", 55, 150},
        },
        {
            name = "Cavalos de Prestígio",
            ["A_C_Horse_Turkoman_Gold"] = {"Turkoman (Dourado Fulgente)", 470, 950},

        } 
    }

    return ret
end

local showroomHorse_entity
local showroomHorse_model

RegisterNUICallback(
    "loadHorse",
    function(data)
        local horseModel = data.horseModel

        if showroomHorse_model == horseModel then
            return
        end

        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
        end

        showroomHorse_model = horseModel

        local modelHash = GetHashKey(showroomHorse_model)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(10)
            end
        end

        showroomHorse_entity = CreatePed(modelHash, SpawnPoint.x, SpawnPoint.y, SpawnPoint.z-0.98, SpawnPoint.h, false, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, showroomHorse_entity, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, showroomHorse_entity)
        NetworkSetEntityInvisibleToNetwork(showroomHorse_entity, true)
        SetVehicleHasBeenOwnedByPlayer(showroomHorse_entity, true)
        -- SetModelAsNoLongerNeeded(modelHash)

        interpCamera("Horse", showroomHorse_entity)

    end
)

RegisterNUICallback(
    "CloseStable",
    function()
        SetNuiFocus(false, false)

        SendNUIMessage(
            {
                action = "hide"
            }
        )
        SetEntityVisible(PlayerPedId(), true)

        showroomHorse_model = nil

        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
        end
        DestroyAllCams(true)
        showroomHorse_entity = nil
        
    end
)

function interpCamera(cameraName, entity)
    for k,v in pairs(cameraUsing) do
        if cameraUsing[k].name == cameraName then
            tempCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
            AttachCamToEntity(tempCam, entity, cameraUsing[k].x + CamPos[1], cameraUsing[k].y + CamPos[2], cameraUsing[k].z)
            SetCamActive(tempCam, true)
            SetCamRot(tempCam, -30.0, 0, HeadingPoint + 50.0)
            if InterP then
                SetCamActiveWithInterp(tempCam, fixedCam, 1200, true, true)
                InterP = false
            end

        end
    end
end


function createCamera(entity)
    groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")    
    SetCamCoord(groundCam, StablePoint[1] + 0.5, StablePoint[2] - 3.6, StablePoint[3] )
    SetCamRot(groundCam, -20.0, 0.0, HeadingPoint + 20)
    SetCamActive(groundCam, true)    
    RenderScriptCams(true, false, 1, true, true)
    --Wait(3000)
    -- last camera, create interpolate
    fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(fixedCam, StablePoint[1] + 0.5, StablePoint[2] - 3.6, StablePoint[3] +1.8)
    SetCamRot(fixedCam, -20.0, 0, HeadingPoint + 50.0)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 3900, true, true)
    Wait(3900)
    DestroyCam(groundCam)
end