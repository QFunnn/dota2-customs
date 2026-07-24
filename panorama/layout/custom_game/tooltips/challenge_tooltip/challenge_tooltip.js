--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function UpdateTooltip()
{
    let parent = $.GetContextPanel().GetParent().GetParent();
    let image = $.GetContextPanel().GetAttributeString("image", "")

    $("#TooltipBG").SetHasClass("challenge", false)
    $("#TooltipBG").SetHasClass("challenge2", false)
    $("#TooltipBG").SetHasClass("challenge3", false)
    $("#TooltipBG").SetHasClass("challenge"+image, true)

    let header_text = $.GetContextPanel().GetAttributeString("header", "")
    let description_text = $.GetContextPanel().GetAttributeString("description", "")
    let description_text_2 = $.GetContextPanel().GetAttributeString("description_2", "")
    $("#ChallengeName").text = $.Localize("#"+header_text)
    $("#ChallengeDescription").text = $.Localize("#"+description_text)
    $("#RewardName").text = $.Localize("#"+description_text_2)

    UpdateAutocastStatus()
}

function UpdateAutocastStatus()
{
    let ctx = $.GetContextPanel()
    if (!ctx || !ctx.IsValid()) { return }

    let challenger_id = ctx.GetAttributeString("challenger_id", "")
    let statusWindow = $("#ChallengeAutocastWindow")
    let statusLabel = $("#ChallengeAutocastStatus")
    if (statusWindow && statusLabel)
    {
        let unlocked = false
        let enabled = false
        if (challenger_id !== "")
        {
            let table = Game.GetCustomTable("challenger_state", String(Game.GetLocalPlayerID())) || {}
            let st = (table.challengers || {})[challenger_id] || {}
            unlocked = Number(st.autocast_unlocked || 0) === 1
            enabled = Number(st.autocast_enabled || 0) === 1
        }
        statusWindow.SetHasClass("AutocastWindowHidden", !unlocked)
        if (unlocked)
        {
            statusLabel.text = $.Localize(enabled ? "#trial_autocast_enabled" : "#trial_autocast_disabled")
            statusLabel.SetHasClass("AutocastOn", enabled)
            statusLabel.SetHasClass("AutocastOff", !enabled)
        }
    }

    $.Schedule(0.1, UpdateAutocastStatus)
}