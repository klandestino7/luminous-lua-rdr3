local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- local salario = {
-- 	{"police", "0", 10},
-- 	{"user", "0", 10},
-- 	{"medic", "0", 10}
-- }

local xp = {
	{"admin", 1},
	{"user", 1},
	{"vip1", 1.10},
	{"vip2", 1.20},
	{"vip3", 1.30}
}

local perdaxp = {
	{"admin", 20},
	{"user", 20},
	{"vip1", 20 * 1.10},
	{"vip2", 20 * 1.20},
	{"vip3", 20 * 1.30}
}

-- RegisterServerEvent("VP:SYSTEMPAY:money")
-- AddEventHandler(
-- 	"VP:SYSTEMPAY:money",
-- 	function()
-- 		local _source = source
-- 		local User = API.getUserFromSource(_source)
-- 		local Character = User:getCharacter()

-- 		if Character == nil then
-- 			return
-- 		end

-- 		local Inventory = User:getCharacter():getInventory()
-- 		local call = json.decode(Character:getData(Character:getId(), "charTable", "banco"))

-- 		for i, v in pairs(salario) do
-- 			local job = Character:hasGroup(v[1])
-- 			if job then
-- 				Character:setData(Character:getId(), "charTable", "banco", tonumber(call + (v[3] * 100)))
-- 				TriggerClientEvent("chatMessage", _source, "SALARIO", {65, 255, 135}, "Sua recompensa de ^1$" .. v[3] .. " ^0 foi depositada no banco.")
-- 			end
-- 		end
-- 	end
-- )

RegisterServerEvent("VP:SYSTEMPAY:xp")
AddEventHandler(
	"VP:SYSTEMPAY:xp",
	function(count)
		local countxp = count
		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()

		if Character ~= nil then
			for i, v in pairs(xp) do
				local group = Character:hasGroup(v[1])
				if group then
					Character:varyExp(tonumber(countxp * v[2]))
				end
			end
			print("XP Distribuido com Sucesso.")
		end
	end
)

-- RegisterServerEvent("VP:SYSTEMPAY:removedeath")
-- AddEventHandler(
-- 	"VP:SYSTEMPAY:removedeath",
-- 	function(source)
-- 		local _source = source
-- 		local countxp = count

-- 		local User = API.getUserFromSource(_source)
-- 		local Character = User:getCharacter()
-- 		local xp = Character:getExp()

-- 		if Character:hasGroup("vip3") then
-- 			Character:varyExp(-(xp * 0.05))
-- 		elseif Character:hasGroup("vip2") then
-- 			Character:varyExp(-(xp * 0.10))
-- 		elseif Character:hasGroup("vip1") then
-- 			Character:varyExp(-(xp * 0.15))
-- 		elseif Character:hasGroup("admin") then
-- 			Character:varyExp(-(xp * 0.20))
-- 		elseif Character:hasGroup("user") then
-- 			Character:varyExp(-(xp * 0.20))
-- 		end
-- 	end
-- )

local r = {
	["trooper"] = 3000,
	["sheriff"] = 4500,
	["medic"] = 2500
}

local withHoldingPaymentToUsers = {}

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000 * 60 * 60)

			for group, payment in pairs(r) do
				for _, User in pairs(API.getUsersByGroup(group, false)) do
					local Character = User:getCharacter()

					local user_id = User:getId()

					if Character ~= nil then
						local Inventory = Character:getInventory()

						if Inventory:addItem("money", payment) then
							User:notify("alert", "Você acabou de receber o seu salário. Aproveite!")
						else
							if withHoldingPaymentToUsers[user_id] then
								payment = payment + withHoldingPaymentToUsers[user_id]
							end
							withHoldingPaymentToUsers[user_id] = payment
						end
					else
						if withHoldingPaymentToUsers[user_id] then
							payment = payment + withHoldingPaymentToUsers[user_id]
						end
						withHoldingPaymentToUsers[user_id] = payment
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000 * 60 * 1)

			for user_id, totalpayment in pairs(withHoldingPaymentToUsers) do
				local User = API.getUserFromId(user_id)
				if User ~= nil then
					local Character = User:getCharacter()
					if Character ~= nil then
						local Inventory = Character:getInventory()
						if Inventory:addItem("money", totalpayment) then
							User:notify("alert", "Você acabou de receber o seu salário. Aproveite!")
							withHoldingPaymentToUsers[user_id] = nil
						else
							User:notify("error", "Sem espaço na Bolsa para receber salário!")
						end
					end
				end
			end
		end
	end
)
