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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_clinkz_skeleton_archer_damage_fix = __TS__Class()
local sl_modifier_clinkz_skeleton_archer_damage_fix = ____exports.sl_modifier_clinkz_skeleton_archer_damage_fix
sl_modifier_clinkz_skeleton_archer_damage_fix.name = "sl_modifier_clinkz_skeleton_archer_damage_fix"
__TS__ClassExtends(sl_modifier_clinkz_skeleton_archer_damage_fix, SLModifierBase)
function sl_modifier_clinkz_skeleton_archer_damage_fix.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local modifier = parent:FindModifierByName("modifier_clinkz_burning_army")
	local ____modifier_GetCaster_result_0 = modifier
	if ____modifier_GetCaster_result_0 ~= nil then
		____modifier_GetCaster_result_0 = ____modifier_GetCaster_result_0:GetCaster()
	end
	local owner = ____modifier_GetCaster_result_0
	if not IsValid(owner) then
		return
	end
	local ability = owner:FindAbilityByName("clinkz_wind_walk")
	if not IsValid(ability) then
		return
	end
	local pct = ability:GetSpecialValueFor("damage_percent")
	local ownerAttack = owner:GetAverageTrueAttackDamage(owner)
	local actualBonusDamage = ownerAttack * pct / 100
	local parentDamage = parent:GetAverageTrueAttackDamage(parent)
	self.extraBonusDamage = math.max(0, actualBonusDamage - parentDamage)
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_clinkz_skeleton_archer_damage_fix.prototype.HandleCustomTransmitterData(self, data)
	self.extraBonusDamage = data.extraBonusDamage
end
function sl_modifier_clinkz_skeleton_archer_damage_fix.prototype.AddCustomTransmitterData(self)
	return { extraBonusDamage = self.extraBonusDamage }
end
function sl_modifier_clinkz_skeleton_archer_damage_fix.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
end
function sl_modifier_clinkz_skeleton_archer_damage_fix.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____self_extraBonusDamage_2 = self.extraBonusDamage
	if ____self_extraBonusDamage_2 == nil then
		____self_extraBonusDamage_2 = 0
	end
	return ____self_extraBonusDamage_2
end
sl_modifier_clinkz_skeleton_archer_damage_fix = __TS__Decorate(
	{ registerModifier(nil, "modifiers/fix/sl_modifier_clinkz_skeleton_archer_damage_fix") },
	sl_modifier_clinkz_skeleton_archer_damage_fix
)
____exports.sl_modifier_clinkz_skeleton_archer_damage_fix = sl_modifier_clinkz_skeleton_archer_damage_fix
return ____exports