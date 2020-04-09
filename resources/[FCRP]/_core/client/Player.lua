cPlayer = {}
Tunnel.bindInterface("API:cPlayer", cPlayer)
Proxy.addInterface("API:cPlayer", cPlayer)

local isHandcuffed = false
local handcuff_prevDrawable

function cPlayer.Initialize(model, skin, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)

    local camera = cWrapper.SkyCameraAtCoords(decodedLastPosition)

    cPed.SetModel(model)
    cPed.SetHeadData(skin)
    cPed.SetClothing(clothing)
    cWrapper.PlaySkyCameraAnimationAtCoords(decodedLastPosition, camera)

    TriggerEvent("ToogleBackCharacter")
end

function cPlayer.Handcuff(bool, handlerServerId)
    isHandcuffed = bool
    local ped = PlayerPedId()

    if isHandcuffed == true then
        if handlerServerId ~= nil then
            local handlerPed = GetPlayerPed(GetPlayerFromServerId(handlerServerId))

            AttachEntityToEntity(handlerPed, ped, 4103, 11816, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            cPed.PlayAnimation("mp_arrest_paired", "cop_p2_back_left", handlerPed)

            Citizen.CreateThread(
                function()
                    Citizen.Wait(3500)
                    DetachEntity(handlerPed, true, false)
                end
            )
        end

        cPed.PlayAnimation("mp_arrest_paired", "crook_p2_back_left")

        handcuff_prevDrawable = GetPedDrawableVariation(ped, 7)

        if IsPedMale(ped) then
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        else
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        end

        Citizen.CreateThread(
            function()
                while isHandcuffed do
                    cPed.PlayAnimation("mp_arrest_paired", "crook_p2_back_left")
                    Citizen.Wait(100)
                end
            end
        )
    else
        if handlerServerId ~= nil then
            local handlerPed = GetPlayerPed(GetPlayerFromServerId(handlerServerId))

            AttachEntityToEntity(handlerPed, ped, 4103, 11816, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            cPed.PlayAnimation("mp_arrest_paired", "cop_p2_back_left", handlerPed)

            Citizen.Wait(3500)
            DetachEntity(handlerPed, true, false)
        end

        if IsEntityPlayingAnim(ped, "mp_arrest_paired", "crook_p2_back_left", 3) then
            ClearPedTasks(ped)
        end

        if handcuff_prevDrawable ~= nil then
            SetPedComponentVariation(ped, 7, handcuff_prevDrawable, 0, 0)
            handcuff_prevDrawable = nil
        end
    end
end

function cPlayer.IsHandcuffed()
    return isHandcuffed
end

function cPlayer.ToggleHandcuff(handlerServerId)
    cPlayer.Handcuff(not isHandcuffed, handlerServerId)
end
