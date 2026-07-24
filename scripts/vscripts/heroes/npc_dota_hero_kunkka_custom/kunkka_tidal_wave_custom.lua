--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_tidal_wave_custom", "heroes/npc_dota_hero_kunkka_custom/kunkka_tidal_wave_custom", LUA_MODIFIER_MOTION_BOTH)

kunkka_tidal_wave_custom = class({})
kunkka_tidal_wave_custom.modifier_kunkka_19 = {100,200,300}

function kunkka_tidal_wave_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_shard_tidal_wave.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_stunned.vpcf", context )
end

function kunkka_tidal_wave_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
	
	local direction = point - self:GetCaster():GetAbsOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local direction_2 = self:GetCaster():GetAbsOrigin() - point
	direction_2.z = 0
	direction_2 = direction_2:Normalized()

	local point_start = self:GetCaster():GetAbsOrigin() + direction_2 * 900

	local speed = self:GetSpecialValueFor("speed")
	local radius = 300
	local distance = self:GetSpecialValueFor("distance")

	local info = 
	{
		Ability = self,
		Source = self:GetCaster(),
		EffectName = "particles/units/heroes/hero_kunkka/kunkka_shard_tidal_wave.vpcf",
		vSpawnOrigin = point_start,
		vVelocity = direction * speed,
		fDistance = 2300,
		fStartRadius = radius,
		fEndRadius = radius,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		ExtraData = {x = direction.x, y = direction.y}
	}

	EmitSoundOnLocationWithCaster( point_start, "Hero_Kunkka.TidalWave", self:GetCaster() )
	EmitSoundOnLocationWithCaster( point, "Hero_Kunkka.TidalWave", self:GetCaster() )

	ProjectileManager:CreateLinearProjectile(info)
end

function kunkka_tidal_wave_custom:OnProjectileHit_ExtraData(target, vLocation, ExtraData)
	if target then
        if not target:IsDebuffImmune() then
            target:AddNewModifier( self:GetCaster(), self, "modifier_kunkka_tidal_wave_custom", { duration = self:GetSpecialValueFor("duration"), distance = self:GetSpecialValueFor("knockback_distance"), height = 0, direction_x = ExtraData.x, direction_y = ExtraData.y})
        end
        local damage = self:GetSpecialValueFor("damage")
        if self:GetCaster():HasModifier("modifier_kunkka_19") then
            damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_kunkka_19[self:GetCaster():GetTalentLevel("modifier_kunkka_19")])
        end
        ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
        target:EmitSound("Hero_Kunkka.TidalWave.Target")
	end
end

modifier_kunkka_tidal_wave_custom = class({})

function modifier_kunkka_tidal_wave_custom:IsHidden()
	return true
end

function modifier_kunkka_tidal_wave_custom:IsPurgable()
	return false
end

function modifier_kunkka_tidal_wave_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_kunkka_tidal_wave_custom:OnCreated( kv )
	if IsServer() then
		self.distance = kv.distance or 0
		self.height = kv.height or -1
		self.duration = kv.duration or 0
		if kv.direction_x and kv.direction_y then
			self.direction = Vector(kv.direction_x,kv.direction_y,0):Normalized()
		else
			self.direction = -(self:GetParent():GetForwardVector())
		end
		self.tree = kv.tree_destroy_radius or self:GetParent():GetHullRadius()

		if kv.IsStun then self.stun = kv.IsStun==1 else self.stun = false end
		if kv.IsFlail then self.flail = kv.IsFlail==1 else self.flail = true end

		-- check duration
		if self.duration == 0 then
			self:Destroy()
			return
		end

		-- load data
		self.parent = self:GetParent()
		self.origin = self.parent:GetOrigin()

		-- horizontal init
		self.hVelocity = self.distance/self.duration

		-- vertical init
		local half_duration = self.duration/2
		self.gravity = 2*self.height/(half_duration*half_duration)
		self.vVelocity = self.gravity*half_duration

		-- apply motion controllers
		if self.distance>0 then
			if self:ApplyHorizontalMotionController() == false then 
				self:Destroy()
				return
			end
		end
		if self.height>=0 then
			if self:ApplyVerticalMotionController() == false then 
				self:Destroy()
				return
			end
		end

		-- tell client of activity
		if self.flail then
			self:SetStackCount( 1 )
		elseif self.stun then
			self:SetStackCount( 2 )
		end
	else
		self.anim = self:GetStackCount()
		self:SetStackCount( 0 )
	end
end

function modifier_kunkka_tidal_wave_custom:OnRefresh( kv )
	if not IsServer() then return end
end

function modifier_kunkka_tidal_wave_custom:OnDestroy( kv )
	if not IsServer() then return end

	if not self.interrupted then
		-- destroy trees
		if self.tree>0 then
			GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree, true )
		end
	end

	if self.EndCallback then
		self.EndCallback( self.interrupted )
	end

	self:GetParent():InterruptMotionControllers( true )
end

--------------------------------------------------------------------------------
-- Setter
function modifier_kunkka_tidal_wave_custom:SetEndCallback( func ) 
	self.EndCallback = func
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_kunkka_tidal_wave_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_kunkka_tidal_wave_custom:GetOverrideAnimation( params )
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_kunkka_tidal_wave_custom:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_kunkka_tidal_wave_custom:UpdateHorizontalMotion( me, dt )
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.distance*(dt/self.duration)

	if parent:GetIdealSpeed() < 100 then return end
	parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_kunkka_tidal_wave_custom:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_kunkka_tidal_wave_custom:UpdateVerticalMotion( me, dt )
	-- set time
	local time = dt/self.duration

	-- change height
	self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, self.vVelocity*dt ) )

	-- calculate vertical velocity
	self.vVelocity = self.vVelocity - self.gravity*dt
end

function modifier_kunkka_tidal_wave_custom:OnVerticalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_kunkka_tidal_wave_custom:GetEffectName()
	if not IsServer() then return end
	if self.stun then
		return "particles/generic_gameplay/generic_stunned.vpcf"
	end
end

function modifier_kunkka_tidal_wave_custom:GetEffectAttachType()
	if not IsServer() then return end
	return PATTACH_OVERHEAD_FOLLOW
end