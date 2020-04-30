function showNotification(text, duration) {
    // int32 x4
    const struct1 = new DataView(new ArrayBuffer(4 * 4));
    struct1.setInt32(0, duration, true); // duration
   
    const string = CreateVarString(10, "LITERAL_STRING", text);
   
    // int32 (weird padding) + int32 + uint64
    const struct2 = new DataView(new ArrayBuffer(100));
    struct2.setBigInt64(8, BigInt(string), true);
    struct2.setBigInt64(16, BigInt(string), true);
    console.log('in')
   
    Citizen.invokeNative("0xC927890AA64E9661", struct1, struct2, 1, 1);
  }
  
  showNotification('ab', 10000);

  