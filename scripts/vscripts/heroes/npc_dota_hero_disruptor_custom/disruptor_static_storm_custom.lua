--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_disruptor_static_storm_custom", "heroes/npc_dota_hero_disruptor_custom/disruptor_static_storm_custom", LUA_MODIFIER_MOTION_NONE )

disruptor_static_storm_custom = class({})
disruptor_static_storm_custom.modifier_disruptor_21_radius = 300
disruptor_static_storm_custom.modifier_disruptor_21_cooldown = -30
disruptor_static_storm_custom.modifier_disruptor_21_duration = 6
disruptor_static_storm_custom.modifier_disruptor_19 = {700,1400}
disruptor_static_storm_custom.modifier_disruptor_5 = {-3,-1}

function disruptor_static_storm_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_static_storm_bolt_hero.vpcf', context )
end

function disruptor_static_storm_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_disruptor_21") then
	    bonus = self.modifier_disruptor_21_cooldown
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function disruptor_static_storm_custom:GetAOERadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_disruptor_21") then
		bonus = self.modifier_disruptor_21_radius
	end
	return self:GetSpecialValueFor( "radius" ) + bonus
end

function disruptor_static_storm_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()

	if self:GetCaster():HasModifier("modifier_disruptor_19") then
		local disruptor_glimpse_custom = self:GetCaster():FindAbilityByName("disruptor_glimpse_custom")
		if disruptor_glimpse_custom then
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),point,nil,self.modifier_disruptor_19[self:GetCaster():GetTalentLevel("modifier_disruptor_19")],DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,0,false)
			for _, enemy in pairs(enemies) do
				disruptor_glimpse_custom:CustomStart(enemy, point)
			end
		end
	end

	CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_static_storm_custom", {}, point, self:GetCaster():GetTeamNumber(), false )
	self:GetCaster():EmitSound("Hero_Disruptor.StaticStorm.Cast")
end

modifier_disruptor_static_storm_custom = class({})

function modifier_disruptor_static_storm_custom:OnCreated( kv )
	if not IsServer() then return end
	self.owner = kv.isProvidedByAura~=1
	if not self.owner then return end
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if self:GetCaster():HasModifier("modifier_disruptor_21") then
		self.radius = self.radius + self:GetAbility().modifier_disruptor_21_radius
	end
	self.pulses = self:GetAbility():GetSpecialValueFor( "pulses" )
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
	if self:GetCaster():HasModifier("modifier_disruptor_21") then
		duration = duration + self:GetAbility().modifier_disruptor_21_duration
	end
    if self:GetCaster():HasModifier("modifier_disruptor_5") then
        duration = duration + self:GetAbility().modifier_disruptor_5[self:GetCaster():GetTalentLevel("modifier_disruptor_5")]
    end
	local damage = self:GetAbility():GetSpecialValueFor( "damage_max" )
	local interval = duration/self.pulses
	local max_tick_damage = damage*interval
	self.tick_damage = max_tick_damage/self.pulses
	self.pulse = 0
	self.damageTable = 
	{
		attacker = self:GetCaster(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	self:StartIntervalThink( interval )
	self:PlayEffects1( duration )
	self:GetParent():EmitSound("Hero_Disruptor.StaticStorm")
end

function modifier_disruptor_static_storm_custom:OnDestroy()
	if not IsServer() then return end
	if self.owner then
		self:GetParent():StopSound("Hero_Disruptor.StaticStorm")
		self:GetParent():EmitSound("Hero_Disruptor.StaticStorm.End")
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_disruptor_static_storm_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_SILENCED] = true,
	}
    if self:GetCaster():HasModifier("modifier_disruptor_5") then
        state[MODIFIER_STATE_MUTED] = true
    end
	return state
end

function modifier_disruptor_static_storm_custom:OnIntervalThink()
	self.pulse = self.pulse + 1
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	self.damageTable.damage = self.tick_damage * self.pulse
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
		self:PlayEffects2(enemy)
	end
	if self.pulse >= self.pulses then
		self:Destroy()
	end
end

function modifier_disruptor_static_storm_custom:IsAura()
	return self.owner
end

function modifier_disruptor_static_storm_custom:GetModifierAura()
	return "modifier_disruptor_static_storm_custom"
end

function modifier_disruptor_static_storm_custom:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_static_storm_custom:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_static_storm_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_static_storm_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_static_storm_custom:PlayEffects1( duration )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 999, 0, 0 ) )
	self:AddParticle(effect_cast, false, false, -1, false, false)
end

function modifier_disruptor_static_storm_custom:PlayEffects2( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_static_storm_bolt_hero.vpcf", PATTACH_OVERHEAD_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end