--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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

var no_talents_heroes = null

Game.IsNoTalentsHero = function(hero_name)
{
	if (!hero_name || hero_name == "undefined")
	{
		let unit = Players.GetLocalPlayerPortraitUnit()

		if (unit == -1)
			return false

		hero_name = Entities.GetUnitName(unit)
	}

	if (hero_name == "npc_dota_hero_target_dummy")
		return true

	if (no_talents_heroes == null)
		no_talents_heroes = CustomNetTables.GetTableValue("custom_pick", "hero_list_extra")

	return no_talents_heroes != null && no_talents_heroes[hero_name] !== undefined
}


var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
dotaHud.FindChildTraverse("StatBranch").style.visibility = "collapse";

var setup_holder = null
var setup_ring = null
var setup_text = null
var setup_button = null
var setup_locked = false
var setup_time = null

GameEvents.Subscribe_custom("setup_time", function(data)
{
	setup_time = data.time
})

function SetupLock()
{
	if (setup_locked)
		return

	setup_locked = true
	setup_ring.AddClass("SetupTimerRing_locked")
	setup_button.AddClass("SetupStartButton_locked")
}

function SetupPhase()
{
	let state = Game.GetState()

	if (state !== DOTA_GameState.DOTA_GAMERULES_STATE_INIT &&
		state !== DOTA_GameState.DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD &&
		state !== DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP) return

	for (let name of ["AutoAssignButton", "ShuffleTeamAssignmentButton", "CancelAndUnlockButton", "StartGameCountdownTimer"])
	{
		let panel = dotaHud.FindChildTraverse(name)
		if (panel)
			panel.style.visibility = "collapse"
	}

	let lock = dotaHud.FindChildTraverse("LockAndStartButton")

	if (setup_time !== null && lock)
	{
		if (setup_holder === null)
		{
			setup_holder = $.CreatePanel("Panel", dotaHud, "CustomSetupHolder")
			setup_holder.BLoadLayout("file://{resources}/layout/custom_game/setup_button.xml", false, false)

			setup_ring = setup_holder.FindChildTraverse("SetupTimerRing")
			setup_text = setup_holder.FindChildTraverse("SetupTimerText")
			setup_button = setup_holder.FindChildTraverse("SetupStartButton")

			if (setup_ring === null || setup_text === null || setup_button === null)
			{
				setup_holder.DeleteAsync(0)
				setup_holder = null

				$.Schedule(0.5, SetupPhase)
				return
			}

			let root = lock.GetParent()
			let unassigned = dotaHud.FindChildTraverse("UnassignedPlayerPanel")

			setup_ring.SetParent(root)

			if (unassigned)
			{
				root.MoveChildBefore(setup_ring, unassigned)
				setup_button.SetParent(unassigned)
			}
			else
			{
				root.MoveChildAfter(setup_ring, lock)

				setup_button.SetParent(root)
				root.MoveChildAfter(setup_button, lock)
			}

			setup_button.SetPanelEvent("onactivate", function()
			{
				if (setup_locked)
					return

				SetupLock()
				Game.EmitSound("UI.Click")
				GameEvents.SendCustomGameEventToServer_custom("setup_start_now", {})
			})

			setup_ring.RemoveClass("SetupHidden")
		}

		lock.style.visibility = "collapse"

		let info = Game.GetLocalPlayerInfo()
		setup_button.SetHasClass("SetupHidden", info == null || !info.player_has_host_privileges)

		setup_text.text = String(setup_time)

		if (setup_time <= 3)
			SetupLock()
	}

	$.Schedule(0.1, SetupPhase)
}

SetupPhase()

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

for (let name of ["BuybackCostIcon", "BuybackCostIconCooldown"])
{
    let icon = dotaHud.FindChildTraverse(name)
    if (icon)
        icon.style.visibility = "collapse"
}

for (let name of ["BuybackCostLabel", "BuybackCooldownLabel"])
{
    let label = dotaHud.FindChildTraverse(name)
    if (label)
    {
        label.text = $.Localize("#buyback_once")
        label.style.marginLeft = "0px"
        label.style.paddingLeft = "0px"
        label.style.fontSize = "16px"
        label.style.letterSpacing = "0px"
        label.style.fontFamily = "Radiance"
        label.RemoveClass("MonoNumbersFont")
    }
}

var RadarButton = dotaHud.FindChildTraverse("RadarButton")
if (RadarButton)
    RadarButton.style.visibility = "collapse"

dotaHud.FindChildTraverse("StatBranchDrawer").style.visibility = "collapse";

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