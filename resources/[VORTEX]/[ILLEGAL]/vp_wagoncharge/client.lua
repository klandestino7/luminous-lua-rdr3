local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local blip 
local Banditos = {}
local wagon
local FinishedSpawn = false

local CoordsInitial = vector3(0,0,0)
local CoordsDestiny = vector3(0,0,0)

local FinishedDelivery = false

RegisterNetEvent('VP:WAGONCHARGE:StartNotify')
AddEventHandler('VP:WAGONCHARGE:StartNotify', function(x,y,z)	
	Wait(3000)               
	TriggerEvent('VP:NOTIFY:Simple', 'Há uma carroça de contrabando sendo transportada, intercepte-á e entregue no destino.', 10000)
	-- iniciar blip aqui!
end)

RegisterNetEvent("VP:WAGONCHARGE:StartMission")
AddEventHandler(
    "VP:WAGONCHARGE:StartMission",
	function(CoordsSpawn, Destiny)		
		CoordsInitial = CoordsSpawn

		CoordsDestiny = Destiny
		
		Banditos = {}

		TriggerEvent('VP:WAGONCHARGE:createWagon')
		Wait(1000)
		TriggerEvent('VP:WAGONCHARGE:spawnped')
		Wait(3000)
		SetPedsOnWagon()
    end
)

RegisterNetEvent('VP:WAGONCHARGE:spawnped')
AddEventHandler('VP:WAGONCHARGE:spawnped', function()

	--local x,y,z = GetEntityCoords(PlayerPedId())
	local pedModelHash = GetHashKey("G_M_M_UniBanditos_01")

	local FinishedDelivery = false
	
	if not HasModelLoaded(pedModelHash) then
		RequestModel(pedModelHash)
		while not HasModelLoaded(pedModelHash) do
			Citizen.Wait(10)
		end
	end

	for i = 1, 5 do
		local ped = CreatePed(pedModelHash, CoordsInitial.x+math.random(2,8), CoordsInitial.y+math.random(2,8), CoordsInitial.z, GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
	--	Citizen.InvokeNative(0xE054346CA3A0F315, ped, x, y, z, 10, 0, 0)
	--	ClearPedSecondaryTask(ped)
		SetEntityAsMissionEntity(ped, true, true)
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
		SetPedCombatRange(ped, 10)

		

		table.insert(Banditos, ped)	
	end
end)

RegisterNetEvent('VP:WAGONCHARGE:createWagon')
AddEventHandler('VP:WAGONCHARGE:createWagon', function()
	local veh = GetHashKey("STAGECOACH004X")

	Citizen.CreateThread(
		function()
			RequestModel(veh)
			while not HasModelLoaded(veh) do
				Wait(1000)                    
			end
			if HasModelLoaded(veh) then
				wagon = CreateVehicle(veh, CoordsInitial.x,CoordsInitial.y,CoordsInitial.z, 114.59, false, true, false, true)
				if not cAPI.hasGroupOrInheritance('trooper') or not cAPI.hasGroupOrInheritance('sheriff') then
					blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, 1664425300, wagon) -- BLIPADDFORENTITY
					SetBlipSprite(blip, -1546805641, 1)
					SetBlipScale(blip, 0.1)
					Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Contrabando de Armas")
				end
			end
		end
	)
end)

function SetPedsOnWagon()
	for i = 1, 5 do
		if i == 1 then
			ClearPedSecondaryTask(Banditos[1])
			TaskSetBlockingOfNonTemporaryEvents(Banditos[1], 1)
			SetPedIntoVehicle(Banditos[1], wagon, -1)   
		--TaskEnterVehicle(Banditos[1], wagon, 8, -1, 2, 1, 0)
			TaskVehicleDriveToCoord(Banditos[1], GetVehiclePedIsIn(Banditos[1], false), CoordsDestiny.x,CoordsDestiny.y,CoordsDestiny.z, 20.0, 1.0, GetEntityModel(GetVehiclePedIsIn(Banditos[1])), 67633207, 7.0, false)
			Citizen.InvokeNative(0x7BF835BB9E2698C8, Banditos[1], 20, 0, 16)
		elseif i == 2 then
			print(Banditos[2])					
			SetPedIntoVehicle(Banditos[2], wagon, 0)   			
			Citizen.InvokeNative(0x7BF835BB9E2698C8, Banditos[2], 20, 0, 16)	
		elseif i == 3 then
			print(Banditos[3])						
			SetPedIntoVehicle(Banditos[3], wagon, 6)   		
			Citizen.InvokeNative(0x7BF835BB9E2698C8, Banditos[3], 20, 0, 16)	
		elseif i == 4 then
			print(Banditos[4])
			SetPedIntoVehicle(Banditos[4], wagon, 7)	
			Citizen.InvokeNative(0x7BF835BB9E2698C8, Banditos[4], 20, 0, 16)
		elseif i == 5 then
			print(Banditos[5])
			SetPedIntoVehicle(Banditos[5], wagon, 8) 		
			Citizen.InvokeNative(0x7BF835BB9E2698C8, Banditos[5], 20, 0, 16)		
		end
	end
end

Citizen.CreateThread(
	function()
	while true do		
		Citizen.Wait(1)
		SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), -1663301869)
		SetRelationshipBetweenGroups(5, -1663301869, GetHashKey('PLAYER'))
	end
end)

Citizen.CreateThread(
function()
	while true do
		Citizen.Wait(0)
		local VehiclePed, retval = GetVehiclePedIsIn(PlayerPedId(), false)
		if VehiclePed == wagon then	
			if not MultiRoute then
				--local x,y,z = GetEntityCoords(wagon)
				SetCoordsMultiRoute(CoordsDestiny)
				TriggerEvent('VP:NOTIFY:Simple', 'Entregue a carroça no destino.', 10000)
			end
			MultiRoute = true
		else
			MultiRoute = false
			ClearGpsMultiRoute()
		end
	end
end
)

Citizen.CreateThread(
    function()
        while true do
			Wait(10)
			
			local wagonCoords = GetEntityCoords(wagon)
			local dst = #(CoordsDestiny - wagonCoords)

			local PlayerCoords = GetEntityCoords(PlayerPedId())
			local PlayerIsClosed = #(wagonCoords - PlayerCoords)

			local VehiclePlayer, retval = GetVehiclePedIsIn(PlayerPedId(), false)
			if VehiclePlayer == wagon then
				if dst < 7 then
					if not FinishedDelivery then		
						TaskEveryoneLeaveVehicleInOrder(wagon, 1)
						SetVehicleUndriveable(wagon, 1)
						BringVehicleToHalt(wagon, 7, 8, 1)
						FinishedDelivery = true
					end					
				end
			end
			if FinishedDelivery then
				if PlayerIsClosed > 50 then
					DeleteVehicle(wagon)
					for i = 1, 5 do
						DeleteEntity(Banditos[i])
					end
				end	
			end
        end
	end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(10)
			local wagonCoords = GetEntityCoords(wagon)
			local dst = #(CoordsDestiny - wagonCoords)		
			
			local PlayerCoords = GetEntityCoords(PlayerPedId())
			local PlayerIsClosed = #(wagonCoords - PlayerCoords)

			local VehiclePed, retval = GetVehiclePedIsIn(Banditos[1], false)			
			if VehiclePed == wagon then
				if dst < 10 then
					-- for i = 1, 5 do
					-- 	TaskLeaveVehicle(Banditos[i], wagon, 0, 0)						
					-- end
					TaskEveryoneLeaveVehicleInOrder(wagon, 1)
					if not FinishedDelivery then
						SetVehicleUndriveable(wagon)
						FinishedDelivery = true			
					end					
					Wait(2000)
					if PlayerIsClosed > 50 then
						DeleteVehicle(wagon)
						for i = 1, 5 do
							DeleteEntity(Banditos[i])
						end
					end				
				end
			end
        end
	end
)

function SetCoordsMultiRoute(Coords)
	StartGpsMultiRoute(76603059, true, true)
	--StartGpsMultiRoute(76603059, true, true)					-- Add the points
	AddPointToGpsMultiRoute(Coords)
	SetGpsMultiRouteRender(true)
end

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