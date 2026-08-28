--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


let time_counter = 0;
let b_root_visible = false;
let tracker_hud;

const MAP_OVERLAY = $("#MapOverlay");

function SetRootPingActive(bool) {
	tracker_hud.hittest = bool;
	HUD_ROOT_FOR_TRACKER.hittestchildren = bool;
}

function ClearActive() {
	for (let i = 1; i <= PINGS_COUNT; i++) {
		$(`#Custom_Ping${i}`).SetHasClass("Active", false);
	}
	HUD_PING_WHEEL.SetHasClass("DefaultPing", false);
}

function PingToServer() {
	for (let i = 1; i <= PINGS_COUNT; i++) {
		const panel = $(`#Custom_Ping${i}`);
		if (panel.BHasClass("Active")) {
			let ping_pos_screen = HUD_PING_WHEEL.GetPositionWithinWindow();
			const x = ping_pos_screen.x + hud_wheel_half_width;
			const y = ping_pos_screen.y + hud_wheel_half_height;
			GameEvents.SendToServerEnsured("custom_ping:ping", {
				pos: Game.ScreenXYToWorld(x, y),
				type: panel.GetAttributeInt("ping-type", 0),
			});
		}
	}
}

function GamePingsTracker() {
	if (GameUI.IsAltDown() && GameUI.IsMouseDown(0)) {
		time_counter += THINK;
	} else {
		if (b_root_visible) PingToServer();
		ClearActive();
		SetRootPingActive(false);
		HUD_PING_WHEEL.visible = false;
		b_root_visible = false;
		time_counter = 0;
	}

	if (time_counter >= TRIGGER_TIME_FOR_WHEEL && !b_root_visible) {
		const cursor = GameUI.GetCursorPosition();
		SetRootPingActive(true);
		$.Schedule(0.01, () => {
			if (tracker_hud.BHasHoverStyle()) {
				HUD_PING_WHEEL.visible = true;
				b_root_visible = true;
				HUD_PING_WHEEL.style.position = `${(cursor[0] - hud_wheel_half_width) / ROOT.actualuiscale_x}px ${
					(cursor[1] - hud_wheel_half_height) / ROOT.actualuiscale_y
				}px 0px`;
			}
		});
	}

	if (b_root_visible) {
		ClearActive();
		const cursor = GameUI.GetCursorPosition();
		const root_pos = HUD_PING_WHEEL.GetPositionWithinWindow();

		const x = cursor[0] - root_pos.x - hud_wheel_half_width;
		const y = root_pos.y - cursor[1] + hud_wheel_half_height;

		let deg = (Math.atan2(y, x) * 180) / Math.PI + (y < 0 ? 360 : 0);

		let element_n = Math.ceil(0.5 + deg / (360 / (PINGS_COUNT - 1)));
		element_n = element_n == 7 ? 1 : element_n;

		const x_abs = Math.abs(x);
		const y_abs = Math.abs(y);
		if (x_abs < MIN_OFFSET && y_abs < MIN_OFFSET) element_n = 7;

		if (x_abs <= MAX_OFFSET * ROOT.actualuiscale_x && y_abs <= MAX_OFFSET * ROOT.actualuiscale_y) {
			const panel = $(`#Custom_Ping${element_n}`);
			if (panel) panel.SetHasClass("Active", true);
			HUD_PING_WHEEL.SetHasClass("DefaultPing", element_n == 7);
		}
	}
	$.Schedule(THINK, () => {
		GamePingsTracker();
	});
}

function ClientPing(data) {
	if (data.type == undefined || PINGS_DATA[data.type] == undefined) return;

	const original_map_width = Math.ceil(minimap.actuallayoutwidth / minimap.actualuiscale_x);
	const original_map_height = Math.ceil(minimap.actuallayoutheight / minimap.actualuiscale_y);

	const world_pos = data.pos.split(" ");
	const coef_x = world_pos[0] / (WORLD_X * 2);
	const coef_y = world_pos[1] / (WORLD_Y * 2);
	const pos_x = (coef_x + 0.5) * original_map_width;
	const pos_y = (0.5 - coef_y) * original_map_height;

	if (pos_x > original_map_width || pos_y > original_map_height) return;

	const new_ping = $.CreatePanel("Panel", HUD_FOR_CUSTOM_PINGS, "");
	new_ping.BLoadLayoutSnippet("CustomPing");

	const margin_side = pos_x - hud_ping_root_half_width + coef_x * 8;
	if (dota_hud.BHasClass("HUDFlipped")) {
		new_ping.style.marginLeft = `${original_map_width - margin_side - hud_ping_root_half_width * 2}px`;
	} else {
		new_ping.style.marginLeft = `${margin_side}px`;
	}

	const margin_top = pos_y + hud_ping_root_half_height - coef_y * 8;

	new_ping.style.marginTop = `${original_map_height - margin_top}px`;

	const image = new_ping.GetChild(0);
	image.AddClass("Pulse");

	if (PINGS_DATA[data.type].image != undefined) {
		image.SetImage(PINGS_DATA[data.type].image);
	}
	if (PINGS_DATA[data.type].sound != undefined) {
		Game.EmitSound(PINGS_DATA[data.type].sound);
	}

	if (data.type == C_PingsTypes.DEFAULT || data.type == C_PingsTypes.DANGER || data.type == C_PingsTypes.WAYPOINT) {
		var player_color = GetHEXPlayerColor(data.player_id);
		image.style.washColor = player_color;
	} else if (data.type == C_PingsTypes.RETREAT) {
		image.style.washColor = "#ff0a0a;";
	}

	let text_label;

	if (data.type == C_PingsTypes.WAYPOINT) {
		let hero_name = Players.GetPlayerSelectedHero(data.player_id);
		new_ping.GetChild(1).SetImage(GetPortraitIcon(data.player_id, hero_name));
		text_label = $.CreatePanel("Label", ROOT, "");
		text_label.AddClass("HeroNamePing");
		text_label.text = $.Localize(hero_name);
		text_label.style.color = player_color;
		text_label.SetParent(tracker_hud);
		$.Schedule(0.01, () => {
			FreezePanel(text_label, parseInt(world_pos[0]), parseInt(world_pos[1]), parseInt(world_pos[2]) + 120);
		});
	}

	$.Schedule(3.5, () => {
		new_ping.DeleteAsync(0);
		if (text_label) text_label.DeleteAsync(0);
	});
}

function FreezePanel(panel, pos_x, pos_y, pos_z) {
	if (!panel.IsValid()) return;
	const sX = Game.WorldToScreenX(pos_x, pos_y, pos_z);
	const sY = Game.WorldToScreenY(pos_x, pos_y, pos_z);

	var x = sX / panel.actualuiscale_x - panel.actuallayoutwidth / 2;
	var y = sY / panel.actualuiscale_y - panel.actuallayoutheight;
	panel.SetPositionInPixels(x, y, 0);
	$.Schedule(0, () => {
		FreezePanel(panel, pos_x, pos_y, pos_z);
	});
}

const DEFAULT_MAP_STYLES = {
	minimap_block: {
		width: ["244px", "280px"],
		height: ["244px", "280px"],
		backgroundImage: "url('s2r://panorama/images/hud/reborn/bg_minimap_psd.vtex')",
		verticalAlign: "bottom",
	},
	minimap: {
		width: ["260px", "296px"],
		height: ["260px", "296px"],
		verticalAlign: "middle",
		horizontalAlign: "center",
	},
	GlyphScanContainer: {
		marginLeft: ["244px", "280px"],
		height: "280px",
		width: "74px",
		padding: "0px",
		verticalAlign: "bottom",
		backgroundImage: "url('s2r://panorama/images/hud/reborn/glyph_scan_bg_psd.vtex')",
		backgroundSize: "cover",
	},
};

function ResetMapStyleByDefault() {
	$.Schedule(0, () => {
		const is_large_map = FindDotaHudElement("Hud").BHasClass("MinimapExtraLarge");

		Object.entries(DEFAULT_MAP_STYLES).forEach(([element_name, json_style]) => {
			const reset_style_valid_check = () => {
				const element = FindDotaHudElement(element_name);
				if (!element || !element.IsValid()) return $.Schedule(1, reset_style_valid_check);

				Object.entries(json_style).forEach(([_name, _value]) => {
					let value = _value;
					if (typeof _value == "object") value = _value[is_large_map ? 1 : 0];

					element.style[_name] = value;
				});
			};
			reset_style_valid_check();
		});
	});
}

let latest_map_state_block = false;
function BlockMap() {
	if (latest_map_state_block) return;
	latest_map_state_block = true;

	MAP_OVERLAY.hittest = true;
	MAP_OVERLAY.SetPanelEvent("onactivate", () => {});
}
function UnBlockMap() {
	if (!latest_map_state_block) return;
	latest_map_state_block = false;

	MAP_OVERLAY.hittest = false;
	MAP_OVERLAY.ClearPanelEvent("onactivate");
}
function BlockMinimapDraw() {
	if (GameUI.IsControlDown()) BlockMap();
	else UnBlockMap();

	$.Schedule(0, BlockMinimapDraw);
}
function OnPlayerKicked(kicked_players) {
	kicked_players = Object.keys(kicked_players).map(function (_p_id) {
		return Number(_p_id);
	});
	if (kicked_players.indexOf(Game.GetLocalPlayerID()) > -1) BlockMinimapDraw();
}

function ChangeMapOverlayParent() {
	const game_hud = FindDotaHudElement("HUDElements");
	if (!game_hud) return void $.Schedule(0.1, ChangeMapOverlayParent);
	const delete_ex_overlay = () => {
		const ex_overlay = game_hud.FindChild("MapOverlay");
		if (ex_overlay) ex_overlay.DeleteAsync(0);
	};
	delete_ex_overlay();

	MAP_OVERLAY.SetParent(game_hud);
	game_hud.MoveChildAfter(MAP_OVERLAY, FindDotaHudElement("minimap_container"));
}
const minimap_block = FindDotaHudElement("minimap_block");
function BlockMinimapByPunisment() {
	const minimap = minimap_block.GetChild(0);

	minimap.style.width = "0px";

	$.Schedule(0, BlockMinimapByPunisment);
}
function SetPunishment(event) {
	const level = event?.punishment_level || 0;
	if (level <= 0) return;
	if (level == 10) BlockMinimapByPunisment();
}
(function () {
	SubscribeToNetTableKey("game_state", "kicked_players", OnPlayerKicked);
	HUD_FOR_CUSTOM_PINGS.RemoveAndDeleteChildren();

	ResetMapStyleByDefault();
	$.RegisterEventHandler("PanelStyleChanged", minimap_block, ResetMapStyleByDefault);
	$.RegisterEventHandler("PanelStyleChanged", MAP_OVERLAY, ResetMapStyleByDefault);

	const remove_dota_hud_element = function (id) {
		const element = FindDotaHudElement(id);
		if (element) element.DeleteAsync(0);
	};
	remove_dota_hud_element("HUDSkinMinimap");
	remove_dota_hud_element("HUDSkinFXGlyph");
	remove_dota_hud_element("HUDSkinTopBarBG");

	HUD_ROOT_FOR_TRACKER.Children().forEach((p) => {
		if (p.id == "CustomPingsHudTracker") p.DeleteAsync(0);
	});
	const panel = $("#CustomPingsHudTracker");
	panel.SetParent(HUD_ROOT_FOR_TRACKER);
	panel.hittest = true;
	tracker_hud = panel;
	GamePingsTracker();

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());

	frame.SubscribeProtected("custom_ping:ping_client", ClientPing);
	frame.SubscribeProtected("Punishments:set_punishment", SetPunishment);

	// TODO
	// GameEvents.SendToServerEnsured("Punishments:get_punishment", {});

	ChangeMapOverlayParent();
})();