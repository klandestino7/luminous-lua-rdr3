local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")
local FirstSpawn = false
local car = nil
local ped = nil
local coords = vector3(-746.465,-1294.942,43.244)

RegisterCommand('first', function()
    TriggerEvent('VP:CREATOR:FirstSpawn')
end)

RegisterCommand('goped', function()
   -- TriggerMusicEvent("REDLP_START")
  --  TriggerMusicEvent("REHR_START") -- MELHOR
  TriggerMusicEvent("REHR_START")
end)
RegisterCommand('first2', function()
    TriggerMusicEvent("MC_MUSIC_STOP")
end)


RegisterNetEvent("VP:CREATOR:FirstSpawn")
AddEventHandler(
    "VP:CREATOR:FirstSpawn",
    function()
        if not FirstSpawn then
            FirstSpawn = true
            TriggerMusicEvent("REHR_START")
            NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
            SetEntityInvincible(PlayerPedId(), true)  
            Wait(100)
            SetEntityCoords(PlayerPedId(), -1099.470,-1839.129,60.327)
            Wait(2500)
            TriggerEvent('VP:CREATOR:CreateVehicle', 'STAGECOACH001X')
            Wait(1000)
            TriggerEvent('VP:CREATOR:CreatePedOnVehicle', 'CS_BivCoachDriver')
            Wait(3000)
            SetPedIntoVehicle(PlayerPedId(), car, 1)
            Wait(2000)    
            cAPI.EndFade(500)
            TriggerEvent('VP:CREATOR:StartNotify')
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(10)
            if FirstSpawn then	
                local pcoords = GetEntityCoords(PlayerPedId())                
                local dst = #(coords - pcoords)	   
                if dst < 5 then
                    print('maoi')
                    RemovePedFromGroup(ped, GetPedGroupIndex(PlayerPedId()))
                    Wait(100)
                    DisableAllControlActions(0)                  
                    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                    SetEntityInvincible(PlayerPedId(), false)  
                    SetCinematicModeActive(0)
                    FirstSpawn = false
                    N_0x69d65e89ffd72313(false)    
                    Wait(2000)
                    TaskLeaveVehicle(PlayerPedId(), car, 0, 0) 
                    Wait(3000)      
                    TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), -848.584,-1252.746,43.559, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
                    TriggerEvent('VP:NOTIFY:Simple', 'Você perdeu todas as suas roupas, tem uma loja de roupa do outro lado da rua, que ~pa~tal ir lá se trocar?')
                    TriggerMusicEvent("MC_MUSIC_STOP")                    
                    Wait(10000)
                    TriggerEvent('VP:NOTIFY:Simple', 'Digite /guiainiciante ver o ~pa~Jornal Guia de Iniciante.')
                    DeleteVehicle(car)
                    DeleteEntity(ped)
                else               
                    N_0x69d65e89ffd72313(true)
                    SetCinematicModeActive(1)
                    DisableAllControlActions(1)
                end 
            end	
        end
    end
)

RegisterNetEvent("VP:CREATOR:CreateVehicle")
AddEventHandler(
	"VP:CREATOR:CreateVehicle",
	function(vModel)
		local veh = GetHashKey(vModel)
		local ply = GetPlayerPed()
		local coords = GetEntityCoords(ply)
		Citizen.CreateThread(
			function()
				RequestModel(veh)
				while not HasModelLoaded(veh) do
                    Wait(1000)                    
				end
				if HasModelLoaded(veh) then
                    car = CreateVehicle(veh, coords, 264.0, true, true, false, true)
                  --  SetEntityCollision(car, true, true)
				end
			end
		)
	end
)

RegisterNetEvent("VP:CREATOR:StartNotify")
AddEventHandler(
	"VP:CREATOR:StartNotify",
    function()
    Wait(5000)
	TriggerEvent('VP:NOTIFY:Simple', 'Saudações, caubói. Seja muito bem-vindo ao  ~o~Faroeste Roleplay~q~, sinta-se livre para explorar as mais variadas regiões e descobrir os mistérios que esse novo mundo lhe aguarda. ')
    Wait(15000)
    TriggerEvent('VP:NOTIFY:Simple', 'Leia o ~o~mural de regras~q~ para ficar por dentro de tudo o que é permitido no servidor, e para que assim evite dúvidas ou problemas futuros. ')
    Wait(15000)
    TriggerEvent('VP:NOTIFY:Simple', 'Tome cuidado ao andejar pelo anoitecer no faroeste, somente os verdadeiramente aventureiros ficam depois do escurecer... dizem que é um mundo totalmente diferente sob a luz da Lua.')
    Wait(15000)
    TriggerEvent('VP:NOTIFY:Simple', 'Aqui é Blackwater, a primeira cidade na qual você vai conhecer. Nela você poderá encontrar diversas lojas de departamento, como a ~v~loja de roupas~v~, ~v~cabeleireiro~v~, ~v~departamento de polícia~v~, entre outros. Mas lembre-se de que há um mundo imenso para você explorar!')
end)

RegisterNetEvent("VP:CREATOR:CreatePedOnVehicle")
AddEventHandler(
    "VP:CREATOR:CreatePedOnVehicle",    
    function(pedModel)
        
        local pedModelHash = GetHashKey(pedModel)
		if not IsModelValid(pedModelHash) then
			return
		end

		if not HasModelLoaded(pedModelHash) then
			RequestModel(pedModelHash)
			while not HasModelLoaded(pedModelHash) do
				Citizen.Wait(10)
			end
        end

		ped = CreatePed(pedModelHash, coords, GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
        SetEntityAsMissionEntity(ped)
        SetModelAsNoLongerNeeded(pedModelHash)
        SetPedAsGroupMember(ped, GetPedGroupIndex(PlayerPedId()))
        SetPedIntoVehicle(ped, car, -1)   
        TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), -746.465,-1294.942,43.244, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
        print(GetPedGroupIndex(ped), GetPedGroupIndex(ped))
	end
)

