--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_megacreep_bad_passive", "abilities/creeps_lane/npc_megacreep_debuf", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_megacreep_bad_debuf", "abilities/creeps_lane/npc_megacreep_debuf", LUA_MODIFIER_MOTION_NONE)

npc_megacreep_debuf = class({})

function npc_megacreep_debuf:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", context)
end

function npc_megacreep_debuf:GetIntrinsicModifierName()
	return "modifier_megacreep_bad_passive"
end

modifier_megacreep_bad_passive = class(mod_hidden)
function modifier_megacreep_bad_passive:RemoveOnDeath()
	return false
end
function modifier_megacreep_bad_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.interval = self.ability:GetSpecialValueFor("interval")

	if not IsServer() then
		return
	end
	self.parent:AddDeathEvent(self, true)
end

function modifier_megacreep_bad_passive:DeathEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if params.attacker:IsBuilding() then
		return
	end
	if not params.attacker:IsAlive() then
		return
	end

	params.attacker:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_megacreep_bad_debuf",
		{ duration = self.ability.duration }
	)
end

modifier_megacreep_bad_debuf = class(mod_visible)
function modifier_megacreep_bad_debuf:GetTexture()
	return "doom_bringer_doom"
end
function modifier_megacreep_bad_debuf:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.duration = self.ability.duration
	self.interval = self.ability.interval

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf")
	self:StartIntervalThink(self.interval)
	self:OnRefresh()
end

function modifier_megacreep_bad_debuf:OnRefresh()
	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_DoomBringer.InfernalBlade.PreAttack")
	self:IncrementStackCount()
end

function modifier_megacreep_bad_debuf:OnIntervalThink()
	if not IsServer() then
		return
	end
	local damage = self.parent:GetMaxHealth() * self.damage * self.interval / self.duration / 100 * self:GetStackCount()

	self.parent:GenericParticle("particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf")
	self.parent:EmitSound("Hero_DoomBringer.InfernalBlade.Target")

	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self.ability,
	})
	self.parent:SendNumber(9, damage)
end

function modifier_megacreep_bad_debuf:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_megacreep_bad_debuf:OnTooltip()
	return self:GetStackCount() * self.damage / self.duration / self.interval
end