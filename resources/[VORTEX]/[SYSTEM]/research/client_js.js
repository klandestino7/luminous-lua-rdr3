exports('DataViewNativeGetEventData', (eventGroup, index, argStructSize) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    Citizen.invokeNative("0x57EC5FA4D4D6AFCA", eventGroup, index, view, argStructSize, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    // console.log(JSON.stringify(out));
    return out;
});

exports('DataViewNativeGetScenarioPointsCloseToCoords', (x, y, z, radius, size) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    letCitizen.invokeNative("0x345EC3B7EBDE1CB5", x, y, z, radius, view, size, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    // console.log(out);
    // console.log(JSON.stringify(out));
    return out;
});

exports('DataViewNetowrk', () => {
    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    // GET_TASK_FISHING_STATE
    // GET_STATE_OF_FISHING
    let w = Citizen.invokeNative("0xF3735ACD11ACD500", PlayerPedId(), view);
    let outAsInt = new Int32Array(buffer);
    let outAsFloat = new Float32Array(buffer);

    // 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 36 34 35
    // 1 - 2 - 3 - 4 - 5 -  6  -  7  -  8  -  9  - 10  - 11  - 12  - 13  - 14  - 15  - 16  -  17

    // f_1   0      float
    // f_2   2      float
    // f_3   4      float
    // f_5   8      flag?
    // f_6   10     flag?
    // f_7   12     entity
    // f_11  20     entity
    // f_12  22     entity
    // f_13  24     entity
    // f_14  26     float
    // f_15  28     float

    // console.log(outAsInt);
    // console.log(outAsFloat);

    return [w, outAsInt, outAsFloat];
});

exports('NativeCreateComposite', (compositeHash, x, y, z, onGround) => {
    let buffer = new ArrayBuffer(4 * 8);
    let view = new DataView(buffer);

    console.log(compositeHash)
    console.log(x, y, z, onGround);

    let composite = Citizen.invokeNative("0x5B4BBE80AD5972DC", compositeHash, x, y, z, 0.0, onGround ? 0 : 2, view, -1);

    let out = new Int32Array(buffer);

    console.log(composite);

    return composite;
});

exports('NativeGetCompositeEntities', (composite) => {
    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let size = Citizen.invokeNative("0x96C6ED22FB742C3E", composite, view);
    let out = new Int32Array(buffer);

    return [size, out];
});

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

    for (i = 0; i <= 27; i++) {
        let k = `f_${i}`;
        v = struct[k];

        switch (i) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 8:
            case 9:
            case 13:
            case 14:
            case 15:
            case 17:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
                v = Float32ToInt32(v);
                break;
        }

        view.setUint32(i * 8, v, true);
    }

    let r = Citizen.invokeNative("0xF3735ACD11ACD501", PlayerPedId(), view);
});

function Int32ToFloat32(num) {
    arr = new ArrayBuffer(4); // an Int32 takes 4 bytes
    view = new DataView(arr);
    view.setUint32(0, num, false); // byteOffset = 0; litteEndian = false
    // console.log(view.getFloat32(0));
    return view.getFloat32(0);
}


function Float32ToInt32(num) {
    arr = new ArrayBuffer(16); // an Float32 takes 4 bytes
    view = new DataView(arr);
    view.setFloat32(0, num, false); // byteOffset = 0; litteEndian = false
    // console.log(view.getInt32(0));
    return view.getInt32(0);
}

var matchmaking_buffer;
var matchmaking_struct;

exports('N_0x04019AE4956D4393_J', () => {

    let buffernh = new ArrayBuffer(256)
    let viewnh = new DataView(buffernh);
    let rr = Citizen.invokeNative("0x388EB2B86C73B6B3", PlayerId(), viewnh);
    let outnh = new Int32Array(buffernh);

    const nh = outnh[0];

    // console.log(nh);

    // console.log(NetworkGetLocalHandle(viewnh));
    // console.log(new Int32Array(buffernh));


    // Global_1572887->f_342.

    // view.setInt32(4 * 0, 0, true);
    // view.setInt32(4 * 1, 0, true);
    // view.setInt32(4 * 2, 0, true);
    // view.setInt32(4 * 3, 2, true);
    // view.setInt32(4 * 4, 3, true);
    // view.setInt32(4 * 5, 18, true); // 0 | 129
    // view.setInt32(4 * 6, 0, true);
    // view.setInt32(4 * 7, 4, true);
    // view.setInt32(4 * 8, 2, true);
    // view.setInt32(4 * 9, 2, true);
    // view.setInt32(4 * 10, 1, true); // flag
    // view.setInt32(4 * 11, 0, true); // f_11 part 2?
    // view.setInt32(4 * 12, 3, true);
    // view.setInt32(4 * 13, nh, true); // LOCAL HANDLE / 1101725955
    // view.setInt32(4 * 14, 0, true);
    // view.setInt32(4 * 15, 0, true);
    // view.setInt32(4 * 16, 0, true);
    // view.setInt32(4 * 17, 0, true);
    // view.setInt32(4 * 18, 0, true);
    // view.setInt32(4 * 19, 0, true);
    // view.setInt32(4 * 20, 101, true); // 100 101 102 103
    // view.setInt32(4 * 21, 1, true);
    // view.setInt32(4 * 22, -1, true); // -1 / GetGameTimer()
    // view.setInt32(4 * 23, -1, true); // -1 / GetGameTimer()
    // view.setInt32(4 * 24, -1, true); // -1 / GetGameTimer()
    // view.setInt32(4 * 25, 0, true);
    // view.setInt32(4 * 26, 0, true);

    // let r = Citizen.invokeNative("0x2989E131FDE37E97", 18, 0, 101, view);

    // NetworkSessionLeave();


    if (matchmaking_struct == undefined || matchmaking_struct == null) {

        matchmaking_buffer = new ArrayBuffer(256);
        matchmaking_struct = new DataView(matchmaking_buffer);
        /*
        matchmaking_struct.setInt32(4 * 0, 56001437, true);
        matchmaking_struct.setInt32(4 * 1, 8, true);
        matchmaking_struct.setInt32(4 * 2, -56899746, true);
        matchmaking_struct.setInt32(4 * 3, -1, true);
        */
        matchmaking_struct.setInt32(4 * 0, 0, true);
        matchmaking_struct.setInt32(4 * 1, 0, true); // 
        matchmaking_struct.setInt32(4 * 2, 0, true); // Matchmaking id?
        matchmaking_struct.setInt32(4 * 3, 5, true); // Your response id? [0: Clear?, 2: Enter?, 5: f_26 has to be set to 2]
        matchmaking_struct.setInt32(4 * 4, 0, true); // Matchmaking type? [1, 2, 3, 4, 5]
        matchmaking_struct.setInt32(4 * 5, 0, true); // [ =| 16, =| 8, =| 4]
        matchmaking_struct.setInt32(4 * 6, 0, true);
        matchmaking_struct.setInt32(4 * 7, 4, true);
        matchmaking_struct.setInt32(4 * 8, 2, true);
        matchmaking_struct.setInt32(4 * 9, 2, true);
        matchmaking_struct.setInt32(4 * 10, 1, true); // flag
        matchmaking_struct.setInt32(4 * 11, 0, true); // f_11 part 2?
        matchmaking_struct.setInt32(4 * 12, 3, true);
        matchmaking_struct.setInt32(4 * 13, nh, true); // Player Network Handle / 1101725955
        matchmaking_struct.setInt32(4 * 14, 0, true);
        matchmaking_struct.setInt32(4 * 15, 0, true);
        matchmaking_struct.setInt32(4 * 16, 0, true);
        matchmaking_struct.setInt32(4 * 17, 0, true);
        matchmaking_struct.setInt32(4 * 18, 0, true);
        matchmaking_struct.setInt32(4 * 19, 0, true);
        matchmaking_struct.setInt32(4 * 20, 101, true); // 100 101 102 103
        matchmaking_struct.setInt32(4 * 21, 1, true);
        matchmaking_struct.setInt32(4 * 22, GetGameTimer(), true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 23, GetGameTimer(), true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 24, GetGameTimer(), true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 25, 1, true); // BOOl
        matchmaking_struct.setInt32(4 * 26, 0, true); // Recreate-matchmaking type? [2: No retry?]
        matchmaking_struct.setInt32(4 * 27, -1, true); // [-1, 1]
        matchmaking_struct.setInt32(4 * 28, -1, true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 29, GetGameTimer(), true); // -1 / GetGameTimer()
        matchmaking_struct.setInt32(4 * 30, -1, true); // -1 / GetGameTimer()
    }

    NetworkSessionLeave();

    // let r = Citizen.invokeNative("0x2989E131FDE37E97", 0, 0, 101, matchmaking_struct);
    let r = Citizen.invokeNative("0x04019AE4956D4393", 0, 0, matchmaking_struct);

    let out = new Int32Array(matchmaking_buffer);

    console.log(r);
    console.log(out);

    const r_is = Citizen.invokeNative("0x2F54B146D3EDCE4D", matchmaking_struct); // IS_VALID

    console.log(r_is);

    if (r_is === 1) {
        const ru = Citizen.invokeNative("0x0DD051B1BF4B8BD6", matchmaking_struct); // GET_STATUS
        /*
        5 = Matchmaking Canceled
        */
        console.log(ru);
    }

    console.log(Citizen.invokeNative("0x8FB7C254CFCBF78E", matchmaking_struct)); // IS_FINISHED?

    Citizen.invokeNative("0xE72E5C1289BD1F40", matchmaking_struct); // DELETE

    // console.log('Ye');

    // return [r, out];
});


var mm_buffer = new ArrayBuffer(4 * 31);
var mm_view = new DataView(mm_buffer);
var mm_out = new Int32Array(mm_buffer);

function N_0x04019AE4956D4393() {

    let buffernh = new ArrayBuffer(256)
    let viewnh = new DataView(buffernh);
    let rr = Citizen.invokeNative("0x388EB2B86C73B6B3", PlayerId(), viewnh);
    let outnh = new Int32Array(buffernh);

    const localNetworkHandle = outnh[0];

    console.log(localNetworkHandle, GetGameTimer());

    mm_buffer = new ArrayBuffer(4 * 31);
    mm_view = new DataView(mm_buffer);

    mm_view.setInt32(4 * 0, 0, true); // accId
    mm_view.setInt32(4 * 1, 0, true); // platId
    mm_view.setInt32(4 * 2, 0, true); // Session id / index
    mm_view.setInt32(4 * 3, 4, true); // Your response id? [0: Clear?, 2: Enter?, 5: f_26 has to be set to 2]
    mm_view.setInt32(4 * 4, 2, true); // Matchmaking type? [1, 2, 3, 4, 5]
    mm_view.setInt32(4 * 5, 0, true); // [ =| 16, =| 8, =| 4]
    mm_view.setInt32(4 * 6, 0, true);
    mm_view.setInt32(4 * 7, 8, true);
    mm_view.setInt32(4 * 8, 2, true);
    mm_view.setInt32(4 * 9, 2, true);
    mm_view.setInt32(4 * 10, 1, true); // flag
    mm_view.setInt32(4 * 11, 0, true); // f_10 part 2?
    mm_view.setInt32(4 * 12, 3, true);
    mm_view.setInt32(4 * 13, localNetworkHandle, true); // Player Network Handle / 1101725955
    mm_view.setInt32(4 * 14, 0, true);
    mm_view.setInt32(4 * 15, 0, true);
    mm_view.setInt32(4 * 16, 0, true);
    mm_view.setInt32(4 * 17, 0, true);
    mm_view.setInt32(4 * 18, 0, true);
    mm_view.setInt32(4 * 19, 0, true);
    mm_view.setInt32(4 * 20, 101, true); // 100 101 102 103
    mm_view.setInt32(4 * 21, 1, true);
    mm_view.setInt32(4 * 22, GetGameTimer(), true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 23, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 24, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 25, 0, true); // BOOl
    mm_view.setInt32(4 * 26, 0, true); // Recreate-matchmaking type? [2: No retry?]
    mm_view.setInt32(4 * 27, -1, true); // [-1, 1]
    mm_view.setInt32(4 * 28, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 29, -1, true); // -1 / GetGameTimer()
    mm_view.setInt32(4 * 30, -1, true); // -1 / GetGameTimer()

    // NetworkSessionLeave();

    // let r = Citizen.invokeNative("0x2989E131FDE37E97", 0, 0, 101, mm_view);
    let r = Citizen.invokeNative("0x04019AE4956D4393", 0, 0, mm_view);

    mm_out = new Int32Array(mm_buffer);

    console.log(r, mm_out);
}

// IS_VALID
exports('N_0x2F54B146D3EDCE4D', (array) => {
    const vb = luaArrayToViewAndBuffer(array);
    const buffer = vb[0];
    const view = vb[1];

    const r = Citizen.invokeNative("0x2F54B146D3EDCE4D", view);

    console.log("IsValid?", view[2], r);
});

// GET_STATUS
function N_0x0DD051B1BF4B8BD6() {
    const matchmakingid = mm_out[2];

    const r = Citizen.invokeNative("0x0DD051B1BF4B8BD6", mm_view);

    console.log('Status?', matchmakingid, r);
};

// ?
exports('N_0x8FB7C254CFCBF78E', (array) => {
    const vb = luaArrayToViewAndBuffer(array);
    const buffer = vb[0];
    const view = vb[1];
});

// DELETE
function N_0xE72E5C1289BD1F40() {
    // const vb = luaArrayToViewAndBuffer(array);
    // const buffer = vb[0];
    // const view = vb[1];

    const matchmakingid = mm_out[2];

    const r = Citizen.invokeNative("0xE72E5C1289BD1F40", mm_view);

    console.log('Delete?', matchmakingid, r);
};

// function luaArrayToBufferAndView(array) {

//     let buffer = new ArrayBuffer(256);
//     let view = new DataView(buffer);

//     for (i = 0; i <= 30; i++) {
//         let k = `f_${i}`;
//         v = struct[k];

//         view.setInt32(i * 4, v, true);
//     }

//     return [buffer, view];
// }

RegisterCommand('mcreate', (source, args) => {
    N_0x04019AE4956D4393();
});

RegisterCommand('mset', (source, args) => {
    mm_view.setInt32(4 * parseInt(args[0]), parseInt(args[1]), true);

    let r = Citizen.invokeNative("0x2989E131FDE37E97", 0, 0, 101, mm_view);
    mm_out = new Int32Array(mm_buffer);
});

RegisterCommand('mdel', (source, args) => {
    N_0xE72E5C1289BD1F40();
});

RegisterCommand('mstatus', (source, args) => {
    N_0x0DD051B1BF4B8BD6();
});

// setTick(() => {
//     if (mm_view != undefined) {

//         let i = 0;
//         mm_out.forEach((element, index, array) => {
//             // if (index == 0 || index % 2 == 0) {
//             DrawTxt(`f_${i}`, 0.65, 0.05 + (i * 0.03), 0.4, 0.55, true, 255, 255, 255, 255, false);
//             DrawTxt("" + element, 0.75, 0.05 + (i * 0.03), 0.4, 0.55, true, 255, 255, 255, 255, false);
//             i++;
//             // }
//         });
//     }
// });

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre) {
    str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)
    SetTextCentre(centre)
    SetTextDropshadow(1, 0, 0, 0, 255)
    Citizen.invokeNative(0xADA9255D, 2)
    DisplayText(str, x, y)
}


// levels3.rpf/levels/rdr3/scenario/herbs_*.ymt

// Hey, i keep having crashes when trying to use 0xF3735ACD11ACD501, probably because i am messing something up with DataView, thought you could maybe give me a hand?