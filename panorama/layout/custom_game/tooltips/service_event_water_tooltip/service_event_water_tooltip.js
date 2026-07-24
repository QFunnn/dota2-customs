--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function GetTooltipItems()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}
}

function GetTooltipPromoEvents()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "promo_events") || {}) : {}
}

function TooltipToArray(data)
{
    if (!data) return []
    if (data instanceof Array) return data
    let result = []
    let keys = Object.keys(data)
    keys.sort(function(a, b) { return (Number(a) || 0) - (Number(b) || 0) })
    for (let i = 0; i < keys.length; i++) result.push(data[keys[i]])
    return result
}

function FindTooltipEvent(event_id)
{
    let config = GetTooltipPromoEvents()
    let events = TooltipToArray(config.events)
    for (let i = 0; i < events.length; i++)
    {
        if (events[i] && String(events[i].id) === String(event_id)) return events[i]
    }
    return null
}

function TooltipSetImage(panel, path)
{
    panel.style.backgroundImage = "url('" + path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

function UpdateTooltip()
{
    let event = FindTooltipEvent(GetAttr("event_id", ""))
    let items = GetTooltipItems()

    let title = $("#EventWaterTooltipTitle")
    if (title) title.text = $.Localize("#services_event_currency_watering_can")

    let desc = $("#EventWaterTooltipDesc")
    if (desc)
    {
        let hint_key = event && event.currency && event.currency.earn_hint ? String(event.currency.earn_hint) : "#services_event_currency_earn_hint"
        desc.text = $.Localize(hint_key)
    }

    let rewardsRow = $("#EventWaterTooltipRewards")
    if (!rewardsRow) return
    rewardsRow.RemoveAndDeleteChildren()
    let rewards = TooltipToArray(event && event.water && event.water.rewards)
    for (let i = 0; i < rewards.length; i++)
    {
        let reward = rewards[i] || {}
        let item = items[reward.id] || {}
        let cell = $.CreatePanel("Panel", rewardsRow, "")
        cell.AddClass("EventWaterRewardCell")
        let bg = $.CreatePanel("Panel", cell, "")
        bg.AddClass("EventWaterRewardBG")
        let icon = $.CreatePanel("Panel", cell, "")
        icon.AddClass("EventWaterRewardIcon")
        TooltipSetImage(icon, item.icon || "")
        let name = $.CreatePanel("Label", cell, "")
        name.AddClass("EventWaterRewardName")
        name.text = $.Localize(item.name || item.id || "")
    }
}