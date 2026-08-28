--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	TOTAL_DAMAGE_BAR: $("#DPS_C_TS_DamageBar"),
	INSTANCES_CONTAINER: $("#DPS_C_InstancesContainer"),
	TOGGLE_RESET_ON_RESPAWN: $("#DPS_C_ResetOnRespawn"),
	TOGGLE_AUTO_OPENING: $("#DPS_C_AutoOpen"),
	TOGGLE_ONLY_HERO_DAMAGE: $("#DPS_C_OnlyHeroDamage"),
	TOGGLE_ONLY_BUILDING_DAMAGE: $("#DPS_C_OnlyBuildingDamage"),
	TEAMS_LIST: $("#DPS_C_TeamsList"),
	TEAMS_LIST_WRAP: $("#DPS_C_TeamsList_Wrap"),
	BUTTON_MODE_TOTAL: $("#DPS_C_Mode_Total"),
	BUTTON_MODE_PER_SEC: $("#DPS_C_Mode_PerSec"),
};
HUD.TOTAL_DAMAGE_BAR.physical_bar = $("#DPS_C_TS_DamageBar_Physical");
HUD.TOTAL_DAMAGE_BAR.magical_bar = $("#DPS_C_TS_DamageBar_Magical");
HUD.TOTAL_DAMAGE_BAR.pure_bar = $("#DPS_C_TS_DamageBar_Pure");

const OTHER_SOURCES = {
	illusion: "file://{images}/spellicons/modifier_illusion.png",
	attack: "file://{images}/custom_game/dps_counter/attack.png",
	summon: "file://{images}/custom_game/dps_counter/summon.png",
};
const DPS_TICKER = new CustomTicker("DPSRecordTime", 1);

let CACHED_INSTANCES = {};
let CACHED_DPS_DATA = {};
let CACHED_HEROES_BUTTONS = [];

let TOTAL_DAMAGE_CACHED = {};
let ACTIVATED_PLAYER_ID = LOCAL_PLAYER_ID;
let last_reset_time;
let record_time = 0;
let supporter_level = 0;
const TEAMS_LIST_SEQUENCE = new RunSequentialActions();

let b_only_hero_damage = false;
let b_only_building_damage = false;

function UpdateDPSData(event) {
	supporter_level = event.supporter_level;
	last_reset_time = event.last_reset_time;

	CACHED_DPS_DATA[event.observed_player_id] = event.dps_data;

	UpdateDPSPanel();
	HUD.CONTEXT.SwitchClass("supp_level", `SuppLevel_${supporter_level}`);
}

function UpdateDPSPanel() {
	if (!CACHED_DPS_DATA[ACTIVATED_PLAYER_ID]) return;

	let damage_by_types = {
		[DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL]: 0,
		[DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL]: 0,
		[DAMAGE_TYPES.DAMAGE_TYPE_PURE]: 0,
	};

	let total_damage = 0;
	for (const [name, info] of Object.entries(CACHED_DPS_DATA[ACTIVATED_PLAYER_ID])) {
		let instance = CACHED_INSTANCES[name];
		if (!instance) {
			instance = $.CreatePanel("Panel", HUD.INSTANCES_CONTAINER, "");
			instance.BLoadLayoutSnippet("DPS_C_Instance");

			const icon = instance.FindChildTraverse("DPS_C_I_Icon");

			if (OTHER_SOURCES[name]) {
				icon.SetImage(OTHER_SOURCES[name]);
				icon.SetPanelEvent("onmouseover", function () {
					$.DispatchEvent("DOTAShowTextTooltip", icon, `#dps_counter_${name}`);
				});
				icon.SetPanelEvent("onmouseout", function () {
					$.DispatchEvent("DOTAHideTextTooltip");
				});
			} else {
				icon.SetAbilityImageToPlayer(ACTIVATED_PLAYER_ID, name);

				icon.SetPanelEvent("onmouseover", function () {
					$.DispatchEvent("DOTAShowAbilityTooltip", icon, name);
				});
				icon.SetPanelEvent("onmouseout", function () {
					$.DispatchEvent("DOTAHideAbilityTooltip");
				});
			}

			instance.damage_bar = instance.FindChildTraverse("DPS_C_I_DamageBar");
			instance.damage_bar.physical_bar = instance.FindChildTraverse("DPS_C_I_DamageBar_Physical");
			instance.damage_bar.magical_bar = instance.FindChildTraverse("DPS_C_I_DamageBar_Magical");
			instance.damage_bar.pure_bar = instance.FindChildTraverse("DPS_C_I_DamageBar_Pure");

			CACHED_INSTANCES[name] = instance;
		}

		let instance_damage_info = {
			[DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL]: 0,
			[DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL]: 0,
			[DAMAGE_TYPES.DAMAGE_TYPE_PURE]: 0,
		};
		let instance_total_damage = 0;

		const damage_info = b_only_hero_damage ? info.heroes : b_only_building_damage ? info.buildings : info.total;

		for (const [damage_type, damage] of Object.entries(damage_info.damage_by_type)) {
			damage_by_types[damage_type] += damage;
			total_damage += damage;
			instance_damage_info[damage_type] += damage;
			instance_total_damage += damage;
		}
		instance.total_damage = instance_total_damage;
		instance.damage_info = instance_damage_info;

		instance.SetDialogVariableInt("count", damage_info.count);
		instance.SetHasClass("BRecordedDamage", damage_info.count > 0);
		FillDamageBar(instance.damage_bar, instance_total_damage, instance_damage_info, name);
	}

	for (const instance of Object.values(CACHED_INSTANCES)) {
		let width = 0;
		if (total_damage > 0) width = Math.max(0.09, instance.total_damage / total_damage);
		instance.damage_bar.GetParent().style.width = `${width * 100}%`;
	}

	DefaultChildrenSort(HUD.INSTANCES_CONTAINER, "total_damage");

	FillDamageBar(HUD.TOTAL_DAMAGE_BAR, total_damage, damage_by_types);

	TOTAL_DAMAGE_CACHED = {
		total_damage: total_damage,
		total_physical: damage_by_types[DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL],
		total_magical: damage_by_types[DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL],
		total_pure: damage_by_types[DAMAGE_TYPES.DAMAGE_TYPE_PURE],
	};
	if (HUD.CONTEXT.BHasClass("DPS_Mode_Total")) UpdateTotalDamageMode();
	else if (HUD.CONTEXT.BHasClass("DPS_Mode_PerSec")) UpdateDamagePerSecondMode();
}

function FillDamageBar(bar, total_damage, damage_table) {
	const physical_damage = damage_table[DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL] || 0;
	const magical_damage = damage_table[DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL] || 0;
	const pure_damage = damage_table[DAMAGE_TYPES.DAMAGE_TYPE_PURE] || 0;

	let physical_pct = (physical_damage / total_damage) * 100.0;
	if (isNaN(physical_pct)) physical_pct = 0;
	else if (physical_damage > 0) physical_pct = Math.max(3, physical_pct);

	let b_low_magical = false;
	let magical_pct = physical_pct + (magical_damage / total_damage) * 100.0;
	if (isNaN(magical_pct)) magical_pct = 0;
	else if (magical_damage > 0 && magical_pct - physical_pct < 9) {
		b_low_magical = true;
		physical_pct = Math.min(97, physical_pct);
		magical_pct += 3;
	}

	let pure_pct = magical_pct + (pure_damage / total_damage) * 100.0;
	if (isNaN(pure_pct)) pure_pct = 0;
	else if (pure_damage > 0 && (pure_pct > 100 || physical_pct > 99 || magical_pct > 99)) {
		physical_pct = Math.min(b_low_magical ? 94 : 97, physical_pct);
		magical_pct = Math.min(97, magical_pct);
	}

	bar.physical_bar.style.width = `${physical_pct}%`;
	bar.magical_bar.style.width = `${magical_pct}%`;
	bar.pure_bar.style.width = `${pure_pct}%`;
}

function ResetDPSPanel(clear_cache) {
	FillDamageBar(HUD.TOTAL_DAMAGE_BAR, 1, {});

	HUD.CONTEXT.SetDialogVariableInt("total_damage", 0);
	HUD.CONTEXT.SetDialogVariableInt("total_magical", 0);
	HUD.CONTEXT.SetDialogVariableInt("total_physical", 0);
	HUD.CONTEXT.SetDialogVariableInt("total_pure", 0);
	HUD.INSTANCES_CONTAINER.RemoveAndDeleteChildren();
	CACHED_INSTANCES = {};
	if (clear_cache) CACHED_DPS_DATA = {};
}

function ResetRequest() {
	last_reset_time = undefined;

	GameEvents.SendToServerEnsured("DPS_Counter:reset", {});
}

function CreateDPSTeamPanel(team_id) {
	if (
		team_id < DOTATeam_t.DOTA_TEAM_FIRST ||
		team_id >= DOTATeam_t.DOTA_TEAM_CUSTOM_MAX ||
		team_id == DOTATeam_t.DOTA_TEAM_NOTEAM ||
		team_id == DOTATeam_t.DOTA_TEAM_NEUTRALS
	)
		return;

	const team_panel = $.CreatePanel("Panel", HUD.TEAMS_LIST, `DPS_C_Team_${team_id}`);
	team_panel.BLoadLayoutSnippet("DPS_C_Team");
	team_panel.AddClass(`Team_${team_id}`);

	team_panel.players_list = team_panel.FindChildTraverse("DPS_C_T_PlayersList");

	const local_team_id = Players.GetTeam(LOCAL_PLAYER_ID);
	const is_local_team = local_team_id == team_id;

	if (is_local_team) team_panel.weight = 9999;
	else team_panel.weight = team_id;

	DefaultChildrenSort(HUD.TEAMS_LIST, "weight", true);
	team_panel.SetHasClass("BLocalTeam", is_local_team);

	const lock_overlay = team_panel.FindChildTraverse("DPS_C_T_LockOverlay");
	lock_overlay.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", lock_overlay, `#dps_lock_supp_${is_local_team ? 1 : 2}`);
	});

	return team_panel;
}

function CreateButtonForPlayer(player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info)
		return void DPS_TICKER.Add(
			`CreateButtonForPlayer_${player_id}`,
			CreateButtonForPlayer.bind(undefined, player_id),
		);

	DPS_TICKER.Remove(`CreateButtonForPlayer_${player_id}`);

	let hero_button = $(`#DPS_C_Player_${player_id}`);
	if (hero_button) return;

	const team_id = Players.GetTeam(player_id);
	const team_root = $(`#DPS_C_Team_${team_id}`) || CreateDPSTeamPanel(team_id);
	if (!team_root) return;

	team_root.SetHasClass(
		"BOtherHeroesOwned",
		player_id != LOCAL_PLAYER_ID && team_id == Players.GetTeam(LOCAL_PLAYER_ID),
	);

	const is_local = player_id == LOCAL_PLAYER_ID;
	hero_button = $.CreatePanel("Button", team_root.players_list, `DPS_C_Player_${player_id}`);
	hero_button.BLoadLayoutSnippet("DPS_C_HeroButton");
	hero_button.SetHasClass("BLocalPlayer", is_local);
	hero_button.player_id = player_id;
	HUD.TEAMS_LIST.ClearPropertyFromCode("width");

	hero_button.SetDialogVariableLocString("hero_name", player_info.player_selected_hero);
	hero_button.SetDialogVariableLocString("player_name", player_info.player_name);
	hero_button.SetDialogVariableLocString("player_color", GetHEXPlayerColor(player_id));

	team_root.SwitchClass("heroes-count", `TotalHeroes_${team_root.players_list.Children().length}`);

	const hero_image = hero_button.FindChildTraverse("DPS_C_HB_Image");
	const update_hero_image = () => {
		hero_image.SetImage(GetPortraitImage(player_id, player_info.player_selected_hero));
	};
	update_hero_image();
	DPS_TICKER.Add(`UpdatePortraitImage_${player_id}`, update_hero_image);

	hero_button.SetPanelEvent("onactivate", () => {
		if (ACTIVATED_PLAYER_ID == player_id) return;

		GameEvents.SendToServerEnsured("DPS_Counter:change_observed_player", {
			observed_player_id: player_id,
		});

		OpenPlayerDPS(player_id);

		HUD.CONTEXT.SetHasClass("BLocalPlayer", player_id == LOCAL_PLAYER_ID);
	});
	hero_button.SetPanelEvent("onmouseover", () =>
		$.DispatchEvent(
			"DOTAShowTextTooltip",
			hero_image,
			`<b><font color='{s:player_color}'>{s:player_name}</font></b><br>{s:hero_name}`,
		),
	);

	if (is_local) hero_button.AddClass("C_Activated");
	hero_button.weight = is_local ? 9999 : player_id;

	DefaultChildrenSort(team_root.players_list, "weight");

	CACHED_HEROES_BUTTONS.push(hero_button);
}

function OpenPlayerDPS(player_id) {
	if (ACTIVATED_PLAYER_ID == player_id) return;
	const local_team = Players.GetTeam(LOCAL_PLAYER_ID);
	const target_team = Players.GetTeam(player_id);

	switch (supporter_level) {
		case 0:
			if (player_id != LOCAL_PLAYER_ID) return;
			break;
		case 1:
			if (local_team != target_team) return;
			break;
	}

	ResetDPSPanel(false);
	ACTIVATED_PLAYER_ID = player_id;
	UpdateDPSPanel();
	for (const hb of CACHED_HEROES_BUTTONS) hb.SetHasClass("C_Activated", hb.player_id == player_id);
}
function InitPlayers() {
	for (let player_id = 0; player_id <= 24; player_id++) {
		CreateButtonForPlayer(player_id);
	}
}

function UpdateDamagePerSecondMode() {
	for (const instance of Object.values(CACHED_INSTANCES))
		instance.SetDialogVariableInt("damage", Math.floor(instance.total_damage / Math.max(record_time, 1)));

	for (const [var_name, damage_value] of Object.entries(TOTAL_DAMAGE_CACHED))
		HUD.CONTEXT.SetDialogVariableInt(var_name, Math.floor(damage_value / Math.max(record_time, 1)));
}
function UpdateTotalDamageMode() {
	for (const instance of Object.values(CACHED_INSTANCES))
		instance.SetDialogVariableInt("damage", instance.total_damage);

	for (const [var_name, damage_value] of Object.entries(TOTAL_DAMAGE_CACHED))
		HUD.CONTEXT.SetDialogVariableInt(var_name, damage_value);
}

function DPSTimer() {
	DPS_TICKER.Add("record", () => {
		if (!last_reset_time) {
			HUD.CONTEXT.SetDialogVariable("record_time", "00:00");
			return;
		}
		record_time = Game.GetGameTime() - last_reset_time;
		HUD.CONTEXT.SetDialogVariable("record_time", FormatSeconds(record_time));
	});
}

function ToggleDPSCounter(force_state) {
	let current_state = HUD.CONTEXT.BHasClass("BHideDPSCounter");
	let new_state = force_state != undefined ? !force_state : !current_state;

	HUD.CONTEXT.SetHasClass("BHideDPSCounter", new_state);
	DPS_TICKER.SetPause(new_state);
	if (!new_state) OpenPlayerDPS(LOCAL_PLAYER_ID);
}

function OpenDPS() {
	ToggleDPSCounter(true);
}
function CloseDPS() {
	ToggleDPSCounter(false);
}
function FullModeAnimation(target_width) {
	TEAMS_LIST_SEQUENCE.finish();
	TEAMS_LIST_SEQUENCE.actions = [];

	let full_width = HUD.TEAMS_LIST.contentwidth / HUD.TEAMS_LIST.actualuiscale_x;
	if (dotaHud.GetChild(0).BHasClass("HUDFlipped")) full_width *= -1;

	const show_full_mode = HUD.CONTEXT.BHasClass("DPS_FullMode");

	const teams_width_lerp = new LerpAction(0.12);
	teams_width_lerp.apply_progress = (progress) => {
		HUD.TEAMS_LIST_WRAP.style.transform = `translateX(${Lerp(
			progress,
			show_full_mode ? full_width : target_width,
			show_full_mode ? target_width : full_width,
		)}px)`;
	};

	TEAMS_LIST_SEQUENCE.add(teams_width_lerp);
	RunSingleAction(TEAMS_LIST_SEQUENCE);
}
function ToggleFullMode() {
	HUD.CONTEXT.ToggleClass("DPS_FullMode");
	FullModeAnimation(0);
}
function ActivateMode(mode) {
	HUD.CONTEXT.SwitchClass("dps_mode", `DPS_Mode_${mode}`);
	switch (mode) {
		case "Total":
			UpdateTotalDamageMode();
			break;
		case "PerSec":
			UpdateDamagePerSecondMode();
			break;
	}
}

function ToggleResetOnRespawn() {
	GameEvents.SendToServerEnsured("DPS_Counter:toggle_reset_on_respawn", {});
}

function ToggleAutoOpen() {
	GameEvents.SendToServerEnsured("DPS_Counter:toggle_auto_opening", {});
}

function ToggleOnlyHeroesDamage() {
	b_only_hero_damage = HUD.TOGGLE_ONLY_HERO_DAMAGE.IsSelected();

	HUD.TOGGLE_ONLY_BUILDING_DAMAGE.SetSelected(false);
	b_only_building_damage = false;

	UpdateDPSPanel();
}

function ToggleOnlyBuildingsDamage() {
	b_only_building_damage = HUD.TOGGLE_ONLY_BUILDING_DAMAGE.IsSelected();

	HUD.TOGGLE_ONLY_HERO_DAMAGE.SetSelected(false);
	b_only_hero_damage = false;

	UpdateDPSPanel();
}

function UpdateSettings(event) {
	HUD.TOGGLE_RESET_ON_RESPAWN.SetSelected(!!event.reset_on_respawn);
	HUD.TOGGLE_AUTO_OPENING.SetSelected(!!GameUI.Player.GetSettingValue("dps_auto_opening"));
}

(() => {
	HUD.TEAMS_LIST.RemoveAndDeleteChildren();
	InitPlayers();
	ResetDPSPanel(true);
	CloseDPS();
	DPSTimer();
	ActivateMode("Total");
	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("DPS_Counter:update", UpdateDPSData);
	frame.SubscribeProtected("DPS_Counter:reset_client", ResetDPSPanel.bind(undefined, true));
	frame.SubscribeProtected("DPS_Counter:update_settings", UpdateSettings);
	frame.SubscribeProtected("DPS_Counter:force_open", OpenDPS);
	frame.SubscribeProtected("DPS_Counter:force_close", CloseDPS);

	GameEvents.SendToServerEnsured("DPS_Counter:get_settings", {});
	$.RegisterForUnhandledEvent("Cancelled", CloseDPS);
})();