--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_custom_debuff", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_freezing_field_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_freezing_field_custom = class({})

crystal_maiden_freezing_field_custom.modifier_crystal_maiden_7_damage_cooldown = 1
crystal_maiden_freezing_field_custom.modifier_crystal_maiden_7_self_damage = 12
crystal_maiden_freezing_field_custom.modifier_crystal_maiden_7_health_to_use = 10

crystal_maiden_freezing_field_custom.modifier_crystal_maiden_18_delay_frostbite = 2

function crystal_maiden_freezing_field_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf', context )
end

function crystal_maiden_freezing_field_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_crystal_maiden_7") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function crystal_maiden_freezing_field_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_crystal_maiden_7") then
		return 0
	end
    return self.BaseClass.GetManaCost(self, level)
end

function crystal_maiden_freezing_field_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_crystal_maiden_7") then
		return 0
	end
	return self.BaseClass.GetCooldown( self, level )
end

function crystal_maiden_freezing_field_custom:OnToggle()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_crystal_maiden_7") then return end

	local caster = self:GetCaster()
	local toggle = self:GetToggleState()

	if toggle then
		self.modifier = caster:AddNewModifier( caster, self, "modifier_crystal_maiden_freezing_field_custom", {} )
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end

	self:StartCooldown(1)
end

function crystal_maiden_freezing_field_custom:OnSpellStart()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_crystal_maiden_7") then return end
	local duration = self:GetChannelTime()
	self.modifier = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_freezing_field_custom", {duration = duration})
end

function crystal_maiden_freezing_field_custom:OnChannelFinish( bInterrupted )
	if self.modifier then
		self.modifier:Destroy()
		self.modifier = nil
	end
end

modifier_crystal_maiden_freezing_field_custom = class({})

function modifier_crystal_maiden_freezing_field_custom:IsHidden() return true end

function modifier_crystal_maiden_freezing_field_custom:IsPurgable()
	return false
end

function modifier_crystal_maiden_freezing_field_custom:IsAura()
	return self.aura_enabled
end

function modifier_crystal_maiden_freezing_field_custom:GetModifierAura()
	return "modifier_crystal_maiden_freezing_field_custom_debuff"
end

function modifier_crystal_maiden_freezing_field_custom:GetAuraRadius()
	return self.slow_radius
end

function modifier_crystal_maiden_freezing_field_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_crystal_maiden_freezing_field_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_crystal_maiden_freezing_field_custom:GetAuraDuration()
	return self.slow_duration
end

function modifier_crystal_maiden_freezing_field_custom:OnCreated()
	self.slow_radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.explosion_radius = self:GetAbility():GetSpecialValueFor( "explosion_radius" )
	self.explosion_interval = self:GetAbility():GetSpecialValueFor( "explosion_interval" )
	self.explosion_min_dist = self:GetAbility():GetSpecialValueFor( "explosion_min_dist" )
	self.explosion_max_dist = self:GetAbility():GetSpecialValueFor( "explosion_max_dist" )
	local explosion_damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.cooldown_damage = 1
	self.aura_enabled = true

	self.quartal = -1

	if IsServer() then
		self.damageTable = { attacker = self:GetCaster(), damage = explosion_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()}
		self:StartIntervalThink( self.explosion_interval )
		self:SetStackCount(1)
		self:OnIntervalThink()
		self:PlayEffects1()
	end
end

function modifier_crystal_maiden_freezing_field_custom:OnRefresh( kv )
	self:OnCreated()
end

function modifier_crystal_maiden_freezing_field_custom:OnDestroy( kv )
	if IsServer() then
		self:StopEffects1()
	end
end

function modifier_crystal_maiden_freezing_field_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}

	return funcs
end

function modifier_crystal_maiden_freezing_field_custom:GetModifierPhysicalArmorBonus()
	if self:GetStackCount() == 0 then return 0 end
	return self.bonus_armor * self:GetStackCount()
end

function modifier_crystal_maiden_freezing_field_custom:OnIntervalThink()

	if self:GetCaster():HasModifier("modifier_crystal_maiden_7") then
		if self:GetParent():GetHealthPercent() < self:GetAbility().modifier_crystal_maiden_7_health_to_use then
			self:StopEffects1()
			self.aura_enabled = false
			if IsServer() then
				self:SetStackCount(0)
				self:StartIntervalThink( 0.1 )
			end
			print("Закончилось афк ждем хп")
			return
		else
			self:SetStackCount(1)
			self:PlayEffects1()
			self.aura_enabled = true
			print("ХП ЕСТЬ МЕТРО ЛЮБЛИНО РАБОТАЕМ")
		end
	end

	if self:GetCaster():HasModifier("modifier_crystal_maiden_7") then
		self.cooldown_damage = self.cooldown_damage + self.explosion_interval
		if self.cooldown_damage >= self:GetAbility().modifier_crystal_maiden_7_damage_cooldown then
			local damage = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_crystal_maiden_7_self_damage
			ApplyDamage( { attacker = self:GetCaster(), victim = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, ability = self:GetAbility()} )
			self.cooldown_damage = 0
		end
	end

	self.quartal = self.quartal+1
	if self.quartal>3 then self.quartal = 0 end
	local a = RandomInt(0,90) + self.quartal*90
	local r = RandomInt(self.explosion_min_dist,self.explosion_max_dist)
	local point = Vector( math.cos(a), math.sin(a), 0 ):Normalized() * r
	point = self:GetCaster():GetOrigin() + point

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, self.explosion_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end

	self:PlayEffects2( point )
	if IsServer() then
		self:StartIntervalThink( self.explosion_interval )
	end
end

function modifier_crystal_maiden_freezing_field_custom:PlayEffects1()
	if self.effect_cast == nil then
		self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.slow_radius, self.slow_radius, 1 ) )
		self:AddParticle( self.effect_cast, false, false, -1, false, false )
		self:GetCaster():EmitSound("hero_Crystal.freezingField.wind")
	end
end

function modifier_crystal_maiden_freezing_field_custom:PlayEffects2( point )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	EmitSoundOnLocationWithCaster( point, "hero_Crystal.freezingField.explosion", self:GetCaster() )
end

function modifier_crystal_maiden_freezing_field_custom:StopEffects1()
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
		self:GetCaster():StopSound("hero_Crystal.freezingField.wind")
		self.effect_cast = nil
	end
end

modifier_crystal_maiden_freezing_field_custom_debuff = class({})

function modifier_crystal_maiden_freezing_field_custom_debuff:OnCreated( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attack_slow" )
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_crystal_maiden_18") then
		self:StartIntervalThink(self:GetAbility().modifier_crystal_maiden_18_delay_frostbite)
	end
end

function modifier_crystal_maiden_freezing_field_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	local ability = self:GetCaster():FindAbilityByName("crystal_maiden_frostbite_custom")
	if ability then
		ability:OnSpellStart(self:GetParent())
	end
	self:StartIntervalThink(-1)
end

function modifier_crystal_maiden_freezing_field_custom_debuff:OnRefresh( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attack_slow" )	
end

function modifier_crystal_maiden_freezing_field_custom_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end