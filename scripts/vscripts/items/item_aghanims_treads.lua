--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_aghanims_treads", "items/item_aghanims_treads", LUA_MODIFIER_MOTION_NONE )

item_aghanims_treads = class({})

function item_aghanims_treads:GetIntrinsicModifierName()
    return "modifier_item_aghanims_treads"
end

-- function item_aghanims_treads:Spawn()
--     if not IsServer() then return end
--     if self and self:GetSecondaryCharges() == 0 then
--         self:SetSecondaryChazrges(1)
--     end
-- end

-- function item_aghanims_treads:OnSpellStart()
--     if not IsServer() then return end
--     if self:GetSecondaryCharges() == 1 then
--         self:SetSecondaryCharges(2)
--     elseif self:GetSecondaryCharges() == 2 then
--         self:SetSecondaryCharges(3)
--     elseif self:GetSecondaryCharges() == 3 then
--         self:SetSecondaryCharges(1)
--     end
-- 
--     local particle = ParticleManager:CreateParticle("particles/items_fx/power_treads_swap_attributes_effect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
--     ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
--     ParticleManager:SetParticleControl(particle, 1, Vector(self:GetSecondaryCharges()-1, 0, 0))
--     ParticleManager:SetParticleControlEnt(particle, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
--     ParticleManager:ReleaseParticleIndex(particle)
-- 
--     self:GetCaster():CalculateStatBonus(true)
--     self:SetSellable(true)
-- end

modifier_item_aghanims_treads = class({})

function modifier_item_aghanims_treads:OnCreated()
    self.bonus_choose_stat = self:GetAbility():GetSpecialValueFor("bonus_choose_stat")
end

function modifier_item_aghanims_treads:IsHidden() return true end
function modifier_item_aghanims_treads:IsPurgable() return false end
function modifier_item_aghanims_treads:IsPurgeException() return false end
function modifier_item_aghanims_treads:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_aghanims_treads:DeclareFunctions() 
  return 
  {
      MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
      MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
      MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
      MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
      MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
  } 
end

function modifier_item_aghanims_treads:GetModifierBonusStats_Strength()
    return self.bonus_choose_stat
end

function modifier_item_aghanims_treads:GetModifierBonusStats_Agility()
    return self.bonus_choose_stat
end

function modifier_item_aghanims_treads:GetModifierBonusStats_Intellect()
    return self.bonus_choose_stat
end

function modifier_item_aghanims_treads:GetModifierMoveSpeedBonus_Special_Boots()
    return self:GetAbility():GetSpecialValueFor("bonus_movespeed")
end

function modifier_item_aghanims_treads:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end