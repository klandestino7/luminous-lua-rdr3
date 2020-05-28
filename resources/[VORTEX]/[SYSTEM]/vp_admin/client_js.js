// exports('js_teste_native', () => {

//     const arrayBuffer = new ArrayBuffer(256 * 4);
//     const dataView = new DataView(arrayBuffer);
//     dataView.setUint32(0, 31);

//     const coords = GetEntityCoords(PlayerPedId());
//     Citizen.invokeNative("0x345EC3B7EBDE1CB5", coords[0], coords[1], coords[2], 50.0, dataView, 4, Citizen.returnResultAnyway());
//     const arrayOut = new Int32Array(arrayBuffer);

//     console.log(arrayOut);
// });