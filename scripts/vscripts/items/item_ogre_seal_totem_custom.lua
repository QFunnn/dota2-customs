--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_ogre_seal_totem_custom", "items/item_ogre_seal_totem_custom", LUA_MODIFIER_MOTION_BOTH )

item_ogre_seal_totem_custom = class({})

function item_ogre_seal_totem_custom:OnAbilityPhaseInterrupted()
	if not IsServer() then return end
	ParticleManager:DestroyParticle( self.nPreviewFXIndex, true )
end

function item_ogre_seal_totem_custom:OnSpellStart()
	if not IsServer() then return end

	if self.nPreviewFXIndex then
		ParticleManager:DestroyParticle( self.nPreviewFXIndex, true )
	end

	local vLocation = self:GetCaster():GetOrigin()
	local kv =
	{
		vLocX = vLocation.x,
		vLocY = vLocation.y,
		vLocZ = vLocation.z
	}
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_item_ogre_seal_totem_custom", kv )
end

function item_ogre_seal_totem_custom:TryToDamage()
	if not IsServer() then return end

	local radius = self:GetSpecialValueFor( "radius" )
	local stun_duration = self:GetSpecialValueFor( "stun_duration" )

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), self:GetCaster(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	for _,enemy in pairs(enemies) do
		if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
			enemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1 - enemy:GetStatusResistance()) } )
		end
	end

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "OgreTank.GroundSmash", self:GetCaster() )

	local nFXIndex = ParticleManager:CreateParticle( "particles/items_fx/ogre_seal_totem_smash.vpcf", PATTACH_WORLDORIGIN,  self:GetCaster()  )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	GridNav:DestroyTreesAroundPoint( self:GetCaster():GetOrigin(), radius, false )
end

modifier_item_ogre_seal_totem_custom = class({})

local OGRE_MINIMUM_HEIGHT_ABOVE_LOWEST = 150
local OGRE_MINIMUM_HEIGHT_ABOVE_HIGHEST = 33
local OGRE_ACCELERATION_Z = 1250
local OGRE_MAX_HORIZONTAL_ACCELERATION = 800

function modifier_item_ogre_seal_totem_custom:IsStunDebuff()
	return true
end

function modifier_item_ogre_seal_totem_custom:IsHidden()
	return true
end

function modifier_item_ogre_seal_totem_custom:IsPurgable()
	return false
end

function modifier_item_ogre_seal_totem_custom:RemoveOnDeath()
	return false
end

function modifier_item_ogre_seal_totem_custom:OnCreated( kv )
	if IsServer() then
		if self.nHopCount == nil then
			self.nHopCount = 1
			self.flop_distances = {325, 225, 200}
		end

		if self:GetCaster():IsRealHero() then
			self:GetCaster():StartGesture( ACT_DOTA_FLAIL )
		end

		self.bHorizontalMotionInterrupted = false
		self.bDamageApplied = false
		self.bTargetTeleported = false

		if self:ApplyHorizontalMotionController() == false or self:ApplyVerticalMotionController() == false then 
			self:Destroy()
			return
		end

		self.flTimer = 0.0
		self.vStartPosition = GetGroundPosition( self:GetParent():GetOrigin(), self:GetParent() )
		self.flCurrentTimeHoriz = 0.0
		self.flCurrentTimeVert = 0.0

		self.vLoc = Vector( kv.vLocX, kv.vLocY, kv.vLocZ ) + self:GetCaster():GetForwardVector() * self.flop_distances[ self.nHopCount ]
		self.vLastKnownTargetPos = self.vLoc

		local duration = self:GetAbility():GetSpecialValueFor( "duration" )
		local flDesiredHeight = OGRE_MINIMUM_HEIGHT_ABOVE_LOWEST * self.nHopCount * duration * duration
		local flLowZ = math.min( self.vLastKnownTargetPos.z, self.vStartPosition.z )
		local flHighZ = math.max( self.vLastKnownTargetPos.z, self.vStartPosition.z )
		local flArcTopZ = math.max( flLowZ + flDesiredHeight, flHighZ + OGRE_MINIMUM_HEIGHT_ABOVE_HIGHEST * self.nHopCount )

		local flArcDeltaZ = flArcTopZ - self.vStartPosition.z
		self.flInitialVelocityZ = math.sqrt( 2.0 * flArcDeltaZ * OGRE_ACCELERATION_Z * self.nHopCount )

		local flDeltaZ = self.vLastKnownTargetPos.z - self.vStartPosition.z
		local flSqrtDet = math.sqrt( math.max( 0, ( self.flInitialVelocityZ * self.flInitialVelocityZ ) - 2.0 * OGRE_ACCELERATION_Z * self.nHopCount * flDeltaZ ) )
		self.flPredictedTotalTime = math.max( ( self.flInitialVelocityZ + flSqrtDet) / ( OGRE_ACCELERATION_Z * self.nHopCount ), ( self.flInitialVelocityZ - flSqrtDet) / ( OGRE_ACCELERATION_Z * self.nHopCount ) )

		self.vHorizontalVelocity = ( self.vLastKnownTargetPos - self.vStartPosition ) / self.flPredictedTotalTime
		self.vHorizontalVelocity.z = 0.0

		
	end
end

function modifier_item_ogre_seal_totem_custom:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveHorizontalMotionController( self )
		self:GetParent():RemoveVerticalMotionController( self )

		if self:GetCaster():IsRealHero() then
			self:GetCaster():RemoveGesture( ACT_DOTA_FLAIL )
		end
	end
end

function modifier_item_ogre_seal_totem_custom:CheckState()
	local state =
	{
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

function modifier_item_ogre_seal_totem_custom:UpdateHorizontalMotion( me, dt )
	if IsServer() then
		self.flTimer = self.flTimer + dt
		self.flCurrentTimeHoriz = math.min( self.flCurrentTimeHoriz + dt, self.flPredictedTotalTime )
		local t = self.flCurrentTimeHoriz / self.flPredictedTotalTime
		local vStartToTarget = self.vLastKnownTargetPos - self.vStartPosition
		local vDesiredPos = self.vStartPosition + t * vStartToTarget

		-- Prevent players from hopping through obstructions (players can cast ogre seal flop with the Ogre Seal Totem item)
		if me:IsRealHero() then
   			--if ( not GridNav:CanFindPath( me:GetOrigin(), vDesiredPos ) ) then
				--self:Destroy()
				--return
			--end
		end

		local vOldPos = me:GetOrigin()
		local vToDesired = vDesiredPos - vOldPos
		vToDesired.z = 0.0
		local vDesiredVel = vToDesired / dt
		local vVelDif = vDesiredVel - self.vHorizontalVelocity
		local flVelDif = vVelDif:Length2D()
		vVelDif = vVelDif:Normalized()
		local flVelDelta = math.min( flVelDif, OGRE_MAX_HORIZONTAL_ACCELERATION * self.nHopCount )

		self.vHorizontalVelocity = self.vHorizontalVelocity + vVelDif * flVelDelta * dt
		local vNewPos = vOldPos + self.vHorizontalVelocity * dt
		me:SetOrigin( vNewPos )
	end
end

function modifier_item_ogre_seal_totem_custom:GetEffectName()
	return "particles/items_fx/ogre_seal_totem.vpcf"
end

function modifier_item_ogre_seal_totem_custom:UpdateVerticalMotion( me, dt )
	if IsServer() then
		self.flCurrentTimeVert = self.flCurrentTimeVert + dt
		local bGoingDown = ( -OGRE_ACCELERATION_Z * self.nHopCount * self.flCurrentTimeVert + self.flInitialVelocityZ ) < 0
		
		local vNewPos = me:GetOrigin()
		vNewPos.z = self.vStartPosition.z + ( -0.5 * OGRE_ACCELERATION_Z * self.nHopCount * ( self.flCurrentTimeVert * self.flCurrentTimeVert ) + self.flInitialVelocityZ * self.flCurrentTimeVert )

		local flGroundHeight = GetGroundHeight( vNewPos, self:GetParent() )
		local bLanded = false
		if ( vNewPos.z < flGroundHeight and bGoingDown == true ) then
			vNewPos.z = flGroundHeight
			bLanded = true
		end

		me:SetOrigin( vNewPos )
		if bLanded == true then

			local bDoneHopping = self.nHopCount == 2

			if self.bHorizontalMotionInterrupted == false then
				
					self:GetAbility():TryToDamage()
					self.flTimer = 0.0
			else
				bDoneHopping = true
			end

			if bDoneHopping then
				self:Destroy()
				
			else
				self.nHopCount = self.nHopCount + 1
				self.vLoc = self.vLoc + self:GetCaster():GetForwardVector() * self.flop_distances[ self.nHopCount ]
				local kv =
				{
					vLocX = self.vLoc.x,
					vLocY = self.vLoc.y,
					vLocZ = self.vLoc.z,
				}
				self:OnCreated( kv )
			end
		end
	end
end

function modifier_item_ogre_seal_totem_custom:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.bHorizontalMotionInterrupted = true
	end
end

function modifier_item_ogre_seal_totem_custom:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_item_ogre_seal_totem_custom:GetOverrideAnimation( params )
	return ACT_DOTA_OVERRIDE_ABILITY_2
end
