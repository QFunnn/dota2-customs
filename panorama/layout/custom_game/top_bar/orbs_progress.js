--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const ORBS_TYPE_COMMON = 1;
const ORBS_TYPE_RARE = 2;
const ORBS_TYPE_EPIC = 4;

const TOPBAR = {
	TEAMS_ROOT: $("#TopBar_TeamsList"),
};

const BARS = {
	[ORBS_TYPE_COMMON]: "OrbsProgress_Bar_Common",
	[ORBS_TYPE_RARE]: "OrbsProgress_Bar_Rare",
};
function ListenToOrbNetTable(data) {
	if (IsSpectating()) {
		for (var teamId of Game.GetAllTeamIDs()) {
			UpdateOrbsProgress({}, teamId);
		}
	} else {
		if (!data.team && Game.GetLocalPlayerInfo() && Game.GetLocalPlayerInfo().player_team_id)
			team = Game.GetLocalPlayerInfo().player_team_id;
		UpdateOrbsProgress(data, data.team);
	}
}
let schedule_orb_progression_animation_common;
let schedule_orb_progression_animation_rare;
function UpdateOrbsProgress(data, team) {
	if (!team && Game.GetLocalPlayerInfo() && Game.GetLocalPlayerInfo().player_team_id)
		team = Game.GetLocalPlayerInfo().player_team_id;
	if (!data || typeof data != "object" || Object.keys(data).length === 0)
		data = CustomNetTables.GetTableValue("orbs", "current_progress_" + team);
	if (!data) return;
	const orb_type = data.orb_type;
	if (!orb_type) return;
	if (!TOPBAR) return;
	if (!TOPBAR.TEAMS_ROOT) return;
	if (!TOPBAR.TEAMS_ROOT.FindChildTraverse("TopBar_Team_" + team)) return;
	const bar = TOPBAR.TEAMS_ROOT.FindChildTraverse("TopBar_Team_" + team).FindChildTraverse(BARS[orb_type]);
	if (!bar) return;

	const current = data.current || 0;
	const max = data.max || 1000;

	const pct_value = current / max;
	bar.value = pct_value;
	const bar_parent = bar.GetParent();
	if (orb_type == ORBS_TYPE_COMMON) {
		if (pct_value > 0.99)
			TriggerClassBySchedule(schedule_orb_progression_animation_common, "OrbProgressionGoalShake_Common");

		bar_parent.SetDialogVariable("value", Math.round(Math.abs(bar.value) * 100));
	} else if (orb_type == ORBS_TYPE_RARE) {
		if (current == 0)
			TriggerClassBySchedule(schedule_orb_progression_animation_rare, "OrbProgressionGoalShake_Rare");

		bar_parent.SetDialogVariable("current", current);
		bar_parent.SetDialogVariable("max", max);
	}
}
function ToggleBarsVisibility() {
	$.GetContextPanel().ToggleClass("HideBars");
}
function InitUI(iTeamNumber) {
	UpdateOrbsProgress(
		{
			orb_type: ORBS_TYPE_COMMON,
			current: 0,
		},
		iTeamNumber,
	);

	UpdateOrbsProgress(
		{
			orb_type: ORBS_TYPE_RARE,
			current: 0,
			max: 2,
		},
		iTeamNumber,
	);
}
(function () {
	if (IsSpectating()) {
		for (var teamId of Game.GetAllTeamIDs()) {
			InitUI(teamId);
		}
	} else {
		InitUI(Game.GetLocalPlayerInfo().player_team_id);
	}

	CustomNetTables.SubscribeNetTableListener("orbs", ListenToOrbNetTable);
})();