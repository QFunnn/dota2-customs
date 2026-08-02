--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const STYLE_BY_RESO = {
	//16x9 , 16x10, 4x3
	ROOT: {
		width: ["58px", "50px", "40px"],
	},
	HeroImage: {
		width: ["58px", "50px", "40px"],
		height: ["32px", "28px", "27px"],
	},
	ManaBar: {
		width: ["51px", "43px", "33px"],
	},
	HealthBar: {
		width: ["51px", "43px", "33px"],
	},
	PlayerColorShadow: {
		marginBottom: ["4px", "8px", "9px"],
	},
	TipButton: {
		force_visible: [true],
		backgroundColor: ["gradient(linear, 0% 0%, 0% 100%, from(#523e1c), to(#1a2128))"],
		padding: ["0"],
		parent: {
			force_visible: [true],
			marginTop: ["63px"],
		},
		children: {
			0: {
				backgroundImage: ["url('file://{images}/custom_game/collection/currency_icon_small.png')"],
				margin: ["3px 4px 1px 4px", "2px", "1px"],
			},
			1: {
				color: ["#f9d014"],
				text: ["+++", undefined, "++"],
			},
		},
	},
};
let current_screen_ratio_id = 0;

function ApplyStyle(panel, style) {
	Object.entries(style).forEach(([param_name, param_values]) => {
		param_value = param_values[current_screen_ratio_id] || param_values[0];

		if (param_name == "parent") {
			ApplyStyle(panel.GetParent(), param_values);
			return;
		}

		if (param_name == "children") {
			Object.entries(param_values).forEach(([child_id, child_style]) => {
				ApplyStyle(panel.GetChild(parseInt(child_id)), child_style);
			});
			return;
		}

		if (param_name == "force_visible") {
			panel.visible = param_value;
			return;
		}

		if (param_name == "text") {
			panel.text = param_value;
			return;
		}

		panel.style[param_name] = param_value;
	});
}
function OverrideDotaTopBar() {
	const hud = dotaHud.GetChild(0);
	if (hud.BHasClass("AspectRatio16x9")) current_screen_ratio_id = 0;
	if (hud.BHasClass("AspectRatio16x10")) current_screen_ratio_id = 1;
	if (hud.BHasClass("AspectRatio4x3")) current_screen_ratio_id = 2;

	const override_bar = (top_bar_name, players_container_name, team_id) => {
		const top_bar = FindDotaHudElement(top_bar_name);
		if (!top_bar) return;

		const team_bg = top_bar.GetChild(0);
		team_bg.style.paddingBottom = `${current_screen_ratio_id == 0 ? 4 : 8}px`;
		team_bg.GetChild(0).style.opacity = "1";
		team_bg.GetChild(0).style.backgroundImage = "url('s2r://panorama/images/hud/reborn/top_bar_team_bg_psd.vtex');";

		const players_list = top_bar.FindChildTraverse(players_container_name);
		if (!players_list) return;

		players_list.Children().forEach((c) => {
			Object.entries(STYLE_BY_RESO).forEach(([panel_name, style]) => {
				if (panel_name == "ROOT") return void ApplyStyle(c, style);
				ApplyStyle(c.FindChildTraverse(panel_name), style);
			});

			const tip_button = c.FindChildTraverse("TipButton");
			const player_id = c.id.replace("DirePlayer", "").replace("RadiantPlayer", "");
			tip_button.SetPanelEvent("onactivate", () => {
				if (dotaHud.BHasClass("TipsBlock")) return;
				GameEvents.SendToServerEnsured("Tips:tip", { target_player_id: parseInt(player_id) });
			});

			c.player_id = player_id;
		});

		DefaultChildrenSort(players_list, "player_id", team_id == DOTATeam_t.DOTA_TEAM_GOODGUYS);
	};

	override_bar("TopBarRadiantTeam", "TopBarRadiantPlayersContainer", DOTATeam_t.DOTA_TEAM_GOODGUYS);
	override_bar("TopBarDireTeam", "TopBarDirePlayersContainer", DOTATeam_t.DOTA_TEAM_BADGUYS);

	$.Schedule(10, OverrideDotaTopBar);
}

(function () {
	OverrideDotaTopBar();
})();