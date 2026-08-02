--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.Facets = {};
let SELECTED_FACETS;
let HERO_FACETS_IDS_BY_NAME = {};

Object.values(HERO_FACETS_WITH_NAMES).forEach((facets) => {
	Object.entries(facets).forEach(([facet_id, facet_data]) => {
		HERO_FACETS_IDS_BY_NAME[facet_data.name] = facet_id;
	});
});

function UpdateSelectedFacets(facets) {
	GameUI.Facets.SetSelectedFacets(facets);
}

GameUI.Facets.IsFacetsLoaded = () => {
	return SELECTED_FACETS != undefined;
};

GameUI.Facets.SetSelectedFacets = (facets) => {
	SELECTED_FACETS = facets;
};

GameUI.Facets.GetFacetName = (player_id) => {
	return SELECTED_FACETS[player_id];
};
GameUI.Facets.GetFacetID = (player_id) => {
	const facet_name = GameUI.Facets.GetFacetName(player_id);

	return parseInt(HERO_FACETS_IDS_BY_NAME[facet_name] || -1);
};

GameUI.Facets.GetUniqueFacetID = (hero_id, facet_id) => {
	if (hero_id > 10000) return hero_id;

	const hero_id_hex = hero_id.toString(16).padStart(2, "0");
	const facet_id_hex = facet_id.toString(16).padStart(2, "0");
	const filler_zeroes = "0".repeat(10 - hero_id_hex.length - facet_id_hex.length);
	return hero_id_hex + filler_zeroes + facet_id_hex;
};

(() => {
	SubscribeToNetTableKey("game_state", "selected_facet_name", UpdateSelectedFacets);
})();