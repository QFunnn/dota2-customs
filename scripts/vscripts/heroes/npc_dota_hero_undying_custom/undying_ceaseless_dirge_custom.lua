--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_ceaseless_dirge_custom", "heroes/npc_dota_hero_undying_custom/undying_ceaseless_dirge_custom", LUA_MODIFIER_MOTION_NONE)

undying_ceaseless_dirge_custom = class({})

function undying_ceaseless_dirge_custom:IsRefreshable()
    return false
end

function undying_ceaseless_dirge_custom:GetCooldown(iLevel)
    return self.BaseClass.GetCooldown(self, iLevel) / self:GetCaster():GetCooldownReduction()
end

function undying_ceaseless_dirge_custom:Spawn()
    if not IsServer() then return end
    self:UseResources(false, false, false, true)
end

function undying_ceaseless_dirge_custom:GetIntrinsicModifierName()
    return "modifier_undying_ceaseless_dirge_custom"
end

function undying_ceaseless_dirge_custom:ReincarnationStart( params )
    local unit = params.unit
    local reincarnate = params.reincarnate
    if reincarnate then
        if GetMapName() == "arena" then
            self:GetCaster():SetRespawnsDisabled(false)
        end
        self:UseResources(true, false, false, true)
        local reincarnation_time = self:GetSpecialValueFor("respawn_delay")
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf", PATTACH_CUSTOMORIGIN, params.unit)
        ParticleManager:SetParticleAlwaysSimulate(particle)
        ParticleManager:SetParticleControl(particle, 0, params.unit:GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, Vector(reincarnation_time, 0, 0))
        ParticleManager:SetParticleControl(particle, 11, Vector(200, 0, 0))
        ParticleManager:ReleaseParticleIndex(particle)
        params.unit:EmitSound("Hero_Undying.RelentlessReturn.Trigger")
        if GameRules:IsDaytime() then
            AddFOWViewer(self:GetCaster():GetTeamNumber(), params.unit:GetAbsOrigin(), 1800, reincarnation_time, true)
        else
            AddFOWViewer(self:GetCaster():GetTeamNumber(), params.unit:GetAbsOrigin(), 800, reincarnation_time, true)
        end
    end
end

modifier_undying_ceaseless_dirge_custom = class({})
function modifier_undying_ceaseless_dirge_custom:RemoveOnDeath() return false end
function modifier_undying_ceaseless_dirge_custom:IsHidden() return true end
function modifier_undying_ceaseless_dirge_custom:IsPurgable() return false end
function modifier_undying_ceaseless_dirge_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_REINCARNATION,                     
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_undying_ceaseless_dirge_custom:ReincarnateTime()
    if IsServer() then
        if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
        if self:GetParent().IS_LOSE_GAME ~= nil then return end
        if self:GetParent():IsRealHero() and self:GetAbility():IsFullyCastable() then
            return self:GetAbility():GetSpecialValueFor("respawn_delay")
        end
        return nil
    end
end

function modifier_undying_ceaseless_dirge_custom:OnDeath(params)
    if not IsServer() then return end
    local unit = params.unit
    local reincarnate = params.reincarnate
    if self:GetParent() ~= unit then return end
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
    if self:GetParent().IS_LOSE_GAME ~= nil then return end
    self:GetAbility():ReincarnationStart( params )
end