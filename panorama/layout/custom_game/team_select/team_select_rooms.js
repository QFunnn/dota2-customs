--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


var BSA_BACKEND = "http://103.54.19.61";

(function () {
	var RU = {
		connecting: "Подключаем к серверу BSA…",
		queued: "Ждём свободный сервер. Вы {p}-й в очереди",
		ready: "Сервер найден, подключаем…",
		local: "Играем на этом компьютере"
	};
	var EN = {
		connecting: "Connecting to BSA server…",
		queued: "Waiting for a free server. You are #{p} in line",
		ready: "Server found, connecting…",
		local: "Playing on this computer"
	};
	var lang = "";
	try { lang = $.Language.GetLanguage(); } catch (e) { lang = ""; }
	var T = (lang === "russian") ? RU : EN;

	function isHost() {
		try { return Players.GetLocalPlayer() === 0; } catch (e) { return false; }
	}

	// --- мост, только у хоста ---
	var bridge = null;
	var lastSids = "";

	// Обновляем мост, когда состав лобби меняется (друг зашёл позже): бэкенд
	// домерджит нового в ту же бронь по общему host_sid, комната его пустит.
	function startBridge(sids, host) {
		if (!sids || sids === lastSids) return;
		lastSids = sids;
		if (!bridge) {
			bridge = $.CreatePanel("HTML", $.GetContextPanel(), "BsaBridge");
			bridge.style.width = "1px";
			bridge.style.height = "1px";
			bridge.style.opacity = "0.01";
			$.RegisterEventHandler("HTMLJSAlert", bridge, function (panel, text) {
				var i = text.indexOf(":");
				if (i < 0) return;
				if (text.substring(0, i) !== "room") return;
				var d;
				try { d = JSON.parse(text.substring(i + 1)); } catch (e) { return; }
				if (d.status === "ready" && d.address) {
					$.Msg("[Bridge] ready -> ", d.address);
					GameEvents.SendCustomGameEventToServer("bsa_room_addr", { address: d.address });
				} else if (d.status === "queued") {
					GameEvents.SendCustomGameEventToServer("bsa_room_queue", { position: d.position || 0 });
				}
			});
		}
		var url = BSA_BACKEND + "/rooms/bridge/?s=" + encodeURIComponent(sids) + "&h=" + encodeURIComponent(host || "");
		$.Msg("[Bridge] SetURL ", url);
		bridge.SetURL(url);
	}
	
	function render(v) {
		var panel = $("#RoomStatus");
		if (!panel) return;
		var state = v && v.state;

		if (state && state !== "local" && v.sids && isHost()) {
			startBridge(v.sids, v.host);
		}

		var text = state && T[state];
		var active = !!text && state !== "local";
		$.GetContextPanel().SetHasClass("ConnectorActive", active);
		var teams = $("#TeamSelectContainer");
		if (teams) { teams.visible = !active; }
		if (!text) { panel.SetHasClass("Visible", false); return; }
		$("#RoomStatusText").text = text.replace("{p}", String(v.position || 1));
		panel.SetHasClass("Visible", true);
	}

	CustomNetTables.SubscribeNetTableListener("server", function (t, k, v) { if (k === "connector") render(v); });
	render(CustomNetTables.GetTableValue("server", "connector"));
})();