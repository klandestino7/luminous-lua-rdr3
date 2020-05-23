-- p_bag_voodoo01x

-- local PropDroppedItemPool = {}

local prompt_pickup
local prompt_group

function CreateDroppedItemAt(itemId, itemAmount, x, y, z)
    local worldModel = ItemList[itemId].worldModel or "p_bag01x"

    if not HasModelLoaded(worldModel) then
        RequestModel(worldModel)
        while not HasModelLoaded(worldModel) do
            Wait(10)
        end
    end

    local prop = CreateObject(worldModel, x, y, z, 1, 1, 1)
    PlaceObjectOnGroundProperly(prop)
    SetObjectTargettable(prop, true)
    CreatePromptPickupAtEntity(prop)

    DecorSetString(prop, "dropped_item_itemid", itemId)
    DecorSetInt(prop, "dropped_item_itemamount", itemAmount)

    -- table.insert(PropDroppedItemPool, {prop, ItemList[itemId].name, itemAmount})
end

local lgroup

function CreatePromptPickupAtEntity(entity)
    local prompt_pickup = PromptRegisterBegin()
    -- prompt_group = GetRandomIntInRange(0, 0xffffff)
    local prompt_group = PromptGetGroupIdForTargetEntity(entity)
    PromptSetControlAction(prompt_pickup, 0xDFF812F9)
    PromptSetText(prompt_pickup, CreateVarString(10, "LITERAL_STRING", "Pegar"))
    PromptSetEnabled(prompt_pickup, true)
    PromptSetVisible(prompt_pickup, true)
    PromptSetStandardMode(prompt_pickup, true)
    N_0x0c718001b77ca468(prompt_pickup, 3.0)
    PromptSetGroup(prompt_pickup, prompt_group)
    PromptRegisterEnd(prompt_pickup)

    lgroup = prompt_group

    print(prompt_pickup, prompt_group)
end

Citizen.CreateThread(
    function()
        DecorRegister("dropped_item_itemid", 4)
        DecorRegister("dropped_item_itemamount", 3)

        CreateDroppedItemAt("raw_gold", 1, GetEntityCoords(PlayerPedId()))
    end
)

-- local closeToOneOrMoreDroppedItem = false

local endc

Citizen.CreateThread(
    function()
        -- CreatePromptPickup()

        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pPosition = GetEntityCoords(ped)

            -- closeToOneOrMoreDroppedItem = false
            -- for _, v in pairs(PropDroppedItemPool) do
            --     local prop = v[1]
            --     if #(pPosition - GetEntityCoords(prop)) <= 10.0 then
            --         closeToOneOrMoreDroppedItem = true
            --         break
            --     end
            -- end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            -- local ped = PlayerPedId()
            -- local pPosition = GetEntityCoords(ped)

            local entity = GetTargettingEntity()

            if entity ~= 0 then
                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pPosition, GetEntityCoords(entity), 255, 0, 255, 255)
            end


            -- if closeToOneOrMoreDroppedItem then
            --     local ped = PlayerPedId()
            --     local pPosition = GetEntityCoords(ped)

            --     local lDist
            --     local lPropIndex

            --     for _, v in pairs(PropDroppedItemPool) do
            --         local prop = v[1]
            --         local dist = #(pPosition - GetEntityCoords(prop))
            --         if (lDist == nil and dist <= 1.0) or (lDist ~= nil and dist < lDist) then
            --             lPropIndex = _
            --         end
            --     end

            --     if lPropIndex ~= nil then
            --         local v = PropDroppedItemPool[lPropIndex]
            --         local prop = v[1]
            --         local itemName = v[2]
            --         local itemAmount = v[3]
            --         -- local prompt_group_name =
            --         -- local prop_prompt_group = PromptGetGroupIdForTargetEntity(prop)

            --         -- print("prompt showing", itemName, itemAmount, prompt_pickup, prompt_group)
            --         -- PromptSetGroup(prompt_pickup, prop_prompt_group)
            --         -- PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", itemName))
            --     end
            -- end

            -- PromptSetActiveGroupThisFrame(lgroup, CreateVarString(10, "LITERAL_STRING", "itemName"))
        end
    end
)

function GetTargettingEntity()
    local ped = PlayerPedId()
    local pedVector = GetEntityCoords(ped)

    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local lastCoords = vec3(cameraCoord.x + direction.x * 2.0, cameraCoord.y + direction.y * 2.0, cameraCoord.z + direction.z * 2.0)

    local rayHandle = StartShapeTestRay(cameraCoord, lastCoords, -1, ped, 0)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, cameraCoord, lastCoords, 255, 0, 255, 255)

    if hit == 1 then
        return entityHit
    end
end

RegisterNetEvent("VP:INVENTORY:DROP:Create")
AddEventHandler(
    "VP:INVENTORY:DROP:Create",
    function()
    end
)

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end
