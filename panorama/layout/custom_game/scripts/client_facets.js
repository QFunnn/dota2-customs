--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameUI.Facets = {};
let SELECTED_FACETS;

function UpdateSelectedFacets(facets) {
	GameUI.Facets.SetSelectedFacets(facets);
}

GameUI.Facets.IsFacetsLoaded = () => {
	return SELECTED_FACETS != undefined;
};

GameUI.Facets.SetSelectedFacets = (facets) => {
	SELECTED_FACETS = facets;
};

GameUI.Facets.GetFacetID = (player_id) => {
	return SELECTED_FACETS[player_id] || -1;
};

(() => {
	SubscribeToNetTableKey("game_state", "selected_facet_id", UpdateSelectedFacets);
})();