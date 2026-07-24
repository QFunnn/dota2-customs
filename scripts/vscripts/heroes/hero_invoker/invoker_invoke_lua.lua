--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_invoker_invoke_lua", "heroes/hero_invoker/invoker_invoke_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if invoker_invoke_lua == nil then
	invoker_invoke_lua = class({})
end
function invoker_invoke_lua:GetIntrinsicModifierName()
	return "modifier_invoker_invoke_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_invoker_invoke_lua == nil then
	modifier_invoker_invoke_lua = class({})
end
function modifier_invoker_invoke_lua:IsHidden()
	return false
end
function modifier_invoker_invoke_lua:IsDebuff()
	return false
end
function modifier_invoker_invoke_lua:IsPurgable()
	return false
end
function modifier_invoker_invoke_lua:IsPurgeException()
	return false
end
function modifier_invoker_invoke_lua:RemoveOnDeath()
	return false
end
function modifier_invoker_invoke_lua:OnCreated(params)
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.spell_lifesteal = self:GetAbilitySpecialValueFor("spell_lifesteal")
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed")
	self.cooldown_reduction = self:GetAbilitySpecialValueFor("cooldown_reduction")
	self.spell_amp = self:GetAbilitySpecialValueFor("spell_amp")
	if IsServer() then
		local hParent = self:GetParent()
		hParent:CalculateStatBonus(true)
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_POINT_FOLLOW, "attach_orb1", Vector(0, 0, 0), true)
		self:AddParticle(iParticleID, false, false, -1, false, false)
		local iParticleID2 = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID2, 1, hParent, PATTACH_POINT_FOLLOW, "attach_orb2", Vector(0, 0, 0), true)
		self:AddParticle(iParticleID2, false, false, -1, false, false)
		local iParticleID3 = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID3, 1, hParent, PATTACH_POINT_FOLLOW, "attach_orb3", Vector(0, 0, 0), true)
		self:AddParticle(iParticleID3, false, false, -1, false, false)
	end
end
function modifier_invoker_invoke_lua:OnRefresh(params)
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.spell_lifesteal = self:GetAbilitySpecialValueFor("spell_lifesteal")
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed")
	self.cooldown_reduction = self:GetAbilitySpecialValueFor("cooldown_reduction")
	self.spell_amp = self:GetAbilitySpecialValueFor("spell_amp")
	if IsServer() then
		local hParent = self:GetParent()

		hParent:CalculateStatBonus(true)
	end
end
function modifier_invoker_invoke_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_invoker_invoke_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end
function modifier_invoker_invoke_lua:GetModifierBonusStats_Strength()
	return self.all_stats
end
function modifier_invoker_invoke_lua:GetModifierBonusStats_Agility()
	return self.all_stats
end
function modifier_invoker_invoke_lua:GetModifierBonusStats_Intellect()
	return self.all_stats
end
function modifier_invoker_invoke_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed
end
function modifier_invoker_invoke_lua:GetModifierSpellAmplify_Percentage(params)
	if IsServer() then
		local hAbility = params.ability
		if IsValid(hAbility) then
			local sAbilityName = hAbility:GetAbilityName()
			if string.find(sAbilityName, "invoker_") ~= nil then
				return self.spell_amp
			end
		end
	end
end
function modifier_invoker_invoke_lua:GetModifierPercentageCooldown(params)
	local hAbility = params.ability
	if IsValid(hAbility) then
		local sAbilityName = hAbility:GetAbilityName()
		if string.find(sAbilityName, "invoker_") ~= nil then
			return self.cooldown_reduction
		end
	end
end