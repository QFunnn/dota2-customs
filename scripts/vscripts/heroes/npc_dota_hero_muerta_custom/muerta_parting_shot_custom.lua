--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_muerta_parting_shot_custom", "heroes/npc_dota_hero_muerta_custom/muerta_parting_shot_custom", LUA_MODIFIER_MOTION_BOTH)

muerta_parting_shot_custom = class({})

function muerta_parting_shot_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	local info = 
    {
        EffectName = "particles/units/heroes/hero_muerta/muerta_parting_shot_projectile.vpcf",
        Ability = self,
        iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
        Source = self:GetCaster(),
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
    }

    self:GetCaster():EmitSound("Hero_Muerta.DeadShot.Cast")

	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_muerta_parting_shot_custom", 
		{
			duration = self:GetSpecialValueFor("knockback_duration"),
			distance = self:GetSpecialValueFor("knockback_distance"),
			direction_x = self:GetCaster():GetForwardVector().x,
			direction_y = self:GetCaster():GetForwardVector().y,
		})
	else
		ProjectileManager:CreateTrackingProjectile( info )
	end
end

function muerta_parting_shot_custom:OnProjectileHit(target, vLocation)
	if target == nil then return end

	if target:TriggerSpellAbsorb(self) then return end

	ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = self:GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL})

	local vec = target:GetOrigin()-self:GetCaster():GetAbsOrigin()
	vec.z = 0
	vec = vec:Normalized()

	target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_muerta_parting_shot_custom", 
	{
		duration = self:GetSpecialValueFor("knockback_duration"),
		distance = self:GetSpecialValueFor("knockback_distance"),
		direction_x = vec.x,
		direction_y = vec.y,
	})
end

modifier_generic_knockback_muerta_parting_shot_custom = class({})

function modifier_generic_knockback_muerta_parting_shot_custom:IsHidden()
	return true
end

function modifier_generic_knockback_muerta_parting_shot_custom:IsPurgable()
	return false
end

function modifier_generic_knockback_muerta_parting_shot_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_generic_knockback_muerta_parting_shot_custom:OnCreated( kv )
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

function modifier_generic_knockback_muerta_parting_shot_custom:OnRefresh( kv )
	if not IsServer() then return end
end

function modifier_generic_knockback_muerta_parting_shot_custom:OnDestroy( kv )
	if not IsServer() then return end

	if not self.interrupted then
		GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), 250, true )
	end

	if self.EndCallback then
		self.EndCallback( self.interrupted )
	end

	self:GetParent():InterruptMotionControllers( true )
end

function modifier_generic_knockback_muerta_parting_shot_custom:SetEndCallback( func ) 
	self.EndCallback = func
end

function modifier_generic_knockback_muerta_parting_shot_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return funcs
end

function modifier_generic_knockback_muerta_parting_shot_custom:GetOverrideAnimation( params )
	return ACT_DOTA_FLAIL
end

function modifier_generic_knockback_muerta_parting_shot_custom:UpdateHorizontalMotion( me, dt )
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.distance*(dt/self.duration)
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), 250, true )
	-- change position
	parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_generic_knockback_muerta_parting_shot_custom:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_generic_knockback_muerta_parting_shot_custom:UpdateVerticalMotion( me, dt )
	local time = dt/self.duration
	self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, self.vVelocity*dt ) )
	self.vVelocity = self.vVelocity - self.gravity*dt
end

function modifier_generic_knockback_muerta_parting_shot_custom:OnVerticalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_generic_knockback_muerta_parting_shot_custom:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_parting_shot_soul.vpcf"
end

function modifier_generic_knockback_muerta_parting_shot_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_generic_knockback_muerta_parting_shot_custom:StatusEffectPriority()
	return 10000
end

function modifier_generic_knockback_muerta_parting_shot_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_muerta_parting_shot.vpcf"
end