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