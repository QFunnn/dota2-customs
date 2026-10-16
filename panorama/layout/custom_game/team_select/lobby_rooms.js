--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


// Карта lobby: список комнат со слотами (бэкенд — back/rooms/lobby.py).
// Игрок садится в комнату, друзья туда же, любой из сидящих жмёт «Играть» —
// бэкенд бронирует комнату на всех, каждый получает адрес и уезжает
// (событие bsa_lobby_go -> rooms/lobby.lua -> bsa_connect -> connect).
(function () {
	var IS_LOBBY = false;
	try { IS_LOBBY = Game.GetMapInfo().map_display_name === "lobby"; } catch (e) {}
	var root = $("#LobbyRooms");
	if (!root) return;
	root.SetHasClass("LobbyHidden", !IS_LOBBY);
	if (!IS_LOBBY) return;

	var BACKEND = "https://boss-survival-adventure.com";
	var PER_ROW = 6;

	// Тексты в resource/addon_<язык>.txt (bsa_lobby_*): язык выбирает сам движок.
	var T = {};
	["title", "loading", "hint", "empty", "server", "free_slot", "join", "play", "leave",
		"full", "gone", "neterror", "go", "wait", "map_bsa", "map_ability_mode"].forEach(function (k) {
		T[k] = $.Localize("#bsa_lobby_" + k);
	});

	var info = Game.GetLocalPlayerInfo() || {};
	var sid = String(info.player_steamid || "");
	var name = String(info.player_name || "");
	var bridge = null;
	var pending = false;
	var leaving = false;
	var last = null;

	var teams = $("#TeamSelectContainer");
	if (teams) teams.visible = false;
	$("#LobbyTitle").text = T.title;

	function hint(text) { $("#LobbyHint").text = text || T.hint; }

	// Действие уходит новым адресом страницы: она перезагрузится, выполнит его
	// и дальше будет просто опрашивать.
	function send(action, room, map) {
		if (!bridge || leaving) return;
		pending = action !== "poll";
		bridge.SetURL(BACKEND + "/rooms/lobby/?s=" + encodeURIComponent(sid)
			+ "&n=" + encodeURIComponent(name) + "&a=" + action
			+ "&r=" + encodeURIComponent(room || "") + "&m=" + encodeURIComponent(map || "")
			+ "&t=" + Date.now());
		if (last) render(last);
	}

	function onData(d) {
		if (d.status === "go" && d.address) {
			if (leaving) return;
			leaving = true;
			$.Msg("[Lobby] go -> ", d.address);
			$("#LobbyList").RemoveAndDeleteChildren();
			hint(T.go);
			GameEvents.SendCustomGameEventToServer("bsa_lobby_go", { address: d.address });
			return;
		}
		if (d.status === "neterror") { hint(T.neterror); return; }
		if (d.status === "wait") {
			// «Играть» нажали, комната переключает карту: список больше не нужен.
			pending = true;
			last = null;
			$("#LobbyList").RemoveAndDeleteChildren();
			hint(T.wait);
			return;
		}
		if (d.status !== "ok") return;
		hint(d.error ? (T[d.error] || T.hint) : (d.rooms.length ? T.hint : T.empty));
		// Опрос раз в 2 с: без изменений не пересобираем, иначе клик может уйти в
		// удалённую кнопку.
		var same = !pending && last && JSON.stringify(last) === JSON.stringify(d);
		pending = false;
		last = d;
		if (!same) render(d);
	}

	function render(d) {
		var list = $("#LobbyList");
		list.RemoveAndDeleteChildren();
		var rooms = d.rooms || [];
		var col = null;
		for (var i = 0; i < rooms.length; i++) {
			if (i % PER_ROW === 0) {
				col = $.CreatePanel("Panel", list, "");
				col.AddClass("LobbyRow");
			}
			renderRoom(col, rooms[i], d.me);
		}
	}

	function renderRoom(parent, r, me) {
		var mine = Number(me) === Number(r.id);
		var slots = r.slots || [];
		var full = slots.length >= r.max;
		var card = $.CreatePanel("Panel", parent, "");
		card.AddClass("LobbyRoom");
		card.SetHasClass("LobbyRoomMine", mine);
		card.SetHasClass("LobbyRoomFull", full && !mine);

		var top = $.CreatePanel("Panel", card, "");
		top.AddClass("LobbyRoomTop");
		var title = $.CreatePanel("Label", top, "");
		title.AddClass("LobbyRoomName");
		title.text = T.server + " " + r.label;
		var count = $.CreatePanel("Label", top, "");
		count.AddClass("LobbyRoomCount");
		count.text = slots.length + " / " + r.max;

		// Карта: в своей комнате переключатель (меняет всем в комнате), в чужих — подпись.
		var maps = $.CreatePanel("Panel", card, "");
		maps.AddClass("LobbyMaps");
		var list = mine ? (last && last.maps) || [r.map] : [r.map];
		for (var m = 0; m < list.length; m++) {
			mapButton(maps, list[m], r, mine);
		}

		var box = $.CreatePanel("Panel", card, "");
		box.AddClass("LobbySlots");
		for (var i = 0; i < r.max; i++) {
			var p = $.CreatePanel("Label", box, "");
			p.AddClass("LobbySlot");
			if (slots[i]) {
				p.text = slots[i].name || slots[i].sid;
				p.SetHasClass("LobbySlotMe", slots[i].sid === sid);
			} else {
				p.text = T.free_slot;
				p.AddClass("LobbySlotFree");
			}
		}

		var buttons = $.CreatePanel("Panel", card, "");
		buttons.AddClass("LobbyButtons");
		if (mine) {
			button(buttons, T.play, "LobbyPlay", function () { send("play", r.id); });
			button(buttons, T.leave, "LobbyLeave", function () { send("leave"); });
		} else if (!full) {
			button(buttons, T.join, "LobbyJoin", function () { send("join", r.id); });
		} else {
			var l = $.CreatePanel("Label", buttons, "");
			l.AddClass("LobbyFullText");
			l.text = T.full;
		}
	}

	function mapButton(parent, map, r, mine) {
		var b = $.CreatePanel(mine ? "Button" : "Panel", parent, "");
		b.AddClass("LobbyMap");
		b.SetHasClass("LobbyMapOn", map === r.map);
		var l = $.CreatePanel("Label", b, "");
		l.AddClass("LobbyMapText");
		l.text = T["map_" + map] || map;
		if (mine && map !== r.map) {
			b.enabled = !pending;
			b.SetPanelEvent("onactivate", function () { if (!pending) send("map", r.id, map); });
		}
	}

	function button(parent, text, cls, cb) {
		var b = $.CreatePanel("Button", parent, "");
		b.AddClass("LobbyButton");
		b.AddClass(cls);
		b.enabled = !pending;
		var l = $.CreatePanel("Label", b, "");
		l.AddClass("LobbyButtonText");
		l.text = text;
		b.SetPanelEvent("onactivate", function () { if (!pending) cb(); });
	}

	hint(T.loading);
	bridge = $.CreatePanel("HTML", $.GetContextPanel(), "LobbyBridge");
	bridge.style.width = "1px";
	bridge.style.height = "1px";
	bridge.style.opacity = "0.01";
	$.RegisterEventHandler("HTMLJSAlert", bridge, function (panel, text) {
		var i = text.indexOf(":");
		if (i < 0 || text.substring(0, i) !== "lobby") return;
		var d;
		try { d = JSON.parse(text.substring(i + 1)); } catch (e) { return; }
		onData(d);
	});
	send("poll");
})();