--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pvp_ending = class({})

function modifier_pvp_ending:IsHidden()
    return true
end
function modifier_pvp_ending:IsDebuff()
    return false
end
function modifier_pvp_ending:IsPurgable()
    return false
end
function modifier_pvp_ending:GetAttributes()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_pvp_ending:RemoveOnDeath()
    return false
end
function modifier_pvp_ending:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_SILENCED] = true,
    }
end
function modifier_pvp_ending:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end
function modifier_pvp_ending:GetOverrideAnimation()
    return ACT_DOTA_VICTORY
end
function modifier_pvp_ending:IsAura()
    return true
end
function modifier_pvp_ending:GetAuraRadius()
    return 3000
end
function modifier_pvp_ending:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_pvp_ending:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_pvp_ending:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end
function modifier_pvp_ending:GetModifierAura()
    return "modifier_pvp_ending_effect"
end
function modifier_pvp_ending:OnCreated()
    local hParent = self:GetParent()
    self.LeavePortParticle = ParticleManager:CreateParticle("particles/items2_fx/teleport_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
    ParticleManager:SetParticleControl(self.LeavePortParticle, 2, Vector(255, 255, 255))
    ParticleManager:SetParticleControl(self.LeavePortParticle, 5, Vector(200, 0, 0))
    EmitSoundOn("Portal.Loop_Disappear", hParent)
end
function modifier_pvp_ending:OnDestroy()
    local hParent = self:GetParent()
    ParticleManager:DestroyParticle(self.LeavePortParticle, true)
    ParticleManager:ReleaseParticleIndex(self.LeavePortParticle)
    self.LeavePortParticle = nil
    StopSoundOn("Portal.Loop_Disappear", hParent)
    EmitSoundOn("Portal.Hero_Appear", hParent)
end

----------------------modifier_pvp_ending_effect------------------
modifier_pvp_ending_effect = class({})
function modifier_pvp_ending_effect:IsHidden()
    return true
end
function modifier_pvp_ending_effect:IsDebuff()
    return false
end
function modifier_pvp_ending_effect:IsPurgable()
    return false
end
function modifier_pvp_ending_effect:GetAttributes()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_pvp_ending_effect:RemoveOnDeath()
    return false
end
function modifier_pvp_ending_effect:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
    }
end