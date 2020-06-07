function cAPI.SetPlayerPed(model)
    local modelHash = GetHashKey(model)

    if IsModelValid(modelHash) then
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(10)
            end
        end
    end

    SetPlayerModel(PlayerId(), modelHash, true)
    NativeSetRandomOutfitVariation(PlayerPedId())

    -- SetModelAsNoLongerNeeded(model)

    -- Citizen.Wait(200)
end

function cAPI.SetPedScale(ped, num)
    SetPedScale(ped, tonumber(num))
end

function cAPI.SetPedFaceFeature(ped, faceFeatures)
    local gameFaceFeatures = {
        0x84D6,
        0x3303,
        0x2FF9,
        0x4AD1,
        0xC04F,
        0xB6CE,
        0x2844,
        0xED30,
        0x6A0B,
        0xABCF,
        0x358D,
        0x8D0A,
        0xEBAE,
        0x1DF6,
        0x3C0F,
        0xC3B2,
        0xE323,
        0x8B2B,
        0x1B6B,
        0xEE44,
        0xD266,
        0xA54E,
        0xDDFB,
        0x6E7F,
        0x3471,
        0x03F5,
        0x34B1,
        0xF156,
        0x561E,
        0xF065,
        0xAA69,
        0x7AC3,
        0x410D,
        0x1A00,
        0x91C1,
        0xC375,
        0xBB4D,
        0xB0B0,
        0x5D16
    }

    for index, floatValue in pairs(faceFeatures) do
        local faceFeatureHash = gameFaceFeatures[index]

        -- Doesn't need to be requested !!!!!!

        NativeSetPedFaceFeature(ped, faceFeatureHash, floatValue)
        NativeUpdatePedVariation(ped)
    end
end

function cAPI.SetPedBodyType(ped, bodyTypeHash)
    bodyTypeHash = tonumber(bodyTypeHash)

    -- Doesn't need to be requested !!!!!!

    -- if IsPedMale(ped) then
    Citizen.InvokeNative(0xA5BAE410B03E7371, ped, bodyTypeHash, true, true, true)
    -- else
    --     Citizen.InvokeNative(0xA5BAE410B03E7371, ped, bodyTypeHash, true, true, true)
    -- end
end

function cAPI.SetSkin(ped, componentArray)
    -- componentArray = json.decode(componentArray)

    for _, componentHash in pairs(componentArray) do
        componentHash = tonumber(componentHash)

        -- Doesn't need to be requested !!!!!!

        NativeSetPedComponentEnabled(ped, componentHash, true, true)
    end
end

function cAPI.SetPedClothing(ped, clothingArray)
    local numComponents = 0

    if clothingArray ~= nil then
        for _, componentHash in pairs(clothingArray) do
            componentHash = tonumber(componentHash)

            -- Doesn't need to be requested !!!!!!

            NativeSetPedComponentEnabled(ped, componentHash, true, true)

            -- while NativeIsPedComponentEquipped(ped, componentHash) == false do
            --     print(componentHash, "isEquipped", NativeIsPedComponentEquipped(ped, componentHash))
            --     Wait(10)
            -- end

            -- SetModelAsNoLongerNeeded(modelHash)

            numComponents = numComponents + 1
        end
    end

    if numComponents <= 0 then
        -- Load default clothing
        if IsPedMale(ped) then
            NativeSetPedComponentEnabled(ped, 0x1B164391, true, true)
            NativeSetPedComponentEnabled(ped, 0x10B87936, true, true)
            NativeSetPedComponentEnabled(ped, 0x11B7CAB1, true, true)
            NativeSetPedComponentEnabled(ped, 0x1526EAB7, true, true)
        else
            NativeSetPedComponentEnabled(ped, 0x15B760CE, true, true)
            NativeSetPedComponentEnabled(ped, 0x1178F4F4, true, true)
            NativeSetPedComponentEnabled(ped, 0x141281DC, true, true)
            NativeSetPedComponentEnabled(ped, 0x1945CE44, true, true)
        end
    end
end

function cAPI.TaskAnimalInteraction(interaction)
    local ped = PlayerPedId()

    local interactions = {
        -- interactionId      interactionAnimation    propId
        ["injection"] = {"INTERACT_INJECTION", "p_cs_syringe01x"}
    }

    if interactions[interaction] then
        local playerHorse = cAPI.GetPlayerHorse()
        if playerHorse ~= nil and playerHorse ~= 0 then
            local v = interactions[interaction]
            TaskAnimalInteraction(ped, playerHorse, GetHashKey(v[1]), v[2] ~= nil and GetHashKey(v[2]) or 0, 0)
        end
    end
end

function cAPI.TaskInteraction(interaction)
    local ped = PlayerPedId()
    local hasWeaponInHead = GetCurrentPedWeapon(ped, 0)

    local unk1 = 1 -- 1 or 3
    local unk2 = 0 -- always
    local unk3 = -1.0

    local interactions = {
        -- p_cs_bottleslim01x
        -- interactionId       propId              promptName     propSlot            interactionAnimation
        ["drink_tonic"] = {"s_inv_antidote01x", -1199896558, "PrimaryItem", "USE_TONIC_SATCHEL_UNARMED_QUICK"},
        ["injection"] = {"s_immunitybooster01x", -1199896558, "PrimaryItem", "USE_STIMULANT_INJECTION_QUICK_LEFT_HAND"}
    }

    if interactions[interaction] then
        local v = interactions[interaction]

        local propEntity = 0
        if v[1] ~= nil then
            propEntity = CreateObject(GetHashKey(v[1]), GetEntityCoords(ped), false, true, false, false, true)
        end

        TaskItemInteraction_2(ped, GetHashKey(v[2]), propEntity, GetHashKey(v[3]), GetHashKey(v[4]), unk1, unk2, unk3)
    end
end

function NativeSetRandomOutfitVariation(ped)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
end

function NativeSetPedFaceFeature(ped, index, value)
    Citizen.InvokeNative(0x5653AB26C82938CF, ped, index, value)
end

function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    -- local categoryHash = NativeGetPedComponentCategory(componentHash)
    -- print(componentHash, categoryHash, NativeGetMetapedType(ped))

    -- NativeFixMeshIssues(ped, categoryHash)

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)
    -- NativeUpdatePedVariation(ped)
end

function NativeUpdatePedVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
end

function NativeFixMeshIssues(ped, categoryHash)
    Citizen.InvokeNative(0x59BD177A1A48600A, ped, categoryHash)
end

function NativeIsPedComponentEquipped(ped, componentHash)
    return Citizen.InvokeNative(0xFB4891BD7578CDC1, ped, componentHash)
end

function NativeGetPedComponentCategory(componentHash)
    return Citizen.InvokeNative(0x5FF9A878C3D115B8, componentHash, NativeGetMetapedType(ped), true)
end

function NativeGetMetapedType(ped)
    return Citizen.InvokeNative(0xEC9A1261BF0CE510, ped)
end


function cAPI.playAnim(upper, seq, looping)
    if seq.task then -- is a task (cf https://github.com/ImagicTheCat/vRP/pull/118)
      cAPI.stopAnim(true)
  
      local ped = GetPlayerPed(-1)
      if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then -- special case, sit in a chair
        local x,y,z = cAPI.getPosition()
        TaskStartScenarioAtPosition(ped, seq.task, x, y, z-1, GetEntityHeading(ped), 0, 0, false)
      else
        TaskStartScenarioInPlace(ped, seq.task, 0, not seq.play_exit)
      end
    else -- a regular animation sequence
    cAPI.stopAnim(self, upper)
  
      local flags = 0
      if upper then flags = flags+48 end
      if looping then flags = flags+1 end
  
      Citizen.CreateThread(function()
        -- prepare unique id to stop sequence when needed
        local id = self.anim_ids:gen()
        self.anims[id] = true
  
        for k,v in pairs(seq) do
          local dict = v[1]
          local name = v[2]
          local loops = v[3] or 1
  
          for i=1,loops do
            if self.anims[id] then -- check animation working
              local first = (k == 1 and i == 1)
              local last = (k == #seq and i == loops)
  
              -- request anim dict
              RequestAnimDict(dict)
              local i = 0
              while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
                Citizen.Wait(10)
                RequestAnimDict(dict)
                i = i+1
              end
  
              -- play anim
              if HasAnimDictLoaded(dict) and self.anims[id] then
                local inspeed = 8.0001
                local outspeed = -8.0001
                if not first then inspeed = 2.0001 end
                if not last then outspeed = 2.0001 end
  
                TaskPlayAnim(GetPlayerPed(-1),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
              end
  
              Citizen.Wait(0)
              while GetEntityAnimCurrentTime(GetPlayerPed(-1),dict,name) <= 0.95 and IsEntityPlayingAnim(GetPlayerPed(-1),dict,name,3) and self.anims[id] do
                Citizen.Wait(0)
              end
            end
          end
        end
  
        -- free id
        self.anim_ids:free(id)
        self.anims[id] = nil
      end)
    end
  end
  
  -- stop animation (new version)
  -- upper: true, stop the upper animation, false, stop full animations
  function cAPI.stopAnim(upper)
    self.anims = {} -- stop all sequences
    if upper then
      ClearPedSecondaryTask(GetPlayerPed(-1))
    else
      ClearPedTasks(GetPlayerPed(-1))
    end
  end