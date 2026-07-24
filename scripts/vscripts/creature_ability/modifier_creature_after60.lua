--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if modifier_creature_after60 == nil then
    modifier_creature_after60 = class({})
end
function modifier_creature_after60:GetTexture()
    return "bounty_hunter_track"
end

function modifier_creature_after60:IsHidden()
    return true
end

function modifier_creature_after60:IsDebuff()
    return false
end

function modifier_creature_after60:IsPurgable()
    return false
end

function modifier_creature_after60:IsPurgeException()
    return false
end

function modifier_creature_after60:OnCreated(kv)
    if IsServer() then
        self.pfx = nil
        self:StartIntervalThink(10)
    end
end

function modifier_creature_after60:OnIntervalThink()
    if not IsServer() then
        return
    end
    local hParent = self:GetParent()
    self:SetStackCount(self:GetStackCount() + 1)
    if self:GetStackCount() >= 5 then
        if not self.pfx then
            local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_haste.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
            self.pfx = particleID
        end
        self:AddParticle(self.pfx, true, false, -1, false, false)
        self:StartIntervalThink(-1)
    end
end

function modifier_creature_after60:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
    return funcs
end

function modifier_creature_after60:GetModifierStatusResistanceStacking()
    return 10
end

function modifier_creature_after60:GetModifierMoveSpeedBonus_Constant()
    return self:GetStackCount() * 30
end