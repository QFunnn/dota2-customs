--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_enhancement_evolved_custom", "items/item_enhancement_evolved_custom", LUA_MODIFIER_MOTION_NONE )

item_enhancement_evolved_custom = class({})

function item_enhancement_evolved_custom:GetIntrinsicModifierName()
    return "modifier_item_enhancement_evolved_custom"
end

modifier_item_enhancement_evolved_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
            MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
            MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        }
    end
})

function modifier_item_enhancement_evolved_custom:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.all_stats = ability:GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_enhancement_evolved_custom:GetModifierBonusStats_Strength()
    return self.all_stats or 0
end

function modifier_item_enhancement_evolved_custom:GetModifierBonusStats_Agility()
    return self.all_stats or 0
end

function modifier_item_enhancement_evolved_custom:GetModifierBonusStats_Intellect()
    return self.all_stats or 0
end