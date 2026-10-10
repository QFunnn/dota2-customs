--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abbadon_attack", "abilities/creeps_lane/npc_abbadon_proc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_proc", "abilities/creeps_lane/npc_abbadon_proc", LUA_MODIFIER_MOTION_NONE)

npc_abbadon_proc = class({})

function npc_abbadon_proc:Precache(context)
	PrecacheResource("particle", "particles/generic/generic_armor_reduction.vpcf", context)
end

function npc_abbadon_proc:GetIntrinsicModifierName()
	return "modifier_abbadon_attack"
end

modifier_abbadon_attack = class(mod_hidden)
function modifier_abbadon_attack:RemoveOnDeath()
	return false
end
function modifier_abbadon_attack:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end
	self.parent:AddDeathEvent(self, true)
end

function modifier_abbadon_attack:DeathEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not params.attacker:IsAlive() then
		return
	end

	self.parent:EmitSound("Hero_Visage.SoulAssumption.Cast")
	params.attacker:EmitSound("Hero_Visage.SoulAssumption.Target")
	params.attacker:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_abbadon_proc",
		{ duration = self.ability.duration }
	)
end

modifier_abbadon_proc = class(mod_visible)
function modifier_abbadon_proc:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
	self.damage = self.ability.damage

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.parent:GenericParticle("particles/generic/generic_armor_reduction.vpcf", self, true)
	self:OnRefresh()
end

function modifier_abbadon_proc:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_abbadon_proc:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_abbadon_proc:GetModifierMoveSpeedBonus_Percentage()
	return self.slow * self:GetStackCount()
end

function modifier_abbadon_proc:GetModifierIncomingDamage_Percentage()
	return self.damage * self:GetStackCount()
end