--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spider_passive", "abilities/creeps_lane/npc_spider_passive", LUA_MODIFIER_MOTION_NONE)

npc_spider_passive = class({})

function npc_spider_passive:GetIntrinsicModifierName()
	return "modifier_spider_passive"
end

modifier_spider_passive = class(mod_hidden)
function modifier_spider_passive:OnCreated()
	self.ability = self:GetAbility()

	self.ability.miss = self.ability:GetSpecialValueFor("miss")
	self.ability.magic = self.ability:GetSpecialValueFor("magic")
end

function modifier_spider_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_spider_passive:GetModifierEvasion_Constant()
	return self.ability.miss
end

function modifier_spider_passive:GetModifierMagicalResistanceBonus()
	return self.ability.magic
end