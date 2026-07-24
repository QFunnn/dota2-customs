--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_orb_effect_lua", "modifiers/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_huskar_burning_spear_custom_debuff", "abilities/huskar_burning_spear_custom", LUA_MODIFIER_MOTION_NONE)

huskar_burning_spear_custom = class({})

function huskar_burning_spear_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf", context )
end

function huskar_burning_spear_custom:GetCastRange(vLocation, hTarget)
    return self:GetCaster():Script_GetAttackRange() + 50
end

function huskar_burning_spear_custom:GetHealthCost(level)
    if IsServer() then return end
    return self:GetSpecialValueFor("health_cost")
end 

function huskar_burning_spear_custom:GetIntrinsicModifierName()
    return "modifier_generic_orb_effect_lua"
end

function huskar_burning_spear_custom:GetProjectileName()
    return "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf"
end

function huskar_burning_spear_custom:OnOrbFire()
    if self:GetCaster():IsSilenced() then return end
    local health_cost = self:GetSpecialValueFor("health_cost")
    self:GetCaster():EmitSound("Hero_Huskar.Burning_Spear.Cast")
    self:GetCaster():SetHealth(math.max(self:GetCaster():GetHealth() - health_cost, 1))
end

function huskar_burning_spear_custom:OnOrbImpact( params )
    self:AttackTarget(params.target)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.target:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        if unit and unit ~= params.target then
            self:AttackTarget(unit)
            break
        end
    end
end

function huskar_burning_spear_custom:AttackTarget(target)
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    target:EmitSound("Hero_Huskar.Burning_Spear")
    target:AddNewModifier(self:GetCaster(), self, "modifier_huskar_burning_spear_custom_debuff", { duration = duration })
end

modifier_huskar_burning_spear_custom_debuff = class({})

function modifier_huskar_burning_spear_custom_debuff:OnCreated()
    if not IsServer() then return end
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:AddStack(1)
    self:OnIntervalThink()
    self:StartIntervalThink(1)
end

function modifier_huskar_burning_spear_custom_debuff:OnRefresh()
    if not IsServer() then return end
    self:AddStack(1)
end

function modifier_huskar_burning_spear_custom_debuff:AddStack(count)
    if not IsServer() then return end
    self:SetStackCount(self:GetStackCount() + count)
    Timers:CreateTimer(self.duration, function()
        if self and not self:IsNull() then
            self:SetStackCount(self:GetStackCount() - count)
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_huskar_burning_spear_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local burn_damage = self:GetAbility():GetSpecialValueFor("burn_damage")
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL, damage = burn_damage * self:GetStackCount()})
end

function modifier_huskar_burning_spear_custom_debuff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Hero_Huskar.Burning_Spear")
end