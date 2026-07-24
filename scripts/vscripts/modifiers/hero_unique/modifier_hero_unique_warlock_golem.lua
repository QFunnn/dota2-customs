--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_warlock_golem = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MODEL_SCALE,
        }
    end,

    GetModifierModelScale = function(self) 
        if self.caster == nil or self.caster:IsNull() then
            return 0
        end

        local Bonus = self.caster:GetLevel() * 1.75
        return -Bonus
    end,

    OnCreated               = function(self)
        self.caster = self:GetCaster()
        self.parent = self:GetParent()

        if not IsServer() then return end

        self:StartIntervalThink(1)
    end,

    OnIntervalThink         = function(self)
        if self.caster == nil or self.caster:IsNull() or self.parent == nil or self.parent:IsNull() or not self.parent:HasModifier("modifier_warlock_rain_of_chaos_golem") then
            self:Destroy()
        end
    end,
})