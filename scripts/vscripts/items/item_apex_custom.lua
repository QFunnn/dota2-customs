--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_apex_custom", "items/item_apex_custom", LUA_MODIFIER_MOTION_NONE)

item_apex_custom = class({})

function item_apex_custom:GetIntrinsicModifierName()
	return "modifier_item_apex_custom"
end

modifier_item_apex_custom = class({})
function modifier_item_apex_custom:IsPurgable() return false end
function modifier_item_apex_custom:IsHidden() return true end
function modifier_item_apex_custom:RemoveOnDeath() return false end
function modifier_item_apex_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_apex_custom:GetModifierBonusStats_Strength()
    if self:GetParent():GetPrimaryAttribute() == 3 then 
        return self:GetAbility():GetSpecialValueFor("stats_all")
    end
    if self:GetParent():GetPrimaryAttribute() == 0 then
        return self:GetAbility():GetSpecialValueFor("primary_stat")
    end
    return self:GetAbility():GetSpecialValueFor("bonus_stats")
end

function modifier_item_apex_custom:GetModifierBonusStats_Agility()
    if self:GetParent():GetPrimaryAttribute() == 3 then 
        return self:GetAbility():GetSpecialValueFor("stats_all")
    end
    if self:GetParent():GetPrimaryAttribute() == 1 then
        return self:GetAbility():GetSpecialValueFor("primary_stat")
    end
    return self:GetAbility():GetSpecialValueFor("bonus_stats")
end

function modifier_item_apex_custom:GetModifierBonusStats_Intellect()
    if self:GetParent():GetPrimaryAttribute() == 3 then 
        return self:GetAbility():GetSpecialValueFor("stats_all")
    end
    if self:GetParent():GetPrimaryAttribute() == 2 then
        return self:GetAbility():GetSpecialValueFor("primary_stat")
    end
    return self:GetAbility():GetSpecialValueFor("bonus_stats")
end