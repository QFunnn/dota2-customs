--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warrior_passive", "abilities/creeps_lane/npc_warrior_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warrior_debuff", "abilities/creeps_lane/npc_warrior_passive", LUA_MODIFIER_MOTION_NONE)

npc_warrior_passive = class({})

function npc_warrior_passive:Precache(context)
	PrecacheResource("particle", "particles/items4_fx/spirit_vessel_damage.vpcf", context)
end

function npc_warrior_passive:GetIntrinsicModifierName()
	return "modifier_warrior_passive"
end

modifier_warrior_passive = class(mod_hidden)
function modifier_warrior_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.reduce = self.ability:GetSpecialValueFor("reduce")
	self.ability.max_stacks = self.ability:GetSpecialValueFor("max_stacks")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
end

function modifier_warrior_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_warrior_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	self.parent:EmitSound("Phantom_Assassin.LegendaryPosison")
	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_warrior_debuff",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_warrior_debuff = class(mod_visible)
function modifier_warrior_debuff:IsPurgable()
	return true
end
function modifier_warrior_debuff:GetTexture()
	return "centaur_double_edge"
end
function modifier_warrior_debuff:GetEffectName()
	return "particles/items4_fx/spirit_vessel_damage.vpcf"
end
function modifier_warrior_debuff:OnCreated()
	self.ability = self:GetAbility()

	self.reduce = self.ability.reduce
	self.max = self.ability.max_stacks

	if not IsServer() then
		return
	end
	self:OnRefresh()
end

function modifier_warrior_debuff:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
end

function modifier_warrior_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_warrior_debuff:GetModifierHPRegenAmplify_Percentage()
	return -self.reduce * self:GetStackCount()
end

function modifier_warrior_debuff:GetModifierHealChange()
	return -self.reduce * self:GetStackCount()
end

function modifier_warrior_debuff:OnTooltip()
	return self.reduce * self:GetStackCount()
end