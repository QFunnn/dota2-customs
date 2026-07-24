--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_jolt_custom_debuff", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_jolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nyx_assassin_jolt_custom", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_jolt_custom", LUA_MODIFIER_MOTION_NONE)

nyx_assassin_jolt_custom = class({})

nyx_assassin_jolt_custom.modifier_nyx_assassin_15 = 300
nyx_assassin_jolt_custom.modifier_nyx_assassin_12_illsuion_outgoing = 50
nyx_assassin_jolt_custom.modifier_nyx_assassin_12_illsuion_incoming = 200
nyx_assassin_jolt_custom.modifier_nyx_assassin_12_illsuion_duration = {3,6,9}

function nyx_assassin_jolt_custom:GetIntrinsicModifierName()
    return "modifier_nyx_assassin_jolt_custom"
end

function nyx_assassin_jolt_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_jolt.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_jolt_red.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_red.vpcf", context )
end

function nyx_assassin_jolt_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_nyx_assassin_2") then
        return "nyx_2"
    end
    return "nyx_assassin_jolt"
end

function nyx_assassin_jolt_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
    self:CastJolt(target)
    if self:GetCaster():HasModifier("modifier_nyx_assassin_15") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_nyx_assassin_15, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false)
        for _,unit in pairs(units) do
            if unit ~= target then
                self:CastJolt(unit, true)
            end
        end
    end
    if self:GetCaster():HasModifier("modifier_nyx_assassin_12") then
        local damage_out = self.modifier_nyx_assassin_12_illsuion_outgoing - 100
        local damage_inc = self.modifier_nyx_assassin_12_illsuion_incoming - 100
        local illusions = CreateIllusions(self:GetCaster(), self:GetCaster(), {duration = self.modifier_nyx_assassin_12_illsuion_duration[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_12")], outgoing_damage=damage_out, incoming_damage = damage_inc}, 1, 250, false, false)
        if illusions and illusions[1] then
            FindClearSpaceForUnit(illusions[1], target:GetAbsOrigin(), true)
        end
    end
end

function nyx_assassin_jolt_custom:CastJolt(target)
    local max_mana_as_damage_pct = self:GetSpecialValueFor("max_mana_as_damage_pct")
    local damage_echo_duration = self:GetSpecialValueFor("damage_echo_duration")
    local damage_echo_pct = self:GetSpecialValueFor("damage_echo_pct")
    local target_math = target
    if self:GetCaster():HasModifier("modifier_nyx_assassin_15") then
        target_math = self:GetCaster()
    end
    local mana_damage = target_math:GetMaxMana() / 100 * max_mana_as_damage_pct
    local mana_burn_pct = self:GetSpecialValueFor("mana_burn_pct")
    local reduce_mana = target:GetMaxMana() / 100 * mana_burn_pct
    target:Script_ReduceMana(reduce_mana, self)
    if self:GetCaster():HasModifier("modifier_nyx_assassin_2") then
        mana_damage = target_math:GetMaxHealth() / 100 * max_mana_as_damage_pct
    end
    local old_damage = 0
    local modifier_nyx_assassin_jolt_custom_debuff = target:FindModifierByName("modifier_nyx_assassin_jolt_custom_debuff")
    if modifier_nyx_assassin_jolt_custom_debuff then
        old_damage = modifier_nyx_assassin_jolt_custom_debuff.damage / 100 * damage_echo_pct
        modifier_nyx_assassin_jolt_custom_debuff:Destroy()
    end

    self:GetCaster():EmitSound("Hero_NyxAssassin.Jolt.Cast")

    local damage = mana_damage + old_damage

    local visual_particle = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_jolt.vpcf"
    local visual_particle_2 = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf"

    if self:GetCaster():HasModifier("modifier_nyx_assassin_2") then
        visual_particle = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_jolt_red.vpcf"
        visual_particle_2 = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_red.vpcf"
    end 

    local particle = ParticleManager:CreateParticle(visual_particle, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    local explosion_particle = ParticleManager:CreateParticle(visual_particle_2, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(explosion_particle, 0, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(explosion_particle)

    ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
    target:EmitSound("Hero_NyxAssassin.Jolt.Target")
end

modifier_nyx_assassin_jolt_custom = class({})
function modifier_nyx_assassin_jolt_custom:IsHidden() return true end
function modifier_nyx_assassin_jolt_custom:IsPurgable() return false end
function modifier_nyx_assassin_jolt_custom:IsPurgeException() return false end
function modifier_nyx_assassin_jolt_custom:RemoveOnDeath() return false end

function modifier_nyx_assassin_jolt_custom:OnCreated()
    self.damage_echo_duration = self:GetAbility():GetSpecialValueFor("damage_echo_duration")
end

function modifier_nyx_assassin_jolt_custom:DeclareFunctions()
    return
    {
         
    }
end

function modifier_nyx_assassin_jolt_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if params.inflictor and params.inflictor == self:GetAbility() then return end
    params.unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nyx_assassin_jolt_custom_debuff", {duration = self.damage_echo_duration, damage = params.damage})
end

modifier_nyx_assassin_jolt_custom_debuff = class({})
function modifier_nyx_assassin_jolt_custom_debuff:IsHidden() return true end
function modifier_nyx_assassin_jolt_custom_debuff:IsPurgable() return false end
function modifier_nyx_assassin_jolt_custom_debuff:IsPurgeException() return false end
function modifier_nyx_assassin_jolt_custom_debuff:RemoveOnDeath() return false end

function modifier_nyx_assassin_jolt_custom_debuff:OnCreated(params)
    if not IsServer() then return end
    local damage_echo_duration = self:GetAbility():GetSpecialValueFor("damage_echo_duration")
    local damage = params.damage
    self.damage = damage
    local mod = self
    Timers:CreateTimer(damage_echo_duration, function()
        if mod and not mod:IsNull() then
            mod.damage = math.max(0, mod.damage - damage)
        end
    end)
end

function modifier_nyx_assassin_jolt_custom_debuff:OnRefresh(params)
    if not IsServer() then return end
    local damage_echo_duration = self:GetAbility():GetSpecialValueFor("damage_echo_duration")
    local damage = params.damage
    self.damage = self.damage + damage
    local mod = self
    Timers:CreateTimer(damage_echo_duration, function()
        if mod and not mod:IsNull() then
            mod.damage = math.max(0, mod.damage - damage)
        end
    end)
end