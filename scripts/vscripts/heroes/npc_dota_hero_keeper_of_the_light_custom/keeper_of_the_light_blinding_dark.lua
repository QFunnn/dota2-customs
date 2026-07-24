--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


keeper_of_the_light_blinding_dark = class({})
keeper_of_the_light_blinding_dark.modifier_keeper_of_the_light_1 = {120,180}

function keeper_of_the_light_blinding_dark:Precache(context)
    PrecacheResource("particle", "particles/econ/items/keeper_of_the_light/kotl_ti10_immortal/kotl_ti10_blinding_dark.vpcf", context)
end

function keeper_of_the_light_blinding_dark:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function keeper_of_the_light_blinding_dark:OnSpellStart()
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local damage = 0
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_1") then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self.modifier_keeper_of_the_light_1[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_1")])
    end

    EmitSoundOnLocationWithCaster(point, "Hero_KeeperOfTheLight.BlindingLight", self:GetCaster())

    local particle = ParticleManager:CreateParticle("particles/econ/items/keeper_of_the_light/kotl_ti10_immortal/kotl_ti10_blinding_dark.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)	
    for _, enemy in pairs(enemies) do
        if damage > 0 then
            ApplyDamage({victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
        end
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = duration * (1 - enemy:GetStatusResistance())})
    end
end