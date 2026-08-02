--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/index"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["4"] = 1,
		["5"] = 2,
		["6"] = 3,
		["7"] = 5,
		["8"] = 6,
		["9"] = 7,
		["10"] = 8,
		["11"] = 9,
		["12"] = 10,
		["13"] = 11,
		["14"] = 12,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["19"] = 17,
		["20"] = 18,
		["21"] = 19,
		["22"] = 20,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 28,
		["31"] = 29,
		["32"] = 31,
		["33"] = 32,
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
	}
)
if IsServer() then
	require("class.weight_pool")
	require("class.edmonds_blossom")
	require("mechanics.timer")
	require("mechanics.selection")
	require("mechanics.hpack")
	require("mechanics.notification")
	require("mechanics.demo")
	require("mechanics.ability_upgrades")
	require("mechanics.round")
	require("mechanics.game_state")
	require("mechanics.player_data")
	require("mechanics.ability_shop")
	require("mechanics.projectile")
	require("mechanics.log")
	require("mechanics.match")
	require("mechanics.damage")
	require("mechanics.combatlog")
	require("mechanics.wearable")
	require("mechanics.courier")
	require("mechanics.match_battle")
	require("mechanics.match_battle_new")
	require("mechanics.net_data")
	require("mechanics.cosmetic")
	require("mechanics.privilege")
	require("mechanics.ui_battle_info")
	require("mechanics.city_effect")
	require("mechanics.card_effect")
	require("mechanics.roshan")
	require("mechanics.rune_task")
	require("mechanics.greevil_mode.index")
	require("mechanics.peak_cup")
	require("mechanics.cosmetic_preview_live")
	require("mechanics.team_mode.index")
	require("mechanics.chat")
else
	require("mechanics.timer")
	require("mechanics.ability_upgrades")
	require("mechanics.wearable")
	require("mechanics.city_effect")
end