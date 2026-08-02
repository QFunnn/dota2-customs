--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	PERK_MENU: $("#Perks_Menu"),
	TIERS_ROOT: $("#PM_List"),
	SETTINGS_BUTTON: $("#Perks_MapButton_Image"),
	SEARCH_TEXT_ENTRY: $("#Perks_Search_TextEntry"),
};
let PERKS_TIERS = 3;
const CUSTOM_ERROR_TOOLTIP = {
	family_t3: "family_t3_UI_error",
};
function StyleSpecial(v) {
	return `<font color='#4dff4d'><b>${v}</b></font>`;
}
function SpecialsListToPanel(panel, specials, tier) {
	if (!specials) return;

	for (const [k, v] of Object.entries(specials)) {
		if (typeof v == "object") {
			panel.SetDialogVariable(k, StyleSpecial(Math.rd(v[tier], 2)));
		} else panel.SetDialogVariable(k, StyleSpecial(Math.rd(v, 2)));
	}
}
let CACHED_DATA;
let CACHED_PERKS_FOR_SEARCH = [];
function InitPerks(data) {
	if (!HUD.PERK_MENU.IsValid()) return;

	CACHED_DATA = data;

	HUD.TIERS_ROOT.RemoveAndDeleteChildren();

	const is_developer = data.is_developer == 1;
	if (is_developer) PERKS_TIERS = 4;

	HUD.CONTEXT.SwitchClass("max_tiers", `MaxPerksTiers_${PERKS_TIERS}`);

	const local_player_hero = Players.GetPlayerSelectedHero(Players.GetLocalPlayer());
	const forbidden_perks = data.forbidden_perks_by_hero ? data.forbidden_perks_by_hero[local_player_hero] : undefined;

	HUD.CONTEXT.SetDialogVariableLocString("hero_name", local_player_hero);
	const forbidden_tooltip_text = $.Localize("perk_forbidden_for_hero", HUD.CONTEXT);

	for (let tier = 0; tier < PERKS_TIERS; tier++) {
		const tier_root = $.CreatePanel("Panel", HUD.TIERS_ROOT, "");
		tier_root.BLoadLayoutSnippet("Perks_Tier");

		tier_root.SetDialogVariableLocString("perk_tier_header", `game_perk_tolltip_tier_${tier}`);
		tier_root.AddClass(`PerksTier_${tier}`);

		const perks_root = tier_root.FindChildTraverse("Perks_Container");

		const is_available_tier = tier == data.supp_level || is_developer;
		tier_root.SetHasClass("BAvailableTier", is_available_tier);
		if (!is_developer) {
			tier_root.SetHasClass("BOldTier", tier < data.supp_level);
			tier_root.SetHasClass("BLockedTier", tier > data.supp_level);
		}

		const unlock_button = tier_root.FindChildTraverse("UnlockTierBySuppButton");
		unlock_button.SetPanelEvent("onactivate", () => {
			if (tier == 0 || tier == 3) return;

			GameUI.InitiatePaymentFor(`subscription_tier_${tier}`);
		});

		Object.values(data.perks_list).forEach((perk_data) => {
			const perk_name = perk_data.name;
			const perk_panel = $.CreatePanel("Panel", perks_root, `Perk_${perk_name}_tier_${tier}`);
			perk_panel.BLoadLayoutSnippet("Perk");

			const perk_icon = perk_panel.FindChildTraverse("Perk_Image");

			perk_icon.SetImage(`file://{images}/custom_game/perks/icons/${perk_name}_t${Math.min(tier, 2)}.png`);

			perk_panel.SetDialogVariable("perk_name", GetPerkLocName(perk_name, tier + 1));

			SpecialsListToPanel(perk_panel, perk_data, tier + 1);

			let tooltip_text = $.Localize(`${perk_name}_tooltip`, perk_panel);

			const perks_white_list = data.perks_white_list ? data.perks_white_list[perk_name] : undefined;
			if (
				(forbidden_perks && forbidden_perks[perk_name]) ||
				(perks_white_list && !perks_white_list[local_player_hero])
			) {
				perk_panel.enabled = false;
				tooltip_text = `${tooltip_text}<br><br>${forbidden_tooltip_text}`;
			}

			if (perk_name == "family" && tier == 3) perk_panel.enabled = false;

			tooltip_text = tooltip_text.replaceAll("%", StyleSpecial("%"));
			perk_panel.SetPanelEvent("onmouseover", function () {
				const error = CUSTOM_ERROR_TOOLTIP[`${perk_name}_t${tier}`];

				$.DispatchEvent(
					"DOTAShowTextTooltip",
					perk_panel,
					!!error ? $.Localize(error, perk_panel) : tooltip_text,
				);
			});

			if (is_available_tier)
				perk_panel.SetPanelEvent("onactivate", function () {
					GameEvents.SendToServerEnsured("game_perks:set_perk", {
						perk_name: perk_name,
						tier: tier,
					});
					HideGamePerks();
				});

			CACHED_PERKS_FOR_SEARCH.push({
				panel: perk_panel,
				search_token: `${perk_name} || ${GetPerkLocName(perk_name, tier + 1).toLowerCase()}`,
			});
		});
	}
	if (data.current_perk) {
		SetPerk({
			current_perk: data.current_perk,
			perk_tier: data.supp_level,
			specials: data.perks_list[data.current_perk],
		});
	} else $.Schedule(3, ShowGamePerks);
}

function ShowGamePerks() {
	HUD.CONTEXT.SetHasClass("Show", true);
}

function HideGamePerks() {
	HUD.CONTEXT.SetHasClass("Show", false);
}

function ResetSettingButton() {
	HUD.SETTINGS_BUTTON.SetImage("file://{images}/custom_game/perks/perk_button_plus_off.png");
	HUD.SETTINGS_BUTTON.SetPanelEvent("onmouseover", function () {
		$.DispatchEvent("DOTAShowTextTooltip", HUD.SETTINGS_BUTTON, $.Localize("game_perk_choose_hint"));
	});
	HUD.SETTINGS_BUTTON.SetPanelEvent("onactivate", function () {
		ShowGamePerks();
	});
}

function SetPerk(data) {
	if (!data.current_perk) return;

	HUD.SETTINGS_BUTTON.ClearPanelEvent("onactivate");

	HUD.SETTINGS_BUTTON.SetImage(
		`file://{images}/custom_game/perks/icons/${data.current_perk}_t${Math.clamp(data.perk_tier - 1, 0, 2)}.png`,
	);

	SpecialsListToPanel(HUD.SETTINGS_BUTTON, data.specials, data.perk_tier);

	HUD.SETTINGS_BUTTON.SetPanelEvent("onmouseover", function () {
		$.DispatchEvent(
			"DOTAShowTextTooltip",
			HUD.SETTINGS_BUTTON,
			$.Localize(`${data.current_perk}_tooltip`, HUD.SETTINGS_BUTTON),
		);
	});
	HideGamePerks();
	if (HUD.PERK_MENU.IsValid()) HUD.PERK_MENU.DeleteAsync(0);
}
function UpdateServerState(event) {
	const state = event.state;
	HUD.CONTEXT.SwitchClass(`server_state`, `ServerState_${state}`);
	HUD.CONTEXT.SetDialogVariableLocString("server_loading_state_header", `server_loading_state_header_${state}`);
	HUD.CONTEXT.SetDialogVariableLocString("server_loading_state_desc", `server_loading_state_desc_${state}`);
}

function UnlockTierBySupp(type) {
	InitiatePayment(type);
}

function FocusSearchInput() {
	HUD.CONTEXT.SetHasClass("BSearchInputFocus", true);
	HUD.SEARCH_TEXT_ENTRY.SetFocus();
}
function DropSearchInput(skip_drop) {
	HUD.SEARCH_TEXT_ENTRY.text = "";
	HUD.CONTEXT.SetHasClass("BSearchInputFocus", false);
	if (!skip_drop) $.DispatchEvent("DropInputFocus");
}
function OnSearchBlur() {
	if (HUD.SEARCH_TEXT_ENTRY.text == "") DropSearchInput(true);
}
function UpdateSearch() {
	const search_text = HUD.SEARCH_TEXT_ENTRY.text.trim().toLowerCase();

	CACHED_PERKS_FOR_SEARCH.forEach((perk) => {
		perk.panel.visible = perk.search_token.includes(search_text);
	});

	HUD.CONTEXT.SetHasClass("BSearchActive", search_text != "");
}

(function () {
	HUD.CONTEXT.SwitchClass("map_name", MAP_NAME);
	ResetSettingButton();

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("game_perks:set_player_info", InitPerks);
	frame.SubscribeProtected("game_perks:set_perk_client", SetPerk);
	frame.SubscribeProtected("game_perks:update_before_match_state", UpdateServerState);

	GameEvents.SendToServerEnsured("game_perks:get_player_info", {});
	GameEvents.SendToServerEnsured("game_perks:get_before_match_state", {});

	GameUI.Player.RegisterForPlayerDataChanges(() => {
		let new_supp_level = GameUI.Player.GetSubscriptionTier();
		let old_supp_level = CACHED_DATA?.supp_level;
		if (!old_supp_level) return;

		if (new_supp_level == old_supp_level) return;
		CACHED_DATA.supp_level = new_supp_level;
		InitPerks(CACHED_DATA);
	});
})();