--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_treant_large_entangle", "heroes/hero_furion/treant_large_entangle.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_large_entangle_debuff", "heroes/hero_furion/treant_large_entangle.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if treant_large_entangle == nil then
	treant_large_entangle = class({})
end
function treant_large_entangle:GetIntrinsicModifierName()
	return "modifier_treant_large_entangle"
end
---------------------------------------------------------------------
--Modifiers
if modifier_treant_large_entangle == nil then
	modifier_treant_large_entangle = class({})
end
function modifier_treant_large_entangle:IsDebuff()
	return false
end
function modifier_treant_large_entangle:IsHidden()
	return true
end
function modifier_treant_large_entangle:OnCreated(params)
	self.trigger_chance = self:GetAbility():GetSpecialValueFor("trigger_chance")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.attack_damage_pct = self:GetAbility():GetSpecialValueFor("attack_damage_pct")
	if IsServer() then
	end
end
function modifier_treant_large_entangle:OnRefresh(params)
	self.trigger_chance = self:GetAbility():GetSpecialValueFor("trigger_chance")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.attack_damage_pct = self:GetAbility():GetSpecialValueFor("attack_damage_pct")
	if IsServer() then
	end
end
function modifier_treant_large_entangle:OnDestroy()
	if IsServer() then
	end
end
function modifier_treant_large_entangle:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end
function modifier_treant_large_entangle:OnAttackLanded(params)
	local hParent = self:GetParent()
	if params.attacker == hParent then
		if RandomFloat(0, 100) < self.trigger_chance then
			if self:GetAbility():IsCooldownReady() and (not params.target:HasState(MODIFIER_STATE_DEBUFF_IMMUNE)) then
				ApplyDamage({
					attacker = hParent,
					victim = params.target,
					damage = hParent:GetAverageTrueAttackDamage(hParent) * self.attack_damage_pct * 0.01,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility()
				})
				if params.target:IsAlive() then
					params.target:AddNewModifier(hParent, self:GetAbility(), "modifier_treant_large_entangle_debuff", { duration = self.duration })
					if params.target:IsRealHero() then
						self:GetAbility():UseResources(true, false, true, true)
					end
				end
			end
		end
	elseif params.target == hParent then
		if RandomFloat(0, 100) < self.trigger_chance then
			if self:GetAbility():IsCooldownReady() and (not params.attacker:HasState(MODIFIER_STATE_DEBUFF_IMMUNE)) then
				ApplyDamage({
					attacker = hParent,
					victim = params.attacker,
					damage = hParent:GetAverageTrueAttackDamage(hParent) * self.attack_damage_pct * 0.01,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility()
				})
				if params.attacker:IsAlive() then
					params.attacker:AddNewModifier(hParent, self:GetAbility(), "modifier_treant_large_entangle_debuff", { duration = self.duration })
					if params.attacker:IsRealHero() then
						self:GetAbility():UseResources(true, false, true, true)
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_treant_large_entangle_debuff == nil then
	modifier_treant_large_entangle_debuff = class({})
end
function modifier_treant_large_entangle_debuff:IsDebuff()
	return true
end
function modifier_treant_large_entangle_debuff:IsHidden()
	return false
end
function modifier_treant_large_entangle_debuff:OnCreated(params)
	local hParent = self:GetParent()
	EmitSoundOn("LoneDruid_SpiritBear.Entangle", hParent)
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	if IsServer() then
	end
end
function modifier_treant_large_entangle_debuff:OnRefresh(params)
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	if IsServer() then
	end
end
function modifier_treant_large_entangle_debuff:OnDestroy()
	if IsServer() then
	end
end
function modifier_treant_large_entangle_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_treant_large_entangle_debuff:GetEffectName()
	return "particles/units/heroes/hero_treant/treant_overgrowth_vines_small.vpcf"
end
function modifier_treant_large_entangle_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end
function modifier_treant_large_entangle_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.bonus_attack_speed
end