--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const wait_time = [
	10, // 0 level patreon
	5, // 1 level patreon
	0, // 2 level patreon
];

// localized text by pick locker stages and supporter levels
const localized_text = {
	0: [$.Localize("#HighSupportersOnly"), $.Localize("#SupportersOnly")],
	1: [$.Localize("#HighSupportersOnly")],
};

const custom_random_button = $("#CustomRandomButton");
const random_button = FindDotaHudElement("RandomButton");

const interval = 0;
const picking_time = 20;
let level = 0;
let random_pressed = false;

function InvokeUpdate(buttons) {
	$.Schedule(interval, function () {
		UpdatePickButton(buttons);
	});
}

function DisableButtons(buttons) {
	buttons.forEach((button) => {
		button.enabled = false;
		button.SetAcceptsFocus(false);
		button.BAcceptsInput(false);
		button.style.saturation = 0.0;
		button.style.brightness = 0.2;
	});
}

function UpdatePickButton(buttons) {
	// if player already selected his hero - hide all buttons
	if (Players.GetSelectedHeroID(Players.GetLocalPlayer()) != 0) {
		custom_random_button.visible = false;
		DisableButtons(buttons);
		return;
	}

	// force stop the update if hero selection state is finished
	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) return;

	// waiting until ban phase or pause expires
	if (Game.IsInBanPhase() || Game.IsGamePaused()) {
		InvokeUpdate(buttons);
		return;
	}

	const nt = CustomNetTables.GetTableValue("game_state", "ban_state_endtime");
	const current_time = Game.GetGameTime();
	const start_time = nt ? nt.time : current_time;
	const display_time = start_time - current_time + wait_time[level];

	if (display_time <= 0) {
		buttons.forEach((button) => {
			button.enabled = true;
			button.SetAcceptsFocus(true);
			button.BAcceptsInput(true);
			button.style.saturation = null;
			button.style.brightness = null;
		});

		buttons[0].GetChild(0).text = $.Localize("#DOTA_Hero_Selection_LOCKIN");
		return;
	}

	// take lock text list, and iterate it over, mapping to wait times corresponding to current subscription level
	// start with first phrase, and change it as time passes
	const text_list = localized_text[level];
	let text = text_list[0];

	// note that indexing start from second applicable time interval, defaulting to first phrase
	// (so tier 0 starts at high supporter phrase, and checks if time is below 5 seconds to change it to supporter)
	for (let i = text_list.length - 1; i >= 0; i--) {
		if (display_time <= wait_time[i]) {
			text = text_list[i];
			break;
		}
	}

	buttons[0].GetChild(0).text = `${text} (${Math.min(10, Math.ceil(display_time))})`;

	InvokeUpdate(buttons);
}

function PickRandomHero() {
	// discard random requests if we've already pressed that or have hero selected
	if (random_pressed || Players.GetSelectedHeroID(Players.GetLocalPlayer()) != 0) return;
	random_pressed = true;
	GameEvents.SendToServerEnsured("pick_random_hero", {});
}

function InitPickLocker() {
	if (IsSpectating()) return;

	// wait until ban phase expires
	if (Game.IsInBanPhase()) {
		$.Schedule(interval, InitPickLocker);
		return;
	}

	if (level >= 2) return;

	let pick_button = FindDotaHudElement("LockInButton");
	// let smart_random_button = FindDotaHudElement("SmartRandomButton");

	let buttons = [pick_button, custom_random_button];

	DisableButtons(buttons);

	let label = pick_button.GetChild(0);
	label.style.width = "95%";
	label.style.height = "25px";
	label.style.horizontalAlign = "left";
	label.style.textOverflow = "shrink";

	UpdatePickButton(buttons);
}

(() => {
	random_button.visible = false;
	custom_random_button.visible = true;
	custom_random_button.SetParent(random_button.GetParent());

	GameUI.Player.RegisterForPlayerDataChanges(() => {
		level = GameUI.Player.GetSubscriptionTier();

		if (GameUI.GetOption("tournament_mode") || Game.IsInToolsMode() || Game.IsDemoMode()) {
			level = 2;
		}

		InitPickLocker();
	});
})();