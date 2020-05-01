RegisterNetEvent("VP:ADMIN:SpawnPed")
AddEventHandler(
	"VP:ADMIN:SpawnPed",
	function(pedModel)
		local pedModelHash = GetHashKey(pedModel)
		if not IsModelValid(pedModelHash) then
			print("model is not valid")
			return
		end

		if not HasModelLoaded(pedModelHash) then
			RequestModel(pedModelHash)
			while not HasModelLoaded(pedModelHash) do
				Citizen.Wait(10)
			end
		end

		local ped = CreatePed(pedModelHash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
		-- Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, ped)
		SetModelAsNoLongerNeeded(pedModelHash)
	end
)

RegisterCommand(
	"weapon",
	function(source, args)
		local modelw = args[1]
		if modelw == nil then
			print("Please set the specific name for weapon")
		else
			local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
			Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey(modelw), 500, true, 0)
		end
	end
)

RegisterNetEvent("VP:ADMIN:outift")
AddEventHandler(
	"VP:ADMIN:outift",
	function(kek)
		SetPedOutfitPreset(PlayerPedId(), kek)
	end
)

Citizen.CreateThread(
	function()
		SetMinimapHideFow(true)
		ActivateInteriorEntitySet(GetInteriorAtCoords(2534.19, -1313.42, 48.57), "new_theater_int_curtainBlocker", 0)
		-- DeactivateInteriorEntitySet(GetInteriorAtCoords(2534.19, -1313.42, 48.57), "new_theater_int_curtainBlocker", 1)
	end
)

RegisterCommand(
	"teste",
	function(source, args)
		-- local model = "p_bucket03x"

		-- RequestModel("p_shotglass01x")
		-- RequestModel("p_bottlejd01x")

		-- Citizen.Wait(100)

		-- local fVar5 = Citizen.InvokeNative(_0xB93EA7184BAA85C3, 0.0, 1)
		-- local uLocal_42 = CreateScenarioAtPoint(-1208105393, GetObjectOffsetFromCoords(Citizen.InvokeNative(0xA8452DD321607029, 0.0, 1)), fVar5, 0.235327, 1.850775, 0, (fVar5 - 180.0), 0, 0, 0)
		-- Citizen.InvokeNative(0xD3A0DA8F91612C6E, uLocal_42, (fVar5 - 180.0), 1)
		-- Citizen.InvokeNative(0xA7479FB665361EDB, uLocal_42, 0)
		-- Citizen.InvokeNative(0xE69FDA40AAC3EFC0, uLocal_42, 0)

		-- -- local  = GetEntityCoords(PlayerPedId()) + (GetEntityForwardVector(PlayerPedId()) * 0.7)
		-- local iLocal_53 = CreateObject("p_shotglass01x", Citizen.InvokeNative(0xA8452DD321607029, 1), true, true, false, false, true)
		-- if (Citizen.InvokeNative(_0x3BBDD6143FF16F98, PlayerPedId(), iLocal_53, "p_bottleBeer01x_PH_R_HAND", "WORLD_HUMAN_BARCUSTOMER_BEER", "WORLD_HUMAN_BARCUSTOMER_HAS_BEER_MALE_A", 1)) then
		-- end

		-- Citizen.InvokeNative(0xD65FDC686A031C83, PlayerPedId(), 1999132356, 3.0)
		-- Citizen.InvokeNative(0x6D07B371E9439019, PlayerPedId())

		RequestAnimDict("MECH_RANSACK@SHELF@FALLBACK@LH@105CM@PICKUP")

		TaskPlayAnim(PlayerPedId(), "MECH_RANSACK@SHELF@FALLBACK@LH@105CM@PICKUP", "enter_lf", 4.0, -2.0, -1, 24, 0, 0, 0, 0, 0, 0)
	end
)

RegisterNetEvent("VP:ADMIN:CreateVehicle")
AddEventHandler(
	"VP:ADMIN:CreateVehicle",
	function(vModel)
		local veh = GetHashKey(Vmodel)
		local ply = GetPlayerPed()
		local coords = GetEntityCoords(ply)
		local head = GetEntityHeading(ply)
		Citizen.CreateThread(
			function()
				RequestModel(veh)
				while not HasModelLoaded(veh) do
					Wait(1000)
					print("Loading Model: " .. Vmodel .. "Loading Hash: " .. veh)
				end
				if HasModelLoaded(veh) then
					local car = CreateVehicle(veh, coords.x - 2, coords.y, coords.z, head, true, true, false, true)
					print("Model spawned Succes: " .. Vmodel)
				end
			end
		)
	end
)
