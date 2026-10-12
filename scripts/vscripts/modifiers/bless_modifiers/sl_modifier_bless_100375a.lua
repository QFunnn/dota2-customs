--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100375a.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100375a.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["15"] = "8:1",
		["16"] = "9:14",
		["17"] = "8:1",
		["18"] = "9:40",
		["19"] = "10:5",
		["20"] = "11:9",
		["21"] = "10:5",
		["22"] = "14:5",
		["23"] = "15:9",
		["24"] = "14:5",
		["25"] = "18:5",
		["26"] = "19:9",
		["27"] = "18:5",
		["28"] = "22:5",
		["29"] = "23:16",
		["30"] = "23:40",
		["31"] = "23:40",
		["32"] = "23:40",
		["34"] = "23:40",
		["36"] = "23:40",
		["38"] = "23:9",
		["39"] = "22:5",
		["40"] = "9:14",
		["41"] = "8:2",
		["42"] = "8:2",
		["43"] = "8:19",
		["44"] = "8:2",
		["46"] = "8:2",
		["47"] = "9:14",
		["49"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 100375a 神圣之怒层数显示
____exports.sl_modifier_bless_100375a = __TS__Class()
local sl_modifier_bless_100375a = ____exports.sl_modifier_bless_100375a
sl_modifier_bless_100375a.name = "sl_modifier_bless_100375a"
__TS__ClassExtends(sl_modifier_bless_100375a, sl_modifier_transmitter_data)
function sl_modifier_bless_100375a.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100375a.prototype.GetTexture(self)
	return "buff/bless/100375a"
end
function sl_modifier_bless_100375a.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_100375a.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____temp_3 = self:GetStackCount()
	local ____table__params_jnzq_per_kill_0 = self._params
	if ____table__params_jnzq_per_kill_0 ~= nil then
		____table__params_jnzq_per_kill_0 = ____table__params_jnzq_per_kill_0.jnzq_per_kill
	end
	local ____table__params_jnzq_per_kill_0_2 = ____table__params_jnzq_per_kill_0
	if ____table__params_jnzq_per_kill_0_2 == nil then
		____table__params_jnzq_per_kill_0_2 = 0
	end
	return ____temp_3 * ____table__params_jnzq_per_kill_0_2
end
sl_modifier_bless_100375a = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100375a", nil, getfenv()) },
	sl_modifier_bless_100375a
)
____exports.sl_modifier_bless_100375a = sl_modifier_bless_100375a
return ____exports