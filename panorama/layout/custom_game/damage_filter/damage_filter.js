--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = FindDotaHudElement("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

GameEvents.Subscribe_custom("WODA_Player_update_damage_filter", WODA_Player_update_damage_filter);

function WODA_Player_update_damage_filter(data)
{
    UpdateDamageFilter("Incoming", data[1])
    UpdateDamageFilter("Outgoing", data[2])
}
 
function UpdateDamageFilter(type, table)
{
    let physical_damage = table[1] || 0
    let magical_damage = table[2] || 0
    let pure_damage = table[4] || 0
    let all_damage = physical_damage + magical_damage + pure_damage
    if (all_damage > 0)
    {
        $("#PhysicalDamage"+type).style.width = Math.max(0, (physical_damage / all_damage * 100)) + "%";
        $("#MagicalDamage"+type).style.width = Math.max(0, (magical_damage / all_damage * 100)) + "%";
        $("#PureDamage"+type).style.width = Math.max(0, (pure_damage / all_damage * 100)) + "%";
    
        $("#PhysicalDamage"+type).GetChild(0).text = (physical_damage / all_damage * 100).toFixed(0) + "%"
        $("#MagicalDamage"+type).GetChild(0).text = (magical_damage / all_damage * 100).toFixed(0) + "%"
        $("#PureDamage"+type).GetChild(0).text = (pure_damage / all_damage * 100).toFixed(0) + "%"
     
        $("#PhysicalDamage"+type).GetChild(1).text = Math.floor(physical_damage)
        $("#MagicalDamage"+type).GetChild(1).text = Math.floor(magical_damage)
        $("#PureDamage"+type).GetChild(1).text = Math.floor(pure_damage)
    }
}

function ResetDamageFilter(type)
{
    $("#PhysicalDamage"+type).style.width = "33%";
    $("#MagicalDamage"+type).style.width = "33%";
    $("#PureDamage"+type).style.width = "34%";

    $("#PhysicalDamage"+type).GetChild(0).text = "0%"
    $("#MagicalDamage"+type).GetChild(0).text = "0%"
    $("#PureDamage"+type).GetChild(0).text = "0%"
 
    $("#PhysicalDamage"+type).GetChild(1).text = "0"
    $("#MagicalDamage"+type).GetChild(1).text = "0"
    $("#PureDamage"+type).GetChild(1).text = "0"
}

function ResetPlayerDamage(type)
{
    GameEvents.SendCustomGameEventToServer_custom("WODA_Player_reset_damage_filter", {damage_type : type});
    ResetDamageFilter("Incoming")
    ResetDamageFilter("Outgoing")
}

function CheckPlayerSubscribe()
{
    let DamageFilterPanel = $("#DamageFilterPanel");
    if (IsPlayerHasSubscribe(Game.GetLocalPlayerID())) 
    {
        if (DamageFilterPanel) 
        {
            DamageFilterPanel.visible = true
        }
    }
    else
    {
        if (DamageFilterPanel) 
        {
            DamageFilterPanel.visible = false
        }
    }
    $.Schedule(1, CheckPlayerSubscribe)
}

CheckPlayerSubscribe()