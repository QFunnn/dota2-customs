--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_grimstroke_soul_chain_creep = class({})
local tempTable = require("utils/tempTable")

function modifier_grimstroke_soul_chain_creep:IsHidden()
	return true
end

function modifier_grimstroke_soul_chain_creep:IsDebuff()
	return true
end

function modifier_grimstroke_soul_chain_creep:IsStunDebuff()
	return false
end

function modifier_grimstroke_soul_chain_creep:IsPurgable()
	return false
end

function modifier_grimstroke_soul_chain_creep:OnCreated( kv )
	if IsServer() then
		self.primary = (kv.primary==1)
		if kv.pair then
			self.pair = tempTable:RetATValue( kv.pair )
		else
			self.pair = nil
		end
		self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow" )
		self.radius = self:GetAbility():GetSpecialValueFor( "chain_latch_radius" )
		self.buffer = self:GetAbility():GetSpecialValueFor( "leash_radius_buffer" )
		self.buffer_radius = self.radius - self.buffer
		self.break_radius = self:GetAbility():GetSpecialValueFor( "chain_break_distance" )
		self.search_tick = 0.1
		self.normal_ms_limit = 550
		self.limit = self.normal_ms_limit
		self:StartIntervalThink( self.search_tick )
		self:OnIntervalThink()
		self:PlayEffects1( self.primary )
	end
end

function modifier_grimstroke_soul_chain_creep:OnRefresh( kv )
	if IsServer() then
		self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow" )
		if kv.pair then
			self.pair = tempTable:RetATValue( kv.pair )
		end

		-- refresh duration
		if not kv.duration then
			self:SetDuration( -1, true )
		else
			self:SetDuration( kv.duration, true )
		end

		-- check if non-primary being refreshed as primary
		if (kv.primary==1) and (not self.primary) then
			self.primary = true
			self.pair.primary = false
		end

		-- if primary, refresh pair if available
		if self.primary and self.pair and (not self.pair:IsNull()) then
			local pair = tempTable:AddATValue( self )
			self.pair = self.pair:GetParent():AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_grimstroke_soul_chain_creep", -- modifier name
				{
					primary = false,
					pair = pair,
				} -- kv
			)
		end

	end
end

function modifier_grimstroke_soul_chain_creep:OnRemoved()
	if IsServer() then
		if self.primary and self.pair and (not self.pair:IsNull()) then
			self:PlayEffects2( false )
		end
	end
end

function modifier_grimstroke_soul_chain_creep:OnDestroy( kv )
	if IsServer() then
		-- destroy the pair, if still exist
		if self.primary and self.pair and (not self.pair:IsNull()) then
			self.pair:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_grimstroke_soul_chain_creep:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_grimstroke_soul_chain_creep:CheckState()
	return {
		[MODIFIER_STATE_DISARMED]=true,
		[MODIFIER_STATE_PASSIVES_DISABLED]=true,
	}
end

function modifier_grimstroke_soul_chain_creep:GetEffectName()
	return "particles/items2_fx/heavens_halberd_debuff_disarm.vpcf"
end

function modifier_grimstroke_soul_chain_creep:OnAbilityFullyCast( params )
	if IsServer() then
		if not self.pair then return end
		if not params.target then return end
		if params.target~=self:GetParent() then return end
		if params.ability==self:GetAbility() then return end
		if params.ability.soulbind then return end
		if params.unit:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end
		local ready = false
		if params.ability:IsCooldownReady() then
			ready = true
		end
		params.ability:EndCooldown()
		params.ability:RefundManaCost()
		params.ability.soulbind = true
		params.unit:SetCursorCastTarget( self.pair:GetParent() )
		params.ability:CastAbility()
		params.ability.soulbind = nil
		if not (params.ability:IsCooldownReady()==ready) then
			params.ability:EndCooldown()
		end
		self:PlayEffects3()
	end
end

function modifier_grimstroke_soul_chain_creep:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_grimstroke_soul_chain_creep:GetModifierMoveSpeed_Limit()
	if IsServer() then
		-- zero is no limit
		return self.limit
	end
end

function modifier_grimstroke_soul_chain_creep:OnIntervalThink()
    if not IsServer() then return end
    if self.pair ~= nil and self.pair:IsNull() then
        self:Destroy()
        return
    end
	if self.primary and (not self.pair) then
		self:FindPair()
	end
	if self.pair then
		self:Bind()
	end
end

function modifier_grimstroke_soul_chain_creep:FindPair()
	-- find enemy heroes
	local heroes = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- find targeted heroes
	local target = nil
	for _,hero in pairs(heroes) do
		if hero~=self:GetParent() then
			-- check if already has modifier
			if (not hero:HasModifier( "modifier_grimstroke_soul_chain_creep" )) then
				target = hero
				break
			end
		end
	end

    print(#heroes, target)

	-- add found target
	if target then
		local pair = tempTable:AddATValue( self )
		self.pair = target:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_grimstroke_soul_chain_creep", -- modifier name
			{
				primary = false,
				pair = pair,
			} -- kv
		)

		self:PlayEffects2( true )
	end
end

function modifier_grimstroke_soul_chain_creep:Bind()
	local vectorToPair = self.pair:GetParent():GetOrigin() - self:GetParent():GetOrigin()
	local facingAngle = self:GetParent():GetAnglesAsVector().y

	-- calculate facing angle
	local angleToPair = VectorToAngles(vectorToPair).y
	local angleDifference = math.abs(AngleDiff( angleToPair, facingAngle ))

	-- calculate distance
	local distanceToPair = vectorToPair:Length2D()

	-- check if it is within boundaries
	if distanceToPair < self.buffer_radius then
		-- within limit
		self.limit = self.normal_ms_limit

	elseif distanceToPair < self.break_radius then
		-- slowed if facing away
		if angleDifference > 90 then
			-- slow interpolates linearly between buffer radius and chain radius
			local interpolate = math.min( (distanceToPair-self.buffer_radius)/self.buffer, 1 )

			-- slow inversely related with interpolation
			self.limit = (1-interpolate) * self.normal_ms_limit

			-- 0 limit means no limit
			if self.limit < 1 then
				self.limit = 0.01
			end
		else
			-- not slowed if facing towards pair
			self.limit = self.normal_ms_limit
		end

		-- interrupts weak motion controllers
		self:GetParent():InterruptMotionControllers( true )
	else
		-- outside, break
		self.limit = self.normal_ms_limit
		if self.primary then
			self.pair:Destroy()
			self.pair = nil
			self:PlayEffects2( false )
		end
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_soul_chain_creep:PlayEffects1( primary )
	-- Get Resources
	local particle_cast1 = "particles/units/heroes/hero_grimstroke/grimstroke_soulchain_debuff.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_grimstroke/grimstroke_soulchain_marker.vpcf"
	local sound_target = "Hero_Grimstroke.SoulChain.Target"

	-- Create Particle
	local effect_cast1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast1,
		2,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast1,
		false,
		false,
		-1,
		false,
		false
	)

	if primary then
		-- create marker
		local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )

		self:AddParticle(
			effect_cast2,
			false,
			false,
			-1,
			false,
			true
		)
	end

	-- Create Sound
	EmitSoundOn( sound_target, target )
end

function modifier_grimstroke_soul_chain_creep:PlayEffects2( connect )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_soulchain.vpcf"
	local sound_cast = "Hero_Grimstroke.SoulChain.Partner"

	if connect then
		-- Create Particle
		self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt(
			self.effect_cast,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControlEnt(
			self.effect_cast,
			1,
			self.pair:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0,0,0), -- unknown
			true -- unknown, true
		)

		-- Create Sound
		EmitSoundOn( sound_cast, self.pair:GetParent() )
	else
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

function modifier_grimstroke_soul_chain_creep:PlayEffects3()
	-- Get Resources
	local particle_cast1 = "particles/units/heroes/hero_grimstroke/grimstroke_soulchain_proc.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_grimstroke/grimstroke_soulchain_proc_tgt.vpcf"

	-- Create chain proc particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.pair:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create main proc particle
	effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create pair proc particle
	effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self.pair:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.pair:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_grimstroke_soul_chain_debuff_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,

	CheckState		= function(self)
		return {
			[MODIFIER_STATE_PASSIVES_DISABLED]=true,
		}
	end,

	OnCreated				= function(self)
		if not IsServer() then return end

		self:StartIntervalThink(0.1)
	end,

	OnIntervalThink			= function(self)
		local parent = self:GetParent()

		if not parent or parent:IsNull() then return end

		if not parent:HasModifier("modifier_grimstroke_soul_chain") then
			self:Destroy()
		end
	end,
})