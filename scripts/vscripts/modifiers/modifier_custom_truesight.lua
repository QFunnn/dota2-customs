--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_custom_truesight = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,
    IsPermanent             = function(self) return true end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_IGNORE_DODGE + MODIFIER_ATTRIBUTE_PERMANENT end,

    IsAura                  = function(self) return true end,
    GetModifierAura         = function(self) return "modifier_truesight" end,
    GetAuraRadius           = function(self) return self.CustomRadius or 2500 end,
    GetAuraDuration         = function(self) return 0.5 end,
    GetAuraSearchFlags      = function(self) return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end,
    GetAuraSearchTeam       = function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
    GetAuraSearchType       = function(self) return DOTA_UNIT_TARGET_ALL end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        }
    end,

    GetDisableAutoAttack    = function (self)
        return 1
    end,

    CheckState        = function(self)
        return {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_UNTARGETABLE] = true,
            [MODIFIER_STATE_DISARMED] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        }
    end,

    OnCreated               = function(self, table)
        if IsServer() then
            self.CustomRadius = table.radius
        end
    end,
})

-- modifier_custom_truesight_aura = class({
--     IsHidden                = function(self) return false end,
--     IsPurgable              = function(self) return false end,
--     IsPurgeException        = function(self) return false end,
--     IsDebuff                = function(self) return true end,
    
--     GetPriority             = function(self) return 999 end,

-- 	CheckState        = function(self)
--         if self.lock == true then return {} end
--         local parent = self:GetParent()
--         if IsServer() and parent ~= nil and not parent:IsNull() and parent:IsAlive() then
--             self.lock = true
--             local bImmune = parent:IsTruesightImmune()
--             self.lock = false
--             return {
--                 [MODIFIER_STATE_INVISIBLE] = bImmune,
--             }
--         end
--         return {}
--     end,
-- })