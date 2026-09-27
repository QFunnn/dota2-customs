--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_frostgolem_slow_passive",
	"abilities/creeps_neutral/neutral_frostgolem_slow",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_neutral_frostgolem_slow_buff",
	"abilities/creeps_neutral/neutral_frostgolem_slow",
	LUA_MODIFIER_MOTION_NONE
)

neutral_frostgolem_slow = class({})

function neutral_frostgolem_slow:Precache(context)
	PrecacheResource("particle", "particles/status_fx/status_effect_frost_lich.vpcf", context)
end

function neutral_frostgolem_slow:GetIntrinsicModifierName()
	return "modifier_neutral_frostgolem_slow_passive"
end

modifier_neutral_frostgolem_slow_passive = class(mod_hidden)
function modifier_neutral_frostgolem_slow_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
	self.ability.heal = self.ability:GetSpecialValueFor("heal")

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_neutral_frostgolem_slow_passive:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_neutral_frostgolem_slow_passive:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not params.target:IsUnit() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_frostgolem_slow_buff",
		{ duration = self.ability.duration }
	)
end

modifier_neutral_frostgolem_slow_buff = class(mod_visible)
function modifier_neutral_frostgolem_slow_buff:IsPurgable()
	return true
end
function modifier_neutral_frostgolem_slow_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end
function modifier_neutral_frostgolem_slow_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_neutral_frostgolem_slow_buff:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.slow = self.ability.slow
	self.heal = self.ability.heal
end

function modifier_neutral_frostgolem_slow_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_neutral_frostgolem_slow_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_neutral_frostgolem_slow_buff:GetModifierHPRegenAmplify_Percentage()
	return self.heal
end

function modifier_neutral_frostgolem_slow_buff:GetModifierHealChange()
	return self.heal
end