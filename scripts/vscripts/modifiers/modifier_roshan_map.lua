--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_roshan_map = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_MODEL_CHANGE,
            MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        }
    end,

    GetModifierModelChange  = function (self)
        return self.Model or ""
    end,

    GetDisableAutoAttack    = function (self)
        return 1
    end,

    CheckState              = function (self)
        return {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_UNTARGETABLE] = true,
            [MODIFIER_STATE_DISARMED] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        }
    end
})

function modifier_roshan_map:OnCreated(table)
    if not IsServer() then return end

    self.Model = table.model
    self.Fx = table.effect

    if self.Fx ~= "" then
        local fx = ParticleManager:CreateParticle(self.Fx, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        self:AddParticle(fx, false, false, -1, false, false)
    end
end