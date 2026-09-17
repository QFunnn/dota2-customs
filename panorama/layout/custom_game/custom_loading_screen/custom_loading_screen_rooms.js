--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


function RoomStart() {
	GameEvents.SendCustomGameEventToServer("room_start", {});
}

(function () {
	var RU = {
		title: "Ваша группа",
		gathering: "Ждём игроков: {p} из {e}",
		queued: "Все комнаты заняты. Вы {n}-й в очереди",
		difficulty: "Выберите сложность",
		starting: "Запускаем…",
		start: "НАЧАТЬ ИГРУ",
		start_now: "НАЧАТЬ БЕЗ ОЖИДАНИЯ"
	};
	var EN = {
		title: "Your party",
		gathering: "Waiting for players: {p} of {e}",
		queued: "All rooms are busy. You are #{n} in line",
		difficulty: "Choose difficulty",
		starting: "Starting…",
		start: "START GAME",
		start_now: "START WITHOUT WAITING"
	};
	var lang = "";
	try { lang = $.Language.GetLanguage(); } catch (e) { lang = ""; }
	var T = (lang === "russian") ? RU : EN;

	function isHost() {
		return Players.GetLocalPlayer() === 0;
	}

	function render(v) {
		var panel = $("#RoomPanel");
		if (!panel) return;
		if (!v || !v.state) { panel.SetHasClass("Visible", false); return; }
		panel.SetHasClass("Visible", true);
		$("#RoomPanelTitle").text = T.title;

		var status = T[v.state] || "";
		$("#RoomPanelStatus").text = status
			.replace("{p}", String(v.present || 0))
			.replace("{e}", String(v.expected || 0))
			.replace("{n}", String(v.position || 1));

		var list = $("#RoomPanelPlayers");
		list.RemoveAndDeleteChildren();
		var players = v.players || {};
		var keys = Object.keys(players).sort(function (a, b) { return Number(a) - Number(b); });
		for (var i = 0; i < keys.length; i++) {
			var p = players[keys[i]];
			var row = $.CreatePanel("Panel", list, "");
			row.AddClass("RoomPlayerRow");
			var name = $.CreatePanel("Label", row, "");
			name.AddClass("RoomPlayerName");
			var nick = "";
			try { nick = Players.GetPlayerName(Number(keys[i])); } catch (e) { nick = ""; }
			name.text = nick || p.name || p.sid || "?";
		}

		var btn = $("#RoomPanelStart");
		var canStart = isHost() && (v.state === "gathering" || v.state === "difficulty");
		btn.SetHasClass("Visible", canStart);
		btn.SetHasClass("Disabled", !canStart);
		$("#RoomPanelStartLabel").text = (v.state === "gathering") ? T.start_now : T.start;
	}

	CustomNetTables.SubscribeNetTableListener("server", function (t, k, v) { if (k === "room") render(v); });
	function tick() {
		var v = CustomNetTables.GetTableValue("server", "room");
		render(v);
		if (!v || v.state !== "starting") { $.Schedule(1, tick); }
	}
	tick();
})();