--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_knockback", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_silence", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_buff", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_BOTH )

drow_ranger_wave_of_silence_custom = class({})


drow_ranger_wave_of_silence_custom.modifier_drow_ranger_15_bonus_ms = {12,24,36}
drow_ranger_wave_of_silence_custom.modifier_drow_ranger_17_damage_frommana = {10,15,20}
drow_ranger_wave_of_silence_custom.modifier_drow_ranger_17_base_damage = 125
drow_ranger_wave_of_silence_custom.modifier_drow_ranger_18_cooldown = {-2,-4}

function drow_ranger_wave_of_silence_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_silence_wave.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_hero_silence.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_stunned.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_silenced.vpcf", context )
end

function drow_ranger_wave_of_silence_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_drow_ranger_18") then
		bonus = self.modifier_drow_ranger_18_cooldown[self:GetCaster():GetTalentLevel("modifier_drow_ranger_18")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function drow_ranger_wave_of_silence_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_drow_ranger_19") then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AUTOCAST
	end
	return DOTA_ABILITY_BEHAVIOR_POINT
end

function drow_ranger_wave_of_silence_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	local speed = self:GetSpecialValueFor( "wave_speed" )
	local width = self:GetSpecialValueFor( "wave_width" )

	if point == self:GetCaster():GetAbsOrigin() then
		point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
	end

	local projectile_distance = self:GetCastRange( point, nil )

	local projectile_direction = point-self:GetCaster():GetOrigin()

	projectile_direction.z = 0

	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = self:GetCaster(),
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
	    bDeleteOnHit = false,
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = flag,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    EffectName = "particles/units/heroes/hero_drow/drow_silence_wave.vpcf",
	    fDistance = projectile_distance,
	    fStartRadius = width,
	    fEndRadius = width,
		vVelocity = projectile_direction * speed,
		ExtraData = { x = self:GetCaster():GetOrigin().x, y = self:GetCaster():GetOrigin().y, z = self:GetCaster():GetOrigin().z, pointx= point.x, pointy=point.y, pointz=point.z }
	}

	self.targets = {}

	if self:GetCaster():HasModifier("modifier_drow_ranger_22") then
		i = 0
	    for var=1,8, 1 do
	        ProjectileManager:CreateLinearProjectile(projectile)
	        info.vVelocity = RotatePosition(Vector(0,0,0), QAngle(0,i,0), caster:GetForwardVector()) * speed
	        i = i + 45
	        ProjectileManager:CreateLinearProjectile(info)
	    end
	else
		ProjectileManager:CreateLinearProjectile(info)
	end

	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_drow_ranger_wave_of_silence_custom_buff", {duration = self:GetSpecialValueFor("silence_duration")})

	self:GetCaster():EmitSound("Hero_DrowRanger.Silence")
end

function drow_ranger_wave_of_silence_custom:OnProjectileHit_ExtraData( target, location, data )
	if target == nil and self:GetCaster():HasModifier("modifier_drow_ranger_19") and not self:GetAutoCastState() then
		local vector = Vector(data.pointx,data.pointy,data.pointz)
		local vector2 = Vector(data.x,data.y,data.z)

		local direction = (vector - vector2)
	    if direction:Length2D() > self:GetCastRange( vector, nil ) then
	        direction = direction:Normalized() * self:GetCastRange( vector, nil )
	    end
	    if not self:GetCaster():HasModifier("modifier_wodarelax_invul") then
            if not self:GetCaster():IsRooted() then
		        FindClearSpaceForUnit(self:GetCaster(), vector, true)
            end
        end
	end

	if not target then return end

	if self.targets[target:entindex()] ~= nil then return end
	self.targets[target:entindex()] = target

	local silence = self:GetSpecialValueFor( "silence_duration" )
	local duration = self:GetSpecialValueFor( "knockback_duration" )
	local max_dist = self:GetSpecialValueFor( "knockback_distance_max" )

	local vec = target:GetOrigin()-Vector(data.x,data.y,0)

	vec.z = 0

	local distance = vec:Length2D()

	distance = (1-distance/self:GetCastRange( Vector(0,0,0), nil ))*max_dist

	if max_dist<0 then distance = 0 end

	vec = vec:Normalized()

	if self:GetCaster():HasModifier("modifier_drow_ranger_17") then
		local damage = (self:GetCaster():GetMana() / 100 * self.modifier_drow_ranger_17_damage_frommana[self:GetCaster():GetTalentLevel("modifier_drow_ranger_17")]) + self.modifier_drow_ranger_17_base_damage
		ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
	end

	target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_wave_of_silence_custom_knockback", { duration = duration, distance = distance, direction_x = vec.x, direction_y = vec.y } )
	target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_wave_of_silence_custom_silence", { duration = silence } )
	self:PlayEffects( target )
end

function drow_ranger_wave_of_silence_custom:PlayEffects( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_hero_silence.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_drow_ranger_wave_of_silence_custom_knockback = class({})

function modifier_drow_ranger_wave_of_silence_custom_knockback:IsHidden()
	return true
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:IsPurgable()
	return false
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:OnCreated( kv )
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

		if self.duration == 0 then
			self:Destroy()
			return
		end

		self.parent = self:GetParent()
		self.origin = self.parent:GetOrigin()

		self.hVelocity = self.distance/self.duration

		local half_duration = self.duration/2
		self.gravity = 2*self.height/(half_duration*half_duration)
		self.vVelocity = self.gravity*half_duration

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

function modifier_drow_ranger_wave_of_silence_custom_knockback:OnDestroy( kv )
	if not IsServer() then return end

	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), 150, true )

	if self.EndCallback then
		self.EndCallback( self.interrupted )
	end

	--self:GetParent():InterruptMotionControllers( true )
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:SetEndCallback( func ) 
	self.EndCallback = func
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return funcs
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:GetOverrideAnimation( params )
	if self.anim==1 then
		return ACT_DOTA_FLAIL
	elseif self.anim==2 then
		return ACT_DOTA_DISABLED
	end
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.stun,
	}

	return state
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:UpdateHorizontalMotion( me, dt )
	local parent = self:GetParent()
	local target = self.direction*self.distance*(dt/self.duration)
    if parent:GetIdealSpeed() < 100 then return end
	parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:UpdateVerticalMotion( me, dt )
	local time = dt/self.duration
	self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, self.vVelocity*dt ) )
	self.vVelocity = self.vVelocity - self.gravity*dt
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:OnVerticalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:GetEffectName()
	if not IsServer() then return end
	if self.stun then
		return "particles/generic_gameplay/generic_stunned.vpcf"
	end
end

function modifier_drow_ranger_wave_of_silence_custom_knockback:GetEffectAttachType()
	if not IsServer() then return end
	return PATTACH_OVERHEAD_FOLLOW
end

modifier_drow_ranger_wave_of_silence_custom_silence = class({})

function modifier_drow_ranger_wave_of_silence_custom_silence:IsDebuff()
	return true
end

function modifier_drow_ranger_wave_of_silence_custom_silence:IsPurgable() return true end

function modifier_drow_ranger_wave_of_silence_custom_silence:OnCreated( kv )
	if not IsServer() then return end
	local resist = 1-self:GetParent():GetStatusResistance()
	local duration = kv.duration*resist
	self:SetDuration( duration, true )
end

function modifier_drow_ranger_wave_of_silence_custom_silence:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_drow_ranger_wave_of_silence_custom_silence:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}
	return state
end

function modifier_drow_ranger_wave_of_silence_custom_silence:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_drow_ranger_wave_of_silence_custom_silence:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

modifier_drow_ranger_wave_of_silence_custom_buff = class({})

function modifier_drow_ranger_wave_of_silence_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_drow_ranger_wave_of_silence_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_drow_ranger_15") then
		bonus = self:GetAbility().modifier_drow_ranger_15_bonus_ms[self:GetCaster():GetTalentLevel("modifier_drow_ranger_15")]
	end
	return self:GetAbility():GetSpecialValueFor("bonus_movespeed") + bonus
end