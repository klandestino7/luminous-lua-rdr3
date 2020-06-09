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

    let buffer = new ArrayBuffer(21 * 8);
    let view = new DataView(buffer);

    view.setInt32(0, 30.0, true); // f_1
    view.setInt32(8, 0.0, true); // f_2
    view.setInt32(16, 0.5, true); // f_3
    view.setInt32(24, 0.0, true); // f_4
    view.setInt32(32, 0, true); // f_5
    view.setInt32(40, 0, true); // f_6
    view.setInt32(48, 0, true); // f_7
    view.setInt32(56, 0.0, true); // f_8
    view.setInt32(64, 0.0, true); // f_9
    view.setInt32(72, 0, true); // f_10
    view.setInt32(80, 0, true); // f_11
    view.setInt32(88, 0, true); // f_12
    view.setInt32(96, 1.0, true); // f_13
    view.setInt32(104, 0, true); // f_14
    view.setInt32(112, 0, true); // f_15
    view.setInt32(120, 3, true); // f_16
    view.setInt32(128, 0.0, true); // f_17
    view.setInt32(136, 0, true); // f_18
    view.setInt32(144, 0, true); // f_19
    view.setInt32(152, 0.5, true); // f_20
    view.setInt32(160, 1.0, true); // f_21
    // view.setInt32(168, 0.0, true); // f_22
    // view.setInt32(176, 0.0, true); // f_23
    // view.setInt32(184, 0.0, true); // f_24
    // view.setInt32(192, 0.0, true); // f_25
    // view.setInt32(200, 0.0, true); // f_26
    // view.setInt32(208, 0.0, true); // f_27
    // view.setInt32(216, 0.0, true); // f_28
    // view.setInt32(224, 0.0, true); // f_29
    // view.setInt32(232, 0.0, true); // f_30
    // view.setInt32(240, 0.0, true); // f_31

    Citizen.invokeNative("0xF3735ACD11ACD501", PlayerPedId(), view);

    let out = new Int32Array(buffer);
});