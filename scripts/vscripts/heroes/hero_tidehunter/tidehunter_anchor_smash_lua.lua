--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tidehunter_anchor_smash_lua = class({}) ---@class tidehunter_anchor_smash_lua : CDOTA_Ability_Lua
LinkLuaModifier("modifier_anchor_smash_lua", "heroes/hero_tidehunter/modifier_anchor_smash_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_anchor_smash_reduction_lua", "heroes/hero_tidehunter/modifier_anchor_smash_reduction_lua",
    LUA_MODIFIER_MOTION_NONE)

function tidehunter_anchor_smash_lua:GetIntrinsicModifierName()
    return "modifier_anchor_smash_lua"
end

function tidehunter_anchor_smash_lua:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function tidehunter_anchor_smash_lua:OnAbilityUpgrade(ability)
    if ability:GetAbilityName() == "tidehunter_kraken_shell" then
        local modifier = ability:GetCaster():FindModifierByName("modifier_tidehunter_kraken_shell")
        if modifier then modifier:SetStackCount(self.kills or 0) end
    end
end

function tidehunter_anchor_smash_lua:OnSpellStart(...)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local position = caster:GetAbsOrigin()

    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("reduction_duration")
    local delay = self:GetSpecialValueFor("attack_delay")

    self.bonus_damage = self:GetSpecialValueFor("attack_damage")

    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(),
        position,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_CLOSEST,
        false
    )

    for i, enemy in pairs(enemies) do
        Timers:CreateTimer(delay * i, function()
            if not enemy or enemy:IsNull() then return end
            if enemy:IsAttackImmune() or enemy:IsInvulnerable() then return end
            if not enemy:IsAlive() then return end
            -- setting flags for bonus damage properties to work properly
            caster.anchor_attack = true
            caster:PerformAttack(enemy, true, true, true, true, true, false, false)
            caster.anchor_attack = false
        end)
        -- apply modifier immediately, damage is delayed for perf reasons
        if not enemy:IsMagicImmune() then
            enemy:AddNewModifier(caster, self, "modifier_anchor_smash_reduction_lua", { duration = duration })
        end
    end
    local particle_name = ParticleManager:GetParticleReplacement(
    "particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf", caster)
    local particle = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, position)
    ParticleManager:ReleaseParticleIndex(particle)

    caster:EmitSound("Hero_Tidehunter.AnchorSmash")
end