--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_force_platemail", "items/item_force_platemail", LUA_MODIFIER_MOTION_NONE)

item_force_platemail = class({})

function item_force_platemail:GetIntrinsicModifierName()
	return "modifier_item_force_platemail"
end

function item_force_platemail:OnSpellStart()
    if not IsServer() then return end
    
    local target = self:GetCursorTarget()

    if target:TriggerSpellAbsorb(self) then return end
    if target:IsMagicImmune() then return end

    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        target:Purge(false, true, false, false, false)
    end

    target:AddNewModifier(self:GetCaster(), self, "modifier_force_boots_active", {push_length = self:GetSpecialValueFor("push_length"), duration = self:GetSpecialValueFor("push_duration")})
    target:RemoveGesture(ACT_DOTA_DISABLED)
    target:EmitSound("DOTA_Item.ForceStaff.Activate")
end

modifier_item_force_platemail = class({})

function modifier_item_force_platemail:IsHidden() return true end
function modifier_item_force_platemail:IsPurgable() return false end
function modifier_item_force_platemail:IsPurgeException() return false end
function modifier_item_force_platemail:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_force_platemail:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_item_force_platemail:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_force_platemail:GetModifierHealthBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_force_platemail:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_armor")
end