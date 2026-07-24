--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_debuff", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_puddle", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_puddle_buff", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_puddle_buff_aura", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_puddle_debuff_aura", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_puddle_attack_speed", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )

slardar_slithereen_crush_custom = class({})

function slardar_slithereen_crush_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slardar/slardar_crush.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/slardar/slardar_takoyaki/slardar_crush_tako.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_slardar_crush.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slardar/slardar_water_puddle_test.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/monkey_king/arcana/monkey_king_arcana_water.vpcf", context )
end

slardar_slithereen_crush_custom.modifier_slardar_1_radius = {125,250}
slardar_slithereen_crush_custom.modifier_slardar_1_duration = {2,4}
slardar_slithereen_crush_custom.modifier_slardar_2_dmg = 25
slardar_slithereen_crush_custom.modifier_slardar_2_percent_dmg = {150,200,250}
slardar_slithereen_crush_custom.modifier_slardar_3 = {0.4,0.8}
slardar_slithereen_crush_custom.modifier_slardar_11_attack_speed = {50,100,150}
slardar_slithereen_crush_custom.modifier_slardar_11_duration = 4
slardar_slithereen_crush_custom.modifier_slardar_15 = {50,100,150}
slardar_slithereen_crush_custom.modifier_slardar_16 = {250,500}
slardar_slithereen_crush_custom.modifier_slardar_17 = 3

function slardar_slithereen_crush_custom:GetCastRange(location, target)
    if self:GetCaster():HasModifier("modifier_slardar_16") then
		return self.modifier_slardar_16[self:GetCaster():GetTalentLevel("modifier_slardar_16")]
	end
end

function slardar_slithereen_crush_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_slardar_16") then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function slardar_slithereen_crush_custom:GetAOERadius()
	return self:GetSpecialValueFor("crush_radius")
end

function slardar_slithereen_crush_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_slardar_11") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function slardar_slithereen_crush_custom:OnSpellStart()
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("crush_radius")
	local damage = self:GetSpecialValueFor("crush_damage")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local slow_duration = self:GetSpecialValueFor("crush_extra_slow_duration")
	local puddle_duration =  self:GetSpecialValueFor("puddle_duration")
	local point = self:GetCaster():GetAbsOrigin()

	if self:GetCaster():HasModifier("modifier_slardar_16") then
		point = self:GetCursorPosition()
	end

	if self:GetCaster():HasModifier("modifier_slardar_1") then
		puddle_duration = puddle_duration + self.modifier_slardar_1_duration[self:GetCaster():GetTalentLevel("modifier_slardar_1")]
	end

	if self:GetCaster():HasModifier("modifier_slardar_15") then
		damage = damage + self.modifier_slardar_15[self:GetCaster():GetTalentLevel("modifier_slardar_15")]
	end

	if self:GetCaster():HasModifier("modifier_slardar_3") then
		stun_duration = stun_duration + self.modifier_slardar_3[self:GetCaster():GetTalentLevel("modifier_slardar_3")]
	end

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )

	for _,enemy in pairs(enemies) do
        if self:GetCaster():HasModifier("modifier_slardar_17") then
            local slardar_amplify_damage_custom = self:GetCaster():FindAbilityByName("slardar_amplify_damage_custom")
			if slardar_amplify_damage_custom and slardar_amplify_damage_custom:GetLevel() > 0 then
				slardar_amplify_damage_custom:CustomActive(enemy, self.modifier_slardar_17)
			end
			self:GetCaster():PerformAttack(enemy, true, true, true, false, false, false, true)
		end
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK, ability = self })
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1 - enemy:GetStatusResistance()) } )
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_slardar_slithereen_crush_custom_debuff", { duration = (stun_duration + slow_duration) * (1 - enemy:GetStatusResistance()) } )
	end

	local effect = "particles/units/heroes/hero_slardar/slardar_crush.vpcf"
	if self:GetCaster():HasModifier("modifier_slardar_16") then
		effect = "particles/econ/items/slardar/slardar_takoyaki/slardar_crush_tako.vpcf"
	end

	local particle = ParticleManager:CreateParticle( effect, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle, 0, point )
	ParticleManager:SetParticleControl( particle, 1, Vector(radius, radius, radius) )
	ParticleManager:ReleaseParticleIndex( particle )

	EmitSoundOnLocationWithCaster( point, "Hero_Slardar.Slithereen_Crush", self:GetCaster() )

	if self:GetCaster():HasModifier("modifier_slardar_11") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_slardar_slithereen_crush_custom_puddle_attack_speed", {duration = self.modifier_slardar_11_duration})
	end

	--local puddle_duration = self:GetSpecialValueFor("puddle_duration")
	if self:GetCaster():HasModifier("modifier_slardar_1") then
		CreateModifierThinker(self:GetCaster(), self, "modifier_slardar_slithereen_crush_custom_puddle", {duration = puddle_duration, ultimate = 1, active = 1, damage = 1}, point, self:GetCaster():GetTeamNumber(), false)
        CreateModifierThinker(self:GetCaster(), self, "modifier_slardar_slithereen_crush_custom_puddle_buff_aura", {duration = puddle_duration, ultimate = 1, active = 1, damage = 1}, point, self:GetCaster():GetTeamNumber(), false)
	else
		CreateModifierThinker(self:GetCaster(), self, "modifier_slardar_slithereen_crush_custom_puddle", {duration = puddle_duration, damage = 1}, point, self:GetCaster():GetTeamNumber(), false)
        CreateModifierThinker(self:GetCaster(), self, "modifier_slardar_slithereen_crush_custom_puddle_buff_aura", {duration = puddle_duration, damage = 1}, point, self:GetCaster():GetTeamNumber(), false)
	end
end

modifier_slardar_slithereen_crush_custom_debuff = class({})

function modifier_slardar_slithereen_crush_custom_debuff:OnCreated( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor("crush_extra_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("crush_attack_slow_tooltip")
end

function modifier_slardar_slithereen_crush_custom_debuff:OnRefresh( kv )
	self:OnCreated()
end

function modifier_slardar_slithereen_crush_custom_debuff:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_slardar_slithereen_crush_custom_debuff:GetModifierMoveSpeedBonus_Percentage( params )
	return self.ms_slow
end

function modifier_slardar_slithereen_crush_custom_debuff:GetModifierAttackSpeedBonus_Constant( params )
	return self.as_slow
end

function modifier_slardar_slithereen_crush_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_slardar_crush.vpcf"
end

function modifier_slardar_slithereen_crush_custom_debuff:StatusEffectPriority()
	return 10
end

modifier_slardar_slithereen_crush_custom_puddle = class({})

function modifier_slardar_slithereen_crush_custom_puddle:IsHidden() return true end
function modifier_slardar_slithereen_crush_custom_puddle:IsPurgable() return false end

function modifier_slardar_slithereen_crush_custom_puddle:OnCreated(params)
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("puddle_radius")
    self.active = params.active
    self.ultimate = params.ultimate
    self.damage = params.damage
	if self:GetCaster():HasModifier("modifier_slardar_1") and params.active then
		self.radius = self.radius + self:GetAbility().modifier_slardar_1_radius[self:GetCaster():GetTalentLevel("modifier_slardar_1")]
	end

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slardar/slardar_water_puddle_test.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius,1,1))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_slardar_slithereen_crush_custom_puddle:IsAura()
    return self:GetCaster():HasModifier("modifier_slardar_2") and self.damage ~= nil
end

function modifier_slardar_slithereen_crush_custom_puddle:GetModifierAura()
    return "modifier_slardar_slithereen_crush_custom_puddle_debuff_aura"
end

function modifier_slardar_slithereen_crush_custom_puddle:GetAuraRadius()
    return self.radius
end

function modifier_slardar_slithereen_crush_custom_puddle:GetAuraDuration()
    return 0
end

function modifier_slardar_slithereen_crush_custom_puddle:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_slardar_slithereen_crush_custom_puddle:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_slardar_slithereen_crush_custom_puddle_attack_speed = class({})

function modifier_slardar_slithereen_crush_custom_puddle_attack_speed:GetTexture()
	return "slardar_11"
end

function modifier_slardar_slithereen_crush_custom_puddle_attack_speed:GetEffectName()
	return "particles/econ/items/monkey_king/arcana/monkey_king_arcana_water.vpcf"
end

function modifier_slardar_slithereen_crush_custom_puddle_attack_speed:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_slardar_slithereen_crush_custom_puddle_attack_speed:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility().modifier_slardar_11_attack_speed[self:GetCaster():GetTalentLevel("modifier_slardar_11")]
end

modifier_slardar_slithereen_crush_custom_puddle_buff_aura = class({})

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:IsPurgable() return false end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:IsAura()
    return true
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:OnCreated(params)
    if not IsServer() then return end

    self.radius = self:GetAbility():GetSpecialValueFor("puddle_radius")

    if self:GetCaster():HasModifier("modifier_slardar_1") and params and params.active then
        self.radius = self.radius + self:GetAbility().modifier_slardar_1_radius[self:GetCaster():GetTalentLevel("modifier_slardar_1")]
    end
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetModifierAura()
    return "modifier_slardar_slithereen_crush_custom_puddle_buff"
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetAuraRadius()
    return self.radius
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetAuraEntityReject(target)
    if target ~= self:GetCaster() then return true end
    return false
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetAuraDuration()
    return 0.5
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_slardar_slithereen_crush_custom_puddle_buff_aura:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_slardar_slithereen_crush_custom_puddle_buff = class({})
function modifier_slardar_slithereen_crush_custom_puddle_buff:IsHidden() return true end
function modifier_slardar_slithereen_crush_custom_puddle_buff:IsPurgable() return false end
function modifier_slardar_slithereen_crush_custom_puddle_buff:IsPurgeException() return false end

modifier_slardar_slithereen_crush_custom_puddle_debuff_aura = class({})

function modifier_slardar_slithereen_crush_custom_puddle_debuff_aura:IsPurgable() return false end

function modifier_slardar_slithereen_crush_custom_puddle_debuff_aura:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
end

function modifier_slardar_slithereen_crush_custom_puddle_debuff_aura:OnIntervalThink()
	if not IsServer() then return end
    local damage = self:GetAbility().modifier_slardar_2_dmg + (self:GetCaster():GetPhysicalArmorValue(false) / 100 * self:GetAbility().modifier_slardar_2_percent_dmg[self:GetCaster():GetTalentLevel("modifier_slardar_2")])
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK, ability = self:GetAbility() })
end