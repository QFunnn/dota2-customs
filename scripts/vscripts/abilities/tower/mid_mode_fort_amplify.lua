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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_fort_amplify = __TS__Class()
local mid_mode_fort_amplify = ____exports.mid_mode_fort_amplify
mid_mode_fort_amplify.name = "mid_mode_fort_amplify"
__TS__ClassExtends(mid_mode_fort_amplify, BaseAbility)
function mid_mode_fort_amplify.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_fort_amplify.name
	end
end
mid_mode_fort_amplify = __TS__Decorate({ registerAbility(nil) }, mid_mode_fort_amplify)
____exports.mid_mode_fort_amplify = mid_mode_fort_amplify
____exports.modifier_mid_mode_fort_amplify = __TS__Class()
local modifier_mid_mode_fort_amplify = ____exports.modifier_mid_mode_fort_amplify
modifier_mid_mode_fort_amplify.name = "modifier_mid_mode_fort_amplify"
__TS__ClassExtends(modifier_mid_mode_fort_amplify, SLModifierBase)
function modifier_mid_mode_fort_amplify.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_fort_amplify.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_mid_mode_fort_amplify.prototype.OnCreated(self, params)
	self._weak_time = self:GetAbilitySpecialValueFor("weak_time") * 60
	self._weak_pct = self:GetAbilitySpecialValueFor("weak_pct")
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ____parent_SetBaseMaxHealth_2 = parent.SetBaseMaxHealth
	local ____temp_1 = parent:GetBaseMaxHealth()
	local ____temp_0 = self:GetAbilitySpecialValueFor("health_bonus")
	if ____temp_0 == nil then
		____temp_0 = 0
	end
	____parent_SetBaseMaxHealth_2(parent, ____temp_1 + ____temp_0)
end
function modifier_mid_mode_fort_amplify.prototype._GetWeakPct(self)
	if not self._weak_time or not self._weak_pct then
		return 0
	end
	local game_time = GameRules:GetDOTATime(false, false)
	if game_time <= self._weak_time then
		return 0
	end
	local minutes = math.floor((game_time - self._weak_time) / 60)
	return minutes * self._weak_pct
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetAbilitySpecialValueFor("dmg_res_pct") * -1 + self:_GetWeakPct()
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierConstantHealthRegen(self)
	local ____temp_3 = self:GetAbilitySpecialValueFor("health_regen_bonus")
	if ____temp_3 == nil then
		____temp_3 = 0
	end
	return ____temp_3
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____temp_4 = self:GetAbilitySpecialValueFor("armor_bonus")
	if ____temp_4 == nil then
		____temp_4 = 0
	end
	return ____temp_4
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____temp_5 = self:GetAbilitySpecialValueFor("magic_resist")
	if ____temp_5 == nil then
		____temp_5 = 0
	end
	return ____temp_5
end
modifier_mid_mode_fort_amplify =
	__TS__Decorate({ registerModifier(nil, "abilities/tower/mid_mode_fort_amplify") }, modifier_mid_mode_fort_amplify)
____exports.modifier_mid_mode_fort_amplify = modifier_mid_mode_fort_amplify
return ____exports