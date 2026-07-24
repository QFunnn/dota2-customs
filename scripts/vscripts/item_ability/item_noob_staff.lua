--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_noob_staff", "item_ability/item_noob_staff.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_noob_staff == nil then
    item_noob_staff = class({})
end
function item_noob_staff:GetIntrinsicModifierName()
    return "modifier_item_noob_staff"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_noob_staff == nil then
    modifier_item_noob_staff = class({})
end
function modifier_item_noob_staff:IsHidden()
    return true
end
function modifier_item_noob_staff:IsDebuff()
    return false
end
function modifier_item_noob_staff:IsPurgable()
    return false
end
function modifier_item_noob_staff:IsPurgeException()
    return false
end
function modifier_item_noob_staff:OnCreated(params)
    self.manacost_reduction = self:GetAbilitySpecialValueFor("manacost_reduction")
    self.magic_crit_pct = self:GetAbilitySpecialValueFor("magic_crit_pct")
    self.magic_crit_damage = self:GetAbilitySpecialValueFor("magic_crit_damage")
    if IsServer() then
        local name = self:GetName()
        local hParent = self:GetParent()
        local buffs = hParent:FindAllModifiersByName(name)

        if self == buffs[1] then
            AddCustomModifierEvent(self, "MODIFIER_EVENT_ON_MAGICAL_CRIT")
            AddCustomModifierProps(self, "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE")
        end
    end
end
function modifier_item_noob_staff:OnRefresh(params)
    self.manacost_reduction = self:GetAbilitySpecialValueFor("manacost_reduction")
    self.magic_crit_pct = self:GetAbilitySpecialValueFor("magic_crit_pct")
    self.magic_crit_damage = self:GetAbilitySpecialValueFor("magic_crit_damage")
    if IsServer() then
    end
end
function modifier_item_noob_staff:OnDestroy()
    if IsServer() then
        RemoveCustomModifierEvent(self, "MODIFIER_EVENT_ON_MAGICAL_CRIT")
        RemoveCustomModifierProps(self, "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE")
    end
end
function modifier_item_noob_staff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
    }
end
function modifier_item_noob_staff:GetModifierPercentageManacostStacking()
    return self.manacost_reduction
end
-- function modifier_item_noob_staff:GetMagicalCritPercent(params)
--     local name = self:GetName()
--     local hParent = self:GetParent()
--     local hAttacker = params.attacker
--     local hTarget = params.target
--     local buffs = hParent:FindAllModifiersByName(name)
--     local hAbility = self:GetAbility()

--     if self == buffs[1] then
--         if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and hAbility:IsCooldownReady() then
--             return self.magic_crit_pct
--         end
--     end
--     return 0
-- end
function modifier_item_noob_staff:GetModifierMagicalCritDamage(params)
    local name = self:GetName()
    local hParent = self:GetParent()
    local hAttacker = params.attacker
    local hTarget = params.target
    local buffs = hParent:FindAllModifiersByName(name)
    local hAbility = self:GetAbility()

    if self == buffs[1] then
        if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and hAbility:IsCooldownReady() and RandomFloat(0, 100) <= self.magic_crit_pct then
            return self.magic_crit_damage
        end
    end
    return 0
end
function modifier_item_noob_staff:OnMagicalCrit(params)
    local name = self:GetName()
    local hParent = self:GetParent()
    -- local hAttacker = params.attacker
    -- local hTarget = params.target
    local buffs = hParent:FindAllModifiersByName(name)
    local hAbility = self:GetAbility()

    if self == buffs[1] then
        if hAbility and params.crit_buff == self then
            hAbility:StartCooldown(hAbility:GetCooldown(-1) * hParent:GetCooldownReduction())
        end
    end
    return 0
end
function modifier_item_noob_staff:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end