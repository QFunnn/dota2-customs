--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function OnShowInShop() {
    //@ts-ignore
    const itemName = Abilities.GetAbilityName($.GetContextPanel().Item);
    const itemClickedEvent = {
        "link": ("dota.item." + itemName),
        "shop": 0,
        "recipe": 0
    };
    GameEvents.SendEventClientSide("dota_link_clicked", itemClickedEvent);
    $.DispatchEvent("DismissAllContextMenus");
}
function OnSell() {
    //@ts-ignore
    GameEvents.SendCustomGameEventToServer("items_sell_from_custom_stash", { source: Players.GetLocalPlayerPortraitUnit(), item: $.GetContextPanel().Item });
    $.DispatchEvent("DismissAllContextMenus");
}