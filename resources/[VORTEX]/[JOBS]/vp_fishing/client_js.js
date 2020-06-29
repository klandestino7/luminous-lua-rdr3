exports('GET_TASK_FISHING_DATA', (ped) => {
    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let hasMinigameOn = Citizen.invokeNative("0xF3735ACD11ACD500", PlayerPedId(), view);
    let outAsInt = new Int32Array(buffer);
    let outAsFloat = new Float32Array(buffer);

    // 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 36 34 35
    // 0 - 1 - 2 - 3 - 4 -  5 -  6  -  7  -  8  -  9  - 10  - 11  - 12  - 13  - 14  - 15  - 16  -  17

    return [hasMinigameOn, outAsInt, outAsFloat];
});

exports('SET_TASK_FISHING_DATA', (struct) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    for (i = 0; i <= 21; i ++){
        let k = `f_${i}`;
        v = struct[k];

        console.log(k);

        if (v != undefined){
            view.setInt32(i * 4, v, true);
        }
    }

    // let r = Citizen.invokeNative("0xF3735ACD11ACD501", PlayerPedId(), view);

    // let outAsInt = new Int32Array(buffer);
    // console.log(outAsInt);
});