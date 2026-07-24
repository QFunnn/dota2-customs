--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_player_controller = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX,
        }
    end,

    GetModifierMoveSpeed_AbsoluteMax    = function(self)
        return 800
    end,


    -- GetModifierMoveSpeed_Absolute    = function(self)
    --     return 900
    -- end,

    -- GetModifierMoveSpeed_Limit    = function(self)
    --     return 900
    -- end,

    -- GetModifierMoveSpeed_MaxOverride    = function(self)
    --     return 900
    -- end,
})

-- function modifier_player_controller:GetModifierOverrideAbilitySpecial(event)
--     local ability = event.ability
--     if ability and ability:GetName() == "silencer_glaives_of_wisdom_custom" and event.ability_special_value == "MaxLevel" then
--         print(event.ability_special_value, event.ability_special_level)
--         return 1
--     end
--     return 0
-- end

-- function modifier_player_controller:GetModifierOverrideAbilitySpecialValue(event)
--     print("Value", event.ability_special_value, event.ability_special_level)
--     return 0
-- end