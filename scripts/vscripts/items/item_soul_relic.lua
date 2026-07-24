--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_soul_relic", "items/item_soul_relic", LUA_MODIFIER_MOTION_NONE)

item_soul_relic = class({})

function item_soul_relic:GetIntrinsicModifierName()
	return "modifier_item_soul_relic"
end

modifier_item_soul_relic = class({})
function modifier_item_soul_relic:IsHidden() return true end
function modifier_item_soul_relic:IsPurgable() return false end
function modifier_item_soul_relic:IsPurgeException() return false end
function modifier_item_soul_relic:RemoveOnDeath() return false end

function modifier_item_soul_relic:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_soul_relic:GetModifierHealthBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("health")
end

function modifier_item_soul_relic:GetModifierManaBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("mana")
end

function modifier_item_soul_relic:GetModifierBonusStats_Strength()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("attribute")
end

function modifier_item_soul_relic:GetModifierBonusStats_Agility()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("attribute")
end

function modifier_item_soul_relic:GetModifierBonusStats_Intellect()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("attribute")
end

function modifier_item_soul_relic:CustomIncreaseModifierDuration()
	return self:GetAbility():GetSpecialValueFor("debuff_increase")
end