--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- global/both/popup_colors.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"global/both/popup_colors.lua",
	{
		["7"] = "4:7",
		["8"] = "6:5",
		["9"] = "8:5",
		["10"] = "10:5",
		["11"] = "12:5",
		["12"] = "14:5",
		["13"] = "16:5",
		["14"] = "18:5",
		["15"] = "20:5",
		["16"] = "22:5",
		["17"] = "24:5",
		["18"] = "26:5",
		["19"] = "28:5",
		["20"] = "4:22",
	}
)
--- 飘字颜色常量
POPUP_COLORS = {
	PHYSICAL_DAMAGE = { r = 255, g = 0, b = 0 },
	MAGICAL_DAMAGE = { r = 0, g = 172, b = 255 },
	DOT_DAMAGE = { r = 215, g = 50, b = 248 },
	HEALING = { r = 0, g = 255, b = 0 },
	GOLD = { r = 255, g = 200, b = 33 },
	MANA = { r = 33, g = 200, b = 255 },
	BLOCK = { r = 255, g = 255, b = 255 },
	CRITICAL = { r = 255, g = 0, b = 0 },
	SPELL_CRITICAL = { r = 0, g = 140, b = 255 },
	MISS = { r = 255, g = 0, b = 0 },
	SPECIAL_PHYSICAL = { r = 255, g = 225, b = 0 },
	EXP = { r = 49, g = 255, b = 204 },
}