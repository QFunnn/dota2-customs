--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lone_druid_true_form_custom", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_true_form_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lone_druid_true_form_custom_cast", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_true_form_custom", LUA_MODIFIER_MOTION_NONE )

lone_druid_true_form_custom = class({})

lone_druid_true_form_custom.modifier_lone_druid_19 = 10
lone_druid_true_form_custom.modifier_lone_druid_19_cd = 20

function lone_druid_true_form_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_true_form.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_true_form_custom.vpcf", context )
end

function lone_druid_true_form_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_lone_druid_19") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function lone_druid_true_form_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lone_druid_19") then
        bonus = self.modifier_lone_druid_19_cd
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function lone_druid_true_form_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_LoneDruid.TrueForm.Cast")
    if self:GetCaster():HasModifier("modifier_lone_druid_19") then
        local duration = self:GetSpecialValueFor("duration")
        if self:GetCaster():HasModifier("modifier_lone_druid_19") then
            duration = duration + self.modifier_lone_druid_19
        end
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_true_form_custom", {duration = duration})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_true_form_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:SetParticleControlEnt(particle, 3, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
        Timers:CreateTimer(1, function()
            ParticleManager:DestroyParticle(particle, false)
        end)
        return
    end
	local duration = self:GetSpecialValueFor("transformation_time")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_true_form_custom_cast", {duration = duration})
end

modifier_lone_druid_true_form_custom_cast = class({})

function modifier_lone_druid_true_form_custom_cast:IsHidden() return true end
function modifier_lone_druid_true_form_custom_cast:IsPurgable() return false end
function modifier_lone_druid_true_form_custom_cast:IsPurgeException() return false end

function modifier_lone_druid_true_form_custom_cast:OnCreated()
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_true_form.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 3	, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_lone_druid_true_form_custom_cast:OnDestroy()
	if not IsServer() then return end
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lone_druid_true_form_custom", {duration = duration})
end

function modifier_lone_druid_true_form_custom_cast:CheckState()
	local state =
	{
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

modifier_lone_druid_true_form_custom = class({})

function modifier_lone_druid_true_form_custom:IsPurgeException() return false end
function modifier_lone_druid_true_form_custom:IsPurgable() return false end
function modifier_lone_druid_true_form_custom:RemoveOnDeath() return false end

function modifier_lone_druid_true_form_custom:OnCreated()
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.bonus_hp = self:GetAbility():GetSpecialValueFor("bonus_hp")
	self.bonus_attack_damage = self:GetAbility():GetSpecialValueFor("bonus_attack_damage")
	if not IsServer() then return end
	self.attack_info = self:GetCaster():GetAttackCapability()
	self:GetCaster():SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_lone_druid_true_form_custom:OnRefresh()
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.bonus_hp = self:GetAbility():GetSpecialValueFor("bonus_hp")
	self.bonus_attack_damage = self:GetAbility():GetSpecialValueFor("bonus_attack_damage")
end

function modifier_lone_druid_true_form_custom:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():SetAttackCapability( self.attack_info )
end

function modifier_lone_druid_true_form_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_ATTACK_RANGE_BASE_OVERRIDE
	}
end

function modifier_lone_druid_true_form_custom:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_lone_druid_true_form_custom:GetModifierHealthBonus()
	return self.bonus_hp
end

function modifier_lone_druid_true_form_custom:GetModifierPreAttack_BonusDamage()
	return self.bonus_attack_damage
end

function modifier_lone_druid_true_form_custom:GetModifierModelChange()
	return "models/heroes/lone_druid/true_form.vmdl"
end

function modifier_lone_druid_true_form_custom:GetAttackSound()
    return "Hero_LoneDruid.TrueForm.Attack"
end

function modifier_lone_druid_true_form_custom:GetTexture()
    return "lone_druid_true_form"
end

function modifier_lone_druid_true_form_custom:GetModifierAttackRangeOverride()
	return 150
end