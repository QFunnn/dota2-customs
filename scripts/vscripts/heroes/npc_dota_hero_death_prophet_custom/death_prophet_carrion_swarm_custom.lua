--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_death_prophet_carrion_swarm_custom_back", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_carrion_swarm_custom", LUA_MODIFIER_MOTION_NONE)

death_prophet_carrion_swarm_custom = class({})

death_prophet_carrion_swarm_custom.modifier_death_prophet_16 = {-0.75,-1.5}
death_prophet_carrion_swarm_custom.modifier_death_prophet_20 = {4.5,3}

function death_prophet_carrion_swarm_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_carrion_swarm.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_death_prophet.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_death_prophet.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_death_prophet.vpcf", context)
end

function death_prophet_carrion_swarm_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_death_prophet_15") then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
end

function death_prophet_carrion_swarm_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_death_prophet_16") then
        bonus = self.modifier_death_prophet_16[self:GetCaster():GetTalentLevel("modifier_death_prophet_16")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function death_prophet_carrion_swarm_custom:OnSpellStart()	
	if not IsServer() then return end

	local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end

	local start_radius = self:GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetSpecialValueFor( "end_radius" )
	local range = self:GetSpecialValueFor( "range" ) + self:GetCaster():GetCastRangeBonus()
	local speed = self:GetSpecialValueFor( "speed" )

	local vDirection = point - self:GetCaster():GetOrigin()
	vDirection.z = 0.0
	vDirection = vDirection:Normalized()

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_carrion_swarm.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 0, self:GetCaster():GetAbsOrigin() )
	ParticleManager:SetParticleControl( particle, 1, vDirection * speed )
	ParticleManager:SetParticleControl( particle, 2, Vector( start_radius, end_radius, 0 ) )
	ParticleManager:SetParticleControl( particle, 5, Vector( range / speed, 0, 0 ) )

	local info = 
	{
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetOrigin(), 
		fStartRadius = start_radius,
		fEndRadius = end_radius,
		vVelocity = vDirection * speed,
		fDistance = range,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		ExtraData = {particle = particle, original = 1}
	}

	ProjectileManager:CreateLinearProjectile( info )

	self:GetCaster():EmitSound("Hero_DeathProphet.CarrionSwarm")
end

function death_prophet_carrion_swarm_custom:OnProjectileHit_ExtraData( hTarget, vLocation, table )
	if hTarget == nil then
		if table and table.particle then
			ParticleManager:DestroyParticle(table.particle, false)
		end
		if table.original == 1 then
			if self:GetCaster():HasModifier("modifier_death_prophet_20") then
				self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_carrion_swarm_custom_back", {duration = self.modifier_death_prophet_20[self:GetCaster():GetTalentLevel("modifier_death_prophet_20")], x = vLocation.x, y = vLocation.y})
			end
		end
	end

	if hTarget ~= nil and ( not hTarget:IsMagicImmune() ) and ( not hTarget:IsInvulnerable() ) then
		
		local damage = self:GetSpecialValueFor("damage")

		local damage = 
		{
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}

		local death_prophet_exorcism_custom = self:GetCaster():FindAbilityByName("death_prophet_exorcism_custom")
        if death_prophet_exorcism_custom and death_prophet_exorcism_custom:GetLevel() > 0 then
        	if self:GetCaster():HasModifier("modifier_death_prophet_11") then
            	death_prophet_exorcism_custom:CastGhostToTarget(hTarget,death_prophet_exorcism_custom.modifier_death_prophet_13[self:GetCaster():GetTalentLevel("modifier_death_prophet_11")])
            end
        end

		ApplyDamage( damage )
	end
end

modifier_death_prophet_carrion_swarm_custom_back = class({})

function modifier_death_prophet_carrion_swarm_custom_back:IsPurgable() return false end
function modifier_death_prophet_carrion_swarm_custom_back:IsHidden() return true end
function modifier_death_prophet_carrion_swarm_custom_back:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_death_prophet_carrion_swarm_custom_back:OnCreated(params)
	if not IsServer() then return end
	self.direction = Vector(params.x,params.y,self:GetCaster():GetAbsOrigin().z)
end

function modifier_death_prophet_carrion_swarm_custom_back:OnDestroy()
	if not IsServer() then return end

	local start_radius = self:GetAbility():GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetAbility():GetSpecialValueFor( "end_radius" )
	local range = self:GetAbility():GetSpecialValueFor( "range" ) + self:GetCaster():GetCastRangeBonus()
	local speed = self:GetAbility():GetSpecialValueFor( "speed" )

	local point = self:GetCaster():GetAbsOrigin()

	local dire_2 = (self.direction - point):Normalized()

	local start_point = point + dire_2 * range

	local vDirection = point - start_point
	vDirection.z = 0.0
	vDirection = vDirection:Normalized()

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_carrion_swarm.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 0, start_point )
	ParticleManager:SetParticleControl( particle, 1, vDirection * speed )
	ParticleManager:SetParticleControl( particle, 2, Vector( start_radius, end_radius, 0 ) )
	ParticleManager:SetParticleControl( particle, 5, Vector( range / speed, 0, 0 ) )

	local info = 
	{
		Ability = self:GetAbility(),
		vSpawnOrigin = start_point, 
		fStartRadius = start_radius,
		fEndRadius = end_radius,
		vVelocity = vDirection * speed,
		fDistance = range,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		ExtraData = {particle = particle, original = 0}
	}

	ProjectileManager:CreateLinearProjectile( info )

	self:GetCaster():EmitSound("Hero_DeathProphet.CarrionSwarm")
end