--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


// Вызывается из team_select.xml по кнопке, поэтому объявлена глобально.
function pick(mode) {
	GameEvents.SendCustomGameEventToServer("bsa_mode_choice", { mode: mode });
}

(function () {
	var RU = {
		waiting: "Подключаем к серверу BSA…",
		queued: "Ждём свободный сервер. Вы {p}-й в очереди",
		ready: "Сервер найден, подключаем…",
		error: "Сервер не отвечает, пробуем ещё…",
		local: "Играем на этом компьютере",
		choice: "Где играть? Автоматически на сервере через {p} с",
		btn_local: "На этом компьютере",
		btn_server: "На сервере BSA"
	};
	var EN = {
		waiting: "Connecting to BSA server…",
		queued: "Waiting for a free server. You are #{p} in line",
		ready: "Server found, connecting…",
		error: "Server is not responding, retrying…",
		local: "Playing on this computer",
		choice: "Where to play? Server in {p}s",
		btn_local: "This computer",
		btn_server: "BSA server"
	};
	var lang = "";
	try { lang = $.Language.GetLanguage(); } catch (e) { lang = ""; }
	var T = (lang === "russian") ? RU : EN;

	function isHost() {
		try { return Players.GetLocalPlayer() === 0; } catch (e) { return false; }
	}

	function render(v) {
		$.Msg("[RoomStatus] render: ", v ? JSON.stringify(v) : "nil");
		var panel = $("#RoomStatus");
		if (!panel) return;
		var text = v && T[v.state];
		var active = !!text && v.state !== "local";
		$.GetContextPanel().SetHasClass("ConnectorActive", active);
		var teams = $("#TeamSelectContainer");
		if (teams) { teams.visible = !active; }
		if (!text) { panel.SetHasClass("Visible", false); return; }
		var n = (v.state === "choice") ? (v.left || 0) : (v.position || 1);
		$("#RoomStatusText").text = text.replace("{p}", String(n));
		panel.SetHasClass("Visible", true);

		var choosing = (v.state === "choice") && isHost();
		var buttons = $("#RoomChoice");
		if (buttons) {
			buttons.SetHasClass("Visible", choosing);
			if (choosing) {
				$("#RoomChoiceLocal").text = T.btn_local;
				$("#RoomChoiceServer").text = T.btn_server;
			}
		}
	}

	CustomNetTables.SubscribeNetTableListener("server", function (t, k, v) { if (k === "connector") render(v); });
	render(CustomNetTables.GetTableValue("server", "connector"));
})();