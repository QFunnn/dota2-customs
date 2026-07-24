--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CHEST_MILESTONE_TOOLTIP = {
    title: $("#ChestMilestoneTooltipTitle"),
    state: $("#ChestMilestoneTooltipState"),
    rewards: $("#ChestMilestoneTooltipRewards"),
}

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function SetTooltipPanelImage(panel, image)
{
    if (!panel || !image) return
    panel.style.backgroundImage = "url('" + image + "')"
    panel.style.backgroundSize = "100%"
}

function GetServiceItemsSafe()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}
}

function GetServiceChestsSafe()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "chests") || {}) : {}
}

function GetPlayerDataSafe()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_player", String(Players.GetLocalPlayer())) || {}) : {}
}

function FindMilestone(chest, milestone_id)
{
    for (let milestone of Object.values((chest && chest.milestones) || {}))
    {
        let open_count = Number(milestone.open_count || milestone.count || milestone.opens) || 0
        let id = String(milestone.id || open_count)
        if (id === milestone_id)
        {
            return { id: id, open_count: open_count, rewards: Object.values(milestone.rewards || {}) }
        }
    }
    return null
}

function UpdateTooltip()
{
    let chest_id = GetAttr("chest_id", "")
    let milestone_id = GetAttr("milestone_id", "")
    let chests = GetServiceChestsSafe()
    let chest = chests.list && chests.list[chest_id] || {}
    let milestone = FindMilestone(chest, milestone_id)
    let player_data = GetPlayerDataSafe()
    let opened_data = player_data.chest_opened_data && player_data.chest_opened_data[chest_id] || {}
    let claimed = !!(opened_data.claimed_milestones && milestone && opened_data.claimed_milestones[milestone.id])

    if (!milestone)
    {
        CHEST_MILESTONE_TOOLTIP.title.text = $.Localize("#services_chest_milestone_tooltip_title_missing")
        return
    }

    CHEST_MILESTONE_TOOLTIP.title.SetDialogVariable("opens", String(milestone.open_count))
    CHEST_MILESTONE_TOOLTIP.title.text = $.Localize("#services_chest_milestone_tooltip_title", CHEST_MILESTONE_TOOLTIP.title)
    if (CHEST_MILESTONE_TOOLTIP.state)
    {
        CHEST_MILESTONE_TOOLTIP.state.style.visibility = "collapse"
    }

    CHEST_MILESTONE_TOOLTIP.rewards.RemoveAndDeleteChildren()
    let items = GetServiceItemsSafe()
    for (let reward of milestone.rewards)
    {
        let item = items[reward.id] || {}
        let row = $.CreatePanel("Panel", CHEST_MILESTONE_TOOLTIP.rewards, "")
        row.AddClass("ChestMilestoneTooltipReward")

        let icon = $.CreatePanel("Panel", row, "")
        icon.AddClass("ChestMilestoneTooltipRewardIcon")
        SetTooltipPanelImage(icon, item.icon || "file://{images}/game_hud/icons/gold.png")

        let name = $.CreatePanel("Label", row, "")
        name.AddClass("ChestMilestoneTooltipRewardName")
        name.text = typeof LocalizeServiceItemName === "function" ? LocalizeServiceItemName(item, reward.id) : reward.id

        let count = Number(reward.count) || 1
        if (count > 1)
        {
            let count_label = $.CreatePanel("Label", row, "")
            count_label.AddClass("ChestMilestoneTooltipRewardCount")
            count_label.text = "x" + String(count)
        }
    }
}