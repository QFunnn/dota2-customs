--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ursa_overpower_custom", "heroes/npc_dota_hero_ursa_custom/ursa_overpower_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ursa_overpower_custom_cooldown", "heroes/npc_dota_hero_ursa_custom/ursa_overpower_custom", LUA_MODIFIER_MOTION_NONE )

ursa_overpower_custom = class({})
ursa_overpower_custom.modifier_ursa_4 = {20,40,60}
ursa_overpower_custom.modifier_ursa_5 = {7,14}
ursa_overpower_custom.modifier_ursa_16 = {40,60,80}
ursa_overpower_custom.modifier_ursa_16_radius = 300
ursa_overpower_custom.modifier_ursa_16_cooldown = 0.5

function ursa_overpower_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", context )
    PrecacheResource( "particle", "particles/ursa_custom_fx/ursa_ti10_earthshock.vpcf", context )
end

function ursa_overpower_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_ursa_16") then
        return "ursa_16"
    end
    return "ursa_overpower"
end

function ursa_overpower_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ursa_5") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function ursa_overpower_custom:OnSpellStart()
	if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_ursa_overpower_custom", {duration = duration})
	self:GetCaster():EmitSound("Hero_Ursa.Overpower")
end

modifier_ursa_overpower_custom = class({})
function modifier_ursa_overpower_custom:OnCreated()
    self.attack_speed_bonus_pct = self:GetAbility():GetSpecialValueFor("attack_speed_bonus_pct")
    self.slow_resist = self:GetAbility():GetSpecialValueFor("slow_resist")
    if not IsServer() then return end
    local max_attacks = self:GetAbility():GetSpecialValueFor("max_attacks")
    self:SetStackCount(max_attacks)
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eye_l", self:GetParent():GetOrigin(), true)
    ParticleManager:SetParticleControlEnt( particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eye_r", self:GetParent():GetOrigin(), true)
    ParticleManager:SetParticleControlEnt( particle, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_back", self:GetParent():GetOrigin(), true)
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_ursa_overpower_custom:OnRefresh()
    self.attack_speed_bonus_pct = self:GetAbility():GetSpecialValueFor("attack_speed_bonus_pct")
    self.slow_resist = self:GetAbility():GetSpecialValueFor("slow_resist")
    if not IsServer() then return end
    local max_attacks = self:GetAbility():GetSpecialValueFor("max_attacks")
    self:SetStackCount(max_attacks)
end
function modifier_ursa_overpower_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_ursa_overpower_custom:GetModifierPreAttack_BonusDamage()
    if self:GetParent():HasModifier("modifier_ursa_4") then
        return self:GetAbility().modifier_ursa_4[self:GetParent():GetTalentLevel("modifier_ursa_4")]
    end
    return 0
end

function modifier_ursa_overpower_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not self:GetParent():HasModifier("modifier_ursa_16") then return end
    if params.inflictor and params.inflictor == self:GetAbility() then return end
    if self:GetParent():HasModifier("modifier_ursa_overpower_custom_cooldown") then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetStackCount() <= 0 then
        self:Destroy()
        return
    end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_ursa_overpower_custom_cooldown", {duration = self:GetAbility().modifier_ursa_16_cooldown})
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.unit:GetAbsOrigin(), nil, self:GetCaster():GetCurrentVisionRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
    if #units > 0 then
        self:TalentExplosion(units[1])
        self:DecrementStackCount()
        if self:GetStackCount() <= 0 then
            self:Destroy()
        end
    end
end
function modifier_ursa_overpower_custom:TalentExplosion(target)
    if not IsServer() then return end
    local radius = self:GetAbility().modifier_ursa_16_radius
    local particle = ParticleManager:CreateParticle("particles/ursa_custom_fx/ursa_ti10_earthshock.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, target:GetAbsOrigin() )
	ParticleManager:SetParticleControl( particle, 1, Vector(radius, radius/2, radius/4) )
	ParticleManager:ReleaseParticleIndex( particle )
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    local damage = self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_ursa_16[self:GetCaster():GetTalentLevel("modifier_ursa_16")]
    for _, unit in pairs(units) do
        ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    end
end
function modifier_ursa_overpower_custom:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent():HasModifier("modifier_ursa_16") then return end
    return self.attack_speed_bonus_pct
end
function modifier_ursa_overpower_custom:GetModifierMoveSpeedBonus_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_ursa_5") then
        bonus = self:GetAbility().modifier_ursa_5[self:GetCaster():GetTalentLevel("modifier_ursa_5")]
    end
    return bonus
end
function modifier_ursa_overpower_custom:GetModifierSlowResistance_Stacking()
    return self.slow_resist
end
function modifier_ursa_overpower_custom:OnAttack(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.no_attack_cooldown then return end
    if self:GetParent():HasModifier("modifier_ursa_16") then return end
    self:DecrementStackCount()
    if self:GetStackCount() <= 0 then
        self:Destroy()
    end
end

modifier_ursa_overpower_custom_cooldown = class({})
function modifier_ursa_overpower_custom_cooldown:IsHidden() return true end
function modifier_ursa_overpower_custom_cooldown:IsPurgeException() return false end
function modifier_ursa_overpower_custom_cooldown:IsPurgable() return false end
function modifier_ursa_overpower_custom_cooldown:RemoveOnDeath() return false end