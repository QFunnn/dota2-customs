--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var TAB_EQUIPMENT = "equipment"
var TAB_APPEARANCE = "appearance"
var TAB_TALENTS = "talents"
var TAB_SMALL = "small"
var TAB_GREAT = "great"
var TAB_SUPER = "super"
var TAB_COMPANIONS = "companions"

var APPEARANCE_TITLE = "title"
var APPEARANCE_WINGS = "wings"
var APPEARANCE_EFFECT = "effect"
var APPEARANCE_HERO = "hero"
var APPEARANCE_PET = "pet"
var APPEARANCE_ASSISTANT = "assistant"

var current_inventory_tab = TAB_EQUIPMENT
var current_equipment_config = 0
var current_storage_tab = "equipment"
var current_appearance_subtab = APPEARANCE_TITLE
var current_talent_config = 0
var current_super_config = 0
var inventory_services_ready = false
var storage_smelt_mode = false
var storage_selected_uids = {}
var storage_item_panels = {}
var storage_forge_mode = false
var forge_selected_uid = null
var forge_category = 1
var forge_use_blessing_stone = false
var forge_reforge_selected = {}
var forge_last_result = null
var storage_rarity_filter = ""
var STORAGE_RARITIES = ["common", "rare", "mythical", "legendary", "immortal", "super"]
var FORGE_CATEGORIES =
[
    { id: 1, title_key: "#services_forge_cat_strengthen" },
    { id: 2, title_key: "#services_forge_cat_reforge_stats" },
    { id: 3, title_key: "#services_forge_cat_set_reforge" },
    { id: 4, title_key: "#services_forge_cat_potential" },
]
var last_crystal_state = {}
var inventory_player_data_override = null
var talent_node_ids = []
for (let talent_node_index = 1; talent_node_index <= 35; talent_node_index++)
{
    talent_node_ids.push("TalentNode" + talent_node_index)
}
var talent_config_by_id = {}
var talent_levels_by_id = {}
var inventory_deferred_render = false
var talent_upgrade_pending = false
var talent_upgrade_hold_locked = false
var hovered_talent_node = null
var talent_guide_panel = null
var talent_guide_seen_local = false
var talent_guide_data_ready = false
var talent_sound_cooldown = -1
var companion_guide_panel = null
var companion_guide_seen_local = false

const InventorySidebar = $("#InventorySidebar")
const InventoryCurrencyRow = $("#InventoryCurrencyRow")
const InventoryContentBody = $("#InventoryContentBody")
const InventoryContentFrame = $("#InventoryContentFrame")

var inventory_tabs =
[
    { id: TAB_EQUIPMENT, title: $.Localize("#services_inventory_tab_equipment") },
    { id: TAB_APPEARANCE, title: $.Localize("#services_inventory_tab_appearance") },
    { id: TAB_TALENTS, title: $.Localize("#services_inventory_tab_talents") },
    { id: TAB_SMALL, title: $.Localize("#services_inventory_tab_crystals") },
    { id: TAB_COMPANIONS, title: $.Localize("#services_inventory_tab_companions") },
    //{ id: TAB_GREAT, title: "Великое хранилище" },
    //{ id: TAB_SUPER, title: "Супер-талант" },
]

var inventory_currencies = []
var inventory_default_currencies = []
var inventory_companion_currencies = []
var inventory_talent_currencies = []
var TALENT_PROGRESS_MAX_POINTS = 200
var TALENT_RESET_COST = 5000
 
var equipment_data =
{
    configs: [$.Localize("#services_inventory_config_1"), $.Localize("#services_inventory_config_2"), $.Localize("#services_inventory_config_3")],
    set_slots:
    [
        { slot: "helmet", icon: "" },
        { slot: "chest", icon: "" },
        { slot: "weapon", icon: "" },
        { slot: "boots", icon: "" },
        { slot: "ring", icon: "" },
        { slot: "trinket", icon: "" },
    ],
    storage_tabs: [
        { id: "equipment", title: $.Localize("#services_inventory_tab_equipment") },
        { id: "item", title: $.Localize("#services_inventory_storage_item") },
        { id: "materials", title: $.Localize("#services_inventory_storage_materials") },
    ],
    storage_count: "0/500",
    storage_counts: { equipment: "0/500", item: "0/500", materials: "0/500" },
    storage_items: { equipment: [], item: [], materials: [] },
    equipment_stats: [],
    forge: { level: 0, progress: 0, max_progress: 1, stats: [] },
}

var appearance_subtabs =
[
    { id: APPEARANCE_TITLE, title: $.Localize("#services_inventory_appearance_title") },
    { id: APPEARANCE_WINGS, title: $.Localize("#services_inventory_appearance_wings") },
    { id: APPEARANCE_EFFECT, title: $.Localize("#services_inventory_appearance_effect") },
    { id: APPEARANCE_HERO, title: $.Localize("#services_inventory_appearance_hero") },
    { id: APPEARANCE_PET, title: $.Localize("#services_inventory_appearance_pet") },
]

var appearance_data =
{
    title: { selected: 0, items: [] },
    wings: { selected: 0, items: [] },
    effect: { selected: 0, items: [] },
    hero: { selected: 0, items: [] },
    pet: { selected: 0, items: [] },
    assistant: { selected: 0, items: [] },
}

const TALENT_PROGRESS_POINTS = [
    { points: 0, width: 0 },
    { points: 10, width: 8 },
    { points: 20, width: 20 },
    { points: 40, width: 32 },
    { points: 70, width: 45 },
    { points: 100, width: 57.5 },
    { points: 130, width: 71.5 },
    { points: 160, width: 86 },
    { points: 200, width: 100 },
]

var talent_data =
{
    configs: [$.Localize("#services_inventory_config_1"), $.Localize("#services_inventory_config_2"), $.Localize("#services_inventory_config_3")],
    currency: "0",
    milestones: [10, 20, 40, 70, 100, 130, 160, 200],
}

var chest_tabs =
{
    small: { unlocked: true, title_right: "Crystals", pull_cost: "0/0", pull_icon: "", sections: [], rare_crystals: [], pull_tooltip: {} },
    great: { unlocked: false, unlock_need: "0/0", title_right: "Crystals", pull_cost: "0/0", pull_icon: "", sections: [], rare_crystals: [], pull_tooltip: {} },
}

var super_talent_data =
{
    unlocked: false,
    unlock_need: "1/5",
    configs: [$.Localize("#services_inventory_config_1"), $.Localize("#services_inventory_config_2"), $.Localize("#services_inventory_config_3")],
}

function AppearanceItem(name, show_button, stars, equipped, image, bonuses, need, item_id, level_bonuses, preview_image, appearance_type, hero_abilities, rarity, special_bonuses, hide_need, description)
{
    return { name: name, show_button: !!show_button, stars: stars, equipped: !!equipped, image: image, preview_image: preview_image || image, bonuses: bonuses || [], need: need || "0/1", item_id: item_id || "", level_bonuses: level_bonuses || [], appearance_type: appearance_type || "", hero_abilities: hero_abilities || [], rarity: rarity || "common", special_bonuses: special_bonuses || [], hide_need: !!hide_need, description: description || "" }
}

function StoneSection(title, total_level, stones)
{
    return { title: title, total_level: total_level, stones: stones || [] }
}

function StoneItem(unlocked, level, icon, category, index, max_level)
{
    return { unlocked: !!unlocked, level: level, icon: icon || "", category: category || "", index: index || 0, max_level: max_level || 0 }
}

function GetAbilityIconPath(ability_name)
{
    if (typeof BASE_ABILITIES_DATA !== "undefined" && BASE_ABILITIES_DATA[ability_name] && BASE_ABILITIES_DATA[ability_name].icon)
    {
        return "file://{images}/abilities/" + BASE_ABILITIES_DATA[ability_name].icon + ".png"
    }

    let ability_card_data = Game.GetCustomTable ? Game.GetCustomTable("ability_card_data", ability_name) : null
    if (ability_card_data && ability_card_data.icon)
    {
        return "file://{images}/spellicons/" + ability_card_data.icon + ".png"
    }

    return "file://{images}/abilities/" + ability_name + ".png"
}

function GetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function GetServiceItems()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}
}

function GetServiceEquipmentConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "equipment") : {}
}

function IsServiceTruthy(value)
{
    return value === true || value === 1 || String(value) === "1" || String(value) === "true"
}
function GetServicePlayerData()
{
    if (inventory_player_data_override) return inventory_player_data_override
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {}
}

function LocalizeServiceText(value)
{
    let text = String(value || "")
    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key))
    {
        return $.Localize(key)
    }
    if (text.charAt(0) === "#")
    {
        let localized = $.Localize(text)
        return localized && localized !== text ? localized : text.substring(1)
    }
    return text
}

function MergeServicePlayerData(base_data, patch_data)
{
    let result = {}
    base_data = base_data || {}
    patch_data = patch_data || {}
    for (let key in base_data) result[key] = base_data[key]
    for (let key in patch_data) result[key] = patch_data[key]
    return result
}

function FormatStatRowName(prefix, stat_name)
{
    return prefix ? prefix + "." + stat_name : stat_name
}

function GetStatLocalizationName(prefix, stat_name)
{
    return prefix ? prefix + "_" + stat_name : stat_name
}

function LocalizeStatRowName(prefix, stat_name)
{
    let localization_name = GetStatLocalizationName(prefix, stat_name)
    let localization_key = "#services_stat_" + localization_name
    let localized = $.Localize(localization_key)
    if (localized && localized !== localization_key)
    {
        return localized
    }
    return FormatStatRowName(prefix, stat_name)
}

function HasPercentStatValue(stat_name)
{
    return IsLevelUpPercentStatName(stat_name)
}

function FormatInventoryNumber(value)
{
    let numeric = Number(value)
    if (!isFinite(numeric))
    {
        return String(value || "")
    }

    let rounded = Math.round((numeric + Number.EPSILON) * 10000) / 10000
    if (Math.abs(rounded) < 0.0001)
    {
        rounded = 0
    }

    if (Number.isInteger(rounded))
    {
        return String(rounded)
    }

    return rounded.toFixed(4).replace(/\.?0+$/, "")
}

const ASSISTANT_INHERIT_LABEL_KEYS = {
    crit: "#services_assistant_inherit_crit_label",
    bounce_count: "#services_assistant_inherit_bounce_count_label",
    extra_attacks: "#services_assistant_inherit_extra_attacks_label",
    attack_speed: "#services_assistant_inherit_attack_speed_label",
    magic_damage: "#services_assistant_inherit_magic_damage_label",
    damage: "#services_assistant_inherit_damage_label",
}

function BuildAssistantInheritRows(item, level)
{
    let rows = []
    let star = Math.max(1, Math.floor(Number(level) || 1))
    for (let inherit_id in (item && item.inherit || {}))
    {
        let inherit = item.inherit[inherit_id] || {}
        let stat = String(inherit.stat || "")
        let label_key = ASSISTANT_INHERIT_LABEL_KEYS[stat]
        if (!label_key) continue

        let pct = (Number(inherit.pct) || 0) + (Number(inherit.per_star) || 0) * (star - 1)
        rows.push({ name: $.Localize(label_key), value: FormatInventoryNumber(pct) + "%" })
    }
    return rows
}

function FormatStatRowValue(stat_name, value)
{
    let numeric = Number(value)
    if (!isNaN(numeric))
    {
        let formatted = FormatInventoryNumber(numeric)
        return (numeric >= 0 ? "+" : "") + formatted + (HasPercentStatValue(stat_name) ? "%" : "")
    }
    return String(value || "")
}

function PushStatRows(result, stats, prefix)
{
    for (let stat_name in (stats || {}))
    {
        let value = stats[stat_name]
        if (value && typeof value === "object")
        {
            PushStatRows(result, value, FormatStatRowName(prefix, stat_name))
        }
        else
        {
            result.push({ name: LocalizeStatRowName(prefix, stat_name), value: FormatStatRowValue(stat_name, value) })
        }
    }
}

function StatsToLabels(stats)
{
    return StatsToRows(stats).map(function(row) { return row.name + " " + row.value })
}

function StatsToRows(stats)
{
    let result = []
    PushStatRows(result, stats, "")
    return result
}

function MergeStatsForDisplay(base_stats, display_stats)
{
    let result = {}
    for (let key in (base_stats || {}))
    {
        let value = base_stats[key]
        result[key] = value && typeof value === "object" ? MergeStatsForDisplay(value, {}) : value
    }
    for (let key in (display_stats || {}))
    {
        let value = display_stats[key]
        if (value && typeof value === "object" && result[key] && typeof result[key] === "object")
        {
            result[key] = MergeStatsForDisplay(result[key], value)
        }
        else
        {
            result[key] = value && typeof value === "object" ? MergeStatsForDisplay(value, {}) : value
        }
    }
    return result
}

function GetAppearanceLevelDisplayStats(level_data)
{
    level_data = level_data || {}
    return MergeStatsForDisplay(level_data.stats || {}, level_data.display_stats || {})
}

function GetAppearanceCumulativeNeed(levels, target_level)
{
    levels = levels || {}
    target_level = Math.max(1, Math.floor(Number(target_level) || 1))

    let total = 0
    for (let level = 1; level <= target_level; level++)
    {
        total += Math.max(0, Math.floor(Number(levels[level] && levels[level].need) || 0))
    }
    return total
}

function GetEquippedUidMap(armor_data)
{
    let result = {}
    let configs = armor_data && armor_data.configurations_data || {}
    for (let config_id in configs)
    {
        for (let slot in (configs[config_id] || {}))
        {
            let uid = configs[config_id][slot]
            if (uid !== undefined && uid !== null)
            {
                result[String(uid)] = true
            }
        }
    }
    return result
}

function BuildStorageItemView(entry, item)
{
    entry = entry || {}
    item = item || {}
    let item_type = entry.item_type || item.item_type || "item"
    let storage_type = entry.storage_type || item.storage_type || "item"
    if (storage_type === "items") storage_type = "item"
    if (storage_type === "material") storage_type = "materials"
    if (item_type === "material") storage_type = "materials"
    return {
        uid: entry.uid,
        item_id: entry.item_id,
        icon: entry.icon || item.icon || "file://{images}/game_hud/icons/gold.png",
        item_type: item_type,
        storage_type: storage_type,
        count: Number(entry.count) || 1,
        rarity: entry.rarity || item.rarity || "common",
        slot: entry.slot || item.slot || "",
        generated: entry.generated === true || entry.generated === 1 || entry.generated_id,
        generated_id: entry.generated_id || "",
        generated_name: entry.generated_name || "",
        potential: entry.potential || 0,
        potential_reforge_attempts: entry.potential_reforge_attempts || 0,
        strengthen_level: entry.strengthen_level || 0,
        locked: entry.locked === true || entry.locked === 1,
        set_id: entry.set_id || "",
        star_min: entry.star_min || 1,
        star_max: entry.star_max || 1,
        equipped: entry.equipped === true || entry.equipped === 1,
        normal_stats: entry.normal_stats || [],
        random_stats: entry.random_stats || [],
    }
}

function BuildEquipmentCompareData(storage_item_data)
{
    if (!storage_item_data || !storage_item_data.generated || !storage_item_data.slot) return null
    for (let slot of equipment_data.set_slots || [])
    {
        if (slot && String(slot.slot) === String(storage_item_data.slot) && slot.uid && String(slot.uid) !== String(storage_item_data.uid) && slot.generated)
        {
            return {
                item_id: slot.item_id,
                generated: "true",
                rarity: slot.rarity,
                icon: slot.icon,
                slot: slot.slot,
                generated_id: slot.generated_id,
                generated_name: slot.generated_name,
                potential: slot.potential,
                potential_reforge_attempts: slot.potential_reforge_attempts,
                strengthen_level: slot.strengthen_level || 0,
                set_id: slot.set_id || "",
                set_equipped_count: GetEquippedSetCount(slot.set_id || ""),
                star_min: slot.star_min,
                star_max: slot.star_max,
                normal_stats: slot.normal_stats || [],
                random_stats: slot.random_stats || [],
            }
        }
    }
    return null
}

function BuildEquipmentTooltipExtra(storage_item_data)
{
    if (!storage_item_data || !storage_item_data.generated) return {}
    let compare_equipped = BuildEquipmentCompareData(storage_item_data)
    return {
        generated: "true",
        rarity: storage_item_data.rarity,
        icon: storage_item_data.icon,
        slot: storage_item_data.slot,
        generated_id: storage_item_data.generated_id,
        generated_name: storage_item_data.generated_name,
        potential: storage_item_data.potential,
        potential_reforge_attempts: storage_item_data.potential_reforge_attempts,
        strengthen_level: storage_item_data.strengthen_level || 0,
        set_id: storage_item_data.set_id || "",
        set_equipped_count: GetEquippedSetCount(storage_item_data.set_id || ""),
        star_min: storage_item_data.star_min,
        star_max: storage_item_data.star_max,
        compare_equipped: compare_equipped,
        normal_stats: storage_item_data.normal_stats || [],
        random_stats: storage_item_data.random_stats || [],
    }
}

function GetLevelStartExp(levels, level)
{
    let data = (levels || {})[level]
    return Number(data && data.exp) || 0
}

function RefreshInventoryDataFromServices()
{
    let items = GetServiceItems()
    let player_data = GetServicePlayerData()
    let equipment_config = GetServiceEquipmentConfig()
    if (!player_data || !Object.keys(player_data).length)
    {
        return false
    }

    let currencies = player_data.economy_data || {}
    function BuildCurrencyEntry(currency_id)
    {
        let item = items[currency_id] || {}
        return { id: currency_id, icon: item.icon || "file://{images}/game_hud/icons/gold.png", amount: String(currencies[currency_id] || 0) }
    }
    inventory_default_currencies = ["coin", "stone", "moon", "sand_time", "magic_crystal"].map(BuildCurrencyEntry)
    inventory_companion_currencies = ["coin", "stone", "moon", "sand_time", "companion_coin"].map(BuildCurrencyEntry)

    let storage_limit = Number(player_data.storage_limit) || 500
    let equipped_uid_map = GetEquippedUidMap(player_data.armor_data)
    let storage_counts = { equipment: 0, item: 0, materials: 0 }
    equipment_data.storage_count = String(player_data.storage_count || 0) + "/" + String(storage_limit)
    equipment_data.storage_counts = { equipment: "0/" + storage_limit, item: "0/" + storage_limit, materials: "0/" + storage_limit }
    equipment_data.storage_items = { equipment: [], item: [], materials: [] }
    for (let entry of Object.values(player_data.storage_items || {}))
    {
        let item = items[entry.item_id] || {}
        let storage_item = BuildStorageItemView(entry, item)
        let storage_type = storage_item.storage_type
        if (entry.equipped || equipped_uid_map[String(entry.uid)])
        {
            continue
        }
        storage_counts[storage_type] = (storage_counts[storage_type] || 0) + 1
        if (!equipment_data.storage_items[storage_type]) equipment_data.storage_items[storage_type] = []
        equipment_data.storage_items[storage_type].push(storage_item)
    }
    for (let storage_type in storage_counts)
    {
        equipment_data.storage_counts[storage_type] = String(storage_counts[storage_type]) + "/" + String(storage_limit)
    }

    let service_stats = player_data.service_stats || {}
    let smelter_levels = equipment_config.smelter_levels || {}
    let smelter_level = Number(player_data.smelter_level) || 0
    let smelter_exp = Number(player_data.smelter_data && player_data.smelter_data.experience) || 0
    let smelter_current_start = GetLevelStartExp(smelter_levels, smelter_level)
    let smelter_next = GetLevelStartExp(smelter_levels, smelter_level + 1)
    if (smelter_next <= smelter_current_start) smelter_next = Math.max(smelter_current_start + 1, smelter_exp)
    equipment_data.forge = {
        level: smelter_level,
        progress: Math.max(0, smelter_exp - smelter_current_start),
        max_progress: Math.max(1, smelter_next - smelter_current_start),
        stats: StatsToRows(service_stats.smelter || {}),
    }
    equipment_data.equipment_stats = StatsToRows(service_stats.equipment || {})
    let slot_order = ["helmet", "chest", "weapon", "boots", "ring", "trinket"]
    let active_config_id = Number(player_data.armor_data && player_data.armor_data.current_configuration) || 1
    current_equipment_config = Math.max(0, active_config_id - 1)
    let active_equipment = player_data.armor_data && player_data.armor_data.configurations_data && player_data.armor_data.configurations_data[active_config_id] || {}
    for (let i = 0; i < equipment_data.set_slots.length; i++)
    {
        let slot_id = slot_order[i]
        let uid = active_equipment[slot_id]
        let found = null
        for (let entry of Object.values(player_data.storage_items || {}))
        {
            if (String(entry.uid) === String(uid)) found = entry
        }
        let item = found && items[found.item_id] || {}
        let storage_item = found ? BuildStorageItemView(found, item) : {}
        equipment_data.set_slots[i].slot = slot_id
        equipment_data.set_slots[i].uid = uid
        equipment_data.set_slots[i].item_id = found && found.item_id || ""
        equipment_data.set_slots[i].icon = storage_item.icon || ""
        equipment_data.set_slots[i].rarity = storage_item.rarity || "common"
        equipment_data.set_slots[i].generated = storage_item.generated || false
        equipment_data.set_slots[i].generated_id = storage_item.generated_id || ""
        equipment_data.set_slots[i].generated_name = storage_item.generated_name || ""
        equipment_data.set_slots[i].potential = storage_item.potential || 0
        equipment_data.set_slots[i].potential_reforge_attempts = storage_item.potential_reforge_attempts || 0
        equipment_data.set_slots[i].strengthen_level = storage_item.strengthen_level || 0
        equipment_data.set_slots[i].set_id = storage_item.set_id || ""
        equipment_data.set_slots[i].star_min = storage_item.star_min || 1
        equipment_data.set_slots[i].star_max = storage_item.star_max || 1
        equipment_data.set_slots[i].normal_stats = storage_item.normal_stats || []
        equipment_data.set_slots[i].random_stats = storage_item.random_stats || []
    }

    let appearance_map = { title: "title_data", wings: "wings_data", effect: "effects_data", hero: "start_hero_data", pet: "pet_data", assistant: "assistant_data" }
    for (let tab_id in appearance_map)
    {
        let group = (player_data.appearance_data || {})[appearance_map[tab_id]] || {}
        let list = []
        for (let item_id in items)
        {
            let item = items[item_id] || {}
            if (item.item_type !== "appearance") continue
            let expected_type = tab_id === "hero" ? "start_hero" : tab_id
            if (item.appearance_type !== expected_type) continue
            let state = group.items_list[item_id] || {}
            let current_level = Number(state.level) || 0
            let level_bonuses = []
            for (let level_id in (item.levels || {}))
            {
                let level = Number(level_id)
                let level_data = item.levels[level_id] || {}
                let level_rows
                if (item.appearance_type === "assistant")
                {
                    // В строках каждой звезды показываем respawn и сигнатурное наследование.
                    let respawn = Number(level_data.respawn) || 0
                    level_rows = respawn > 0 ? [{ name: $.Localize("#services_assistant_respawn_label"), value: String(respawn) + $.Localize("#services_assistant_respawn_suffix") }] : []
                    level_rows = level_rows.concat(BuildAssistantInheritRows(item, level))
                }
                else
                {
                    level_rows = StatsToRows(GetAppearanceLevelDisplayStats(level_data))
                }
                level_bonuses.push({ level: level, unlocked: current_level >= level, bonuses: level_rows })
            }
            level_bonuses.sort(function(a, b) { return a.level - b.level })
            let special_bonuses = []
            for (let special_id in (item.special_bonus || {}))
            {
                let special = item.special_bonus[special_id] || {}
                let need = Number(special.need) || 1
                special_bonuses.push({ level: need, unlocked: current_level >= need, description: LocalizeServiceText(special.description || "") })
            }
            special_bonuses.sort(function(a, b) { return a.level - b.level })
            let reward_icon = item.icon || "file://{images}/game_hud/icons/gold.png"
            let card_icon = item.card_icon || reward_icon
            let preview_icon = item.preview_icon || reward_icon
            let hero_abilities = Object.values(item.hero_abilities || {})
            let next_level = current_level + 1
            let next_level_need = item.levels && item.levels[next_level] && GetAppearanceCumulativeNeed(item.levels, next_level) || state.count || 1
            let item_description = item.appearance_type === "assistant" ? $.Localize("#" + item_id + "_description") : ""
            let appearance_item = AppearanceItem(
            LocalizeServiceItemName(item, item_id), !!state.owned, current_level, group.current_selected === item_id, card_icon, StatsToLabels(GetAppearanceLevelDisplayStats(item.levels && item.levels[current_level])), String(state.count || 0) + "/" + String(next_level_need), item_id, item.hide_need ? [] : level_bonuses, preview_icon, item.appearance_type, hero_abilities, item.rarity || "common", special_bonuses, !!item.hide_need, item_description )
            appearance_item.order_index = Number(item.order_index) || 999999
            appearance_item.owned = !!state.owned
            appearance_item.companion_type = item.companion_type ? $.Localize(item.companion_type) : ""
            appearance_item.companion_coin_price = Number(item.companion_coin_price) || 0
            appearance_item.model = item.model || ""
            appearance_item.model_scale = Number(item.model_scale) || 1
            appearance_item.unit_name = item.unit_name || "npc_levelup_assistant"
            appearance_item.preview_unit = item.preview_unit || item.unit_name || "npc_levelup_assistant"
            list.push(appearance_item)
        }
        list.sort(function(a, b) { return (a.order_index || 999999) - (b.order_index || 999999) })
        if (appearance_data[tab_id])
        {
            appearance_data[tab_id].items = list
            appearance_data[tab_id].selected = Math.max(0, list.findIndex(function(item) { return item.equipped }))
        }
    }

    let talents_data = player_data.talents_data || {}
    let active_talent_config = Number(talents_data.current_configuration) || 1
    let active_talent_data = talents_data.configurations_data && talents_data.configurations_data[active_talent_config] || {}
    current_talent_config = Math.max(0, active_talent_config - 1)
    talent_data.max_points = Number(talents_data.max_talents_counter) || 0
    talent_data.spent_points = Number(active_talent_data.spent_points) || 0
    talent_data.available_points = Math.max(0, talent_data.max_points - talent_data.spent_points)
    talent_data.currency = String(talent_data.available_points)
    talent_guide_data_ready = IsServiceTruthy(player_data.web_server_load_finished) || IsServiceTruthy(player_data.web_server_loaded) || IsServiceTruthy(player_data.web_server_load_failed)
    let guide_seen_value = talents_data.talent_guide_seen
    talent_data.guide_seen = talent_guide_seen_local || IsServiceTruthy(guide_seen_value)
    if (talent_data.guide_seen) HideTalentGuidePanel()
    talent_config_by_id = equipment_config.talents || {}
    talent_levels_by_id = active_talent_data.talents || {}
    inventory_talent_currencies = ["coin", "talent_point"].map(function(currency_id)
    {
        let item = items[currency_id] || {}
        let amount = currency_id === "talent_point" ? talent_data.available_points : (currencies[currency_id] || 0)
        return { id: currency_id, icon: item.icon || "file://{images}/game_hud/icons/gold.png", amount: String(amount) }
    })
    inventory_currencies = current_inventory_tab === TAB_TALENTS ? inventory_talent_currencies : (current_inventory_tab === TAB_COMPANIONS ? inventory_companion_currencies : inventory_default_currencies)

    let crystals = player_data.crystals_data && player_data.crystals_data.defaults_crystals_list || {}
    let rare_crystals = player_data.crystals_data && player_data.crystals_data.rare_crystals_list || {}
    let crystals_config = equipment_config.crystals || {}
    chest_tabs.small.sections = []
    chest_tabs.small.rare_crystals = []
    for (let category of ["C", "B", "A", "S", "SS", "SSS"])
    {
        let stones = []
        let total_level = 0
        let category_number = ["C", "B", "A", "S", "SS", "SSS"].indexOf(category) + 1
        let category_config = crystals_config.categories && crystals_config.categories[category] || {}
        let crystal_index = 1
        for (let crystal of Object.values(crystals[category] || {}))
        {
            let level = Number(crystal.level) || 0
            let crystal_config = category_config.crystals && category_config.crystals[crystal_index] || {}
            let max_level = Number(crystal_config.max_level) || 0
            total_level += level
            stones.push(StoneItem(level > 0, level, "file://{images}/game_hud/gems/" + category_number + "_" + crystal_index + ".png", category, crystal_index, max_level))
            crystal_index += 1
        }
        while (stones.length < 4) 
        { 
            let next_index = stones.length + 1
            let crystal_config = category_config.crystals && category_config.crystals[next_index] || {}
            stones.push(StoneItem(false, 0, "file://{images}/game_hud/gems/" + category_number + "_" + next_index + ".png", category, next_index, Number(crystal_config.max_level) || 0)) 
        }
        chest_tabs.small.sections.push(StoneSection(category, total_level, stones))

        let rare_state = rare_crystals[category] || {}
        let rare_config = category_config.rare_crystal || {}
        chest_tabs.small.rare_crystals.push({
            category: category,
            unlocked: !!rare_state.claimed,
            threshold: Number(category_config.rare_threshold || rare_state.threshold) || 0,
            total_level: total_level,
            icon: "file://{images}/game_hud/gems/rare_" + category_number + ".png",
            id: rare_config.id || ("rare_crystal_" + category.toLowerCase()),
        })
    }
    if (crystals_config.pull_cost)
    {
        let cost = crystals_config.pull_cost
        let currency_item = items[cost.currency] || {}
        chest_tabs.small.pull_icon = currency_item.icon || chest_tabs.small.pull_icon
        chest_tabs.small.pull_cost = String((currencies[cost.currency] || 0)) + "/" + String(cost.amount || 0)
        chest_tabs.small.pull_tooltip = { currency: cost.currency, amount: Number(cost.amount) || 0 }
    }

    inventory_services_ready = true
    return true
}

function GetTalentProgressWidth(points) {
    points = Number(points) || 0

    if (points <= 0) return 0
    if (points >= 200) return 100

    for (let i = 1; i < TALENT_PROGRESS_POINTS.length; i++) {
        const prev = TALENT_PROGRESS_POINTS[i - 1]
        const next = TALENT_PROGRESS_POINTS[i]

        if (points <= next.points) {
            const progress = (points - prev.points) / (next.points - prev.points)
            return prev.width + (next.width - prev.width) * progress
        }
    }

    return 100
}

function RenderInventoryFromServices(table_name, key, data)
{
    if (table_name === "services_player" && String(key) === GetLocalPlayerKey() && data)
    {
        inventory_player_data_override = data
    }
    if (!RefreshInventoryDataFromServices())
    {
        return
    }
    if (!IsInventoryWindowVisible())
    {
        inventory_deferred_render = true
        RenderInventoryCurrencies()
        return
    }
    RenderInventoryCurrencies()
    RefreshCurrentInventoryContent()
    RestartHoveredTalentTooltip()
    inventory_deferred_render = false
}

function OnInventoryPartialUpdate(data)
{
    let base_data = inventory_player_data_override || (Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {})
    inventory_player_data_override = MergeServicePlayerData(base_data, data || {})
    talent_upgrade_pending = false
    if (data && data.reason === "forge" && data.forge_result)
    {
        forge_last_result = data.forge_result
        Game.EmitSound("General.ButtonClick")
    }
    if (!RefreshInventoryDataFromServices())
    {
        return
    }
    if (!IsInventoryWindowVisible())
    {
        inventory_deferred_render = true
        RenderInventoryCurrencies()
        return
    }
    RenderInventoryCurrencies()
    RefreshCurrentInventoryContent()
    RestartHoveredTalentTooltip()
}

function RefreshCurrentInventoryContent()
{
    if (current_inventory_tab === TAB_EQUIPMENT)
    {
        RefreshStorageColumn()
        RefreshEquipmentSlots()
        RefreshEquipmentStats()
        RefreshForgePanel()
        RefreshForgeCraftPanel()
        ApplyForgeModeVisibility()
        return
    }

    if (current_inventory_tab === TAB_APPEARANCE)
    {
        RefreshAppearancePanels()
        return
    }

    if (current_inventory_tab === TAB_TALENTS)
    {
        RefreshTalentFooter()
        ShowTalentGuideIfNeeded()
        return
    }

    if (current_inventory_tab === TAB_SMALL)
    {
        RefreshStoneCollection(chest_tabs.small)
        return
    }

    RenderInventoryContent()
}

function HideTalentGuidePanel()
{
    if (talent_guide_panel && talent_guide_panel.IsValid && talent_guide_panel.IsValid())
    {
        talent_guide_panel.DeleteAsync(0)
    }
    talent_guide_panel = null
}

function ShowTalentGuideIfNeeded()
{
    if (current_inventory_tab !== TAB_TALENTS)
    {
        HideTalentGuidePanel()
        return
    }

    let fresh_player_data = Game.GetCustomTable ? (Game.GetCustomTable("services_player", GetLocalPlayerKey()) || {}) : {}
    let fresh_talents_data = fresh_player_data.talents_data || {}
    let fresh_seen_value = fresh_talents_data.talent_guide_seen

    if (IsServiceTruthy(fresh_seen_value))
    {
        talent_guide_seen_local = true
        talent_data.guide_seen = true
        HideTalentGuidePanel()
        return
    }

    let fresh_data_ready = IsServiceTruthy(fresh_player_data.web_server_load_finished) || IsServiceTruthy(fresh_player_data.web_server_loaded) || IsServiceTruthy(fresh_player_data.web_server_load_failed)

    if (!talent_guide_data_ready && !fresh_data_ready)
    {
        HideTalentGuidePanel()
        return
    }

    if (talent_data.guide_seen)
    {
        HideTalentGuidePanel()
        return
    }

    if (talent_guide_panel && talent_guide_panel.IsValid && talent_guide_panel.IsValid())
    {
        return
    }

    let overlay = $.CreatePanel("Panel", $.GetContextPanel(), "TalentGuideOverlay")
    talent_guide_panel = overlay
    overlay.AddClass("TalentGuideOverlay")
    overlay.hittest = true
    overlay.hittestchildren = true

    let window = $.CreatePanel("Panel", overlay, "")
    window.AddClass("TalentGuideWindow")

    let title = $.CreatePanel("Label", window, "")
    title.AddClass("TalentGuideTitle")
    title.text = $.Localize("#services_talent_guide_title")

    let videoFrame = $.CreatePanel("Panel", window, "")
    videoFrame.AddClass("TalentGuideVideoFrame")

    let video = $.CreatePanel("MoviePanel", videoFrame, "TalentGuideVideo", {
        src: "file://{resources}/videos/talent_guide.webm",
        repeat: "true",
        autoplay: "onload",
    })
    video.AddClass("TalentGuideVideo")

    Game.EmitSound("up_up_ui_guide")

    let text = $.CreatePanel("Label", window, "")
    text.AddClass("TalentGuideText")
    text.text = $.Localize("#services_talent_guide_text")

    let description = $.CreatePanel("Label", window, "")
    description.AddClass("TalentGuideDescription")
    description.text = $.Localize("#services_talent_guide_description")

    let button = $.CreatePanel("Panel", window, "")
    button.AddClass("TalentGuideContinueButton")
    button.hittest = true
    button.SetPanelEvent("onactivate", function()
    {
        talent_guide_seen_local = true
        talent_data.guide_seen = true
        if (inventory_player_data_override)
        {
            inventory_player_data_override.talents_data = inventory_player_data_override.talents_data || {}
            inventory_player_data_override.talents_data.talent_guide_seen = true
        }
        HideTalentGuidePanel()
        GameEvents.SendCustomGameEventToServer("event_services_confirm_talent_guide", {})
        Game.EmitSound("General.ButtonClick")
    })

    let buttonLabel = $.CreatePanel("Label", button, "")
    buttonLabel.AddClass("TalentGuideContinueLabel")
    buttonLabel.text = $.Localize("#services_common_continue")
}

function HideCompanionGuidePanel()
{
    if (companion_guide_panel && companion_guide_panel.IsValid && companion_guide_panel.IsValid())
    {
        companion_guide_panel.DeleteAsync(0)
    }
    companion_guide_panel = null
}

function PlayerOwnsStarterCompanion()
{
    let pdata = GetServicePlayerData() || {}
    let appearance = pdata.appearance_data || {}
    let assistant = appearance.assistant_data || {}
    let list = assistant.items_list || {}
    let entry = list["assistant_training_archer"]
    return !!(entry && (IsServiceTruthy(entry.owned) || (Number(entry.count) || 0) > 0))
}

function ShowCompanionGuideIfNeeded()
{
    if (current_inventory_tab !== TAB_COMPANIONS)
    {
        HideCompanionGuidePanel()
        return
    }

    let fresh_player_data = Game.GetCustomTable ? (Game.GetCustomTable("services_player", GetLocalPlayerKey()) || {}) : {}

    if (companion_guide_seen_local || IsServiceTruthy(fresh_player_data.companion_guide_seen))
    {
        companion_guide_seen_local = true
        HideCompanionGuidePanel()
        return
    }

    let fresh_data_ready = IsServiceTruthy(fresh_player_data.web_server_load_finished) || IsServiceTruthy(fresh_player_data.web_server_loaded) || IsServiceTruthy(fresh_player_data.web_server_load_failed)
    if (!fresh_data_ready)
    {
        HideCompanionGuidePanel()
        return
    }

    if (PlayerOwnsStarterCompanion())
    {
        HideCompanionGuidePanel()
        return
    }

    if (companion_guide_panel && companion_guide_panel.IsValid && companion_guide_panel.IsValid())
    {
        return
    }

    let overlay = $.CreatePanel("Panel", $.GetContextPanel(), "CompanionGuideOverlay")
    companion_guide_panel = overlay
    overlay.AddClass("TalentGuideOverlay")
    overlay.hittest = true
    overlay.hittestchildren = true

    let window = $.CreatePanel("Panel", overlay, "")
    window.AddClass("TalentGuideWindow")

    let title = $.CreatePanel("Label", window, "")
    title.AddClass("TalentGuideTitle")
    title.text = $.Localize("#services_companion_guide_title")

    let videoFrame = $.CreatePanel("Panel", window, "")
    videoFrame.AddClass("TalentGuideVideoFrame")

    let video = $.CreatePanel("MoviePanel", videoFrame, "CompanionGuideVideo", {
        src: "file://{resources}/videos/assist_guide.webm",
        repeat: "true",
        autoplay: "onload",
    })
    video.AddClass("TalentGuideVideo")

    Game.EmitSound("up_up_ui_guide")

    let text = $.CreatePanel("Label", window, "")
    text.AddClass("TalentGuideText")
    text.text = $.Localize("#services_companion_guide_text")

    let description = $.CreatePanel("Label", window, "")
    description.AddClass("TalentGuideDescription")
    description.text = $.Localize("#services_companion_guide_description")

    let button = $.CreatePanel("Panel", window, "")
    button.AddClass("TalentGuideContinueButton")
    button.hittest = true
    button.SetPanelEvent("onactivate", function()
    {
        companion_guide_seen_local = true
        if (inventory_player_data_override)
        {
            inventory_player_data_override.companion_guide_seen = true
        }
        HideCompanionGuidePanel()
        GameEvents.SendCustomGameEventToServer("event_services_confirm_companion_guide", {})
        Game.EmitSound("General.ButtonClick")
    })

    let buttonLabel = $.CreatePanel("Label", button, "")
    buttonLabel.AddClass("TalentGuideContinueLabel")
    buttonLabel.text = $.Localize("#services_common_continue")
}
function IsInventoryWindowVisible()
{
    let context = $.GetContextPanel()
    return !!(context && context.BHasClass && context.BHasClass("WindowVisible"))
}

function RenderInventoryIfDeferred()
{
    GameEvents.SendCustomGameEventToServer("event_services_request_inventory_sync", {})
    if (!RefreshInventoryDataFromServices())
    {
        return
    }
    RenderInventoryCurrencies()
    RefreshCurrentInventoryContent()
    RestartHoveredTalentTooltip()
    inventory_deferred_render = false
}

if (typeof Game !== 'undefined') Game.RenderInventoryIfDeferred = RenderInventoryIfDeferred

function InitInventory()
{
    RefreshInventoryDataFromServices()
    RenderInventorySidebar()
    RenderInventoryCurrencies()
    RenderInventoryContent()

    if (Game.SubscribeCustomTableListener)
    {
        Game.SubscribeCustomTableListener("services_config", "items", RenderInventoryFromServices)
        Game.SubscribeCustomTableListener("services_config", "equipment", RenderInventoryFromServices)
        Game.SubscribeCustomTableListener("services_player", GetLocalPlayerKey(), RenderInventoryFromServices)
    }
    GameEvents.Subscribe("event_services_inventory_update", OnInventoryPartialUpdate)
}

function RenderInventorySidebar()
{
    InventorySidebar.RemoveAndDeleteChildren()
    for (let i = 0; i < inventory_tabs.length; i++)
    {
        let tab = inventory_tabs[i]
        let button = $.CreatePanel("Panel", InventorySidebar, "")
        button.AddClass("InventoryNavButton")
        button.SetHasClass("InventoryNavButtonActive", tab.id === current_inventory_tab)
        button.SetPanelEvent("onactivate", (function(tab_id)
        {
            return function()
            {
                if (tab_id !== TAB_EQUIPMENT)
                {
                    storage_smelt_mode = false
                    storage_selected_uids = {}
                }
                current_inventory_tab = tab_id
                RefreshInventoryDataFromServices()
                if (tab_id === TAB_TALENTS)
                {
                    GameEvents.SendCustomGameEventToServer("event_services_request_inventory_sync", {})
                }
                RenderInventorySidebar()
                RenderInventoryCurrencies()
                RenderInventoryContent()
            }
        })(tab.id))

        let label = $.CreatePanel("Label", button, "")
        label.AddClass("InventoryNavButtonLabel")
        label.text = tab.title
    }
}

function RenderInventoryCurrencies()
{
    InventoryCurrencyRow.RemoveAndDeleteChildren()
    if (typeof RenderServiceServerSyncButton === "function")
    {
        if (current_inventory_tab !== TAB_TALENTS)
        {
            RenderServiceServerSyncButton(InventoryCurrencyRow)
        }
    }
    inventory_currencies = current_inventory_tab === TAB_TALENTS ? inventory_talent_currencies : (current_inventory_tab === TAB_COMPANIONS ? inventory_companion_currencies : inventory_default_currencies)
    for (let i = 0; i < inventory_currencies.length; i++)
    {
        let currency = inventory_currencies[i]
        let panel = $.CreatePanel("Panel", InventoryCurrencyRow, "")
        panel.AddClass("InventoryCurrencyPanel")

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("InventoryCurrencyIcon")
        SetPanelImage(icon, currency.icon)

        let label = $.CreatePanel("Label", panel, "")
        label.AddClass("InventoryCurrencyAmount")
        label.text = currency.amount

        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, currency.id, currency.amount)
        }
    }
    if (typeof RenderServiceCurrencyMoreButton === "function")
    {
        RenderServiceCurrencyMoreButton(InventoryCurrencyRow, (GetServicePlayerData().economy_data || {}))
    }
}

function RenderInventoryContent()
{
    InventoryContentBody.RemoveAndDeleteChildren()
    ClearInventoryThemes()

    if (current_inventory_tab === TAB_EQUIPMENT)
    {
        InventoryContentFrame.AddClass("InventoryThemeEquipment")
        RenderEquipmentTab()
        return
    }

    if (current_inventory_tab === TAB_COMPANIONS)
    {
        InventoryContentFrame.AddClass("InventoryThemeAppearance")
        RenderCompanionsTab()
        ShowCompanionGuideIfNeeded()
        return
    }

    if (current_inventory_tab === TAB_APPEARANCE)
    {
        InventoryContentFrame.AddClass("InventoryThemeAppearance")
        RenderAppearanceTab()
        return
    }

    if (current_inventory_tab === TAB_TALENTS)
    {
        InventoryContentFrame.AddClass("InventoryThemeTalents")
        RenderTalentTab(false)
        ShowTalentGuideIfNeeded()
        return
    }

    if (current_inventory_tab === TAB_SMALL)
    {
        InventoryContentFrame.AddClass("InventoryThemeStones")
        RenderStoneTab(chest_tabs.small)
        return
    }

    if (current_inventory_tab === TAB_GREAT)
    {
        InventoryContentFrame.AddClass("InventoryThemeStones")
        RenderStoneTab(chest_tabs.great)
        return
    }

    InventoryContentFrame.AddClass("InventoryThemeSuper")
    RenderSuperTalentTab()
}

function ClearInventoryThemes()
{
    InventoryContentFrame.RemoveClass("InventoryThemeEquipment")
    InventoryContentFrame.RemoveClass("InventoryThemeAppearance")
    InventoryContentFrame.RemoveClass("InventoryThemeTalents")
    InventoryContentFrame.RemoveClass("InventoryThemeStones")
    InventoryContentFrame.RemoveClass("InventoryThemeSuper")
}

function RefreshStorageColumn()
{
    if (current_storage_tab !== "equipment")
    {
        storage_smelt_mode = false
        storage_selected_uids = {}
    }

    let storageCount = $("#InventoryStorageCount")
    if (storageCount)
    {
        storageCount.SetDialogVariable("value", String(equipment_data.storage_counts[current_storage_tab] || equipment_data.storage_count))
        storageCount.text = $.Localize("#services_inventory_items_count", storageCount)
    }

    let storageTabs = $("#InventoryStorageTabs")
    if (storageTabs)
    {
        for (let child of storageTabs.Children())
        {
            child.SetHasClass("InventorySubTabButtonActive", child.storage_tab_id === current_storage_tab)
        }
    }

    let storageGrid = $("#InventoryStorageGrid")
    if (storageGrid)
    {
        if (storageGrid.Children && storageGrid.Children().length > 0)
        {
            RefreshStorageGridItems(storageGrid)
        }
        else
        {
            RenderStorageGrid(storageGrid)
        }
    }

    let storageButtons = $("#InventoryStorageButtons")
    if (storageButtons)
    {
        storageButtons.RemoveAndDeleteChildren()
        RenderStorageButtons(storageButtons)
    }
}

function SetStorageTab(tab_id)
{
    if (tab_id === "material")
    {
        tab_id = "materials"
    }
    if (current_storage_tab !== tab_id)
    {
        storage_smelt_mode = false
        storage_selected_uids = {}
        storage_rarity_filter = ""
        let lbl = $("#StorageFilterLabel")
        if (lbl) lbl.text = GetStorageFilterLabel()
        let popup = $("#StorageFilterPopup")
        if (popup) popup.style.visibility = "collapse"
    }
    current_storage_tab = tab_id
    RefreshStorageColumn()
}

function GetFilteredStorageItems()
{
    let items = equipment_data.storage_items[current_storage_tab] || []
    if (!storage_rarity_filter) return items
    return items.filter(function(it) { return String(it.rarity || "common") === storage_rarity_filter })
}

function GetStorageFilterLabel()
{
    if (!storage_rarity_filter) return $.Localize("#services_inventory_filter")
    return $.Localize("#services_rarity_" + storage_rarity_filter)
}

function GetSetConfig(set_id)
{
    if (!set_id) return null
    let sets = GetServiceEquipmentConfig().sets || {}
    let list = sets.list || {}
    return list[set_id] || null
}

function GetSetBonuses(set_config)
{
    return Object.values((set_config && set_config.bonuses) || {})
}

function GetEquippedSetCount(set_id)
{
    if (!set_id) return 0
    let count = 0
    let slots = equipment_data.set_slots || []
    for (let i = 0; i < slots.length; i++)
    {
        if (slots[i] && slots[i].generated && String(slots[i].set_id || "") === String(set_id)) count++
    }
    return count
}

function AddSetIconOverlay(parentPanel, set_id)
{
    let set_config = GetSetConfig(set_id)
    if (!set_config || !set_config.icon) return
    let overlay = $.CreatePanel("Panel", parentPanel, "")
    overlay.AddClass("ItemSetIconOverlay")
    SetPanelImage(overlay, set_config.icon)
}

function AddStrengthenLevelOverlay(parentPanel, strengthen_level)
{
    let level = Math.max(0, Math.floor(Number(strengthen_level) || 0))
    if (level <= 0) return
    let overlay = $.CreatePanel("Label", parentPanel, "")
    overlay.AddClass("ItemStrengthenLevelOverlay")
    overlay.text = "+" + level
}

function GetSetMaxPieces(set_config)
{
    let bonuses = GetSetBonuses(set_config)
    let max_pieces = 0
    for (let i = 0; i < bonuses.length; i++) max_pieces = Math.max(max_pieces, Number(bonuses[i].pieces) || 0)
    return max_pieces
}

function RenderEquippedSetsRow(parent)
{
    if (!parent) return

    let slots = equipment_data.set_slots || []
    let counts = {}
    let order = []
    for (let i = 0; i < slots.length; i++)
    {
        let slot = slots[i]
        if (!slot) continue
        let sid = String(slot.set_id || "")
        if (sid === "") continue
        if (counts[sid] === undefined) { counts[sid] = 0; order.push(sid) }
        counts[sid]++
    }
    if (order.length === 0) return

    let container = $.CreatePanel("Panel", parent, "")
    container.AddClass("EquippedSetsContainer")

    let title = $.CreatePanel("Label", container, "")
    title.AddClass("EquippedSetsTitle")
    title.text = $.Localize("#services_equipment_sets_row")

    let row = $.CreatePanel("Panel", container, "")
    row.AddClass("EquippedSetsRow")

    for (let i = 0; i < order.length; i++)
    {
        let sid = order[i]
        let set_config = GetSetConfig(sid)
        if (!set_config) continue
        let count = counts[sid]
        let max_pieces = GetSetMaxPieces(set_config)

        let cell = $.CreatePanel("Panel", row, "")
        cell.AddClass("EquippedSetCell")

        let icon = $.CreatePanel("Panel", cell, "")
        icon.AddClass("EquippedSetIcon")
        if (set_config.icon) SetPanelImage(icon, set_config.icon)

        let label = $.CreatePanel("Label", cell, "")
        label.AddClass("EquippedSetCount")
        label.text = count + "/" + max_pieces

        cell.SetPanelEvent("onmouseover", function()
        {
            $.DispatchEvent("UIShowCustomLayoutParametersTooltip", cell, "set_tooltip_custom",
                "file://{resources}/layout/custom_game/tooltips/set_tooltip/set_tooltip.xml",
                buildTooltipParams({ set_id: sid, equipped_count: String(count) }))
        })
        cell.SetPanelEvent("onmouseout", function()
        {
            $.DispatchEvent("UIHideCustomLayoutTooltip", cell, "set_tooltip_custom")
        })
    }
}

function RenderStorageGrid(storageGrid)
{
    storage_item_panels = {}
    let can_smelt_tab = current_storage_tab === "equipment"
    let items = GetFilteredStorageItems()
    for (let i = 0; i < 500; i++)
    {
        let cell = $.CreatePanel("Panel", storageGrid, "")
        cell.AddClass("StorageCell")
        if (!items[i]) continue
        RenderStorageCellItem(cell, items[i], can_smelt_tab)
    }
}

function RefreshStorageGridItems(storageGrid)
{
    storage_item_panels = {}
    let can_smelt_tab = current_storage_tab === "equipment"
    let items = GetFilteredStorageItems()
    let cells = storageGrid.Children()
    for (let i = 0; i < 500; i++)
    {
        let cell = cells[i]
        if (!cell) continue
        cell.RemoveAndDeleteChildren()
        if (items[i]) RenderStorageCellItem(cell, items[i], can_smelt_tab)
    }
}

function RenderStorageCellItem(cell, storage_item_data, can_smelt_tab)
{
    let StorageCellItem = $.CreatePanel("Panel", cell, "")
    StorageCellItem.AddClass("StorageCellItem")
    SetServiceItemTooltip(StorageCellItem, storage_item_data.item_id, storage_item_data.count, BuildEquipmentTooltipExtra(storage_item_data))
    storage_item_panels[String(storage_item_data.uid)] = StorageCellItem
    StorageCellItem.SetHasClass("StorageCellItemSelected", (storage_forge_mode && storage_item_data.item_type === "equipment" && String(forge_selected_uid) === String(storage_item_data.uid)) || (can_smelt_tab && storage_smelt_mode && !!storage_selected_uids[String(storage_item_data.uid)]))
    StorageCellItem.SetPanelEvent("onactivate", function()
    {
        if (storage_forge_mode && storage_item_data.item_type === "equipment")
        {
            SelectForgeItem(storage_item_data.uid)
            Game.EmitSound("General.ButtonClick")
            return
        }
        if (storage_smelt_mode && can_smelt_tab && storage_item_data.item_type === "equipment")
        {
            if (storage_item_data.locked) return
            let key = String(storage_item_data.uid)
            if (storage_selected_uids[key]) delete storage_selected_uids[key]
            else storage_selected_uids[key] = true
            StorageCellItem.SetHasClass("StorageCellItemSelected", !!storage_selected_uids[key])
            return
        }
        if (storage_item_data.item_type === "equipment")
        {
            GameEvents.SendCustomGameEventToServer("event_services_equip_item", { uid: storage_item_data.uid, config_id: current_equipment_config + 1 })
            Game.EmitSound("up_up_ui_armor_on")
        }
    })
    if (storage_item_data.item_type === "equipment")
    {
        StorageCellItem.SetPanelEvent("oncontextmenu", function()
        {
            ShowStorageItemContextMenu(StorageCellItem, storage_item_data)
        })
    }

    let StorageCellItemBG1 = $.CreatePanel("Panel", StorageCellItem, "")
    StorageCellItemBG1.AddClass("StorageCellItemBG1")
    if (storage_item_data.rarity && storage_item_data.rarity !== "common")
    {
        StorageCellItemBG1.AddClass("RareColor_" + storage_item_data.rarity)
    }

    let StorageCellItemBG2 = $.CreatePanel("Panel", StorageCellItem, "")
    StorageCellItemBG2.AddClass("StorageCellItemBG2")

    let icon = $.CreatePanel("Panel", StorageCellItem, "")
    icon.AddClass("StorageCellIcon")
    SetPanelImage(icon, storage_item_data.icon)

    AddSetIconOverlay(StorageCellItem, storage_item_data.set_id)
    AddStrengthenLevelOverlay(StorageCellItem, storage_item_data.strengthen_level)

    if ((Number(storage_item_data.count) || 1) > 1)
    {
        let count = $.CreatePanel("Label", StorageCellItem, "")
        count.AddClass("StorageCellItemCount")
        count.text = "x" + String(storage_item_data.count)
    }

    if (storage_item_data.locked)
    {
        let lock = $.CreatePanel("Panel", StorageCellItem, "")
        lock.AddClass("StorageCellLockIcon")
    }
}

function GetStorageItemByUid(uid)
{
    let items = equipment_data.storage_items[current_storage_tab] || []
    for (let i = 0; i < items.length; i++)
    {
        if (String(items[i].uid) === String(uid))
        {
            return items[i]
        }
    }
    return null
}

function GetInventoryPanelCenter(panel, scale)
{
    let pos = panel.GetPositionWithinWindow()
    let width = panel.actuallayoutwidth || panel.contentwidth || 0
    let height = panel.actuallayoutheight || panel.contentheight || 0
    return { x: (pos.x + width / 2) / scale, y: (pos.y + height / 2) / scale }
}

function AnimateSmeltItemsToFurnace(selected_uids)
{
    let furnace = $("#InventoryFurnaceParticle")
    if (!furnace || selected_uids.length <= 0)
    {
        return
    }

    let scale = Game.GetScreenHeight() / 1080
    let target_pos = GetInventoryPanelCenter(furnace, scale)
    let root = $.GetContextPanel()

    for (let i = 0; i < selected_uids.length; i++)
    {
        let uid = String(selected_uids[i])
        let source_panel = storage_item_panels[uid]
        let item_data = GetStorageItemByUid(uid)
        if (!source_panel || !source_panel.IsValid || !source_panel.IsValid() || !item_data || !item_data.icon)
        {
            continue
        }

        let source_pos = GetInventoryPanelCenter(source_panel, scale)
        let icon_size = Math.max(42, Math.min(72, (source_panel.actuallayoutwidth || 56) / scale))
        let half_size = icon_size / 2

        let fly_icon = $.CreatePanel("Panel", root, "")
        fly_icon.hittest = false
        fly_icon.style.width = icon_size + "px"
        fly_icon.style.height = icon_size + "px"
        fly_icon.style.x = (source_pos.x - half_size) + "px"
        fly_icon.style.y = (source_pos.y - half_size) + "px"
        fly_icon.style.zIndex = "1000"
        fly_icon.style.opacity = "1"
        fly_icon.style["pre-transform-scale2d"] = "1"
        fly_icon.style.transitionProperty = "position, opacity, pre-transform-scale2d"
        fly_icon.style.transitionDuration = "1.0s"
        fly_icon.style.transitionTimingFunction = "ease-in"
        SetPanelImage(fly_icon, item_data.icon)

        $.Schedule(0.03, function()
        {
            if (!fly_icon || !fly_icon.IsValid())
            {
                return
            }
            fly_icon.style.x = (target_pos.x - half_size * 0.25) + "px"
            fly_icon.style.y = (target_pos.y - half_size * 0.25) + "px"
            fly_icon.style.opacity = "0"
            fly_icon.style["pre-transform-scale2d"] = "0.25"
        })
        fly_icon.DeleteAsync(1.05)
    }
}
function RenderStorageButtons(storageButtons)
{
    if (current_storage_tab !== "equipment")
    {
        storage_smelt_mode = false
        storage_selected_uids = {}
        let hiddenSmeltButton = CreateLabeledButton(storageButtons, $.Localize("#services_inventory_smelt"))
        hiddenSmeltButton.style.opacity = "0"
        hiddenSmeltButton.hittest = false
        return
    }

    let smeltButton = CreateLabeledButton(storageButtons, storage_smelt_mode ? $.Localize("#services_common_accept") : $.Localize("#services_inventory_smelt"))
    smeltButton.SetPanelEvent("onactivate", function()
    {
        if (!storage_smelt_mode)
        {
            SetForgeMode(false)
            storage_smelt_mode = true
            storage_selected_uids = {}
            RefreshStorageColumn()
            Game.EmitSound("General.ButtonClick")
            return
        }
        let selected_uids = Object.keys(storage_selected_uids)
        if (selected_uids.length > 0)
        {
            AnimateSmeltItemsToFurnace(selected_uids)
            GameEvents.SendCustomGameEventToServer("event_services_smelt_items", { uids: selected_uids })
        }
        storage_smelt_mode = false
        storage_selected_uids = {}
        RefreshStorageColumn()
        Game.EmitSound("General.ButtonClick")
    })
    if (storage_smelt_mode)
    {
        let selectAllButton = CreateLabeledButton(storageButtons, $.Localize("#services_inventory_select_all"))
        selectAllButton.SetPanelEvent("onactivate", function()
        {
            let items = GetFilteredStorageItems()
            storage_selected_uids = {}
            for (let i = 0; i < items.length; i++)
            {
                let it = items[i]
                if (it && it.item_type === "equipment" && !it.locked)
                {
                    storage_selected_uids[String(it.uid)] = true
                }
            }
            RefreshStorageColumn()
            Game.EmitSound("General.ButtonClick")
        })

        let cancelButton = CreateLabeledButton(storageButtons, $.Localize("#services_common_cancel"))
        cancelButton.SetPanelEvent("onactivate", function()
        {
            storage_smelt_mode = false
            storage_selected_uids = {}
            RefreshStorageColumn()
            Game.EmitSound("General.ButtonClick")
        })
        return
    }

    let forgeButton = CreateLabeledButton(storageButtons, storage_forge_mode ? $.Localize("#services_common_cancel") : $.Localize("#services_forge"))
    forgeButton.SetPanelEvent("onactivate", function()
    {
        SetForgeMode(!storage_forge_mode)
        RefreshStorageColumn()
        Game.EmitSound("General.ButtonClick")
    })
}

function RenderStorageFilter(parent)
{
    let filterRow = $.CreatePanel("Panel", parent, "")
    filterRow.AddClass("StorageFilterRow")

    let button = $.CreatePanel("Panel", filterRow, "StorageFilterButton")
    button.AddClass("StorageFilterButton")

    let label = $.CreatePanel("Label", button, "StorageFilterLabel")
    label.AddClass("StorageFilterLabel")
    label.text = GetStorageFilterLabel()

    let arrow = $.CreatePanel("Panel", button, "")
    arrow.AddClass("StorageFilterArrow")

    button.SetPanelEvent("onactivate", function()
    {
        ShowStorageFilterContextMenu(button)
        Game.EmitSound("General.ButtonClick")
    })
}

function ShowStorageFilterContextMenu(anchorPanel)
{
    let contextMenu = $.CreatePanel("ContextMenuScript", anchorPanel, "", {})
    contextMenu.AddClass("ForgeContextMenuScript")
    let contents = contextMenu.GetContentsPanel()
    contents.BLoadLayout("file://{resources}/layout/custom_game/inventory_rarity_filter/inventory_rarity_filter.xml", false, false)

    function closeMenu()
    {
        if (contextMenu && contextMenu.IsValid && contextMenu.IsValid()) contextMenu.DeleteAsync(0)
    }

    let options = [""].concat(STORAGE_RARITIES)
    for (let i = 0; i < options.length; i++)
    {
        let rarity = options[i]
        let opt = contents.FindChildTraverse("FilterOpt_" + (rarity === "" ? "all" : rarity))
        if (!opt) continue
        opt.SetHasClass("StorageFilterOptionActive", storage_rarity_filter === rarity)
        opt.SetPanelEvent("onactivate", (function(r)
        {
            return function()
            {
                storage_rarity_filter = r
                let lbl = $("#StorageFilterLabel")
                if (lbl) lbl.text = GetStorageFilterLabel()
                RefreshStorageColumn()
                closeMenu()
                Game.EmitSound("General.ButtonClick")
            }
        })(rarity))
    }
}

function ShowStorageItemContextMenu(anchorPanel, storage_item_data)
{
    let uid = storage_item_data.uid
    let contextMenu = $.CreatePanel("ContextMenuScript", anchorPanel, "", {})
    contextMenu.AddClass("ForgeContextMenuScript")
    let contents = contextMenu.GetContentsPanel()
    contents.BLoadLayout("file://{resources}/layout/custom_game/inventory_item_context/inventory_item_context.xml", false, false)

    function closeMenu()
    {
        if (contextMenu && contextMenu.IsValid && contextMenu.IsValid()) contextMenu.DeleteAsync(0)
    }

    let lockLabel = contents.FindChildTraverse("ForgeContextLockLabel")
    if (lockLabel) lockLabel.text = $.Localize(storage_item_data.locked ? "#services_inventory_unlock" : "#services_inventory_lock")

    let forgeBtn = contents.FindChildTraverse("ForgeContextForgeBtn")
    if (forgeBtn)
    {
        forgeBtn.SetPanelEvent("onactivate", function()
        {
            SetForgeMode(true)
            SelectForgeItem(uid)
            RefreshStorageColumn()
            closeMenu()
            Game.EmitSound("General.ButtonClick")
        })
    }

    let lockBtn = contents.FindChildTraverse("ForgeContextLockBtn")
    if (lockBtn)
    {
        lockBtn.SetPanelEvent("onactivate", function()
        {
            GameEvents.SendCustomGameEventToServer("event_services_toggle_item_lock", { uid: String(uid) })
            closeMenu()
            Game.EmitSound("General.ButtonClick")
        })
    }
}

function RenderEquipmentTab()
{
    let root = $.CreatePanel("Panel", InventoryContentBody, "")
    root.AddClass("InventoryEquipmentRoot")

    let InventoryEquipmentRootContent = $.CreatePanel("Panel", root, "")
    InventoryEquipmentRootContent.AddClass("InventoryEquipmentRootContent")

    let InventoryEquipmentRootBG = $.CreatePanel("Panel", root, "")
    InventoryEquipmentRootBG.AddClass("InventoryEquipmentRootBG")
    let InventoryEquipmentRootBorder = $.CreatePanel("Panel", root, "")
    InventoryEquipmentRootBorder.AddClass("InventoryEquipmentRootBorder")
    
    let storage = $.CreatePanel("Panel", InventoryEquipmentRootContent, "")
    storage.AddClass("StorageColumn")

    let storageTitleRow = $.CreatePanel("Panel", storage, "")
    storageTitleRow.AddClass("InventoryHeaderRow")
    let storageTitle = $.CreatePanel("Label", storageTitleRow, "")
    storageTitle.AddClass("InventoryHeaderTitle")
    storageTitle.text = $.Localize("#services_inventory_storage")
    let storageCount = $.CreatePanel("Label", storageTitleRow, "InventoryStorageCount")
    storageCount.AddClass("InventoryHeaderMeta")
    storageCount.SetDialogVariable("value", String(equipment_data.storage_counts[current_storage_tab] || equipment_data.storage_count))
    storageCount.text = $.Localize("#services_inventory_items_count", storageCount)

    let storageTabs = $.CreatePanel("Panel", storage, "InventoryStorageTabs")
    storageTabs.AddClass("InventorySubTabsRow")
    for (let i = 0; i < equipment_data.storage_tabs.length; i++)
    {
        let tab = equipment_data.storage_tabs[i]
        let button = $.CreatePanel("Panel", storageTabs, "")
        button.AddClass("InventorySubTabButton")
        button.storage_tab_id = tab.id
        button.SetHasClass("InventorySubTabButtonActive", tab.id === current_storage_tab)
        button.SetPanelEvent("onactivate", (function(tab_id)
        {
            return function()
            {
                SetStorageTab(tab_id)
            }
        })(tab.id))
        let tabLabel = $.CreatePanel("Label", button, "")
        tabLabel.text = tab.title
    }

    RenderStorageFilter(storage)

    let storageGrid = $.CreatePanel("Panel", storage, "InventoryStorageGrid")
    storageGrid.AddClass("StorageGrid")
    RenderStorageGrid(storageGrid)

    let storageButtons = $.CreatePanel("Panel", storage, "InventoryStorageButtons")
    storageButtons.AddClass("StorageButtonsRow")
    RenderStorageButtons(storageButtons)

    let equipped = $.CreatePanel("Panel", InventoryEquipmentRootContent, "")
    equipped.AddClass("EquipmentColumn")
    CreateSectionTitle(equipped, $.Localize("#services_inventory_tab_equipment"))
    RenderConfigTabs(equipped, equipment_data.configs, current_equipment_config, function(index)
    {
        current_equipment_config = index
        GameEvents.SendCustomGameEventToServer("event_services_set_equipment_config", { config_id: index + 1 })
    })

    let grid = $.CreatePanel("Panel", equipped, "EquipmentSlotsGrid")
    grid.AddClass("EquipmentSlotsGrid")
    RenderEquipmentSlots(grid)

    let statsTitle_ = $.CreatePanel("Label", equipped, "")
    statsTitle_.AddClass("ForgeStatsTitle")
    statsTitle_.text = $.Localize("#services_inventory_equipment_stats")

    let stats_item_info = $.CreatePanel("Panel", equipped, "EquipmentStatsList")
    stats_item_info.AddClass("stats_item_info")
    RenderEquippedSetsRow(stats_item_info)
    RenderStatRows(stats_item_info, equipment_data.equipment_stats)

    let forge = $.CreatePanel("Panel", InventoryEquipmentRootContent, "ForgeSmelterColumn")
    forge.AddClass("ForgeColumn")
    CreateSectionTitle(forge, $.Localize("#services_inventory_forge"))

    let ForgeFurnaceFrame = $.CreatePanel("Panel", forge, "")
    ForgeFurnaceFrame.AddClass("ForgeFurnaceFrame")

    let furnace_particle = $.CreatePanel("DOTAParticleScenePanel", ForgeFurnaceFrame, "InventoryFurnaceParticle", {particleName:"particles/slyrak_background_fire_base.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"860 0 0", lookAt:"0 240 0", fov:"60"})
    furnace_particle.AddClass("furnace_particle")
    furnace_particle.hittest = false

    let furnace_particle_lava = $.CreatePanel("DOTAParticleScenePanel", ForgeFurnaceFrame, "", {particleName:"particles/lava_furnace/lava_furnace.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 250", lookAt:"0 0 0", fov:"20"})
    furnace_particle_lava.AddClass("furnace_particle_lava")
    furnace_particle_lava.hittest = false

    $.CreatePanel("Panel", ForgeFurnaceFrame, "").AddClass("ForgeFurnaceFrame2")

    let progress = $.CreatePanel("Panel", forge, "")
    progress.AddClass("ForgeProgressBar")

    let progressBG = $.CreatePanel("Panel", progress, "")
    progressBG.AddClass("progressBG")

    let progressline = $.CreatePanel("Panel", progress, "")
    progressline.AddClass("ForgeProgressBarLine")

    let fill = $.CreatePanel("Panel", progressline, "ForgeProgressFill")
    fill.AddClass("ForgeProgressFill")
    fill.style.width = Math.min(100, (equipment_data.forge.progress / equipment_data.forge.max_progress) * 100) + "%"

    let progress_level = $.CreatePanel("Label", progress, "ForgeProgressLevel")
    progress_level.AddClass("progress_level")
    progress_level.text = equipment_data.forge.level

    let furnace_particle_level = $.CreatePanel("DOTAParticleScenePanel", progress, "", {particleName:"particles/furnace_level_a/furnace_level_a.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 250", lookAt:"0 0 0", fov:"20"})
    furnace_particle_level.AddClass("furnace_particle_level")
    furnace_particle_level.hittest = false
    
    let progress_line = $.CreatePanel("Label", progressline, "ForgeProgressLine")
    progress_line.AddClass("progress_line")
    progress_line.text = equipment_data.forge.progress + "/" + equipment_data.forge.max_progress

    let how_to_up_forge = $.CreatePanel("Panel", forge, "")
    how_to_up_forge.AddClass("how_to_up_forge")

    let how_to_up_forge_icon = $.CreatePanel("Panel", how_to_up_forge, "")
    how_to_up_forge_icon.AddClass("how_to_up_forge_icon")
    ShowTextForPanel(how_to_up_forge_icon, $.Localize("#services_inventory_forge_help_tooltip"))

    let how_to_up_forge_label = $.CreatePanel("Label", how_to_up_forge, "")
    how_to_up_forge_label.AddClass("how_to_up_forge_label")
    how_to_up_forge_label.text = $.Localize("#services_inventory_forge_help")

    let statsTitle = $.CreatePanel("Label", forge, "")
    statsTitle.AddClass("ForgeStatsTitle")
    statsTitle.text = $.Localize("#services_inventory_forge_stats")

    let statsBox = $.CreatePanel("Panel", forge, "ForgeStatsBox")
    statsBox.AddClass("ForgeStatsBox")
    RenderStatRows(statsBox, equipment_data.forge.stats)

    let forgeCraft = $.CreatePanel("Panel", InventoryEquipmentRootContent, "ForgeCraftPanel")
    forgeCraft.AddClass("ForgeCraftPanel")
    RenderForgeCraftPanel(forgeCraft)
    ApplyForgeModeVisibility()
}

function RenderEquipmentSlots(grid)
{
    for (let i = 0; i < equipment_data.set_slots.length; i++)
    {
        let slot = equipment_data.set_slots[i]
        let item = $.CreatePanel("Panel", grid, "EquipmentSetSlot_" + slot.slot)
        item.AddClass("EquipmentSetSlot")
        item.AddClass("EquipmentSetSlot"+i)
        RenderEquipmentSlotContents(item, slot)
    }
}

function GetEquipmentSlotSignature(slot)
{
    if (!slot) return ""
    return [
        String(slot.uid || ""),
        String(slot.icon || ""),
        String(slot.rarity || ""),
        String(slot.strengthen_level || 0),
        String(slot.set_id || ""),
        String(slot.potential || 0),
        String(slot.potential_reforge_attempts || 0),
        JSON.stringify(slot.normal_stats || []),
        JSON.stringify(slot.random_stats || []),
    ].join("|")
}

function RenderEquipmentSlotContents(item, slot)
{
    item.RemoveAndDeleteChildren()
    item.rendered_uid = String(slot.uid || "")
    item.rendered_signature = GetEquipmentSlotSignature(slot)
    item.SetHasClass("EquipmentSetSlotEmpty", !slot.icon)
    item.SetHasClass("EquipmentSetSlotForgeSelected", storage_forge_mode && !!slot.icon && !!slot.generated && String(forge_selected_uid) === String(slot.uid || ""))
    item.SetPanelEvent("onactivate", (function(slot_id, has_item, slot_uid, is_generated)
    {
        return function()
        {
            if (!has_item) return
            if (storage_forge_mode)
            {
                if (!is_generated) return
                SelectForgeItem(slot_uid)
                Game.EmitSound("General.ButtonClick")
                return
            }
            GameEvents.SendCustomGameEventToServer("event_services_unequip_item", { slot: slot_id, config_id: current_equipment_config + 1 })
            Game.EmitSound("up_up_ui_armor_off")
        }
    })(slot.slot, !!slot.icon, slot.uid, !!slot.generated))
    
    if (slot.icon)
    {
        let EquipmentSetSlotItem = $.CreatePanel("Panel", item, "")
        EquipmentSetSlotItem.AddClass("EquipmentSetSlotItem")
        SetServiceItemTooltip(EquipmentSetSlotItem, slot.item_id, 1, BuildEquipmentTooltipExtra(slot))

        let EquipmentSetSlotItemBG1 = $.CreatePanel("Panel", EquipmentSetSlotItem, "")
        EquipmentSetSlotItemBG1.AddClass("EquipmentSetSlotItemBG1")
        if (slot.rarity && slot.rarity !== "common")
        {
            EquipmentSetSlotItemBG1.AddClass("RareColor_" + slot.rarity)
        }

        let EquipmentSetSlotItemBG2 = $.CreatePanel("Panel", EquipmentSetSlotItem, "")
        EquipmentSetSlotItemBG2.AddClass("EquipmentSetSlotItemBG2")

        let icon = $.CreatePanel("Panel", EquipmentSetSlotItem, "")
        icon.AddClass("EquipmentSetSlotIcon")
        SetPanelImage(icon, slot.icon)

        AddSetIconOverlay(EquipmentSetSlotItem, slot.set_id)
        AddStrengthenLevelOverlay(EquipmentSetSlotItem, slot.strengthen_level)
    }
    else
    {
        let icon_without_item = $.CreatePanel("Panel", item, "")
        icon_without_item.AddClass("icon_without_item")
    }

    let border_particle = $.CreatePanel("DOTAParticleScenePanel", item, "", {particleName:"particles/item_rare_border.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"160 0 0", lookAt:"0 0 0", fov:"52"})
    border_particle.AddClass("set_rarity_scene")
    border_particle.hittest = false
}

function RenderStatRows(parent, rows)
{
    for (let i = 0; i < rows.length; i++)
    {
        let stat_panel = $.CreatePanel("Label", parent, "")
        stat_panel.AddClass("ForgeStatPanel")

        let stat_panel_label = $.CreatePanel("Label", stat_panel, "")
        stat_panel_label.AddClass("ForgeStatLabel")
        stat_panel_label.text = rows[i].name || rows[i]

        let stat = $.CreatePanel("Label", stat_panel, "")
        stat.AddClass("ForgeStatLabel2")
        stat.text = rows[i].value || ""
    }
}

function RefreshEquipmentSlots()
{
    let grid = $("#EquipmentSlotsGrid")
    if (!grid) return
    for (let i = 0; i < equipment_data.set_slots.length; i++)
    {
        let slot = equipment_data.set_slots[i]
        let panel = $("#EquipmentSetSlot_" + slot.slot)
        if (!panel)
        {
            grid.RemoveAndDeleteChildren()
            RenderEquipmentSlots(grid)
            return
        }
        if (panel.rendered_signature !== GetEquipmentSlotSignature(slot))
        {
            RenderEquipmentSlotContents(panel, slot)
        }
    }
}

function RefreshEquipmentStats()
{
    let stats = $("#EquipmentStatsList")
    if (!stats) return
    stats.RemoveAndDeleteChildren()
    RenderEquippedSetsRow(stats)
    RenderStatRows(stats, equipment_data.equipment_stats)
}

function RefreshForgePanel()
{
    let fill = $("#ForgeProgressFill")
    if (fill) fill.style.width = Math.min(100, (equipment_data.forge.progress / equipment_data.forge.max_progress) * 100) + "%"
    let level = $("#ForgeProgressLevel")
    if (level) level.text = equipment_data.forge.level
    let line = $("#ForgeProgressLine")
    if (line) line.text = equipment_data.forge.progress + "/" + equipment_data.forge.max_progress
    let stats = $("#ForgeStatsBox")
    if (stats)
    {
        stats.RemoveAndDeleteChildren()
        RenderStatRows(stats, equipment_data.forge.stats)
    }
}

function CanUnequipAppearanceItem(item)
{
    return item && item.equipped && item.appearance_type !== "start_hero"
}

function GetAppearanceApplyButtonText(item)
{
    if (!item) return $.Localize("#services_common_apply")
    if (CanUnequipAppearanceItem(item)) return $.Localize("#services_common_unequip")
    return item.equipped ? $.Localize("#services_common_equipped") : $.Localize("#services_common_apply")
}

function ActivateSelectedAppearanceItem(group, selected_item)
{
    if (!group || !selected_item || !selected_item.show_button) return

    if (CanUnequipAppearanceItem(selected_item))
    {
        selected_item.equipped = false
        RefreshAppearancePanels()
        GameEvents.SendCustomGameEventToServer("event_services_set_appearance", { item_id: "", appearance_type: selected_item.appearance_type })
        Game.EmitSound("up_up_ui_visual_off")
        return
    }

    if (selected_item.equipped) return

    for (let i = 0; i < group.items.length; i++)
    {
        group.items[i].equipped = false
    }
    selected_item.equipped = true
    RefreshAppearancePanels()
    GameEvents.SendCustomGameEventToServer("event_services_set_appearance", { item_id: selected_item.item_id, appearance_type: selected_item.appearance_type })
    Game.EmitSound("up_up_ui_visual_on")
}

function RenderAppearanceNeedPanel(parent, selected_item)
{
    if (!parent || !selected_item || selected_item.hide_need) return

    let needPanel = $.CreatePanel("Panel", parent, "")
    needPanel.AddClass("AppearanceNeedPanel")

    let needTitle = $.CreatePanel("Label", needPanel, "")
    needTitle.AddClass("AppearanceNeedTitle")
    needTitle.text = $.Localize("#services_inventory_required_count")
    
    let needRow = $.CreatePanel("Panel", needPanel, "")
    needRow.AddClass("AppearanceNeedRow")

    let needItem = $.CreatePanel("Panel", needRow, "")
    needItem.AddClass("AppearanceNeedItem")

    let needItemBG = $.CreatePanel("Panel", needItem, "")
    needItemBG.AddClass("AppearanceNeedItemBG")

    let needItemBG2 = $.CreatePanel("Panel", needItem, "")
    needItemBG2.AddClass("AppearanceNeedItemBG2")
    if (selected_item.rarity && selected_item.rarity !== "common")
    {
        needItemBG.AddClass("RareColor_" + selected_item.rarity)
    }
    
    let needIcon = $.CreatePanel("Panel", needItem, "")
    needIcon.AddClass("AppearanceNeedIcon")
    SetPanelImage(needIcon, selected_item.image) 

    let needText = $.CreatePanel("Label", needRow, "")
    needText.AddClass("AppearanceNeedText")
    needText.text = selected_item.need
}
function RenderAppearanceTab()
{
    let root = $.CreatePanel("Panel", InventoryContentBody, "")
    root.AddClass("InventoryAppearanceRoot")

    let InventoryAppearanceRootBG = $.CreatePanel("Panel", root, "")
    InventoryAppearanceRootBG.AddClass("InventoryAppearanceRootBG")

    let subMenu = $.CreatePanel("Panel", root, "")
    subMenu.AddClass("AppearanceSubmenu")
    for (let i = 0; i < appearance_subtabs.length; i++)
    {
        let tab = appearance_subtabs[i]
        let button = $.CreatePanel("Panel", subMenu, "")
        button.AddClass("AppearanceSubmenuButton")
        button.AddClass("AppearanceSubmenuButton"+i)

        let AppearanceSubmenuButtonBG = $.CreatePanel("Panel", button, "")
        AppearanceSubmenuButtonBG.AddClass("AppearanceSubmenuButtonBG")

        button.SetHasClass("AppearanceSubmenuButtonActive", tab.id === current_appearance_subtab)
        button.SetPanelEvent("onactivate", (function(tab_id)
        {
            return function()
            {
                current_appearance_subtab = tab_id
                RenderInventoryContent()
            }
        })(tab.id))
        $.CreatePanel("Label", button, "").text = tab.title
    }

    let itemList = $.CreatePanel("Panel", root, "")
    itemList.AddClass("AppearanceItemsColumn")
    itemList.style.overflow = "squish scroll"

    let itemGrid = $.CreatePanel("Panel", itemList, "AppearanceItemGrid")
    itemGrid.AddClass("AppearanceItemGrid")

    let group = appearance_data[current_appearance_subtab]
    let selected_item = group.items[group.selected]
    for (let i = 0; i < group.items.length; i++)
    {
        let item = group.items[i]
        let card = $.CreatePanel("Panel", itemGrid, "")
        card.AddClass("AppearanceCard")
        if (item.rarity)
        {
            card.AddClass("RarityCard_"+item.rarity)
        }
        card.appearance_index = i

        let AppearanceCardBG = $.CreatePanel("Panel", card, "")
        AppearanceCardBG.AddClass("AppearanceCardBG")
        AppearanceCardBG.hittest = false

        let item_fx_inventory = $.CreatePanel("DOTAParticleScenePanel", AppearanceCardBG, "", {particleName:"particles/item_fx_inventory/item_fx_inventory.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"160 0 0", lookAt:"0 0 0", fov:"52"})
        item_fx_inventory.AddClass("item_fx_inventory")
        item_fx_inventory.hittest = false

        card.SetHasClass("AppearanceCardActive", i === group.selected)
        card.SetHasClass("AppearanceCardEquipped", item.equipped)
        card.SetHasClass("AppearanceCardLocked", item.stars === 0 && !item.show_button)
        card.SetPanelEvent("onactivate", (function(index)
        {
            return function()
            {
                SelectAppearanceItem(index)
            }
        })(i))

        let preview = $.CreatePanel("Panel", card, "")
        preview.AddClass("AppearanceCardPreview")
        preview.hittest = false
        SetPanelImage(preview, item.image)
        let name = $.CreatePanel("Label", card, "")
        name.AddClass("AppearanceCardName")
        name.hittest = false
        name.text = item.name
    }

    let center = $.CreatePanel("Panel", root, "AppearancePreviewColumn")
    center.AddClass("AppearancePreviewColumn")

    let AppearancePreviewColumnBG = $.CreatePanel("Panel", center, "")
    AppearancePreviewColumnBG.AddClass("AppearancePreviewColumnBG")

    let art = $.CreatePanel("Panel", center, "")
    art.AddClass("AppearanceBigPreview")
    let artIcon = $.CreatePanel("Panel", art, "")
    artIcon.AddClass("AppearanceBigPreviewIcon")
    SetPanelImage(artIcon, selected_item.preview_image)
    
    let desc_panel = $.CreatePanel("Panel", center, "")
    desc_panel.AddClass("AppearanceDescriptionPanel")

    let desc_title = $.CreatePanel("Label", desc_panel, "")
    desc_title.AddClass("AppearanceDescriptionTitle")
    desc_title.text = selected_item.name

    if (selected_item.appearance_type === "start_hero" && selected_item.hero_abilities.length > 0)
    {
        let abilities_panel = $.CreatePanel("Panel", desc_panel, "")
        abilities_panel.AddClass("AppearanceHeroAbilities")

        for (let ability_name of selected_item.hero_abilities)
        {
            let ability = $.CreatePanel("Panel", abilities_panel, "")
            ability.AddClass("AppearanceHeroAbility")
            SetPanelImage(ability, GetAbilityIconPath(ability_name))
            SetCustomTooltip(ability, "ability_tooltip", { ability_name: ability_name })
        }
    }
    else
    {
        let desc = $.CreatePanel("Label", desc_panel, "")
        desc.AddClass("AppearanceDescription")
        // У помощников нет обычных stats; respawn и inherit выводятся в строках
        // уровня, а здесь оставляем общее текстовое описание.
        desc.text = (selected_item.appearance_type === "assistant" && selected_item.description)
            ? selected_item.description
            : selected_item.bonuses.join("\n")

        if ((selected_item.appearance_type === "pet" || selected_item.appearance_type === "assistant") && selected_item.special_bonuses.length > 0)
        {
            let specialPanel = $.CreatePanel("Panel", desc_panel, "")
            specialPanel.AddClass("AppearanceSpecialBonusPanel")

            let specialTitle = $.CreatePanel("Label", specialPanel, "")
            specialTitle.AddClass("AppearanceSpecialBonusTitle")
            specialTitle.text = $.Localize("#services_pet_special_bonus_title")

            for (let special_info of selected_item.special_bonuses)
            {
                let row = $.CreatePanel("Panel", specialPanel, "")
                row.AddClass("AppearanceSpecialBonusRow")
                row.SetHasClass("AppearanceSpecialBonusRowLocked", !special_info.unlocked)

                let stars = $.CreatePanel("Label", row, "")
                stars.AddClass("AppearanceSpecialBonusStars")
                stars.text = special_info.level + "★"

                let text = $.CreatePanel("Label", row, "")
                text.AddClass("AppearanceSpecialBonusText")
                text.text = special_info.description
            }
        }
    }
    
    let applyButton = CreateLabeledButton(center, GetAppearanceApplyButtonText(selected_item), "InventoryActionButton2", "AppearanceApplyButton")
    UpdateAppearanceApplyButtonState(applyButton, selected_item)
    applyButton.SetPanelEvent("onactivate", function()
    {
        ActivateSelectedAppearanceItem(group, selected_item)
    })

    let right = $.CreatePanel("Panel", root, "AppearanceInfoColumn")
    right.AddClass("AppearanceInfoColumn")
    let infoCard = $.CreatePanel("Panel", right, "")
    infoCard.AddClass("AppearanceInfoCard")
    let mini = $.CreatePanel("Panel", infoCard, "")
    mini.AddClass("AppearanceInfoMiniIcon")
    SetPanelImage(mini, selected_item.preview_image)
    let title = $.CreatePanel("Label", infoCard, "")
    title.AddClass("AppearanceInfoTitle")
    title.text = $.Localize("#services_inventory_upgrade_progress")

    let levelsScroll = $.CreatePanel("Panel", infoCard, "")
    levelsScroll.AddClass("AppearanceLevelScroll")

    for (let level_info of selected_item.level_bonuses)
    {
        let block = $.CreatePanel("Panel", levelsScroll, "")
        block.AddClass("AppearanceLevelBlock")
        block.SetHasClass("AppearanceLevelBlockLocked", !level_info.unlocked)
        let starsRow = $.CreatePanel("Panel", block, "")
        starsRow.AddClass("AppearanceStarsRow")
        for (let i = 0; i < level_info.level; i++)
        {
            let star = $.CreatePanel("Panel", starsRow, "")
            star.AddClass("AppearanceStar")
        }
        for (let bonus_data of level_info.bonuses)
        {
            let line = $.CreatePanel("Panel", block, "")
            line.AddClass("AppearanceBonusLine")

            let AppearanceBonusLineBonus_1 = $.CreatePanel("Label", line, "")
            AppearanceBonusLineBonus_1.AddClass("AppearanceBonusLineBonus_1")
            AppearanceBonusLineBonus_1.text = bonus_data.name || bonus_data

            let AppearanceBonusLineBonus_2 = $.CreatePanel("Label", line, "")
            AppearanceBonusLineBonus_2.AddClass("AppearanceBonusLineBonus_2")
            AppearanceBonusLineBonus_2.text = bonus_data.value || ""
        }
    }
    RenderAppearanceNeedPanel(infoCard, selected_item)
}

function RefreshAppearancePanels()
{
    let group = appearance_data[current_appearance_subtab]
    if (!group || !group.items.length) return

    let itemGrid = $("#AppearanceItemGrid")
    if (itemGrid)
    {
        let cards = itemGrid.Children()
        for (let i = 0; i < cards.length; i++)
        {
            let card = cards[i]
            let item = group.items[card.appearance_index]
            if (!item) continue
            card.SetHasClass("AppearanceCardActive", card.appearance_index === group.selected)
            card.SetHasClass("AppearanceCardEquipped", item.equipped)
            card.SetHasClass("AppearanceCardLocked", item.stars === 0 && !item.show_button)
        }
    }

    let selected_item = group.items[group.selected]
    let applyButton = $("#AppearanceApplyButton")
    if (applyButton && selected_item)
    {
        UpdateAppearanceApplyButtonState(applyButton, selected_item)
        applyButton.SetPanelEvent("onactivate", function()
        {
            ActivateSelectedAppearanceItem(group, selected_item)
        })
    }
}

function SelectAppearanceItem(index)
{
    let group = appearance_data[current_appearance_subtab]
    if (!group || !group.items || !group.items[index])
    {
        return
    }

    group.selected = index
    RefreshAppearancePanels()
    RebuildAppearanceSidePanels()
}

function RebuildAppearanceSidePanels()
{
    let group = appearance_data[current_appearance_subtab]
    if (!group || !group.items.length) return

    let itemGrid = InventoryContentBody && InventoryContentBody.FindChildTraverse("AppearanceItemGrid")
    let root = itemGrid && itemGrid.GetParent && itemGrid.GetParent().GetParent()
    if (!root) return

    let center = root.FindChildTraverse("AppearancePreviewColumn")
    let right = root.FindChildTraverse("AppearanceInfoColumn")
    if (!center)
    {
        center = $.CreatePanel("Panel", root, "AppearancePreviewColumn")
        center.AddClass("AppearancePreviewColumn")
    }
    else
    {
        center.RemoveAndDeleteChildren()
    }

    if (!right)
    {
        right = $.CreatePanel("Panel", root, "AppearanceInfoColumn")
        right.AddClass("AppearanceInfoColumn")
    }
    else
    {
        right.RemoveAndDeleteChildren()
    }

    let selected_item = group.items[group.selected]

    let AppearancePreviewColumnBG = $.CreatePanel("Panel", center, "")
    AppearancePreviewColumnBG.AddClass("AppearancePreviewColumnBG")

    let art = $.CreatePanel("Panel", center, "")
    art.AddClass("AppearanceBigPreview")
    let artIcon = $.CreatePanel("Panel", art, "")
    artIcon.AddClass("AppearanceBigPreviewIcon")
    SetPanelImage(artIcon, selected_item.preview_image)

    let desc_panel = $.CreatePanel("Panel", center, "")
    desc_panel.AddClass("AppearanceDescriptionPanel")

    let desc_title = $.CreatePanel("Label", desc_panel, "")
    desc_title.AddClass("AppearanceDescriptionTitle")
    desc_title.text = selected_item.name

    if (selected_item.appearance_type === "start_hero" && selected_item.hero_abilities.length > 0)
    {
        let abilities_panel = $.CreatePanel("Panel", desc_panel, "")
        abilities_panel.AddClass("AppearanceHeroAbilities")
        for (let ability_name of selected_item.hero_abilities)
        {
            let ability = $.CreatePanel("Panel", abilities_panel, "")
            ability.AddClass("AppearanceHeroAbility")
            SetPanelImage(ability, GetAbilityIconPath(ability_name))
            SetCustomTooltip(ability, "ability_tooltip", { ability_name: ability_name })
        }
    }
    else
    {
        let desc = $.CreatePanel("Label", desc_panel, "")
        desc.AddClass("AppearanceDescription")
        // У помощников нет обычных stats; respawn и inherit выводятся в строках
        // уровня, а здесь оставляем общее текстовое описание.
        desc.text = (selected_item.appearance_type === "assistant" && selected_item.description)
            ? selected_item.description
            : selected_item.bonuses.join("\n")

        if ((selected_item.appearance_type === "pet" || selected_item.appearance_type === "assistant") && selected_item.special_bonuses.length > 0)
        {
            let specialPanel = $.CreatePanel("Panel", desc_panel, "")
            specialPanel.AddClass("AppearanceSpecialBonusPanel")

            let specialTitle = $.CreatePanel("Label", specialPanel, "")
            specialTitle.AddClass("AppearanceSpecialBonusTitle")
            specialTitle.text = $.Localize("#services_pet_special_bonus_title")

            for (let special_info of selected_item.special_bonuses)
            {
                let row = $.CreatePanel("Panel", specialPanel, "")
                row.AddClass("AppearanceSpecialBonusRow")
                row.SetHasClass("AppearanceSpecialBonusRowLocked", !special_info.unlocked)

                let stars = $.CreatePanel("Label", row, "")
                stars.AddClass("AppearanceSpecialBonusStars")
                stars.text = special_info.level + "★"

                let text = $.CreatePanel("Label", row, "")
                text.AddClass("AppearanceSpecialBonusText")
                text.text = special_info.description
            }
        }
    }

    let applyButton = CreateLabeledButton(center, GetAppearanceApplyButtonText(selected_item), "InventoryActionButton2", "AppearanceApplyButton")
    UpdateAppearanceApplyButtonState(applyButton, selected_item)
    applyButton.SetPanelEvent("onactivate", function()
    {
        ActivateSelectedAppearanceItem(group, selected_item)
    })

    let infoCard = $.CreatePanel("Panel", right, "")
    infoCard.AddClass("AppearanceInfoCard")
    let mini = $.CreatePanel("Panel", infoCard, "")
    mini.AddClass("AppearanceInfoMiniIcon")
    SetPanelImage(mini, selected_item.preview_image)
    let title = $.CreatePanel("Label", infoCard, "")
    title.AddClass("AppearanceInfoTitle")
    title.text = $.Localize("#services_inventory_upgrade_progress")

    let levelsScroll = $.CreatePanel("Panel", infoCard, "")
    levelsScroll.AddClass("AppearanceLevelScroll")
    for (let level_info of selected_item.level_bonuses)
    {
        let block = $.CreatePanel("Panel", levelsScroll, "")
        block.AddClass("AppearanceLevelBlock")
        block.SetHasClass("AppearanceLevelBlockLocked", !level_info.unlocked)
        let starsRow = $.CreatePanel("Panel", block, "")
        starsRow.AddClass("AppearanceStarsRow")
        for (let i = 0; i < level_info.level; i++) $.CreatePanel("Panel", starsRow, "").AddClass("AppearanceStar")
        for (let bonus_data of level_info.bonuses)
        {
            let line = $.CreatePanel("Panel", block, "")
            line.AddClass("AppearanceBonusLine")
            let name = $.CreatePanel("Label", line, "")
            name.AddClass("AppearanceBonusLineBonus_1")
            name.text = bonus_data.name || bonus_data
            let value = $.CreatePanel("Label", line, "")
            value.AddClass("AppearanceBonusLineBonus_2")
            value.text = bonus_data.value || ""
        }
    }
    RenderAppearanceNeedPanel(infoCard, selected_item)
}

function UpdateAppearanceApplyButtonState(button, item)
{
    if (!button || !item) return
    SetButtonText(button, GetAppearanceApplyButtonText(item))
    button.SetHasClass("InventoryActionButtonDisabled", (item.equipped && !CanUnequipAppearanceItem(item)) || !item.show_button)
    button.SetHasClass("AppearanceApplyButtonLocked", !item.show_button)
    button.SetHasClass("AppearanceApplyButtonUnequip", CanUnequipAppearanceItem(item))
    button.hittest = (!!item.show_button && (!item.equipped || CanUnequipAppearanceItem(item)))
}

var companion_selected_index = 0
var companion_cards_grid = null
var companion_center_panel = null

function GetCompanionList()
{
    let group = appearance_data.assistant || { items: [] }
    let items = (group.items || []).slice()
    items.sort(function(a, b)
    {
        let ao = a.owned ? 0 : 1
        let bo = b.owned ? 0 : 1
        if (ao !== bo) return ao - bo
        let ap = Number(a.companion_coin_price) || 0
        let bp = Number(b.companion_coin_price) || 0
        if (ap !== bp) return ap - bp
        return (a.order_index || 999999) - (b.order_index || 999999)
    })
    return items
}

function GetCompanionCoinBalance()
{
    let economy = (GetServicePlayerData() || {}).economy_data || {}
    return Number(economy.companion_coin) || 0
}

function GetCompanionCoinIcon()
{
    let items = (Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}) || {}
    let item = items.companion_coin || {}
    return item.icon || "file://{images}/game_hud/services/companion_coin.png"
}

function GetRarityLabel(rarity)
{
    return $.Localize("#services_rarity_" + String(rarity || "common"))
}

var COMPANION_MAX_STARS = 5

function BuildCompanionStarTooltipData(item, level)
{
    if (!item) return null

    let bonuses = []
    for (let level_info of (item.level_bonuses || []))
    {
        if (level_info.level !== level) continue
        for (let b of (level_info.bonuses || []))
        {
            let nm = (b && b.name) ? b.name : String(b || "")
            let val = (b && b.value) ? b.value : ""
            bonuses.push({ name: nm, value: val })
        }
        break
    }
    if (!bonuses.length) return null

    return { level: level, max: COMPANION_MAX_STARS, bonuses: bonuses }
}

function RenderCompanionStars(parent, count, max, is_current, item)
{
    let total = Number(max) || COMPANION_MAX_STARS
    let lit = Number(count) || 0
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass(is_current ? "CompanionStarsRowCurrent" : "CompanionStarsRow")
    for (let i = 0; i < total; i++)
    {
        let star = $.CreatePanel("Panel", row, "")
        star.AddClass("CompanionStar")
        star.SetHasClass("CompanionStarLit", i < lit)
        star.SetHasClass("CompanionStarDim", i >= lit)

        if (item)
        {
            let tip = BuildCompanionStarTooltipData(item, i + 1)
            if (tip)
            {
                star.hittest = true
                SetCustomTooltip(star, "assistant_star_tooltip", tip)
            }
        }
    }
    return row
}

function RenderCompanionBlessingStars(parent, count, max)
{
    let total = Number(max) || COMPANION_MAX_STARS
    let lit = Number(count) || 0
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("CompanionBlessingStarRow")
    for (let i = 0; i < total; i++)
    {
        let star = $.CreatePanel("Panel", row, "")
        star.AddClass("CompanionBlessingStar")
        star.SetHasClass("CompanionBlessingStarLit", i < lit)
        star.SetHasClass("CompanionBlessingStarDim", i >= lit)
    }
    return row
}

function RenderCompanionStatRows(parent, rows)
{
    for (let i = 0; i < rows.length; i++)
    {
        let stat_panel = $.CreatePanel("Label", parent, "")
        stat_panel.AddClass("CompanionStatPanel")

        let stat_panel_label = $.CreatePanel("Label", stat_panel, "")
        stat_panel_label.AddClass("CompanionStatLabel")
        stat_panel_label.text = rows[i].name || rows[i]

        let stat = $.CreatePanel("Label", stat_panel, "")
        stat.AddClass("CompanionStatLabel2")
        stat.text = rows[i].value || ""
    }
}

function RenderCompanionAbilities(parent, item)
{
    if (!item || !item.special_bonuses || !item.special_bonuses.length) return
    let panel = $.CreatePanel("Panel", parent, "")
    panel.AddClass("CompanionSpecialPanel")
    let title = $.CreatePanel("Label", panel, "")
    title.AddClass("CompanionSpecialTitle")
    title.text = $.Localize("#services_companion_ability_title")
    for (let special_info of item.special_bonuses)
    {
        let row = $.CreatePanel("Panel", panel, "")
        row.AddClass("CompanionSpecialRow")
        row.SetHasClass("CompanionSpecialRowLocked", !special_info.unlocked)
        let text = $.CreatePanel("Label", row, "")
        text.AddClass("CompanionSpecialText")
        text.text = special_info.description
    }
}

function RenderCompanionInfo(parent, item)
{
    let name = $.CreatePanel("Label", parent, "")
    name.AddClass("CompanionInfoName")
    name.text = item.name

    let meta = $.CreatePanel("Panel", parent, "")
    meta.AddClass("CompanionInfoMeta")

    let type = $.CreatePanel("Label", meta, "")
    type.AddClass("CompanionInfoType")
    type.text = item.companion_type || ""

    let rarity = $.CreatePanel("Label", meta, "")
    rarity.AddClass("CompanionInfoRarity")
    rarity.AddClass("CompanionRarity_" + (item.rarity || "common"))
    rarity.text = GetRarityLabel(item.rarity)

    RenderCompanionStars(parent, item.stars, (item.level_bonuses && item.level_bonuses.length) || COMPANION_MAX_STARS, true, item)

    RenderCompanionXpBar(parent, item)

    let display_level = Math.max(1, Number(item.stars) || 0)
    let statRows = []
    for (let level_info of (item.level_bonuses || []))
    {
        if (level_info.level === display_level)
        {
            statRows = level_info.bonuses || []
        }
    }
    if (statRows.length) RenderCompanionStatRows(parent, statRows)

    RenderCompanionAbilities(parent, item)
}

function EquipCompanion(item)
{
    if (!item || !item.owned || item.equipped) return
    GameEvents.SendCustomGameEventToServer("event_services_set_appearance", { item_id: item.item_id, appearance_type: "assistant" })
    Game.EmitSound("up_up_ui_visual_on")
}

function GetCompanionMaxStars(item)
{
    return (item && item.level_bonuses && item.level_bonuses.length) || COMPANION_MAX_STARS
}

function IsCompanionMaxed(item)
{
    return !!item && item.owned && (Number(item.stars) || 0) >= GetCompanionMaxStars(item)
}

function GetCompanionPreviewImage(item)
{
    if (item && item.preview_unit)
    {
        return "file://{images}/store_items/comp_preview/" + item.preview_unit + ".png"
    }
    return (item && item.image) || ""
}

function RenderCompanionXpBar(parent, item)
{
    let parts = String(item.need || "0/1").split("/")
    let current = Number(parts[0]) || 0
    let required = Number(parts[1]) || 0
    let maxed = IsCompanionMaxed(item)

    let wrap = $.CreatePanel("Panel", parent, "")
    wrap.AddClass("CompanionXpBar")

    let fill = $.CreatePanel("Panel", wrap, "")
    fill.AddClass("CompanionXpFill")
    let ratio = (maxed || required <= 0) ? 1 : Math.min(1, current / required)
    fill.style.width = (ratio * 100) + "%"

    let label = $.CreatePanel("Label", wrap, "")
    label.AddClass("CompanionXpLabel")
    label.text = maxed ? $.Localize("#services_companion_max_stars") : (String(current) + " / " + String(required))
}

var COMPANION_RARITY_LABEL = { common: "C", rare: "B", mythical: "A", legendary: "S", immortal: "SSR", super: "UR", unique: "UR" }

function GetCompanionRarityTier(rarity)
{
    let key = String(rarity || "common")
    return COMPANION_RARITY_LABEL[key] || key.toUpperCase()
}

function BuyCompanion(item, count)
{
    if (!item || IsCompanionMaxed(item)) return
    count = Math.max(1, Number(count) || 1)
    let cost = (Number(item.companion_coin_price) || 0) * count
    if (GetCompanionCoinBalance() < cost) return
    GameEvents.SendCustomGameEventToServer("event_services_buy_companion_copy", { item_id: item.item_id, count: count })
    Game.EmitSound("up_up_ui_visual_on")
}

function SelectCompanionItem(index)
{
    companion_selected_index = index

    let list = GetCompanionList()
    if (companion_selected_index >= list.length) companion_selected_index = 0
    let selected = list[companion_selected_index]

    if (companion_cards_grid && companion_cards_grid.IsValid && companion_cards_grid.IsValid())
    {
        let cards = companion_cards_grid.Children()
        for (let i = 0; i < cards.length; i++)
        {
            cards[i].SetHasClass("CompanionCardActive", i === companion_selected_index)
        }
    }

    if (companion_center_panel && companion_center_panel.IsValid && companion_center_panel.IsValid())
    {
        companion_center_panel.RemoveAndDeleteChildren()
        RenderCompanionCenter(companion_center_panel, selected)
    }
    else
    {
        RenderInventoryContent()
    }
}

function RenderCompanionCard(parent, item, index)
{
    let card = $.CreatePanel("Panel", parent, "")
    card.AddClass("CompanionCard")
    card.AddClass("CompanionRarity_" + (item.rarity || "common"))
    card.SetHasClass("CompanionCardActive", index === companion_selected_index)
    card.SetHasClass("CompanionCardEquipped", item.equipped)
    card.SetHasClass("CompanionCardLocked", !item.owned)
    card.SetPanelEvent("onactivate", (function(i){ return function(){ SelectCompanionItem(i) } })(index))

    let bg = $.CreatePanel("Panel", card, "")
    bg.AddClass("CompanionCardBG")
    bg.hittest = false

    let bg2 = $.CreatePanel("Panel", card, "")
    bg2.AddClass("CompanionCardBG2")
    bg2.hittest = false

    let badge = $.CreatePanel("Label", card, "")
    badge.AddClass("CompanionCardRarityBadge")
    badge.hittest = false
    badge.text = GetCompanionRarityTier(item.rarity)

    let card_preview = $.CreatePanel("Panel", card, "")
    card_preview.AddClass("CompanionCardPreviewPanel")
    card_preview.hittest = false

    let preview = $.CreatePanel("Panel", card_preview, "")
    preview.AddClass("CompanionCardPreview")
    preview.hittest = false
    SetPanelImage(preview, GetCompanionPreviewImage(item))

    let previewLocked = $.CreatePanel("Panel", card_preview, "")
    previewLocked.AddClass("CompanionCardPreviewLocked")

    if ((item.rarity || "common") !== "rare")
    {
        let scene = $.CreatePanel("DOTAScenePanel", card_preview, "", {
            unit: item.preview_unit || "npc_levelup_assistant",
            renderdeferred: "false",
            antialias: "true",
            particleonly: "false",
            drawbackground: "false",
        })
        scene.AddClass("CompanionCardScene")
        scene.AddClass(item.preview_unit)
        scene.hittest = false
        $.RegisterEventHandler("DOTAScenePanelSceneLoaded", scene, function()
        {
            preview.visible = false
        })

        let CompanionSceneRareBG = $.CreatePanel("DOTAParticleScenePanel", card, "", {particleName : "particles/companiun_hud/companiun_hud_back.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "100 0 0", lookAt : "0 0 0", fov : "52", squarePixels : "true"})
        CompanionSceneRareBG.AddClass("CompanionSceneRareBG")
        CompanionSceneRareBG.hittest = false
    }

    let name = $.CreatePanel("Label", card, "")
    name.AddClass("CompanionCardName")
    name.hittest = false
    name.text = item.name

    let type = $.CreatePanel("Label", card, "")
    type.AddClass("CompanionCardType")
    type.hittest = false
    type.text = item.companion_type || ""

    RenderCompanionStars(card, item.stars, GetCompanionMaxStars(item)).hittest = false
}

function RenderCompanionActions(parent, item)
{
    if (item.owned)
    {
        let equipText = item.equipped ? $.Localize("#services_common_equipped") : $.Localize("#services_companion_equip")
        let equipBtn = CreateLabeledButton(parent, equipText, "CompanionActionButton", "CompanionEquipButton")
        equipBtn.SetPanelEvent("onactivate", function(){ EquipCompanion(item) })
    }

    if (IsCompanionMaxed(item)) return

    let per_copy = Number(item.companion_coin_price) || 0
    let count = 1
    if (item.owned)
    {
        let parts = String(item.need || "0/1").split("/")
        let current = Number(parts[0]) || 0
        let required = Number(parts[1]) || 0
        count = Math.max(1, required - current)
    }
    let cost = per_copy * count
    let can_afford = GetCompanionCoinBalance() >= cost

    let buyBox = $.CreatePanel("Panel", parent, "")
    buyBox.AddClass("CompanionBuyBox")

    let priceRow = $.CreatePanel("Panel", buyBox, "")
    priceRow.AddClass("CompanionPriceRow")
    let priceIcon = $.CreatePanel("Panel", priceRow, "")
    priceIcon.AddClass("CompanionPriceIcon")
    SetPanelImage(priceIcon, GetCompanionCoinIcon())
    let priceLabel = $.CreatePanel("Label", priceRow, "")
    priceLabel.AddClass("CompanionPriceLabel")
    priceLabel.text = String(GetCompanionCoinBalance()) + " / " + String(cost)

    let buyText = item.owned ? $.Localize("#services_companion_upgrade") : $.Localize("#services_companion_buy")
    let buyBtn = CreateLabeledButton(buyBox, buyText, "CompanionActionButton", "CompanionBuyButton")
    buyBtn.SetHasClass("CompanionActionButtonDisabled", !can_afford)
    buyBtn.SetPanelEvent("onactivate", function(){ BuyCompanion(item, count) })
}

function GetCompanionBlessingItems()
{
    let items = (Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}) || {}
    let result = []
    for (let id in items)
    {
        let cfg = items[id]
        if (cfg && cfg.item_type === "companion_blessing")
        {
            result.push(cfg)
        }
    }
    result.sort(function(a, b){ return (Number(a.order_index) || 0) - (Number(b.order_index) || 0) })
    return result
}

function RenderCompanionBlessings(parent, item)
{
    let list = $.CreatePanel("Panel", parent, "")
    list.AddClass("CompanionBlessingList")
    list.style.overflow = "squish scroll"

    let blessings = GetCompanionBlessingItems()
    if (!blessings.length)
    {
        let placeholder = $.CreatePanel("Label", list, "")
        placeholder.AddClass("CompanionBlessingPlaceholder")
        placeholder.text = $.Localize("#services_companion_blessing_soon")
        return
    }

    let levels = (GetServicePlayerData() || {}).companion_blessings || {}

    for (let blessing of blessings)
    {
        let max_level = Number(blessing.blessing_max_level) || 0
        let per_level = Number(blessing.blessing_per_level) || 0
        let level = Number((levels[blessing.id] || {}).count) || 0
        if (max_level > 0) level = Math.min(level, max_level)

        let row = $.CreatePanel("Panel", list, "")
        row.AddClass("CompanionBlessingRow")
        row.SetHasClass("CompanionBlessingRowLocked", level <= 0)

        let top = $.CreatePanel("Panel", row, "")
        top.AddClass("CompanionBlessingTop")

        let icon = $.CreatePanel("Panel", top, "")
        icon.AddClass("CompanionBlessingIcon")
        SetPanelImage(icon, blessing.icon || "file://{images}/game_hud/icons/gold.png")

        let info = $.CreatePanel("Panel", top, "")
        info.AddClass("CompanionBlessingInfo")

        let name = $.CreatePanel("Label", info, "")
        name.AddClass("CompanionBlessingName")
        name.text = LocalizeServiceItemName(blessing, blessing.id)

        let desc = $.CreatePanel("Label", info, "")
        desc.AddClass("CompanionBlessingDesc")
        desc.text = blessing.description ? $.Localize(blessing.description) : ""

        let effect = $.CreatePanel("Label", info, "")
        effect.AddClass("CompanionBlessingEffect")
        let current_bonus = level * per_level
        if (max_level > 0 && level >= max_level)
        {
            effect.text = "+" + String(current_bonus) + "%"
        }
        else
        {
            effect.text = "+" + String(current_bonus) + "% (+" + String((level + 1) * per_level) + "%)"
        }

        let bottom = $.CreatePanel("Panel", row, "")
        bottom.AddClass("CompanionBlessingBottom")

        let starsWrap = $.CreatePanel("Panel", bottom, "")
        starsWrap.AddClass("CompanionBlessingStars")
        RenderCompanionBlessingStars(starsWrap, level, max_level)

        let lvl = $.CreatePanel("Label", bottom, "")
        lvl.AddClass("CompanionBlessingLevel")
        lvl.text = String(level) + "/" + String(max_level)
    }
}

function RenderCompanionCenter(center, selected)
{
    if (!selected) return

    let sceneWrap = $.CreatePanel("Panel", center, "")
    sceneWrap.AddClass("CompanionSceneWrap")

    let CompanionSceneBG = $.CreatePanel("DOTAParticleScenePanel", sceneWrap, "", {particleName : "particles/companiun_hud/companiun_hud_fx.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
    CompanionSceneBG.AddClass("CompanionSceneBG")
    CompanionSceneBG.hittest = false

    let scene = $.CreatePanel("DOTAScenePanel", sceneWrap, "", {
        unit: selected.preview_unit || "npc_levelup_assistant",
        renderdeferred: "false",
        antialias: "true",
        particleonly: "false",
        drawbackground: "false",
    })
    scene.AddClass("CompanionScene")
    scene.hittest = false

    let details = $.CreatePanel("Panel", center, "")
    details.AddClass("CompanionDetails")
    RenderCompanionInfo(details, selected)

    let actions = $.CreatePanel("Panel", center, "")
    actions.AddClass("CompanionActionsRow")
    RenderCompanionActions(actions, selected)
}

function RenderCompanionsTab()
{
    let list = GetCompanionList()
    if (companion_selected_index >= list.length) companion_selected_index = 0
    let selected = list[companion_selected_index]

    let root = $.CreatePanel("Panel", InventoryContentBody, "")
    root.AddClass("CompanionsRoot")

    let listColumn = $.CreatePanel("Panel", root, "")
    listColumn.AddClass("CompanionsListColumn")
    let listTitle = $.CreatePanel("Label", listColumn, "")
    listTitle.AddClass("CompanionSectionTitle")
    listTitle.text = $.Localize("#services_companion_available_title")
    let grid = $.CreatePanel("Panel", listColumn, "")
    grid.AddClass("CompanionGrid")
    grid.style.overflow = "squish scroll"
    companion_cards_grid = grid
    for (let i = 0; i < list.length; i++)
    {
        RenderCompanionCard(grid, list[i], i)
    }

    let center = $.CreatePanel("Panel", root, "")
    center.AddClass("CompanionsCenterColumn")
    companion_center_panel = center
    RenderCompanionCenter(center, selected)

    let blessingColumn = $.CreatePanel("Panel", root, "")
    blessingColumn.AddClass("CompanionsBlessingColumn")
    let blessingTitle = $.CreatePanel("Label", blessingColumn, "")
    blessingTitle.AddClass("CompanionSectionTitle2")
    blessingTitle.text = $.Localize("#services_companion_blessing_title")
    RenderCompanionBlessings(blessingColumn, selected)
}

function RenderTalentTab(is_super)
{
    let root = $.CreatePanel("Panel", InventoryContentBody, "")
    root.AddClass(is_super ? "InventorySuperTalentRoot" : "InventoryTalentRoot")
    let configColumn = $.CreatePanel("Panel", root, "")
    configColumn.AddClass("TalentConfigColumn")

    let configs = is_super ? super_talent_data.configs : talent_data.configs
    let active = is_super ? current_super_config : current_talent_config
    for (let i = 0; i < configs.length; i++)
    {
        let button = $.CreatePanel("Panel", configColumn, "")
        button.AddClass("TalentConfigButton")
        button.SetHasClass("TalentConfigButtonActive", i === active)
        button.SetPanelEvent("onactivate", (function(index)
        {
            return function()
            {
                if (is_super) current_super_config = index
                else
                {
                    current_talent_config = index
                    GameEvents.SendCustomGameEventToServer("event_services_set_talent_config", { config_id: index + 1 })
                    Game.EmitSound("General.ButtonClick")
                }
                RenderInventoryContent()
            }
        })(i))
        $.CreatePanel("Label", button, "").text = configs[i]
    }

    let board = $.CreatePanel("Panel", root, "")
    board.AddClass(is_super ? "SuperTalentBoard" : "TalentBoard")
    if (is_super && !super_talent_data.unlocked)
    {
        RenderLockedOverlay(board, "Для разблокировки требуется пройти: " + super_talent_data.unlock_need)
    }

    if (is_super)
    {
        RenderCircularTalentNodes(board)
    }
    else
    {
        RenderGridTalentNodes(board)
        
        let footer = $.CreatePanel("Panel", board, "")
        footer.AddClass("TalentFooter")
        
        let TalentLevelBar = $.CreatePanel("Panel", footer, "")
        TalentLevelBar.AddClass("TalentLevelBar")

        let TalentLevelBarBG = $.CreatePanel("Panel", TalentLevelBar, "")
        TalentLevelBarBG.AddClass("TalentLevelBarBG")

        for (let pin_id = 1; pin_id <= talent_data.milestones.length; pin_id++)
        {
            let pin = $.CreatePanel("Panel", TalentLevelBar, "TalentLevelPin_" + pin_id)
            pin.AddClass("TalentLevelPin")
            pin.AddClass("TalentLevelPin"+pin_id)

            if ((talent_data.milestones[pin_id - 1] || 0) <= (talent_data.spent_points || 0))
            {
                pin.AddClass("TalentLevelPin_active")
            }
        }

        let TalentLevelLine = $.CreatePanel("Panel", TalentLevelBar, "")
        TalentLevelLine.AddClass("TalentLevelLine")

        let TalentLevelLineFront = $.CreatePanel("Panel", TalentLevelLine, "TalentLevelLineFront")
        TalentLevelLineFront.AddClass("TalentLevelLineFront")
        TalentLevelLineFront.style.width = GetTalentProgressWidth(talent_data.spent_points || 0) + "%"

        let TalentLevelLabel = $.CreatePanel("Label", TalentLevelBar, "TalentLevelLabel")
        TalentLevelLabel.AddClass("TalentLevelLabel")
        TalentLevelLabel.text = String(talent_data.spent_points || 0)

        let milestoneRow = $.CreatePanel("Panel", footer, "")
        milestoneRow.AddClass("TalentMilestonesRow")
        let title = $.CreatePanel("Label", milestoneRow, "")
        title.AddClass("TalentLevelTitle")
        title.text = $.Localize("#services_inventory_total_level")
        for (let i = 0; i < talent_data.milestones.length; i++)
        {
            let lvlr = $.CreatePanel("Label", milestoneRow, "")
            lvlr.AddClass("TalentLevelTitls"+i)
            lvlr.text = String(talent_data.milestones[i])
        }
        let buttons = $.CreatePanel("Panel", footer, "")
        buttons.AddClass("TalentButtonsRow")
        let resetButton = CreateLabeledButton(buttons, $.Localize("#services_talent_reset_button"), "InventoryTalentActionButton", "TalentResetButton")
        UpdateTalentResetButton(resetButton)
        resetButton.SetPanelEvent("onactivate", function()
        {
            if (CanResetTalentsClient())
            {
                ShowTalentResetConfirm()
            }
        })
    }
}

function RefreshTalentFooter()
{
    let line = $("#TalentLevelLineFront")
    if (line) line.style.width = GetTalentProgressWidth(talent_data.spent_points || 0) + "%"
    let label = $("#TalentLevelLabel")
    if (label) label.text = String(talent_data.spent_points || 0)
    UpdateTalentResetButton($("#TalentResetButton"))
    for (let pin_id = 1; pin_id <= talent_data.milestones.length; pin_id++)
    {
        let pin = $("#TalentLevelPin_" + pin_id)
        if (pin)
        {
            pin.SetHasClass("TalentLevelPin_active", (talent_data.milestones[pin_id - 1] || 0) <= (talent_data.spent_points || 0))
        }
    }
    for (let i = 1; i <= 35; i++)
    {
        let node = $("#TalentNode_" + i)
        if (node)
        {
            SetTalentNodeState(node)
        }
    }
}

function CanResetTalentsClient()
{
    let player_data = GetServicePlayerData()
    let currencies = player_data.economy_data || {}
    return (talent_data.spent_points || 0) > 0 && (Number(currencies.coin) || 0) >= TALENT_RESET_COST
}

function UpdateTalentResetButton(button)
{
    if (!button) return
    button.SetHasClass("InventoryTalentActionButtonDisabled", !CanResetTalentsClient())
    button.hittest = CanResetTalentsClient()
}

function HideTalentResetConfirm()
{
    let modal = $("#TalentResetConfirmModal")
    if (modal)
    {
        modal.DeleteAsync(0)
        Game.EmitSound("General.ButtonClick")
    }
}

function ShowTalentResetConfirm()
{
    HideTalentResetConfirm()
    let modal = $.CreatePanel("Panel", $.GetContextPanel(), "TalentResetConfirmModal")
    modal.AddClass("TalentResetConfirmModal")
    modal.SetPanelEvent("onactivate", HideTalentResetConfirm)

    let card = $.CreatePanel("Panel", modal, "")
    card.AddClass("TalentResetConfirmCard")
    card.SetPanelEvent("onactivate", function() {})

    let title = $.CreatePanel("Label", card, "")
    title.AddClass("TalentResetConfirmTitle")
    title.text = $.Localize("#services_talent_reset_title")

    let text = $.CreatePanel("Panel", card, "")
    text.AddClass("TalentResetConfirmText")
    let textBefore = $.CreatePanel("Label", text, "")
    textBefore.AddClass("TalentResetConfirmTextLabel")
    textBefore.text = $.Localize("#services_talent_reset_confirm_before")
    let coinIcon = $.CreatePanel("Panel", text, "")
    coinIcon.AddClass("TalentResetConfirmCoinIcon")
    let coin_item = GetServiceItems().coin || {}
    SetPanelImage(coinIcon, coin_item.icon || "file://{images}/game_hud/services/coin.png")
    let costLabel = $.CreatePanel("Label", text, "")
    costLabel.AddClass("TalentResetConfirmCost")
    costLabel.text = String(TALENT_RESET_COST)
    let textAfter = $.CreatePanel("Label", text, "")
    textAfter.AddClass("TalentResetConfirmTextLabel")
    textAfter.text = $.Localize("#services_talent_reset_confirm_after")

    let row = $.CreatePanel("Panel", card, "")
    row.AddClass("TalentResetConfirmButtons")
    let accept = CreateLabeledButton(row, $.Localize("#services_common_yes"), "InventoryTalentActionButton")
    accept.SetPanelEvent("onactivate", function()
    {
        GameEvents.SendCustomGameEventToServer("event_services_reset_talents", { config_id: current_talent_config + 1 })
        HideTalentResetConfirm()
    })
    let cancel = CreateLabeledButton(row, $.Localize("#services_common_no"), "InventoryTalentActionButton")
    cancel.SetPanelEvent("onactivate", HideTalentResetConfirm)
}

function RenderSuperTalentTab()
{
    RenderTalentTab(true)
}

var talent_tracker_timer = -1
var talent_clicked_time = 0

function GetTalentConfig(talent_id)
{
    return talent_config_by_id[talent_id] || {}
}

function GetTalentIcon(talent_id)
{
    return GetTalentConfig(talent_id).icon || "file://{images}/game_hud/talents/test.png"
}

function GetTalentLevel(talent_id)
{
    return Number(talent_levels_by_id && talent_levels_by_id[talent_id]) || 0
}

function GetTalentCost(talent_id)
{
    return Math.max(1, Number(GetTalentConfig(talent_id).cost) || 1)
}

function GetTalentMaxLevel(talent_id)
{
    return Math.max(1, Number(GetTalentConfig(talent_id).max_level) || 1)
}

function NormalizeTalentRequirements(talent)
{
    let requires = talent && talent.requires || []
    if (requires.id) return [requires]
    return Object.values(requires || {})
}

function IsTalentUnlockedByRequirements(talent_id)
{
    let requirements = NormalizeTalentRequirements(GetTalentConfig(talent_id))
    let has_any = false
    let any_passed = false
    for (let requirement of requirements)
    {
        let required_level = Number(requirement.level) || 1
        let passed = GetTalentLevel(requirement.id) >= required_level
        if (requirement.any)
        {
            has_any = true
            any_passed = any_passed || passed
        }
        else if (!passed)
        {
            return false
        }
    }
    return !has_any || any_passed
}

function CanUpgradeTalentClient(talent_id)
{
    if (!talent_id) return false
    if (talent_upgrade_pending || talent_upgrade_hold_locked) return false
    let current_level = GetTalentLevel(talent_id)
    if (current_level >= GetTalentMaxLevel(talent_id)) return false
    if (!IsTalentUnlockedByRequirements(talent_id)) return false
    return (talent_data.spent_points + GetTalentCost(talent_id)) <= talent_data.max_points
}

function WaitTalentUpgradeMouseRelease()
{
    if (!GameUI.IsMouseDown(0))
    {
        talent_upgrade_hold_locked = false
        return
    }
    $.Schedule(0.03, WaitTalentUpgradeMouseRelease)
}

function UpgradeTalentNode(node, wait_for_release)
{
    if (!node || !node.talent_id || !CanUpgradeTalentClient(node.talent_id)) return
    talent_upgrade_pending = true
    talent_upgrade_hold_locked = !!wait_for_release
    GameEvents.SendCustomGameEventToServer("event_services_upgrade_talent", { talent_id: node.talent_id, config_id: current_talent_config + 1 })
    if (wait_for_release)
    {
        WaitTalentUpgradeMouseRelease()
    }
    else
    {
        Game.EmitSound("up_up_ui_talent_3")
    }
    $.Schedule(1.0, function()
    {
        talent_upgrade_pending = false
    })
}

function ShowTalentNodeTooltip(node)
{
    if (!node || !node.talent_id || typeof buildTooltipParams !== "function") return
    let params = buildTooltipParams({
        talent_id: node.talent_id,
        config_id: current_talent_config + 1,
        level: GetTalentLevel(node.talent_id),
        max_level: GetTalentMaxLevel(node.talent_id),
        cost: GetTalentCost(node.talent_id),
        talents: talent_levels_by_id || {},
    })
    $.DispatchEvent(
        "UIShowCustomLayoutParametersTooltip",
        node,
        "talent_tooltip_custom",
        "file://{resources}/layout/custom_game/tooltips/talent_tooltip/talent_tooltip.xml",
        params
    )
}

function HideTalentNodeTooltip(node)
{
    if (!node) return
    $.DispatchEvent("UIHideCustomLayoutTooltip", node, "talent_tooltip_custom")
}

function RestartHoveredTalentTooltip()
{
    let node = hovered_talent_node
    if (!node || !node.IsValid || !node.IsValid() || !node.talent_id || !node.talent_tooltip_hovered) return
    HideTalentNodeTooltip(node)
    $.Schedule(0.03, function()
    {
        if (node && node.IsValid && node.IsValid() && node.talent_tooltip_hovered)
        {
            ShowTalentNodeTooltip(node)
        }
    })
}

function SetTalentNodeState(node, upd_pfx)
{
    if (!node || !node.talent_id) return
    let current_level = GetTalentLevel(node.talent_id)
    let max_level = GetTalentMaxLevel(node.talent_id)
    let requirements_unlocked = IsTalentUnlockedByRequirements(node.talent_id)
    let can_upgrade = CanUpgradeTalentClient(node.talent_id)
    node.SetHasClass("TalentNodeNotActive", current_level <= 0)
    node.SetHasClass("TalentNodeLocked", !requirements_unlocked)
    node.SetHasClass("TalentNodeMaxLevel", current_level >= max_level)
    node.SetHasClass("TalentNodeCanUpgrade", can_upgrade)
    for (let child_line of node.lines || [])
    {
        let is_inactivate = child_line.BHasClass("TalentLineNotActive")
        child_line.SetHasClass("TalentLineNotActive", current_level <= 0)
        if (upd_pfx || is_inactivate && !child_line.BHasClass("TalentLineNotActive"))
        {
            child_line.ReloadScene()
            child_line.StartParticles()
        }
    }
    $.Schedule(1, function()
    {
        if (node && node.IsValid() && node.ring_mini && node.ring_mini.IsValid())
        {
            if (upd_pfx)
            {
                node.ring_mini.ReloadScene()
                node.ring_mini.StartParticles()
            }
        }  
    })
    if (node.TalentLevelLabel)
    {
        node.TalentLevelLabel.SetDialogVariable("level", String(current_level))
        node.TalentLevelLabel.SetDialogVariable("max", String(max_level))
        node.TalentLevelLabel.text = $.Localize("#services_talent_level_value", node.TalentLevelLabel)
    }
}

function RepeatTalentTracker(node)
{
    if (talent_tracker_timer == -1)
    {
        return
    }
    CheckTalentMouseCallback(node)
    if (talent_tracker_timer == -1)
    {
        return
    }
    talent_tracker_timer = $.Schedule(0.03, ()=>
    {
        RepeatTalentTracker(node)
    })
}

function SetTalentProgress(node)
{
    if (!node.TalentNodeProgress) return
    let percent = Math.max(0, Math.min(100, (talent_clicked_time * 100)))
    percent = Math.round(percent * 100) / 100
    node.TalentNodeProgress.style["opacity-mask-scale"] = (percent*2) + "%"
}

function CheckTalentMouseCallback(node)
{
    if (GameUI.IsMouseDown(0))
    {
        if (talent_upgrade_pending || talent_upgrade_hold_locked) { return }
        if (!node.BHasClass("TalentNodeNotActive") || !CanUpgradeTalentClient(node.talent_id)) { return }
        talent_clicked_time += 0.03
        SetTalentProgress(node)
        if (talent_sound_cooldown == -1)
        {
            talent_sound_cooldown = Game.EmitSound("up_up_ui_talent_2")
        }
        if (talent_clicked_time >= 1)
        {
            talent_clicked_time = 0
            talent_tracker_timer = -1
            UpgradeTalentNode(node, true)
            for (let child_line of node.lines)
            {
                child_line.SetHasClass("TalentLineNotActive", false)
            }
            CancelTalentCallback(node)
            Game.StopSound(talent_sound_cooldown)
            talent_sound_cooldown = -1
            Game.EmitSound("up_up_ui_talent")
        }
    }
    else
    {
        talent_upgrade_hold_locked = false
        talent_clicked_time = Math.max(talent_clicked_time - 0.06, 0)
        SetTalentProgress(node)
        Game.StopSound(talent_sound_cooldown)
        talent_sound_cooldown = -1
    }
}

function CancelTalentCallback(node)
{
    talent_clicked_time = 0
    if (!GameUI.IsMouseDown(0))
    {
        talent_upgrade_hold_locked = false
    }
    if (node.TalentNodeProgress)
    {
        node.TalentNodeProgress.style["opacity-mask-scale"] = "0%"
    }
}

function AnimationTransitionTalents(grid, perecnt)
{
    if (!grid.IsValid())
    {
        return
    }
    perecnt = perecnt + 5
    grid.style["opacity-mask-scale"] = perecnt + "%"
    if (perecnt >= 200) { return }
    $.Schedule(0.03, function()
    {
        AnimationTransitionTalents(grid, perecnt)
    })
}

function RenderGridTalentNodes(parent)
{
    let grid = $.CreatePanel("Panel", parent, "")
    grid.AddClass("TalentNodeGrid")
    AnimationTransitionTalents(grid, 0)

    let grid_BG_lines = $.CreatePanel("Panel", grid, "")
    grid_BG_lines.AddClass("grid_BG_lines")
    grid_BG_lines.hittest = false

    for (let i = 0; i <= 35; i++)
    {
        let node = $.CreatePanel("Panel", grid, i > 0 ? "TalentNode_" + i : "TalentNode_Center")
        node.AddClass("TalentNode"+i)
        node.AddClass("TalentNode")
        node.lines = []
        node.talent_id = talent_node_ids[i - 1]
        node.talent_node_index = i
        
        node.SetPanelEvent("onmouseover", function()
        {
            hovered_talent_node = node
            node.talent_tooltip_hovered = true
            ShowTalentNodeTooltip(node)
            if (talent_tracker_timer != -1)
            {
                $.CancelScheduled(talent_tracker_timer)
                talent_tracker_timer = -1
            }
            talent_tracker_timer = $.Schedule(0.03, ()=>
            {
                RepeatTalentTracker(node)
            })
        })

        node.SetPanelEvent("onmouseout", function()
        {
            node.talent_tooltip_hovered = false
            if (hovered_talent_node === node)
            {
                hovered_talent_node = null
            }
            HideTalentNodeTooltip(node)
            CancelTalentCallback(node)
            if (talent_tracker_timer != -1)
            {
                $.CancelScheduled(talent_tracker_timer)
                talent_tracker_timer = -1
            }
        })

        node.SetPanelEvent("onactivate", function()
        {
            if (!node.talent_id) return
            if (GetTalentLevel(node.talent_id) > 0)
            {
                UpgradeTalentNode(node, false)
            }
        })

        let TalentNodeBG = $.CreatePanel("Panel", node, "")
        TalentNodeBG.AddClass("TalentNodeBG")

        let TalentNodeProgress = $.CreatePanel("Panel", node, "")
        TalentNodeProgress.AddClass("TalentNodeProgress")

        let TalentNodeProgressIcon = $.CreatePanel("Panel", TalentNodeProgress, "")
        TalentNodeProgressIcon.AddClass("TalentNodeProgressIcon")
        if (node.talent_id)
        {
            SetPanelImage(TalentNodeProgressIcon, GetTalentIcon(node.talent_id))
        }

        node.TalentNodeProgress = TalentNodeProgress
        
        if (i >= 1 && i <= 5)
        {
            node.AddClass("TalentNodeGolden")
        }

        if (i >= 6 && i <= 10)
        {
            node.AddClass("TalentNodeGreen")
        }

        if (i >= 11 && i <= 22)
        {
            node.AddClass("TalentNodeOrange")
        }

        if (i >= 23)
        {
            node.AddClass("TalentNodeBlue")
        }

        if (i !== 0)
        {
            let node_icon = $.CreatePanel("Panel", node, "")
            node_icon.AddClass("TalentNodeIcon")
            SetPanelImage(node_icon, GetTalentIcon(node.talent_id))

            let node_pfx_line = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/line_ember_soul_void_id_"+i+".vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
            node_pfx_line.AddClass("node_pfx_line")
            node_pfx_line.AddClass("node_pfx_line_id_"+i)
            node_pfx_line.hittest = false
            node.lines.push(node_pfx_line)

            if (i == 14)
            {
                let node_pfx_line = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/line_ember_soul_void_id_14_1.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
                node_pfx_line.AddClass("node_pfx_line")
                node_pfx_line.AddClass("node_pfx_line_id_14_1")
                node_pfx_line.AddClass("TalentLineNotActive")
                node_pfx_line.hittest = false
                node.lines.push(node_pfx_line)

                let node_pfx_line_id_14 = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/line_ember_soul_void_id_14_2.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
                node_pfx_line_id_14.AddClass("node_pfx_line")
                node_pfx_line_id_14.AddClass("node_pfx_line_id_14_2")
                node_pfx_line_id_14.AddClass("TalentLineNotActive")
                node_pfx_line_id_14.hittest = false
                node.lines.push(node_pfx_line_id_14)

                let node_pfx_pip = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/center_pip.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "15", squarePixels : "true"})
                node_pfx_pip.AddClass("node_pfx_pip_14")
                node_pfx_pip.AddClass("TalentLineNotActive")
                node_pfx_pip.hittest = false
                node.lines.push(node_pfx_pip)
            }

            if (i == 28)
            {
                let node_pfx_line = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/line_ember_soul_void_id_28_1.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
                node_pfx_line.AddClass("node_pfx_line")
                node_pfx_line.AddClass("node_pfx_line_id_28_1")
                node_pfx_line.AddClass("TalentLineNotActive")
                node_pfx_line.hittest = false
                node.lines.push(node_pfx_line)

                let node_pfx_line_id_14 = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/line_ember_soul_void_id_28_2.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
                node_pfx_line_id_14.AddClass("node_pfx_line")
                node_pfx_line_id_14.AddClass("node_pfx_line_id_28_2")
                node_pfx_line_id_14.AddClass("TalentLineNotActive")
                node_pfx_line_id_14.hittest = false
                node.lines.push(node_pfx_line_id_14)

                let node_pfx_pip = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/center_pip.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "15", squarePixels : "true"})
                node_pfx_pip.AddClass("node_pfx_pip_28")
                node_pfx_pip.AddClass("TalentLineNotActive")
                node_pfx_pip.hittest = false
                node.lines.push(node_pfx_pip)
            }

            let node_pfx_ring = $.CreatePanel("DOTAParticleScenePanel", node, "", {particleName : "particles/talents_pfx/center_ring_mini.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 820", lookAt : "0 0 0", fov : "40", squarePixels : "true"})
            node_pfx_ring.AddClass("node_pfx_ring_mini")
            node_pfx_ring.hittest = false
            node.ring_mini = node_pfx_ring
            SetTalentNodeState(node, true)
        }
        else
        {
            let node_pfx_ring = $.CreatePanel("DOTAParticleScenePanel", node, "", {particleName : "particles/talents_pfx/center_ring.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 820", lookAt : "0 0 0", fov : "40", squarePixels : "true"})
            node_pfx_ring.AddClass("node_pfx_ring")
            node_pfx_ring.hittest = false
            node.ring_mini = node_pfx_ring

            for (let pfx_id = 1, pfx_count = 4; pfx_id <= pfx_count; pfx_id++)
            {
                let node_pfx_line = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/line_ember_soul_void"+pfx_id+".vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "35", squarePixels : "true"})
                node_pfx_line.AddClass("node_pfx_line_center")
                node_pfx_line.AddClass("node_pfx_line_center"+pfx_id)
                node_pfx_line.hittest = false
                
                let node_pfx_pip = $.CreatePanel("DOTAParticleScenePanel", grid, "", {particleName : "particles/talents_pfx/center_pip.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 770", lookAt : "0 0 0", fov : "15", squarePixels : "true"})
                node_pfx_pip.AddClass("node_pfx_pip_center")
                node_pfx_pip.AddClass("node_pfx_pip_center"+pfx_id)
                node_pfx_pip.hittest = false
            }
        }

        if (i !== 0)
        {
            let level_label = $.CreatePanel("Label", node, "TalentNodeLevel_" + i)
            level_label.AddClass("TalentNodeLevelLabel")
            node.TalentLevelLabel = level_label
            SetTalentNodeState(node, true)
        }
    }
}

function RenderCircularTalentNodes(parent)
{
    let wrap = $.CreatePanel("Panel", parent, "")
    wrap.AddClass("SuperTalentCircleWrap")
    for (let i = 0; i < 12; i++)
    {
        let node = $.CreatePanel("Panel", wrap, "")
        node.AddClass("SuperTalentNode")
        $.CreatePanel("Label", node, "").text = "0"
        let angle = i * 30
        let radius = (i % 2 === 0) ? 250 : 180
        let x = Math.floor(Math.cos(angle * Math.PI / 180) * radius)
        let y = Math.floor(Math.sin(angle * Math.PI / 180) * radius)
        node.style.position = (430 + x) + "px " + (260 + y) + "px 0px"
    }
    let buttons = $.CreatePanel("Panel", parent, "")
    buttons.AddClass("TalentButtonsRow")
    buttons.AddClass("TalentButtonsRowSuper")
    CreateLabeledButton(buttons, $.Localize("#services_common_apply"), "InventoryActionButton")
    CreateLabeledButton(buttons, $.Localize("#services_common_save"), "InventoryActionButton")
    CreateLabeledButton(buttons, $.Localize("#services_common_reset"), "InventoryDangerButton")
}

function RenderStoneTab(data)
{
    let root = $.CreatePanel("Panel", InventoryContentBody, "")
    root.AddClass("InventoryStoneRoot")

    let left = $.CreatePanel("Panel", root, "")
    left.AddClass("StoneCollectionColumn")
    left.style.overflow = "squish scroll"
    for (let i = 0; i < data.sections.length; i++)
    {
        let section = data.sections[i]
        let block = $.CreatePanel("Panel", left, "")
        block.AddClass("StoneTierBlock")
        block.AddClass("StoneTierBlock"+i)
        let titleRow = $.CreatePanel("Panel", block, "")
        titleRow.AddClass("StoneTierHeader")
        let StoneTierHeader1 = $.CreatePanel("Label", titleRow, "")
        StoneTierHeader1.AddClass("StoneTierHeader1")
        StoneTierHeader1.SetDialogVariable("value", section.title)
        StoneTierHeader1.text = $.Localize("#services_inventory_crystal_rank", StoneTierHeader1)
        let StoneTierHeader2 = $.CreatePanel("Label", titleRow, "StoneTierTotal_" + section.title)
        StoneTierHeader2.AddClass("StoneTierHeader2")
        StoneTierHeader2.SetDialogVariable("value", String(section.total_level))
        StoneTierHeader2.text = $.Localize("#services_inventory_total_level_value", StoneTierHeader2)

        let row = $.CreatePanel("Panel", block, "")
        row.AddClass("StoneTierItems")
        for (let j = 0; j < section.stones.length; j++)
        {
            let stone = section.stones[j]
            let card = $.CreatePanel("Panel", row, "StoneCard_" + section.title + "_" + j)
            card.AddClass("StoneCard")
            card.SetHasClass("StoneCardLocked", !stone.unlocked)
            if (typeof SetCrystalTooltip === "function")
            {
                SetCrystalTooltip(card, stone.category, stone.index, stone.level, section.total_level, false)
            }
            let StoneLevelLabel = $.CreatePanel("Label", card, "StoneLevelLabel_" + section.title + "_" + j)
            StoneLevelLabel.SetDialogVariable("value", String(stone.level))
            StoneLevelLabel.text = $.Localize("#services_inventory_level_suffix", StoneLevelLabel)
            let icon = $.CreatePanel("Panel", card, "")
            icon.AddClass("StoneCardIcon")
            let gem_fx = $.CreatePanel("DOTAParticleScenePanel", card, "", {particleName:"particles/gem_fx/gem_fx.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"180 0 0", lookAt:"0 0 0", fov:"122"})
            gem_fx.hittest = false
            gem_fx.AddClass("gem_fx")
            if (stone.icon) SetPanelImage(icon, stone.icon)
        }
    }

    let right = $.CreatePanel("Panel", root, "")
    right.AddClass("StoneSpecialColumn")
    //let title = $.CreatePanel("Label", right, "")
    //title.AddClass("StoneSpecialTitle")
    //title.text = data.title_right

    let specialGrid = $.CreatePanel("Panel", right, "")
    specialGrid.AddClass("StoneSpecialGrid")

    let specialGridBG = $.CreatePanel("Panel", specialGrid, "")
    specialGridBG.AddClass("StoneSpecialGridBG")

    for (let i = 0; i < 6; i++)
    {
        let rare = data.rare_crystals && data.rare_crystals[i] || {}
        let slot = $.CreatePanel("Panel", specialGrid, "StoneSpecialSlot_" + i)
        slot.AddClass("StoneSpecialSlot")
        slot.AddClass("StoneSpecialSlot"+i)
        slot.SetHasClass("StoneCardLocked", !rare.unlocked)
        let rareIcon = $.CreatePanel("Panel", slot, "StoneSpecialSlotIcon_" + i)
        rareIcon.AddClass("StoneSpecialSlotIcon")
        if (rare.icon)
        {
            SetPanelImage(rareIcon, rare.icon)
        }
        if (typeof SetCrystalTooltip === "function")
        {
            SetCrystalTooltip(slot, rare.category, 0, rare.unlocked ? 1 : 0, rare.total_level, true)
        }
    }

    let StoneSpecialGrid = $.CreatePanel("Label", specialGrid, "")
    StoneSpecialGrid.AddClass("StoneSpecialGridTitle")
    StoneSpecialGrid.text = $.Localize("#services_inventory_crystal_transmutation")

    let chest = $.CreatePanel("Panel", right, "")
    chest.AddClass("StoneChestCard")
    
    let chest_content = $.CreatePanel("Panel", chest, "")
    chest_content.AddClass("StoneChestContent")

    let title = $.CreatePanel("Label", chest, "")
    title.AddClass("StoneChestTitle")
    title.text = $.Localize("#services_inventory_astral_rift")

    let pullButton = CreateLabeledButton(chest_content, $.Localize("#services_inventory_pull"), "InventoryActionButton2")
    if (typeof SetCrystalPullTooltip === "function")
    {
        SetCrystalPullTooltip(pullButton)
    }
    pullButton.SetPanelEvent("onactivate", function()
    {
        GameEvents.SendCustomGameEventToServer("event_services_pull_crystal", {})
    })

    let costRow = $.CreatePanel("Panel", chest_content, "")
    costRow.AddClass("StoneChestCostRow")
    let costIcon = $.CreatePanel("Panel", costRow, "")
    costIcon.AddClass("StoneChestCostIcon")
    SetPanelImage(costIcon, data.pull_icon)
    let costText = $.CreatePanel("Label", costRow, "StoneChestCostText")
    costText.AddClass("StoneChestCostText")
    costText.text = data.pull_cost
}

function RefreshStoneCollection(data)
{
    for (let i = 0; i < data.sections.length; i++)
    {
        let section = data.sections[i]
        let total = $("#StoneTierTotal_" + section.title)
        if (total)
        {
            total.SetDialogVariable("value", String(section.total_level))
            total.text = $.Localize("#services_inventory_total_level_value", total)
        }

        for (let j = 0; j < section.stones.length; j++)
        {
            let stone = section.stones[j]
            let state_key = section.title + "_" + j
            let state_value = String(stone.level) + ":" + String(stone.unlocked)
            if (last_crystal_state[state_key] === state_value) continue
            last_crystal_state[state_key] = state_value
            let card = $("#StoneCard_" + section.title + "_" + j)
            if (card)
            {
                card.SetHasClass("StoneCardLocked", !stone.unlocked)
                if (typeof SetCrystalTooltip === "function")
                {
                    SetCrystalTooltip(card, stone.category, stone.index, stone.level, section.total_level, false)
                }
            }
            let level = $("#StoneLevelLabel_" + section.title + "_" + j)
            if (level)
            {
                level.SetDialogVariable("value", String(stone.level))
                level.text = $.Localize("#services_inventory_level_suffix", level)
            }
        }
    }

    for (let i = 0; i < (data.rare_crystals || []).length; i++)
    {
        let rare = data.rare_crystals[i] || {}
        let slot = $("#StoneSpecialSlot_" + i)
        if (slot)
        {
            slot.SetHasClass("StoneCardLocked", !rare.unlocked)
            let rareIcon = $("#StoneSpecialSlotIcon_" + i)
            if (rareIcon && rare.icon)
            {
                SetPanelImage(rareIcon, rare.icon)
            }
            if (typeof SetCrystalTooltip === "function")
            {
                SetCrystalTooltip(slot, rare.category, 0, rare.unlocked ? 1 : 0, rare.total_level, true)
            }
        }
    }

    let cost = $("#StoneChestCostText")
    if (cost) cost.text = data.pull_cost
}

function RenderLockedOverlay(parent, text)
{
    let overlay = $.CreatePanel("Panel", parent, "")
    overlay.AddClass("InventoryLockedOverlay")
    $.CreatePanel("Panel", overlay, "").AddClass("InventoryLockedEmblem")
    let label = $.CreatePanel("Label", overlay, "")
    label.AddClass("InventoryLockedText")
    label.text = text
}

function RenderConfigTabs(parent, labels, active_index, callback)
{
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("InventorySubTabsRow")
    for (let i = 0; i < labels.length; i++)
    {
        let button = $.CreatePanel("Panel", row, "")
        button.AddClass("InventorySubTabButton")
        button.SetHasClass("InventorySubTabButtonActive", i === active_index)
        button.SetPanelEvent("onactivate", (function(index) { return function()
        {
            let buttons = row.Children()
            for (let j = 0; j < buttons.length; j++)
            {
                buttons[j].SetHasClass("InventorySubTabButtonActive", j === index)
            }
            callback(index)
        } })(i))
        $.CreatePanel("Label", button, "").text = labels[i]
    }
}

function CreateSectionTitle(parent, text)
{
    let title = $.CreatePanel("Label", parent, "")
    title.AddClass("InventoryBigSectionTitle")
    title.text = text
}

function GetForgeConfig()
{
    return GetServiceEquipmentConfig().forge || {}
}

function GetLocalAtlasStatValue(stat_id)
{
    stat_id = String(stat_id || "")
    if (stat_id === "" || !Game.GetCustomTable) return 0
    let pdata = Game.GetCustomTable("services_player", GetLocalPlayerKey()) || {}
    let atlas_items = pdata.atlas_items || {}
    let items = Game.GetCustomTable("services_config", "items") || {}
    let total = 0
    for (let item_id in atlas_items)
    {
        if ((Number(atlas_items[item_id]) || 0) <= 0) continue
        let cfg = items[item_id]
        let stats = cfg && cfg.stats
        if (stats && stats[stat_id] !== undefined) total += Number(stats[stat_id]) || 0
    }
    return total
}

function SetForgeMode(on)
{
    on = !!on
    if (storage_forge_mode === on)
    {
        ApplyForgeModeVisibility()
        return
    }
    storage_forge_mode = on
    if (on)
    {
        storage_smelt_mode = false
        storage_selected_uids = {}
    }
    else
    {
        forge_selected_uid = null
        forge_reforge_selected = {}
        forge_use_blessing_stone = false
        forge_last_result = null
    }
    RefreshForgeCraftPanel()
    ApplyForgeModeVisibility()
}

function ApplyForgeModeVisibility()
{
    let smelter = $("#ForgeSmelterColumn")
    let craft = $("#ForgeCraftPanel")
    if (smelter) smelter.style.visibility = storage_forge_mode ? "collapse" : "visible"
    if (craft) craft.style.visibility = storage_forge_mode ? "visible" : "collapse"
}

function SelectForgeItem(uid)
{
    forge_selected_uid = (uid === undefined || uid === null) ? null : uid
    forge_reforge_selected = {}
    forge_last_result = null
    RefreshForgeCraftPanel()
    UpdateForgeSelectionHighlight()
}

function UpdateForgeSelectionHighlight()
{
    let selected_uid = String(forge_selected_uid)
    for (let uid in storage_item_panels)
    {
        let panel = storage_item_panels[uid]
        if (!panel || (panel.IsValid && !panel.IsValid())) continue
        let is_forge_selected = storage_forge_mode && forge_selected_uid !== null && selected_uid === String(uid)
        let is_smelt_selected = storage_smelt_mode && !!storage_selected_uids[String(uid)]
        panel.SetHasClass("StorageCellItemSelected", is_forge_selected || is_smelt_selected)
    }
    let slots = equipment_data.set_slots || []
    for (let i = 0; i < slots.length; i++)
    {
        let slot = slots[i]
        let panel = $("#EquipmentSetSlot_" + slot.slot)
        if (!panel) continue
        let is_forge_selected = storage_forge_mode && !!slot.icon && !!slot.generated && forge_selected_uid !== null && selected_uid === String(slot.uid || "")
        panel.SetHasClass("EquipmentSetSlotForgeSelected", is_forge_selected)
    }
}

function GetForgeNormalStats(item)
{
    return Object.values((item && item.normal_stats) || {})
}

function GetForgeSelectedItem()
{
    if (forge_selected_uid === undefined || forge_selected_uid === null) return null
    let uid = String(forge_selected_uid)
    let items = equipment_data.storage_items.equipment || []
    for (let i = 0; i < items.length; i++)
    {
        if (String(items[i].uid) === uid) return items[i]
    }
    let slots = equipment_data.set_slots || []
    for (let i = 0; i < slots.length; i++)
    {
        if (slots[i] && slots[i].generated && String(slots[i].uid || "") === uid) return slots[i]
    }
    return null
}

function GetForgeOwnedAmount(item_id)
{
    let player_data = GetServicePlayerData() || {}
    if (item_id === "coin")
    {
        return Number((player_data.economy_data || {}).coin) || 0
    }
    let total = 0
    let storage = player_data.storage_items || {}
    for (let key in storage)
    {
        let entry = storage[key]
        if (entry && String(entry.item_id) === String(item_id))
        {
            total += Number(entry.count) || 0
        }
    }
    return total
}

function IsForgePercentStat(stat)
{
    return stat.percent === true || stat.percent === 1 || stat.percent === "true" || IsLevelUpPercentStatName(stat.id)
}

function GetForgeStatName(stat)
{
    return $.Localize("#services_stat_" + String(stat.id || ""))
}

function FormatForgeStatNumber(stat, value)
{
    let formatted = FormatPrecisionValue(value)
    return (Number(value) >= 0 ? "+" : "") + formatted + (IsForgePercentStat(stat) ? "%" : "")
}

function FormatForgeStatDelta(stat, delta)
{
    return "+" + FormatPrecisionValue(delta) + (IsForgePercentStat(stat) ? "%" : "")
}

function ComputeForgeStrengthenChance(item, use_stone)
{
    let forge = GetForgeConfig()
    let s = forge.strengthen || {}
    let level = Math.max(0, Math.floor(Number(item.strengthen_level) || 0))
    let by_level = s.chance_by_level || {}
    let chance = by_level[level]
    if (chance === undefined || chance === null)
    {
        let decay_after = Math.floor(Number(s.chance_decay_after) || 9)
        let base_chance = Number(by_level[decay_after])
        if (!isFinite(base_chance)) base_chance = 45
        let step = Number(s.chance_decay_step) || 5
        chance = base_chance - Math.max(0, level - decay_after) * step
    }
    chance = Math.max(Number(s.chance_min) || 1, Number(chance) || 0)
    if (use_stone) chance += Number(forge.blessing_stone_success_bonus_pct) || 0
    chance += Math.max(0, GetLocalAtlasStatValue("forge_armor_strengthen_bonus_pct"))
    return Math.max(0, Math.min(100, chance))
}

function ComputeForgeCost(item)
{
    let forge = GetForgeConfig()
    let rarity = item.rarity || "common"
    let materials = []
    let potential_cost = 0
    let chance = null

    if (forge_category === 1)
    {
        let s = forge.strengthen || {}
        potential_cost = Number((forge.potential_cost || {}).strengthen) || 0
        materials.push({ item_id: "stone_strengthening_equipment", need: Number(s.stone_cost) || 0 })
        materials.push({ item_id: "blessing_orb", need: Number(s.blessing_orb_cost) || 0 })
        materials.push({ item_id: "coin", need: Number(s.coin_cost) || 0 })
        materials.push({ item_id: "stone_blessing", need: 1, inactive: !forge_use_blessing_stone })
        chance = ComputeForgeStrengthenChance(item, forge_use_blessing_stone)
    }
    else if (forge_category === 2)
    {
        let r = forge.reforge_stats || {}
        potential_cost = Number((forge.potential_cost || {}).reforge_stats) || 0
        let total = GetForgeNormalStats(item).length
        let selected = Object.keys(forge_reforge_selected).length
        let base = Number((r.stone_base_by_rarity || {})[rarity]) || 0
        let stone = Math.max(base, base * (total - Math.max(1, selected) + 1))
        let reduce_steps = Math.max(0, selected - 1)
        let orb = Math.max(Number(r.blessing_orb_cost_min) || 0, (Number(r.blessing_orb_cost) || 0) - (Number(r.blessing_orb_cost_per_selected) || 0) * reduce_steps)
        let coin = Math.max(Number(r.coin_cost_min) || 0, (Number(r.coin_cost) || 0) - (Number(r.coin_cost_per_selected) || 0) * reduce_steps)
        materials.push({ item_id: "stone_reforging", need: stone, inactive: selected <= 0 })
        materials.push({ item_id: "blessing_orb", need: orb })
        materials.push({ item_id: "coin", need: coin })
        chance = null
    }
    else if (forge_category === 3)
    {
        let sr = forge.set_reforge || {}
        potential_cost = Number((forge.potential_cost || {}).set_reforge) || 0
        materials.push({ item_id: "stone_souls", need: Number(sr.stone_souls_cost) || 0 })
        materials.push({ item_id: "blessing_orb", need: Number(sr.blessing_orb_cost) || 0 })
        materials.push({ item_id: "coin", need: Number(sr.coin_cost) || 0 })
        chance = null
    }
    else
    {
        let restore = forge.potential_restore || {}
        let stone_id = String(restore.stone_id || "")
        let stone_cost = Number(restore.stone_cost) || 0
        if (stone_id !== "" && stone_cost > 0) materials.push({ item_id: stone_id, need: stone_cost })
        materials.push({ item_id: "blessing_orb", need: Number(restore.blessing_orb_cost) || 0 })
        materials.push({ item_id: "coin", need: Number(restore.coin_cost) || 0 })
        chance = null
    }

    return { materials: materials, potential_cost: potential_cost, chance: chance }
}

function RenderForgeCraftPanel(root)
{
    if (!root) root = $("#ForgeCraftPanel")
    if (!root) return
    root.RemoveAndDeleteChildren()
    CreateSectionTitle(root, $.Localize("#services_forge"))

    let tabs = $.CreatePanel("Panel", root, "ForgeCraftTabs")
    tabs.AddClass("ForgeCraftTabs")
    for (let i = 0; i < FORGE_CATEGORIES.length; i++)
    {
        let cat = FORGE_CATEGORIES[i]
        let btn = $.CreatePanel("Panel", tabs, "")
        btn.AddClass("ForgeCraftTabButton")
        btn.SetHasClass("ForgeCraftTabButtonActive", forge_category === cat.id)
        let lbl = $.CreatePanel("Label", btn, "")
        lbl.AddClass("ForgeCraftTabLabel")
        lbl.text = $.Localize(cat.title_key)
        btn.SetPanelEvent("onactivate", (function(cid)
        {
            return function()
            {
                if (forge_category !== cid)
                {
                    forge_category = cid
                    forge_reforge_selected = {}
                    forge_last_result = null
                }
                RefreshForgeCraftPanel()
                Game.EmitSound("General.ButtonClick")
            }
        })(cat.id))
    }

    let body = $.CreatePanel("Panel", root, "ForgeCraftBody")
    body.AddClass("ForgeCraftBody")

    RefreshForgeCraftPanel()
}

function RefreshForgeCraftPanel()
{
    let tabs = $("#ForgeCraftTabs")
    if (tabs)
    {
        let children = tabs.Children()
        for (let i = 0; i < children.length && i < FORGE_CATEGORIES.length; i++)
        {
            children[i].SetHasClass("ForgeCraftTabButtonActive", forge_category === FORGE_CATEGORIES[i].id)
        }
    }

    let body = $("#ForgeCraftBody")
    if (!body) return
    body.RemoveAndDeleteChildren()

    RenderForgeCategoryHint(body)

    let item = GetForgeSelectedItem()
    RenderForgeItemHeader(body, item)
    if (!item) return

    let category_body = $.CreatePanel("Panel", body, "")
    category_body.AddClass("ForgeCraftCategoryBody")
    RenderForgeCategoryBody(category_body, item)

    let cost = ComputeForgeCost(item)

    let bottom = $.CreatePanel("Panel", body, "")
    bottom.AddClass("ForgeCraftBottom")
    RenderForgeMaterials(bottom, cost)
    if (forge_category === 1) RenderForgeBlessingRow(bottom)
    RenderForgeFooter(bottom, item, cost)
    RenderForgeButtons(bottom, item, cost)
}

function RenderForgeCategoryHint(parent)
{
    let desc_keys = {
        1: "#services_forge_desc_strengthen",
        2: "#services_forge_desc_reforge_stats",
        3: "#services_forge_desc_set_reforge",
        4: "#services_forge_desc_potential",
    }
    let cat = null
    for (let i = 0; i < FORGE_CATEGORIES.length; i++)
    {
        if (FORGE_CATEGORIES[i].id === forge_category) { cat = FORGE_CATEGORIES[i]; break }
    }
    if (!cat) cat = FORGE_CATEGORIES[0]

    let hint = $.CreatePanel("Panel", parent, "")
    hint.AddClass("ForgeCraftHint")

    let icon = $.CreatePanel("Panel", hint, "")
    icon.AddClass("ForgeCraftHintIcon")
    ShowTextForPanel(icon, $.Localize(desc_keys[forge_category] || desc_keys[1]))

    let label = $.CreatePanel("Label", hint, "")
    label.AddClass("ForgeCraftHintLabel")
    label.text = $.Localize("#services_forge_how_it_works") + " " + $.Localize(cat.title_key)
}

function RenderForgeItemHeader(parent, item)
{
    let header = $.CreatePanel("Panel", parent, "")
    header.AddClass("ForgeCraftItemHeader")

    if (!item)
    {
        header.AddClass("ForgeCraftItemHeaderEmpty")
        let hint = $.CreatePanel("Label", header, "")
        hint.AddClass("ForgeCraftPickHint")
        hint.text = $.Localize("#services_forge_pick_item")
        return
    }

    let iconWrap = $.CreatePanel("Panel", header, "")
    iconWrap.AddClass("ForgeCraftItemIconWrap")

    let ForgeCellItemBG1 = $.CreatePanel("Panel", iconWrap, "")
    ForgeCellItemBG1.AddClass("ForgeCellItemBG1")

    if (item.rarity && item.rarity !== "common")
    {
        ForgeCellItemBG1.AddClass("RareColor_" + item.rarity)
    }

    let ForgeellItemBG2 = $.CreatePanel("Panel", iconWrap, "")
    ForgeellItemBG2.AddClass("ForgeellItemBG2")

    let icon = $.CreatePanel("Panel", iconWrap, "")
    icon.AddClass("ForgeCraftItemIcon")
    SetPanelImage(icon, item.icon || "file://{images}/game_hud/icons/gold.png")
    AddSetIconOverlay(iconWrap, item.set_id)
    SetServiceItemTooltip(iconWrap, item.item_id, 1, BuildEquipmentTooltipExtra(item))

    let info = $.CreatePanel("Panel", header, "")
    info.AddClass("ForgeCraftItemInfo")

    let level = Math.max(0, Math.floor(Number(item.strengthen_level) || 0))
    let name = $.CreatePanel("Label", info, "")
    name.AddClass("ForgeCraftItemName")
    name.text = $.Localize(item.generated_name || ("#services_equipment_slot_" + (item.slot || ""))) + (level > 0 ? " +" + level : "")

    let meta = $.CreatePanel("Label", info, "")
    meta.AddClass("ForgeCraftItemMeta")
    meta.text = $.Localize("#services_rarity_" + (item.rarity || "common")) + "  |  " + $.Localize("#services_equipment_potential") + ": " + (Number(item.potential) || 0)
}

function RenderForgeStatRow(parent, stat, index, mode, delta)
{
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("ForgeCraftStatRow")

    if (mode === "reforge")
    {
        let selected = !!forge_reforge_selected[String(index)]
        let check = $.CreatePanel("Panel", row, "")
        check.AddClass("ForgeCraftCheckbox")
        check.SetHasClass("ForgeCraftCheckboxChecked", selected)
        row.SetHasClass("ForgeCraftStatRowSelected", selected)
        row.SetPanelEvent("onactivate", (function(idx)
        {
            return function()
            {
                let key = String(idx)
                if (forge_reforge_selected[key]) delete forge_reforge_selected[key]
                else forge_reforge_selected[key] = true
                RefreshForgeCraftPanel()
                Game.EmitSound("General.ButtonClick")
            }
        })(index))
    }

    let name = $.CreatePanel("Label", row, "")
    name.AddClass("ForgeCraftStatName")
    name.text = GetForgeStatName(stat)

    let stars = $.CreatePanel("Panel", row, "")
    stars.AddClass("ForgeCraftStatStars")
    let star_count = Math.max(0, Math.floor(Number(stat.stars) || 0))
    for (let s = 0; s < star_count; s++)
    {
        let star = $.CreatePanel("Panel", stars, "")
        star.AddClass("ForgeCraftStatStar")
    }

    let value = $.CreatePanel("Label", row, "")
    value.AddClass("ForgeCraftStatValue")
    let value_text = FormatForgeStatNumber(stat, Number(stat.value) || 0)
    if (mode === "strengthen" && Number(delta) > 0)
    {
        value_text += " (" + FormatForgeStatDelta(stat, delta) + ")"
    }
    value.text = value_text
}

function RenderForgeStatsTitle(parent)
{
    let title = $.CreatePanel("Label", parent, "")
    title.AddClass("ForgeCraftSectionLabel")
    title.text = $.Localize("#services_forge_item_stats")
}

function RenderForgeBlessingRow(parent)
{
    let blessing_row = $.CreatePanel("Panel", parent, "")
    blessing_row.AddClass("ForgeCraftBlessingRow")
    blessing_row.SetPanelEvent("onactivate", function()
    {
        forge_use_blessing_stone = !forge_use_blessing_stone
        RefreshForgeCraftPanel()
        Game.EmitSound("General.ButtonClick")
    })
    let box = $.CreatePanel("Panel", blessing_row, "")
    box.AddClass("ForgeCraftCheckbox")
    box.SetHasClass("ForgeCraftCheckboxChecked", forge_use_blessing_stone)
    let label = $.CreatePanel("Label", blessing_row, "")
    label.AddClass("ForgeCraftBlessingLabel")
    label.text = $.Localize("#services_forge_use_blessing_stone")
}

function RenderForgeCategoryBody(parent, item)
{
    let forge = GetForgeConfig()

    if (forge_category === 1)
    {
        let s = forge.strengthen || {}
        let rarity = item.rarity || "common"
        let inc_base = Number((s.increment_pct_by_rarity || {})[rarity]) || 0
        let inc_star = Number(s.increment_pct_per_star) || 0
        let stats = GetForgeNormalStats(item)
        RenderForgeStatsTitle(parent)
        let list = $.CreatePanel("Panel", parent, "")
        list.AddClass("ForgeCraftStatList")
        for (let i = 0; i < stats.length; i++)
        {
            let stat = stats[i]
            let pct = inc_base + inc_star * (Number(stat.stars) || 0)
            let delta = (Number(stat.value) || 0) * pct / 100
            RenderForgeStatRow(list, stat, i, "strengthen", delta)
        }
        return
    }

    if (forge_category === 2)
    {
        let stats = GetForgeNormalStats(item)
        RenderForgeStatsTitle(parent)
        let list = $.CreatePanel("Panel", parent, "")
        list.AddClass("ForgeCraftStatList")
        for (let i = 0; i < stats.length; i++)
        {
            RenderForgeStatRow(list, stats[i], i, "reforge", 0)
        }
        return
    }

    if (forge_category === 3)
    {
        RenderForgeSetBody(parent, item)
        return
    }

    let restore = forge.potential_restore || {}
    let cur = Number(item.potential) || 0
    let attempts = Math.max(0, Math.floor(Number(item.potential_reforge_attempts) || 0))
    let restore_bonus = Math.max(0, GetLocalAtlasStatValue("forge_potential_restore_bonus"))

    let row = $.CreatePanel("Label", parent, "")
    row.AddClass("ForgeCraftPotentialPreview")
    row.text = $.Localize("#services_forge_current_potential") + ": " + cur + "  →  " + (cur + (Number(restore.min) || 0) + restore_bonus) + "-" + (cur + (Number(restore.max) || 0) + restore_bonus)

    let attemptsRow = $.CreatePanel("Label", parent, "")
    attemptsRow.AddClass("ForgeCraftPotentialAttempts")
    attemptsRow.SetHasClass("ForgeCraftPotentialAttemptsEmpty", attempts <= 0)
    attemptsRow.text = attempts > 0
        ? ($.Localize("#services_equipment_reforge_attempts") + ": " + attempts)
        : $.Localize("#services_forge_no_attempts")
}

function FormatSetBonusText(bonus)
{
    if (bonus && bonus.desc) return $.Localize(bonus.desc)
    let stats = (bonus && bonus.stats) || {}
    let parts = []
    for (let id in stats)
    {
        let value = Number(stats[id]) || 0
        let percent = /_pct$/.test(id) || IsLevelUpPercentStatName(id)
        parts.push("+" + FormatPrecisionValue(value) + (percent ? "%" : "") + " " + $.Localize("#services_stat_" + id))
    }
    return parts.join(", ")
}

function RenderForgeSetBody(parent, item)
{
    let set_id = item.set_id || ""
    let set_config = GetSetConfig(set_id)

    let header = $.CreatePanel("Panel", parent, "")
    header.AddClass("ForgeSetHeader")

    let iconWrap = $.CreatePanel("Panel", header, "")
    iconWrap.AddClass("ForgeSetIconWrap")
    if (set_config && set_config.icon)
    {
        let icon = $.CreatePanel("Panel", iconWrap, "")
        icon.AddClass("ForgeSetIcon")
        SetPanelImage(icon, set_config.icon)
    }

    let name = $.CreatePanel("Label", header, "")
    name.AddClass("ForgeSetName")
    name.text = set_config ? $.Localize(set_config.name || set_id) : $.Localize("#equipment_set_none")

    if (!set_config) return

    let equipped_count = GetEquippedSetCount(set_id)
    let bonuses = GetSetBonuses(set_config)
    bonuses.sort(function(a, b) { return (Number(a.pieces) || 0) - (Number(b.pieces) || 0) })

    let list = $.CreatePanel("Panel", parent, "")
    list.AddClass("ForgeSetBonusList")
    for (let i = 0; i < bonuses.length; i++)
    {
        let bonus = bonuses[i]
        let pieces = Number(bonus.pieces) || 0
        let bonusRow = $.CreatePanel("Label", list, "")
        bonusRow.AddClass("ForgeSetBonusRow")
        bonusRow.SetHasClass("ForgeSetBonusActive", equipped_count >= pieces)
        bonusRow.text = "[" + pieces + "] " + FormatSetBonusText(bonus)
    }
}

function RenderForgeMaterials(parent, cost)
{
    let title = $.CreatePanel("Label", parent, "")
    title.AddClass("ForgeCraftSectionLabel")
    title.text = $.Localize("#services_forge_materials")

    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("ForgeCraftMaterials")
    let items = GetServiceItems()
    for (let i = 0; i < cost.materials.length; i++)
    {
        let mat = cost.materials[i]
        if (!mat || (Number(mat.need) || 0) <= 0) continue
        let owned = GetForgeOwnedAmount(mat.item_id)
        let need = Number(mat.need) || 0
        let inactive = !!mat.inactive
        let cell = $.CreatePanel("Panel", row, "")
        cell.AddClass("ForgeCraftMaterial")
        cell.SetHasClass("ForgeCraftMaterialInactive", inactive)

        let item_def = items[mat.item_id] || {}

        let iconWrap = $.CreatePanel("Panel", cell, "")
        iconWrap.AddClass("ForgeCraftMaterialIconWrap")

        let bg1 = $.CreatePanel("Panel", iconWrap, "")
        bg1.AddClass("ForgeCraftMaterialBG1")
        if (item_def.rarity && item_def.rarity !== "common")
        {
            bg1.AddClass("RareColor_" + item_def.rarity)
        }

        let bg2 = $.CreatePanel("Panel", iconWrap, "")
        bg2.AddClass("ForgeCraftMaterialBG2")

        let icon = $.CreatePanel("Panel", iconWrap, "")
        icon.AddClass("ForgeCraftMaterialIcon")
        SetPanelImage(icon, item_def.icon || "file://{images}/game_hud/icons/gold.png")
        SetServiceItemTooltip(iconWrap, mat.item_id, need)

        let amount = $.CreatePanel("Label", cell, "")
        amount.AddClass("ForgeCraftMaterialAmount")
        amount.SetHasClass("ForgeCraftMaterialInsufficient", !inactive && owned < need)
        amount.text = owned + "/" + need
    }
}

function RenderForgeFooter(parent, item, cost)
{
    let has_chance = cost.chance !== null && cost.chance !== undefined
    let potential_cost = Number(cost.potential_cost) || 0
    let has_result = forge_last_result && String(forge_last_result.uid || "") === String(forge_selected_uid)
    if (!has_chance && potential_cost <= 0 && !has_result) return

    let footer = $.CreatePanel("Panel", parent, "")
    footer.AddClass("ForgeCraftFooter")

    if (has_chance)
    {
        let chance = $.CreatePanel("Label", footer, "")
        chance.AddClass("ForgeCraftChance")
        let chance_text = $.Localize("#services_forge_success_chance") + ": " + Math.round(Number(cost.chance)) + "%"
        let strengthen_bonus = forge_category === 1 ? Math.max(0, GetLocalAtlasStatValue("forge_armor_strengthen_bonus_pct")) : 0
        if (strengthen_bonus > 0)
        {
            chance_text += " <font color='#5eff5e'>(+" + Math.round(strengthen_bonus) + "%)</font>"
        }
        chance.html = true
        chance.text = chance_text
    }

    if (potential_cost > 0)
    {
        let cur = Number(item.potential) || 0
        let after = Math.max(0, cur - potential_cost)
        let potential = $.CreatePanel("Label", footer, "")
        potential.AddClass("ForgeCraftPotentialCost")
        potential.text = $.Localize("#services_forge_potential_cost") + ": " + cur + " → " + after
    }

    if (has_result)
    {
        let ok = IsServiceTruthy(forge_last_result.success)
        let result = $.CreatePanel("Label", footer, "")
        result.AddClass("ForgeCraftResult")
        result.SetHasClass("ForgeCraftResultFail", !ok)
        if (!ok && String(forge_last_result.error || "") === "no_attempts")
        {
            result.text = $.Localize("#services_forge_no_attempts")
        }
        else
        {
            result.text = $.Localize(ok ? "#services_forge_result_success" : "#services_forge_result_fail")
        }
    }
}

function CanAffordForge(item, cost)
{
    let forge = GetForgeConfig()
    if (forge_category === 3)
    {
        let sr = forge.set_reforge || {}
        if (!IsServiceTruthy(sr.enabled)) return false
    }
    if (forge_category === 2 && Object.keys(forge_reforge_selected).length <= 0) return false
    if (forge_category === 4 && Math.floor(Number(item.potential_reforge_attempts) || 0) <= 0) return false
    if ((Number(item.potential) || 0) < (Number(cost.potential_cost) || 0)) return false
    for (let i = 0; i < cost.materials.length; i++)
    {
        let mat = cost.materials[i]
        if (!mat || mat.inactive) continue
        let need = Number(mat.need) || 0
        if (need <= 0) continue
        if (GetForgeOwnedAmount(mat.item_id) < need) return false
    }
    return true
}

function SubmitForge(item, cost)
{
    if (!item || !CanAffordForge(item, cost)) return
    forge_last_result = null
    let payload = { category: forge_category, uid: String(item.uid) }
    if (forge_category === 1)
    {
        payload.use_blessing_stone = forge_use_blessing_stone ? 1 : 0
    }
    else if (forge_category === 2)
    {
        let indexes = []
        for (let key in forge_reforge_selected)
        {
            if (forge_reforge_selected[key]) indexes.push(Number(key) + 1)
        }
        payload.stat_indexes = indexes
    }
    GameEvents.SendCustomGameEventToServer("event_services_forge_item", payload)
    CreateForgePfx()
    Game.EmitSound("up_up_forge_anvil_fx")
}

function CreateForgePfx()
{
    let ForgeCraftPanel = $.GetContextPanel().FindChildTraverse("ForgeCraftPanel")
    if (!ForgeCraftPanel) { return }

    let particle_fx_container_forge = $.CreatePanel("Panel", ForgeCraftPanel, "")
    particle_fx_container_forge.AddClass("particle_fx_container_forge")
    particle_fx_container_forge.DeleteAsync(3)

    $.CreatePanel("DOTAParticleScenePanel", particle_fx_container_forge, "", 
    { 
        style: "width:100%;height:100%;",
        particleName: "particles/anvil_ui/anvil_ui.vpcf", 
        particleonly:"false", 
        startActive:"true", 
        cameraOrigin:"0 700 100", 
        lookAt:"0 0 0",  
        fov:"25", 
        drawbackground:"true",
        squarePixels:"true",
        hittest: "false"
    });
}

function RenderForgeButtons(parent, item, cost)
{
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("ForgeCraftButtons")

    let can_forge = CanAffordForge(item, cost)
    let forgeBtn = CreateLabeledButton(row, $.Localize("#services_forge"), "InventoryActionButton")
    forgeBtn.SetHasClass("InventoryActionButtonDisabled", !can_forge)
    forgeBtn.enabled = can_forge
    if (can_forge)
    {
        forgeBtn.SetPanelEvent("onactivate", function()
        {
            SubmitForge(item, cost)
        })
    }

    let cancelBtn = CreateLabeledButton(row, $.Localize("#services_common_cancel"), "InventoryDangerButton")
    cancelBtn.SetPanelEvent("onactivate", function()
    {
        SetForgeMode(false)
        RefreshStorageColumn()
        Game.EmitSound("General.ButtonClick")
    })
}

function CreateLabeledButton(parent, text, class_name, id)
{
    let button = $.CreatePanel("Panel", parent, id || "")
    button.AddClass(class_name || "InventoryActionButton")
    let label = $.CreatePanel("Label", button, "ButtonLabel")
    label.text = text
    return button
}

function SetButtonText(button, text)
{
    if (!button) return
    let label = button.FindChildTraverse("ButtonLabel")
    if (!label)
    {
        let children = button.Children()
        for (let i = 0; i < children.length; i++)
        {
            if (children[i].paneltype === "Label")
            {
                label = children[i]
                break
            }
        }
    }
    if (label) label.text = text
}

function StorageTabToId(label)
{
    if (typeof label === "object") return label.id
    if (label === $.Localize("#services_inventory_tab_equipment")) return "equipment"
    if (label === $.Localize("#services_inventory_storage_item")) return "item"
    return "materials"
}

function SetPanelImage(panel, path)
{
    panel.style.backgroundImage = "url('" + path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

InitInventory()





