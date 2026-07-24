--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_lightning_hands_lua", "heroes/hero_zeus/zuus_lightning_hands_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if zuus_lightning_hands_lua == nil then
	zuus_lightning_hands_lua = class({})
end
function zuus_lightning_hands_lua:GetIntrinsicModifierName()
	return "modifier_zuus_lightning_hands_lua"
end
function zuus_lightning_hands_lua:OnToggle()
end
---------------------------------------------------------------------
--Modifiers
if modifier_zuus_lightning_hands_lua == nil then
	modifier_zuus_lightning_hands_lua = class({})
end
function modifier_zuus_lightning_hands_lua:IsHidden()
	return true
end
function modifier_zuus_lightning_hands_lua:IsDebuff()
	return false
end
function modifier_zuus_lightning_hands_lua:IsPurgable()
	return false
end
function modifier_zuus_lightning_hands_lua:IsPurgeException()
	return false
end
function modifier_zuus_lightning_hands_lua:AllowIllusionDuplicate()
	return true
end
function modifier_zuus_lightning_hands_lua:OnCreated(params)
	self.attack_range_bonus = self:GetAbilitySpecialValueFor("attack_range_bonus")
	if IsServer() then
	end
end
function modifier_zuus_lightning_hands_lua:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_zuus_lightning_hands_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_zuus_lightning_hands_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end
function modifier_zuus_lightning_hands_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hArc = hParent:FindAbilityByName("zuus_arc_lightning_lua")
	local hAbility = self:GetAbility()

	if IsValid(hTarget) and IsValid(hParent) and hTarget:IsAlive() and IsValid(hArc) and IsValid(hAbility) and hAbility:GetToggleState() and hAbility:IsCooldownReady() then
		if hArc:GetLevel() >= 1 then
			hArc:ArcLightning(hTarget, true)
			hAbility:StartCooldown(hAbility:GetEffectiveCooldown(-1))
		end
	end
end
function modifier_zuus_lightning_hands_lua:GetModifierAttackRangeBonus(params)
	return self.attack_range_bonus
end