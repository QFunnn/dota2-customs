--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_anchor_smash_lua = class({}) ---@class CDOTA_Modifier_Lua

function modifier_anchor_smash_lua:IsHidden() return self:GetStackCount() <= 0 end
function modifier_anchor_smash_lua:IsPurgable() return false end
function modifier_anchor_smash_lua:RemoveOnDeath() return false end

function modifier_anchor_smash_lua:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    if not IsValidEntity(self.parent) then return end
    if not IsValidEntity(self.ability) then return end

    local attackProc = tonumber(self.ability:GetSpecialValueFor("is_smash_on_attack")) == 1 and true or false
    self.is_smash_on_attack = attackProc
    self.smash_on_attack_chance = self.ability:GetSpecialValueFor("smash_on_attack_chance")
    self.smash_on_attack_cooldown = self.ability:GetSpecialValueFor("smash_on_attack_cooldown")
end

function modifier_anchor_smash_lua:OnRefresh()
    self:OnCreated()
end

function modifier_anchor_smash_lua:GetModifierProcAttack_Feedback(keys)
    if not IsServer() then return end
    if not IsValidEntity(self.ability) then return end
    if not self.is_smash_on_attack then return end

    -- Death Ward bounced attack
    if keys.damage_type == DAMAGE_TYPE_PURE then return end

    if not RollPercentage(self.smash_on_attack_chance) then return end
    if self.parent:HasModifier("modifier_anchor_smash_cooldown_lua") then return end
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_anchor_smash_cooldown_lua", {duration = self.smash_on_attack_cooldown})
    self.ability:OnSpellStart()
end

function modifier_anchor_smash_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    }
end

function modifier_anchor_smash_lua:GetModifierPreAttack_BonusDamage()
    if self.parent.anchor_attack then return self.ability.bonus_damage end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_anchor_smash_cooldown_lua = class({})
LinkLuaModifier("modifier_anchor_smash_cooldown_lua", "heroes/hero_tidehunter/modifier_anchor_smash_lua", LUA_MODIFIER_MOTION_NONE)

function modifier_anchor_smash_cooldown_lua:IsHidden() return true end
function modifier_anchor_smash_cooldown_lua:IsDebuff() return true end
function modifier_anchor_smash_cooldown_lua:IsPurgable() return false end
function modifier_anchor_smash_cooldown_lua:RemoveOnDeath() return true end
function modifier_anchor_smash_cooldown_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
