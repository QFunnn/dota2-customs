--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_special_bonus_cha_ogre_magi = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        }
    end,

    GetModifierPreAttack_BonusDamage = function(self)
        local parent = self:GetParent()
        if parent and parent:HasModifier("modifier_ogre_magi_bloodlust") then
            return self.bonus_damage or 0
        end
        return 0
    end,
})

function modifier_special_bonus_cha_ogre_magi:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.bonus_damage = ability:GetSpecialValueFor("value")
    else
        self.bonus_damage = 40
    end
end