--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


"use strict";

var strip = $("#DailyStrip");

var VISIBLE = 7;
var MIDDLE = Math.floor(VISIBLE / 2);

var state = { claimed: 0, cycle: 0, available: false, slots: [] };
var autoOpened = false;

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

DotaHUD.windowControllers["daily"] = {
	is_open: false,
	open: function () {
		$("#DailyPanel").SetHasClass("CloseDaily", false);
		GameEvents.SendCustomGameEventToServer("daily_open", {});
	},
	close: function () {
		$("#DailyPanel").SetHasClass("CloseDaily", true);
	}
};
DotaHUD.ListenToMouseEvent(
	DotaHUD.GetCloseWindowOnOutsideClick($("#DailyPanel"), "daily")
);

function DailyToggle() {
	if (DotaHUD.IsWindowOpen("daily")) {
		DotaHUD.WindowClose("daily");
	} else {
		DotaHUD.WindowOpen("daily");
	}
}

function maybeAutoOpen() {
	if (autoOpened || !state.available || !state.slots.length) { return; }
	if (Game.GetState() < DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME) {
		$.Schedule(1.0, maybeAutoOpen);
		return;
	}
	autoOpened = true;
	if (!DotaHUD.IsWindowOpen("daily")) {
		DotaHUD.WindowOpen("daily");
	}
}

function markIcon(available) {
	var panel = DotaHUD.Get().FindChildTraverse("daily");
	if (!panel || !panel.IsValid()) { return; }
	var image = panel.GetChild(0);
	if (!image) { return; }
	image.style.washColor = available ? "#ffd47aff" : "none";
	image.style.brightness = available ? "1.35" : "1.0";
}

function centerOn(cards, index) {
	if (!cards.length) { return; }
	var target = Math.min(index + MIDDLE, cards.length - 1);
	$.Schedule(0.05, function () {
		try {
			if (!cards[0].IsValid()) { return; }
			$.Schedule(0.0, function () {
				try {
					if (cards[target].IsValid()) {
						cards[target].ScrollParentToMakePanelFit(0, false);
					}
				} catch (e) { $.Msg("[daily] центрирование: " + e); }
			});
		} catch (e) { $.Msg("[daily] лента: " + e); }
	});
}

function bindTip(panel, slot) {
	if (slot.kind === "item" && slot.item) {
		panel.SetPanelEvent("onmouseover", function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", panel, slot.item);
		});
		panel.SetPanelEvent("onmouseout", function () {
			$.DispatchEvent("DOTAHideAbilityTooltip");
		});
		return;
	}
	var key = slot.title ? "#" + String(slot.title).replace(/^#/, "") : "#daily_tip_" + slot.kind;
	var name = slot.item ? $.Localize("#" + slot.item) : "";
	var text = $.Localize(key)
		.replace("{amount}", String(Number(slot.qty) || 1))
		.replace("{name}", name);
	panel.SetPanelEvent("onmouseover", function () {
		$.DispatchEvent("DOTAShowTextTooltip", panel, text);
	});
	panel.SetPanelEvent("onmouseout", function () {
		$.DispatchEvent("DOTAHideTextTooltip", panel);
	});
}

function cardClass(st) {
	if (st === "taken") { return "DailyCardTaken"; }
	if (st === "next") { return "DailyCardNext"; }
	return "DailyCardLocked";
}

function DailyClaim() {
	if (!state.available) { return; }
	GameEvents.SendCustomGameEventToServer("daily_claim", {});
}

function Render() {
	strip.RemoveAndDeleteChildren();

	var slots = state.slots || [];
	var current = null;
	var currentIndex = 0;
	var cards = [];

	for (var i = 0; i < slots.length; i++) {
		var s = slots[i];
		var card = $.CreatePanel("Panel", strip, "");
		card.BLoadLayoutSnippet("daily_card");
		card.AddClass(cardClass(s.state));

		card.style.width = "130px";
		card.style.height = "153px";
		cards.push(card);

		var icon = card.FindChildTraverse("cicon");
		icon.style.width = "52px";
		icon.style.height = "52px";
		icon.style.backgroundSize = "100% 100%";
		icon.style.backgroundRepeat = "no-repeat";
		if (s.icon) {
			icon.style.backgroundImage = 'url("file://{images}/' + s.icon + '.png")';
		} else if (s.kind === "item" && s.item) {
			icon.style.width = "66px";
			icon.style.height = "48px";
			var itemImage = $.CreatePanel("DOTAItemImage", icon, "");
			itemImage.itemname = s.item;
			itemImage.style.width = "100%";
			itemImage.style.height = "100%";
			itemImage.hittest = false;
		}

		bindTip(icon, s);

		card.FindChildTraverse("cday").text =
			$.Localize("#daily_day").replace("{day}", String(s.day));
		card.FindChildTraverse("cqty").text = (Number(s.qty) || 1) > 1 ? "x" + s.qty : "";

		if (s.state === "next") {
			current = s;
			currentIndex = i;

			card.SetPanelEvent("onmouseactivate", DailyClaim);
		}

		var fx = card.FindChildTraverse("cfx");
		if (fx && !(s.state === "next" && state.available)) {
			fx.DeleteAsync(0);
		}
	}

	var titleSlot = current;
	if (!state.available) {
		var last = state.claimed > 0 ? state.claimed - 1 : slots.length - 1;
		if (slots[last]) { titleSlot = slots[last]; }
	}
	$("#DailyTitle").text = titleSlot
		? $.Localize("#daily_day").replace("{day}", String(titleSlot.day))
		: $.Localize("#daily");

	markIcon(state.available);

	centerOn(cards, currentIndex);
}

(function () {
	GameEvents.Subscribe("daily_data", function (data) {
		if (!data) { return; }
		var slots = [];
		try { slots = JSON.parse(data.slots || "[]"); } catch (e) { slots = []; }
		state = {
			claimed: Number(data.claimed) || 0,
			cycle: Number(data.cycle) || 0,
			available: Number(data.available) === 1,
			slots: slots,
		};
		Render();
		maybeAutoOpen();
	});

	GameEvents.Subscribe("daily_result", function () {
		$.DispatchEvent("PlaySoundEffect", "ui.treasure_reveal");
	});

	GameUI.LoopTime.Schedule(0.0, function () {
		DotaHUD.CreateTopBarButton("file://{images}/custom_game/calendar_icon.png", "daily", DailyToggle, "daily");
		markIcon(state.available);
	});

	GameEvents.SendCustomGameEventToServer("daily_open", {});
})();