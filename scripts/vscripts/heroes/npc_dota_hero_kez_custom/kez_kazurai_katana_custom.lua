--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_kazurai_katana_custom", "heroes/npc_dota_hero_kez_custom/kez_kazurai_katana_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_kazurai_katana_custom_debuff", "heroes/npc_dota_hero_kez_custom/kez_kazurai_katana_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_kazurai_katana_custom_fx", "heroes/npc_dota_hero_kez_custom/kez_kazurai_katana_custom", LUA_MODIFIER_MOTION_NONE)

kez_kazurai_katana_custom = class({})

kez_kazurai_katana_custom.modifier_kez_5 = {1,2,3}
kez_kazurai_katana_custom.modifier_kez_7 = 50 -- Plus
kez_kazurai_katana_custom.modifier_kez_7_stacks = 500 -- Plus

function kez_kazurai_katana_custom:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_2_ALLY
end

function kez_kazurai_katana_custom:IsTargetBackFacing(target)
    local direction = self:GetCaster():GetAbsOrigin() - target:GetAbsOrigin()
    direction.z = 0
    if direction:Length2D() <= 0 then return false end

    local attacker_angle = VectorToAngles(direction:Normalized()).y
    local target_angle = VectorToAngles(target:GetForwardVector()).y

    return math.abs(AngleDiff(attacker_angle, target_angle)) > 90
end

function kez_kazurai_katana_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local impale_duration = self:GetSpecialValueFor("impale_duration")
    local direction = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    self:GetCaster():SetForwardVector(direction)
    self:GetCaster():AddNewModifier(target, self, "modifier_kez_kazurai_katana_custom_fx", {duration = impale_duration})
    target:AddNewModifier(self:GetCaster(), self, "modifier_kez_katana_shard_debuff", {duration = impale_duration})
    if self:IsTargetBackFacing(target) and self:GetCaster():HasModifier("modifier_kez_7") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = impale_duration * (1 - target:GetStatusResistance())})
    end
    local modifier_kez_kazurai_katana_custom_debuff = target:FindModifierByName("modifier_kez_kazurai_katana_custom_debuff")
    if modifier_kez_kazurai_katana_custom_debuff then
        modifier_kez_kazurai_katana_custom_debuff:ForceDestroy()
    end
    self:GetCaster():EmitSound("Hero_Kez.Attack")
end

function kez_kazurai_katana_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
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
function modifier_kez_kazurai_katana_custom:OnAttackLanded( params )
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local target = params.target
    if not params.target:IsBaseNPC() then return end
    if self:GetCaster():HasModifier("modifier_kez_switch_weapons_custom") then return end
    local katana_bleed_attack_damage_pct = self:GetAbility():GetSpecialValueFor("katana_bleed_attack_damage_pct")
    if self:GetCaster():HasModifier("modifier_kez_5") then
        katana_bleed_attack_damage_pct = katana_bleed_attack_damage_pct + self:GetAbility().modifier_kez_5[self:GetCaster():GetTalentLevel("modifier_kez_5")]
    end
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
    if self:GetCaster():HasModifier("modifier_kez_switch_weapons_custom") then return end
    local katana_bleed_attack_damage_pct = self:GetAbility():GetSpecialValueFor("katana_bleed_attack_damage_pct")
    if self:GetCaster():HasModifier("modifier_kez_5") then
        katana_bleed_attack_damage_pct = katana_bleed_attack_damage_pct + self:GetAbility().modifier_kez_5[self:GetCaster():GetTalentLevel("modifier_kez_5")]
    end
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
    if self:GetCaster():HasModifier("modifier_kez_18") then
        damage_type = DAMAGE_TYPE_MAGICAL
    end
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
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_kez_kazurai_katana_custom_debuff:GetModifierPropertyRestorationAmplification()
    return self.heal_reduction_pct
end

function modifier_kez_kazurai_katana_custom_debuff:ForceDestroy()
    if not IsServer() then return end
    local damage_type = DAMAGE_TYPE_PHYSICAL
    if self:GetCaster():HasModifier("modifier_kez_18") then
        damage_type = DAMAGE_TYPE_MAGICAL
    end
    local max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    local bleed_as_rupture_pct = self:GetAbility():GetSpecialValueFor("bleed_as_rupture_pct")
    if self:GetCaster():HasModifier("modifier_kez_7") then
        max_stacks = max_stacks + self:GetAbility().modifier_kez_7_stacks
        bleed_as_rupture_pct = bleed_as_rupture_pct + self:GetAbility().modifier_kez_7
    end
    local damage = self:GetStackCount() * bleed_as_rupture_pct / 100
    damage = math.min(damage, max_stacks)
    local lifesteal = ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = damage_type})
    if self:GetCaster():HasModifier("modifier_kez_7") then
        self:GetCaster():Heal(lifesteal, self:GetAbility())
        local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:ReleaseParticleIndex(particle)
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_damage_numbers.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(10, math.floor(damage), 4))
    ParticleManager:SetParticleControl(particle, 2, Vector(1.5, string.len(tostring(math.floor(damage)))+1, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    self:Destroy()
end

modifier_kez_kazurai_katana_custom_fx = class({})
function modifier_kez_kazurai_katana_custom_fx:IsHidden() return true end
function modifier_kez_kazurai_katana_custom_fx:IsPurgable() return false end
function modifier_kez_kazurai_katana_custom_fx:IsPurgeException() return false end
function modifier_kez_kazurai_katana_custom_fx:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = IsServer(),
    }
end