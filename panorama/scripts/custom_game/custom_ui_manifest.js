--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


'use strict';

GameEvents.Subscribe_custom("panorama_cooldown_error", function(data) 
{
	GameEvents.SendEventClientSide("dota_hud_error_message", 
	{
		"splitscreenplayer": 0,
		"reason": data.reason || 80,
		"message": $.Localize(data.message) + data.time
	})
})

var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
dotaHud.FindChildTraverse("StatBranch").style.visibility = "collapse";

//dotaHud.FindChildTraverse("FacetIcon").style.visibility = "collapse";
//dotaHud.FindChildTraverse("FacetDetails").style.visibility = "collapse";

var mapHud = dotaHud.FindChildTraverse("HUDSkinMinimap")

if (mapHud)
{
   mapHud.style.visibility = "collapse"     
}

var TopHud = dotaHud.FindChildTraverse("HUDSkinTopBarBG")

if (TopHud)
{
   TopHud.style.visibility = "collapse"     
}


var RoshanTimerContainer = dotaHud.FindChildTraverse("RoshanTimerContainer")
if (RoshanTimerContainer)
    RoshanTimerContainer.style.visibility = "collapse"

var TormentorTimerContainer = dotaHud.FindChildTraverse("TormentorTimerContainer")
if (TormentorTimerContainer)
    TormentorTimerContainer.style.visibility = "collapse"

dotaHud.FindChildTraverse("DOTAStatBranch").style.visibility = "collapse";

var ChatHud = dotaHud.FindChildTraverse("HudChat")
var game_mode_table = CustomNetTables.GetTableValue("custom_pick", "game_mode")

if ( !Game.IsInToolsMode() && (game_mode_table && game_mode_table.team_size < 2) )
{
    //ChatHud.DeleteAsync(0)     
}

$.RegisterForUnhandledEvent("StyleClassesChanged", function(panel)
{
    if(panel == null)
    {
        return;
    }
    if (panel.id == "ScoreboardMuteContextMenu")
    {
        let button = panel.FindChildTraverse("MenuOptionsPanel")
        for (let child of button.Children())
        {
            let label = child.GetChild(0)
            if (label.text.includes($.Localize("#DOTA_UserMenu_Swap")) || label.text.includes($.Localize("#DOTA_HUD_Scoreboard_SwapHero")))
            {
                child.visible = false
            }
        }
    }
})




dotaHud.FindChildTraverse("level_stats_frame").style.visibility = "collapse";

dotaHud.FindChildTraverse("inventory_tpscroll_HotkeyContainer").FindChildTraverse("Hotkey").style.visibility = "visible"

GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );

GameEvents.Subscribe_custom("Attack_Base", function(data) 
{
    Game.EmitSound(data.sound);
})

var PreGame = dotaHud.FindChildTraverse("PreGame");


PreGame.style.opacity = "0";


GameEvents.Subscribe_custom("CreateIngameErrorMessage", function(data) 
{
    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": data.reason || 80,
        "message": data.message
    })
})


GameUI.CustomUIConfig().team_select = 
{
    "bShowSpectatorTeam" : true
}