local isFishing = false

Citizen.CreateThread(
    function()
        local DRAW_LINE = GetHashKey("DRAW_LINE")

        local isFishing = false

        local struct = {
            f_12 = nil,
            f_13 = nil
        }

        while true do
            Citizen.Wait(0)

            -- TaskWeapon(PlayerPedId())

            local ped = PlayerPedId()

            -- local has, weaponHash = GetCurrentPedWeapon(ped, 0)

            -- if has and weaponHash == GetHashKey("WEAPON_FISHINGROD") then
            --     if IsControlPressed(0, 0xF84FA74F) and IsControlJustPressed(0, 0x07CE1E61) then

            --         -- Citizen.InvokeNative(0xF3735ACD11ACD500, ped, 12)
            --         Citizen.InvokeNative(0x1F298C7BD30D1240, ped)
            --         -- SetPedResetFlag(ped, 134, true)
            --         SetPedConfigFlag(ped, 502, true)
            --     end
            -- end

            if HasAnimEventFired(ped, -1947554776) then
                print("anim 1")
            end

            -- if IsControlJustPressed(0, 0x07CE1E61) then
            local r = exports["research"]:DataViewNetowrk()
            isFishing = r[1]
            local bufferAsInt = r[2]
            local bufferAsFloat = r[3]

            -- print(json.encode(bufferAsInt))
            -- print(json.encode(bufferAsFloat))

            -- print(bufferAsInt["24"], DoesEntityExist(bufferAsInt["24"]))

            struct[1] = bufferAsInt["0"]        -- int      |   Task_Fishing_State
            struct[2] = bufferAsFloat["2"]
            struct[3] = bufferAsFloat["4"]      -- float    |   Distance_To_Fishing_Line
            struct[4] = bufferAsFloat["6"]      -- float    |   Fishing_Line_Curvature
            struct[5] = bufferAsInt["8"]        --          |   FLAG?
            struct[6] = bufferAsInt["10"]       -- BOOL     |   Is_Ped_Trying_To_Hook
            struct[7] = bufferAsInt["12"]       -- Entity   |   Might be the fish you set when using the setter?
            struct[8] = bufferAsInt["14"]       -- float?
            struct[9] = bufferAsFloat["16"]     -- float?
            struct[10] = bufferAsInt["18"]
            struct[11] = bufferAsInt["20"]      -- int      |   Some sort of timer?
            struct[12] = bufferAsInt["22"]      -- Entity   |   Bobber / Boia
            struct[13] = bufferAsInt["24"]      -- Entity   |   Lure / Isca
            struct[14] = bufferAsFloat["26"]
            struct[15] = bufferAsFloat["28"]
            struct[16] = bufferAsFloat["30"]    -- int      | Some sort of state? range: -1-6


            -- // 0xF3735ACD11ACD500
            -- // GETTER
            -- BOOL _GET_ TASK_FISHING_STATE/STATE_FISHING(Ped ped, Any* argStruct)
            -- /*
            -- Returns wether the ped is fishing or trying to fish
            -- */
            
            -- // 0xF3735ACD11ACD501
            -- // SETTER
            -- Any _SET_ TASK_FISHING_STATE/STATE_FISHING(Ped ped, Any argStruct)
            
            -- struct task_fishing_state = {
            --   int fishing_state;
            --   Any unk0;
            --   float distance_to_fishing_line;
            --   float fishing_line_curvature;
            --   int unk1; // Mostly likely to be a flag
            --   BOOL is_ped_trying_to_hook;
            --   Entity unk2; //  Might be the fish you set when using the setter?
            --   float unk3;
            --   float unk4;
            --   int unk5; // Some sort of timer? How long the ped has got the fishingrod?
            --   Entity bobber;
            --   Entity lure;
            --   Any unk6;
            --   Any unk7;
            --   int unk8; // Some sort of state? range: -1-6
            -- }

            -- Global_1900073->f_26[iVar1 /*30*/])->

            -- SETTER
            -- 0xF3735ACD11ACD501

            -- Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, GetEntityCoords(ped), GetEntityCoords(f_12_entity), 0, 0, 255, 255)
            -- Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, GetEntityCoords(ped), GetEntityCoords(struct.f_13), 0, 0, 255, 255)

            DrawTxt("isFishing", 0.65, 0.05, 0.4, 0.4, true, 255, 255, 255, 255, false)
            DrawTxt("" .. (isFishing == 1 and "true" or "false"), 0.75, 0.05, 0.4, 0.4, true, 255, 255, 255, 255, false)

            local i = 1
            for k, v in pairs(struct) do
                DrawTxt("f_" .. k, 0.65, 0.05 + (i * 0.02), 0.4, 0.4, true, 255, 255, 255, 255, false)
                DrawTxt("" .. v, 0.75, 0.05 + (i * 0.02), 0.4, 0.4, true, 255, 255, 255, 255, false)
                i = i + 1
            end
        end
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 4)
    DisplayText(str, x, y)
end

RegisterCommand('garmas', function()
    RemoveAllPedWeapons(PlayerPedId(), true, true)
end, false)

-- uParam0->f_18 = GRAPHICS::START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_mg_fishing_drips", Global_1902942->f_5.f_7, 0f, 0f, 0f, 0f, 0f, 0f, ENTITY::GET_ENTITY_BONE_INDEX_BY_NAME(Global_1902942->f_5.f_7, "SKEL_Tail5"), 1065353216, 0, 0, 0);
-- 	GRAPHICS::SET_PARTICLE_FX_LOOPED_EVOLUTION(uParam0->f_18, "fade", uParam0->f_19, false);
-- GRAPHICS::START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_mg_fish_struggle", vVar0, 0f, 0f, MISC::GET_RANDOM_FLOAT_IN_RANGE(0f, 360f), fVar3, 0, 0, 0);

-- if (!ENTITY::_0x0C9DBF48C6BA6E4C(PLAYER::PLAYER_PED_ID(),VCETOR3 vVar0, 1))

-- 0x53187E563F938E76
-- FISH MODEL SIZE??

-- ENTITY::_0x978AA2323ED32209(Local_5.f_5, 0f);
