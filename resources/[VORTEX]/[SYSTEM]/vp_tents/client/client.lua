local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

pitch = 0
tempObj = nil
TentsSpawned = {}
Tents = {}
myIdentifier = nil
position = {}

RegisterNetEvent('VP:TENTS:usedItem')
AddEventHandler('VP:TENTS:usedItem', function(model)   
    local coords  = GetEntityCoords(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 1.6)
    if not HasModelLoaded(model) then
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Citizen.Wait(1)
    end
    tempObj = CreateObject(model, x, y, z-1, true, true, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if tempObj ~= nil then
            local coords  = GetEntityCoords(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward * 1.6)
            SetEntityAlpha(tempObj, 127)
            SetEntityHeading(tempObj, GetGameplayCamRelativeHeading())
            SetEntityCollision(tempObj, false, false)
            SetEntityCoords(tempObj, x+2,y,z-1)
            SetEntityRotation(tempObj, GetGameplayCamRot(1))
            if Citizen.InvokeNative(0x50F940259D3841E6, 1, 0x07CE1E61) then
                for k,v in pairs(Config.Tents) do
                    if Config.Tents[k].tentModel == GetEntityModel(tempObj) then
                        local pPos = GetEntityCoords(tempObj)
                        local pRot = GetEntityRotation(tempObj)
                        local pHea = GetEntityHeading(tempObj)  
                        TriggerServerEvent('VP:TENTS:createdTent', Config.Tents[k].itemId, Config.Tents[k].tentModel, pPos, pRot, pHea)
                        DeleteObject(tempObj)
                        tempObj = nil
                        exports['mythic_progbar']:Progress({
                            name = "creating_tents",
                            duration = Config.Tents[k].tentSpawnTime,
                            label = Config.Tents[k].tentLabel,
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = nil,
                                anim = nil,
                                flags = 49,
                            },
                            prop = {
                                model = nil,
                            }
                        }, function(status)
                            if not status then
                                TriggerServerEvent('VP:TENTS:spawnTents')
                            end
                        end)
                    end
                end
            elseif Citizen.InvokeNative(0x50F940259D3841E6, 1, 0xF84FA74F) then
                DeleteObject(tempObj)
                tempObj = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent('VP:TENTS:spawnTents')
end)

RegisterNetEvent('VP:TENTS:spawnCliTents')
AddEventHandler('VP:TENTS:spawnCliTents', function(tents, identifier)
    myIdentifier = identifier
    for k,v in pairs(tents) do
        if TentsSpawned[k] == nil then
            position[k] = json.decode(tents[k].position)
            TentsSpawned[k] = CreateObject(tents[k].model, position[k].x, position[k].y, position[k].z, true, true, false)
            Tents[k] = tents[k]
            SetEntityCoords(TentsSpawned[k], position[k].x,position[k].y, position[k].z)
            SetEntityHeading(TentsSpawned[k], position[k].h)
            SetEntityRotation(TentsSpawned[k], position[k].rotx, position[k].roty, position[k].rotz)
        end
    end
end)

appear = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(2, 0x3C3DD371) then -- Hold PGDOWN
            appear = not appear
        end
        for k,v in pairs(TentsSpawned) do
            local pos = GetEntityCoords(TentsSpawned[k])
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos.x, pos.y, pos.z, true) <= 2.0 then
                if Tents[k].identifier == myIdentifier then
                    for x,a in pairs(Config.Tents) do
                        if appear and Config.Tents[x].tentModel == GetEntityModel(TentsSpawned[k]) then
                            DrawText3D(pos.x, pos.y, pos.z, "Sua "..Config.Tents[x].tentText)
                        end
                        if IsControlJustPressed(2, 0x4AF4D473) and appear then -- Hold DEL
                            if Config.Tents[x].tentModel == GetEntityModel(TentsSpawned[k]) then
                                TriggerServerEvent('VP:TENTS:removeTents', Tents[k].id, Config.Tents[x].itemId)
                                DeleteObject(TentsSpawned[k])
                            end
                        end
                    end
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("menu_textures", "translate_bg_1a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 5, 5, 5, 190, 0)
end
