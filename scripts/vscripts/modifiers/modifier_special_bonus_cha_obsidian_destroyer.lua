--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_special_bonus_cha_obsidian_destroyer = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        }
    end,

    GetModifierMoveSpeedBonus_Constant = function(self)
        local parent = self:GetParent()
        local mana = parent:GetMana()
        return mana * (self.mana_pct or 0) / 100
    end,
})

function modifier_special_bonus_cha_obsidian_destroyer:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.mana_pct = ability:GetSpecialValueFor("value")
    end
    if IsServer() then
        self:StartIntervalThink(0.5)
    end
end

function modifier_special_bonus_cha_obsidian_destroyer:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():CalculateStatBonus(true)
end