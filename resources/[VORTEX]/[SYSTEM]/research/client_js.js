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

exports('DataViewNetowrk', (comp) => {


    let buffer = new ArrayBuffer(256);
    let view = new DataView(buffer);

    let w = Citizen.invokeNative("0x5B4BBE80AD5972DC", comp, GetEntityCoords(PlayerPedId()), 0.0, 0, view, -1);

    // Citizen.invokeNative("0x5758B1EE0C3FD4AC", w, 0); // DELETE_PLANT
    let z = Citizen.invokeNative("0x96C6ED22FB742C3E", w, GetEntityCoords(PlayerPedId()));

    let out = new Int32Array(buffer);
    console.log(z);
    console.log(w);
    console.log(out);
});