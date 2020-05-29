local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local savedMensage = {}

RegisterServerEvent('VP:PEAGLE:checkJOB')
AddEventHandler('VP:PEAGLE:checkJOB', function()

end)


RegisterCommand(
    "peagle",
    function(source,args)
    local Mensagem = cAPI.prompt(source, "Mensagem:", "")
    local idcart = math.random(111,999)
    
    local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()

    if Mensagem == "" then
        return
    end

    TriggerClientEvent("VP:PEAGLE:GetCoords", source, tplayer, Mensagem)
    --TriggerEvent("VP:PEAGLE:newNote", -1, Mensagem, "CART"..idcart)
end)

RegisterNetEvent("VP:PEAGLE:ReceiveCoords")
AddEventHandler("VP:PEAGLE:ReceiveCoords", function(coords, tplayer, Mensagem)
  TriggerClientEvent("VP:PEAGLE:ReceiveMenssage", tplayer, coords, Mensagem)
end)

RegisterNetEvent("VP:PEAGLE:LoadsNote")
AddEventHandler("VP:PEAGLE:LoadsNote", function()
   TriggerClientEvent('VP:PEAGLE:updateNotes', -1, savedMensage)
end)

RegisterNetEvent("VP:PEAGLE:newNote")
AddEventHandler("VP:PEAGLE:newNote", function(text, id)
      local import = {
        ["ID"] = ""..id.."",
        ["text"] = ""..text.."",
      }
      table.insert(savedMensage, import)
      TriggerEvent("VP:PEAGLE:LoadsNote")
end)

RegisterNetEvent("VP:PEAGLE:updateNote")
AddEventHandler("VP:PEAGLE:updateNote", function(noteID, text)
  savedMensage[noteID]["text"]=text
  TriggerEvent("VP:PEAGLE:LoadsNote")
end)

RegisterNetEvent("VP:PEAGLE:destroyNote")
AddEventHandler("VP:PEAGLE:destroyNote", function(noteID)
  table.remove(savedMensage, noteID)
  TriggerEvent("VP:PEAGLE:LoadsNote")
end)