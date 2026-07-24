--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS =
{
    stat_str_main : $("#stat_str_main"),
    stat_str_add : $("#stat_str_add"),
    stat_agi_main : $("#stat_agi_main"),
    stat_agi_add : $("#stat_agi_add"),
    stat_int_main : $("#stat_int_main"),
    stat_int_add : $("#stat_int_add"),
    stat_health : $("#stat_health"),
    stat_hp_regen : $("#stat_hp_regen"),
    stat_damage : $("#stat_damage"),
    stat_base_damage_str : $("#stat_base_damage_str"),
    stat_base_damage_agi : $("#stat_base_damage_agi"),
    stat_base_damage_int : $("#stat_base_damage_int"),
    stat_spell_amp : $("#stat_spell_amp"),
    stat_spell_amp_artif : $("#stat_spell_amp_artif"),
    TooltipBody : $("#TooltipBody"),
}

function UpdateTooltip()
{
    let stats_data = Game.GetCustomTable("player_stats", String(Game.GetLocalPlayerID()))

    TOOLTIP_PANELS.stat_str_main.text = Math.floor(stats_data.base_strength)
    TOOLTIP_PANELS.stat_agi_main.text = Math.floor(stats_data.base_agility)
    TOOLTIP_PANELS.stat_int_main.text = Math.floor(stats_data.base_intellect)
    ApplyStatFormat(TOOLTIP_PANELS.stat_str_add, Math.floor(stats_data.strength))
    ApplyStatFormat(TOOLTIP_PANELS.stat_agi_add, Math.floor(stats_data.agility))
    ApplyStatFormat(TOOLTIP_PANELS.stat_int_add, Math.floor(stats_data.intellect))
    
    TOOLTIP_PANELS.stat_health.text = Math.floor(stats_data.health)
    TOOLTIP_PANELS.stat_hp_regen.text = Math.floor(stats_data.health_regen)
    TOOLTIP_PANELS.stat_damage.text = Math.floor(stats_data.bonus_damage)
    TOOLTIP_PANELS.stat_spell_amp.text = Math.floor(stats_data.spell_amp)
    TOOLTIP_PANELS.stat_spell_amp_artif.text = Math.floor(stats_data.artefact_amp)
    TOOLTIP_PANELS.stat_base_damage_str.text = Math.floor(stats_data.damage)
    TOOLTIP_PANELS.stat_base_damage_agi.text = Math.floor(stats_data.damage)
    TOOLTIP_PANELS.stat_base_damage_int.text = Math.floor(stats_data.damage)
    TOOLTIP_PANELS.TooltipBody.SetHasClass("PrimaryStr", stats_data.primary_attribute == 0)
    TOOLTIP_PANELS.TooltipBody.SetHasClass("PrimaryAgi", stats_data.primary_attribute == 1)
    TOOLTIP_PANELS.TooltipBody.SetHasClass("PrimaryInt", stats_data.primary_attribute == 2)
    TOOLTIP_PANELS.TooltipBody.SetHasClass("PrimaryAll", stats_data.primary_attribute == 3)
}