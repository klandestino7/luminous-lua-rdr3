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

RegisterNetEvent('VP:ADMIN:outift')
AddEventHandler('VP:ADMIN:outift', function(kek) 
    SetPedOutfitPreset(PlayerPedId(), kek)
end)

Citizen.CreateThread(function()
	SetMinimapHideFow(true)
	ActivateInteriorEntitySet(GetInteriorAtCoords(2534.19, -1313.42, 48.57), "new_theater_int_curtainBlocker", 0)
	-- DeactivateInteriorEntitySet(GetInteriorAtCoords(2534.19, -1313.42, 48.57), "new_theater_int_curtainBlocker", 1)
end)