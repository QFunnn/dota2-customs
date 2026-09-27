--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_npc_necro_range_passive",
	"abilities/creeps_lane/npc_necro_range_passive",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_npc_necro_range_slow",
	"abilities/creeps_lane/npc_necro_range_passive",
	LUA_MODIFIER_MOTION_NONE
)

npc_necro_range_passive = class({})

function npc_necro_range_passive:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_manaburn.vpcf", context)
end

function npc_necro_range_passive:GetIntrinsicModifierName()
	return "modifier_npc_necro_range_passive"
end

modifier_npc_necro_range_passive = class(mod_hidden)
function modifier_npc_necro_range_passive:CheckState()
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
function modifier_npc_necro_range_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.mana = self.ability:GetSpecialValueFor("mana") / 100
	self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_npc_necro_range_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_npc_necro_range_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if params.target:IsBuilding() then
		return
	end

	params.target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")
	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_npc_necro_range_slow",
		{ duration = self.ability.slow_duration * (1 - params.target:GetStatusResistance()) }
	)
	params.target:SpendMana(params.target:GetMaxMana() * self.ability.mana, self.ability)
end

modifier_npc_necro_range_slow = class(mod_visible)
function modifier_npc_necro_range_slow:IsPurgable()
	return true
end
function modifier_npc_necro_range_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_npc_necro_range_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_npc_necro_range_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end