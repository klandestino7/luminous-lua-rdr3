RegisterNetEvent("LP:Write")
AddEventHandler(
    "LP:Write",
    function(fileName, data)
        print('save')
        SaveResourceFile(GetCurrentResourceName(), fileName, data, -1)
    end
)