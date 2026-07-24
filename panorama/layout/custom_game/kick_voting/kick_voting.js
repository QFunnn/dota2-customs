--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function InitReasons() {
	HUD.REASONS_CONTAINER.RemoveAndDeleteChildren();

	const sub_lines = GenerateSublines(HUD.REASONS_CONTAINER, REASONS_PER_LINE, 7, 7);
	for (const reason of REASONS) {
		const panel = sub_lines.create("Button");

		panel.BLoadLayoutSnippet("KV_Reason");

		panel.FindChildTraverse("KV_R_Image").SetImage(`file://{images}/custom_game/kick_voting/${reason}.png`);
		panel.SetDialogVariableLocString("reason_name", `kick_voting_reason_${reason}`);
		panel.SwitchClass("reason_name", reason);

		panel.SetPanelEvent("onactivate", () => {
			GameEvents.SendToServerEnsured("voting_to_kick:reason_picked", { reason: reason });
		});
	}
}

function SetPlayerNameAndColor(panel, player_id) {
	panel.SetDialogVariable("player_name", Players.GetPlayerName(player_id));
	panel.SetDialogVariable("player_color", GetHEXPlayerColor(player_id));
}

function ShowKickReasons(event) {
	HUD.CONTEXT.SwitchClass("voting_state", "BShowReasons");
	SetPlayerNameAndColor(HUD.KV_REASONS, event.target_id);
}

function UpdateTimer(init_time) {
	const tick = () => {
		if (!HUD.CONTEXT.BHasClass("BShowProcess")) return;
		const game_time = Game.GetGameTime();
		const left_time = Math.clamp(KV_DURATION - (game_time - init_time), 0, KV_DURATION);
		const left_time_pct = left_time / KV_DURATION;

		HUD.CONTEXT.SetDialogVariable("kv_vp_time", Math.floor(left_time));

		HUD.KV_TIMER.style.opacityBrush = `gradient( linear, 0% 0%, 100% 0%, from(white), color-stop(${left_time_pct}, white), color-stop(${left_time_pct}, transparent), to(transparent));`;
		$.Schedule(0, tick);
	};
	tick();
}

function ShowKickVoting(event) {
	HUD.CONTEXT.RemoveClass("BHideVotingProcess");
	HUD.CONTEXT.SwitchClass("voting_state", "BShowProcess");

	HUD.KV_VOTING_PROCESS.SetDialogVariableLocString("kv_header_reason", `kick_voting_reason_${event.reason}`);
	HUD.CONTEXT.SetDialogVariable("kv_vp_kills", Players.GetKills(event.target_id));
	HUD.CONTEXT.SetDialogVariable("kv_vp_deaths", Players.GetDeaths(event.target_id));
	HUD.CONTEXT.SetDialogVariable("kv_vp_assists", Players.GetAssists(event.target_id));

	HUD.KV_VOTING_PROCESS_INITIATOR_ICON.SetImage(
		GetPortraitIcon(event.player_id_init, Players.GetPlayerSelectedHero(event.player_id_init)),
	);

	SetPlayerNameAndColor(HUD.KV_VOTING_PROCESS, event.target_id);
	SetPlayerNameAndColor(HUD.REPORT_BUTTON, event.player_id_init);
	SetPlayerNameAndColor(HUD.KV_VOTING_PROCESS_INITIATOR_ROOT, event.player_id_init);

	HUD.MODEL_CONTAINER.RemoveAndDeleteChildren();

	const hero_name = Players.GetPlayerSelectedHero(event.target_id);
	$.CreatePanel("DOTAScenePanel", HUD.MODEL_CONTAINER, "", {
		unit: hero_name,
		particleonly: `false`,
		["activity-modifier"]: hero_name == "npc_dota_hero_warlock" ? "none" : "PostGameIdle",
	});

	// HUD.VOTES.RemoveAndDeleteChildren();
	//
	// for (let i = 0; i < 12; i++) $.CreatePanel("Panel", HUD.VOTES, "");
	//
	// const votes = HUD.VOTES.Children();
	//
	// votes.at(-1).AddClass("BVoteNo");
	// votes.at(0).AddClass("BVoteYes");

	HUD.CONTEXT.SetHasClass(
		"BHideVotingButtons",
		LOCAL_PLAYER_ID == event.player_id_init || LOCAL_PLAYER_ID == event.target_id,
	);
	HUD.CONTEXT.SetHasClass("BLocalPlayerVoted", event.player_voted != undefined);

	UpdateTimer(event.init_time);
}
function CloseVotingByType(type) {
	if (HUD.CONTEXT.BHasClass(type)) HUD.CONTEXT.SwitchClass("voting_state", "none");
}
function CloseNotification(delay) {
	if (delay > 0) $.Schedule(delay, CloseVotingByType.bind(undefined, "BShowNotification"));
	else CloseVotingByType("BShowNotification");
}
function PlayerKicked(event) {
	HUD.CONTEXT.SwitchClass("voting_state", "BShowNotification");
	const hero_name = Players.GetPlayerSelectedHero(event.target_id);
	HUD.KV_NOTIFICATION.SetDialogVariableLocString("kv_header_reason", `kick_voting_reason_${event.reason}`);
	HUD.KV_NOTIFICATION_ICON.SetImage(GetPortraitIcon(event.target_id, hero_name));

	SetPlayerNameAndColor(HUD.KV_NOTIFICATION, event.target_id);
	CloseNotification(3);
}

function CloseReasons() {
	CloseVotingByType("BShowReasons");
}
function CloseKickVoting() {
	CloseVotingByType("BShowProcess");
}
function ToggleVotingProcessView() {
	HUD.CONTEXT.ToggleClass("BHideVotingProcess");
}
function HideVotingProcess() {
	HUD.CONTEXT.AddClass("BHideVotingProcess");
}

function KV_VoteYes() {
	HUD.CONTEXT.SetHasClass("BLocalPlayerVoted", true);
	GameEvents.SendToServerEnsured("voting_to_kick:vote_yes", {});
	HideVotingProcess();
}

function KV_VoteNo() {
	HUD.CONTEXT.SetHasClass("BLocalPlayerVoted", true);
	GameEvents.SendToServerEnsured("voting_to_kick:vote_no", {});
	HideVotingProcess();
}
function KV_Report() {
	GameEvents.SendToServerEnsured("voting_to_kick:report", {});
	HideVotingProcess();
}

(() => {
	HUD.CONTEXT.SwitchClass("voting_state", "none");
	InitReasons();

	GameEvents.SendToServerEnsured("voting_to_kick:check_state", {});

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());

	frame.SubscribeProtected("voting_to_kick:show_reason", ShowKickReasons);
	frame.SubscribeProtected("voting_to_kick:hide_reason", CloseReasons);

	frame.SubscribeProtected("voting_to_kick:show_voting", ShowKickVoting);
	frame.SubscribeProtected("voting_to_kick:hide_voting", CloseKickVoting);

	frame.SubscribeProtected("voting_to_kick:player_kicked", PlayerKicked);
})();