--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var WODA_CONNECT_STATE_KEYS = {
	waiting: "#woda_connect_waiting",
	requesting: "#woda_connect_requesting",
	queued: "#woda_connect_queued",
	ready: "#woda_connect_ready",
	relaunch: "#woda_connect_relaunch",
	error: "#woda_connect_error",
	choose: "#woda_connect_choose",
	session: "#woda_connect_session",
	search_choose: "#woda_connect_search_choose",
	searching: "#woda_connect_searching",
	search_found: "#woda_connect_search_found"
};
var g_WodaStatusTime = null;
var g_WodaRegion = { serial: null, selected: null, deadline: 0, mode: null, newConfirm: false };
var g_WodaSearch = { selected: null, leader: false, status: null, startedAt: 0 };

function WodaLocalizeOr(key, fallback)
{
	var text = $.Localize(key);
	if (!text || text === key || text === key.substring(1))
	{
		return fallback;
	}
	return text;
}

function WodaRegionName(id)
{
	if (!id)
	{
		return "";
	}
	return WodaLocalizeOr("#woda_region_" + id, String(id).toUpperCase());
}

function WodaSendRegionChoice(action, region, mode)
{
	GameEvents.SendCustomGameEventToServer("event_woda_region_choice", { action: action, region: region || "", mode: mode || "" });
}

function WodaModeName(mode)
{
	if (!mode)
	{
		return "";
	}
	return WodaLocalizeOr("#woda_mode_" + mode, String(mode));
}

function WodaSelectMode(mode)
{
	g_WodaSearch.selected = mode;
	var list = $("#WodaModeList");
	if (!list)
	{
		return;
	}
	var children = list.Children();
	for (var i = 0; i < children.length; i++)
	{
		children[i].SetHasClass("Selected", children[i].id === "WodaModeCard_" + mode);
	}
}

function WodaStartSearch(mode)
{
	if (!g_WodaSearch.leader || !mode)
	{
		return;
	}
	WodaSendRegionChoice("search", "", mode);
}

function WodaBuildModeCard(parent, mode, info)
{
	var card = $.CreatePanel("Panel", parent, "WodaModeCard_" + mode);
	card.AddClass("WodaRegionCard");
	card.AddClass("WodaModeCard");

	var name = $.CreatePanel("Label", card, "");
	name.AddClass("WodaRegionName");
	name.AddClass("WodaModeName");
	name.text = WodaModeName(mode);

	var count = $.CreatePanel("Label", card, "");
	count.AddClass("WodaRegionFree");
	if (info && Number(info.known) > 0)
	{
		count.SetDialogVariableInt("count", Number(info.searching) || 0);
		count.SetDialogVariableInt("needed", Number(info.needed) || 0);
		count.text = $.Localize("#woda_search_in_queue", count);
	}
	else
	{
		count.text = "";
	}

	card.SetPanelEvent("onactivate", function() { if (g_WodaSearch.leader) { WodaSelectMode(mode); } });
	card.SetPanelEvent("ondblclick", function() { if (g_WodaSearch.leader) { WodaSelectMode(mode); WodaStartSearch(mode); } });
	return card;
}

function WodaRenderSearchChoice(status)
{
	var picker = $("#WodaSearchPicker");
	var list = $("#WodaModeList");
	if (!picker || !list)
	{
		return;
	}
	g_WodaSearch.leader = Number(status.leader) > 0;
	list.RemoveAndDeleteChildren();
	var modes = String(status.modes || "").split(",").filter(function(x) { return x !== ""; });
	var counts = status.counts || {};
	if (!g_WodaSearch.selected || modes.indexOf(g_WodaSearch.selected) < 0)
	{
		g_WodaSearch.selected = modes[0];
	}
	for (var i = 0; i < modes.length; i++)
	{
		WodaBuildModeCard(list, modes[i], counts[modes[i]]);
	}
	WodaSelectMode(g_WodaSearch.selected);
	$("#WodaSearchStart").visible = g_WodaSearch.leader;
	$("#WodaSearchLeaderNote").visible = !g_WodaSearch.leader;
	picker.SetHasClass("Visible", true);
}

function WodaFormatTime(seconds)
{
	var total = Math.max(0, Math.floor(seconds));
	var minutes = Math.floor(total / 60);
	var rest = total % 60;
	return minutes + ":" + (rest < 10 ? "0" : "") + rest;
}

function WodaUpdateSearchText()
{
	var status = g_WodaSearch.status;
	var label = $("#WodaSearchText");
	if (!status || !label)
	{
		return;
	}
	var lines = [WodaModeName(status.search_mode)];
	if (status.state === "search_found")
	{
		lines.push($.Localize("#woda_search_found"));
	}
	else
	{
		if (Number(status.needed) > 0)
		{
			label.SetDialogVariableInt("count", Number(status.searching) || 0);
			label.SetDialogVariableInt("needed", Number(status.needed) || 0);
			lines.push($.Localize("#woda_search_progress", label));
		}
		label.SetDialogVariable("time", WodaFormatTime((Date.now() - g_WodaSearch.startedAt) / 1000));
		lines.push($.Localize("#woda_search_time", label));
	}
	label.text = lines.join("\n");
}

function WodaRenderSearching(status)
{
	var box = $("#WodaSearchBox");
	if (!box)
	{
		return;
	}
	g_WodaSearch.status = status;
	g_WodaSearch.startedAt = Date.now() - (Number(status.elapsed) || 0) * 1000;
	$("#WodaSearchCancel").visible = Number(status.can_cancel) > 0;
	WodaUpdateSearchText();
	box.SetHasClass("Visible", true);
}

function WodaHideSearch()
{
	var picker = $("#WodaSearchPicker");
	if (picker)
	{
		picker.SetHasClass("Visible", false);
	}
	var box = $("#WodaSearchBox");
	if (box)
	{
		box.SetHasClass("Visible", false);
	}
	$("#WodaSearchStart").visible = false;
	$("#WodaSearchLeaderNote").visible = false;
	g_WodaSearch.status = null;
}

function WodaSelectRegion(id)
{
	g_WodaRegion.selected = id;
	var list = $("#WodaRegionList");
	if (!list)
	{
		return;
	}
	var children = list.Children();
	for (var i = 0; i < children.length; i++)
	{
		children[i].SetHasClass("Selected", children[i].id === "WodaRegionCard_" + id);
	}
}

function WodaBuildRegionCard(parent, id, info, recommended)
{
	var card = $.CreatePanel("Panel", parent, "WodaRegionCard_" + id);
	card.AddClass("WodaRegionCard");

	var chip = $.CreatePanel("Label", card, "");
	chip.AddClass("WodaRegionChip");
	chip.SetHasClass("Hidden", recommended !== id);
	chip.text = $.Localize("#woda_region_recommended");

	var name = $.CreatePanel("Label", card, "");
	name.AddClass("WodaRegionName");
	name.text = WodaRegionName(id);

	var ping = Number(info.ping) || 0;
	if ((info.source || "none") === "none")
	{
		ping = 0;
	}
	var pingLabel = $.CreatePanel("Label", card, "");
	pingLabel.AddClass("WodaRegionPing");
	if (ping > 0)
	{
		pingLabel.SetDialogVariableInt("ping", ping);
		pingLabel.text = $.Localize("#woda_region_ping", pingLabel);
		pingLabel.SetHasClass("Good", ping <= 90);
		pingLabel.SetHasClass("Bad", ping > 150);
	}
	else
	{
		pingLabel.text = $.Localize("#woda_region_ping_none");
	}

	var free = $.CreatePanel("Label", card, "");
	free.AddClass("WodaRegionFree");
	var freeCount = Number(info.free) || 0;
	if (freeCount > 0)
	{
		free.SetDialogVariableInt("free", freeCount);
		free.text = $.Localize("#woda_region_free", free);
	}
	else
	{
		free.AddClass("Full");
		free.text = $.Localize("#woda_region_full");
	}

	card.SetPanelEvent("onactivate", function() { WodaSelectRegion(id); });
	card.SetPanelEvent("ondblclick", function() { WodaSelectRegion(id); WodaSendRegionChoice("connect", id); });
	return card;
}

function WodaRenderPicker(status)
{
	var picker = $("#WodaRegionPicker");
	var list = $("#WodaRegionList");
	if (!picker || !list)
	{
		return;
	}
	list.RemoveAndDeleteChildren();
	var order = String(status.order || "").split(",").filter(function(x) { return x !== ""; });
	var regions = status.regions || {};
	if (!g_WodaRegion.selected || order.indexOf(g_WodaRegion.selected) < 0)
	{
		g_WodaRegion.selected = (status.recommended && order.indexOf(status.recommended) >= 0) ? status.recommended : order[0];
	}
	for (var i = 0; i < order.length; i++)
	{
		WodaBuildRegionCard(list, order[i], regions[order[i]] || {}, status.recommended);
	}
	WodaSelectRegion(g_WodaRegion.selected);
	picker.SetHasClass("ModeChoose", true);
	picker.SetHasClass("ModeSession", false);
	picker.SetHasClass("Visible", true);
}

function WodaRenderSession(status)
{
	var picker = $("#WodaRegionPicker");
	if (!picker)
	{
		return;
	}
	var text = $("#WodaSessionText");
	if (text)
	{
		text.text = $.Localize("#woda_session_title") + (status.search_mode ? "\n" + WodaModeName(status.search_mode) : "") + (status.region ? "\n" + $.Localize("#woda_session_server") + " " + WodaRegionName(status.region) : "");
	}
	g_WodaRegion.newConfirm = false;
	var newLabel = $("#WodaSessionNewLabel");
	if (newLabel)
	{
		newLabel.text = $.Localize("#woda_session_new");
	}
	picker.SetHasClass("ModeChoose", false);
	picker.SetHasClass("ModeSession", true);
	picker.SetHasClass("Visible", true);
}

function WodaHidePicker()
{
	var picker = $("#WodaRegionPicker");
	if (picker)
	{
		picker.SetHasClass("Visible", false);
	}
	g_WodaRegion.mode = null;
	g_WodaRegion.deadline = 0;
	g_WodaRegion.newConfirm = false;
}

function WodaUpdateCountdown()
{
	var label = $("#WodaRegionCountdown");
	if (label)
	{
		if (g_WodaRegion.mode && g_WodaRegion.deadline > 0)
		{
			var left = Math.max(0, Math.ceil((g_WodaRegion.deadline - Date.now()) / 1000));
			label.SetDialogVariableInt("seconds", left);
			label.text = $.Localize(g_WodaRegion.mode === "session" ? "#woda_session_countdown" : "#woda_region_countdown", label);
			label.visible = true;
		}
		else
		{
			label.visible = false;
		}
	}
	WodaUpdateSearchText();
	$.Schedule(0.5, WodaUpdateCountdown);
}

function WodaOnSessionNew()
{
	if (!g_WodaRegion.newConfirm)
	{
		g_WodaRegion.newConfirm = true;
		var newLabel = $("#WodaSessionNewLabel");
		if (newLabel)
		{
			newLabel.text = $.Localize("#woda_session_new_confirm");
		}
		return;
	}
	WodaSendRegionChoice("new", "");
}

function WodaBindButtons()
{
	$("#WodaRegionConnect").SetPanelEvent("onactivate", function() { WodaSendRegionChoice("connect", g_WodaRegion.selected); });
	$("#WodaSessionReconnect").SetPanelEvent("onactivate", function() { WodaSendRegionChoice("reconnect", ""); });
	$("#WodaSessionNew").SetPanelEvent("onactivate", WodaOnSessionNew);
	$("#WodaChangeServer").SetPanelEvent("onactivate", function() { WodaSendRegionChoice("change", ""); });
	$("#WodaSearchStart").SetPanelEvent("onactivate", function() { WodaStartSearch(g_WodaSearch.selected); });
	$("#WodaSearchCancel").SetPanelEvent("onactivate", function() { WodaSendRegionChoice("cancel", ""); });
}

function WodaUpdateStatusText(state, status)
{
	var label = $("#WodaConnectStatus");
	if (!label)
	{
		return;
	}
	label.SetDialogVariableInt("position", Number(status.position) || 0);
	var key = WODA_CONNECT_STATE_KEYS[state] || WODA_CONNECT_STATE_KEYS.waiting;
	var text = $.Localize(key, label);
	if (state === "session" && (!text || text === key || text === key.substring(1)))
	{
		text = $.Localize("#woda_session_title");
	}
	if (state === "error" && status.reason)
	{
		text += " (" + status.reason + ")";
	}
	if (status.party_region)
	{
		text = $.Localize("#woda_region_party") + " " + WodaRegionName(status.party_region) + "\n" + text;
	}
	else if (status.region && (state === "requesting" || state === "queued" || state === "ready"))
	{
		text += "\n" + WodaRegionName(status.region);
	}
	label.text = text;
	var note = $("#WodaConnectNote");
	if (note)
	{
		var reason = (state === "queued" && status.reason) ? String(status.reason) : "";
		note.text = reason !== "" ? WodaLocalizeOr("#woda_queue_reason_" + reason, reason) : "";
		note.visible = reason !== "";
	}
	var box = $("#WodaConnectBox");
	box.SetHasClass("Error", state === "error");
	box.SetHasClass("Ready", state === "ready" || state === "relaunch");
	box.SetHasClass("CanChange", state === "queued" && !!status.can_change);
}

function WodaApplyStatus(status)
{
	if (!status)
	{
		return;
	}
	g_WodaStatusTime = status.updated_at;
	$("#WodaConnectBox").SetHasClass("Visible", true);
	var state = status.state || "waiting";
	if (state === "search_choose")
	{
		WodaHidePicker();
		$("#WodaSearchBox").SetHasClass("Visible", false);
		g_WodaSearch.status = null;
		WodaRenderSearchChoice(status);
		WodaUpdateStatusText(state, status);
		return;
	}
	if (state === "searching" || state === "search_found")
	{
		WodaHidePicker();
		$("#WodaSearchPicker").SetHasClass("Visible", false);
		WodaRenderSearching(status);
		WodaUpdateStatusText(state, status);
		return;
	}
	WodaHideSearch();
	if (state === "choose" || state === "session")
	{
		if (g_WodaRegion.serial !== status.updated_at)
		{
			g_WodaRegion.serial = status.updated_at;
			var chooseSec = Number(status.choose_sec) || 0;
			g_WodaRegion.deadline = chooseSec > 0 ? Date.now() + chooseSec * 1000 : 0;
		}
		g_WodaRegion.mode = state;
		if (state === "choose")
		{
			WodaRenderPicker(status);
		}
		else
		{
			WodaRenderSession(status);
		}
		WodaUpdateStatusText(state, status);
		return;
	}
	WodaHidePicker();
	WodaUpdateStatusText(state, status);
}

function WodaOnStatusChanged(tableName, key, value)
{
	if (key !== "status")
	{
		return;
	}
	WodaApplyStatus(value);
}

function WodaPollStatus()
{
	var status = CustomNetTables.GetTableValue("woda_connect", "status");
	if (status && status.updated_at !== g_WodaStatusTime)
	{
		WodaApplyStatus(status);
	}
	$.Schedule(1.0, WodaPollStatus);
}

function WodaReadConvarInt(name)
{
	try
	{
		return Game.GetConvarInt(name) || 0;
	}
	catch (e)
	{
		return 0;
	}
}

function WodaSendPartyInfo()
{
	var ids = [];
	var groups = {};
	var groupOrder = [];
	for (var i = 1; i <= 8; i++)
	{
		var value = WodaReadConvarInt("woda_party_" + i);
		if (value > 0)
		{
			var steamId = String(value);
			ids.push(steamId);
			var group = WodaReadConvarInt("woda_group_" + i) || (100 + i);
			if (!groups[group])
			{
				groups[group] = [];
				groupOrder.push(group);
			}
			groups[group].push(steamId);
		}
	}
	var groupTexts = [];
	for (var g = 0; g < groupOrder.length; g++)
	{
		groupTexts.push(groups[groupOrder[g]].join(","));
	}
	var lang = "";
	try
	{
		lang = String($.Language() || "");
	}
	catch (e)
	{
		lang = "";
	}
	GameEvents.SendCustomGameEventToServer("event_woda_party_info", {
		ids: ids.join(","),
		groups: groupTexts.join("-"),
		mode: WodaReadConvarInt("woda_party_mode"),
		launch: WodaReadConvarInt("woda_local_launch"),
		lang: lang
	});
}

(function()
{
	Game.AutoAssignPlayersToTeams();
	WodaBindButtons();
	CustomNetTables.SubscribeNetTableListener("woda_connect", WodaOnStatusChanged);
	WodaUpdateCountdown();
	WodaPollStatus();
	WodaSendPartyInfo();
	$.Schedule(2.0, WodaSendPartyInfo);
	$.Schedule(6.0, WodaSendPartyInfo);
})();