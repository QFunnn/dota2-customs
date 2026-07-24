--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_BaseNPC:RemoveAllDefaultItems()
    local hero_name = self:GetUnitName()
    local children = self:GetChildren()
    wearables_system:CheckingUniqueArcaneItems(self)
    for k, child in pairs(children) do
        if child and child:GetClassname() == "dota_item_wearable" then
            local model_name = child:GetModelName()
            if model_name ~= "" and wearables_system.items_data_slots[hero_name] and wearables_system.items_data_slots[hero_name][model_name] then
                wearables_system:SaveDefaultItemsData(hero_name, wearables_system.items_data_slots[hero_name][model_name], model_name, child:GetMaterialGroupHash())
            end
            UTIL_Remove(child)
        end
    end
    for slot_name, _ in pairs(wearables_system.full_slots_for_hero[hero_name]) do
        wearables_system:SaveDefaultItemsData(hero_name, slot_name, "none_model", "0")
    end
end

function CDOTA_BaseNPC:GetPlayerWearables()
    local items_list = {}
    if self.items_list then
        for _, item_handle in pairs(self.items_list) do
            if item_handle and IsValid(item_handle) then
                table.insert(items_list, item_handle)
            end
        end
    end
    return items_list
end

function CDOTA_BaseNPC:HasUnequipItem(item_id_f)
    if self.items_list_ids then
        for _, item_id in pairs(self.items_list_ids) do
            if tonumber(item_id) == item_id_f then
                return true
            end
        end
    end
    return false
end

function CDOTA_BaseNPC:GetIllusionCopyData()
    local unit_name = self:GetUnitName()
    for _, player in pairs(players) do 
        if IsValid(player) and player:GetUnitName() == unit_name then
            return player:GetId()
        end
    end
    return nil
end

function CDOTA_BaseNPC:GetTerrorbladeColor()
    if self:HasUnequipItem(5957) then
        for item_id, color in pairs(TERRORBLADE_COLORS_IDS) do
            if self:HasUnequipItem(tonumber(item_id)) then
                return color
            end
        end
        return Vector(255,60,40)
    end
    return nil
end

function CDOTA_BaseNPC:GetTerrorbladeNumber()
    if self:HasUnequipItem(5957) then
        for item_id, color in pairs(TERRORBLADE_ID_IDS) do
            if self:HasUnequipItem(tonumber(item_id)) then
                return color
            end
        end
        return 1
    end
    return nil
end

function wearables_system:GetParticleReplacement(unit, particle_name)
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return particle_name end
    local pct_replace = replacement_info.particle_replace[particle_name] 
    if pct_replace then
        return pct_replace
    end
    return particle_name
end

function wearables_system:GetAbilityIconTry(ability_handle)
    if ability_handle.GetAbilityName then
        return ability_handle:GetAbilityName()
    elseif ability_handle.GetAbility then
        if ability_handle:GetAbility() and ability_handle:GetAbility().GetAbilityName then
            return ability_handle:GetAbility():GetAbilityName()
        end
    end
    return nil
end

function wearables_system:GetParticleReplacementAbility(unit, particle_name, ability_handle, ability_name_new)
    local ability_name = nil
    if ability_name_new then
        ability_name = ability_name_new
    end
    if ability_handle and ability_name == nil then
        ability_name = wearables_system:GetAbilityIconTry(ability_handle)
    end
    if ability_name then
        local replacement_ability = self.ReplacementInfoEffects[unit:GetUnitName()]
        if replacement_ability then
            if replacement_ability.particle_replace[ability_name] then
                local particle_data = replacement_ability.particle_replace[ability_name][particle_name]
                if particle_data then
                    return particle_data
                end
            end
        end
    end
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return particle_name end
    local pct_replace = replacement_info.particle_replace[particle_name] 
    if pct_replace then
        return pct_replace
    end
    return particle_name
end

function wearables_system:GetSoundReplacement(unit, sound_name, ability_handle)
    local ability_name = nil
    if ability_handle then
        ability_name = wearables_system:GetAbilityIconTry(ability_handle)
    end
    if ability_name then
        local replacement_ability = self.ReplacementInfoEffects[unit:GetUnitName()]
        if replacement_ability then
            if replacement_ability.sound_replace[ability_name] then
                local sound_data = replacement_ability.sound_replace[ability_name][sound_name]
                if sound_data then
                    return sound_data
                end
            end
        end
    end
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return sound_name end
    local sound_replace = replacement_info.sound_replace[sound_name] 
    if sound_replace then
        return sound_replace
    end
    return sound_name
end

function wearables_system:GetUnitModelReplacement(unit, unit_name, ability_handle)
    local ability_name = nil
    if ability_handle then
        ability_name = wearables_system:GetAbilityIconTry(ability_handle)
    end
    if ability_name then
        local replacement_ability = self.ReplacementInfoEffects[unit:GetUnitName()]
        if replacement_ability then
            if replacement_ability.models[ability_name] then
                local unit_data = replacement_ability.models[ability_name][unit_name]
                if unit_data then
                    return unit_data
                end
            end
        end
    end
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return nil end
    local model = replacement_info.models[unit_name] 
    if model then
        return model
    end
    return nil
end

function wearables_system:GetModelRefitsReplacement(unit, model_name)
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return model_name end
    local model = replacement_info.models_refits[model_name] 
    if model then
        return model
    end
    return model_name
end

function wearables_system:CopyTable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[wearables_system:CopyTable(orig_key)] = wearables_system:CopyTable(orig_value)
        end
        setmetatable(copy, wearables_system:CopyTable(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function CDOTA_BaseNPC:GetItemWearableHandle(slot_name)
    if self.items_list and self.items_list[slot_name] then
        return self.items_list[slot_name]
    end
    return nil
end

function CDOTA_BaseNPC:GetItemStyle(item_id_original)
    if wearables_system.ITEMS_DATA and wearables_system.ITEMS_DATA[self:GetUnitName()] and wearables_system.ITEMS_DATA[self:GetUnitName()][item_id_original] then
        return wearables_system.ITEMS_DATA[self:GetUnitName()][item_id_original].ItemStyle
    end
    return "0"
end

function wearables_system.remove_item(tbl,item) -- Удалить итем
    local i,max=1,#tbl
    while i<=max do
        if tbl[i] == item then
            table.remove(tbl,i)
            i = i-1
            max = max-1
        end
        i= i+1
    end
    return tbl
end

function wearables_system:CheckingUniqueArcaneItems(hero)
    local hero_name = hero:GetUnitName()
    local player_id = hero:GetPlayerOwnerID()

    if hero and (hero:GetModelName() == "models/heroes/pudge_cute/pudge_cute.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 999251)) then
        print("[wearables_system] " .. "У игрока есть персона на пудг в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 999251
    elseif hero and (hero:GetModelName() == "models/items/pudge/arcana/pudge_arcana_base.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "hero_base", 7756)) then
        print("[wearables_system] " .. "У игрока есть аркана на пуджа в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["hero_base"] = 7756
    end
    
    if hero and (hero:GetModelName() == "models/heroes/juggernaut/juggernaut_arcana.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "hero_base", 9059)) then
        print("[wearables_system] " .. "У игрока есть аркана на джагернаута в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["hero_base"] = 9059
    end
    if hero and (hero:GetModelName() == "models/items/axe/ti9_jungle_axe/axe_bare.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "weapon", 12964)) then
        print("[wearables_system] " .. "У игрока есть персона на акса в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["weapon"] = 12964
    end
    if hero and (hero:GetModelName() == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "hero_base", 13670)) then
        print("[wearables_system] " .. "У игрока есть аркана на огра в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["hero_base"] = 13670
    end
    if hero and (hero:GetModelName() == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "hero_base", 6996)) then
        print("[wearables_system] " .. "У игрока есть аркана на огра в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["hero_base"] = 6996
    end
    if hero and (hero:GetModelName() == "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 26559)) then
        print("[wearables_system] " .. "У игрока есть персона на цм в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 26559
    end
    if hero and (hero:GetModelName() == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 4480)) then
        print("[wearables_system] " .. "У игрока есть персона на фантомка в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 4480
    end
    if hero and (hero:GetModelName() == "models/heroes/antimage_female/antimage_female.vmdl" or hero:GetModelName() == "models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin.vmdl" or hero:GetModelName() == "models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin_rainbow.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 13783)) then
        print("[wearables_system] " .. "У игрока есть персона на антимаг в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 13783
    end
    if hero and (hero:GetModelName() == "models/heroes/invoker_kid/invoker_kid.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 13042)) then
        print("[wearables_system] " .. "У игрока есть персона на инвокер в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 13042
    end
    if hero and (hero:GetModelName() == "models/items/axe/axe_carnival/axe_carnival_base.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 31367)) then
        print("[wearables_system] " .. "У игрока есть персона на фантомка в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 31367
    end
    if hero and (hero:GetModelName() == "models/items/legion_commander/dark_carnival_legion_commander/dark_carnival_legion_commander_base.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 36191)) then
        print("[wearables_system] " .. "У игрока есть персона на фантомка в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 36191
    end
    if hero and (hero:GetModelName() == "models/items/morphling/morphling_automaton/morphling_automaton.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 36193)) then
        print("[wearables_system] " .. "У игрока есть персона на фантомка в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 36193
    end
    if hero and (hero:GetModelName() == "models/items/bristleback/bristlebot/bristlebot.vmdl" or wearables_system:HasStartSelectionItem(player_id, hero_name, "persona_selector", 36214)) then
        print("[wearables_system] " .. "У игрока есть персона на фантомка в доте")
        wearables_system.DEFAULT_ITEMS_IDS[hero_name]["persona_selector"] = 36214
    end
end

function wearables_system:HasStartSelectionItem(player_id, hero_name, item_slot_type, item_id)
    if wearables_system.selection_data[player_id] and wearables_system.selection_data[player_id][hero_name] and wearables_system.selection_data[player_id][hero_name][item_slot_type] ~= nil then
        return tonumber(wearables_system.selection_data[player_id][hero_name][item_slot_type]) == item_id
    end
    return false
end