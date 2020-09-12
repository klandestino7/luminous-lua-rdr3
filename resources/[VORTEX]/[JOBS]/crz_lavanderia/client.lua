
local entrou = false
local maquinas = {
    {id = 1, x= 1122.42,y=-3193.31,z=-40.39,h=0, state = 0, value = 0, propAberto = "bkr_prop_prtmachine_dryer_op", propFechado = "bkr_prop_prtmachine_dryer_spin"},
    {id = 2, x= 1124.85,y=-3193.13,z=-40.39,h=0, state = 0, value = 0, propAberto = "bkr_prop_prtmachine_dryer_op", propFechado = "bkr_prop_prtmachine_dryer_spin"},
    {id = 3, x= 1126.95,y=-3193.25,z=-40.39,h=0, state = 0, value = 0, propAberto = "bkr_prop_prtmachine_dryer_op", propFechado = "bkr_prop_prtmachine_dryer_spin"},
}
-- Conceito:
-----------------------
--      *( Quando o cara entrar neste local ele registrar todas as máquinas em uma coordenada, com a variavel comecarLavagem(fehcado))
--      *(Após entrar e chegar perto da máquina, você deverá abrir-la a tampa e colocar a variavel (propAberto))
--      *(Após abrir a tampa da lavagem vai perguntar quando dinheiro inserir(máx:2500) por spin da máquina.)
--      *(Após isso ele irá fechar a máquina com a variavel (propFechado))
--      *( Depois de um certo tempo ela irá abrir com o dinheiro(molhado) para depois ir na prensa e secar-la e irá ficar pronto o dinheiro.)
------------------------
local entrada = {
    {1059.95,-2407.19,29.97},
    {1063.01,-2407.45,29.98}
}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for k,v in pairs(entrada) do
            DrawMarker(20, v[1],v[2],v[3],0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, 255,25,25, 25, false, true, 2, nil, nil, false)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v[1],v[2],v[3],true) <= 1 then
                DrawText3Ds(v[1],v[2],v[3],"PRESSIONE ~g~G~w~ PARA ENTRAR NA LAVANDERIA")                
                if IsControlJustPressed(0,47) then	
                    TriggerEvent('crz_lavanderia:teleportar')
                end
            end
        end
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1138.0465087891,-3199.1188964844,-39.665721893311,true) <= 1 then
            DrawText3Ds(1138.0465087891,-3199.1188964844,-39.665721893311,"PRESSIONE ~g~G~w~ PARA SAIR DA LAVANDERIA")                
            if IsControlJustPressed(0,47) then	
                TriggerEvent('crz_lavanderia:saida')
            end
        end
        local obj = GetClosestObjectOfType(1123.12,-3193.55,-40.39, 1.0, GetHashKey("bkr_prop_prtmachine_dryer_op"), false, true ,true) or GetClosestObjectOfType(1123.12,-3193.55,-40.39, 1.0, GetHashKey("bkr_prop_prtmachine_dryer_spin"), false, true ,true) 
        local obj2 = GetClosestObjectOfType(1124.73,-3193.45,-40.39, 1.0, GetHashKey("bkr_prop_prtmachine_dryer_op"), false, true ,true) or GetClosestObjectOfType(1124.73,-3193.45,-40.39, 1.0, GetHashKey("bkr_prop_prtmachine_dryer_spin"), false, true ,true) 
        local obj3 = GetClosestObjectOfType(1126.95,-3193.25,-40.39, 1.0, GetHashKey("bkr_prop_prtmachine_dryer_op"), false, true ,true) or GetClosestObjectOfType(1126.95,-3193.25,-40.39, 1.0, GetHashKey("bkr_prop_prtmachine_dryer_spin"), false, true ,true) 
        if obj == 0 then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1129.54,-3194.13,-40.39,true) <= 1 then
                DrawText3Ds(1129.54,-3194.13,-40.39,"PRESSIONE ~g~G~w~ PARA ATIVAR")                
                if IsControlJustPressed(0,47) then	
                    TriggerEvent('crz_lavanderia:criarMaquinas', 1)
                end
            end
        elseif obj2 == 0 then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1129.54,-3194.13,-40.39,true) <= 1 then
                DrawText3Ds(1129.54,-3194.13,-40.39,"PRESSIONE ~g~G~w~ PARA ATIVAR")                
                if IsControlJustPressed(0,47) then	
                    TriggerEvent('crz_lavanderia:criarMaquinas', 2)
                end
            end
        elseif obj3 == 0 then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1129.54,-3194.13,-40.39,true) <= 1 then
                DrawText3Ds(1129.54,-3194.13,-40.39,"PRESSIONE ~g~G~w~ PARA ATIVAR")                
                if IsControlJustPressed(0,47) then	
                    TriggerEvent('crz_lavanderia:criarMaquinas', 3)
                end
            end
        end
    end
end)

RegisterNetEvent('crz_lavanderia:statuses')
AddEventHandler('crz_lavanderia:statuses', function(maq)
    for k,v in pairs(maquinas) do
        if v.id == maq then
            Citizen.CreateThread(function() 
                while v.state == 2 do
                    Wait(0)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z,true) <= 1.5 then
                        DrawText3Ds(v.x,v.y,v.z,"PRESSIONE ~g~G~w~ PARA DEPOSITAR DINHEIRO SUJO")    
                        if IsControlJustPressed(0,47) then	
                            TriggerServerEvent('crz_lavanderia:depositarDSujo', maq)
                        end
                    end
                end
                while v.state == 3 do
                    Wait(0)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z,true) <= 1.5 then
                        DrawText3Ds(v.x,v.y,v.z,"PRESSIONE ~g~G~w~ PARA ATIVAR MÁQUINA")    
                        if IsControlJustPressed(0,47) then	
                            if DoesObjectOfTypeExistAtCoords(v.x,v.y,v.z,0.9,GetHashKey(v.propAberto),true) then
                                local nome = "prop_"..v.id
                                nome = GetClosestObjectOfType(v.x,v.y,v.z,0.9,GetHashKey(v.propAberto),false,false,false)
                                SetEntityAsMissionEntity(nome,true,true)
                                DeleteObject(nome)
                                v.state = 4 
                                local nivel2 = "prop_"..v.id
                                nivel2 = CreateObject(GetHashKey(v.propFechado), v.x,v.y,v.z, true, true, true)
                                SetEntityAsMissionEntity(nivel2,true,true)
                                PlaceObjectOnGroundProperly(nivel2)
                                SetEntityHeading(nivel2,v.h)
                                FreezeEntityPosition(nivel2,true)
                            end
                        end
                    end
                end
                while v.state == 4 do
                    Wait(0)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z,true) <= 1.5 then
                        DrawText3Ds(v.x,v.y,v.z,"AGUARDE A LAVAGEM DO SEU DINHEIRO.")   
                    end
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z,true) <= 1.5 and not entrou then
                        entrou = true
                        TriggerEvent('crz_lavanderia:TESTE', maq)
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent('crz_lavanderia:TESTE')
AddEventHandler('crz_lavanderia:TESTE', function(maq) 
    for k,v in pairs(maquinas) do
        if v.id == maq then
            Citizen.Wait(20*1000)
            v.state = 5
            Citizen.CreateThread(function()
                while v.state == 5 do
                    Wait(0)
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z,true) <= 1.5 then
                        DrawText3Ds(v.x,v.y,v.z,"PRESSIONE ~r~G~w~ PARA RECOLHER SEU DINHEIRO..")
                    end
                    if IsControlJustPressed(0,47) then
                        TriggerServerEvent('crz_lavanderia:enviarQuantia', v.value)
                        if DoesObjectOfTypeExistAtCoords(v.x,v.y,v.z,0.9,GetHashKey(v.propFechado),true) then
                            local nome = "prop_"..v.id
                            nome = GetClosestObjectOfType(v.x,v.y,v.z,0.9,GetHashKey(v.propFechado),false,false,false)
                            SetEntityAsMissionEntity(nome,true,true)
                            DeleteObject(nome)
                            v.state = 0
                            entrou = false
                        end
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent('crz_lavanderia:criarMaquinas')
AddEventHandler('crz_lavanderia:criarMaquinas', function(maq) 
    for k,v in pairs(maquinas) do
        if v.id == maq then
            local nivel1 = "prop_"..v.id
            nivel1 = CreateObject(GetHashKey(v.propAberto), v.x,v.y,v.z, true, true, true)
            PlaceObjectOnGroundProperly(nivel1)
            SetEntityHeading(nivel1,v.h)
            FreezeEntityPosition(nivel1,true)
            SetEntityAsMissionEntity(nivel1,true,true)
            -- state 1
            v.state = 1
            Citizen.Wait(2*1000)
            v.state = 2
            TriggerEvent('crz_lavanderia:statuses', maq)
        end
    end
end)

RegisterNetEvent('crz_lavanderia:coloqueiDinheiro')
AddEventHandler('crz_lavanderia:coloqueiDinheiro', function(maq, quantidade) 
    for k,v in pairs(maquinas) do
        if v.id == maq then
            v.value = quantidade
            v.state = 3
            TriggerEvent('crz_lavanderia:statuses', maq)
        end
    end
end)

RegisterNetEvent('crz_lavanderia:teleportar')
AddEventHandler('crz_lavanderia:teleportar', function() 
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
    local ped = PlayerPedId()
    SetEntityCoords(ped,1138.10,-3198.80,-39.66+1)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end)
RegisterNetEvent('crz_lavanderia:saida')
AddEventHandler('crz_lavanderia:saida', function() 
	DoScreenFadeOut(1000)
	Citizen.Wait(1500)
    local ped = PlayerPedId()
    SetEntityCoords(ped,1059.95,-2407.19,29.97+1)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
