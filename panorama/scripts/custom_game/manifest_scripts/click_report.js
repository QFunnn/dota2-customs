--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


"use strict";

(function () {
	const customUIConfig = GameUI.CustomUIConfig();
	const TUTORIAL_FIRST_PLAY_KEY = "tutorial_first_play";
	customUIConfig._ClickReportQueue ??= [];
	customUIConfig._PlayerTypeReportQueue ??= [];
	customUIConfig._ClickReportInterval ??= 60;
	customUIConfig._ClickReportScheduleToken = (customUIConfig._ClickReportScheduleToken ?? 0) + 1;
	const scheduleToken = customUIConfig._ClickReportScheduleToken;

	function enqueuePendingPlayerTypeReports() {
		const isNewPlayerAtLogin = customUIConfig._ClickReportIsNewPlayerAtLogin;
		if (typeof isNewPlayerAtLogin != "boolean") {
			return;
		}

		const queue = customUIConfig._PlayerTypeReportQueue;
		if (!Array.isArray(queue) || queue.length == 0) {
			return;
		}

		const clickType = isNewPlayerAtLogin ? "newbie" : "existing_player";
		for (const message of queue) {
			customUIConfig._ClickReportQueue.push({
				click_type: clickType,
				detail: message.detail
			});
		}
		customUIConfig._PlayerTypeReportQueue = [];
	}

	function getPlayerKeyValuesTableKey(playerID) {
		return `player_key_values${playerID}`;
	}

	function resolveIsNewPlayerAtLogin(netTableValue) {
		if (typeof customUIConfig._ClickReportIsNewPlayerAtLogin == "boolean") {
			enqueuePendingPlayerTypeReports();
			return;
		}
		if (netTableValue?.data == undefined) {
			return;
		}
		const playerKeyValues = JSON.parse(netTableValue.data);
		customUIConfig._ClickReportIsNewPlayerAtLogin = playerKeyValues[TUTORIAL_FIRST_PLAY_KEY]?.value == undefined;
		enqueuePendingPlayerTypeReports();
	}

	function tryResolveIsNewPlayerAtLogin() {
		const playerID = Players.GetLocalPlayer();
		if (playerID < 0) {
			return;
		}
		const tableKey = getPlayerKeyValuesTableKey(playerID);
		const netTableValue = CustomNetTables.GetTableValue("service", tableKey);
		resolveIsNewPlayerAtLogin(netTableValue);
	}

	tryResolveIsNewPlayerAtLogin();
	if (customUIConfig._ClickReportPlayerKeyValuesListener != undefined) {
		CustomNetTables.UnsubscribeNetTableListener(customUIConfig._ClickReportPlayerKeyValuesListener);
		customUIConfig._ClickReportPlayerKeyValuesListener = undefined;
	}
	if (customUIConfig._ClickReportGameStateListener != undefined) {
		CustomNetTables.UnsubscribeNetTableListener(customUIConfig._ClickReportGameStateListener);
	}
	customUIConfig._ClickReportGameStateListener = CustomNetTables.SubscribeNetTableListener("common", (_, key) => {
		if (key == "game_state") {
			tryResolveIsNewPlayerAtLogin();
		}
	});

	function flushClickReport() {
		const queue = customUIConfig._ClickReportQueue;
		if (!Array.isArray(queue) || queue.length == 0) {
			return;
		}

		const clickMessages = queue.slice(0, queue.length);
		customUIConfig._ClickReportQueue = [];
		GameEvents.SendCustomEventToServer("call_action", {
			actionName: "/v1/click/report",
			params: JSON.stringify({ click_messages: clickMessages })
		});
	}

	function scheduleFlush() {
		$.Schedule(customUIConfig._ClickReportInterval, () => {
			if (customUIConfig._ClickReportScheduleToken != scheduleToken) {
				return;
			}
			flushClickReport();
			scheduleFlush();
		});
	}

	customUIConfig.ReportClick = (clickType, detail) => {
		customUIConfig._ClickReportQueue.push({
			click_type: String(clickType ?? ""),
			detail: String(detail ?? "")
		});
	};
	customUIConfig.PlayerTypeReport = (detail) => {
		const message = {
			detail: String(detail ?? "")
		};
		customUIConfig._PlayerTypeReportQueue.push(message);
		tryResolveIsNewPlayerAtLogin();
		enqueuePendingPlayerTypeReports();
	};
	customUIConfig.FlushClickReport = flushClickReport;

	scheduleFlush();
})();