
Citizen.CreateThread(
	function()
		WarMenu.CreateMenu('horses', 'Estabulo')
        WarMenu.SetSubTitle('horses', 'Selecione uma Opção')
        WarMenu.CreateSubMenu('category_shop', 'horses', 'Comprar Cavalo')
		WarMenu.CreateSubMenu('horse_shop', 'horses', 'Comprar Cavalo')
		WarMenu.CreateSubMenu('my_horses', 'horses', 'Meus Cavalos')
		while true do
			if WarMenu.IsMenuOpened('horses') then
				WarMenu.MenuButton('Comprar Cavalo', 'category_shop')

				if WarMenu.MenuButton('Meus Cavalos', 'my_horses') then
					TriggerServerEvent('FCRP:HORSESHOP:AskForMyHorses')
				end

				if WarMenu.IsMenuAboutToBeClosed() then
					if DoesEntityExist(tempHorse) then
						DeleteVehicle(tempHorse)
						if DoesEntityExist(tempHorse) then
							DeletePed(tempHorse)
						end
					end
				end

				WarMenu.Display()
            end
            
            if WarMenu.IsMenuOpened('category_shop') then
				for _, horseData in pairs(buyableHorses) do					
                        WarMenu.MenuButton(horseData['Text'], 'horse_shop')
                         
				end
				WarMenu.Display()
            end
            
			if WarMenu.IsMenuOpened('horse_shop') then
				
                for typeTable, vhor in pairs(buyableHorses) do     
					for index, horseData in pairs(vhor) do

					end   				   
				
					if typeTable == "Riding" then
						for index, horseData in pairs(vhor) do
							print(json.encode(horseData[1]))
							--WarMenu.Button(horseData['Text'], '~pa~$' .. horseData['priceMoney'])
						end										
					end
				end    
				WarMenu.Display()
			end

			-- if WarMenu.IsMenuOpened('horse_shop') then
			-- 	for _, horseData in pairs(buyableHorses) do
			-- 		if not IsControlPressed(2, 0) then
			-- 			if WarMenu.Button(horseData['Text'], '~pa~$' .. horseData['priceMoney']) then
			-- 				tryToBuyHorse(horseData['Model'], false)
			-- 			end
			-- 		else
			-- 			if WarMenu.Button(horseData['Text'], '~g~' .. horseData['priceGold'] .. ' ouros') then
			-- 				tryToBuyHorse(horseData['Model'], false)
			-- 			end
			-- 		end
			-- 	end
			-- 	WarMenu.Display()
			-- end
			if WarMenu.IsMenuOpened('my_horses') then
				for _, horseData in pairs(myHorses) do
				--	print(json.encode(horseData))
					if WarMenu.Button(horseData.name .. ' ' .. horseData.model .. ' ' or 'false') then	
								
						TriggerServerEvent('FCRP:HORSESHOP:SelectHorseWithId', horseData.id)
					end
				end

				WarMenu.Display()
			end

			Citizen.Wait(0)
		end
	end
)