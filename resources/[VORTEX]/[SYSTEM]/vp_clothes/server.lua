local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

RegisterNetEvent("VP:CLOTHES:SavePlayerClothing")
AddEventHandler(
    "VP:CLOTHES:SavePlayerClothing",
    function(dataClothes, securePayment)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        if Character ~= nil then            

            -- for k, v in pairs(data) do
            --     Character:setData(Character:getId(), 'clothes', k, v)
            -- end

            -- local data = json.encode(dataClothes)

            local Inventory = Character:getInventory()

          --  if Inventory:removeItem(-1, "money", #data * 0.2) then            
              --  TriggerClientEvent('VP:CLOTHES:ClearOldClothing', _source)                
                for k, v in pairs(dataClothes) do 
                 --   if v ~= 0 then
                      --  print(k,v)
                        Character:setData(Character:getId(), 'clothes', k, v)
                  --  end
                   -- dbAPI.execute("UPDATE:character_data_clothing", {charid = Character:getId(), clothing = data})
                end              
            --else
               -- TriggerClientEvent('VP:CLOTHES:DrawOldClothing', _source)
             --   User:notify('error', 'Dinheiro insuficiente!')
          --  end
            
        end
    end
)
