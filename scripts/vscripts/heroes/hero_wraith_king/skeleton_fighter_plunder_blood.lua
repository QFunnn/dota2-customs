--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_fighter_plunder_blood", "heroes/hero_wraith_king/skeleton_fighter_plunder_blood.lua", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_skeleton_fighter_plunder_blood_debuff", "heroes/hero_wraith_king/skeleton_fighter_plunder_blood.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if skeleton_fighter_plunder_blood == nil then
    skeleton_fighter_plunder_blood = class({})
end
function skeleton_fighter_plunder_blood:GetIntrinsicModifierName()
    return "modifier_skeleton_fighter_plunder_blood"
end
---------------------------------------------------------------------
--Modifiers
if modifier_skeleton_fighter_plunder_blood == nil then
    modifier_skeleton_fighter_plunder_blood = class({})
end
function modifier_skeleton_fighter_plunder_blood:IsDebuff(params)
    return false
end
function modifier_skeleton_fighter_plunder_blood:IsHidden(params)
    return true
end
function modifier_skeleton_fighter_plunder_blood:IsPurgable(params)
    return false
end
function modifier_skeleton_fighter_plunder_blood:OnCreated(params)
    self.max_hp_steal_duration = self:GetAbility():GetSpecialValueFor("max_hp_steal_duration")
    self.max_hp_steal = self:GetAbility():GetSpecialValueFor("max_hp_steal")
    self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
    if IsServer() then
    end
end
function modifier_skeleton_fighter_plunder_blood:OnRefresh(params)
    self.max_hp_steal_duration = self:GetAbility():GetSpecialValueFor("max_hp_steal_duration")
    self.max_hp_steal = self:GetAbility():GetSpecialValueFor("max_hp_steal")
    self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
    if IsServer() then
    end
end
function modifier_skeleton_fighter_plunder_blood:OnDestroy()
    if IsServer() then
    end
end
function modifier_skeleton_fighter_plunder_blood:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end
function modifier_skeleton_fighter_plunder_blood:GetModifierProcAttack_BonusDamage_Pure(params)
    local hParent = self:GetParent()
    if hParent == params.attacker and params.target:IsAlive() then
        local dmg = self.max_hp_steal
        if params.record == self.record then
            dmg = dmg * self.crit_mult * 0.01
        end
        return dmg
    end
end
function modifier_skeleton_fighter_plunder_blood:OnAttackLanded(params)
    local hParent = self:GetParent()
    if IsServer() then
        if hParent == params.attacker then
            if self:GetAbility().cleave then
                DoCleaveAttack(hParent, params.target, self:GetAbility(), params.damage * 0.25, 150, 360, 650, "particles/items_fx/battlefury_cleave.vpcf")
            end
        end
    end
end
---------------------------------------------------------------------
--Modifiers
-- if modifier_skeleton_fighter_plunder_blood_debuff == nil then
--     modifier_skeleton_fighter_plunder_blood_debuff = class({})
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:IsHidden()
--     return false
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:IsDebuff()
--     local hCaster = self:GetCaster()
--     local hParent = self:GetParent()
--     if hCaster == hParent then
--         return false
--     else
--         return true
--     end
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:IsPurgable()
--     return false
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:IsPurgeException()
--     return false
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:OnCreated(params)
--     self.max_hp_steal = self:GetAbility():GetSpecialValueFor("max_hp_steal")
--     if IsServer() then
--         self:SetStackCount(params.stack or 1)
--     end
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:OnRefresh(params)
--     self.max_hp_steal = self:GetAbility():GetSpecialValueFor("max_hp_steal")
--     if IsServer() then
--         self:SetStackCount(self:GetStackCount() + (params.stack or 0))
--     end
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:OnDestroy()
--     if IsServer() then
--     end
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:DeclareFunctions()
--     local hParent = self:GetParent()
--     if hParent:IsHero() then
--         return {
--             MODIFIER_PROPERTY_HEALTH_BONUS,
--         }
--     else
--         return {
--             MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
--         }
--     end

-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:GetModifierExtraHealthBonus()
--     return -self:GetStackCount()
-- end
-- function modifier_skeleton_fighter_plunder_blood_debuff:GetModifierHealthBonus()
--     return -self:GetStackCount()
-- end