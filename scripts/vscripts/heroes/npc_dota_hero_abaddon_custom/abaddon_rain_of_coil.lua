--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abaddon_rain_of_coil", "heroes/npc_dota_hero_abaddon_custom/abaddon_rain_of_coil", LUA_MODIFIER_MOTION_NONE)

abaddon_rain_of_coil = class({})

function abaddon_rain_of_coil:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("count") * self:GetSpecialValueFor("interval")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_abaddon_rain_of_coil", {duration = duration})
end

modifier_abaddon_rain_of_coil = class({})

function modifier_abaddon_rain_of_coil:IsPurgable() return false end

function modifier_abaddon_rain_of_coil:OnCreated()
    if not IsServer() then return end
    EmitSoundOn("Hero_Abaddon.AphoticShield.Loop", self:GetParent())
    local interval = self:GetAbility():GetSpecialValueFor("interval")
    self.particle = ParticleManager:CreateParticle("particles/abaddon/abaddon_rain_of_coil.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( self.particle, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetSpecialValueFor("radius")))
	self:AddParticle(self.particle, false, false, -1, false, false)
    self:StartIntervalThink(interval)
end

function modifier_abaddon_rain_of_coil:OnDestroy()
    if not IsServer() then return end
    StopSoundOn("Hero_Abaddon.AphoticShield.Loop", self:GetParent())
end

function modifier_abaddon_rain_of_coil:OnIntervalThink()
    if not IsServer() then return end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    if #units > 0 then
        local abaddon_death_coil_custom = self:GetCaster():FindAbilityByName("abaddon_death_coil_custom")
        if abaddon_death_coil_custom and abaddon_death_coil_custom:GetLevel() > 0 then
            local target = units[1]
            abaddon_death_coil_custom:CastTarget(target)
            if self:GetCaster():HasModifier("modifier_abaddon_15") then
                local radius = abaddon_death_coil_custom.modifier_abaddon_15_radius
                if self:GetCaster():HasModifier("modifier_abaddon_16") then
                    radius = radius + abaddon_death_coil_custom.modifier_abaddon_16[self:GetCaster():GetTalentLevel("modifier_abaddon_16")]
                end
                local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
                for _, unit in pairs(units) do
                    if unit ~= target then
                        abaddon_death_coil_custom:CastTarget(unit)
                    end
                end
            end
        end
    end
end