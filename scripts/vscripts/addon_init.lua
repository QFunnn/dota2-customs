--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- ═══════════════════════════════════════════════════════════════════════════
--  ЕДИНЫЙ ГЕЙТ ВСЕХ print() МОДА.
--  Перехватываем глобальный print ОДИН раз, до любого его вызова. Дальше весь
--  код мода печатает как обычно, но реальный вывод в console идёт ТОЛЬКО когда
--  DEBUG_PRINT_STATUS == true (значение задаётся в constants/main.lua).
--  На проде (false) — ноль console-I/O на игровом сервере. В тулзах/локалке
--  ставишь true и видишь все принты (диагностику и ошибки).
-- ═══════════════════════════════════════════════════════════════════════════
do
    local _engine_print = print
    -- Сырой движковый print в обход гейта: для диагностики, которая должна печататься
    -- без включения DEBUG_PRINT_STATUS и гейтит себя сама (probe zxc_sec_probe — только в тулзах).
    _ENGINE_PRINT_RAW = _engine_print
    print = function(...)
        if DEBUG_PRINT_STATUS then _engine_print(...) end
    end
end

--- Позволяет линкануть сразу несколько модифаеров
function LinkModifiers(Modifiers)
    for _, Modififer in ipairs(Modifiers) do
        -- print("Link modifier: " .. Modififer[1])
        LinkLuaModifier(Modififer[1], Modififer[2], Modififer[3])
    end
end

--- Позволяет загрузить и выполнить модули
function RequireFiles(Files)
    for _, File in ipairs(Files) do
        print("Require file: " .. File .. " IsClient - " .. tostring(IsClient()))
        require(File)
    end
end

RequireFiles({
    "constants/main",
    "constants/ability_exclusions",
})

-- Обёртка AddNewModifier: применяет debuff_amplify кастера и status_resistance цели к длительности дебаффов
if IsServer() then
    local OriginalAddNewModifier = CDOTA_BaseNPC.AddNewModifier
    CDOTA_BaseNPC.AddNewModifier = function(self, caster, ability, modifier_name, params)
        if params and params.duration and params.duration > 0 and caster and not caster:IsNull() and self and not self:IsNull() then
            if caster:GetTeamNumber() ~= self:GetTeamNumber() then
                local duration = params.duration

                -- Debuff amplify кастера (увеличивает длительность)
                local skills_modifier = caster:FindModifierByName("modifier_skills_bonuses")
                if skills_modifier and skills_modifier.GetValue then
                    local debuff_amplify = skills_modifier:GetValue("debuff_amplify")
                    if debuff_amplify > 0 then
                        duration = duration * (1 + debuff_amplify / 100)
                    end
                end

                -- Status resistance цели (уменьшает длительность)
                local status_resistance = self:GetStatusResistance()
                if status_resistance > 0 then
                    duration = duration * (1 - status_resistance)
                end

                params.duration = duration
            end
        end
        return OriginalAddNewModifier(self, caster, ability, modifier_name, params)
    end
end

if IsClient() then
    RequireFiles({
        "utils/client_utils",
        "utils/skill_list"
    })
end

ListenToGameEvent("client_side_server_command", function (data, event)
    if IsClient() then
        SendToConsole(data.command)
    end
end, nil)

LinkModifiers({
    {"modifier_faceless_void_time_lock_custom_scepter", "heroes/hero_void/faceless_void_time_lock_custom", LUA_MODIFIER_MOTION_NONE},
    {"modifier_necrophos_scythe_creep", "heroes/modifier_necrophos_scythe_creep", LUA_MODIFIER_MOTION_NONE},
    {"modifier_bounty_hunter_track_creep", "heroes/modifier_bounty_hunter_track_creep", LUA_MODIFIER_MOTION_NONE},
    {"modifier_item_moon_shard_buff_custom", "modifiers/modifier_item_moon_shard_buff_custom", LUA_MODIFIER_MOTION_NONE},
    {"modifier_sand_king_caustic_finale_lua_debuff", "heroes/hero_sandking/modifier_sand_king_caustic_finale_lua_debuff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_abilities_optimization_thinker", "modifiers/modifier_abilities_optimization_thinker", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_refreshing", "heroes/modifier_hero_refreshing", LUA_MODIFIER_MOTION_NONE},
    {"modifier_clinkz_skeletons", "heroes/hero_clinkz/modifier_clinkz_skeletons", LUA_MODIFIER_MOTION_NONE},
    {"modifier_stranger_test", "modifiers/modifier_stranger_test", LUA_MODIFIER_MOTION_NONE},
    {"modifier_debug_creep_damage_tracker", "modifiers/modifier_debug_creep_damage_tracker", LUA_MODIFIER_MOTION_NONE},
    {"modifier_aegis_buff_rebirth", "modifiers/modifier_aegis_buff_rebirth", LUA_MODIFIER_MOTION_NONE},
    {"modifier_duel_curse", "modifiers/modifier_duel_curse", LUA_MODIFIER_MOTION_NONE},
    {"modifier_duel_curse_cooldown", "modifiers/modifier_duel_curse", LUA_MODIFIER_MOTION_NONE},
    {"modifier_skill_call_of_the_ancient_buff", "modifiers/modifier_skill_call_of_the_ancient", LUA_MODIFIER_MOTION_NONE},
    {"modifier_loser_curse", "heroes/modifier_loser_curse", LUA_MODIFIER_MOTION_NONE},
    {"modifier_report_curse", "modifiers/modifier_report_curse", LUA_MODIFIER_MOTION_NONE},
    {"modifier_report_warning", "modifiers/modifier_report_warning", LUA_MODIFIER_MOTION_NONE},
    {"modifier_duel_teleporting", "heroes/modifier_duel_teleporting", LUA_MODIFIER_MOTION_NONE},
    {"modifier_duel_teleporting_2", "heroes/modifier_duel_teleporting", LUA_MODIFIER_MOTION_NONE},
    {"modifier_aegis", "heroes/modifier_aegis", LUA_MODIFIER_MOTION_NONE},
    {"modifier_aegis_buff", "heroes/modifier_aegis_buff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_skywrath_mage_shard_lua", "heroes/hero_skywrath_mage/modifier_skywrath_mage_shard_lua", LUA_MODIFIER_MOTION_NONE},
    {"modifier_skywrath_mage_shard_bonus_counter_lua", "heroes/hero_skywrath_mage/modifier_skywrath_mage_shard_lua", LUA_MODIFIER_MOTION_NONE},
    {"modifier_spell_amplify_controller", "heroes/modifier_spell_amplify_controller", LUA_MODIFIER_MOTION_NONE},
    {"modifier_gyrocopter_flak_cannon_lua_scepter", "heroes/hero_gyrocopter/gyrocopter_flak_cannon_lua", LUA_MODIFIER_MOTION_NONE},
    {"modifier_cha_vision", "modifiers/modifier_cha_vision", LUA_MODIFIER_MOTION_NONE},
    {"modifier_cha_high_cooldown", "modifiers/modifier_cha_high_cooldown", LUA_MODIFIER_MOTION_NONE},
    {"modifier_gaben_int_fixed", "modifiers/modifier_gaben_int_fixed", LUA_MODIFIER_MOTION_NONE},
    {"modifier_base_attack_speed_custom", "modifiers/modifier_base_attack_speed_custom", LUA_MODIFIER_MOTION_NONE},
    {"modifier_cashback_creep_count", "modifiers/modifier_cashback_creep_count", LUA_MODIFIER_MOTION_NONE},
    {"modifier_centaur_return_unique_buff", "modifiers/modifier_centaur_return_unique_buff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_primal_beast_uproar_custom_creep", "modifiers/modifier_primal_beast_uproar_custom_creep", LUA_MODIFIER_MOTION_NONE},
    {"modifier_stunned_without_anim", "modifiers/modifier_stunned_without_anim", LUA_MODIFIER_MOTION_NONE},
    {"modifier_tiny_grow_custom", "modifiers/modifier_tiny_grow_custom", LUA_MODIFIER_MOTION_NONE},
    {"modifier_creep_spawner_cha_ready", "modifiers/modifier_creep_spawner_cha_ready", LUA_MODIFIER_MOTION_NONE},
    {"modifier_creep_controll", "modifiers/modifier_creep_controll", LUA_MODIFIER_MOTION_NONE},
    {"modifier_creep_controll_berserk_debuff", "modifiers/modifier_creep_controll", LUA_MODIFIER_MOTION_NONE},
    {"modifier_skills_bonuses", "modifiers/modifier_skills_bonuses", LUA_MODIFIER_MOTION_NONE},
    {"modifier_magic_immune_buff", "modifiers/modifier_magic_immune_buff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_grimstroke_soul_chain_creep", "modifiers/modifier_grimstroke_soul_chain_creep", LUA_MODIFIER_MOTION_NONE},
    {"modifier_grimstroke_soul_chain_debuff_custom", "modifiers/modifier_grimstroke_soul_chain_creep", LUA_MODIFIER_MOTION_NONE},
    {"modifier_magical_critical_strike_custom", "modifiers/modifier_magical_critical_strike_custom", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_alchemist_concotion", "modifiers/hero_unique/modifier_hero_unique_modifier_alchemist_concotion", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_mars_gods_rebuke", "modifiers/hero_unique/modifier_hero_unique_modifier_mars_gods_rebuke", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_dragon_knight_breathe_fire", "modifiers/hero_unique/modifier_hero_unique_modifier_dragon_knight_breathe_fire", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_skywrath_mage_concussive_shot", "modifiers/hero_unique/modifier_hero_unique_modifier_skywrath_mage_concussive_shot", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_skeleton_king_hellfire_blast", "modifiers/hero_unique/modifier_hero_unique_modifier_skeleton_king_hellfire_blast", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_templar_assassin_meld", "modifiers/hero_unique/modifier_hero_unique_modifier_templar_assassin_meld", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_chaos_knight_chaos_bolt", "modifiers/hero_unique/modifier_hero_unique_modifier_chaos_knight_chaos_bolt", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_tinker_defense_matrix", "modifiers/hero_unique/modifier_hero_unique_modifier_tinker_defense_matrix", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_abaddon_aphotic_shield", "modifiers/hero_unique/modifier_hero_unique_modifier_abaddon_aphotic_shield", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_riki_backstab_custom", "modifiers/hero_unique/modifier_hero_unique_modifier_riki_backstab_custom", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_phantom_assassin_phantom_strike", "modifiers/hero_unique/modifier_hero_unique_modifier_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_clinkz_strafe", "modifiers/hero_unique/modifier_hero_unique_modifier_clinkz_strafe", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_spectre_spectral_dagger", "modifiers/hero_unique/modifier_hero_unique_modifier_spectre_spectral_dagger", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_slark_dark_pact", "modifiers/hero_unique/modifier_hero_unique_modifier_slark_dark_pact", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_enchantress_natures_attendants", "modifiers/hero_unique/modifier_hero_unique_modifier_enchantress_natures_attendants", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_weaver_shukuchi", "modifiers/hero_unique/modifier_hero_unique_modifier_weaver_shukuchi", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_troll_warlord_berserkers_rage", "modifiers/hero_unique/modifier_hero_unique_modifier_troll_warlord_berserkers_rage", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_nevermore_dark_lord", "modifiers/hero_unique/modifier_hero_unique_modifier_nevermore_dark_lord", LUA_MODIFIER_MOTION_NONE},
    {"modifier_nevermore_presence_amp", "heroes/hero_nevermore/modifier_nevermore_talents", LUA_MODIFIER_MOTION_NONE},
    {"modifier_nevermore_presence_amp_debuff", "heroes/hero_nevermore/modifier_nevermore_talents", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_dazzle_poison_touch", "modifiers/hero_unique/modifier_hero_unique_modifier_dazzle_poison_touch", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_queenofpain_scream_of_pain", "modifiers/hero_unique/modifier_hero_unique_modifier_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_earthshaker_enchant_totem", "modifiers/hero_unique/modifier_hero_unique_modifier_earthshaker_enchant_totem", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_spirit_breaker_bulldoze", "modifiers/hero_unique/modifier_hero_unique_modifier_spirit_breaker_bulldoze", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_ursa_overpower", "modifiers/hero_unique/modifier_hero_unique_modifier_ursa_overpower", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_elder_titan_natural_order", "modifiers/hero_unique/modifier_hero_unique_modifier_elder_titan_natural_order", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_alchemist_corrosive_weaponry", "modifiers/hero_unique/modifier_hero_unique_modifier_alchemist_corrosive_weaponry", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_enchantress_impetus", "modifiers/hero_unique/modifier_hero_unique_modifier_enchantress_impetus", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_antimage_blink", "modifiers/hero_unique/modifier_hero_unique_modifier_antimage_blink", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_antimage_blink_debuff", "modifiers/hero_unique/modifier_hero_unique_modifier_antimage_blink", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_shredder_reactive_armor", "modifiers/hero_unique/modifier_hero_unique_modifier_shredder_reactive_armor", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_shredder_reactive_armor_debuff", "modifiers/hero_unique/modifier_hero_unique_modifier_shredder_reactive_armor", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_abaddon_death_coil", "modifiers/hero_unique/modifier_hero_unique_modifier_abaddon_death_coil", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_modifier_nyx_assassin_burrow", "modifiers/hero_unique/modifier_hero_unique_modifier_nyx_assassin_burrow", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_unique_warlock_golem", "modifiers/hero_unique/modifier_hero_unique_warlock_golem", LUA_MODIFIER_MOTION_NONE},
    -- {"modifier_noxious_plague_controller", "heroes/hero_venomancer/noxious_plague_controller", LUA_MODIFIER_MOTION_NONE},
    {"modifier_roshan_map", "modifiers/modifier_roshan_map", LUA_MODIFIER_MOTION_NONE},
    {"modifier_cha_top_rating", "modifiers/modifier_cha_top_rating", LUA_MODIFIER_MOTION_NONE},
    {"modifier_cha_high_five", "modifiers/modifier_cha_high_five", LUA_MODIFIER_MOTION_NONE},
    {"modifier_dummy", "modifiers/modifier_dummy", LUA_MODIFIER_MOTION_NONE},
    {"modifier_test_nears", "modifiers/modifier_test_nears", LUA_MODIFIER_MOTION_NONE},
    {"modifier_special_bonus_custom_debuff_amp_15", "modifiers/modifier_special_bonus_custom_debuff_amp_15", LUA_MODIFIER_MOTION_NONE},
    {"modifier_special_bonus_cha_obsidian_destroyer", "modifiers/modifier_special_bonus_cha_obsidian_destroyer", LUA_MODIFIER_MOTION_NONE},
    {"modifier_special_bonus_cha_ogre_magi", "modifiers/modifier_special_bonus_cha_ogre_magi", LUA_MODIFIER_MOTION_NONE},
    {"modifier_ogre_magi_fireblast_proc", "modifiers/modifier_ogre_magi_fireblast_proc", LUA_MODIFIER_MOTION_NONE},
    {"modifier_special_bonus_custom_attack_range_150", "modifiers/modifier_special_bonus_custom_attack_range_150", LUA_MODIFIER_MOTION_NONE},
    {"modifier_arenas_pre_stun", "modifiers/modifier_arenas_pre_stun", LUA_MODIFIER_MOTION_NONE},
    {"modifier_boss_controller", "modifiers/modifier_boss_controller", LUA_MODIFIER_MOTION_NONE},
    {"modifier_minigames_win_buff", "modifiers/modifier_minigames_win_buff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_hero_change", "modifiers/modifier_hero_change", LUA_MODIFIER_MOTION_NONE},
    {"modifier_mass_arena_player", "modifiers/modifier_mass_arena_player", LUA_MODIFIER_MOTION_NONE},
    {"modifier_minigames_unit", "modifiers/modifier_minigames_unit", LUA_MODIFIER_MOTION_NONE},
    {"modifier_minigames_arena", "modifiers/modifier_minigames_arena", LUA_MODIFIER_MOTION_NONE},
    {"modifier_minigames_pudge", "modifiers/modifier_minigames_pudge", LUA_MODIFIER_MOTION_NONE},
    {"modifier_minigames_mirana", "modifiers/modifier_minigames_mirana", LUA_MODIFIER_MOTION_NONE},
    {"modifier_minigames_circle_debuff", "modifiers/modifier_minigames_circle_debuff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_mass_arena_circle_debuff", "modifiers/modifier_mass_arena_circle_debuff", LUA_MODIFIER_MOTION_NONE},
    {"modifier_player_controller", "modifiers/modifier_player_controller", LUA_MODIFIER_MOTION_NONE},
    {"modifier_custom_truesight", "modifiers/modifier_custom_truesight", LUA_MODIFIER_MOTION_NONE},
    -- {"modifier_custom_truesight_aura", "modifiers/modifier_custom_truesight", LUA_MODIFIER_MOTION_NONE},
    {"modifier_player_cosmetics", "modifiers/modifier_player_cosmetics", LUA_MODIFIER_MOTION_NONE},
    {"modifier_player_cosmetics_pet", "modifiers/modifier_player_cosmetics", LUA_MODIFIER_MOTION_NONE},
    {"modifier_techies_mines_health_pips", "modifiers/modifier_techies_mines_health_pips", LUA_MODIFIER_MOTION_NONE},
    {"modifier_summon_invulnerable", "modifiers/modifier_summon_invulnerable", LUA_MODIFIER_MOTION_NONE},
})