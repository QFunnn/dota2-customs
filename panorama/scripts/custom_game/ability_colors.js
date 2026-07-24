--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Подсветка способностей — единая точка истины.
//
// АРХИТЕКТУРА:
//   • SSS-категории (FORMS..USEFUL) приходят с сервера (globals:bans_categories).
//   • WHITE-категория (модифицированные ванильные) — с сервера (globals:modified_abilities).
//   • Пользовательские настройки цветов/тогглов — из setting_data игрока (zxc_server.lua).
//   • Дефолты (палитра + 3 тоггла) хранятся в HIGHLIGHT_DEFAULTS ниже.
//
// API ДЛЯ ОСТАЛЬНОГО UI:
//   GetAbilityHighlightColor(abilityName) → "#RRGGBB" | null
//     null = подсветка не нужна (отключено или ability не в списках).
//   GetCategoryColor(catName) → "#RRGGBB"
//     Получить цвет конкретной SSS-категории по пользовательским настройкам.
//   GetAbilitySSSSubgroup(abilityName) → "FORMS" | "OP" | ... | null
//     В какой SSS-подкатегории способность (для UI типа полос в bans-меню).

// ============= ДЕФОЛТНАЯ ПАЛИТРА =============
// Применяется когда у игрока нет своих настроек или сервер их не вернул.
// Ключи должны совпадать с серверными (zxc_server.lua → settings).
const HIGHLIGHT_DEFAULTS = {
    highlight_master_enabled:    1,
    highlight_sss_enabled:       1,
    highlight_modified_enabled:  1,
    // 0 = все SSS подсвечиваются ОДНИМ цветом (color_default_sss).
    // 1 = каждая категория подсвечивается своим цветом из color_*.
    highlight_use_categories:    0,
    // По дефолту всё оранжевое (FORMS-цвет) — пользователь сам перенастроит при желании.
    color_default_sss:           "#ff8c42",
    color_modified:              "#ffffff",
    color_forms:                 "#ff8c42",
    color_splashes:              "#ff8c42",
    color_op:                    "#ff8c42",
    color_bkb:                   "#ff8c42",
    color_bashes:                "#ff8c42",
    color_percent:               "#ff8c42",
    color_saves:                 "#ff8c42",
    color_useful:                "#ff8c42",
}

const SSS_SUBGROUPS = ["FORMS", "SPLASHES", "OP", "BKB", "BASHES", "PERCENT", "SAVES", "USEFUL"]

// ============= SSS-СПИСОК (ХАРДКОД) =============
// ВАЖНО: должен совпадать с constants/tier_lists.lua → SPEICAL_TIERS_TABLE.ABILITIES.SSS
// При изменении списка в Lua — синхронизировать здесь вручную.
// Хардкод выбран чтобы не зависеть от NetTable timing (bans_categories может прийти
// позже чем создаётся первый ability_selection).
const ABILITY_SSS_SUBGROUP = {
    // FORMS
    "dragon_knight_elder_dragon_form_custom": "FORMS",
    "keeper_of_the_light_spirit_form_custom": "FORMS",
    "lina_laguna_blade_custom": "FORMS",
    "lycan_shapeshift_custom": "FORMS",
    "sven_gods_strength_custom": "FORMS",
    "undying_flesh_golem_custom": "FORMS",
    "winter_wyvern_arctic_burn": "FORMS",
    // SPLASHES
    "kunkka_tidebringer_custom": "SPLASHES",
    "sven_great_cleave": "SPLASHES",
    "tiny_tree_grab_lua": "SPLASHES",
    // OP
    "doom_bringer_doom": "OP",
    "faceless_void_chronosphere": "OP",
    "ogre_magi_multicast_lua": "OP",
    "shadow_demon_disseminate_custom": "OP",
    "tinker_rearm_datadriven": "OP",
    "witch_doctor_death_ward": "OP",
    "witch_doctor_maledict_custom": "OP",
    "elder_titan_natural_order": "OP",
    "warlock_fatal_bonds_lua": "OP",
    "magnataur_reverse_polarity": "OP",
    "magnataur_reverse_reverse_polarity": "OP",
    "disruptor_static_storm_custom": "OP",
    // BKB
    "chen_hand_of_god_custom": "BKB",
    "juggernaut_blade_fury": "BKB",
    "legion_commander_press_the_attack_custom": "BKB",
    "life_stealer_rage": "BKB",
    // BASHES
    "faceless_void_time_lock_custom": "BASHES",
    "slardar_bash": "BASHES",
    "spirit_breaker_greater_bash": "BASHES",
    // PERCENT
    "bloodseeker_bloodrage_custom": "PERCENT",
    "bloodseeker_thirst": "PERCENT",
    "broodmother_insatiable_hunger_custom": "PERCENT",
    "enigma_black_hole": "PERCENT",
    "life_stealer_feast_custom": "PERCENT",
    "meepo_ransack_custom": "PERCENT",
    "enigma_midnight_pulse_custom": "PERCENT",
    "terrorblade_reflection_lua": "PERCENT",
    "venomancer_poison_nova_custom": "PERCENT",
    "wisp_overcharge_custom": "PERCENT",
    "zuus_heavenly_jump_custom": "PERCENT",
    "zuus_static_field_custom": "PERCENT",
    "zuus_lightning_bolt_custom": "PERCENT",
    "necrolyte_heartstopper_aura_lua": "PERCENT",
    "zuus_arc_lightning_custom": "PERCENT",
    "zuus_thundergods_vengeance_custom": "PERCENT",
    // SAVES
    "abaddon_borrowed_time_custom": "SAVES",
    "dark_willow_shadow_realm": "SAVES",
    "dazzle_shallow_grave": "SAVES",
    "muerta_pierce_the_veil": "SAVES",
    "obsidian_destroyer_astral_imprisonment": "SAVES",
    "oracle_false_promise_custom": "SAVES",
    "phantom_assassin_blur_custom": "SAVES",
    "puck_phase_shift_custom": "SAVES",
    "slark_shadow_dance_custom": "SAVES",
    "troll_warlord_battle_trance": "SAVES",
    "tusk_snowball": "SAVES",
    "ursa_enrage": "SAVES",
    "visage_gravekeepers_cloak_lua": "SAVES",
    // USEFUL
    "huskar_inner_fire_custom": "USEFUL",
    "invoker_deafening_blast_lua": "USEFUL",
    "spectre_dispersion_custom": "USEFUL",
    "obsidian_destroyer_arcane_orb": "USEFUL",
    "silencer_glaives_of_wisdom": "USEFUL",
    "pangolier_heartpiercer_custom": "USEFUL",
    "rubick_spell_steal": "USEFUL",
    "drow_ranger_marksmanship_custom": "USEFUL",
}

let ABILITY_MODIFIED = {}         // { ability_name → true }  (WHITE категория, с сервера)
let HIGHLIGHT_SETTINGS = Object.assign({}, HIGHLIGHT_DEFAULTS)

// Подписка на WHITE (модифицированные ванильные способности) — приходит с сервера.
SubscribeAndFirePlayerTableByKey("globals", "modified_abilities", function(v){
    ABILITY_MODIFIED = v || {}
})

// Подписка на пользовательские настройки (cохраняются на сервере через PlayerSettings).
SubscribeAndFirePlayerTableByKey(`player_${Players.GetLocalPlayer()}`, "setting_data", function(v){
    if(!v) return
    let merged = Object.assign({}, HIGHLIGHT_DEFAULTS)
    let keys = Object.keys(HIGHLIGHT_DEFAULTS)
    for(let k of keys){
        if(v[k] !== undefined && v[k] !== null && v[k] !== ""){
            // Цвет приходит как строка "#RRGGBB", флаги как 0/1.
            merged[k] = v[k]
        }
    }
    HIGHLIGHT_SETTINGS = merged
})

// ============= ПУБЛИЧНОЕ API =============

function GetAbilitySSSSubgroup(abilityName){
    return ABILITY_SSS_SUBGROUP[abilityName] || null
}

// Спец-маркер «не подсвечивать» — используется когда пользователь выбрал в палитре «без цвета».
function IsNoColor(c){ return !c || c === "none" || c === "" }

// Цвет категории по её имени ("FORMS" → "#ff8c42"). null если "none" или не задан.
function GetCategoryColor(catName){
    if(!catName) return null
    let key = "color_" + catName.toLowerCase()
    let c = HIGHLIGHT_SETTINGS[key]
    return IsNoColor(c) ? null : c
}

// Цвет для полосы категории в UI банов. Возвращает null если:
//  - master_enabled=0 (вся подсветка off)
//  - sss_enabled=0 (SSS подсветка off)
//  - use_categories=0 (общий цвет для всех SSS, без полос по подкатегориям)
//  - сам цвет в настройках помечен как "none"
function GetCategoryStripeColor(catName){
    if(!HIGHLIGHT_SETTINGS.highlight_master_enabled) return null
    if(!HIGHLIGHT_SETTINGS.highlight_sss_enabled) return null
    if(!HIGHLIGHT_SETTINGS.highlight_use_categories) return null
    return GetCategoryColor(catName)
}

// Главная функция — возвращает цвет для иконки способности или null если подсветки нет.
function GetAbilityHighlightColor(abilityName){
    if(!HIGHLIGHT_SETTINGS.highlight_master_enabled) return null

    let sg = GetAbilitySSSSubgroup(abilityName)
    if(sg){
        if(!HIGHLIGHT_SETTINGS.highlight_sss_enabled) return null
        if(HIGHLIGHT_SETTINGS.highlight_use_categories){
            return GetCategoryColor(sg)  // null если "none"
        }
        let c = HIGHLIGHT_SETTINGS.color_default_sss
        return IsNoColor(c) ? null : c
    }

    if(ABILITY_MODIFIED[abilityName]){
        // Модифицированные всегда подсвечены — отключение через установку
        // color_modified в "none" (тоггл из UI удалён).
        let c = HIGHLIGHT_SETTINGS.color_modified
        return IsNoColor(c) ? null : c
    }

    return null
}

// ============= REAL-TIME APPLY (cross-script) =============
// Settings UI обновляет цвета/тогглы без переоткрытия селектора. Settings.js
// вызывает ApplyHighlightSetting(key, value), это мутирует HIGHLIGHT_SETTINGS
// и зовёт всех слушателей. Параллельно settings.js шлёт на сервер для
// персиста — серверный roundtrip триггерит ту же подписку выше, но к
// моменту прихода обновления локальный HIGHLIGHT_SETTINGS уже синхронен.

function _zxcNotifyHighlightChange(){
    let cfg = GameUI.CustomUIConfig()
    let listeners = cfg.HighlightChangeListeners || []
    for(let cb of listeners){
        try{ cb() } catch(e){ $.Msg("[HL listener err] ", String(e)) }
    }
}

GameUI.CustomUIConfig().ApplyHighlightSetting = function(key, value){
    // Защита от опечаток в ключах из settings.js — мутируем только known fields.
    if(!(key in HIGHLIGHT_DEFAULTS)) return
    HIGHLIGHT_SETTINGS[key] = value
    _zxcNotifyHighlightChange()
}

// Также проксируем подписку — потребитель не должен дублировать boilerplate.
GameUI.CustomUIConfig().OnHighlightChange = function(cb){
    let cfg = GameUI.CustomUIConfig()
    if(!cfg.HighlightChangeListeners) cfg.HighlightChangeListeners = []
    cfg.HighlightChangeListeners.push(cb)
}

// ============= LEGACY (для совместимости со старым кодом) =============
// Старая структура ABILITIES_COLOR использовалась в GetAbilityColor (см. ability_selection.js).
// Оставляем пустые объекты — старый код не упадёт, но новый идёт через GetAbilityHighlightColor.
let ABILITIES_COLOR = {
    FORMS    : {},
    SPLASHES : {},
    OP       : {},
    BKB      : {},
    BASHES   : {},
    PERCENT  : {},
    SAVES    : {},
    USEFUL   : {},
    BLUE     : {},
    PURPLE   : {},
    PINK     : {},
    WHITE    : {},
}