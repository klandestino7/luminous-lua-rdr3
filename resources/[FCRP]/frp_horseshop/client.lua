local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

-- local keys = {['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ['ENTER'] = 0xC7B5340A, ['E'] = 0xDFF812F9}

 promptGroup = GetRandomIntInRange(0, 0xffffff)
local prompt

-- local tempHorse

 shops = {
	{
		enteringSpot = {-366.08, 787.01, 116.17},
		horseSpot = {}
	},
	{
		enteringSpot = {-874.02, -1364.78, 43.53},
		horseSpot = {}
	},
	{
		enteringSpot = {-1777.02, -440.15, 154.96},
		horseSpot = {}
	},
	{
		enteringSpot = {2502.5, -1455.33, 46.31},
		horseSpot = {}
	},
	{
		enteringSpot = {2970.73, 1427.97, 44.71},
		horseSpot = {}
	}	
}




 buyableHorses = {
	Riding = {
		['Text'] = 'Riding',
		['Horses'] = {
			[1] = {
				['Text'] = 'Tennesseewalker Chestnut',
				['SubText'] = '',
				['Model'] = 'A_C_HORSE_TENNESSEEWALKER_CHESTNUT',
				priceMoney = 40,
				priceGold = 1
			},
			[2] = {
				['Text'] = 'SHIRE RAVENBLACK' ,
				['SubText'] = '',
				['Model'] = 'A_C_HORSE_SHIRE_RAVENBLACK',
				priceMoney = 60,
				priceGold = 1
			},
			[3] = {
				['Text'] = 'APPALOOSA LEOPARD',
				['SubText'] = '',
				['Model'] = 'A_C_HORSE_APPALOOSA_LEOPARD',
				priceMoney = 100,
				priceGold = 2
			}
		}

	},

	Draft = {
		['Text'] = 'Draft',
	},

	War = {
		['Text'] = 'War',
	},

	Work = {
		['Text'] = 'Work',
	},

	Multi = {
		['Text'] = 'Multi',
	},

	Superior = {
		['Text'] = 'Superior',
	}

	-- [1] = {
	-- 	['Text'] = 'Tennesseewalker Chestnut',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_TENNESSEEWALKER_CHESTNUT',
	-- 	priceMoney = 40,
	-- 	priceGold = 1
	-- },
	-- [2] = {
	-- 	['Text'] = 'SHIRE RAVENBLACK' ,
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_SHIRE_RAVENBLACK',
	-- 	priceMoney = 60,
	-- 	priceGold = 1
	-- },
	-- [3] = {
	-- 	['Text'] = 'APPALOOSA LEOPARD',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_APPALOOSA_LEOPARD',
	-- 	priceMoney = 100,
	-- 	priceGold = 2
	-- },
	-- [4] = {
	-- 	['Text'] = 'Mr Bill W',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_GANG_BILL',
	-- 	priceMoney = 150,
	-- 	priceGold = 10
	-- },
	-- [5] = {
	-- 	['Text'] = 'Kentuckysaddle Black',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_KENTUCKYSADDLE_BLACK',
	-- 	priceMoney = 35,
	-- 	priceGold = 1
	-- },
	-- [6] = {
	-- 	['Text'] = 'THOROUGHBRED BRINDLE',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_THOROUGHBRED_BRINDLE',
	-- 	priceMoney = 150,
	-- 	priceGold = 10
	-- },
	-- [7] = {
	-- 	['Text'] = 'Turcomano',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_TURKOMAN_DARKBAY',
	-- 	priceMoney = 3500,
	-- 	priceGold = 30
	-- },
	-- [8] = {
	-- 	['Text'] = 'Árabe negro',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_ARABIAN_BLACK',
	-- 	priceMoney = 7000,
	-- 	priceGold = 70
	-- },
	-- [9] = {
	-- 	['Text'] = 'Árabe branco',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_ARABIAN_ROSEGREYBAY',
	-- 	priceMoney = 10000,
	-- 	priceGold = 10
	-- },
	-- [10] = {
	-- 	['Text'] = 'MUSTANG GRULLODUN',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_MUSTANG_GRULLODUN',
	-- 	priceMoney = 250,
	-- 	priceGold = 2
	-- },
	-- [11] = {
	-- 	['Text'] = 'MUSTANG WILDBAY',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_MUSTANG_WILDBAY',
	-- 	priceMoney = 250,
	-- 	priceGold = 2
	-- },
	-- [12] = {
	-- 	['Text'] = 'MISSOURI FOX',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_MISSOURIFOXTROTTER_AMBERCHAMPAGNE',
	-- 	priceMoney = 350,
	-- 	priceGold = 3
	-- },
	-- [13] = {
	-- 	['Text'] = 'TURKOMAN GOLD',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_TURKOMAN_GOLD',
	-- 	priceMoney = 3500,
	-- 	priceGold = 35
	-- },
	-- [14] = {
	-- 	['Text'] = 'AMERICANSTANDARDBRED',
	-- 	['SubText'] = '',
	-- 	['Model'] = 'A_C_HORSE_AMERICANSTANDARDBRED_PALOMINODAPPLE',
	-- 	priceMoney = 350,
	-- 	priceGold = 3
	-- }
}

myHorses = {}

function tryToBuyHorse(horseModel, buyWithGold)
	local horseName = cAPI.prompt('Nomeie seu Cavalo:', 'Cavalo')

	if horseName ~= '' then
		TriggerServerEvent('FCRP:HORSESHOP:Buy', horseModel, horseName, buyWithGold)
	end
end

-- function spawnTempHorse(selectedId)
-- 	-- vVar25 = { ENTITY::GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(uParam1->f_167.f_1768, ENTITY::GET_ENTITY_COORDS(uParam0->f_1769, true, false)) };
-- 	-- CAM::POINT_CAM_AT_ENTITY(uParam0->f_4.f_1206, uParam0->f_1768, 0.1336f, vVar25.y, vVar25.z, true);
-- 	-- Horse camera is forward vector * vec3(1, 1, 1)
-- 	tempHorse = CreatePed(selectedHorseHash, horseSpot, false, false)
-- end

function setupHorsePrompt()
	if not PromptIsValid(prompt) then
		prompt = PromptRegisterBegin()
		PromptSetControlAction(prompt, 0xE8342FF2)
		--PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Comprar Cavalo'))
		PromptSetEnabled(prompt, 1)
		PromptSetVisible(prompt, 1)
		PromptSetHoldMode(prompt, 1)

		PromptSetGroup(prompt, promptGroup)
		PromptRegisterEnd(prompt)
	end
end




Citizen.CreateThread(
	function()
		for _, values in pairs(shops) do
			local b = N_0x554d9d53f696d002(-515518185, values[1], values[2], values[3])
			SetBlipScale(b, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, b, 'Estábulo')
			print(json.encode(values.enteringSpot))
		end		
		while true do
			Citizen.Wait(10)

			local ped = PlayerPedId()
			local pCoords = GetEntityCoords(ped)

			for _, values in pairs(shops) do
				
				local x, y, z = table.unpack(values.enteringSpot)
				if #(pCoords - vec3(x, y, z)) <= 5 then
					if IsPedOnMount(ped) then
						PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Guardar Cavalo'))
						local horseGroupName = CreateVarString(10, 'LITERAL_STRING', 'Loja')
						PromptSetActiveGroupThisFrame(promptGroup, horseGroupName)
						if PromptHasHoldModeCompleted(prompt) then
							Citizen.Wait(1000)
							cAPI.fleeHorse()							
						end				
					elseif not WarMenu.IsMenuOpened('horses') then
						PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Comprar Cavalo'))
						local horseGroupName = CreateVarString(10, 'LITERAL_STRING', 'Loja')
						PromptSetActiveGroupThisFrame(promptGroup, horseGroupName)
						if PromptHasHoldModeCompleted(prompt) then
							Citizen.Wait(1000)
							WarMenu.OpenMenu('horses')
						end					
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		setupHorsePrompt()
	end
)

RegisterNetEvent('FCRP:HORSESHOP:ReceiveHorsesData')
AddEventHandler(
	'FCRP:HORSESHOP:ReceiveHorsesData',
	function(data)
		myHorses = data
	end
)


-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
-- 			end		
--         end
--     end
-- )
