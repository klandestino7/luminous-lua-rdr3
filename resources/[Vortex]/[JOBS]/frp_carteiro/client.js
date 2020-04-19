/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/client/client.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/client/client.js":
/*!******************************!*\
  !*** ./src/client/client.js ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("let pedsSpawned = []\r\nlet postUsing = 0\r\nlet postManPrompt = null\r\nlet postManGroup = GetRandomIntInRange(0, 0xffffff)\r\nlet steps = 0\r\nlet Cards = 0\r\nlet tickNervoso = null\r\nlet SettedRoute = null\r\nlet blip = {}\r\nlet timer = 0;\r\nlet timing = null;\r\n\r\nlet WorkStations = [\r\n    {\r\n        ped: \"U_M_M_RhdTrainStationWorker_01\",\r\n        x: 2748.02,\r\n        y: -1396.81,\r\n        z: 45.1,\r\n        h: 21.20,\r\n        Posts: [\r\n            {\r\n                x: 2731.64, y: -1402.33, z: 46.18\r\n            }\r\n        ],\r\n        Routes: [\r\n            { x: 2476.3903808594, y: -1257.2432861328, z: 48.32202911377 },\r\n            { x: 2435.4719238281, y: -1250.4569091797, z: 45.889453887939 },\r\n            { x: 2400.3029785156, y: -1129.0904541016, z: 46.823177337646 },\r\n            { x: 2841.1586914063, y: -1077.8255615234, z: 45.365314483643 },\r\n            { x: 2525.9570312543, y: -1129.5076904297, z: 49.87043762207 },\r\n            { x: 2545.8195800781, y: -1129.0428466797, z: 50.571140289307 },\r\n            { x: 2555.8884277344, y: -1129.6837158203, z: 50.61877822876 },\r\n            { x: 2722.9196777344, y: -1275.5471191406, z: 49.625667572021 }\r\n        ]\r\n    }\r\n]\r\n\r\nlet rModel = null;\r\nfunction createPeds() {\r\n    for (let i = 0; i < WorkStations.length; i++) {\r\n        if (pedsSpawned[i] == null) {\r\n            let model = GetHashKey(WorkStations[i].ped)\r\n            RequestModel(model)\r\n            while (!HasModelLoaded(model) && !rModel) {\r\n                rModel = setTimeout(function () {\r\n                    RequestModel(model)\r\n                }, 1000);\r\n            }\r\n            pedsSpawned[i] = CreatePed(model, WorkStations[i].x, WorkStations[i].y, WorkStations[i].z, WorkStations[i].h, 1, 0)\r\n            SetPedOutfitPreset(pedsSpawned[i], 2, false)\r\n            FreezeEntityPosition(pedsSpawned[i], true)\r\n            PlaceObjectOnGroundProperly(pedsSpawned[i], true)\r\n            if (blip['start' + i] == null) {\r\n                CreateBlip('start' + i, WorkStations[i], 'Emprego Carteiro', -592068833)\r\n            }\r\n            postUsing = i\r\n        }\r\n    }\r\n}\r\ncreatePeds();\r\n\r\nsetTick(() => {\r\n    if(timer == 0) {\r\n        let posPlayer = GetEntityCoords(PlayerPedId())\r\n        if (steps >= 1) {\r\n            DrawText('Você possui ' + Cards + ' cartas', 0.925, 0.96, 0.4, 0.4, false, 255, 255, 255, 145, 1, 7)\r\n        }\r\n        if (steps == 0) {\r\n            for (let i = 0; i < pedsSpawned.length; i++) {\r\n                let posPed = GetEntityCoords(pedsSpawned[i])\r\n                if (GetDistanceBetweenCoords(posPed[0], posPed[1], posPed[2], posPlayer[0], posPlayer[1], posPlayer[2]) < 2.5) {\r\n                    notifyHelp('Bem vindo, senhor.')\r\n                    PromptSetActiveGroupThisFrame(postManGroup, CreateVarString(10, 'LITERAL_STRING', 'Carteiro'))\r\n                    if (PromptHasHoldModeCompleted(postManPrompt)) {\r\n                        steps = 1\r\n                    }\r\n                }\r\n            }\r\n        } else if (steps == 1) {\r\n            notifyHelp(' ')\r\n            if (Cards < 15) {\r\n                if (GetDistanceBetweenCoords(getPosts().x, getPosts().y, getPosts().z, posPlayer[0], posPlayer[1], posPlayer[2]) < 2.5) {\r\n                    if (!tickNervoso) {\r\n                        PromptSetText(postManPrompt, CreateVarString(10, 'LITERAL_STRING', 'Pegar Cartas'))\r\n                        PromptSetActiveGroupThisFrame(postManGroup, CreateVarString(10, 'LITERAL_STRING', 'Carteiro'))\r\n                        if (PromptHasHoldModeCompleted(postManPrompt)) {\r\n                            tickNervoso = setTimeout(() => {\r\n                                playAnim(\"mech_pickup@loot@horse_saddlebags@live@lt\", \"base\", 1.0)\r\n                                setTimeout(() => {\r\n                                    Cards += 1\r\n                                    setSatchel('0xEA272E11');\r\n                                    tickNervoso = null;\r\n                                }, 3700)\r\n                            }, 100)\r\n                        }\r\n                    }\r\n                }\r\n            } else {\r\n                steps = 2\r\n                SettedRoute = getRoute();\r\n            }\r\n        } else if (steps == 2) {\r\n            if (!DoesBlipExist(blip[steps])) {\r\n                CreateBlip(steps, SettedRoute, 'Entregue suas Cartas', -1656531561)\r\n            } else {\r\n                if (Cards != 0) {\r\n                    if (GetDistanceBetweenCoords(SettedRoute.x, SettedRoute.y, SettedRoute.z, posPlayer[0], posPlayer[1], posPlayer[2]) < 4.5) {\r\n                        if (!tickNervoso) {\r\n                            PromptSetText(postManPrompt, CreateVarString(10, 'LITERAL_STRING', 'Jogar Carta'))\r\n                            PromptSetActiveGroupThisFrame(postManGroup, CreateVarString(10, 'LITERAL_STRING', 'Carteiro'))\r\n                            if (PromptHasHoldModeCompleted(postManPrompt)) {\r\n                                tickNervoso = setTimeout(() => {\r\n                                    Cards -= 1\r\n                                    SettedRoute = getRoute();\r\n                                    notifyHelp('Você entregou uma carta, vá para a próxima localização.')\r\n                                    DeleteBlips();\r\n                                    tickNervoso = null;\r\n                                }, 100)\r\n                            }\r\n                        }\r\n                    }\r\n                } else {\r\n                    notifyHelp('Suas cartas acabaram, vá para o posto receber sua recompensa e aguarde 20 minutos..')\r\n                    DeleteBlips();\r\n                    timer = 1200;\r\n                    steps = 0;\r\n                    postUsing = 0;\r\n                    SettedRoute = null;\r\n                }\r\n            }\r\n        }\r\n    }\r\n})\r\n\r\n/*\r\n    FUNÇÕES\r\n*/\r\n\r\nsetTick(() => {\r\n    if (!timing && timer != 0) {\r\n        timing = setTimeout(()=>{\r\n            timer -= 1\r\n            timing = null;\r\n        },1000)\r\n    }\r\n})\r\n\r\nfunction DeleteBlips() {\r\n    RemoveBlip(blip[steps]);\r\n}\r\n\r\nfunction getRoute() {\r\n    return WorkStations[postUsing].Routes[Math.floor(Math.random() * (WorkStations[postUsing].Routes.length))];\r\n}\r\n\r\nfunction setSatchel(model) {\r\n    if (!HasModelLoaded(parseInt(model))) {\r\n        Citizen.invokeNative('0xFA28FE3A6246FC30', parseInt(model))\r\n    }\r\n    Citizen.invokeNative('0xD3A7B003ED343FD9', PlayerPedId(), parseInt(model), true, true, true)\r\n}\r\n\r\nfunction getPosts() {\r\n    for (let i = 0; i < WorkStations[postUsing].Posts.length; i++) {\r\n        return WorkStations[postUsing].Posts[i]\r\n    }\r\n}\r\n\r\nsetInterval(() => {\r\n    createPrompt();\r\n}, 1000);\r\n\r\nfunction createPrompt() {\r\n    if (!PromptIsValid(postManPrompt)) {\r\n        postManPrompt = PromptRegisterBegin()\r\n        PromptSetControlAction(postManPrompt, 0xE8342FF2)\r\n        PromptSetText(postManPrompt, CreateVarString(10, 'LITERAL_STRING', 'Pegar Emprego'))\r\n        PromptSetEnabled(postManPrompt, 1)\r\n        PromptSetVisible(postManPrompt, 1)\r\n        PromptSetHoldMode(postManPrompt, 1)\r\n        PromptSetGroup(postManPrompt, postManGroup)\r\n        PromptRegisterEnd(postManPrompt)\r\n    }\r\n}\r\nAddEventHandler('playerSpawned', () => {\r\n    createPeds();\r\n});\r\nAddEventHandler('onResourceStop', (resourceName) => {\r\n    if (GetCurrentResourceName() != resourceName) {\r\n        return;\r\n    }\r\n    for (let i = 0; i < pedsSpawned.length; i++) {\r\n        SetEntityCoords(pedsSpawned[i], 0, 0, 0)\r\n        SetEntityAlpha(pedsSpawned[i], 0)\r\n        SetEntityCompletelyDisableCollision(pedsSpawned[i], true, true)\r\n        RemoveBlip(blip['start' + i])\r\n    }\r\n    DeleteBlips();\r\n})\r\n\r\nfunction DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font) {\r\n    SetTextScale(w, h)\r\n    SetTextColor(Math.floor(col1), Math.floor(col2), Math.floor(col3), Math.floor(a))\r\n    SetTextCentre(centre)\r\n    if (enableShadow) {\r\n        SetTextDropshadow(1, 0, 0, 0, 255)\r\n    }\r\n    Citizen.invokeNative('0xADA9255D', font)\r\n    DisplayText(CreateVarString(10, \"LITERAL_STRING\", str), x, y)\r\n}\r\n\r\nfunction notifyHelp(_message) {\r\n    SetTextScale(0.25, 0.25)\r\n    SetTextCentre(1)\r\n    Citizen.invokeNative('0xFA233F8FE190514C', CreateVarString(10, \"LITERAL_STRING\", _message))\r\n    Citizen.invokeNative('0xE9990552DEC71600')\r\n}\r\n\r\nlet noCrash = null;\r\nfunction playAnim(dict, anim, speed) {\r\n    if (!IsEntityPlayingAnim(PlayerPedId(), dict, anim)) {\r\n        RequestAnimDict(dict)\r\n        while (!HasAnimDictLoaded(dict) && !noCrash) {\r\n            noCrash = setTimeout(function () {\r\n                RequestAnimDict(dict)\r\n            }, 1000);\r\n        }\r\n        TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)\r\n    }\r\n}\r\n\r\nfunction CreateBlip(id, pos, name, sprite) {\r\n    blip[id] = N_0x554d9d53f696d002(1664425300, pos.x, pos.y, pos.z)\r\n    SetBlipSprite(blip[id], sprite, 1)\r\n    SetBlipScale(blip[id], 0.2)\r\n    Citizen.invokeNative('0x9CB1A1623062F402', blip[id], name)\r\n}\n\n//# sourceURL=webpack:///./src/client/client.js?");

/***/ })

/******/ });