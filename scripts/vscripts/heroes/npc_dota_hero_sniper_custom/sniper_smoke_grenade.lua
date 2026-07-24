--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_sniper_smoke_grenade_debuff", "heroes/npc_dota_hero_sniper_custom/sniper_smoke_grenade", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_sniper_smoke_grenade_thinker", "heroes/npc_dota_hero_sniper_custom/sniper_smoke_grenade", LUA_MODIFIER_MOTION_BOTH )

sniper_smoke_grenade = class({})

function sniper_smoke_grenade:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/boss/riki_smokebomb.vpcf", context )
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_riki.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_model.vpcf", context )
end

function sniper_smoke_grenade:GetAOERadius()
    return self:GetSpecialValueFor( "radius" )
end

function sniper_smoke_grenade:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    local speed = 1200

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_model.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControlEnt(pfx, 0, self:GetCaster(), PATTACH_POINT, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(pfx, 1, Vector(speed,speed,speed))
    ParticleManager:SetParticleControl(pfx, 5, self:GetCursorPosition())

    local options = 
    {
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
        fDistance = distance,
        fStartRadius = 0,
        fEndRadius = 0,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        fExpireTime = GameRules:GetGameTime() + 1.7,
        bDeleteOnHit = false,
        vVelocity = direction * speed,
        bProvidesVision = true,
        iVisionRadius = 10,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
        ExtraData = {fx = pfx}
    }
    self:GetCaster():EmitSound("Hero_Sniper.ConcussiveGrenade.Cast")
    ProjectileManager:CreateLinearProjectile(options)
    -- Grenade cooldown
    if self:GetCaster():HasModifier("modifier_sniper_3") and self:GetCaster():HasModifier("modifier_sniper_10") and self:GetCaster():HasModifier("modifier_sniper_16") and self:GetCaster():HasModifier("modifier_sniper_17") then
        local grenades = 
        {
            "sniper_concussive_grenade_custom",
            "sniper_smoke_grenade",
            "sniper_molotov_grenade",
            "sniper_flashbang_grenade",
        }
        for _, grenade_name in pairs(grenades) do
            local grenade_ability = self:GetCaster():FindAbilityByName(grenade_name)
            if grenade_ability and grenade_ability ~= self then
                local new_cooldown = grenade_ability:GetCooldownTimeRemaining() - 2
                grenade_ability:EndCooldown()
                if new_cooldown > 0 then
                    grenade_ability:StartCooldown(new_cooldown)
                end
            end
        end
    end
end

function sniper_smoke_grenade:OnProjectileHit_ExtraData(hTarget, vLocation, table)
    if not IsServer() then return end
    if table.fx then
        ParticleManager:DestroyParticle(table.fx, false)
        ParticleManager:ReleaseParticleIndex(table.fx)
    end
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    CreateModifierThinker(self:GetCaster(), self, "modifier_sniper_smoke_grenade_thinker", {duration = duration}, vLocation, self:GetCaster():GetTeamNumber(), false)
end

modifier_sniper_smoke_grenade_thinker = class({})
function modifier_sniper_smoke_grenade_thinker:IsPurgable() return false end
function modifier_sniper_smoke_grenade_thinker:IsHidden() return true end
function modifier_sniper_smoke_grenade_thinker:IsAura() return true end
function modifier_sniper_smoke_grenade_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_sniper_smoke_grenade_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_sniper_smoke_grenade_thinker:GetModifierAura() return "modifier_sniper_smoke_grenade_debuff" end
function modifier_sniper_smoke_grenade_thinker:GetAuraRadius() return self.radius end
function modifier_sniper_smoke_grenade_thinker:GetAuraDuration() return 0 end
function modifier_sniper_smoke_grenade_thinker:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.particle = ParticleManager:CreateParticle("particles/boss/riki_smokebomb.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self.radius, self.radius))
    self:AddParticle(self.particle, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_Riki.Smoke_Screen")
end

modifier_sniper_smoke_grenade_debuff = class({})
function modifier_sniper_smoke_grenade_debuff:IsPurgable() return false end
function modifier_sniper_smoke_grenade_debuff:IsDebuff() return true end
function modifier_sniper_smoke_grenade_debuff:OnCreated()
    self.miss_chance = self:GetAbility():GetSpecialValueFor("chance")
end
function modifier_sniper_smoke_grenade_debuff:CheckState()
    return { [MODIFIER_STATE_SILENCED] = true}
end
function modifier_sniper_smoke_grenade_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_MISS_PERCENTAGE }
end
function modifier_sniper_smoke_grenade_debuff:GetModifierMiss_Percentage()
    return self.miss_chance
end