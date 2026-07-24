--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_reincarnation_custom", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_reincarnation_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_slow_aura", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_reincarnation_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_slow", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_reincarnation_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_blink", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_reincarnation_custom", LUA_MODIFIER_MOTION_NONE)

skeleton_king_reincarnation_custom = class({})

function skeleton_king_reincarnation_custom:Precache(context) 
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf", context )
    PrecacheResource( "particle", "particles/wk_reincanartion_damage_buff.vpcf", context )
    PrecacheResource( "particle", "particles/wraith_king_blink_effect.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/ti10/blink_dagger_end_ti10.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate_slow_debuff.vpcf", context )
end

function skeleton_king_reincarnation_custom:GetIntrinsicModifierName()
	return "modifier_skeleton_king_reincarnation_custom"
end

function skeleton_king_reincarnation_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():IsIllusion() then return end
    self:EndCooldown()
    self:GetCaster():Kill(self, self:GetCaster())
end

function skeleton_king_reincarnation_custom:ReincarnationStart( params )
    local unit = params.unit
    local reincarnate = params.reincarnate
    if reincarnate then
        if GetMapName() == "arena" then
            self:GetCaster():SetRespawnsDisabled(false)
        end
        self:UseResources(true, false, false, true)
        local reincarnation_time = self:GetSpecialValueFor("reincarnate_time")
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf", PATTACH_CUSTOMORIGIN, params.unit)
        ParticleManager:SetParticleAlwaysSimulate(particle)
        ParticleManager:SetParticleControl(particle, 0, params.unit:GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, Vector(reincarnation_time, 0, 0))
        ParticleManager:SetParticleControl(particle, 11, Vector(200, 0, 0))
        ParticleManager:ReleaseParticleIndex(particle)
        params.unit:EmitSound("Hero_SkeletonKing.Reincarnate")
        if GameRules:IsDaytime() then
            AddFOWViewer(self:GetCaster():GetTeamNumber(), params.unit:GetAbsOrigin(), 1800, reincarnation_time, true)
        else
            AddFOWViewer(self:GetCaster():GetTeamNumber(), params.unit:GetAbsOrigin(), 800, reincarnation_time, true)
        end
        local shard_skeleton_count = self:GetSpecialValueFor("shard_skeleton_count")
        CreateModifierThinker(self:GetCaster(), self, "modifier_skeleton_king_reincarnation_custom_slow_aura", {duration = self:GetSpecialValueFor("slow_duration")}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        local skeleton_king_bone_guard_custom = self:GetCaster():FindAbilityByName("skeleton_king_bone_guard_custom")
        if skeleton_king_bone_guard_custom and skeleton_king_bone_guard_custom:GetLevel() > 0 and not self:GetCaster():HasModifier("modifier_skeleton_king_8") then
            local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("slow_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
            if #units > 0 then
                for i=1, shard_skeleton_count do
                    skeleton_king_bone_guard_custom:CreateSkeleton(self:GetCaster():GetAbsOrigin(), nil, nil, true, unit)
                end     
            end
        end
    end
end

modifier_skeleton_king_reincarnation_custom = class({})
function modifier_skeleton_king_reincarnation_custom:RemoveOnDeath() return false end
function modifier_skeleton_king_reincarnation_custom:IsHidden() return true end
function modifier_skeleton_king_reincarnation_custom:IsPurgable() return false end

function modifier_skeleton_king_reincarnation_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_REINCARNATION,                     
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_skeleton_king_reincarnation_custom:ReincarnateTime()
    if IsServer() then
        if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
        if self:GetParent():HasModifier("modifier_skeleton_king_5") then return nil end
        if self:GetParent().IS_LOSE_GAME ~= nil then return end
        if self:GetParent():IsRealHero() and self:GetAbility():IsFullyCastable() then
            return self:GetAbility():GetSpecialValueFor("reincarnate_time")
        end
        return nil
    end
end

function modifier_skeleton_king_reincarnation_custom:OnDeath(params)
    if not IsServer() then return end
    local unit = params.unit
    local reincarnate = params.reincarnate
    if self:GetParent() ~= unit then return end
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():HasModifier("modifier_skeleton_king_5") then return end
    if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
    if self:GetParent().IS_LOSE_GAME ~= nil then return end
    self:GetAbility():ReincarnationStart( params )
end

modifier_skeleton_king_reincarnation_custom_slow_aura = class({})

function modifier_skeleton_king_reincarnation_custom_slow_aura:IsAura()
    return true
end

function modifier_skeleton_king_reincarnation_custom_slow_aura:GetModifierAura()
    return "modifier_skeleton_king_reincarnation_custom_slow"
end

function modifier_skeleton_king_reincarnation_custom_slow_aura:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("slow_radius")
end

function modifier_skeleton_king_reincarnation_custom_slow_aura:GetAuraDuration()
    return 0
end

function modifier_skeleton_king_reincarnation_custom_slow_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_skeleton_king_reincarnation_custom_slow_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_skeleton_king_reincarnation_custom_slow_aura:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_skeleton_king_reincarnation_custom_slow = class({})
function modifier_skeleton_king_reincarnation_custom_slow:IsHidden() return false end

function modifier_skeleton_king_reincarnation_custom_slow:OnCreated()    
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_reincarnate_slow_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)    
end

function modifier_skeleton_king_reincarnation_custom_slow:DeclareFunctions()
    local decFuncs = 
    {
    	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return decFuncs
end

function modifier_skeleton_king_reincarnation_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_skeleton_king_reincarnation_custom_slow:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attackslow")
end

modifier_skeleton_king_reincarnation_custom_blink = class({})

function modifier_skeleton_king_reincarnation_custom_blink:OnCreated(params)
    if not IsServer() then return end
    self.point = Vector(params.x,params.y,0)
    Timers:CreateTimer(FrameTime(), function()
        self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_DIE, 2)
    end)
end

function modifier_skeleton_king_reincarnation_custom_blink:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
    }
end

function modifier_skeleton_king_reincarnation_custom_blink:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_skeleton_king_reincarnation_custom_blink:GetActivityTranslationModifiers()
    return "reincarnate"
end

function modifier_skeleton_king_reincarnation_custom_blink:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self.point, true)
end