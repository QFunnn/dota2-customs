--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();

const SMART_RANDOM_BUTTON = $("#SmartRandomButton");
const FILTERS = FindDotaHudElement("Filters");
const GRID_CATEGORIES = FindDotaHudElement("GridCategories");

let smart_random_status = false;
let smart_random_heroes = [];

function GetAllHeroCards() {
	return GRID_CATEGORIES.FindChildrenWithClassTraverse("HeroCard");
}

function Activate() {
	if (smart_random_status) {
		GameEvents.SendToServerEnsured("SmartRandom:execute", {});
	}
}

function OnMouseOver() {
	const message = smart_random_status ? "ready" : "no_stats";

	$.DispatchEvent("DOTAShowTextTooltip", SMART_RANDOM_BUTTON, `#smart_random_tooltip_${message}`);

	if (!smart_random_status) return;

	for (const card of GetAllHeroCards()) {
		const short_name = card.FindChildTraverse("HeroImage").heroname;
		const hero_name = `npc_dota_hero_${short_name}`;
		card.SetHasClass("Filtered", !smart_random_heroes.includes(hero_name));
	}
}

function OnMouseOut() {
	$.DispatchEvent("DOTAHideTextTooltip");
	$.DispatchEvent("DOTAHeroGridToggleRecommendedHeroesFilter", FILTERS);
	$.DispatchEvent("DOTAHeroGridToggleRecommendedHeroesFilter", FILTERS);
}

function UpdateSmartRandomStatus(heroes) {
	const is_valid_smart_random_pool = typeof heroes === "object" && Object.values(heroes).length > 0;

	smart_random_status = is_valid_smart_random_pool;

	if (is_valid_smart_random_pool) {
		smart_random_heroes = Object.values(heroes);
	}

	$.Msg("Smart random status: ", is_valid_smart_random_pool);

	SMART_RANDOM_BUTTON.SetHasClass("IsError", !is_valid_smart_random_pool);
}

(function () {
	const hero_pick_right_column = FindDotaHudElement("HeroPickRightColumn");
	SMART_RANDOM_BUTTON.SetParent(hero_pick_right_column);

	UpdateSmartRandomStatus("no_stats");
	SubscribeToNetTableKey("game_state", "smart_random", function (data) {
		UpdateSmartRandomStatus(data[Game.GetLocalPlayerID()]);
	});
})();