--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boar_passive2", "abilities/creeps_lane/npc_boar_slow2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boar_slow_debuf2", "abilities/creeps_lane/npc_boar_slow2", LUA_MODIFIER_MOTION_NONE)

npc_boar_slow2 = class({})

function npc_boar_slow2:GetIntrinsicModifierName()
	return "modifier_boar_passive2"
end

modifier_boar_passive2 = class(mod_hidden)
function modifier_boar_passive2:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_boar_passive2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_boar_passive2:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_boar_slow_debuf2",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_boar_slow_debuf2 = class(mod_visible)
function modifier_boar_slow_debuf2:GetTexture()
	return "beastmaster_boar_poison"
end
function modifier_boar_slow_debuf2:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_boar_slow_debuf2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_boar_slow_debuf2:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_boar_slow_debuf2:OnTooltip()
	return self.slow
end