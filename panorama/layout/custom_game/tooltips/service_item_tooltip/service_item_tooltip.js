--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PANELS =
{
    root: $.GetContextPanel(),
    bg: $("#TooltipBG"),
    icon: $("#ServiceItemIcon"),
    name: $("#ServiceItemName"),
    meta: $("#ServiceItemMeta"),
    description: $("#ServiceItemDescription"),
    stats: $("#ServiceItemStats"),
    compare: $("#ServiceItemCompare"),
}

const SERVICE_DISPLAY_ONLY_STATS =
{
    atlas_scrolls_001_dynamic_effect: true,
    atlas_scrolls_002_dynamic_effect: true,
    atlas_scrolls_003_dynamic_effect: true,
    atlas_scrolls_004_dynamic_effect: true,
    atlas_scrolls_005_dynamic_effect: true,
    nature_opened_spheres_str_coefficient_bonus: true,
    nature_opened_spheres_agi_coefficient_bonus: true,
    nature_opened_spheres_int_coefficient_bonus: true,
    throne_last_stand: true,
    last_set_card_auto_absorb: true,
    auto_victory_token_unlocked: true,
}

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function GetServiceItemsTooltip()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}
}

function GetServiceEquipmentTooltip()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "equipment") || {}) : {}
}

function GetEquippedSetCountTooltip(set_id)
{
    set_id = String(set_id || "")
    if (set_id === "") return 0
    let key = (typeof Players !== "undefined" && Players.GetLocalPlayer) ? String(Players.GetLocalPlayer()) : ""
    let player_data = (Game.GetCustomTable && key !== "") ? (Game.GetCustomTable("services_player", key) || {}) : {}
    let armor_data = player_data.armor_data || {}
    let config = (armor_data.configurations_data || {})[Number(armor_data.current_configuration) || 1] || {}
    let storage = player_data.storage_items || {}
    let equipped = {}
    for (let slot in config)
    {
        if (config[slot] !== undefined && config[slot] !== null) equipped[String(config[slot])] = true
    }
    let count = 0
    for (let k in storage)
    {
        let entry = storage[k]
        if (entry && equipped[String(entry.uid)] && String(entry.set_id || "") === set_id) count++
    }
    return count
}

function TooltipFormatSetBonus(bonus)
{
    let stats = (bonus && bonus.stats) || {}
    let parts = []
    for (let id in stats)
    {
        let value = Number(stats[id]) || 0
        let percent = /_pct$/.test(id) || IsLevelUpPercentStatName(id)
        parts.push("+" + FormatPrecisionValue(value) + (percent ? "%" : "") + " " + LocalizeTooltipKeyOrText("services_stat_" + id, id))
    }
    return parts.join(", ")
}

function AddGeneratedSetBlock(set_id, equipped_count, parent_panel)
{
    set_id = String(set_id || "")
    if (set_id === "") return
    let sets = GetServiceEquipmentTooltip().sets || {}
    let set_config = (sets.list || {})[set_id]
    if (!set_config) return

    let bonuses = Object.values(set_config.bonuses || {})
    bonuses.sort(function(a, b) { return (Number(a.pieces) || 0) - (Number(b.pieces) || 0) })
    let max_pieces = 0
    for (let i = 0; i < bonuses.length; i++) max_pieces = Math.max(max_pieces, Number(bonuses[i].pieces) || 0)
    equipped_count = GetEquippedSetCountTooltip(set_id)

    let block = $.CreatePanel("Panel", parent_panel || PANELS.stats, "")
    block.AddClass("ServiceItemSetBlock")

    let header = $.CreatePanel("Label", block, "")
    header.AddClass("ServiceItemSetHeader")
    header.text = LocalizeTooltipKeyOrText("services_equipment_set_title", "Set") + ": " + $.Localize(set_config.name || set_id) + " (" + equipped_count + "/" + max_pieces + ")"

    for (let i = 0; i < bonuses.length; i++)
    {
        let bonus = bonuses[i]
        let pieces = Number(bonus.pieces) || 0
        let row = $.CreatePanel("Label", block, "")
        row.AddClass("ServiceItemSetBonus")
        row.SetHasClass("ServiceItemSetBonusActive", equipped_count >= pieces)
        let bonus_text = bonus.desc ? LocalizeTooltipKeyOrText(bonus.desc, "") : TooltipFormatSetBonus(bonus)
        row.text = "[" + pieces + "] " + bonus_text
    }
}

function LocalizeTooltipKeyOrText(value, fallback)
{
    let text = String(value || "")
    if (text === "") return String(fallback || "")
    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key))
    {
        return $.Localize(key)
    }
    return text.charAt(0) === "#" ? text.substring(1) : text
}

function GetItemDescription(item, item_id)
{
    let description_key = item && item.description || (item_id ? item_id + "_description" : "")
    let description = LocalizeTooltipKeyOrText(description_key, "")
    if (description !== "" && description !== description_key)
    {
        return description
    }
    return GetAttr("description", description || "")
}

function NormalizeImagePath(path, fallback)
{
    let value = String(path || "")
    if (value === "" || value === "undefined" || value === "null")
    {
        value = String(fallback || "")
    }
    if (value === "" || value === "undefined" || value === "null")
    {
        value = "file://{images}/game_hud/icons/gold.png"
    }
    return value
}

function SetImage(panel, path)
{
    if (!panel) return
    let image_path = NormalizeImagePath(path)
    panel.style.backgroundImage = "none"
    panel.style.backgroundImage = "url(\"" + image_path + "\")"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundPosition = "center"
    panel.style.backgroundRepeat = "no-repeat"
}

function NormalizeRarity(value)
{
    let rarity = String(value || "common").trim()
    if (rarity === "" || rarity === "undefined" || rarity === "null") rarity = "common"
    return rarity
}

function SetRarityClasses(panel, rarity)
{
    if (!panel) return
    rarity = NormalizeRarity(rarity)
    panel.SetHasClass("Rarity_rare", rarity === "rare")
    panel.SetHasClass("Rarity_mythical", rarity === "mythical")
    panel.SetHasClass("Rarity_legendary", rarity === "legendary")
    panel.SetHasClass("Rarity_immortal", rarity === "immortal")
    panel.SetHasClass("Rarity_super", rarity === "super")
    panel.SetHasClass("Rarity_unique", rarity === "unique")
}

function ParseJsonAttr(name, fallback)
{
    let raw = GetAttr(name, "")
    if (!raw) return fallback
    try
    {
        return JSON.parse(raw)
    }
    catch (e)
    {
        return fallback
    }
}

function FormatGeneratedStatValue(stat)
{
    let value = Number(stat && stat.value)
    if (isNaN(value)) return ""
    let formatted = typeof FormatPrecisionValue === "function" ? FormatPrecisionValue(value) : String(Math.round(value * 100) / 100)
    let result = (value >= 0 ? "+" : "") + formatted
    if (stat && (stat.percent === true || stat.percent === 1 || stat.percent === "true" || IsLevelUpPercentStatName(stat.id))) result += "%"
    return result
}

function FormatServiceTooltipStatValue(stat_name, value)
{
    if (SERVICE_DISPLAY_ONLY_STATS[String(stat_name || "")])
    {
        return ""
    }
    let numeric = Number(value)
    if (isNaN(numeric))
    {
        return String(value || "")
    }
    let formatted = typeof FormatPrecisionValue === "function" ? FormatPrecisionValue(numeric) : String(Math.round(numeric * 100) / 100)
    return (numeric >= 0 ? "+" : "") + formatted + (IsLevelUpPercentStatName(stat_name) ? "%" : "")
}

function AddStatStars(parent, stars)
{
    stars = Math.max(0, Math.floor(Number(stars) || 0))
    if (stars <= 0) return
    let stars_panel = $.CreatePanel("Panel", parent, "")
    stars_panel.AddClass("ServiceItemStatStars")
    for (let i = 0; i < stars; i++)
    {
        let star = $.CreatePanel("Panel", stars_panel, "")
        star.AddClass("ServiceItemStatStar")
    }
}

function AddGeneratedStatRows(title_key, stats, parent_panel)
{
    parent_panel = parent_panel || PANELS.stats
    stats = Array.isArray(stats) ? stats : Object.values(stats || {})
    if (stats.length <= 0) return

    let title = $.CreatePanel("Label", parent_panel, "")
    title.AddClass("ServiceItemStatGroupTitle")
    title.text = LocalizeTooltipKeyOrText(title_key, title_key)

    for (let i = 0; i < stats.length; i++)
    {
        let stat = stats[i] || {}
        let stat_id = String(stat.id || "")
        if (stat_id === "") continue
        let line = $.CreatePanel("Panel", parent_panel, "")
        line.AddClass("ServiceItemStatLine")
        let name = $.CreatePanel("Label", line, "")
        name.AddClass("ServiceItemStatName")
        name.text = LocalizeTooltipKeyOrText("services_stat_" + stat_id, stat_id)
        let label = $.CreatePanel("Label", line, "")
        label.AddClass("ServiceItemStatValue")
        label.text = FormatGeneratedStatValue(stat)
        AddStatStars(line, stat.stars)
    }
}

function AddStatRows(stats, prefix)
{
    for (let stat_name in (stats || {}))
    {
        let value = stats[stat_name]
        if (value && typeof value === "object")
        {
            AddStatRows(value, prefix ? prefix + "." + stat_name : stat_name)
            continue
        }

        let line = $.CreatePanel("Panel", PANELS.stats, "")
        line.AddClass("ServiceItemStatLine")
        let name = $.CreatePanel("Label", line, "")
        name.AddClass("ServiceItemStatName")
        name.text = LocalizeTooltipKeyOrText("services_stat_" + (prefix ? prefix + "_" + stat_name : stat_name), prefix ? prefix + "." + stat_name : stat_name)
        let label = $.CreatePanel("Label", line, "")
        label.AddClass("ServiceItemStatValue")
        label.text = FormatServiceTooltipStatValue(stat_name, value)
    }
}

function AddMetaLabel(text, class_name, parent_panel)
{
    if (!text) return
    let label = $.CreatePanel("Label", parent_panel || PANELS.meta, "")
    label.AddClass("ServiceItemMetaLabel")
    if (class_name) label.AddClass(class_name)
    label.text = text
}

function LocalizeExistingTooltipKey(key)
{
    key = String(key || "")
    if (key === "") return ""
    let localize_key = key.charAt(0) === "#" ? key : "#" + key
    if ($.CanLocalize && $.CanLocalize(localize_key))
    {
        return $.Localize(localize_key)
    }
    return ""
}

function AddGeneratedFooterLabel(text)
{
    if (!text) return
    let label = $.CreatePanel("Label", PANELS.stats, "")
    label.AddClass("ServiceItemGeneratedFooter")
    label.text = text
}

function RenderGeneratedEquipmentCompare(compare_data)
{
    PANELS.compare.RemoveAndDeleteChildren()
    const has_compare = compare_data && compare_data.generated
    PANELS.root.SetHasClass("HasCompare", !!has_compare)
    if (!has_compare) return

    let bg = $.CreatePanel("Panel", PANELS.compare, "")
    bg.AddClass("ServiceItemTooltipBG")
    bg.AddClass("ServiceItemColumnBG")
    SetRarityClasses(bg, compare_data.rarity)

    let border = $.CreatePanel("Panel", PANELS.compare, "")
    border.AddClass("ServiceItemTooltipBorder")
    border.AddClass("ServiceItemColumnBorder")

    let content = $.CreatePanel("Panel", PANELS.compare, "")
    content.AddClass("ServiceItemInfoBodyContent")

    let title = $.CreatePanel("Label", content, "")
    title.AddClass("ServiceItemCompareTitle")
    title.text = LocalizeTooltipKeyOrText("services_equipment_equipped_compare", "Equipped")

    let header = $.CreatePanel("Panel", content, "")
    header.AddClass("ServiceItemHeader")

    let icon = $.CreatePanel("Panel", header, "")
    icon.AddClass("ServiceItemIcon")
    SetImage(icon, compare_data.icon)

    let header_text = $.CreatePanel("Panel", header, "")
    header_text.AddClass("ServiceItemHeaderText")

    let name = $.CreatePanel("Label", header_text, "")
    name.AddClass("ServiceItemName")
    let compare_level = Number(compare_data.strengthen_level) || 0
    name.text = LocalizeTooltipKeyOrText(compare_data.generated_name || ("generated_equipment_slot_" + String(compare_data.slot || "")), compare_data.item_id || "generated_equipment") + (compare_level > 0 ? " +" + compare_level : "")

    let meta = $.CreatePanel("Panel", header_text, "")
    meta.AddClass("ServiceItemMeta")
    let rarity = NormalizeRarity(compare_data.rarity)
    AddMetaLabel(LocalizeExistingTooltipKey("services_rarity_" + rarity), "ServiceItemMetaRarity", meta)
    if (compare_data.slot) AddMetaLabel(LocalizeTooltipKeyOrText("services_equipment_slot_" + String(compare_data.slot), String(compare_data.slot)), "ServiceItemMetaSlot", meta)
    AddMetaLabel(LocalizeTooltipKeyOrText("services_equipment_potential", "Potential") + ": " + String(compare_data.potential || 0), "ServiceItemMetaPotential", meta)

    let divider = $.CreatePanel("Panel", content, "")
    divider.AddClass("ServiceItemDivider")

    AddGeneratedStatRows("services_equipment_normal_stats", compare_data.normal_stats || [], content)
    AddGeneratedStatRows("services_equipment_random_stats", compare_data.random_stats || [], content)
    AddGeneratedSetBlock(compare_data.set_id, compare_data.set_equipped_count, content)

    let reforge = $.CreatePanel("Label", content, "")
    reforge.AddClass("ServiceItemGeneratedFooter")
    reforge.text = LocalizeTooltipKeyOrText("services_equipment_reforge_attempts", "Reforge") + ": " + String(compare_data.potential_reforge_attempts || 0)
}

function UpdateTooltip()
{
    let item_id = GetAttr("item_id", "")
    let item = GetServiceItemsTooltip()[item_id] || {}
    let is_generated = GetAttr("generated", "") === "true"
    let rarity_source = is_generated ? GetAttr("rarity", item.rarity || "common") : (item.rarity || GetAttr("rarity", "common"))
    let rarity = NormalizeRarity(rarity_source)
    let icon = is_generated ? NormalizeImagePath(GetAttr("icon", ""), item.icon) : NormalizeImagePath(item.icon, GetAttr("icon", ""))
    let count = Number(GetAttr("count", "0")) || 0
    let slot = GetAttr("slot", "")
    let item_type = String(item.item_type || "")
    let is_currency = item_type === "currency" || item.currency
    let compare_equipped = ParseJsonAttr("compare_equipped", null)
    RenderGeneratedEquipmentCompare(compare_equipped)

    SetRarityClasses(PANELS.bg, rarity)

    let strengthen_level = Number(GetAttr("strengthen_level", "0")) || 0
    SetImage(PANELS.icon, icon)
    PANELS.name.text = is_generated
        ? (LocalizeTooltipKeyOrText(GetAttr("generated_name", "") || ("generated_equipment_slot_" + slot), item_id) + (strengthen_level > 0 ? " +" + strengthen_level : ""))
        : (typeof LocalizeServiceItemName === "function" ? LocalizeServiceItemName(item, item_id) : LocalizeTooltipKeyOrText(item_id, item_id))

    PANELS.meta.RemoveAndDeleteChildren()
    AddMetaLabel(LocalizeExistingTooltipKey("services_rarity_" + rarity), "ServiceItemMetaRarity")
    if (is_generated && slot) AddMetaLabel(LocalizeTooltipKeyOrText("services_equipment_slot_" + slot, slot), "ServiceItemMetaSlot")
    if (is_generated) AddMetaLabel(LocalizeTooltipKeyOrText("services_equipment_potential", "Potential") + ": " + GetAttr("potential", "0"), "ServiceItemMetaPotential")
    if (is_generated && strengthen_level > 0) AddMetaLabel(LocalizeTooltipKeyOrText("services_forge_strengthen_level", "Enhance") + ": +" + strengthen_level, "ServiceItemMetaStrengthen")
    if (!is_currency && !is_generated && count > 1) AddMetaLabel("x" + String(count), "ServiceItemMetaCount")

    let description = (is_generated || item_type === "equipment") ? "" : GetItemDescription(item, item_id)
    PANELS.description.text = description || ""
    PANELS.description.style.visibility = PANELS.description.text ? "visible" : "collapse"

    PANELS.stats.RemoveAndDeleteChildren()
    if (is_generated)
    {
        AddGeneratedStatRows("services_equipment_normal_stats", ParseJsonAttr("normal_stats", []))
        AddGeneratedStatRows("services_equipment_random_stats", ParseJsonAttr("random_stats", []))
        AddGeneratedSetBlock(GetAttr("set_id", ""), GetAttr("set_equipped_count", "0"))
        AddGeneratedFooterLabel(LocalizeTooltipKeyOrText("services_equipment_reforge_attempts", "Reforge") + ": " + GetAttr("potential_reforge_attempts", "0"))
    }
    else
    {
        if (item_type === "atlas" && Number(item.blessing_exp) > 0)
        {
            let line = $.CreatePanel("Panel", PANELS.stats, "")
            line.AddClass("ServiceItemStatLine")
            let name = $.CreatePanel("Label", line, "")
            name.AddClass("ServiceItemStatName")
            name.text = LocalizeTooltipKeyOrText("services_stat_blessing_exp", "Blessing exp")
            let label = $.CreatePanel("Label", line, "")
            label.AddClass("ServiceItemStatValue")
            label.text = FormatServiceTooltipStatValue("blessing_exp", item.blessing_exp)
        }
        AddStatRows(item.stats, "")
    }
    PANELS.stats.style.visibility = PANELS.stats.Children().length > 0 ? "visible" : "collapse"
}