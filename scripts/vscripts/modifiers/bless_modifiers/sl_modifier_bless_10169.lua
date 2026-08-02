--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
____exports.sl_modifier_bless_10169 = __TS__Class()
local sl_modifier_bless_10169 = ____exports.sl_modifier_bless_10169
sl_modifier_bless_10169.name = "sl_modifier_bless_10169"
__TS__ClassExtends(sl_modifier_bless_10169, sl_modifier_transmitter_data)
function sl_modifier_bless_10169.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_DEBUFF_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
		[MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
	}
end
function sl_modifier_bless_10169.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL }
end
function sl_modifier_bless_10169.prototype.GetModifierOverrideAbilitySpecial(self, event)
	local ____table__params_event_ability_special_value_0 = self._params
	if ____table__params_event_ability_special_value_0 ~= nil then
		____table__params_event_ability_special_value_0 =
			____table__params_event_ability_special_value_0[event.ability_special_value]
	end
	if ____table__params_event_ability_special_value_0 then
		return 1
	end
	return 0
end
function sl_modifier_bless_10169.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ____table__params_event_ability_special_value_2 = self._params
	if ____table__params_event_ability_special_value_2 ~= nil then
		____table__params_event_ability_special_value_2 =
			____table__params_event_ability_special_value_2[event.ability_special_value]
	end
	return ____table__params_event_ability_special_value_2
end
sl_modifier_bless_10169 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10169") },
	sl_modifier_bless_10169
)
____exports.sl_modifier_bless_10169 = sl_modifier_bless_10169
return ____exports