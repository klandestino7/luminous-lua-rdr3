Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(659073366908731412)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo')
        
        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Faroeste Roleplay')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('verify')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('RedM Roleplay')

        --It updates every one minute just in case.
		Citizen.Wait(60000)  
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		players = {}
		
		for i = 0, 256 do
			if NetworkIsPlayerActive( i ) then
				
			end
		end

		for _, player in ipairs(GetActivePlayers()) do
			local ped = GetPlayerPed(player)
				
	      		table.insert(players, player)

    	end

		SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #players .. "/256")
	end
end)