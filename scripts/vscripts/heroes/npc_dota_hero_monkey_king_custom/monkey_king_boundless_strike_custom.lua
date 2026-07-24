--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_monkey_king_boundless_strike_custom_damage", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_boundless_strike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_boundless_strike_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_boundless_strike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

monkey_king_boundless_strike_custom = class({})
monkey_king_boundless_strike_custom.modifier_monkey_king_9 = {25,50}
monkey_king_boundless_strike_custom.modifier_monkey_king_10 = {0.2,0.3,0.4}
monkey_king_boundless_strike_custom.modifier_monkey_king_20 = 75
monkey_king_boundless_strike_custom.modifier_monkey_king_12_cast_point = {25,50}
monkey_king_boundless_strike_custom.modifier_monkey_king_12_mana_cost = {25,50}

function monkey_king_boundless_strike_custom:GetManaCost(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_monkey_king_12") then
        bonus = self.BaseClass.GetManaCost(self, iLevel) / 100 * self.modifier_monkey_king_12_mana_cost[self:GetCaster():GetTalentLevel("modifier_monkey_king_12")]
    end
    return self.BaseClass.GetManaCost(self, iLevel) - bonus
end

function monkey_king_boundless_strike_custom:GetCastPoint()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_monkey_king_12") then
        bonus = self.BaseClass.GetCastPoint(self) / 100 * self.modifier_monkey_king_12_cast_point[self:GetCaster():GetTalentLevel("modifier_monkey_king_12")]
    end
    return self.BaseClass.GetCastPoint(self) - bonus
end

function monkey_king_boundless_strike_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_monkey_king_20") then
        return "monkey_king_20"
    end
    return "monkey_king_boundless_strike"
end

function monkey_king_boundless_strike_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_monkey_king/monkey_king_strike_cast.vpcf", context )
    PrecacheResource("particle", "particles/units/heroes/hero_monkey_king/monkey_king_strike.vpcf", context )
    PrecacheResource("particle", "particles/units/heroes/hero_monkey_king/monkey_king_strike_slow_impact.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_monkey_king.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_monkey_king.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_monkey_king.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/monkey_king/ti7_weapon/mk_ti7_immortal_strike.vpcf", context)
end

function monkey_king_boundless_strike_custom:OnAbilityPhaseStart()
    self:GetCaster():EmitSound("Hero_MonkeyKing.Strike.Cast")
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_strike_cast.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(self.particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControlEnt(self.particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_bot", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.particle, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_top", self:GetCaster():GetAbsOrigin(), true)
    return true
end

function monkey_king_boundless_strike_custom:OnAbilityPhaseInterrupted()
    if self.particle ~= nil then
        ParticleManager:DestroyParticle(self.particle, true)
        ParticleManager:ReleaseParticleIndex(self.particle)
        self.particle = nil
    end
    if IsServer() then
        self:GetCaster():FadeGesture(ACT_DOTA_MK_STRIKE)
    end
    return true
end

function monkey_king_boundless_strike_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_monkey_king_11") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AUTOCAST
    end
    return DOTA_ABILITY_BEHAVIOR_POINT
end

function monkey_king_boundless_strike_custom:GetIntrinsicModifierName()
    return "modifier_monkey_king_boundless_strike_custom"
end

function monkey_king_boundless_strike_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    if point == caster:GetAbsOrigin() then 
        point = point + caster:GetForwardVector()
    end
    if self.particle ~= nil then
        ParticleManager:DestroyParticle(self.particle, false)
        ParticleManager:ReleaseParticleIndex(self.particle)
        self.particle = nil
    end
    self:CastStrike(caster:GetAbsOrigin(), point)
end

function monkey_king_boundless_strike_custom:CastStrike(start_point, end_point)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local strike_radius = self:GetSpecialValueFor("strike_radius")
    local strike_cast_range = self:GetSpecialValueFor("strike_cast_range")
    local strike_crit_mult = self:GetSpecialValueFor("strike_crit_mult")
    local stun_duration = self:GetSpecialValueFor("stun_duration")

    local vStartPosition = start_point
    local vTargetPosition = end_point

    local vDirection = vTargetPosition - vStartPosition
    vDirection.z = 0
    vStartPosition = GetGroundPosition(vStartPosition+vDirection:Normalized()*(strike_radius/2), caster)
    vTargetPosition = GetGroundPosition(vStartPosition+vDirection:Normalized()*(strike_cast_range-strike_radius/2), caster)

    EmitSoundOnLocationWithCaster(vStartPosition, "Hero_MonkeyKing.Strike.Impact", caster)
    EmitSoundOnLocationWithCaster(vTargetPosition, "Hero_MonkeyKing.Strike.Impact.EndPos", caster)

    local particle_fx = "particles/units/heroes/hero_monkey_king/monkey_king_strike.vpcf"
    if self:GetCaster():HasModifier("modifier_monkey_king_20") then
        particle_fx = "particles/econ/items/monkey_king/ti7_weapon/mk_ti7_immortal_strike.vpcf"
    end

    local particle = ParticleManager:CreateParticle(particle_fx, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, vStartPosition)
    ParticleManager:SetParticleControlForward(particle, 0, vDirection:Normalized())
    ParticleManager:SetParticleControl(particle, 1, vTargetPosition)
    ParticleManager:ReleaseParticleIndex(particle)

    local ignores_targets = {}
    local modifier_monkey_king_boundless_strike_custom_damage = caster:AddNewModifier(caster, self, "modifier_monkey_king_boundless_strike_custom_damage", {})
    local enemies = FindUnitsInLine(caster:GetTeamNumber(), vStartPosition , vTargetPosition, nil, strike_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE)
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
        caster:PerformAttack(enemy, true, true, true, true, true, false, true)
        local particle_impact = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_strike_slow_impact.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControlEnt(particle_impact, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle_impact)
        if self:GetCaster():HasModifier("modifier_monkey_king_20") and not self:GetCaster():HasModifier("modifier_monkey_king_2") then
            local ability = caster:FindAbilityByName("monkey_king_primal_spring_custom")
            if ability and ability:IsTrained() then 
                ability:DealDamageOnTarget(enemy, self.modifier_monkey_king_20 / 100, true)
                ignores_targets[enemy] = true
            end
        end
    end
    if modifier_monkey_king_boundless_strike_custom_damage then 
        modifier_monkey_king_boundless_strike_custom_damage:Destroy()
    end

    local modifier_monkey_king_jingu_mastery_custom_buff = caster:FindModifierByName("modifier_monkey_king_jingu_mastery_custom_buff")
    if modifier_monkey_king_jingu_mastery_custom_buff and modifier_monkey_king_jingu_mastery_custom_buff:GetElapsedTime() > 0.1 then 
        modifier_monkey_king_jingu_mastery_custom_buff:DecrementStackCount()
        if modifier_monkey_king_jingu_mastery_custom_buff:GetStackCount() <= 0 then 
            modifier_monkey_king_jingu_mastery_custom_buff:Destroy()
        end
    end

    if caster:HasModifier("modifier_monkey_king_11") then 
        local point = start_point + vDirection:Normalized()*(strike_cast_range)
        if self:GetAutoCastState() then
            local distance = (point - caster:GetAbsOrigin()):Length2D()
            local dir = (point - caster:GetAbsOrigin()):Normalized()
            distance = math.min(strike_cast_range, distance)
            local arc = caster:AddNewModifier( caster, self, "modifier_generic_arc_lua",
            { 
                dir_x = dir.x,
                dir_y = dir.y,
                distance = distance,
                speed = 3000,
                height = 150,
                fix_end = true,
                isStun = true,
                isForward = true,
                activity =  ACT_DOTA_MK_SPRING_SOAR,
                effect = "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf",
            })
            arc:SetEndCallback( function( interrupted )
                caster:StartGesture(ACT_DOTA_MK_STRIKE_END)
            end)
        end
    end

    if self:GetCaster():HasModifier("modifier_monkey_king_20") and not self:GetCaster():HasModifier("modifier_monkey_king_2") then
        local point = start_point + vDirection:Normalized()*(strike_cast_range)
        local ability = caster:FindAbilityByName("monkey_king_primal_spring_custom")
        if ability and ability:IsTrained() then 
            ability:DealDamage(point, self.modifier_monkey_king_20 / 100, true, ignores_targets)
        end
    end
end

modifier_monkey_king_boundless_strike_custom_damage = class({})
function modifier_monkey_king_boundless_strike_custom_damage:IsHidden() return true end
function modifier_monkey_king_boundless_strike_custom_damage:IsPurgable() return false end

function modifier_monkey_king_boundless_strike_custom_damage:OnCreated(table)
    if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("strike_flat_damage")
    self.strike_crit_mult = self:GetAbility():GetSpecialValueFor("strike_crit_mult")
    if self:GetCaster():HasModifier("modifier_monkey_king_9") then
        self.strike_crit_mult = self.strike_crit_mult + self:GetAbility().modifier_monkey_king_9[self:GetCaster():GetTalentLevel("modifier_monkey_king_9")]
    end
end

function modifier_monkey_king_boundless_strike_custom_damage:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
    } 
end

function modifier_monkey_king_boundless_strike_custom_damage:GetModifierProcAttack_BonusDamage_Physical()
    return self.damage
end

function modifier_monkey_king_boundless_strike_custom_damage:GetModifierPreAttack_CriticalStrike()
    return self.strike_crit_mult
end

function modifier_monkey_king_boundless_strike_custom_damage:GetCritDamage()
    return self.strike_crit_mult
end

modifier_monkey_king_boundless_strike_custom = class({})
function modifier_monkey_king_boundless_strike_custom:IsHidden() return true end
function modifier_monkey_king_boundless_strike_custom:IsPurgable() return false end
function modifier_monkey_king_boundless_strike_custom:IsPurgeException() return false end
function modifier_monkey_king_boundless_strike_custom:RemoveOnDeath() return false end
function modifier_monkey_king_boundless_strike_custom:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if not self:GetParent():HasModifier("modifier_monkey_king_10") then return end
    local new_cooldown = self:GetAbility():GetCooldownTimeRemaining()
    if new_cooldown > 0 then
        self:GetAbility():EndCooldown()
        new_cooldown = new_cooldown - self:GetAbility().modifier_monkey_king_10[self:GetParent():GetTalentLevel("modifier_monkey_king_10")]
        if new_cooldown > 0 then
            self:GetAbility():StartCooldown(new_cooldown)
        end
    end
end