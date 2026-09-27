--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_werewolf_bloodrage", "abilities/creeps_lane/npc_werewolf_bloodrage", LUA_MODIFIER_MOTION_NONE)

npc_werewolf_bloodrage = class({})

function npc_werewolf_bloodrage:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf", context)
end

function npc_werewolf_bloodrage:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.heal = self:GetLevelSpecialValueFor("heal", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
end

function npc_werewolf_bloodrage:OnAbilityPhaseStart()
	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self.caster:EmitSound("hero_bloodseeker.bloodRage")
	return true
end

function npc_werewolf_bloodrage:OnSpellStart()
	self.caster:AddNewModifier(self.caster, self, "modifier_werewolf_bloodrage", { duration = self.duration })
end

modifier_werewolf_bloodrage = class(mod_visible)
function modifier_werewolf_bloodrage:IsPurgable()
	return true
end
function modifier_werewolf_bloodrage:GetEffectName()
	return "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
end
function modifier_werewolf_bloodrage:CheckState()
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
function modifier_werewolf_bloodrage:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.speed
	self.heal = self.ability.heal

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_werewolf_bloodrage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_werewolf_bloodrage:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_werewolf_bloodrage:OnTooltip()
	return self.speed
end

function modifier_werewolf_bloodrage:OnTooltip2()
	return self.heal
end

function modifier_werewolf_bloodrage:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	self.parent:GenericHeal(self.parent:GetMaxHealth() * self.heal / 100, self.ability)
end