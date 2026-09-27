--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abbadon_passive", "abilities/creeps_lane/npc_abbadon_ulti", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_buff", "abilities/creeps_lane/npc_abbadon_ulti", LUA_MODIFIER_MOTION_NONE)

npc_abbadon_ulti = class({})

function npc_abbadon_ulti:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf", context)
end

function npc_abbadon_ulti:GetIntrinsicModifierName()
	return "modifier_abbadon_passive"
end

modifier_abbadon_passive = class(mod_hidden)
function modifier_abbadon_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.cd = self.ability:GetSpecialValueFor("cd")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.heal = self.ability:GetSpecialValueFor("heal") / 100

	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_abbadon_passive:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end
	if self.parent:HasCd("npc_abbadon_ulti", self.ability.cd) then
		return
	end

	self.parent:EmitSound("Hero_Abaddon.BorrowedTime")
	self.parent:StartCd("npc_abbadon_ulti")
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_abbadon_buff", { duration = self.ability.duration })
end

modifier_abbadon_buff = class(mod_visible)
function modifier_abbadon_buff:GetEffectName()
	return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf"
end
function modifier_abbadon_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf"
end
function modifier_abbadon_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function modifier_abbadon_buff:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
end

function modifier_abbadon_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_abbadon_buff:DamageLogic(params)
	if not IsServer() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return 0
	end
	if not params.attacker then
		return 0
	end

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(particle, 1, params.attacker:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

	self.parent:GenericHeal(params.damage * self.ability.heal, self.ability, true, "")
	return 1
end

function modifier_abbadon_buff:GetAbsoluteNoDamagePhysical(params)
	return self:DamageLogic(params)
end

function modifier_abbadon_buff:GetAbsoluteNoDamageMagical(params)
	return self:DamageLogic(params)
end

function modifier_abbadon_buff:GetAbsoluteNoDamagePure(params)
	return self:DamageLogic(params)
end