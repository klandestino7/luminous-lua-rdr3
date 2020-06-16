let pedsSpawned = []
let postUsing = 0
let postManPrompt = null
let postManGroup = GetRandomIntInRange(0, 0xffffff)
let steps = 0
let Cards = 0
let tickNervoso = null
let SettedRoute = null
let blip = {}
let timer = 0;
let timing = null;

let WorkStations = [
    {
        ped: "U_M_M_RhdTrainStationWorker_01",
        x: 2748.02,
        y: -1396.81,
        z: 45.1,
        h: 21.20,
        Posts: [
            {
                x: 2731.64, y: -1402.33, z: 46.18
            }
        ],
        Routes: [
            { x: 2476.3903808594, y: -1257.2432861328, z: 48.32202911377 },
            { x: 2435.4719238281, y: -1250.4569091797, z: 45.889453887939 },
            { x: 2400.3029785156, y: -1129.0904541016, z: 46.823177337646 },
            { x: 2841.1586914063, y: -1077.8255615234, z: 45.365314483643 },
            { x: 2525.9570312543, y: -1129.5076904297, z: 49.87043762207 },
            { x: 2545.8195800781, y: -1129.0428466797, z: 50.571140289307 },
            { x: 2555.8884277344, y: -1129.6837158203, z: 50.61877822876 },
            { x: 2722.9196777344, y: -1275.5471191406, z: 49.625667572021 },
            { x: 2641.239, y:-973.583, z: 43.754},
            { x: 2576.201, y: -780.618, z:43.411},
            { x: 1865.882, y: -1402.342, z: 41.892},
            { x: 2846.347, y: -1074.492, z: 45.154 },
            { x: 1374.631, y: -864.310, z: 69.287 },
            { x: 1404.618, y: -1373.797, z: 81.304 }
        ]
    }
]

let rModel = null;
function createPeds() {
    for (let i = 0; i < WorkStations.length; i++) {
        if (pedsSpawned[i] == null) {
            let model = GetHashKey(WorkStations[i].ped)
            RequestModel(model)
            while (!HasModelLoaded(model) && !rModel) {
                rModel = setTimeout(function () {
                    RequestModel(model)
                }, 1000);
            }
            pedsSpawned[i] = CreatePed(model, WorkStations[i].x, WorkStations[i].y, WorkStations[i].z, WorkStations[i].h, 1, 0)
            SetPedOutfitPreset(pedsSpawned[i], 2, false)
            FreezeEntityPosition(pedsSpawned[i], true)
            PlaceObjectOnGroundProperly(pedsSpawned[i], true)
            if (blip['start' + i] == null) {
                CreateBlip('start' + i, WorkStations[i], 'Emprego Carteiro', -592068833)
            }
            postUsing = i
        }
    }
}
createPeds()

setTick(() => {
    if(timer == 0) {
        let posPlayer = GetEntityCoords(PlayerPedId())
        if (steps >= 1) {
            DrawText('Você possui ' + Cards + ' cartas', 0.925, 0.96, 0.4, 0.4, false, 255, 255, 255, 145, 1, 7)
        }
        if (steps == 0) {
            for (let i = 0; i < pedsSpawned.length; i++) {
                let posPed = GetEntityCoords(pedsSpawned[i])
                if (GetDistanceBetweenCoords(posPed[0], posPed[1], posPed[2], posPlayer[0], posPlayer[1], posPlayer[2]) < 2.5) {
                    notifyHelp('Bem vindo, senhor.')
                    PromptSetActiveGroupThisFrame(postManGroup, CreateVarString(10, 'LITERAL_STRING', 'Carteiro'))
                    if (PromptHasHoldModeCompleted(postManPrompt)) {
                        steps = 1
                    }
                }
            }
        } else if (steps == 1) {
            notifyHelp(' ')
            if (Cards < 15) {
                if (GetDistanceBetweenCoords(getPosts().x, getPosts().y, getPosts().z, posPlayer[0], posPlayer[1], posPlayer[2]) < 2.5) {
                    if (!tickNervoso) {
                        PromptSetText(postManPrompt, CreateVarString(10, 'LITERAL_STRING', 'Pegar Cartas'))
                        PromptSetActiveGroupThisFrame(postManGroup, CreateVarString(10, 'LITERAL_STRING', 'Carteiro'))
                        if (PromptHasHoldModeCompleted(postManPrompt)) {
                            tickNervoso = setTimeout(() => {
                                playAnim("mech_pickup@loot@horse_saddlebags@live@lt", "base", 1.0)
                                setTimeout(() => {
                                    Cards += 1
                                    setSatchel('0xEA272E11');
                                    tickNervoso = null;
                                }, 3700)
                            }, 100)
                        }
                    }
                }
            } else {
                steps = 2
                SettedRoute = getRoute();
            }
        } else if (steps == 2) {
            if (!DoesBlipExist(blip[steps])) {
                CreateBlip(steps, SettedRoute, 'Entregue suas Cartas', -1656531561)
            } else {
                if (Cards != 0) {
                    if (GetDistanceBetweenCoords(SettedRoute.x, SettedRoute.y, SettedRoute.z, posPlayer[0], posPlayer[1], posPlayer[2]) < 4.5) {
                        if (!tickNervoso) {
                            PromptSetText(postManPrompt, CreateVarString(10, 'LITERAL_STRING', 'Jogar Carta'))
                            PromptSetActiveGroupThisFrame(postManGroup, CreateVarString(10, 'LITERAL_STRING', 'Carteiro'))
                            if (PromptHasHoldModeCompleted(postManPrompt)) {
                                tickNervoso = setTimeout(() => {
                                    Cards -= 1
                                    SettedRoute = getRoute();
                                    DeleteBlips();
                                    tickNervoso = null;
                                }, 100)
                            }
                        }
                    }
                } else {
                    notifyHelp('Suas cartas acabaram, aguarde 20 minutos e vá para o posto novamente. Você recebeu $10,00')
                    DeleteBlips();
                    timer = 1200;
                    steps = 0;
                    postUsing = 0;
                    SettedRoute = null;
                    TriggerServerEvent("VP:CARTEIRO:pay")                   
                }
            }
        }
    }
})

/*
    FUNÇÕES
*/

setTick(() => {
    if (!timing && timer != 0) {
        timing = setTimeout(()=>{
            timer -= 1
            timing = null;
        },1000)
    }
})

function DeleteBlips() {
    RemoveBlip(blip[steps]);
}

function getRoute() {
    return WorkStations[postUsing].Routes[Math.floor(Math.random() * (WorkStations[postUsing].Routes.length))];
}

function setSatchel(model) {
    if (!HasModelLoaded(parseInt(model))) {
        Citizen.invokeNative('0xFA28FE3A6246FC30', parseInt(model))
    }
    Citizen.invokeNative('0xD3A7B003ED343FD9', PlayerPedId(), parseInt(model), true, true, true)
}

function getPosts() {
    for (let i = 0; i < WorkStations[postUsing].Posts.length; i++) {
        return WorkStations[postUsing].Posts[i]
    }
}

setInterval(() => {
    createPrompt();
}, 1000);

function createPrompt() {
    if (!PromptIsValid(postManPrompt)) {
        postManPrompt = PromptRegisterBegin()
        PromptSetControlAction(postManPrompt, 0xE8342FF2)
        PromptSetText(postManPrompt, CreateVarString(10, 'LITERAL_STRING', 'Pegar Emprego'))
        PromptSetEnabled(postManPrompt, 1)
        PromptSetVisible(postManPrompt, 1)
        PromptSetHoldMode(postManPrompt, 1)
        PromptSetGroup(postManPrompt, postManGroup)
        PromptRegisterEnd(postManPrompt)
    }
}

AddEventHandler('onResourceStop', (resourceName) => {
    if (GetCurrentResourceName() != resourceName) {
        return;
    }
    for (let i = 0; i < pedsSpawned.length; i++) {
        SetEntityCoords(pedsSpawned[i], 0, 0, 0)
        SetEntityAlpha(pedsSpawned[i], 0)
        SetEntityCompletelyDisableCollision(pedsSpawned[i], true, true)
        RemoveBlip(blip['start' + i])
    }
    DeleteBlips();
})

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font) {
    SetTextScale(w, h)
    SetTextColor(Math.floor(col1), Math.floor(col2), Math.floor(col3), Math.floor(a))
    SetTextCentre(centre)
    if (enableShadow) {
        SetTextDropshadow(1, 0, 0, 0, 255)
    }
    Citizen.invokeNative('0xADA9255D', font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
}

function notifyHelp(_message) {
    SetTextScale(0.25, 0.25)
    SetTextCentre(1)
    Citizen.invokeNative('0xFA233F8FE190514C', CreateVarString(10, "LITERAL_STRING", _message))
    Citizen.invokeNative('0xE9990552DEC71600')
}

let noCrash = null;
function playAnim(dict, anim, speed) {
    if (!IsEntityPlayingAnim(PlayerPedId(), dict, anim)) {
        RequestAnimDict(dict)
        while (!HasAnimDictLoaded(dict) && !noCrash) {
            noCrash = setTimeout(function () {
                RequestAnimDict(dict)
            }, 1000);
        }
        TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
    }
}

function CreateBlip(id, pos, name, sprite) {
    blip[id] = N_0x554d9d53f696d002(1664425300, pos.x, pos.y, pos.z)
    SetBlipSprite(blip[id], sprite, 1)
    SetBlipScale(blip[id], 0.2)
    Citizen.invokeNative('0x9CB1A1623062F402', blip[id], name)
}