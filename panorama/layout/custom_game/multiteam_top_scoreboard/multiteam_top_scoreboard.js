--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var g_ScoreboardHandle = null;

function UpdateScoreboard()
{
	ScoreboardUpdater_SetScoreboardActive( g_ScoreboardHandle, true );
	$.Schedule( 0.2, UpdateScoreboard );
}

(function()
{
	var scoreboardConfig =
	{
		"teamXmlName" : "file://{resources}/layout/custom_game/multiteam_top_scoreboard/multiteam_top_scoreboard_team.xml",
		"playerXmlName" : "file://{resources}/layout/custom_game/multiteam_top_scoreboard/multiteam_top_scoreboard_player.xml",
	};
	g_ScoreboardHandle = ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, $( "#MultiteamScoreboard" ) );
	UpdateScoreboard();
    $.GetContextPanel().GetParent().style.zIndex = "-2"
})();