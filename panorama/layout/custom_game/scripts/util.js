--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function IsPlayerHasSubscribe(id)
{
    let player_data = Game.GetCustomTable("woda_player_data", String(id));
    if (player_data) 
    {
        if (player_data.plus_days > 0 || Game.IsInToolsMode())
        {
            return true
        }
    }
    return false
}

function GetDotaHud()
{
	let hPanel = $.GetContextPanel();

	while ( hPanel && hPanel.id !== 'Hud')
	{
        hPanel = hPanel.GetParent();
	}

	if (!hPanel)
	{
        throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
	}

	return hPanel;
}

function FindDotaHudElement(sId)
{
	return GetDotaHud().FindChildTraverse(sId);
}

function HasModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return true
        }
    }
    return false
}

function ShowAbilityDescription(panel, ability)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltip', panel, ability); });
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}

function FindModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return Entities.GetBuff(unit, i);
        }
    }
    return "none"
}

function HowStacks(mod) 
{
	var hero = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )
	for (var i = 0; i < Entities.GetNumBuffs(hero); i++) 
    {
		var buffID = Entities.GetBuff(hero, i)
		if (Buffs.GetName(hero, buffID ) == mod ){
			var stack = Buffs.GetStackCount(hero, buffID ) 
			if (stack == 0) {
				stack = 1
			}
			return stack
		}
	}
	return 0
}

function GetCurrentStacks(hero_id, mod) 
{
    var hero = hero_id
 
    for (var i = 0; i < Entities.GetNumBuffs(hero); i++) 
    {
       var buffID = Entities.GetBuff(hero, i)
        if (Buffs.GetName(hero, buffID ) == mod )
        {
            var stack = Buffs.GetStackCount(hero, buffID ) 
            return stack
        }
    }
    return 0
}

function IsSpectator() 
{
    const localPlayer = Players.GetLocalPlayer()
    if (Players.IsSpectator(localPlayer))
    {
        return true
    }
    const localTeam = Players.GetTeam(localPlayer)
    return localTeam !== 2 && localTeam !== 3 && localTeam !== 6 && localTeam !== 7 && localTeam !== 8 && localTeam !== 9 && localTeam !== 10 && localTeam !== 11 && localTeam !== 12 && localTeam !== 13
}

function ConvertTimeMinutes(time)
{
    var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var min = String(min - 60*( Math.trunc(min/60) ))
    var sec = String(sec_n)
    if (sec_n < 10) 
    {
        sec = '0' + sec
    }
    if (min < 10)
    {
        min = '0' + min
    } 
    return min + ':' + sec
}
var RUNE_VALUES =
{
    rune_health: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_strength: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_regeneration: {values: [1, 2, 3, 4, 5], suffix: "%"},
    rune_giant: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_titan: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_warrior: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_cast_range: {values: [200, 400, 600, 800, 1000], suffix: ""},
    rune_sentinel: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_antimagic: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_rebirth: {values: [1, 2, 3, 4, 5], suffix: ""},
    rune_knight: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_agility: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_evasion: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_rage: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_monk: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_berserker: {values: [1.5, 1.45, 1.4, 1.35, 1.3], suffix: ""},
    rune_hunter: {values: [100, 200, 300, 400, 500], suffix: ""},
    rune_vampire: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_speed: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_gold: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_sage: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_intellect: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_restoration: {values: [1, 2, 3, 4, 5], suffix: "%"},
    rune_thought: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_curse: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_spell: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_cleansing: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_sorcerer: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_barrier: {values: [5, 10, 15, 20, 25], suffix: "%"},
    rune_creator: {values: [1, 2, 3, 4, 5], suffix: ""},
    rune_replenishment: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_time: {values: [10, 20, 30, 40, 50], suffix: ""},
    rune_radius: {values: [50, 100, 150, 200, 250], suffix: ""},
    rune_summoner: {values: [20, 40, 60, 80, 100], suffix: "%"},
    rune_druid: {values: [20, 40, 60, 80, 100], suffix: "%"},
    rune_shaman: {values: [20, 40, 60, 80, 100], suffix: "%"},
    rune_necromancer: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_dominator: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_farm: {values: [10, 20, 30, 40, 50], suffix: "%"},
    rune_champion: {values: [10, 20, 30, 40, 50], suffix: "%"},
}

var ARENA_STAT_ORDER =
[
    "str", "agi", "int", "all_attributes_pct", "str_pct", "agi_pct", "int_pct", "health", "health_pct", "mana", "mana_pct",
    "armor", "armor_pct", "base_damage", "damage", "damage_pct", "total_damage_pct", "spell_amp", "attack_speed", "attack_speed_pct",
    "movespeed_pct", "magic_resist", "evasion", "dodge_any", "status_resist", "debuff_amp", "damage_reduction", "ignore_reduction",
    "manacost_reduction", "cooldown_reduction", "cast_range", "attack_range", "lifesteal", "spell_lifesteal", "hp_regen_pct", "mana_regen_pct",
]
var SMELTER_BONUS_PER_LEVEL = {ignore_reduction: 1, spell_amp: 1, damage: 5, armor: 1, health: 50, mana: 50}
var SMELTER_BONUS_ORDER = ["ignore_reduction", "spell_amp", "damage", "armor", "health", "mana"]

function FormatArenaStatValue(value)
{
    return String(Math.round((Number(value) || 0) * 100) / 100)
}

function LocalizeArenaStat(panel, key, value)
{
    panel.SetDialogVariable("value", FormatArenaStatValue(value))
    return $.Localize("#arena_stat_" + key, panel)
}

function BuildArenaStatsText(panel, stats)
{
    var lines = []
    for (var i = 0; i < ARENA_STAT_ORDER.length; i++)
    {
        var value = stats ? Number(stats[ARENA_STAT_ORDER[i]]) || 0 : 0
        if (value != 0)
        {
            lines.push(LocalizeArenaStat(panel, ARENA_STAT_ORDER[i], value))
        }
    }
    return lines.join("<br>")
}

var WODA_TOOLTIP_GOLD = "#eabe10"

function WodaGold(text)
{
    return "<b><font color='" + WODA_TOOLTIP_GOLD + "'>" + text + "</font></b>"
}

function WodaTooltipHeader(text)
{
    return "<b><font color='#ffffff'>" + text + "</font></b>"
}

function WodaGoldNumber(text)
{
    text = String(text)
    if (text.indexOf("<") >= 0) { return text }
    return text.replace(/[+\-]?\d+(?:[.,]\d+)?%?/, function(value) { return WodaGold(value) })
}

function BuildArenaStatsTextGold(panel, stats)
{
    var lines = []
    for (var i = 0; i < ARENA_STAT_ORDER.length; i++)
    {
        var value = stats ? Number(stats[ARENA_STAT_ORDER[i]]) || 0 : 0
        if (value != 0)
        {
            lines.push(WodaGoldNumber(LocalizeArenaStat(panel, ARENA_STAT_ORDER[i], value)))
        }
    }
    return lines.join("<br>")
}

function WodaSetTitleTooltip(panel, title, text)
{
    panel.SetPanelEvent("onmouseover", function()
    {
        $.DispatchEvent("DOTAShowTitleTextTooltip", panel, title, text)
    })
    panel.SetPanelEvent("onmouseout", function()
    {
        $.DispatchEvent("DOTAHideTitleTextTooltip", panel)
    })
}

function GetSmelterBonusStats(level)
{
    var stats = {}
    for (var i = 0; i < SMELTER_BONUS_ORDER.length; i++)
    {
        var key = SMELTER_BONUS_ORDER[i]
        stats[key] = (Number(level) || 0) * SMELTER_BONUS_PER_LEVEL[key]
    }
    return stats
}

function FormatRuneDescription(rune_id, level)
{
    var text = $.Localize("#" + rune_id + "_description")
    var info = RUNE_VALUES[rune_id]
    if (!info)
    {
        return text
    }
    var parts = []
    for (var i = 0; i < info.values.length; i++)
    {
        var value = String(info.values[i]) + (info.suffix || "")
        if (Number(level) == i + 1)
        {
            value = "<b><font color='#eabe10'>" + value + "</font></b>"
        }
        parts.push(value)
    }
    return text.split("{values}").join(parts.join("/"))
}

var ARENA_DIFFICULTY_ROOMS = [0, 12, 3, 10, 5, 21, 17, 29, 4, 33]

var WODA_BOSS_SOUL_COLOR = "#ff7a3c"

function GetArenaDifficultyRewards(level)
{
    var levels = Game.GetCustomTable("arena_difficulty_rewards", "levels")
    return levels ? (levels[String(level)] || null) : null
}

function BuildArenaDifficultyRewardsLines(level)
{
    var info = GetArenaDifficultyRewards(level)
    if (!info) { return [] }
    var lines = []
    lines.push($.Localize("#arena_difficulty_rewards_coins").split("{value}").join(WodaGold(FormatArenaStatValue(info.coins))))
    lines.push($.Localize("#arena_difficulty_rewards_boss_soul").split("{value}").join("<b><font color='" + WODA_BOSS_SOUL_COLOR + "'>" + FormatArenaStatValue(info.boss_soul_chance) + "%</font></b>"))
    var rooms = info.rooms || {}
    for (var i = 1; rooms[i]; i++)
    {
        var room_text = $.Localize("#arena_difficulty_rewards_room").split("{room}").join($.Localize("#arena_room_" + rooms[i].room))
        lines.push(room_text.split("{value}").join(WodaGold(FormatArenaStatValue(rooms[i].chance) + "%")))
    }
    if (Number(info.rune_slot) > 0)
    {
        lines.push($.Localize("#arena_difficulty_rewards_rune_slot"))
    }
    return lines
}

function BuildArenaDifficultyInfoText(info)
{
    if (!info) { return "" }
    var global_damage = Number(info.global_damage) || 0
    var final_room = Number(info.final_room)
    return $.Localize("#arena_difficulty_tooltip_text")
        .replace("{final_room}", final_room >= 0 ? $.Localize("#arena_room_" + final_room) : "")
        .replace("{final_boss}", info.final_boss ? $.Localize("#" + info.final_boss) : "")
        .replace("{global_damage}", (global_damage > 0 ? "+" : "") + global_damage)
        .replace("{reduction_ignore}", String(Number(info.reduction_ignore) || 0))
        .replace("{status_resistance}", String(Number(info.status_resistance) || 0))
        .replace("{slow_resistance}", String(Number(info.slow_resistance) || 0))
        .replace("{debuff_amplify}", String(Number(info.debuff_amplify) || 0))
        .replace("{accuracy}", String(Number(info.accuracy) || 0))
}

function BuildArenaDifficultyTooltipText(level, info)
{
    var parts = []
    var info_text = BuildArenaDifficultyInfoText(info)
    if (info_text != "") { parts.push(info_text) }
    var rewards = BuildArenaDifficultyRewardsLines(level)
    if (rewards.length > 0) { parts.push(rewards.join("<br>")) }
    return parts.join("<br><br>")
}

function GetArenaDifficultyTooltipTitle(level)
{
    return $.Localize("#arena_difficulty_tooltip_title").replace("{level}", String(level))
}

var WODA_HEROES_ID =
{
    npc_dota_hero_antimage: 1,
    npc_dota_hero_axe: 2,
    npc_dota_hero_bane: 3,
    npc_dota_hero_bloodseeker: 4,
    npc_dota_hero_crystal_maiden: 5,
    npc_dota_hero_drow_ranger: 6,
    npc_dota_hero_earthshaker: 7,
    npc_dota_hero_juggernaut: 8,
    npc_dota_hero_mirana: 9,
    npc_dota_hero_nevermore: 11,
    npc_dota_hero_morphling: 10,
    npc_dota_hero_phantom_lancer: 12,
    npc_dota_hero_puck: 13,
    npc_dota_hero_pudge: 14,
    npc_dota_hero_razor: 15,
    npc_dota_hero_sand_king: 16,
    npc_dota_hero_storm_spirit: 17,
    npc_dota_hero_sven: 18,
    npc_dota_hero_tiny: 19,
    npc_dota_hero_vengefulspirit: 20,
    npc_dota_hero_windrunner: 21,
    npc_dota_hero_zuus: 22,
    npc_dota_hero_kunkka: 23,
    npc_dota_hero_lina: 25,
    npc_dota_hero_lich: 31,
    npc_dota_hero_lion: 26,
    npc_dota_hero_shadow_shaman: 27,
    npc_dota_hero_slardar: 28,
    npc_dota_hero_tidehunter: 29,
    npc_dota_hero_witch_doctor: 30,
    npc_dota_hero_riki: 32,
    npc_dota_hero_enigma: 33,
    npc_dota_hero_tinker: 34,
    npc_dota_hero_sniper: 35,
    npc_dota_hero_necrolyte: 36,
    npc_dota_hero_warlock: 37,
    npc_dota_hero_beastmaster: 38,
    npc_dota_hero_queenofpain: 39,
    npc_dota_hero_venomancer: 40,
    npc_dota_hero_faceless_void: 41,
    npc_dota_hero_skeleton_king: 42,
    npc_dota_hero_death_prophet: 43,
    npc_dota_hero_phantom_assassin: 44,
    npc_dota_hero_pugna: 45,
    npc_dota_hero_templar_assassin: 46,
    npc_dota_hero_viper: 47,
    npc_dota_hero_luna: 48,
    npc_dota_hero_dragon_knight: 49,
    npc_dota_hero_dazzle: 50,
    npc_dota_hero_rattletrap: 51,
    npc_dota_hero_leshrac: 52,
    npc_dota_hero_furion: 53,
    npc_dota_hero_life_stealer: 54,
    npc_dota_hero_dark_seer: 55,
    npc_dota_hero_clinkz: 56,
    npc_dota_hero_omniknight: 57,
    npc_dota_hero_enchantress: 58,
    npc_dota_hero_huskar: 59,
    npc_dota_hero_night_stalker: 60,
    npc_dota_hero_broodmother: 61,
    npc_dota_hero_bounty_hunter: 62,
    npc_dota_hero_weaver: 63,
    npc_dota_hero_jakiro: 64,
    npc_dota_hero_batrider: 65,
    npc_dota_hero_chen: 66,
    npc_dota_hero_spectre: 67,
    npc_dota_hero_doom_bringer: 69,
    npc_dota_hero_ancient_apparition: 68,
    npc_dota_hero_ursa: 70,
    npc_dota_hero_spirit_breaker: 71,
    npc_dota_hero_gyrocopter: 72,
    npc_dota_hero_alchemist: 73,
    npc_dota_hero_invoker: 74,
    npc_dota_hero_silencer: 75,
    npc_dota_hero_obsidian_destroyer: 76,
    npc_dota_hero_lycan: 77,
    npc_dota_hero_brewmaster: 78,
    npc_dota_hero_shadow_demon: 79,
    npc_dota_hero_lone_druid: 80,
    npc_dota_hero_chaos_knight: 81,
    npc_dota_hero_meepo: 82,
    npc_dota_hero_treant: 83,
    npc_dota_hero_ogre_magi: 84,
    npc_dota_hero_undying: 85,
    npc_dota_hero_rubick: 86,
    npc_dota_hero_disruptor: 87,
    npc_dota_hero_nyx_assassin: 88,
    npc_dota_hero_naga_siren: 89,
    npc_dota_hero_keeper_of_the_light: 90,
    npc_dota_hero_wisp: 91,
    npc_dota_hero_visage: 92,
    npc_dota_hero_slark: 93,
    npc_dota_hero_medusa: 94,
    npc_dota_hero_troll_warlord: 95,
    npc_dota_hero_centaur: 96,
    npc_dota_hero_magnataur: 97,
    npc_dota_hero_shredder: 98,
    npc_dota_hero_bristleback: 99,
    npc_dota_hero_tusk: 100,
    npc_dota_hero_skywrath_mage: 101,
    npc_dota_hero_abaddon: 102,
    npc_dota_hero_elder_titan: 103,
    npc_dota_hero_legion_commander: 104,
    npc_dota_hero_ember_spirit: 106,
    npc_dota_hero_earth_spirit: 107,
    npc_dota_hero_abyssal_underlord: 108,
    npc_dota_hero_terrorblade: 109,
    npc_dota_hero_phoenix: 110,
    npc_dota_hero_techies: 105,
    npc_dota_hero_oracle: 111,
    npc_dota_hero_winter_wyvern: 112,
    npc_dota_hero_arc_warden: 113,
    npc_dota_hero_monkey_king: 114,
    npc_dota_hero_dark_willow: 119,
    npc_dota_hero_pangolier: 120,
    npc_dota_hero_grimstroke: 121,
    npc_dota_hero_hoodwink: 123,
    npc_dota_hero_void_spirit: 126,
    npc_dota_hero_snapfire: 128,
    npc_dota_hero_mars: 129,
    npc_dota_hero_dawnbreaker: 135,
    npc_dota_hero_marci: 136,
    npc_dota_hero_primal_beast: 137,
    npc_dota_hero_muerta: 138,
    npc_dota_hero_kez: 145,
}

var WODA_AD_FREE_STEAM_IDS =
{
    "76561199562362347": true,
    "76561198141783031": true,
    "76561199402579042": true,
    "76561198082679478": true,
}

function WodaShowAdBanner(panel, attempt)
{
    if (!panel || $.Language() != "russian") { return }
    var info = Game.GetLocalPlayerInfo()
    if (!info || !info.player_steamid)
    {
        attempt = attempt || 0
        if (attempt < 120)
        {
            $.Schedule(0.25, function() { WodaShowAdBanner(panel, attempt + 1) })
        }
        return
    }
    if (WODA_AD_FREE_STEAM_IDS[String(info.player_steamid)] === true) { return }
    panel.style.opacity = "1"
}

function WodaTrackTextEntry(panel)
{
    if (!panel) { return }
    $.RegisterEventHandler("InputFocusSet", panel, function()
    {
        GameUI.CustomUIConfig().woda_text_entry_focus = true
    })
    $.RegisterEventHandler("InputFocusLost", panel, function()
    {
        GameUI.CustomUIConfig().woda_text_entry_focus = false
        var restore = GameUI.CustomUIConfig().woda_restore_focus
        if (typeof restore === "function")
        {
            $.Schedule(0.2, function()
            {
                try { restore() } catch (error) {}
            })
        }
    })
}

function WodaIsTextEntryFocused()
{
    return GameUI.CustomUIConfig().woda_text_entry_focus === true
}