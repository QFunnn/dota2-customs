--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_beastmaster_hawk_storm_gathering", "heroes/hero_beastmaster/beastmaster_hawk_storm_gathering.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if beastmaster_hawk_storm_gathering == nil then
	beastmaster_hawk_storm_gathering = class({})
end
function beastmaster_hawk_storm_gathering:GetIntrinsicModifierName()
	return "modifier_beastmaster_hawk_storm_gathering"
end
---------------------------------------------------------------------
--Modifiers
if modifier_beastmaster_hawk_storm_gathering == nil then
	modifier_beastmaster_hawk_storm_gathering = class({})
end
function modifier_beastmaster_hawk_storm_gathering:IsHidden()
	return false
end
function modifier_beastmaster_hawk_storm_gathering:IsDebuff()
	return false
end
function modifier_beastmaster_hawk_storm_gathering:IsPurgable()
	return false
end
function modifier_beastmaster_hawk_storm_gathering:IsPurgeException()
	return false
end
function modifier_beastmaster_hawk_storm_gathering:OnCreated(params)
	self.bonus_base_damage = self:GetAbilitySpecialValueFor("bonus_base_damage")
	self.root_duration = self:GetAbilitySpecialValueFor("root_duration")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	if IsServer() then
	end
end
function modifier_beastmaster_hawk_storm_gathering:OnRefresh(params)
	self.bonus_base_damage = self:GetAbilitySpecialValueFor("bonus_base_damage")
	self.root_duration = self:GetAbilitySpecialValueFor("root_duration")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	if IsServer() then
	end
end
function modifier_beastmaster_hawk_storm_gathering:OnDestroy()
	if IsServer() then
	end
end
function modifier_beastmaster_hawk_storm_gathering:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
end
function modifier_beastmaster_hawk_storm_gathering:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	if IsServer() then
		if IsValid(hParent) and IsValid(hTarget) then
			local iParticleID = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", hParent:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(iParticleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(iParticleID)
			EmitSoundOnLocationWithCaster(hTarget:GetAbsOrigin(), "Hero_razor.Attack", hParent)
			if self:GetStackCount() >= self.max_stack then
				hTarget:AddNewModifier(hParent, hAbility, "modifier_rooted", { duration = self.root_duration * hTarget:GetStatusResistanceFactor(hParent) })
				self:SetStackCount(0)
			else
				self:IncrementStackCount()
			end
		end
	end
end
function modifier_beastmaster_hawk_storm_gathering:GetModifierBaseAttack_BonusDamage()
	return self:GetStackCount() * self.bonus_base_damage
end