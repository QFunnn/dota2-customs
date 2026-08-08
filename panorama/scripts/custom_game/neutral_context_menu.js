--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()

function GoToNeutralStash(){
    if(MAIN_PANEL.Item != undefined){
        GameEvents.SendCustomGameEventToServer( "neutrals_move_item_to_stash", {entindex: MAIN_PANEL.Item} )
        $.DispatchEvent("DismissAllContextMenus");
    }
}