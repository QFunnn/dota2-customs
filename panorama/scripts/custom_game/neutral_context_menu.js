--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()

function GoToNeutralStash(){
    if(MAIN_PANEL.Item != undefined){
        GameEvents.SendCustomGameEventToServer( "neutrals_move_item_to_stash", {entindex: MAIN_PANEL.Item} )
        $.DispatchEvent("DismissAllContextMenus");
    }
}