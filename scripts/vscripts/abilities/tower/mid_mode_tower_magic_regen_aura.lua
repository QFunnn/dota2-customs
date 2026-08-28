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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_tower_magic_regen_aura = __TS__Class()
local mid_mode_tower_magic_regen_aura = ____exports.mid_mode_tower_magic_regen_aura
mid_mode_tower_magic_regen_aura.name = "mid_mode_tower_magic_regen_aura"
__TS__ClassExtends(mid_mode_tower_magic_regen_aura, BaseAbility)
function mid_mode_tower_magic_regen_aura.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_tower_magic_regen_aura.name
	end
end
function mid_mode_tower_magic_regen_aura.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("aura_radius")
end
mid_mode_tower_magic_regen_aura = __TS__Decorate({ registerAbility(nil) }, mid_mode_tower_magic_regen_aura)
____exports.mid_mode_tower_magic_regen_aura = mid_mode_tower_magic_regen_aura
____exports.modifier_mid_mode_tower_magic_regen_aura = __TS__Class()
local modifier_mid_mode_tower_magic_regen_aura = ____exports.modifier_mid_mode_tower_magic_regen_aura
modifier_mid_mode_tower_magic_regen_aura.name = "modifier_mid_mode_tower_magic_regen_aura"
__TS__ClassExtends(modifier_mid_mode_tower_magic_regen_aura, SLModifierBase)
function modifier_mid_mode_tower_magic_regen_aura.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.IsAura(self)
	return true
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetModifierAura(self)
	return ____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff.name
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraRadius(self)
	return self:GetAbilitySpecialValueFor("aura_radius")
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraOwner(self)
	local ____temp_0 = self:GetParent()
	if ____temp_0 == nil then
		____temp_0 = nil
	end
	return ____temp_0
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraDuration(self)
	return self:GetAbilitySpecialValueFor("sticky_time")
end
modifier_mid_mode_tower_magic_regen_aura = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_magic_regen_aura") },
	modifier_mid_mode_tower_magic_regen_aura
)
____exports.modifier_mid_mode_tower_magic_regen_aura = modifier_mid_mode_tower_magic_regen_aura
____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff = __TS__Class()
local sl_modifier_mid_mode_tower_magic_regen_aura_buff = ____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff
sl_modifier_mid_mode_tower_magic_regen_aura_buff.name = "sl_modifier_mid_mode_tower_magic_regen_aura_buff"
__TS__ClassExtends(sl_modifier_mid_mode_tower_magic_regen_aura_buff, SLModifierBase)
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.IsHidden(self)
	return false
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT, MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE }
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.GetModifierConstantManaRegen(self)
	return self:GetAbilitySpecialValueFor("mana_regen_constant")
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.GetModifierTotalPercentageManaRegen(self)
	return self:GetAbilitySpecialValueFor("mana_regen_total_pct")
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.mid_tower_mana_regen
end
sl_modifier_mid_mode_tower_magic_regen_aura_buff = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_magic_regen_aura") },
	sl_modifier_mid_mode_tower_magic_regen_aura_buff
)
____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff = sl_modifier_mid_mode_tower_magic_regen_aura_buff
return ____exports