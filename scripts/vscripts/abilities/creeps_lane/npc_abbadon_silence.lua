--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abbadon_silence_self", "abilities/creeps_lane/npc_abbadon_silence", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_silence", "abilities/creeps_lane/npc_abbadon_silence", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_stack", "abilities/creeps_lane/npc_abbadon_silence", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_speed", "abilities/creeps_lane/npc_abbadon_silence", LUA_MODIFIER_MOTION_NONE)

npc_abbadon_silence = class({})

function npc_abbadon_silence:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_curse_frostmourne_debuff.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_silence.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_frost_buff.vpcf", context)
end

function npc_abbadon_silence:GetIntrinsicModifierName()
	return "modifier_abbadon_silence_self"
end

modifier_abbadon_silence_self = class(mod_hidden)
function modifier_abbadon_silence_self:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.hits = self.ability:GetSpecialValueFor("hits")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.move = self.ability:GetSpecialValueFor("move")

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_abbadon_silence_self:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if params.target:HasModifier("modifier_abbadon_silence") then
		return
	end

	params.target:AddNewModifier(self.parent, self.ability, "modifier_abbadon_stack", { duration = 5 })
end

modifier_abbadon_stack = class(mod_visible)
function modifier_abbadon_stack:IsPurgable()
	return true
end
function modifier_abbadon_stack:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.RemoveForDuel = true

	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.parent
	)
	self:AddParticle(self.particle, false, false, -1, false, true)

	self:OnRefresh()
end

function modifier_abbadon_stack:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))

	if self:GetStackCount() < self.ability.hits then
		return
	end

	self.parent:EmitSound("Hero_Abaddon.Curse.Proc")
	self.parent:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_abbadon_silence",
		{ duration = self.ability.duration * (1 - self.parent:GetStatusResistance()) }
	)
	self:Destroy()
end

modifier_abbadon_silence = class(mod_visible)
function modifier_abbadon_silence:IsPurgable()
	return true
end
function modifier_abbadon_silence:GetEffectName()
	return "particles/units/heroes/hero_abaddon/abaddon_curse_frostmourne_debuff.vpcf"
end
function modifier_abbadon_silence:CheckState()
	return { [MODIFIER_STATE_SILENCED] = true }
end
function modifier_abbadon_silence:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.speed = self.ability.speed

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.parent:GenericParticle("particles/generic_gameplay/generic_silence.vpcf", self, true)
	self.parent:AddAttackEvent_inc(self, true)
end

function modifier_abbadon_silence:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_abbadon_silence:OnTooltip()
	return self.speed
end

function modifier_abbadon_silence:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end

	params.attacker:AddNewModifier(self.caster, self.ability, "modifier_abbadon_speed", { duration = 2 })
end

modifier_abbadon_speed = class(mod_visible)
function modifier_abbadon_speed:GetEffectName()
	return "particles/units/heroes/hero_abaddon/abaddon_frost_buff.vpcf"
end
function modifier_abbadon_speed:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.speed = self.ability.speed
	self.move = self.ability.move
end

function modifier_abbadon_speed:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_abbadon_speed:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_abbadon_speed:GetModifierMoveSpeedBonus_Percentage()
	return self.move
end

function modifier_abbadon_speed:OnTooltip()
	return self.speed
end

function modifier_abbadon_speed:OnTooltip2()
	return self.move
end