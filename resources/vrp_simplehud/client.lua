local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
local month = ""
local dayOfMonth = 0
local proximity = 10.001
local voice = 2
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- DATA E HORA
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "Janeiro"
	elseif month == 1 then
		month = "Fevereiro"
	elseif month == 2 then
		month = "Março"
	elseif month == 3 then
		month = "Abril"
	elseif month == 4 then
		month = "Maio"
	elseif month == 5 then
		month = "Junho"
	elseif month == 6 then
		month = "Julho"
	elseif month == 7 then
		month = "Agosto"
	elseif month == 8 then
		month = "Setembro"
	elseif month == 9 then
		month = "Outubro"
	elseif month == 10 then
		month = "Novembro"
	elseif month == 11 then
		month = "Dezembro"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CSS
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	.div_informacoes {
		bottom: 3%;
		right: 2%;
		position: absolute;
	}
	.voice1 {
		content: url(https://i.imgur.com/qODLlmI.png);
		height: 32px;
		width: 32px;
		float: left;
	}
	.voice2 {
		content: url(https://i.imgur.com/0XjvSVh.png);
		height: 32px;
		width: 32px;
		float: left;
	}
	.voice3 {
		content: url(https://i.imgur.com/WGagrXs.png);
		height: 32px;
		width: 32px;
		float: left;
	}
	.voice4 {
		content: url(https://i.imgur.com/dtLNTOn.png);
		height: 32px;
		width: 32px;
		float: left;
	}
	.texto {
		margin-right: 12px;
		height: 32px;
		font-family: Arial;
		font-size: 13px;
		text-shadow: 1px 1px #000;
		color: rgba(255,255,255,0.5);
		text-align: right;
		line-height: 16px;
		float: left;
	}
	.texto b {
		color: rgba(255,255,255,0.7);
	}
	.div_barraserver {
		content: url(https://i.imgur.com/1sfxI0Q.png);
		top: 0;
		right: 0;
		position: absolute;
		width: 217px;
		height: 169px;
	}
]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned",function()
	NetworkSetTalkerProximity(proximity)
	vRP._setDiv("informacoes",css,"")
end)

function UpdateOverlay()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped,false))
	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
	CalculateTimeToDisplay()
	CalculateDateToDisplay()
	NetworkClearVoiceChannel()
	NetworkSetTalkerProximity(proximity)

	vRP._setDivContent("informacoes","<div class=\"texto\">Hoje é dia "..dayOfMonth.." de "..month.." - "..hour..":"..minute.."<br>Você está na <b>"..street.."</b></div><div class=\"voice"..voice.."\"></div>")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		UpdateOverlay()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()

		if IsControlJustPressed(1,212) and GetEntityHealth(ped) > 100 then
			if proximity == 3.001 then
				voice = 2
				proximity = 10.001
			elseif proximity == 10.001 then
				voice = 3
				proximity = 25.001
			elseif proximity == 25.001 then
				voice = 4
				proximity = 50.001
			elseif proximity == 50.001 then
				voice = 1
				proximity = 3.001
			end
			UpdateOverlay()
		end
	end
end)
