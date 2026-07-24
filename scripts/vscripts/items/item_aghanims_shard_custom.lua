--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_aghanims_shard_custom", "items/item_aghanims_shard_custom", LUA_MODIFIER_MOTION_NONE )

item_aghanims_shard_custom = class({})

function item_aghanims_shard_custom:GetIntrinsicModifierName()
    return "modifier_item_aghanims_shard_custom"
end

function item_aghanims_shard_custom:GetAbilityTextureName()
    if IsClient() then
        if self:GetSecondaryCharges() == 1 then
            return "aghanims_shard_custom_2"
        elseif self:GetSecondaryCharges() == 2 then
            return "item_aghanims_shard_custom"
        elseif self:GetSecondaryCharges() == 3 then
            return "aghanims_shard_custom_1"
        end
    end
end

function item_aghanims_shard_custom:Spawn()
    if not IsServer() then return end
    if self and self:GetSecondaryCharges() == 0 then
        self:SetSecondaryCharges(1)
    end
end

function item_aghanims_shard_custom:OnSpellStart()
    if not IsServer() then return end

    if self:GetSecondaryCharges() == 1 then
        self:SetSecondaryCharges(2)
    elseif self:GetSecondaryCharges() == 2 then
        self:SetSecondaryCharges(3)
    elseif self:GetSecondaryCharges() == 3 then
        self:SetSecondaryCharges(1)
    end
    self:GetCaster():CalculateStatBonus(true)
    self:SetSellable(true)
end

modifier_item_aghanims_shard_custom = class({})

function modifier_item_aghanims_shard_custom:OnCreated()
    self.bonus_choose_stat = self:GetAbility():GetSpecialValueFor("bonus_choose_stat")
end

function modifier_item_aghanims_shard_custom:IsHidden() return true end
function modifier_item_aghanims_shard_custom:IsPurgable() return false end
function modifier_item_aghanims_shard_custom:IsPurgeException() return false end
function modifier_item_aghanims_shard_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_aghanims_shard_custom:DeclareFunctions() 
  return 
  {
      MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
      MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
      MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  } 
end

function modifier_item_aghanims_shard_custom:GetModifierBonusStats_Strength()
    if self:GetAbility():GetSecondaryCharges() == 1 then
        return self.bonus_choose_stat
    end
    return 0
end

function modifier_item_aghanims_shard_custom:GetModifierBonusStats_Agility()
    if self:GetAbility():GetSecondaryCharges() == 3 then
        return self.bonus_choose_stat
    end
    return 0
end

function modifier_item_aghanims_shard_custom:GetModifierBonusStats_Intellect()
    if self:GetAbility():GetSecondaryCharges() == 2 then
        return self.bonus_choose_stat
    end
    return 0
end