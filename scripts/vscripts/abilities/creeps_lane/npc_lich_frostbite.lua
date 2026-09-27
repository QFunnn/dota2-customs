--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_frostbite", "abilities/creeps_lane/npc_lich_frostbite", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frostbite_death", "abilities/creeps_lane/npc_lich_frostbite", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_blast", "abilities/creeps_lane/npc_lich_frostbite", LUA_MODIFIER_MOTION_NONE)

npc_lich_frostbite = class({})

function npc_lich_frostbite:Precache(context)
	PrecacheResource("particle", "particles/status_fx/status_effect_frost_lich.vpcf", context)
end

function npc_lich_frostbite:GetIntrinsicModifierName()
	return "modifier_lich_frostbite"
end

modifier_lich_frostbite = class(mod_hidden)
function modifier_lich_frostbite:IsPurgable()
	return true
end
function modifier_lich_frostbite:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage_stack = self.ability:GetSpecialValueFor("damage_stack")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
	self.ability.heal = self.ability:GetSpecialValueFor("heal")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.max = self.ability:GetSpecialValueFor("max")
	self.ability.duration_inc = self.ability:GetSpecialValueFor("duration_inc")

	if not IsServer() then
		return
	end
	self.parent:AddDamageEvent_out(self, true)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_lich_frostbite_death", {})
end

function modifier_lich_frostbite:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if not params.inflictor then
		return
	end

	local name = params.inflictor:GetAbilityName()
	if
		name ~= "npc_lich_blast"
		and (name ~= "npc_lich_ulti" or params.unit:GetTeamNumber() == self.parent:GetTeamNumber())
	then
		return
	end

	if not self.duration then
		self.duration = self.ability.duration
			+ (self.parent:GetUpgradeStack("modifier_waveupgrade_boss") - 1) * self.ability.duration_inc
	end

	params.unit:AddNewModifier(self.parent, self.ability, "modifier_lich_blast", { duration = self.duration })
end

modifier_lich_frostbite_death = class(mod_hidden)
function modifier_lich_frostbite_death:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
end

function modifier_lich_frostbite_death:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end

	self.parent:EmitSound("Lich.Death_voice")
end

modifier_lich_blast = class(mod_visible)
function modifier_lich_blast:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end
function modifier_lich_blast:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.heal = -self.ability.heal
	self.slow = -self.ability.slow
	self.max = self.ability.max
	self.damage = self.ability.damage_stack

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self:OnRefresh()
end

function modifier_lich_blast:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
end

function modifier_lich_blast:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_lich_blast:GetModifierHPRegenAmplify_Percentage()
	return self.heal * self:GetStackCount()
end

function modifier_lich_blast:GetModifierHealChange()
	return self.heal * self:GetStackCount()
end

function modifier_lich_blast:GetModifierMoveSpeedBonus_Percentage()
	return self.slow * self:GetStackCount()
end

function modifier_lich_blast:GetModifierIncomingDamage_Percentage(params)
	if IsServer() and params.attacker ~= self.caster then
		return
	end
	return self.damage * self:GetStackCount()
end