--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function RemoveOT3Background() {
	var otBG = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("OT3BG");
	if (otBG) {
		otBG.DeleteAsync(0.1);
	}
}

function OverrideDotaNeutralItemsShop() {
	const shop_grid_1 = FindDotaHudElement("GridNeutralsCategory");
	if (!shop_grid_1) return;

	shop_grid_1.style.overflow = "squish scroll";

	shop_grid_1
		.FindChildTraverse("TeamNeutralItemsTierList")
		.Children()
		.forEach((panel) => {
			panel.FindChild("TierItemsList").style.flowChildren = "right-wrap";
		});
}

function MovePlayerPerformanceContainer() {
	const playerPerformanceContainer = FindDotaHudElement("player_performance_container");
	if (!playerPerformanceContainer) return;
	playerPerformanceContainer.style.marginTop = "13px";
}
function MoveMorphlingBar() {
	const player_info = Game.GetPlayerInfo(Game.GetLocalPlayerID());

	if (!player_info.player_selected_hero) return void $.Schedule(1, MoveMorphlingBar);
	if (player_info.player_selected_hero != "npc_dota_hero_morphling") return;

	const bar = FindDotaHudElement("MorphProgress");
	bar.style.marginLeft = "73px";
}

function UpdateFightRecap() {
	const fight_recap = FindDotaHudElement("FightRecap");
	fight_recap.style.marginTop = `${MAP_NAME == "ot3_necropolis_ffa" ? 75 : 50}px`;
}

function UpdateSidePanelPos() {
	const side_stats = FindDotaHudElement("stackable_side_panels");
	if (side_stats) side_stats.style.marginTop = "28px";
}

function MoveRoshanTimer() {
	const roshan_timer = FindDotaHudElement("RoshanTimer");
	if (!roshan_timer) return void $.Schedule(0.1, MoveRoshanTimer);

	roshan_timer.style.marginBottom = "52px";
	roshan_timer.style.backgroundImage = "url('file://{images}/custom_game/roshan_timer_bg_custom.png');";
	roshan_timer.style.paddingLeft = "-4px";
}
function HideCouriersControl() {
	const shop_launcher_block = FindDotaHudElement("shop_launcher_block");
	if (!shop_launcher_block) return void $.Schedule(1, HideCouriersControl);

	const elements = [
		"SelectCourierHotkey",
		"CourierDeliverHotkey",
		"DeliverItemsButton",
		// "AutoDeliverViolator",
		"OverflowIndicator",
	];
	for (element_name of elements) {
		const panel = shop_launcher_block.FindChildTraverse(element_name);
		if (!panel.visible) continue;
		if (!panel) return void $.Schedule(1, HideCouriersControl);

		panel.visible = false;
	}

	const courier = FindDotaHudElement("courier");
	if (!courier) return void $.Schedule(1, HideCouriersControl);

	for (const p of courier.Children()) if (p.paneltype == "Label") p.DeleteAsync(0);

	$.CreatePanel("Label", courier, "", {
		text: "#global_shop_lower_hud_hint",
		html: true,
		style: StyleObjectToCSSLine({
			align: "center center",
			"text-align": "center",
			"margin-bottom": "1px",
			color: "#b6e3ff",
			"background-color": "rgba(0,0,0,0.6)",
			padding: "2px 20px",
			"font-size": "17px",
			"max-height": "40px",
			"text-overflow": "shrink",
		}),
	});
}
(function () {
	// OverrideDotaNeutralItemsShop();
	RemoveOT3Background();
	// MovePlayerPerformanceContainer();
	MoveMorphlingBar();
	// UpdateFightRecap();
	UpdateSidePanelPos();
	// MoveRoshanTimer();
	HideCouriersControl();

	$.RegisterForUnhandledEvent("DOTAHUDShopClosed", function () {
		dotaHud.RemoveClass("BShopOpen_Custom");
	});

	$.RegisterForUnhandledEvent("DOTAHUDShopOpened", function () {
		dotaHud.AddClass("BShopOpen_Custom");
	});
})();