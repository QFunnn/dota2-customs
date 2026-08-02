--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("extensions/string")
require("extensions/table")
require("extensions/math")
require("extensions/c_dota_modifier_lua")
require("extensions/c_dota_ability_lua")
require("extensions/c_dota_basenpc")

local OldGetMapName = _G.GetMapName
_G.GetMapName = function()
	local map_name, _ = OldGetMapName():gsub("maps/", ""):gsub(".vpk", "")
	return map_name
end