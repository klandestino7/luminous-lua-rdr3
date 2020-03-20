local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


local webhookLink = "https://discordapp.com/api/webhooks/670247764919189504/UD3Rj9xqa76sJVAjWACCmDg8bGojZqE1xb2nV70uRIaRW361Yt90ydh_u11LTvypoNYc"

RegisterServerEvent('fc_acougue:addmoneyskin')
AddEventHandler( 'fc_acougue:addmoneyskin', function (carried)
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()
	local amount = math.random(1, 2)
	local name = Character:getName()
	local Inventory = User:getCharacter():getInventory()

	User:notify("Você entregou o animal "..carried.." e recebeu "..amount)
	Inventory:addItem('generic_money', tonumber(amount))
	sendToDiscord("Acougue Log", name.." entregou para o açougue o animal "..carried.." e recebeu "..amount, 17411680)

end)


RegisterServerEvent('fc_acougue:addmoney')
AddEventHandler( 'fc_acougue:addmoney', function (amount, carried)
	local _source = source
	local User = API.getUserFromSource(source)
	local Character = User:getCharacter()
	local _amount = amount	
	local name = Character:getName()
	local Inventory = User:getCharacter():getInventory()
	
	Inventory:addItem('generic_money', tonumber(amount))
	
	User:notify("Você entregou o animal "..carried.." e recebeu "..amount)
	sendToDiscord("Acougue Log", name.." entregou para o açougue o animal "..carried.." e recebeu "..amount, 17411680)

end)

function sendToDiscord(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "Criado por Crazy",
              },
          }
      }
    PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = 'Mortes', embeds = connect, avatar_url = ''}), { ['Content-Type'] = 'application/json' })
  end