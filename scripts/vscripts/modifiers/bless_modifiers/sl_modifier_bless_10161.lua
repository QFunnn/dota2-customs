--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
--- 10161 层数显示
____exports.sl_modifier_bless_10161 = __TS__Class()
local sl_modifier_bless_10161 = ____exports.sl_modifier_bless_10161
sl_modifier_bless_10161.name = "sl_modifier_bless_10161"
__TS__ClassExtends(sl_modifier_bless_10161, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10161.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10161.prototype.GetTexture(self)
	return "buff/bless/10161"
end
function sl_modifier_bless_10161.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end
function sl_modifier_bless_10161.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_armor_0 = self._params
	if ____table__params_armor_0 ~= nil then
		____table__params_armor_0 = ____table__params_armor_0.armor
	end
	return ____table__params_armor_0 * self:GetStackCount()
end
function sl_modifier_bless_10161.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____table__params_magic_resist_2 = self._params
	if ____table__params_magic_resist_2 ~= nil then
		____table__params_magic_resist_2 = ____table__params_magic_resist_2.magic_resist
	end
	return ____table__params_magic_resist_2 * self:GetStackCount()
end
function sl_modifier_bless_10161.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_10161_debuff
end
sl_modifier_bless_10161 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10161") },
	sl_modifier_bless_10161
)
____exports.sl_modifier_bless_10161 = sl_modifier_bless_10161
return ____exports