--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_enhancement_fleetfooted_custom", "items/item_enhancement_fleetfooted_custom", LUA_MODIFIER_MOTION_NONE )

item_enhancement_fleetfooted_custom = class({})

function item_enhancement_fleetfooted_custom:GetIntrinsicModifierName()
    return "modifier_item_enhancement_fleetfooted_custom"
end

modifier_item_enhancement_fleetfooted_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
            MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT
        }
    end
})

function modifier_item_enhancement_fleetfooted_custom:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.move_speed = ability:GetSpecialValueFor("movespeed")
    end
end

function modifier_item_enhancement_fleetfooted_custom:GetModifierMoveSpeedBonus_Special_Boots()
    return self.move_speed
end

function modifier_item_enhancement_fleetfooted_custom:GetModifierIgnoreMovespeedLimit()
    return 1
end