cUI = {}
Tunnel.bindInterface("API:cUI", cUI)
Proxy.addInterface("API:cUI", cUI)

local prompResult = nil
local canDisplayNUI = true

function cAPI.prompt(title, default_text)
	SendNUIMessage({act = "prompt", title = title, text = tostring(default_text)})
	SetNuiFocus(true)
	while prompResult == nil do
		Citizen.Wait(10)
	end
	local _temp = prompResult
	prompResult = nil
	return _temp
end

RegisterNUICallback(
	"prompt",
	function(data, cb)
		if data.act == "close" then
			SetNuiFocus(false)
			prompResult = data.result
		end
	end
)

local requests = {}

function cAPI.request(text, time)
	local id = math.random(999999)
	SendNUIMessage({act = "request", id = id, text = tostring(text), time = time})

	-- !!! OPTIMIZATION
	-- Stop the loop while the time has passed

	while requests[id] == nil do
		Citizen.Wait(10)
	end

	local _temp = requests[id] or false
	requests[id] = nil
	return _temp
end

RegisterNUICallback(
	"request",
	function(data, cb)
		if data.act == "response" then
			requests[data.id] = data.ok
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(3)
			if IsControlJustPressed(1, 166) then
				SendNUIMessage({act = "event", event = "yes"})
			end
			if IsControlJustPressed(1, 167) then
				SendNUIMessage({act = "event", event = "no"})
			end
		end
	end
)

function cAPI.canDisplayNUI()
	return canDisplayNUI
end

function cAPI.setCanDisplayNUI(bool)
	canDisplayNUI = bool
end