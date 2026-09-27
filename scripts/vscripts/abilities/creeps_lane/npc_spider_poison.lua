--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spider_poison", "abilities/creeps_lane/npc_spider_poison", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spider_debuff", "abilities/creeps_lane/npc_spider_poison", LUA_MODIFIER_MOTION_NONE)

npc_spider_poison = class({})

function npc_spider_poison:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf",
		context
	)
end

function npc_spider_poison:GetIntrinsicModifierName()
	return "modifier_spider_poison"
end

modifier_spider_poison = class(mod_hidden)
function modifier_spider_poison:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.miss = self.ability:GetSpecialValueFor("miss")
end

function modifier_spider_poison:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_spider_poison:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_spider_debuff",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_spider_debuff = class(mod_visible)
function modifier_spider_debuff:IsPurgable()
	return true
end
function modifier_spider_debuff:GetTexture()
	return "broodmother_incapacitating_bite"
end
function modifier_spider_debuff:GetEffectName()
	return "particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf"
end
function modifier_spider_debuff:OnCreated()
	self.ability = self:GetAbility()

	self.miss = self.ability.miss
end

function modifier_spider_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_spider_debuff:GetModifierMiss_Percentage()
	return self.miss
end

function modifier_spider_debuff:OnTooltip()
	return self.miss
end