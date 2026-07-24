--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const KILLSTREAK_ROOT = FindDotaHudElement("KillStreak");
const NOTIFICATIONS_POOL = [];

function InitNotificationsPool() {
	for (let index = 0; index < 5; index++) {
		const notificationLabel = $.CreatePanel("Label", KILLSTREAK_ROOT, "Notification" + index);
		notificationLabel.html = true;
		notificationLabel.visible = false;
		KILLSTREAK_ROOT.MoveChildBefore(notificationLabel, KILLSTREAK_ROOT.GetChild(0));
		NOTIFICATIONS_POOL.push(notificationLabel);
	}
}

function ShowNotification(text, time, scale) {
	for (let index = 0; index < NOTIFICATIONS_POOL.length; index++) {
		const notificationLabel = NOTIFICATIONS_POOL[index];
		if (notificationLabel.visible == false) {
			notificationLabel.style.preTransformScale2d = scale || 1;
			notificationLabel.text = text;
			notificationLabel.RemoveClass("Expired");
			notificationLabel.RemoveClass("KillStreak");
			notificationLabel.AddClass("KillStreak");
			notificationLabel.visible = true;
			$.Schedule(time - 0.49, () => {
				notificationLabel.AddClass("Expired");
			});
			$.Schedule(time, () => {
				notificationLabel.visible = false;
			});
			break;
		}
	}
}

function DisplayKillAlert(event) {
	const player_info = Game.GetPlayerInfo(event.player_id);
	if (!player_info) return;

	const team_info = Game.GetTeamDetails(player_info.player_team_id);

	ShowNotification(
		`<img src="${GetPortraitIcon(
			event.player_id,
			player_info.player_selected_hero,
		)}"> <font color='${GetHEXPlayerColor(event.player_id)}'>${$.Localize(team_info.team_name)}</font> ${$.Localize(
			"leader_was_killed_by_bonus_0",
		)} <font color='#ffcc33'> ${event.gold_reward} </font> ${$.Localize("leader_was_killed_by_bonus_1")}`,
		5,
		0.75,
	);
}

function OnItemWillSpawn(event) {
	ShowNotification(
		`<font color='#ea00ff'>${$.Localize("#DOTA_Tooltip_ability_item_epic_orb")}</font> ${$.Localize(
			"#item_will_spawn_message",
		)}`,
		5,
	);
}

function OnItemHasSpawned(event) {
	ShowNotification(
		`<font color='#ea00ff'>${$.Localize("#DOTA_Tooltip_ability_item_epic_orb")}</font> ${$.Localize(
			"#item_has_spawned_message",
		)}`,
		5,
	);
}

function DisplayLeaderOverthrowAlert(event) {
	const overthrow_team = event.overthrow_team_id;
	const team_details = Game.GetTeamDetails(overthrow_team);
	ShowNotification(`${$.Localize(team_details.team_name)} ${$.Localize("#leader_was_overthrown_message")}`);
}

(function () {
	InitNotificationsPool();

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());

	frame.SubscribeProtected("Alerts:leader_killed", DisplayKillAlert);
	frame.SubscribeProtected("item_will_spawn", OnItemWillSpawn);
	frame.SubscribeProtected("item_has_spawned", OnItemHasSpawned);
	frame.SubscribeProtected("Alerts:leader_overthrown", DisplayLeaderOverthrowAlert);

	KILLSTREAK_ROOT.style.width = "900px";
	KILLSTREAK_ROOT.style.marginTop = "100px";
	const kill_streak_container = FindDotaHudElement("StreakContainer");
	kill_streak_container.style.preTransformScale2d = "0.75";
})();