--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10208.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10208.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["15"] = "6:1",
		["16"] = "7:14",
		["17"] = "6:1",
		["18"] = "7:38",
		["19"] = "8:5",
		["20"] = "9:9",
		["21"] = "8:5",
		["22"] = "12:5",
		["23"] = "13:9",
		["24"] = "12:5",
		["25"] = "18:5",
		["26"] = "19:9",
		["27"] = "18:5",
		["28"] = "22:5",
		["29"] = "23:16",
		["30"] = "23:16",
		["31"] = "23:16",
		["33"] = "23:16",
		["35"] = "23:16",
		["37"] = "23:9",
		["38"] = "22:5",
		["39"] = "26:5",
		["40"] = "27:9",
		["41"] = "26:5",
		["42"] = "7:14",
		["43"] = "6:2",
		["44"] = "6:2",
		["45"] = "6:19",
		["46"] = "6:2",
		["48"] = "6:2",
		["49"] = "7:14",
		["51"] = "7:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 空城状态：敌方无法指向（自身/友方可指向），附带移速；不显示图标
____exports.sl_modifier_bless_10208 = __TS__Class()
local sl_modifier_bless_10208 = ____exports.sl_modifier_bless_10208
sl_modifier_bless_10208.name = "sl_modifier_bless_10208"
__TS__ClassExtends(sl_modifier_bless_10208, sl_modifier_transmitter_data)
function sl_modifier_bless_10208.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10208.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true }
end
function sl_modifier_bless_10208.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10208.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__params_ys_0 = self._params
	if ____table__params_ys_0 ~= nil then
		____table__params_ys_0 = ____table__params_ys_0.ys
	end
	local ____table__params_ys_0_2 = ____table__params_ys_0
	if ____table__params_ys_0_2 == nil then
		____table__params_ys_0_2 = 0
	end
	return ____table__params_ys_0_2
end
function sl_modifier_bless_10208.prototype.GetStatusEffectName(self)
	return BLESS_PARTICLES.bless_10208_shadow_realm
end
sl_modifier_bless_10208 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10208", nil, getfenv()) },
	sl_modifier_bless_10208
)
____exports.sl_modifier_bless_10208 = sl_modifier_bless_10208
return ____exports