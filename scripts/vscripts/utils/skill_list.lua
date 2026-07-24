--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


SKILL_TABLE_LIST =
{
    {"spell_armor", "chainmail"},
    {"spell_movespeed", "boots"},
    {"spell_attackspeed", "gloves"},
    {"spell_evasion", "talisman_of_evasion"},
    {"spell_magical_resistance", "cloak"},
    {"spell_status_resistance", "titan_sliver"},
    {"spell_amplify", "kaya"},
    {"spell_attack_range", "dragon_lance"},
    {"spell_cast_range", "psychic_headband"},
    {"spell_bonus_damage", "blades_of_attack"},
    {"spell_health", "vitality_booster"},
    {"spell_mana", "energy_booster"},
    {"spell_proj_speed", "witch_blade"},
    {"spell_fairy", "mysterious_hat"},
    {"spell_health_regen_perc", "heart"},
    {"spell_mana_regen_perc", "bloodstone"},
    {"spell_universal_evasion", "void_spell"},
    {"spell_total_block", "craggy_coat"},
    {"spell_critical_strike", "lesser_crit"},
    {"spell_magical_critical_strike", "magilys_custom"},
    {"spell_all_atributes", "crown"},
    {"spell_main_atributes", "vambrace"},
    {"spell_other_atributes", "pupils_gift"},
    {"spell_gold_second", "philosophers_stone"},
    {"spell_lifesteal", "lifesteal"},
    {"spell_spell_lifesteal", "voodoo_mask"},
    {"spell_cast_point", "arcane_blink"},
    {"spell_time_reduction", "timeless_relic"},
}

GET_SKILL_NUMBER =
{
    ["spell_armor"] = 7,
    ["spell_movespeed"] = 40,
    ["spell_attackspeed"] = 40,
    ["spell_evasion"] = 7,
    ["spell_magical_resistance"] = 5,
    ["spell_status_resistance"] = 5,
    ["spell_amplify"] = 3,
    ["spell_attack_range"] = 50,
    ["spell_cast_range"] = 50,
    ["spell_bonus_damage"] = 40,
    ["spell_health"] = 500,
    ["spell_mana"] = 500,
    ["spell_proj_speed"] = 200,
    ["spell_fairy"] = 10,
    ["spell_health_regen_perc"] = 0.5,
    ["spell_mana_regen_perc"] = 0.5,
    ["spell_universal_evasion"] = 5,
    ["spell_total_block"] = 5,
    ["spell_critical_strike"] = 10,
    ["spell_magical_critical_strike"] = 10,
    ["spell_all_atributes"] = 7,
    ["spell_main_atributes"] = 10,
    ["spell_other_atributes"] = 10,
    ["spell_gold_second"] = 60,
    ["spell_lifesteal"] = 10,
    ["spell_spell_lifesteal"] = 10,
    ["spell_cast_point"] = 10,
    ["spell_time_reduction"] = 4,
}

PERCENT_SPELLS = 
{
    ["spell_evasion"] = true,
    ["spell_magical_resistance"] = true,
    ["spell_status_resistance"] = true,
    ["spell_amplify"] = true,
    ["spell_fairy"] = true,
    ["spell_health_regen_perc"] = true,
    ["spell_mana_regen_perc"] = true,
    ["spell_universal_evasion"] = true,
    ["spell_total_block"] = true,
    ["spell_critical_strike"] = true,
    ["spell_magical_critical_strike"] = true,
    ["spell_lifesteal"] = true,
    ["spell_spell_lifesteal"] = true,
    ["spell_cast_point"] = true,
    ["spell_time_reduction"] = true,
}

function GetSpellNumCHA(name)
    local base_mult = 1
    local percent_mult = 1
    local round_info = CustomNetTables:GetTableValue("round_info", "round_number")
    if round_info and round_info.round > 0 then
        if round_info.round >= 30 then
            base_mult = 2
        end
        if round_info.round >= 50 then
            base_mult = 3
            percent_mult = 2
        end
    end
    if name == "spell_attack_range" then
        base_mult = 1
    end
    if name == "spell_total_block" then
        percent_mult = 1
    end
    if PERCENT_SPELLS[name] then
        return GET_SKILL_NUMBER[name] * percent_mult
    end
    return GET_SKILL_NUMBER[name] * base_mult
end

