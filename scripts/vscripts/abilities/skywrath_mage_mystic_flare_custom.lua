--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


skywrath_mage_mystic_flare_custom = class({})

LinkLuaModifier( "modifier_skywrath_mage_mystic_flare_custom_thinker", "abilities/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE )

function skywrath_mage_mystic_flare_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf", context )
end

function skywrath_mage_mystic_flare_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function skywrath_mage_mystic_flare_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )
	local radius = self:GetSpecialValueFor( "radius" )
	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end
	CreateModifierThinker( caster, self, "modifier_skywrath_mage_mystic_flare_custom_thinker", { duration = duration, real_duration = self:GetSpecialValueFor( "duration" ) }, point, caster:GetTeamNumber(), false )
	caster:EmitSound("Hero_SkywrathMage.MysticFlare.Cast")
	if caster:HasScepter() then
		local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), point, nil, scepter_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false )
		local target = nil
		local creep = nil
		for _,enemy in pairs(enemies) do
			if (enemy:GetOrigin()-point):Length2D() > radius then
				if enemy:IsHero() then
					target = enemy
					break
				elseif not creep then
					creep = enemy
				end
			end
		end
		if not target then
			target = creep
		end
		if target then
			CreateModifierThinker( caster, self, "modifier_skywrath_mage_mystic_flare_custom_thinker", { duration = duration, real_duration = self:GetSpecialValueFor( "duration" ) }, target:GetOrigin(), caster:GetTeamNumber(), false )
		end
	end
end

modifier_skywrath_mage_mystic_flare_custom_thinker = class({})

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnCreated( kv )
	local interval = self:GetAbility():GetSpecialValueFor( "damage_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if IsServer() then
		self.damage = self.damage * interval / kv.real_duration
		self.damageTable = 
		{
			attacker = self:GetCaster(),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(),
            damage = self.damage,
		}
		self:StartIntervalThink( interval )
		self:OnIntervalThink()
		self:PlayEffects( self.radius, kv.duration, interval )
	end
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnIntervalThink()
	local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,hero in pairs(heroes) do
		self.damageTable.victim = hero
		ApplyDamage( self.damageTable )
	end
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:PlayEffects( radius, duration, interval )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0 , self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, duration, interval ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():EmitSound("Hero_SkywrathMage.MysticFlare")
end