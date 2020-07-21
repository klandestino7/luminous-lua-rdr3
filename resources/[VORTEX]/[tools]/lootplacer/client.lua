local entity

local entityIndex

local entities = {}

local xAxis, yAxis, zAxis = 0.0, 0.0, 0.0

local cJSON = {}

local SELECTION_DISTANCE_THRESHOLD = 1.0

Citizen.CreateThread(
    function()
        ReadFromInput()

        local l_lookingAtPosition = vec3(0, 0, 0)
        local l_entity

        while true do
            Citizen.Wait(0)

            DisableControlAction(0, GetHashKey("INPUT_ATTACK"), true)
            DisableControlAction(0, GetHashKey("INPUT_AIM"), true)

            if entity then
                -- DrawDimension(entity)

                local lookingAtPosition = GetLookingAtPosition(7.0)

                local entityPosition = GetEntityCoords(entity)

                local groundZ = GetGroundZAt(vec3(lookingAtPosition.xy, 999))
                local lowestPoint = GetEntityLowestPoint(entity)

                local distance = #(l_lookingAtPosition - lookingAtPosition)
                local hasMovedAConsiderableLenght = (distance > 0.14)

                l_lookingAtPosition = lookingAtPosition

                -- if hasMovedAConsiderableLenght then
                SetEntityCoords(entity, lookingAtPosition + vec3(0, 0, 0.15), xAxis, yAxis, zAxis, 0)
                ActivatePhysics(entity)
                -- end

                if IsControlPressed(0, 0x430593AA) then
                    local pedRot = GetEntityHeading(entity) - 10
                    SetEntityHeading(entity, pedRot % 360)
                end

                if IsControlPressed(0, 0x3076E97C) then
                    local pedRot = GetEntityHeading(entity) + 10
                    SetEntityHeading(entity, pedRot % 360)
                end

                if IsDisabledControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                    local model = GetEntityModel(entity)
                    local string_model = GetHashName(model)

                    FreezeEntityPosition(entity, false)
                    SetEntityCollision(entity, true, 0)
                    ActivatePhysics(entity)
                    SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(entity, false)

                    local x, y, z = table.unpack(entityPosition)
                    local heading = GetEntityHeading(entity)

                    local data = {
                        position = {x, y, z},
                        rotation = heading
                    }

                    if not closestIndex then
                        if not cJSON[string_model] then
                            cJSON[string_model] = {}
                        end

                        table.insert(entities, entity)
                        table.insert(cJSON[string_model], data)
                    else
                        closestIndex = nil
                    end

                    Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, false)

                    CreateMyEntity(string_model, lookingAtPosition)
                end

                if IsDisabledControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                    if not closestIndex then
                    else
                        local model = GetEntityModel(entity)

                        table.remove(entities, closestIndex)
                        closestIndex = nil

                        print("set to nil")
                    end

                    DeleteMyEntity()
                end
            else
                -- end
                -- if IsDisabledControlPressed(0, GetHashKey("INPUT_ATTACK")) then
                local lookingAtPosition = GetLookingAtPosition(7.0)

                local closestIndex
                local closestDistance

                for index, ent in pairs(entities) do
                    local distance = #(GetEntityCoords(ent) - lookingAtPosition)

                    if distance and distance <= SELECTION_DISTANCE_THRESHOLD then
                        if not closestDistance or distance < closestDistance then
                            closestIndex = index
                            closestDistance = distance
                        end
                    end
                end

                if closestIndex then
                    l_entity = entities[closestIndex]
                    Citizen.InvokeNative(0x7DFB49BCDB73089A, l_entity, true)

                    if IsDisabledControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                        l_entity = nil
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, l_entity, false)

                        entity = entities[closestIndex]
                        entityIndex = closestIndex

                        Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
                    end
                end
            end
        end
    end
)

RegisterCommand(
    "lpset",
    function(source, args, raw)
        local model = args[1]
        local modelHash = tonumber(model) == nil and model or tonumber(model)

        if not IsModelValid(modelHash) then
            print("LootPlace: Model invalido!")
            return
        end

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(0)
            end
        end

        local lookingAtPosition = GetLookingAtPosition(10.0)

        DeleteMyEntity()
        print(model)
        CreateMyEntity(modelHash, lookingAtPosition)
    end,
    false
)

RegisterCommand(
    "saveloot",
    function(source, args, raw)
        WriteToOutput()
    end,
    false
)

function CreateMyEntity(model, position)
    entity = CreateObject(model, position, true, true, true)

    FreezeEntityPosition(entity, true)
    SetEntityCollision(entity, false, 0)
    --ActivatePhysics(entity)
    --SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(entity, false)

    Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
end

function DeleteMyEntity()
    if entity then
        SetEntityAsMissionEntity(entity, true, true)
        DeleteEntity(entity)

        entity = nil
    end
end

function GetLookingAtPosition(maxDistance)
    local ped = PlayerPedId()
    local pedVector = GetEntityCoords(ped)

    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()

    local adjustedRotation = {
        x = (math.pi / 180) * cameraRotation.x,
        y = (math.pi / 180) * cameraRotation.y,
        z = (math.pi / 180) * cameraRotation.z
    }

    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }

    local lastCoords = vec3(cameraCoord.x + direction.x * maxDistance, cameraCoord.y + direction.y * maxDistance, cameraCoord.z + direction.z * maxDistance)

    local rayHandle = StartShapeTestRay(cameraCoord, lastCoords, -1, ped, 0)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

    if hit == 1 and entityHit ~= entity then
        lastCoords = endCoords
    end

    return lastCoords
end

function GetGroundZAt(position)
    local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)

    return groundZ
end

function GetEntityLowestPoint(entity)
    local min, max = GetModelDimensions(GetEntityModel(entity))

    return GetOffsetFromEntityInWorldCoords(entity, min)
end

function ReadFromInput()
    local contents = LoadResourceFile(GetCurrentResourceName(), "save.json")

    cJSON = json.decode(contents)

    SpawnEntitiesAtJSON()
end

function WriteToOutput()
    -- local file = io.open("C:\\Users\\key\\Desktop\\project_VP\\rdr3\\resources\\[VORTEX]\\[tools]\\lootplacer\\output.json", "w")

    -- if file then
    --     local contents = json.encode(cJSON)
    --     file:write(contents)
    --     io.close(file)
    --     return true
    -- else
    --     return false
    -- end

    TriggerServerEvent("LP:Write", "save.json", json.encode(cJSON))
end

function SpawnEntitiesAtJSON()
    for model, list in pairs(cJSON) do
        model = tonumber(model)
        if IsModelValid(model) then
            if not HasModelLoaded(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(0)
                end
            end

            for _, v in pairs(list) do
                local x, y, z = table.unpack(v.position)

                local ent = CreateObject(model, x, y, z, true, true, true)
                local rotation = table.unpack(v.rotation)
                SetEntityHeading(ent, rotation)

                ActivatePhysics(ent)
                SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(ent, true)

                table.insert(entities, ent)
            end

            SetModelAsNoLongerNeeded(model)
        end
    end
end

function GetHashName(hash)
    if HASH_MODELS[hash] then
        return HASH_MODELS[hash]
    end
    if HASH_PEDS[hash] then
        return HASH_PEDS[hash]
    end
    if HASH_PROVISIONS[hash] then
        return HASH_PROVISIONS[hash]
    end
    if HASH_VEHICLES[hash] then
        return HASH_VEHICLES[hash]
    end
    return false
end

AddEventHandler(
    "onResourceStop",
    function()
        WriteToOutput()

        DeleteMyEntity()

        for _, ent in pairs(entities) do
            SetEntityAsMissionEntity(ent, true, true)
            DeleteObject(ent)
        end
    end
)
