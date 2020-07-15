local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local blip 
local Banditos = {}
local wagon
local FinishedSpawn = false

RegisterNetEvent('VP:WAGONCHARGE:StartNotify')
AddEventHandler('VP:WAGONCHARGE:StartNotify', function(x,y,z)
	TriggerEvent('VP:NOTIFY:Simple', 'Há uma carroça de contrabando sendo transportada, intercepte-á e entregue no destino.', 10000)
	-- iniciar blip aqui!
end)


-- RegisterCommand('testeWagon', function()
-- 	local x,y,z = GetEntityCoords(PlayerPedId())
-- 	print(x,y,z)
--   	TriggerEvent('VP:WAGONCHARGE:StartMission', x,y,z)
-- end)


RegisterNetEvent("VP:WAGONCHARGE:StartMission")
AddEventHandler(
    "VP:WAGONCHARGE:StartMission",
	function(x,y,z)		
		Banditos = {}
		TriggerEvent('VP:WAGONCHARGE:createWagon', x,y,z)
		Wait(1000)
		TriggerEvent('VP:WAGONCHARGE:spawnped', x,y,z)
		Wait(2000)               
		TriggerEvent('VP:WAGONCHARGE:StartNotify', x,y,z)
		SetPedsOnWagon()
    end
)


RegisterNetEvent('VP:WAGONCHARGE:spawnped')
AddEventHandler('VP:WAGONCHARGE:spawnped', function(x,y,z)
	local x,y,z = GetEntityCoords(PlayerPedId())
	local pedModelHash = GetHashKey("G_M_M_UniBanditos_01")
	
	if not HasModelLoaded(pedModelHash) then
		RequestModel(pedModelHash)
		while not HasModelLoaded(pedModelHash) do
			Citizen.Wait(10)
		end
	end

	for i = 1, 5 do
		local ped = CreatePed(pedModelHash, x+math.random(1,8), y, z, GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
	--	Citizen.InvokeNative(0xE054346CA3A0F315, ped, x, y, z, 10, 0, 0)
	--	ClearPedSecondaryTask(ped)
		SetEntityAsMissionEntity(ped)
		--SetRelationshipBetweenGroups(5, ped, `PLAYER`)
		ClearPedSecondaryTask(ped)
		SetPedOutfitPreset(ped, math.random(1,8))

		if pedModelHash == "G_M_M_UniBanditos_01" then
			
			SetPedAsGroupMember(ped, -1663301869)
			SetPedRelationshipGroupHash(ped, -1663301869)
	
			local weapons = {
				[1] = {["WEAPON_REPEATER_EVANS"] = 3},
				[2] = {["WEAPON_REVOLVER_SCHOFIELD_CALLOWAY"] = 3},
				[3] = {["WEAPON_RIFLE_SPRINGFIELD"] = 10},
				[4] = {["WEAPON_REVOLVER_LEMAT"]= 3},
				[5] = {["WEAPON_REPEATER_CARBINE"]= 3}
		   }

		   for WeaponHash, Quantity in pairs(weapons[math.random(1,5)]) do
				Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey(WeaponHash), 500, true, 0)
		   end

		end
		 
		SetPedFleeAttributes(ped, 0, 0)
		SetPedCombatAttributes(ped, 46, 1)
		SetPedCombatAbility(ped, 100)
		SetPedCombatMovement(ped, 2)
		SetPedCombatRange(ped, 2)
	--	SetAmbientVoiceName(ped, "ALIENS")
	--	DisablePedPainAudio(ped, true)
	 
		--SetPedIsDrunk(ped, true)
		--RequestAnimSet("move_m@drunk@verydrunk")
		--while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			--Wait(1)
		--end

		Citizen.Trace("Load animation set\n")
		--SetPedMovementClipset(ped, "move_m@drunk@verydrunk", 1.0)	

		TaskCombatHatedTargets(ped , 16)	

		table.insert(Banditos, ped)


	
	end
end)

RegisterNetEvent('VP:WAGONCHARGE:createWagon')
AddEventHandler('VP:WAGONCHARGE:createWagon', function(x,y,z)
	local veh = GetHashKey("STAGECOACH004X")

	Citizen.CreateThread(
		function()
			RequestModel(veh)
			while not HasModelLoaded(veh) do
				Wait(1000)                    
			end
			if HasModelLoaded(veh) then
				wagon = CreateVehicle(veh, x,y,z, 264.0, false, true, false, true)
				
				blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, 1664425300, wagon) -- BLIPADDFORENTITY
				SetBlipSprite(blip, -1546805641, 1)
				SetBlipScale(blip, 0.1)
				Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Contrabando de Armas")
			end
		end
	)
end)

function SetPedsOnWagon()
	for i = 1, 5 do
		if i == 1 then
			print(Banditos[1])
			SetPedIntoVehicle(Banditos[1], wagon, -1)   
			TaskVehicleDriveToCoord(Banditos[1], GetVehiclePedIsIn(Banditos[1], false), 2538.675,-1144.211,50.175, 20.0, 1.0, GetEntityModel(GetVehiclePedIsIn(Banditos[1])), 67633207, 5.0, false)
		elseif i == 2 then
			print(Banditos[2])
			SetPedIntoVehicle(Banditos[2], wagon, 0)   
		elseif i == 3 then
			print(Banditos[3])
			SetPedIntoVehicle(Banditos[3], wagon, 6)   
		elseif i == 4 then
			print(Banditos[4])
			SetPedIntoVehicle(Banditos[4], wagon, 7) 
		elseif i == 5 then
			print(Banditos[5])
			SetPedIntoVehicle(Banditos[5], wagon, 8) 	
		end
	end
end

Citizen.CreateThread(
	function()
	while true do		
		Citizen.Wait(1)
		SetRelationshipBetweenGroups(5, "PLAYER", -1663301869)
		SetRelationshipBetweenGroups(5, -1663301869, "PLAYER")
	end
end)



Citizen.CreateThread(
function()
	while true do
		Citizen.Wait(0)


		-- if wagon == nil then	
		-- 	RemoveBlip(blip)
		-- end


		local VehiclePed, retval = GetVehiclePedIsIn(PlayerPedId(), false)
		if VehiclePed == wagon then	
			print('igual')
			if not MultiRoute then		
				print('multiroute')
				--local x,y,z = GetEntityCoords(wagon)
				SetCoordsMultiRoute(2538.675,-1144.211,50.175)				
			end
			MultiRoute = true
		else
			MultiRoute = false
			ClearGpsMultiRoute()
		end

	end
end
)


function SetCoordsMultiRoute(x,y,z)
	StartGpsMultiRoute(76603059, true, true)
	--StartGpsMultiRoute(76603059, true, true)					-- Add the points
	AddPointToGpsMultiRoute(x, y, z)
	SetGpsMultiRouteRender(true)
	TriggerEvent('VP:ROBREG:ClearGps')
end



Citizen.CreateThread(
    function()
        while true do
            Wait(10)
            if FirstSpawn then	
                local pcoords = GetEntityCoords(PlayerPedId())                
                local dst = #(coords - pcoords)	   
                if dst < 5 then
                    RemovePedFromGroup(ped, GetPedGroupIndex(PlayerPedId()))
                    Wait(100)
                    DisableAllControlActions(0)                  
                    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                    SetEntityInvincible(PlayerPedId(), false)  
                    SetCinematicModeActive(0)                    
                    FirstSpawn = false
                    N_0x69d65e89ffd72313(false)    
                    Wait(1000)
                    TaskLeaveVehicle(PlayerPedId(), car, 0, 0) 
                    Wait(2000)                         
                    TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), 2600.436,-1205.932,53.323, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
                    TriggerEvent('VP:NOTIFY:Simple', 'Você perdeu todas as suas roupas, tem uma loja de roupa do outro lado da rua, que tal ir lá se trocar?', 10000)
                    TriggerMusicEvent("MC_MUSIC_STOP")                    
                    Wait(10000)
                  --  TriggerEvent('VP:NOTIFY:Simple', 'Digite /guiainiciante ver o Jornal Guia de Iniciante.', 10000)
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

RegisterNetEvent('VP:WAGONCHARGE:killblip')
AddEventHandler('VP:WAGONCHARGE:killblip', function()
	RemoveBlip(blip)
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
		local game = NetworkIsGameInProgress()
		if game == 1 then
			TriggerServerEvent('VP:WAGONCHARGE:playerActivated')
			return
		end
    end
end)