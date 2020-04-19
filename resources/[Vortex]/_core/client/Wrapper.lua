function cAPI.RequestModel(hash)
	hash = tonumber(hash)

	if not IsModelValid(hash) then
		return
	end

	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(10)
		end
	end
end

function cAPI.RequestAnimDict(dictionary)
	if not HasAnimDictLoaded(dictionary) then
		RequestAnimDict(dictionary)
		while not HasAnimDictLoaded(dictionary) do
			Citizen.Wait(10)
		end
	end
end

function cAPI.InFade(timer)
	DoScreenFadeOut(timer)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function cAPI.OutFade(timer)
	ShutdownLoadingScreen()
	DoScreenFadeIn(timer)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

-- {x, y, z}
-- function cAPI.SkyCameraAtCoords(coords)
-- 	local cam =  CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
-- 	PointCamAtCoord(cam, coords[1], coords[2], coords[3] + 200)
-- 	SetCamActive(cam, true)

-- 	cAPI.EndFade(500)

-- 	RenderScriptCams(true, false, 1, true, true)
-- 	return cam
-- end

function cAPI.PlaySkyCameraAnimationAtCoords(coords)
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67, 374.08, 873.24, 300.00, 0.00, 0.00, 100.00, false, 0) -- CAMERA COORDS
	PointCamAtCoord(cam, coords[1], coords[2], coords[3] + 200)
	SetCamActive(cam, true)
	cAPI.EndFade(500)
	cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords[1], coords[2], coords[3] + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
	PointCamAtCoord(cam3, coords[1], coords[2], coords[3] + 200)
	SetCamActiveWithInterp(cam3, cam, 3900, true, true)
	Citizen.Wait(3900)
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords[1], coords[2], coords[3] + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
	PointCamAtCoord(cam2, coords[1], coords[2], coords[3] + 2)
	SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
	RenderScriptCams(false, true, 500, true, true)
	SetEntityCoords(PlayerPedId(), coords[1], coords[2], coords[3] + 0.5)
	Citizen.Wait(500)
	Citizen.Wait(3000)
	DestroyAllCams(true)
end