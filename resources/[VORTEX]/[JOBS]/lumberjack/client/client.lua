local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

local prompts = {}

TreeHashes = {
4065794,
8489218,
6723074,
1897986,
46857,
85265,
175637,
236309,
247063,
68631, 
77336,
370203,
290589,
246045,
304414, 
215582,
308255,
197149, 
103448,
165665,
126498, 
109345,
285987,
337441, 
29221, 
341282, 
322340, 
144166, 
219171,
213285,
213023, 
369703, 
71460, 
183849, 
345127, 
174120,
290599,
235561,
152359, 
290599, 
132395, 
229929, 
349227, 
35371, 
45101,
334382,
110383,
334382,
338989,
45101,
334382,
199729,
45101,
168754,
338989,
102704,
244016,
325171,
191794,
244016,
47156,
325171,
63278,
335413,
211765,
252722,
56630,
}


local Anim = false


-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             for _, prompt in pairs(prompts) do
--                 if Citizen.InvokeNative(0xE0F65F0640EF0617, prompt) then
--                     Citizen.Wait(0)            
--                         print('kdksks')
--                     -- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 20000, true, false, false, false)           
--                 end
--             end
--         end
--     end
-- )    

Citizen.CreateThread(function()
	while true do
    local Ped = PlayerPedId()
    local Entity, farCoordsX, farCoordsY, farCoordsZ = cAPI.Target(6.0, Ped)

    local EntityType = GetEntityType(Entity)

    local EntityModel = GetEntityModel(Entity)

    --print(EntityModel)
    
    for _, tree in pairs(TreeHashes) do
        if Entity == tree or EntityType == 3 then
            if IsControlJustPressed(0, 0xE8342FF2) then -- Hold ALT					
                if not Anim then
                    anim() 
                    Anim = true
                    Wait(20000)
                    Anim = false
                end    
            end
        else
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
         --   Anim = false
        end
    end

    Citizen.Wait(0)
	end
end)

function anim()

-- local pile = CreateObject("p_cs_woodPile01x", GetEntityCoords(PlayerPedId()), false, true, false, false, false)
-- Citizen.InvokeNative(0xF0B4F759F35CC7F5, pile , GetHashKey('FIREWOOD'), 0, 0, 512)

end

AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end)



