local butchers = {
    vec3(-1753.07, -394.78, 156.18), --Cabana de Açougue de Strawberry
    vec3(-341.08, 767.16, 116.71), --Cabana de Açougue de Valentine
    vec3(1296.28, -1279.22, 75.84), --Cabana de Açougue de Rhodes
    vec3(-5508.29, -2948.16, -1.87) --Cabana de Açougue de Tumbleweed
}

local closestButcherIndex

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            closeToButcher = false

            local ped = PlayerPedId()
            local pedVec = GetEntityCoords(ped)

            local closestDist

            for _, v in pairs(butchers) do
                local dist = #(pedVec - v)
                if (dist <= 50 and closestDist == nil) or (closestDist ~= nil and dist < closestDist) then
                    closestDist = dist
                    closestButcherIndex = _
                end
            end
        end
    end
)

local lastCarriable

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if lastCarriable ~= nil then
                if not DoesEntityExist(lastCarriable) then
                    lastCarriable = nil
                else
                    local ped = PlayerPedId()
                    local pedVec = GetEntityCoords(ped)

                    local carriableVec = GetEntityCoords(lastCarriable)

                    if #(pedVec - carriableVec) >= 500 then
                        lastCarriable = nil
                    end
                end
            end

            if closestButcherIndex ~= nil then
                local carriedEntity = GetPedCarriedEntity()
                local type = GetEntityType(carriedEntity)
                -- 1 : animal
                -- 3 : pelt
                if carriedEntity ~= false and (type == 1 or type == 3) then
                    lastCarriable = carriedEntity
                end

                if carriedEntity == false and lastCarriable ~= nil then
                    local carriableVec = GetEntityCoords(lastCarriable)

                    local butcherVec = butchers[closestButcherIndex]

                    if #(carriableVec - butcherVec) <= 2.5 then
                        Citizen.InvokeNative(0x18FF3110CF47115D, lastCarriable, 2, false)
                        TriggerServerEvent("VP:BUTCHER:TryToSell", type, GetEntityModel(lastCarriable), lastCarriable, GetAnimalCarcassQuality(lastCarriable))

                        lastCarriable = nil
                    end
                end
            end
        end
    end
)

RegisterNetEvent("VP:BUTCHER:EntityNotAccepted")
AddEventHandler(
    "VP:BUTCHER:EntityNotAccepted",
    function(entity)
        if DoesEntityExist(entity) then
            -- if GetEntityModel(entity) == entModel then
            Citizen.InvokeNative(0x18FF3110CF47115D, entity, 2, true)
        -- end
        end
    end
)

function GetPedCarriedEntity()
    return Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
end

function GetAnimalCarcassQuality(Ped)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, Ped)
    return ret ~= false and ret or 0
end

-- // 0x79443D56C8DF45EE
-- Ped _GET_CARRIER(Entity entity)

-- // 0x7BCC6087D130312A
-- int _GET_PED_QUALITY(Ped ped) ?

-- // 0x7528720101A807A5
-- void _SET_PED_CARCASS_QUALITY(Ped Ped)

-- // 0xDACE03C65C6666DB
-- void _SET_0x6CFC373008A1EDAF -- related

-- // 0xCE6B874286D640BB
-- void SET_0x7BCC6087D130312A -- related

-- // 0x88EFFED5FE8B0B4A
-- int _GET_PED_CARCASS_QUALITY(Ped ped)

-- // 0xA911EE21EDF69DAF
-- BOOL IS_PED_CARRYING(Ped ped)

-- ENTITY::_0x9A100F1CF4546629(iParam0) || ENTITY::_0xC346A546612C49A9(iParam0))
-- WAS_PED_SKINNED || IS_PED_BEING_SKINNED
