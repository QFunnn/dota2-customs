--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("wearables_system/configs")

function Spawn()
    if not IsClient() then return end
    if not _G.PLAYER_PORTRAIT_UNIT then return end
    if _G.PLAYER_PORTRAIT_UNIT == -1 then return end
    local unit = EntIndexToHScript(_G.PLAYER_PORTRAIT_UNIT)
    if unit == nil then return end
    if unit:IsNull() then return end
    if not unit:IsHero() then return end
    local unit_name = unit and unit.GetUnitName and unit:GetUnitName()
    if unit_name == nil then return end
    if unit_name == "npc_dota_hero_target_dummy" then return end
    if not _G.added_shop_heroes[unit_name] then return end
    local portrait_model = DEFAULT_MODELS_HEROES[unit_name]
    if not portrait_model then return end
    if portrait_model == "models/new_models/slark/slark.vmdl" then
        portrait_model = "models/heroes/slark/slark.vmdl"
    end
    if portrait_model == "models/muerta/muerta.vmdl" then
        portrait_model = "models/heroes/muerta/muerta_base.vmdl"
    end
    if unit:HasModifier("modifier_night_stalker_innate_custom_active") then
        portrait_model = "models/heroes/nightstalker/nightstalker_night.vmdl"
    end
    if not _G.HEROES_DATA_ITEMS_CLIENT[unit_name] then
        _G.HEROES_DATA_ITEMS_CLIENT[unit_name] = require("wearables_system/items_list/"..unit_name)
    end
    if not _G.DEFAULT_PORTRAITS_CUSTOM_DATA then
        _G.DEFAULT_PORTRAITS_CUSTOM_DATA = LoadKeyValues("scripts/npc/portraits.txt")
    end
    if not _G.DEFAULT_PORTRAITS_CUSTOM_OTHERS_DATA then
        _G.DEFAULT_PORTRAITS_CUSTOM_OTHERS_DATA = LoadKeyValues("scripts/vscripts/client/portraits_others.txt")
    end
    if not _G.DEFAULT_LIGHT_DATA_CUSTOM then
        _G.DEFAULT_LIGHT_DATA_CUSTOM = LoadKeyValues("scripts/vscripts/client/light_custom.txt")
    end
    local portraits = _G.DEFAULT_PORTRAITS_CUSTOM_DATA
    local portraits_others = _G.DEFAULT_PORTRAITS_CUSTOM_OTHERS_DATA
    local light_new_data = _G.DEFAULT_LIGHT_DATA_CUSTOM
    local is_tempest = false
    local new_camera_data = nil
    if unit:HasModifier("modifier_arc_warden_tempest_double_custom") then
        is_tempest = true
    end

    local unit_data =
    {
        targetname = "hero_model",
        model = portrait_model,
        MapUnitName = unit_name,
        spawn_wearable_item_defs = "1",
        item_def0 = "0",
        item_def1 = "0",
        item_def2 = "0",
        item_def3 = "0",
        origin = "100000 0 0",
        angles = "0 0 0",
        suppress_intro_effects = "1",
        ModelScale = "1",
        activity = "ACT_DOTA_CAPTURE",
        m_iTeamNum = "2",
        StartDisabled = "0",
        EnableAutoStyles = "0",
        spawn_background_models = "0",
        skip_background_entities = "0",
        ModelScale = "1",
    }

    if _G.AllItemsData[unit:GetPlayerOwnerID()] ~= nil then
        local item_num = 0
        for k, item_id in pairs(_G.AllItemsData[unit:GetPlayerOwnerID()]) do
            local is_ambient = false
            if _G.HEROES_DATA_ITEMS_CLIENT[unit_name] and _G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)] then
                if #_G.AllItemsData[unit:GetPlayerOwnerID()] >= 7 and string.find(_G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_slot, "ambient") then
                    is_ambient = true
                end
                if string.find(_G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_slot, "ability") then
                    is_ambient = true
                end
                if unit_name == "npc_dota_hero_alchemist" and (_G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_slot == "weapon" or _G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_slot == "arms" or _G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_slot == "offhand_weapon") then
                    is_ambient = true
                end
                if unit_name == "npc_dota_hero_arc_warden" then
                    if string.find(_G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_slot, "arms") then
                        is_ambient = true
                    end
                end
            end
            if not is_ambient then
                unit_data["item_def"..item_num] = tostring(item_id)
                if _G.HEROES_DATA_ITEMS_CLIENT[unit_name] and _G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)] then
                    local another_model = _G.HEROES_DATA_ITEMS_CLIENT[unit_name][tostring(item_id)].item_hero_model
                    if another_model then
                        unit_data.model = another_model
                    end
                end
                if _G.AllItemsStyles[unit:GetPlayerOwnerID()] ~= nil then
                    if _G.AllItemsStyles[unit:GetPlayerOwnerID()][tostring(item_id)] ~= nil then
                        unit_data["style_index"..item_num] = _G.AllItemsStyles[unit:GetPlayerOwnerID()][tostring(item_id)]
                    end
                end
                item_num = item_num + 1
            end
            if portraits_others and portraits_others[tostring(item_id)] then
                new_camera_data = portraits_others[tostring(item_id)]
            end
        end
    end

    if light_new_data[unit_data.model] and light_new_data[unit_data.model].camera_offsetX then
        local result = tostring(100000 + light_new_data[unit_data.model].camera_offsetX).." "..light_new_data[unit_data.model].camera_offsetY.." "..light_new_data[unit_data.model].camera_offsetZ
       unit_data.origin = tostring(result)
    end

    local portrait = SpawnEntityFromTableSynchronous("portrait_world_unit", unit_data)
    --local portrait = SpawnEntityFromTableSynchronous("dota_portrait_entity", unit_data)
    --DeepPrintTable(getmetatable(portrait))

    local function split( inputStr, delimiter )
        local d = delimiter or '%s' 
        local t={} 
        for field,s in string.gmatch(inputStr, "([^"..delimiter.."]*)("..delimiter.."?)") do 
            table.insert(t,field) 
            if s=="" then 
                return t 
            end 
        end
    end

    if portraits and portraits[unit_data.model] or (portraits_others and portraits_others[unit_data.model]) then
        local light_hero_info = portraits[unit_data.model]
        if portraits_others and portraits_others[unit_data.model] then
            light_hero_info = portraits_others[unit_data.model]
        end
        if new_camera_data then
            light_hero_info = new_camera_data
        end
        local vectors_light = split(light_hero_info["PortraitLightPosition"], " ")
        local new_vector_light = tostring((tonumber(vectors_light[1])+100000)) .. " " .. vectors_light[2] .. " " .. vectors_light[3]
        --Свет для кастомного героя
        local light_data =
        {
            origin = new_vector_light,
            angles = light_hero_info["PortraitLightAngles"],
            fov = light_hero_info["PortraitLightFOV"],
            nearz = light_hero_info["PortraitLightDistance"],

            -- КЛЮЧЕВОЙ МОМЕНТ
            color = light_hero_info["PortraitLightColor"],
            lightscale = light_hero_info["PortraitLightScale"],

            -- AMBIENT = PortraitLightColor
            ambientangles = light_hero_info["PortraitAmbientDirection"],
            ambientcolor1 = light_hero_info["PortraitAmbientColor"],
            ambientscale1 = light_hero_info["PortraitAmbientScale"],

            -- ТЕНИ
            ambientcolor2 = light_hero_info["PortraitShadowColor"],
            ambientscale2 = light_hero_info["PortraitShadowScale"],
            ambientcolor3 = light_hero_info["PortraitShadowColor"],

            -- SPECULAR
            specularcolor = light_hero_info["PortraitSpecularColor"].." 255",
            specularpower = light_hero_info["PortraitSpecularPower"],
            specularindependence = "1",
            groundscale = light_hero_info["PortraitGroundShadowScale"],
        }

        if light_new_data[unit_data.model] then
            light_data = 
            {
                origin = new_vector_light,
                angles = light_new_data[unit_data.model]["angles"],
                ambientangles = light_new_data[unit_data.model]["ambientangles"],
                color = light_new_data[unit_data.model]["color"],
                lightscale = light_new_data[unit_data.model]["lightscale"],
                ambientcolor1 = light_new_data[unit_data.model]["ambientcolor1"],
                ambientscale1 = light_new_data[unit_data.model]["ambientscale1"],
                ambientcolor2 = light_new_data[unit_data.model]["ambientcolor2"],
                ambientscale2 = light_new_data[unit_data.model]["ambientscale2"],
                groundscale = light_new_data[unit_data.model]["groundscale"],
                specularangles = light_new_data[unit_data.model]["specularangles"],
                specularpower = light_new_data[unit_data.model]["specularpower"],
                specularcolor = light_new_data[unit_data.model]["specularcolor"],
                fov = light_new_data[unit_data.model]["fov"],
                nearz = light_new_data[unit_data.model]["nearz"],
                enableshadows = light_new_data[unit_data.model]["enableshadows"],
                fow_darkness = light_new_data[unit_data.model]["fow_darkness"],
                ambientcolor3 = light_new_data[unit_data.model]["ambientcolor3"],
                specularindependence = light_new_data[unit_data.model]["specularindependence"],
            }
        end
        
        light_data.targetname = "main_light"
        local light = SpawnEntityFromTableSynchronous("env_global_light", light_data)
        local fow_add = 3
        local cameras_table = light_hero_info["cameras"]
        for camera_name, camera_info in pairs(cameras_table) do
            local vectors = split(camera_info["PortraitPosition"], " ")
            local new_vector = tostring((tonumber(vectors[1])+100000)) .. " " .. vectors[2] .. " " .. vectors[3]
            SpawnEntityFromTableSynchronous("point_camera", 
            {
                targetname = camera_name,
                origin = new_vector,
                angles = camera_info["PortraitAngles"],
                fov = tostring(tonumber(camera_info["PortraitFOV"])+fow_add),
                zfar = "1000",
                ZNear = "4",
                UseScreenAspectRatio = "0",
                aspectRatio = "1",
                fogEnable = "0",
                fogColor = "0 0 0",
                fogStart = "2048",
                fogEnd = "4096",
                fogMaxDensity = "1",
                rendercolor = "128 128 128",
                hltvUsable = "0",
                override_shadow_farz = "0",
                dof_enabled = "0",
                dof_near_blurry = "250",
                dof_near_crisp = "550",
                dac_dof_far_crisp = "1200",
                dac_dof_far_blurry = "1600",
                dac_dof_tilt_to_ground = "0.75",
            })
        end
        
        if unit_name == "npc_dota_hero_lina" then
            local pfx = SpawnEntityFromTableSynchronous("info_particle_system", {
                effect_name = "particles/units/heroes/hero_lina/portrait_lina.vpcf",
                origin = "100000 0 0",
                start_active = "1",
                cpoint1 = "hero_model",
            })
        end

        if unit_name == "npc_dota_hero_juggernaut" then
            local pfx = SpawnEntityFromTableSynchronous("info_particle_system", {
                effect_name = "particles/units/heroes/hero_juggernaut/juggernaut_portrait.vpcf",
                origin = "100000 0 0",
                start_active = "1",
                cpoint1 = "hero_model",
            })
        end

        if unit_name == "npc_dota_hero_morphling" then
            local prop_data =
            {
                origin = "99920 60 60",
                ["scales"] = "0.9 0.9 0.9",
                ["local.scales"] = "1 1 1",
                model = "models/morph_bg.vmdl",
                parentname = "body",
                clientSideEntity = "1",
                useLocalOffset = "1",
            }
            local prop = SpawnEntityFromTableSynchronous("prop_dynamic", prop_data)
        end

        --local ent = Entities:First() --but what if worldspawn
        --while ent do
        --    print(ent:GetClassname())
        --    ent = Entities:Next(ent)
        --end
    end
end