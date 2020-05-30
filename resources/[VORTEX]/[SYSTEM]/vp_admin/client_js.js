exports('js_teste_native', (group, i, size) => {

    let buffer = new ArrayBuffer(256 * 2);
    let view = new DataView(buffer);
    // dataView.setInt32(0, 3);
    // dataView.setInt32(3, );

    Citizen.invokeNative("0x57EC5FA4D4D6AFCA", group, i, view, size, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);

    console.log(out);
    // console.log(JSON.stringify(out));
});