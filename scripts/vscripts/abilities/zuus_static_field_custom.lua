--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_zuus_static_field_custom", "abilities/zuus_static_field_custom", LUA_MODIFIER_MOTION_NONE )

zuus_static_field_custom = class({})

function zuus_static_field_custom:GetIntrinsicModifierName()
    return "modifier_zuus_static_field_custom"
end

modifier_zuus_static_field_custom = class({})
function modifier_zuus_static_field_custom:IsHidden() return true end
function modifier_zuus_static_field_custom:IsPurgable() return false end
function modifier_zuus_static_field_custom:IsPurgeException() return false end
function modifier_zuus_static_field_custom:RemoveOnDeath() return false end
function modifier_zuus_static_field_custom:OnCreated()
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_zuus_static_field_custom:OnRefresh()
    self:OnCreated()
end
function modifier_zuus_static_field_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
    }
end
function modifier_zuus_static_field_custom:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.ability:IsItem() then return end
    if params.ability:IsToggle() then return end
    if params.ability:GetCooldown(params.ability:GetLevel()) <= 0 then return end
    local units = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false)
    for _,unit in pairs(units) do
        local damage = unit:GetHealth() / 100 * self.damage
        local damageTable = {victim = unit, attacker = self:GetParent(), damage = damage, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL}
        ApplyDamage(damageTable)
        unit:EmitSound("Hero_Zuus.ArcLightning.Target")
        local particle = "particles/units/heroes/hero_zuus/zuus_shard_head.vpcf"
        local thunder = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, unit)
        ParticleManager:SetParticleControlEnt(thunder, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(thunder, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(thunder, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_origin", self:GetParent():GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(thunder)
    end
end