--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_skeleton_aura",
	"abilities/creeps_neutral/neutral_skeleton_aura",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_neutral_skeleton_aura_buff",
	"abilities/creeps_neutral/neutral_skeleton_aura",
	LUA_MODIFIER_MOTION_NONE
)

neutral_skeleton_aura = class({})

function neutral_skeleton_aura:GetIntrinsicModifierName()
	return "modifier_neutral_skeleton_aura"
end

modifier_neutral_skeleton_aura = class(mod_hidden)
function modifier_neutral_skeleton_aura:IsAura()
	return true
end
function modifier_neutral_skeleton_aura:GetAuraDuration()
	return 0.1
end
function modifier_neutral_skeleton_aura:GetAuraRadius()
	return self.ability.radius
end
function modifier_neutral_skeleton_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_neutral_skeleton_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_neutral_skeleton_aura:OnCreated()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_neutral_skeleton_aura:GetModifierAura()
	return "modifier_neutral_skeleton_aura_buff"
end

modifier_neutral_skeleton_aura_buff = class(mod_visible)
function modifier_neutral_skeleton_aura_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_neutral_skeleton_aura_buff:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.damage = self.ability.damage
end

function modifier_neutral_skeleton_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_neutral_skeleton_aura_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage
end