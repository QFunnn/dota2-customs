--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heart_custom", "abilities/items/item_heart_custom", LUA_MODIFIER_MOTION_NONE)

item_heart_custom = class({})

function item_heart_custom:GetIntrinsicModifierName()
return "modifier_item_heart_custom"
end

modifier_item_heart_custom = class({})
function modifier_item_heart_custom:IsHidden() return true end
function modifier_item_heart_custom:IsPurgable() return false end
function modifier_item_heart_custom:RemoveOnDeath() return false end
function modifier_item_heart_custom:GetAttributes()
if test then 
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

end


function modifier_item_heart_custom:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
self.health_regen_pct = self.ability:GetSpecialValueFor("health_regen_pct")
self.health_regen_missing = self.ability:GetSpecialValueFor("health_regen_missing")
self.health = self.ability:GetSpecialValueFor("health")
end

function modifier_item_heart_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_heart_custom:GetModifierHealthBonus()
return self.health
end

function modifier_item_heart_custom:GetModifierBonusStats_Strength()
return self.bonus_strength
end

function modifier_item_heart_custom:GetModifierHealthRegenPercentage()
return self.health_regen_pct + self.health_regen_missing*(1 - self.parent:GetHealthPercent()/100)
end

