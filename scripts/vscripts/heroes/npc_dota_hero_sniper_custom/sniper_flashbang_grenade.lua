--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_sniper_flashbang_grenade_debuff", "heroes/npc_dota_hero_sniper_custom/sniper_flashbang_grenade", LUA_MODIFIER_MOTION_BOTH )

sniper_flashbang_grenade = class({})

function sniper_flashbang_grenade:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_snapfire.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_model.vpcf", context )
end

function sniper_flashbang_grenade:GetAOERadius()
    return self:GetSpecialValueFor( "radius" )
end

function sniper_flashbang_grenade:OnSpellStart()
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

function sniper_flashbang_grenade:OnProjectileHit_ExtraData(hTarget, vLocation, table)
    if not IsServer() then return end
    if table.fx then
        ParticleManager:DestroyParticle(table.fx, false)
        ParticleManager:ReleaseParticleIndex(table.fx)
    end
    local radius = self:GetSpecialValueFor("radius")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vLocation, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _,unit in pairs(units) do
        unit:AddNewModifier(self:GetCaster(), self, "modifier_sniper_flashbang_grenade_debuff", {duration = self:GetSpecialValueFor("stun_duration") * (1 - unit:GetStatusResistance())})
    end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, vLocation)
	ParticleManager:SetParticleControl(particle, 1, vLocation)
	ParticleManager:SetParticleControl(particle, 2, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOnLocationWithCaster(vLocation, "Hero_Sniper.ConcussiveGrenade", self:GetCaster())
    EmitSoundOnLocationWithCaster(vLocation, "Hero_KeeperOfTheLight.BlindingLight", self:GetCaster())
end

modifier_sniper_flashbang_grenade_debuff = class({})

function modifier_sniper_flashbang_grenade_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_sniper_flashbang_grenade_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_FIXED_DAY_VISION,
        MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
        MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE,
	}
end

function modifier_sniper_flashbang_grenade_debuff:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

function modifier_sniper_flashbang_grenade_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_sniper_flashbang_grenade_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_sniper_flashbang_grenade_debuff:GetBonusVisionPercentage() 
    return self:GetAbility():GetSpecialValueFor("vision_debuff")
end