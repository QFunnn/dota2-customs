--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var ABILITIES_KEY_BINDS_SLOTS =
{
    0: [DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1, DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST],
    1: [DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2, DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST],
    2: [DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3, DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST],
    3: [DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1, DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST],
    4: [DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2, DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST],
    5: [DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE, DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST],
}

var DEFAULTS_HOTKEYS =
{
    7: "G",
    8: "F2",
    9: "F4",
}

var ITEMS_KEY_BINDS_SLOTS =
{
    0: [DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1, DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_QUICKCAST],
    1: [DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2, DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKCAST],
    2: [DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3, DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKCAST],
    3: [DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4, DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKCAST],
    4: [DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5, DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKCAST],
    5: [DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6, DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKCAST],
}

var BASE_ABILITIES_DATA =
{
    levelup_select_card :
    {
        icon : "levelup_select_card",
    },
    levelup_upgrade_stats :
    {
        icon : "sniper_headshot",
    },
    levelup_upgrade_artifacts :
    {
        icon : "levelup_upgrade_artifacts_0",
    },
    levelup_blink :
    {
        icon : "levelup_blink",
        mana_cost : 0,
        cooldown : 0,
        special_values :
        {
            base_max_range : 800,
            movement_speed : 4000,
        },
    },
    levelup_void_spirit_astral_step :
    {
        icon : "levelup_astral_step",
        mana_cost : 25,
        cooldown : 0.1,
        special_values :
        {
            max_travel_distance : 800,
            radius : 160,
            attack_damage_pct : 100,
        },
    },
    levelup_sand_king_burrowstrike :
    {
        icon : "levelup_burrowstrike",
        mana_cost : 25,
        cooldown : 0.1,
        special_values :
        {
            max_travel_distance : 800,
            movement_speed : 3000,
            radius : 160,
            int_damage_pct : 75,
            stun_duration : 0.82,
            knockback_duration : 0.52,
            knockback_height : 350,
            cast_backswing : 0.53,
        },
    },
    levelup_mirana_leap :
    {
        icon : "levelup_leap",
        mana_cost : 25,
        cooldown : 0.1,
        special_values :
        {
            leap_distance : 675,
            leap_speed : 1250,
            leap_height : 150,
            leap_min_duration : 0.25,
            leap_bonus_duration : 2.5,
            leap_speedbonus : 25,
            leap_speedbonus_as : 20,
        },
    },
    levelup_earth_spirit_rolling_boulder :
    {
        icon : "levelup_rolling_boulder",
        mana_cost : 25,
        cooldown : 0.1,
        special_values :
        {
            distance : 800,
            speed : 2500,
            radius : 160,
            str_damage_pct : 100,
            stun_duration : 0.8,
        },
    },
    levelup_ultimate_handler :
    {
        icon : "rubick_empty1",
    },
}

const quality_values = 
{
    "all":
    {
        1: "I",
        2: "II",
        3: "III",
        4: "IV",
        5: "V",
        6: "VI",
        7: "VII",
        8: "VIII",
        9: "IX",
        10: "X"
    },
    "tchinese":
    {
        1: "F",
        2: "D",
        3: "C",
        4: "B",
        5: "A",
        6: "SSS",
        7: "SS",
        8: "SSS",
        9: "X",
        10: "EX"
    },
    "schinese":
    {
        1: "F",
        2: "D",
        3: "C",
        4: "B",
        5: "A",
        6: "SSS",
        7: "SS",
        8: "SSS",
        9: "X",
        10: "EX"
    },
}