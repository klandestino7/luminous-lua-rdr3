keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
	['G'] = 0x5415BE48,
	['E'] = 0xDFF812F9,
	["ALT"] = 0xE8342FF2
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)		
				local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
			for k,v in pairs(Config.Coords) do
					if Vdist(coords, v) < 2 then
						DrawTxt(Config.Shoptext, 0.85, 0.95, 0.35, 0.35, true, 255, 255, 255, 200, true, 10000)
						if IsControlJustReleased(0, keys['ALT']) then					
							  TriggerServerEvent("VP:STORECLOTHES:checkmoney")
						end
					end
			end
	end
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end
