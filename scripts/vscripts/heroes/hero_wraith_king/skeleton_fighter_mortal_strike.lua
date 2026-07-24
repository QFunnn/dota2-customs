--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_fighter_mortal_strike", "heroes/hero_wraith_king/skeleton_fighter_mortal_strike.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if skeleton_fighter_mortal_strike == nil then
	skeleton_fighter_mortal_strike = class({})
end
function skeleton_fighter_mortal_strike:GetIntrinsicModifierName()
	return "modifier_skeleton_fighter_mortal_strike"
end
---------------------------------------------------------------------
--Modifiers
if modifier_skeleton_fighter_mortal_strike == nil then
	modifier_skeleton_fighter_mortal_strike = class({})
end
function modifier_skeleton_fighter_mortal_strike:IsDebuff(params)
	return false
end
function modifier_skeleton_fighter_mortal_strike:IsHidden(params)
	return true
end
function modifier_skeleton_fighter_mortal_strike:IsPurgable(params)
	return false
end
function modifier_skeleton_fighter_mortal_strike:OnCreated(params)
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
	if IsServer() then
	end
end
function modifier_skeleton_fighter_mortal_strike:OnRefresh(params)
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
	if IsServer() then
	end
end
function modifier_skeleton_fighter_mortal_strike:OnDestroy()
	if IsServer() then
	end
end
function modifier_skeleton_fighter_mortal_strike:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	}
end
function modifier_skeleton_fighter_mortal_strike:OnAttack(params)
	local hParent = self:GetParent()
	if hParent == params.attacker and params.record == self.record then
		EmitSoundOn("Hero_SkeletonKing.CriticalStrike", hParent)
		self:GetAbility():UseResources(true, false, true, true)
	end
end
function modifier_skeleton_fighter_mortal_strike:GetModifierPreAttack_CriticalStrike(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsValid(hAbility) and hAbility:GetCooldown(-1) > 0 and hAbility:IsCooldownReady() and self.crit_mult > 0 then
		self.record = params.record
		hParent:FindModifierByName("modifier_skeleton_fighter_plunder_blood").record = params.record
		return self.crit_mult
	else
		return 0
	end
end