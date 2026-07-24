--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_psychic_headband_custom", "items/item_psychic_headband_custom", LUA_MODIFIER_MOTION_NONE)

item_psychic_headband_custom = class({})

function item_psychic_headband_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local push_length = self:GetSpecialValueFor("push_length")
	local push_duration = self:GetSpecialValueFor("push_duration")
	target:AddNewModifier(self:GetCaster(), self, "modifier_item_psychic_headband_active", {duration = push_duration, push_length = push_length})
	target:EmitSound("DOTA_Item.ForceStaff.Activate")
end

function item_psychic_headband_custom:GetIntrinsicModifierName()
	return "modifier_item_psychic_headband_custom"
end

modifier_item_psychic_headband_custom = class({})

function modifier_item_psychic_headband_custom:IsHidden() return true end

function modifier_item_psychic_headband_custom:IsPurgable() return false end
function modifier_item_psychic_headband_custom:IsPurgeException() return false end

function modifier_item_psychic_headband_custom:OnCreated()
    self.intelligence_pct = self:GetAbility():GetSpecialValueFor("intelligence_pct")
    self.cast_range = self:GetAbility():GetSpecialValueFor("cast_range")
    self.agility_bonus = 0
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_item_psychic_headband_custom:OnIntervalThink()
    if not IsServer() then return end
    self.agility_bonus = 0
    self.agility_bonus = self:GetParent():GetIntellect(false) / 100 * self.intelligence_pct
    self:GetParent():CalculateStatBonus(true)
end

function modifier_item_psychic_headband_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
    }
end

function modifier_item_psychic_headband_custom:GetModifierBonusStats_Intellect(params)
    return self.agility_bonus
end

function modifier_item_psychic_headband_custom:GetModifierCastRangeBonusStacking(params)
    return self.cast_range
end