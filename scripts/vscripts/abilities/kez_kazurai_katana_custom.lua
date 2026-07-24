--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_kazurai_katana_custom", "abilities/kez_kazurai_katana_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_kazurai_katana_custom_debuff", "abilities/kez_kazurai_katana_custom", LUA_MODIFIER_MOTION_NONE)

kez_kazurai_katana_custom = class({})

function kez_kazurai_katana_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasShard() then
        return self:GetCaster():Script_GetAttackRange() + 50
    end
end

function kez_kazurai_katana_custom:GetCooldown( nLevel )
    if self:GetCaster():HasShard() then
        return 7
    end
end

function kez_kazurai_katana_custom:GetManaCost( nLevel )
    if self:GetCaster():HasShard() then
        return 50
    end
end

function kez_kazurai_katana_custom:GetBehavior()
    if self:GetCaster():HasShard() then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function kez_kazurai_katana_custom:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_2_ALLY
end

function kez_kazurai_katana_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = 0.6})
    self:GetCaster():AddNewModifier(target, self, "modifier_stunned", {duration = 0.6})
    local modifier_kez_kazurai_katana_custom_debuff = target:FindModifierByName("modifier_kez_kazurai_katana_custom_debuff")
    if modifier_kez_kazurai_katana_custom_debuff then
        modifier_kez_kazurai_katana_custom_debuff:ForceDestroy(self.modifier_kez_7)
    end
    self:GetCaster():EmitSound("Hero_Kez.Attack")
end

function kez_kazurai_katana_custom:Precache( context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_katana_bleed.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_damage_numbers.vpcf", context )
end

function kez_kazurai_katana_custom:GetIntrinsicModifierName()
    return "modifier_kez_kazurai_katana_custom"
end

modifier_kez_kazurai_katana_custom = class({})
function modifier_kez_kazurai_katana_custom:IsHidden() return true end
function modifier_kez_kazurai_katana_custom:IsPurgable() return false end
function modifier_kez_kazurai_katana_custom:IsPurgeException() return false end
function modifier_kez_kazurai_katana_custom:RemoveOnDeath() return false end
function modifier_kez_kazurai_katana_custom:OnCreated()
    self.katana_bleed_duration = self:GetAbility():GetSpecialValueFor("katana_bleed_duration")
end
function modifier_kez_kazurai_katana_custom:OnRefresh()
    self:OnCreated()
end
function modifier_kez_kazurai_katana_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end
function modifier_kez_kazurai_katana_custom:OnAttackLanded( params )
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local target = params.target
    if not params.target:IsBaseNPC() then return end
    local katana_bleed_attack_damage_pct = self:GetAbility():GetSpecialValueFor("katana_bleed_attack_damage_pct")
    local modifier_kez_kazurai_katana_custom_debuff = target:FindModifierByNameAndCaster("modifier_kez_kazurai_katana_custom_debuff", self:GetCaster())
    if not modifier_kez_kazurai_katana_custom_debuff then
        modifier_kez_kazurai_katana_custom_debuff = target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_kez_kazurai_katana_custom_debuff", {duration = self.katana_bleed_duration})
    end
    if modifier_kez_kazurai_katana_custom_debuff then
        local new_stacks = math.floor((params.original_damage / 100 * katana_bleed_attack_damage_pct) * self.katana_bleed_duration)
        modifier_kez_kazurai_katana_custom_debuff:UpdateDamage(new_stacks)
        modifier_kez_kazurai_katana_custom_debuff:SetDuration(self.katana_bleed_duration, true)
    end
end

function modifier_kez_kazurai_katana_custom:ForceSetBuff(target, damage)
    local katana_bleed_attack_damage_pct = self:GetAbility():GetSpecialValueFor("katana_bleed_attack_damage_pct")
    local modifier_kez_kazurai_katana_custom_debuff = target:FindModifierByNameAndCaster("modifier_kez_kazurai_katana_custom_debuff", self:GetCaster())
    if not modifier_kez_kazurai_katana_custom_debuff then
        modifier_kez_kazurai_katana_custom_debuff = target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_kez_kazurai_katana_custom_debuff", {duration = self.katana_bleed_duration})
    end
    if modifier_kez_kazurai_katana_custom_debuff then
        local new_stacks = math.floor((damage / 100 * katana_bleed_attack_damage_pct) * self.katana_bleed_duration)
        modifier_kez_kazurai_katana_custom_debuff:UpdateDamage(new_stacks)
    end
end


modifier_kez_kazurai_katana_custom_debuff = class({})
function modifier_kez_kazurai_katana_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_kez_kazurai_katana_custom_debuff:OnCreated()
    self.heal_reduction_pct = self:GetAbility():GetSpecialValueFor("heal_reduction_pct")
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_katana_bleed.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 1, Vector(500, 0, 0))
    ParticleManager:SetParticleControl(particle, 8, Vector(50, 0, 0))
    self:AddParticle(particle, false, false, -1, false, true)
    self.damage = self:GetStackCount() / self:GetDuration()
    self:StartIntervalThink(1)
end

function modifier_kez_kazurai_katana_custom_debuff:OnRefresh()
    self.damage = self:GetStackCount() / self:GetDuration()
end

function modifier_kez_kazurai_katana_custom_debuff:UpdateDamage(new_stacks)
    self:SetStackCount(self:GetStackCount() + new_stacks)
    self.damage = self:GetStackCount() / self:GetDuration()
end

function modifier_kez_kazurai_katana_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage_type = DAMAGE_TYPE_PHYSICAL
    self:SetStackCount(self:GetStackCount() - self.damage)
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = self.damage, damage_type = damage_type})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_damage_numbers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(10, math.floor(self.damage), 4))
    ParticleManager:SetParticleControl(particle, 2, Vector(1.5, string.len(tostring(math.floor(self.damage)))+1, 0))
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_kez_kazurai_katana_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
    }
end

function modifier_kez_kazurai_katana_custom_debuff:GetModifierLifestealRegenAmplify_Percentage()
    return self.heal_reduction_pct
end

function modifier_kez_kazurai_katana_custom_debuff:GetModifierHealAmplify_PercentageTarget()
    return self.heal_reduction_pct
end

function modifier_kez_kazurai_katana_custom_debuff:GetModifierHPRegenAmplify_Percentage()
    return self.heal_reduction_pct
end

function modifier_kez_kazurai_katana_custom_debuff:ForceDestroy(damage_percent)
    if not IsServer() then return end
    local damage_type = DAMAGE_TYPE_PHYSICAL
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = self:GetStackCount(), damage_type = damage_type})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_damage_numbers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(10, math.floor(self:GetStackCount()), 4))
    ParticleManager:SetParticleControl(particle, 2, Vector(1.5, string.len(tostring(math.floor(self:GetStackCount())))+1, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    self:Destroy()
end