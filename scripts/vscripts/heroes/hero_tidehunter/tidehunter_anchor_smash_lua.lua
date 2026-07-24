--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tidehunter_anchor_smash_lua = class({})
LinkLuaModifier("modifier_anchor_smash_lua", "heroes/hero_tidehunter/modifier_anchor_smash_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_anchor_smash_reduction_lua", "heroes/hero_tidehunter/modifier_anchor_smash_reduction_lua", LUA_MODIFIER_MOTION_NONE)

function tidehunter_anchor_smash_lua:GetIntrinsicModifierName()
    return "modifier_anchor_smash_lua"
end

-- function tidehunter_anchor_smash_lua:GetCooldown(level)
-- 	local totalCooldown = self.BaseClass.GetCooldown(self, level)
-- 	if self:GetCaster():HasShard() then
-- 		totalCooldown = totalCooldown - self:GetSpecialValueFor("shard_cooldown_reduction")
-- 	end
-- 	return totalCooldown
-- end

function tidehunter_anchor_smash_lua:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function tidehunter_anchor_smash_lua:OnSpellStart(...)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local position = caster:GetAbsOrigin()

    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("reduction_duration")
    local delay = self:GetSpecialValueFor("attack_delay")

    local enemies = FindUnitsInRadius(
    caster:GetTeamNumber(),
    position,
    nil,
    radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_NONE,
    FIND_CLOSEST,
    false
    )

    local buff = caster:FindModifierByName("modifier_anchor_smash_lua")

    for i, enemy in pairs(enemies) do
        if IsValid(enemy) then
            if enemy:IsAlive() and (not enemy:IsAttackImmune()) then
                if buff then
                    if buff.units == nil then
                        buff.units = {}
                    end
                    table.insert(buff.units, enemy)
                end
                enemy:AddNewModifier(caster, self, "modifier_anchor_smash_reduction_lua", { duration = duration * enemy:GetStatusResistanceFactor(caster) })
            end
        end
    end
    local particle_name = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf", caster)
    local particle = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, position)
    ParticleManager:ReleaseParticleIndex(particle)

    caster:EmitSound("Hero_Tidehunter.AnchorSmash")
end