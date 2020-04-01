local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


local webhookLink = "https://discordapp.com/api/webhooks/670247764919189504/UD3Rj9xqa76sJVAjWACCmDg8bGojZqE1xb2nV70uRIaRW361Yt90ydh_u11LTvypoNYc"

RegisterServerEvent('FRP:BUTCHER:addmoneyskin')
AddEventHandler( 'FRP:BUTCHER:addmoneyskin', function (carried)
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()
	local amount = math.random(1, 2)
	local name = Character:getName()
	local Inventory = User:getCharacter():getInventory()

	User:notify("Você entregou o animal "..carried.." e recebeu "..amount)
	Inventory:addItem('generic_money', tonumber(amount))
	--sendToDiscord("Acougue Log", name.." entregou para o açougue o animal "..carried.." e recebeu "..amount/100, 17411680)

end)


RegisterServerEvent('FRP:BUTCHER:addmoney')
AddEventHandler( 'FRP:BUTCHER:addmoney', function (amount, carried)
	local price = amount
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()
	local _amount = amount	
	local name = Character:getName()

	local Inventory = User:getCharacter():getInventory()
	print(price)
	Inventory:addItem('generic_money', price)
	
	User:notify("Você entregou o animal "..carried.." e recebeu "..price/100)
	--sendToDiscord("Acougue Log", name.." entregou para o açougue o animal "..carried.." e recebeu "..price/100, 17411680)

end)

-- function sendToDiscord(name, message, color)
--     local connect = {
--           {
--               ["color"] = color,
--               ["title"] = "**".. name .."**",
--               ["description"] = message,
--               ["footer"] = {
--                   ["text"] = "Criado por Crazy",
--               },
--           }
--       }
--     PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = 'Mortes', embeds = connect, avatar_url = ''}), { ['Content-Type'] = 'application/json' })
--   end