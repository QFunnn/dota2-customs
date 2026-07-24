--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	CURRENCY_BUTTONS_ROOT: $("#C_TopBar_ButtonsRoot"),
	TABS_ROOT: $("#C_Tabs"),
	CONTENT_ROOT: $("#C_Content"),
	BOOST_CONF_ROOT: $("#PaySubscriptionConf_Root"),
	CURRENCY_BUNDLES_ROOT: $("#C_PayCurrency_Content"),
	SUB_PANELS: $("#C_SubPanels"),
	ADDITIONAL_PANELS: $("#C_AdditionalPanels"),
};
const GetC_Image = (extended_path) => {
	return `file://{images}/custom_game/collection/${extended_path}.png`;
};
const MAX_TIER_SUB = 3;