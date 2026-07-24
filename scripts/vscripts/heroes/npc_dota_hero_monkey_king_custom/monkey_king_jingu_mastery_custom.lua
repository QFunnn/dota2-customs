--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_monkey_king_jingu_mastery_custom_hit", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_jingu_mastery_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_jingu_mastery_custom_buff", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_jingu_mastery_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_jingu_mastery_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_jingu_mastery_custom", LUA_MODIFIER_MOTION_NONE)

monkey_king_jingu_mastery_custom = class({})
monkey_king_jingu_mastery_custom.modifier_monkey_king_1_creep_attacks = 4
monkey_king_jingu_mastery_custom.modifier_monkey_king_1 = 1
monkey_king_jingu_mastery_custom.modifier_monkey_king_2_lifesteal = {5,10}
monkey_king_jingu_mastery_custom.modifier_monkey_king_2_damage = {40,80}

function monkey_king_jingu_mastery_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_overhead.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_start.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_tap_buff.vpcf", context )
end

function monkey_king_jingu_mastery_custom:GetIntrinsicModifierName()
    if self:GetCaster():IsIllusion() then return end
    return "modifier_monkey_king_jingu_mastery_custom"
end

modifier_monkey_king_jingu_mastery_custom = class({})
function modifier_monkey_king_jingu_mastery_custom:IsHidden() return true end
function modifier_monkey_king_jingu_mastery_custom:IsPurgable() return false end
function modifier_monkey_king_jingu_mastery_custom:IsPurgeException() return false end
function modifier_monkey_king_jingu_mastery_custom:RemoveOnDeath() return false end

function modifier_monkey_king_jingu_mastery_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.duration_debuff = self.ability:GetSpecialValueFor("counter_duration")
    if not IsServer() then return end
end

function modifier_monkey_king_jingu_mastery_custom:OnRefresh()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.duration_debuff = self.ability:GetSpecialValueFor("counter_duration")
    if not IsServer() then return end
end

function modifier_monkey_king_jingu_mastery_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self.parent then return end
    if not params.target then return end
    if params.target:GetTeamNumber() == self.parent:GetTeamNumber() then return end
    if params.attacker:PassivesDisabled() then return end
    local counter_target = params.target
    local modifier_monkey_king_wukongs_command_custom_soldier_active = self.parent:FindModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
    if modifier_monkey_king_wukongs_command_custom_soldier_active then
        if modifier_monkey_king_wukongs_command_custom_soldier_active.ultimate == 1 then return end
        counter_target = self.parent
    end
    if self:GetParent():HasModifier("modifier_monkey_king_18") then return end
    local modifier_monkey_king_jingu_mastery_custom_buff = self.parent:FindModifierByName("modifier_monkey_king_jingu_mastery_custom_buff")
    local is_valid_target = true
    if not self:GetParent():HasModifier("modifier_monkey_king_1") then
        if not params.target:IsHero() then
            is_valid_target = false
        end
    end
    if is_valid_target then
        if not modifier_monkey_king_jingu_mastery_custom_buff then
            counter_target:AddNewModifier(params.attacker, self.ability, "modifier_monkey_king_jingu_mastery_custom_hit", {duration = self.duration_debuff})
            return
        end
    end
    if modifier_monkey_king_jingu_mastery_custom_buff then
        if not self.parent:HasModifier("modifier_monkey_king_boundless_strike_custom_damage") then 
            modifier_monkey_king_jingu_mastery_custom_buff:DecrementStackCount()
            if modifier_monkey_king_jingu_mastery_custom_buff:GetStackCount() <= 0  then
                Timers:CreateTimer(FrameTime(), function()
                    modifier_monkey_king_jingu_mastery_custom_buff:Destroy()
                end)
            end
        end
    end
end

function modifier_monkey_king_jingu_mastery_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
    }
end

function modifier_monkey_king_jingu_mastery_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent() == params.unit then return end
    if params.unit:IsBuilding() then return end
    if params.damage <= 0 then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    if (params.inflictor == nil or (params.inflictor and params.inflictor:GetName() == "windrunner_focusfire_whirlwind")) and not self:GetParent():IsIllusion() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then
        local modifier_monkey_king_jingu_mastery_custom_buff = self.parent:FindModifierByName("modifier_monkey_king_jingu_mastery_custom_buff")
        if modifier_monkey_king_jingu_mastery_custom_buff and modifier_monkey_king_jingu_mastery_custom_buff:GetElapsedTime() > 0.1 then
            local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, params.unit)
            ParticleManager:SetParticleControlEnt(hit_effect, 0, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), false) 
            ParticleManager:SetParticleControlEnt(hit_effect, 1, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), false) 
            ParticleManager:ReleaseParticleIndex(hit_effect)
        end
    end
end

function modifier_monkey_king_jingu_mastery_custom:GetModifierProperty_PhysicalLifesteal(params)
    local modifier_monkey_king_jingu_mastery_custom_buff = self.parent:FindModifierByName("modifier_monkey_king_jingu_mastery_custom_buff")
    if modifier_monkey_king_jingu_mastery_custom_buff and modifier_monkey_king_jingu_mastery_custom_buff:GetElapsedTime() > 0.1 then
        return modifier_monkey_king_jingu_mastery_custom_buff.lifesteal
    end
end

modifier_monkey_king_jingu_mastery_custom_hit = class({})
function modifier_monkey_king_jingu_mastery_custom_hit:IsPurgable() return false end
function modifier_monkey_king_jingu_mastery_custom_hit:OnCreated(table)
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.max_stack = self.ability:GetSpecialValueFor("required_hits")
    self.duration_buff = self.ability:GetSpecialValueFor("max_duration")
    self.new_attacks = nil
    if not self:GetParent():IsHero() and self:GetCaster():HasModifier("modifier_monkey_king_1") then
        self.max_stack = self:GetAbility().modifier_monkey_king_1_creep_attacks
        self.new_attacks = self:GetAbility().modifier_monkey_king_1
    end
    if not IsServer() then return end
    self:SetStackCount(1)
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(1, self:GetStackCount(), 1))
    self:AddParticle(self.particle, true, false, -1, false, false)
end

function modifier_monkey_king_jingu_mastery_custom_hit:OnRefresh(table)
    if not IsServer() then return end
    self:IncrementStackCount()
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(1, self:GetStackCount(), 1))
    end
    if self:GetStackCount() >= self.max_stack then 
        self.caster:AddNewModifier(self.caster, self.ability, "modifier_monkey_king_jingu_mastery_custom_buff", {duration = self.duration_buff, new_attacks = self.new_attacks})
        self:Destroy()
    end
end

modifier_monkey_king_jingu_mastery_custom_buff = class({})
function modifier_monkey_king_jingu_mastery_custom_buff:IsHidden() return false end

function modifier_monkey_king_jingu_mastery_custom_buff:OnCreated(params)
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.lifesteal = self.ability:GetSpecialValueFor("lifesteal")
    self.damage = self.ability:GetSpecialValueFor("bonus_damage")
    if self:GetCaster():HasModifier("modifier_monkey_king_2") then
        self.damage = self.damage + self:GetAbility().modifier_monkey_king_2_damage[self:GetCaster():GetTalentLevel("modifier_monkey_king_2")]
        self.lifesteal = self.lifesteal + self:GetAbility().modifier_monkey_king_2_lifesteal[self:GetCaster():GetTalentLevel("modifier_monkey_king_2")]
    end
    if not IsServer() then return end
    local charges = self.ability:GetSpecialValueFor("charges")
    if params.new_attacks then
        charges = params.new_attacks
    end
    local startPfx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(startPfx, 0, self.parent:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(startPfx)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_tap_buff.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_top", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_top", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_bot", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle,true,false,0,false,false)
    self.parent:EmitSound("Hero_MonkeyKing.IronCudgel")
    self:SetStackCount(charges)
    self:StartIntervalThink(0.2)
end

function modifier_monkey_king_jingu_mastery_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    if not self.ability or not self.ability:GetIntrinsicModifierName() or not self.caster:HasModifier(self.ability:GetIntrinsicModifierName()) then
        self:Destroy()
    end
end

function modifier_monkey_king_jingu_mastery_custom_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_monkey_king_jingu_mastery_custom_buff:GetModifierPreAttack_BonusDamage()
    if self:GetElapsedTime() <= 0.1 then return end
    return self.damage
end

function modifier_monkey_king_jingu_mastery_custom_buff:GetActivityTranslationModifiers(params)
    if self:GetElapsedTime() <= 0.1 then return end
    return "iron_cudgel_charged_attack"
end

function modifier_monkey_king_jingu_mastery_custom_buff:GetEffectName()
    return "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_overhead.vpcf"
end

function modifier_monkey_king_jingu_mastery_custom_buff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end