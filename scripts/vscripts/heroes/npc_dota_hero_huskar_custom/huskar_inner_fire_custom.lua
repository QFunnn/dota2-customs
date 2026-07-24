--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_inner_fire_custom", "heroes/npc_dota_hero_huskar_custom/huskar_inner_fire_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_huskar_inner_fire_custom_debuff", "heroes/npc_dota_hero_huskar_custom/huskar_inner_fire_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_huskar_inner_fire_custom_handler", "heroes/npc_dota_hero_huskar_custom/huskar_inner_fire_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_huskar_inner_fire_custom_rooted", "heroes/npc_dota_hero_huskar_custom/huskar_inner_fire_custom", LUA_MODIFIER_MOTION_NONE)

huskar_inner_fire_custom = class({})

huskar_inner_fire_custom.modifier_huskar_11 = {1,2}
huskar_inner_fire_custom.modifier_huskar_12 = 150
huskar_inner_fire_custom.modifier_huskar_17 = {700,600,500}

function huskar_inner_fire_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf", context )
    PrecacheResource( "particle", "particles/huskar_root_inner_fire.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
end

function huskar_inner_fire_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_huskar_12") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function huskar_inner_fire_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_huskar_12") then
        if IsClient() then
            return self:GetCaster():GetModifierStackCount("modifier_huskar_inner_fire_custom_handler", self:GetCaster())
        end
    end
end

function huskar_inner_fire_custom:GetIntrinsicModifierName()
    return "modifier_huskar_inner_fire_custom_handler"
end

function huskar_inner_fire_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function huskar_inner_fire_custom:GetHealthCost(level)
    if self:GetCaster():HasModifier("modifier_huskar_15") then return end
    return self:GetSpecialValueFor("health_cost") * (1 - self:GetCaster():Script_GetMagicalArmorValue(self))
end

function huskar_inner_fire_custom:GetManaCost(level)
    if not self:GetCaster():HasModifier("modifier_huskar_15") then return end
    return self:GetSpecialValueFor("health_cost")
end

function huskar_inner_fire_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_huskar_12") then
        local point = self:GetCursorPosition()
        local direction = (point - self:GetCaster():GetAbsOrigin())
        direction.z = 0
        local length = direction:Length2D()
        direction = direction:Normalized()
        local range = math.floor(self:GetCaster():GetDisplayAttackSpeed() / 100 * self.modifier_huskar_12)
        if length >= range then
            point = self:GetCaster():GetAbsOrigin() + direction * range
        end
        self:UseInnerFire(point)
        if not self:GetCaster():IsRooted() then
            FindClearSpaceForUnit(self:GetCaster(), point, true)
        end
        return
    end
    self:UseInnerFire(self:GetCaster():GetAbsOrigin())
end

function huskar_inner_fire_custom:UseInnerFire(point)
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")
    local disarm_duration = self:GetSpecialValueFor("disarm_duration")
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        local direction = unit:GetAbsOrigin() - point
        direction.z = 0
        local length = direction:Length2D()
        direction = direction:Normalized()
        local knockback_distance = self:GetSpecialValueFor("knockback_distance")
        knockback_distance = math.max(0, knockback_distance - length)
        local knockback = unit:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = knockback_duration, distance = knockback_distance, IsStun = true, direction_x = direction.x, direction_y = direction.y} )
        local callback = function()
            if self:GetCaster():HasModifier("modifier_huskar_11") then
                unit:AddNewModifier(self:GetCaster(), self, "modifier_huskar_inner_fire_custom_rooted", {duration = self.modifier_huskar_11[self:GetCaster():GetTalentLevel("modifier_huskar_11")] * (1-unit:GetStatusResistance())})
            end
        end
        if knockback then
            knockback:SetEndCallback( callback )
        end
        if self:GetCaster():HasModifier("modifier_huskar_17") then
            local stack_count = self:GetCaster():GetMana() / self.modifier_huskar_17[self:GetCaster():GetTalentLevel("modifier_huskar_17")]
            local huskar_burning_spear_custom = self:GetCaster():FindAbilityByName("huskar_burning_spear_custom")
            if huskar_burning_spear_custom and huskar_burning_spear_custom:GetLevel() > 0 and stack_count > 0 then
                for i=1, stack_count do
                    huskar_burning_spear_custom:AttackTarget(unit)
                end
            end
        end
        ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        unit:AddNewModifier(self:GetCaster(), self, "modifier_huskar_inner_fire_custom_debuff", {duration = disarm_duration * (1-unit:GetStatusResistance())})
    end
    EmitSoundOnLocationWithCaster(point, "Hero_Huskar.Inner_Fire.Cast", self:GetCaster())
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, point)
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
    ParticleManager:SetParticleControl(particle, 3, point)
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_huskar_inner_fire_custom_debuff = class({})

function modifier_huskar_inner_fire_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_huskar_inner_fire_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf"
end
  
function modifier_huskar_inner_fire_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_huskar_inner_fire_custom_rooted = class({})

function modifier_huskar_inner_fire_custom_rooted:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/huskar_root_inner_fire.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_huskar_inner_fire_custom_rooted:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true
    }
end

modifier_huskar_inner_fire_custom_handler = class({})
function modifier_huskar_inner_fire_custom_handler:IsHidden() return true end
function modifier_huskar_inner_fire_custom_handler:IsPurgable() return false end
function modifier_huskar_inner_fire_custom_handler:IsPurgeException() return false end
function modifier_huskar_inner_fire_custom_handler:RemoveOnDeath() return false end
function modifier_huskar_inner_fire_custom_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_huskar_inner_fire_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_huskar_12") then
        self:SetStackCount(math.floor(self:GetCaster():GetDisplayAttackSpeed() / 100 * self:GetAbility().modifier_huskar_12))
    end
end