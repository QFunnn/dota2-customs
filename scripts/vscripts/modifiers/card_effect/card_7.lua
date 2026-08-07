--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/card_effect/card_7.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["5"] = 6,
		["6"] = 6,
		["7"] = 26,
		["8"] = 26,
		["9"] = 1,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["14"] = 4,
		["15"] = 4,
		["17"] = 4,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
	}
)
function card_7(self) end
function modifier_card_7(self) end
LinkLuaModifier("modifier_card_7", "modifiers/card_effect/card_7.lua", LUA_MODIFIER_MOTION_NONE)
Abilities = Abilities - 1
if card_7 == ____nil then
	local f = ____then
end
____class_0 = d()
____class_0.name = ""
function ____class_0.prototype.____constructor(self) end
card_7 = ____class_0(nil, {})
local f = ____end
local f = f
return "modifier_card_7"