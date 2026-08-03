--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100375a") },
	sl_modifier_bless_100375a
)
____exports.sl_modifier_bless_100375a = sl_modifier_bless_100375a
return ____exports