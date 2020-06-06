exports('DataViewNativeGetEventData', (eventGroup, index, argStructSize) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    Citizen.invokeNative("0x57EC5FA4D4D6AFCA", eventGroup, index, view, argStructSize, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    console.log(out);
    // console.log(JSON.stringify(out));
    return out;
});

exports('DataViewNativeGetScenarioPointsCloseToCoords', (x, y, z, radius, size) => {

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    Citizen.invokeNative("0x345EC3B7EBDE1CB5", x, y, z, radius, view, size, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    // console.log(out);
    // console.log(JSON.stringify(out));
    return out;
});

exports('DataViewNetowrk', () => {


    // Global_1572887->f_342.f_4 = 4;
    // Global_1572887->f_342.f_21 = iParam0;
    // Global_1572887->f_342.f_5 = 18;
    // Global_1572887->f_342.f_25 = 0;
    // Global_1572887->f_342.f_26 = 0;

    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let buffer2 = new ArrayBuffer(256 * 2);
    let view2 = new DataView(buffer2);

    view.setInt32(0, 1, true); // f_1
    view.setInt32(8, -1, true); // f_2
    view.setInt32(16, -1, true); // f_3
    view.setInt32(24, -1, true); // f_4
    view.setInt32(32, -1, true); // f_5
    view.setInt32(40, -1, true); // f_6
    view.setInt32(48, -1, true); // f_7
    view.setInt32(56, -1, true); // f_8
    view.setInt32(64, -1, true); // f_9
    view.setInt32(72, -1, true); // f_10
    view.setInt32(80, -1, true); // f_11
    view.setInt32(88, -1, true); // f_12
    view.setInt32(96, -1, true); // f_13
    view.setInt32(104,-1, true); // f_14
    view.setInt32(112, -1, true); // f_15
    view.setInt32(120, -1, true); // f_16
    view.setInt32(128, -1, true); // f_17
    view.setInt32(136, -1, true); // f_18
    view.setInt32(144, -1, true); // f_19
    view.setInt32(152, -1, true); // f_20
    view.setInt32(160, -1, true); // f_21
    view.setInt32(168, -1, true); // f_22
    view.setInt32(176, -1, true); // f_23
    view.setInt32(184, -1, true); // f_24
    view.setInt32(192, -1, true); // f_25
    view.setInt32(200, -1, true); // f_26
    view.setInt32(208, -1, true); // f_27
    view.setInt32(216, -1, true); // f_28
    view.setInt32(224, -1, true); // f_29
    view.setInt32(232, -1, true); // f_30
    view.setInt32(240, -1, true); // f_31


    // Citizen.invokeNative("0x17C21B7319A05047"); // SESSION_LEAVE

    // 1rd: numPlayers
    // 3rd: 100/101/102/103
    Citizen.invokeNative("0x39A8EF7AF29A192C", 1, 0, view);

    // Citizen.invokeNative("0x2989E131FDE37E97", 0, 109, view);

    let out = new Int32Array(buffer);
    console.log(out);
});