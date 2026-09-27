--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slardar_armor", "abilities/creeps_lane/npc_slardar_armor", LUA_MODIFIER_MOTION_NONE)

npc_slardar_armor = class({})

function npc_slardar_armor:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf", context)
end

function npc_slardar_armor:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.armor = self:GetLevelSpecialValueFor("armor", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_slardar_armor:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:EmitSound("Hero_Slardar.Amplify_Damage")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_slardar_armor",
		{ duration = self.duration * (1 - target:GetStatusResistance()) }
	)
end

modifier_slardar_armor = class(mod_visible)
function modifier_slardar_armor:IsPurgable()
	return true
end
function modifier_slardar_armor:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.armor = -self.ability.armor

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self.parent:GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		self.parent,
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self.parent:GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		2,
		self.parent,
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self.parent:GetOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, true)

	self:OnRefresh()
end

function modifier_slardar_armor:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_slardar_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_slardar_armor:GetModifierPhysicalArmorBonus()
	return self.armor * self:GetStackCount()
end