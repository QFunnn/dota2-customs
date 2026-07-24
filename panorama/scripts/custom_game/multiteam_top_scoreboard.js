--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

var g_ScoreboardHandle = null;

function init()
{
	GameEvents.Subscribe_custom('PreGameEnd_top', PreGameEnd)
    if (IsSpectator())
    {
        PreGameEnd()
    }
}

function ChangePositionTimerDuo()
{
    let timer_panels = 
    [
        "TimeOfDay",
        "TimeOfDayBG",
        "DayGlow",
        "NightGlow",
        "TimeUntil",
    ]
    let Hud = FindDotaHudElement("Hud")
    if (Hud.BHasClass("AspectRatio21x9"))
    {  
        let topbar = FindDotaHudElement("topbar")
        if (topbar)
        {
            topbar.style.width = "100%"
        }
    }
    for (let timer_child_name of timer_panels)
    {
        let timer_child = FindDotaHudElement(timer_child_name)
        if (timer_child)
        {
            let margin = 50
            if (Hud.BHasClass("AspectRatio16x10"))
            {
                margin = 150
            }
            if (Hud.BHasClass("AspectRatio21x9"))
            {
                margin = 200
            }
            if (Hud.BHasClass("AspectRatio4x3"))
            {
                margin = 200
            }
            if (timer_child_name == "TimeOfDay")
            {
                margin = margin + 5
            }
            if (timer_child_name == "TimeUntil")
            {
                margin = margin - 20
            }
            timer_child.style.marginLeft = margin + "px"
            timer_child.style.horizontalAlign = "left"
        }
    }
}

const dotaHud = (() => 
{
    let panel = $.GetContextPanel();
    while (panel) 
    {
        if (panel.id === "DotaHud")
            return panel;
        panel = panel.GetParent();
    }
    return panel;
})();

const FindDotaHudElement = (id) => 
{
    return dotaHud.FindChildTraverse(id);
};

let SpectatorTable = 
{
    "spectator_game_stats" : true,
    "SpectatorGraph" : true,
    "spectator_options" : true,
    "DOTASpectatorOverwatch" : true,
    "SpectatorGoldDisplay" : true,
} 

for (let spec_panel of Object.keys(SpectatorTable)) 
{
    let panel_in_hud = FindDotaHudElement(spec_panel)
    if (panel_in_hud)
    {
        panel_in_hud.visible = false
        panel_in_hud.style.opacity = "0"
    }
}

function IsSpectator() {
	const localPlayer = Players.GetLocalPlayer()
	if (Players.IsSpectator(localPlayer))
		return true
	const localTeam = Players.GetTeam(localPlayer)
	return localTeam !== 2 &&
		localTeam !== 3 &&
		localTeam !== 6 &&
		localTeam !== 7 &&
		localTeam !== 12 &&
		localTeam !== 9
}

init()

function PreGameEnd()
{
	let main = $.GetContextPanel().FindChildTraverse("TopBarScoreboard")
	if (main)
	{
		main.RemoveClass("TopBarScoreboard_hidden")
		main.RemoveClass("TopBarScoreboard")
		main.AddClass("TopBarScoreboard")
	}
}

function UpdateScoreboard()
{
	ScoreboardUpdater_SetScoreboardActive( g_ScoreboardHandle, true );
	$.Schedule(0.5, UpdateScoreboard );
}

(function()
{
    let game_mode_table = CustomNetTables.GetTableValue("custom_pick", "game_mode")
    if (game_mode_table && game_mode_table.team_size >= 2)
    {
        $.GetContextPanel().AddClass("IsDuoMode")
        // ChangePositionTimerDuo()
    }
    
	var shouldSort = true;
	if ( ScoreboardUpdater_InitializeScoreboard === null ) { $.Msg( "WARNING: This file requires shared_scoreboard_updater.js to be included." ); }
	var scoreboardConfig =
	{
		"teamXmlName" : "file://{resources}/layout/custom_game/multiteam_top_scoreboard_team.xml",
		"playerXmlName" : "file://{resources}/layout/custom_game/multiteam_top_scoreboard_player.xml",
		"shouldSort" : shouldSort
	};
	g_ScoreboardHandle = ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, $( "#MultiteamScoreboard" ) );
	UpdateScoreboard();
})();