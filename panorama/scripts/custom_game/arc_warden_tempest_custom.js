--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

var TEMPEST_ARC_WARDEN_ID = null

InitSelectedAnimation()

GameEvents.Subscribe_custom('update_tempest_entindex_js', update_tempest_entindex_js)

function SelectWarden(unit)
{
    let original_entindex = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )
    if (unit == "original")
    {
        GameUI.SelectUnit( original_entindex, false )
    }
    if (unit == "tempest")
    {
        if (TEMPEST_ARC_WARDEN_ID != null)
        {
            GameUI.SelectUnit( TEMPEST_ARC_WARDEN_ID, false )
        }
    }
}

function InitSelectedAnimation()
{
    let original_entindex = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )
    let selected = Players.GetLocalPlayerPortraitUnit()

    if (selected == original_entindex)
    {
        $("#ArcWardenOriginal").SetHasClass("ArcWardenSelected", true)
        $("#ArcWardenTempest").SetHasClass("ArcWardenSelected", false)
    }
    else if (TEMPEST_ARC_WARDEN_ID != null && selected == TEMPEST_ARC_WARDEN_ID)
    {
        $("#ArcWardenOriginal").SetHasClass("ArcWardenSelected", false)
        $("#ArcWardenTempest").SetHasClass("ArcWardenSelected", true)
    }
    else 
    {
        $("#ArcWardenOriginal").SetHasClass("ArcWardenSelected", false)
        $("#ArcWardenTempest").SetHasClass("ArcWardenSelected", false)
    }
    $.Schedule(0.1 , InitSelectedAnimation);
}

function update_tempest_entindex_js(data)
{
    TEMPEST_ARC_WARDEN_ID = data.entindex
    $("#ArcWardenUnits").style.opacity = "1"
}