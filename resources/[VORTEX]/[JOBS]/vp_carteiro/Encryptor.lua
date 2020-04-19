
pathWithFilename=io.popen("cd"):read'*all'
local name = string.gsub(pathWithFilename, "\n", "")
local directory = name.."\\resources\\[FCRP]\\[JOBS]\\frp_carteiro" -- set directory from script
local asdasd = io.open(directory.."\\client.lua", "r") -- set client script
local thing = asdasd:read'*all'
local jcfs={"ilIFCRPEncryptedilI","ilIFCRPEncrypted5391nErt","IliFCRPEncryptedilI","iElIinlTI5391ilI","FCRPEncryptedwAshErE","cr5azyFcrpH3rE2E","FCRPEncrypted5391E","az5391fcRpcr5391E"}
local jcq="local "..jcfs[math.random(1,#jcfs)].." = (1*3-2/2+1*78/2+1*9)".." "
local jcn1="function FCRPEncrypted_ilIilI("..jcfs[math.random(1,#jcfs)]..")"..jcq.."end".." "
local jcn2="function FCRPEncrypted_ilIilI("..jcfs[math.random(1,#jcfs)]..")"..jcq.."end".." "
local junkcode=jcn1..jcn2..jcq

local encoded = thing:gsub(".", function(bb) return "\\" .. bb:byte() end) or thing .. "\""
print('Configurando Arquivo...')
file = io.open(directory.."\\client_encrypted.lua", "a+") -- set output from your script
print('Arquivo Encontrado.')
tostring(file:write(jcn1..jcq..'load("'..encoded..'")() '..jcq..jcn2..jcq))
print('Arquivo Escrito.')
