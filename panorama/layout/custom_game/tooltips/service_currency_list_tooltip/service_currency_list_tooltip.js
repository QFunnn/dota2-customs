--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const SERVICE_CURRENCY_IDS = ["coin", "stone", "moon", "sand_time", "magic_crystal", "night_crystal", "leaf", "companion_coin", "auto_victory_token"]

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function ParseJsonAttr(name, fallback)
{
    let raw = GetAttr(name, "")
    if (!raw) return fallback || {}
    try
    {
        return JSON.parse(raw)
    }
    catch (e)
    {
        return fallback || {}
    }
}

function GetServiceItems()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}
}

function SetCurrencyImage(panel, path)
{
    if (!panel) return
    let image_path = String(path || "file://{images}/game_hud/icons/gold.png")
    panel.style.backgroundImage = "url(\"" + image_path + "\")"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundPosition = "center"
    panel.style.backgroundRepeat = "no-repeat"
}

function LocalizeKeyOrText(value, fallback)
{
    let text = String(value || "")
    if (text === "") return String(fallback || "")
    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key)) return $.Localize(key)
    return text.charAt(0) === "#" ? text.substring(1) : text
}

function UpdateTooltip()
{
    let list = $("#ServiceCurrencyList")
    list.RemoveAndDeleteChildren()
    let items = GetServiceItems()
    let currencies = ParseJsonAttr("currencies", {})
    for (let i = 0; i < SERVICE_CURRENCY_IDS.length; i++)
    {
        let currency_id = SERVICE_CURRENCY_IDS[i]
        let item = items[currency_id] || {}
        if (!item.id && !Object.prototype.hasOwnProperty.call(currencies, currency_id)) continue
        let row = $.CreatePanel("Panel", list, "")
        row.AddClass("ServiceCurrencyListRow")
        let icon = $.CreatePanel("Panel", row, "")
        icon.AddClass("ServiceCurrencyListIcon")
        SetCurrencyImage(icon, item.icon)
        let info = $.CreatePanel("Panel", row, "")
        info.AddClass("ServiceCurrencyListInfo")
        let name = $.CreatePanel("Label", info, "")
        name.AddClass("ServiceCurrencyListName")
        name.text = typeof LocalizeServiceItemName === "function" ? LocalizeServiceItemName(item, currency_id) : LocalizeKeyOrText(currency_id, currency_id)
        let description = $.CreatePanel("Label", info, "")
        description.AddClass("ServiceCurrencyListDescription")
        description.text = LocalizeKeyOrText((item.description || currency_id + "_description"), "")
        let amount = $.CreatePanel("Label", row, "")
        amount.AddClass("ServiceCurrencyListAmount")
        amount.text = String(currencies[currency_id] || 0)
    }
}