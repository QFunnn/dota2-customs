--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_disruptor_static_mana", "heroes/npc_dota_hero_disruptor_custom/disruptor_static_mana", LUA_MODIFIER_MOTION_NONE )

disruptor_static_mana = class({})

function disruptor_static_mana:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/econ/items/disruptor/disruptor_2022_immortal/disruptor_2022_immortal_static_storm.vpcf', context )
    PrecacheResource( "particle", 'particles/econ/items/disruptor/disruptor_2022_immortal/disruptor_2022_immortal_static_storm_hero_debuff.vpcf', context )
end

function disruptor_static_mana:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function disruptor_static_mana:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )
	CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_static_mana", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false )
	self:GetCaster():EmitSound("Hero_Disruptor.StaticStorm.Cast")
end

modifier_disruptor_static_mana = class({})

function modifier_disruptor_static_mana:OnCreated( kv )
	if not IsServer() then return end
	self.owner = kv.isProvidedByAura~=1
	if not self.owner then return end
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self:StartIntervalThink( 0.5 )
	self:PlayEffects1( duration )
	self:GetParent():EmitSound("Hero_Disruptor.StaticStorm")
end

function modifier_disruptor_static_mana:OnDestroy()
	if not IsServer() then return end
	if self.owner then
		self:GetParent():StopSound("Hero_Disruptor.StaticStorm")
		self:GetParent():EmitSound("Hero_Disruptor.StaticStorm.End")
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_disruptor_static_mana:OnIntervalThink()
	if not IsServer() then return end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local damage = self:GetAbility():GetSpecialValueFor("damage") + (self:GetCaster():GetMana() / 100 * self:GetAbility():GetSpecialValueFor("damage_mana"))
	for _, enemy in pairs(enemies) do
		ApplyDamage({attacker = self:GetCaster(), victim = enemy, ability = self:GetAbility(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL})
		self:PlayEffects2(enemy)
	end
end

function modifier_disruptor_static_mana:IsAura()
	return self.owner
end

function modifier_disruptor_static_mana:GetModifierAura()
	return "modifier_disruptor_static_mana"
end

function modifier_disruptor_static_mana:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_static_mana:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_static_mana:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_static_mana:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_static_mana:PlayEffects1( duration )
	local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/disruptor/disruptor_2022_immortal/disruptor_2022_immortal_static_storm.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 999, 0, 0 ) )
	self:AddParticle(effect_cast, false, false, -1, false, false)
end

function modifier_disruptor_static_mana:PlayEffects2( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/disruptor/disruptor_2022_immortal/disruptor_2022_immortal_static_storm_hero_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end