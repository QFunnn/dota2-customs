--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_golem_aura", "abilities/creeps_neutral/neutral_golem_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_neutral_golem_aura_buff",
	"abilities/creeps_neutral/neutral_golem_aura",
	LUA_MODIFIER_MOTION_NONE
)

neutral_golem_aura = class({})

function neutral_golem_aura:GetIntrinsicModifierName()
	return "modifier_neutral_golem_aura"
end

modifier_neutral_golem_aura = class(mod_hidden)
function modifier_neutral_golem_aura:IsAura()
	return IsServer() and self.parent:IsAlive()
end
function modifier_neutral_golem_aura:GetAuraDuration()
	return 0.1
end
function modifier_neutral_golem_aura:GetAuraRadius()
	return self.ability.radius
end
function modifier_neutral_golem_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_neutral_golem_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_neutral_golem_aura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_neutral_golem_aura:GetModifierAura()
	return "modifier_neutral_golem_aura_buff"
end

modifier_neutral_golem_aura_buff = class(mod_visible)
function modifier_neutral_golem_aura_buff:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.health = self.ability.health
end

function modifier_neutral_golem_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end

function modifier_neutral_golem_aura_buff:GetModifierExtraHealthPercentage()
	return self.health
end