--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("npc_arc_knockback_passive", "abilities/creeps_lane/npc_arc_knockback", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("npc_arc_knockback_passive2", "abilities/creeps_lane/npc_arc_knockback", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_knockback", "abilities/creeps_lane/npc_arc_knockback", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_arc_knockback_buf", "abilities/creeps_lane/npc_arc_knockback", LUA_MODIFIER_MOTION_NONE)

npc_arc_knockback = class({})

function npc_arc_knockback:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf",
		context
	)
end

function npc_arc_knockback:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.distance = self:GetLevelSpecialValueFor("distance", 1)
	self.slow = self:GetLevelSpecialValueFor("slow", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_arc_knockback:GetIntrinsicModifierName()
	return "npc_arc_knockback_passive"
end

function npc_arc_knockback:OnSpellStart()
	local point = self.caster:GetAbsOrigin()

	self.caster:EmitSound("Hero_KeeperOfTheLight.BlindingLight")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf",
		PATTACH_POINT_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, Vector(400, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	for _, enemy in pairs(self.caster:FindTargets(400)) do
		local status = 1 - enemy:GetStatusResistance()

		enemy:FacePoint(enemy:GetAbsOrigin() + (enemy:GetAbsOrigin() - point))
		enemy:RemoveModifierByName("modifier_arc_knockback")
		enemy:AddNewModifier(self.caster, self, "modifier_arc_knockback_buf", { duration = self.duration * status })
		enemy:AddNewModifier(self.caster, self, "modifier_arc_knockback", { duration = 0.5 * status })
	end
end

npc_arc_knockback_passive = class(mod_hidden)
function npc_arc_knockback_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:AddNewModifier(self.parent, self.ability, "npc_arc_knockback_passive2", {})
end

function npc_arc_knockback_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function npc_arc_knockback_passive:GetActivityTranslationModifiers()
	return "walk"
end

npc_arc_knockback_passive2 = class(mod_hidden)
function npc_arc_knockback_passive2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function npc_arc_knockback_passive2:GetActivityTranslationModifiers()
	return "fast"
end

modifier_arc_knockback = class(mod_hidden)
function modifier_arc_knockback:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if self.parent:HasModifier("modifier_knockback") then
		return
	end

	local point = self.caster:GetAbsOrigin()
	local vec = self.parent:GetAbsOrigin() - point
	local center = point - vec:Normalized() * (vec:Length2D() + 250)

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_knockback",
		{
			center_x = center.x,
			center_y = center.y,
			center_z = center.z,
			duration = 0.5,
			knockback_duration = 0.5,
			knockback_distance = self.ability.distance,
			knockback_height = 0,
		}
	)
end

function modifier_arc_knockback:OnDestroy()
	if not IsServer() then
		return
	end
	local dir = self.parent:GetAbsOrigin()
	dir.z = 0

	self.parent:FacePoint(self.parent:GetAbsOrigin() + dir:Normalized())
end

modifier_arc_knockback_buf = class(mod_visible)
function modifier_arc_knockback_buf:OnCreated()
	self.ability = self:GetAbility()

	self.slow = -self.ability.slow

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
end

function modifier_arc_knockback_buf:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_arc_knockback_buf:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_arc_knockback_buf:OnTooltip()
	return self.slow
end