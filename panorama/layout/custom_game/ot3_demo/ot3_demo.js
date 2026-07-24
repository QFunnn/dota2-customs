--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	HERO_PICKER_ROOT: $("#HeroPicker"),
	DEMO_SELECTION_CONTAINER: $("#DemoSelectHeroContainer"),
	HERO_PICKER_IMAGE: $("#HeroPickerImage"),

	ENEMY_TEAM_SELECTOR: $("#EnemyTeamSelector"),
};

let SELECTED_ENEMY_TEAM = undefined;
let block_some_events = true;

function SetTargetHeroUI(data) {
	HUD.HERO_PICKER_IMAGE.heroname = data.hero_name;
	HUD.CONTEXT.SetDialogVariableLocString("spawn_hero_name", data.hero_name);
}

function SwitchToNewHero(hero_id) {
	Game.EmitSound("UI.Button.Pressed");

	GameEvents.SendToServerEnsured("Demo:set_selected_unit", { hero_id: hero_id });

	ToggleHeroPicker(false);
}

function ToggleHeroPicker(b_force_state) {
	if (b_force_state != undefined) HideSubTestUI();
	else ToggleTestUI("HeroPicker");

	const b_picker_show = HUD.CONTEXT.BHasClass("BShowTestUI_HeroPicker");
	const text_entry = HUD.DEMO_SELECTION_CONTAINER.FindChildTraverse("HeroSearchTextEntry");
	text_entry.text = "";
	$.DispatchEvent("DropInputFocus");

	if (!b_picker_show) return;

	text_entry.SetFocus();
}

function RemoveSelectedHeroes() {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:remove_selected", { entity: selected });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function ToggleInvulnerabilityState(state) {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:toggle_invulnerability", { entity: selected, state: state });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function LevelUpSelectedHeroes() {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:level_up", { entity: selected });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function MaxLevelUpSelectedHeroes() {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:level_max", { entity: selected });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function ResetSelectedHeroes() {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:reset_hero", { entity: selected });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function ShardSelectedHeroes() {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:add_shard", { entity: selected });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function ScepterSelectedHeroes() {
	for (let selected of Players.GetSelectedEntities(0)) {
		GameEvents.SendToServerEnsured("Demo:add_scepter", { entity: selected });
	}

	Game.EmitSound("UI.Button.Pressed");
}

function MouseOverRune(rune_id, rune_tooltip) {
	let rune_panel = $("#" + rune_id);
	rune_panel.StartAnimating();
	$.DispatchEvent("UIShowTextTooltip", rune_panel, rune_tooltip);
}

function MouseOutRune(rune_id) {
	let rune_panel = $("#" + rune_id);
	rune_panel.StopAnimating();
	$.DispatchEvent("UIHideTextTooltip", rune_panel);
}

function SlideThumbActivate() {
	let slideThumb = $.GetContextPanel();
	let bMinimized = slideThumb.BHasClass("Minimized");

	if (bMinimized) Game.EmitSound("ui_settings_slide_out");
	else Game.EmitSound("ui_settings_slide_in");

	slideThumb.ToggleClass("Minimized");
	HideSubTestUI();
}

function HideSubTestUI() {
	ToggleTestUI("TestUI_None");
}

function ToggleTestUI(type) {
	const class_name = `BShowTestUI_${type}`;
	const b_panel_visible = HUD.CONTEXT.BHasClass(class_name);
	HUD.CONTEXT.SwitchClass("upgrade_visible_type", b_panel_visible ? "" : class_name);
}

function ToggleTowers() {
	GameEvents.SendToServerEnsured("TowersEnabledButtonPressed", {
		bEnabled: $("#TowersEnabledButton").IsSelected(),
	});
}

function UpdateSelectedHeroName() {
	HUD.CONTEXT.SetDialogVariableLocString("selected_hero_name", Players.GetPlayerSelectedHero(0) || "");
}

function PopulateEnemyTeamSelector() {
	HUD.ENEMY_TEAM_SELECTOR.RemoveAllOptions();

	const team_ids = Game.GetAllTeamIDs();

	for (const team_id of team_ids) {
		if (team_id == Players.GetTeam(Game.GetLocalPlayerID())) continue;

		const option = $.CreatePanel("Panel", HUD.ENEMY_TEAM_SELECTOR, team_id);
		option.BLoadLayoutSnippet("enemy_team_option");
		const image = option.GetChild(0);
		image.SetImage(GameUI.GetTeamIcon(team_id, false));
		image.style.washColor = GameUI.GetTeamColor(team_id);
		option.team_id = team_id;

		option.SetPanelEvent("onactivate", () => {
			HUD.ENEMY_TEAM_SELECTOR.SetSelected(team_id);
			$.DispatchEvent("DropInputFocus");
		});

		HUD.ENEMY_TEAM_SELECTOR.AddOption(option);
	}
}

function UpdateSelectedEnemyTeam() {
	$.Schedule(1, () => {
		HUD.ENEMY_TEAM_SELECTOR.SetSelected(`${DOTATeam_t.DOTA_TEAM_BADGUYS}`);
		ChangeCurrentEnemyTeam();
	});
}

function ChangeCurrentEnemyTeam() {
	const selected = HUD.ENEMY_TEAM_SELECTOR.GetSelected();
	selected.GetChild(0).style.washColor = GameUI.GetTeamColor(Number(selected.id));

	SELECTED_ENEMY_TEAM = Number(selected.id);
}

function SpawnAllyHero() {
	GameEvents.SendToServerEnsured("Demo:spawn_ally", {});
}

function SpawnEnemyHero() {
	GameEvents.SendToServerEnsured("Demo:spawn_enemy", {
		enemy_team_id: SELECTED_ENEMY_TEAM || DOTATeam_t.DOTA_TEAM_BADGUYS,
	});
}

function RequestSpawnRune(rune_type) {
	GameEvents.SendToServerEnsured("Demo:spawn_rune", {
		rune_type: rune_type || DOTA_RUNES.DOTA_RUNE_DOUBLEDAMAGE,
	});
}

function ChangeHero() {
	GameEvents.SendToServerEnsured("Demo:change_hero", {});
}

function SimpleServerEvent(event_name, b_check_cooldown) {
	if (b_check_cooldown && block_some_events) return;

	GameEvents.SendToServerEnsured(event_name, {});
}

function ResetEventsCooldown() {
	$.Schedule(5, () => {
		block_some_events = false;
	});
}

(function () {
	ResetEventsCooldown();
	if (!Game.IsInToolsMode() && Game.GetMapInfo().map_display_name != "ot3_demo") return;

	HUD.CONTEXT.AddClass("Show");
	UpdateSelectedHeroName();

	PopulateEnemyTeamSelector();
	UpdateSelectedEnemyTeam();

	$.RegisterEventHandler("DOTAUIHeroPickerHeroSelected", HUD.HERO_PICKER_ROOT, SwitchToNewHero);

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);

	frame.SubscribeProtected("set_spawn_hero_id", SetTargetHeroUI);

	GameEvents.SendToServerEnsured("Demo:get_state", {});
})();