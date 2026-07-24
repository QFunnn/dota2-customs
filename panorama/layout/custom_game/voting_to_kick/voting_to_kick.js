--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let bVotingIsNow = false;
const HUD = {
	CONTEXT: $.GetContextPanel(),
	HIDE_VOTING_ARROW: $("#HideVotingWrap"),
	VOTING_ROOT: $("#VotingToKickVoting"),
	REASON_SELECTOR: $("#VotingToKickReasonPanel"),
	MODEL_ROOT: $("#VotingToKickModelPanel"),
};

function VotingToKickShowVoting(data) {
	HUD.CONTEXT.SetHasClass("ShowVoting", true);
	HUD.CONTEXT.SetHasClass("BHideVoting", false);
	HUD.CONTEXT.SetHasClass("BPlayerReported", false);
	VotingToKickHideReason();

	let timer_voting = $.CreatePanel("Panel", HUD.VOTING_ROOT, "VotingToKickCountdown");
	timer_voting.AddClass("Active");

	let target_player = Game.GetPlayerInfo(data.target_id);

	HUD.CONTEXT.SetDialogVariableLocString("reason", `#voting_to_kick_reason_${data.reason}`);
	HUD.CONTEXT.SetDialogVariable("target_player_name", target_player.player_name);
	HUD.CONTEXT.SetDialogVariableInt("kills", Players.GetKills(data.target_id));
	HUD.CONTEXT.SetDialogVariableInt("deaths", Players.GetDeaths(data.target_id));
	HUD.CONTEXT.SetDialogVariableInt("assists", Players.GetAssists(data.target_id));

	HUD.MODEL_ROOT.RemoveAndDeleteChildren();
	$.CreatePanel(`DOTAScenePanel`, HUD.MODEL_ROOT, "VotingToKickVotingHeroModel", {
		unit: `${target_player.player_selected_hero}`,
		particleonly: `false`,
	});

	HUD.CONTEXT.SetHasClass(
		"BHideVotingButtons",
		LOCAL_PLAYER_ID == data.player_id_init || LOCAL_PLAYER_ID == data.target_id,
	);
	HUD.CONTEXT.SetHasClass("BPlayerVoted", data.player_voted != undefined);
}
function ToggleVotingPanel() {
	HUD.CONTEXT.ToggleClass("BHideVoting");
}
function HideVotingHint() {
	$.DispatchEvent(
		"DOTAShowTextTooltip",
		HUD.HIDE_VOTING_ARROW,
		$.Localize(`#${HUD.CONTEXT.BHasClass("BHideVoting") ? "show_voting" : "hide_voting"}`),
	);
}

function VotingToKickHideVoting() {
	HUD.CONTEXT.SetHasClass("ShowVoting", false);
	$("#VotingToKickCountdown").DeleteAsync(0);
}

function VotingToKickVoteYes() {
	GameEvents.SendToServerEnsured("voting_to_kick:vote_yes", {});
	HUD.CONTEXT.AddClass("BPlayerVoted");
}

function VotingToKickVoteNo() {
	// GameEvents.SendToServerEnsured("voting_to_kick:vote_no", {});
	HUD.CONTEXT.AddClass("BPlayerVoted");
}

function VotingToKickHideReason() {
	HUD.CONTEXT.RemoveClass("ShowReason");
}
function VotingToKickShowReason(data) {
	HUD.CONTEXT.AddClass("ShowReason");
	HUD.CONTEXT.SetDialogVariable("target_player_name", Players.GetPlayerName(data.target_id));
}
function VotingToKickInitVoting(reason) {
	GameEvents.SendToServerEnsured("voting_to_kick:reason_picked", { reason: reason });
}
function ReportVoting() {
	HUD.CONTEXT.SetHasClass("BPlayerReported", true);
	GameEvents.SendToServerEnsured("voting_to_kick:report", {});
}

(() => {
	GameEvents.SendToServerEnsured("voting_to_kick:check_state", {});

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());

	frame.SubscribeProtected("voting_to_kick:show_reason", VotingToKickShowReason);
	frame.SubscribeProtected("voting_to_kick:hide_reason", VotingToKickHideReason);

	frame.SubscribeProtected("voting_to_kick:show_voting", VotingToKickShowVoting);
	frame.SubscribeProtected("voting_to_kick:hide_voting", VotingToKickHideVoting);
})();