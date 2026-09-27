--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lizard_frenzy", "abilities/creeps_neutral/neutral_lizard_frenzy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_lizard_frenzy_aura",
	"abilities/creeps_neutral/neutral_lizard_frenzy",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lizard_frenzy_buff",
	"abilities/creeps_neutral/neutral_lizard_frenzy",
	LUA_MODIFIER_MOTION_NONE
)

neutral_lizard_frenzy = class({})

function neutral_lizard_frenzy:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/thunder_lizard_frenzy.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_has_quest.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_overpower.vpcf", context)
end

function neutral_lizard_frenzy:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_lizard_frenzy"
end

modifier_lizard_frenzy = class(mod_hidden)
function modifier_lizard_frenzy:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.aoe = self.ability:GetSpecialValueFor("aoe")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.heal = self.ability:GetSpecialValueFor("heal") / 100
end

function modifier_lizard_frenzy:StartCast(target)
	if not IsServer() then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.3,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_lizard_frenzy:EndCast()
	if not IsServer() then
		return
	end

	self.parent:EmitSound("n_creep_Thunderlizard_Big.Roar")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_lizard_frenzy_aura",
		{ duration = self.ability.duration }
	)
end

modifier_lizard_frenzy_aura = class(mod_hidden)
function modifier_lizard_frenzy_aura:IsAura()
	return IsServer() and self.parent:IsAlive()
end
function modifier_lizard_frenzy_aura:GetAuraDuration()
	return 0.1
end
function modifier_lizard_frenzy_aura:GetAuraRadius()
	return self.aoe
end
function modifier_lizard_frenzy_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_lizard_frenzy_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_lizard_frenzy_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_lizard_frenzy_aura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.aoe = self.ability.aoe

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/generic_gameplay/generic_has_quest.vpcf", self, true)
end

function modifier_lizard_frenzy_aura:GetModifierAura()
	return "modifier_lizard_frenzy_buff"
end

modifier_lizard_frenzy_buff = class(mod_visible)
function modifier_lizard_frenzy_buff:GetEffectName()
	return "particles/neutral_fx/thunder_lizard_frenzy.vpcf"
end
function modifier_lizard_frenzy_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_overpower.vpcf"
end
function modifier_lizard_frenzy_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end
function modifier_lizard_frenzy_buff:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.speed
	self.heal = self.ability.heal

	if not IsServer() then
		return
	end
	self.parent:AddDamageEvent_out(self, true)
end

function modifier_lizard_frenzy_buff:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if params.inflictor then
		return
	end
	if params.unit:IsBuilding() then
		return
	end

	self.parent:GenericHeal(params.damage * self.heal, self.ability)
end

function modifier_lizard_frenzy_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_lizard_frenzy_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end