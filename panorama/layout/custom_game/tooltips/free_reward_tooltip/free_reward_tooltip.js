--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function UpdateFreeRewardTooltip()
{
    var root = $.GetContextPanel()
    var coins = root.GetAttributeString("coins", "10")
    var crystals = root.GetAttributeString("crystals", "5")
    var has_plus = root.GetAttributeString("has_plus", "0") == "1"
    var claimed = root.GetAttributeString("claimed", "0") == "1"

    $("#FreeRewardTooltipCoins").text = "+" + coins
    $("#FreeRewardTooltipCrystals").text = "+" + crystals
    $("#FreeRewardTooltipCrystalRow").SetHasClass("Inactive", !has_plus)

    var plus_status = $("#FreeRewardTooltipPlusStatus")
    plus_status.text = $.Localize(has_plus ? "#free_reward_tooltip_plus_active" : "#free_reward_tooltip_plus_inactive")
    plus_status.SetHasClass("Positive", has_plus)
    plus_status.SetHasClass("Negative", !has_plus)

    var claim_status = $("#FreeRewardTooltipClaimStatus")
    claim_status.text = $.Localize(claimed ? "#free_reward_tooltip_claimed" : "#free_reward_tooltip_available")
    claim_status.SetHasClass("Positive", !claimed)
    claim_status.SetHasClass("Negative", claimed)
}