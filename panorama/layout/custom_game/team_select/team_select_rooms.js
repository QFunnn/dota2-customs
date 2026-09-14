--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


(function () {
	var RU = {
		waiting: "Подключаем к серверу BSA…",
		queued: "Ждём свободный сервер, очередь: {p}",
		ready: "Сервер найден, подключаем…",
		error: "Сервер не отвечает, пробуем ещё…",
		local: "Свободных серверов нет, играем локально"
	};
	var EN = {
		waiting: "Connecting to BSA server…",
		queued: "Waiting for a free server, queue: {p}",
		ready: "Server found, connecting…",
		error: "Server is not responding, retrying…",
		local: "No free servers, playing locally"
	};
	var lang = "";
	try { lang = $.Language.GetLanguage(); } catch (e) { lang = ""; }
	var T = (lang === "russian") ? RU : EN;

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
		$("#RoomStatusText").text = text.replace("{p}", String(v.position || 1));
		panel.SetHasClass("Visible", true);
	}

	CustomNetTables.SubscribeNetTableListener("server", function (t, k, v) { if (k === "connector") render(v); });
	render(CustomNetTables.GetTableValue("server", "connector"));
})();