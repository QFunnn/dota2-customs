--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boar_passive", "abilities/creeps_lane/npc_boar_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boar_slow_debuf", "abilities/creeps_lane/npc_boar_slow", LUA_MODIFIER_MOTION_NONE)

npc_boar_slow = class({})

function npc_boar_slow:GetIntrinsicModifierName()
	return "modifier_boar_passive"
end

modifier_boar_passive = class(mod_hidden)
function modifier_boar_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_boar_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_boar_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_boar_slow_debuf",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_boar_slow_debuf = class(mod_visible)
function modifier_boar_slow_debuf:GetTexture()
	return "beastmaster_boar_poison"
end
function modifier_boar_slow_debuf:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_boar_slow_debuf:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_boar_slow_debuf:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_boar_slow_debuf:OnTooltip()
	return self.slow
end