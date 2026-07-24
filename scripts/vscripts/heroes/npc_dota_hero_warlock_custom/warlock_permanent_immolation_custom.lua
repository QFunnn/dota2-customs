--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_permanent_immolation_custom", "heroes/npc_dota_hero_warlock_custom/warlock_permanent_immolation_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_permanent_immolation_custom_debuff", "heroes/npc_dota_hero_warlock_custom/warlock_permanent_immolation_custom", LUA_MODIFIER_MOTION_NONE)

warlock_permanent_immolation_custom = class({})

function warlock_permanent_immolation_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/golem_ambient.vpcf", context)
end

function warlock_permanent_immolation_custom:GetIntrinsicModifierName()
    return "modifier_warlock_permanent_immolation_custom"
end

modifier_warlock_permanent_immolation_custom = class({})
function modifier_warlock_permanent_immolation_custom:IsHidden() return true end
function modifier_warlock_permanent_immolation_custom:IsPurgable() return false end
function modifier_warlock_permanent_immolation_custom:IsPurgeException() return false end
function modifier_warlock_permanent_immolation_custom:RemoveOnDeath() return false end
function modifier_warlock_permanent_immolation_custom:IsAura() return true end
function modifier_warlock_permanent_immolation_custom:IsAuraActiveOnDeath() return false end
function modifier_warlock_permanent_immolation_custom:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_warlock_permanent_immolation_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_warlock_permanent_immolation_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_warlock_permanent_immolation_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_warlock_permanent_immolation_custom:GetModifierAura()	return "modifier_warlock_permanent_immolation_custom_debuff" end
function modifier_warlock_permanent_immolation_custom:GetAuraDuration() return 0 end
function modifier_warlock_permanent_immolation_custom:OnCreated()
    if not IsServer() then return end
    if not self:GetParent():IsHero() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/golem_ambient.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane1", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane2", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane3", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane4", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane5", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 5, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane6", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 6, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane7", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 7, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mane8", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 10, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hand_r", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 11, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hand_l", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 12, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_mouthFire", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, false)
end

modifier_warlock_permanent_immolation_custom_debuff = class({})

function modifier_warlock_permanent_immolation_custom_debuff:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_warlock_permanent_immolation_custom_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_warlock_permanent_immolation_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    local agility = 0
    if self:GetCaster():IsHero() then
        agility = self:GetCaster():GetAgility()
    else
        agility = self:GetCaster():GetOwner():GetAgility()
    end
    damage = damage + agility / 100 * self:GetAbility():GetSpecialValueFor("agility_damage")
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end

warlock_golem_permanent_immolation_custom = class({})

function warlock_golem_permanent_immolation_custom:GetIntrinsicModifierName()
    return "modifier_warlock_permanent_immolation_custom"
end