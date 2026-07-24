--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



----------------------------------------------------------------------
spider_nethertoxin_lua = class({})
LinkLuaModifier( "modifier_spider_nethertoxin_lua", "creature_ability/modifier/modifier_spider_nethertoxin_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function spider_nethertoxin_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function spider_nethertoxin_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local Distance = CalculateDistance(point, caster:GetOrigin())
	local Direction = CalculateDirection(point, caster:GetOrigin())
	Direction.z = 0

	-- load data
	local projectile_name = ""
	local Speed = self:GetSpecialValueFor( "projectile_speed" )
 
	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_NONE,
	    
	    EffectName = projectile_name,
	    fDistance = Distance,
	    fStartRadius = 0,
	    fEndRadius = 0,
		vVelocity = Direction * Speed,
		bDeleteOnHit = false,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	self:PlayEffects( point )
end
--------------------------------------------------------------------------------
-- Projectile
function spider_nethertoxin_lua:OnProjectileHit( target, location )
	-- should be no target
	if target then return false end

	if self.fx ~= nil then
		ParticleManager:DestroyParticle(self.fx, false)
		ParticleManager:ReleaseParticleIndex(self.fx)
		self.fx = nil
	end

	-- references
	local duration = self:GetSpecialValueFor( "duration" )

	-- create thinker
	CreateModifierThinker(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_spider_nethertoxin_lua", -- modifier name
		{ duration = duration }, -- kv
		location,
		self:GetCaster():GetTeamNumber(),
		false
	)
end

function spider_nethertoxin_lua:PlayEffects( point )
	local Speed = self:GetSpecialValueFor( "projectile_speed" )
	self.fx = ParticleManager:CreateParticle( "particles/gameplay/spider/spider_nethertoxin_proj.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( self.fx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( self.fx, 1, Vector( Speed, 0, 0 ) )
	ParticleManager:SetParticleControl( self.fx, 5, point )
	self:GetCaster():EmitSound("Hero_Viper.Nethertoxin.Cast")
end