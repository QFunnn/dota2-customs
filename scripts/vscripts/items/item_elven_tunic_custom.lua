--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_elven_tunic_custom", "items/item_elven_tunic_custom", LUA_MODIFIER_MOTION_NONE)

item_elven_tunic_custom = class({})

function item_elven_tunic_custom:GetIntrinsicModifierName()
	return "modifier_item_elven_tunic_custom"
end

modifier_item_elven_tunic_custom = class({})

function modifier_item_elven_tunic_custom:IsHidden() return true end

function modifier_item_elven_tunic_custom:IsPurgable() return false end
function modifier_item_elven_tunic_custom:IsPurgeException() return false end

function modifier_item_elven_tunic_custom:OnCreated()
    self.agility_pct_special = self:GetAbility():GetSpecialValueFor("agility_pct")
    self.agility_pct = 0
    self.evasion = self:GetAbility():GetSpecialValueFor("evasion")
	self.movment = self:GetAbility():GetSpecialValueFor("movment")
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_item_elven_tunic_custom:OnIntervalThink()
    if not IsServer() then return end
    self.agility_pct = 0
    self.agility_pct = self:GetParent():GetAgility() / 100 * self.agility_pct_special
    self:GetParent():CalculateStatBonus(true)
end

function modifier_item_elven_tunic_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_item_elven_tunic_custom:GetModifierBonusStats_Agility(params)
    return self.agility_pct
end

function modifier_item_elven_tunic_custom:GetModifierEvasion_Constant(params)
    return self.evasion
end

function modifier_item_elven_tunic_custom:GetModifierMoveSpeedBonus_Percentage(params)
    return self.movment
end