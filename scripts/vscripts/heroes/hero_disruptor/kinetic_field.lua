--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_disruptor_kinetic_field", "heroes/hero_disruptor/kinetic_field", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_disruptor_kinetic_field_buff", "heroes/hero_disruptor/kinetic_field", LUA_MODIFIER_MOTION_NONE )

if ability_disruptor_kinetic_field == nil then
	ability_disruptor_kinetic_field = class({})
end

function ability_disruptor_kinetic_field:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf", context)
end

function ability_disruptor_kinetic_field:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	CreateModifierThinker(
		caster,
		self,
		"modifier_ability_disruptor_kinetic_field",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)
end

modifier_ability_disruptor_kinetic_field = class({
	IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,
	GetAttributes			= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,

	IsAura                  = function(self) return self.owner and self.formed end,
    GetAuraDuration         = function(self) return 0.5 end,
    GetAuraRadius           = function(self) return self.radius + 100 or 0 end,
    GetAuraSearchFlags      = function(self) return DOTA_UNIT_TARGET_FLAG_NONE end,
    GetAuraSearchTeam       = function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
    GetAuraSearchType       = function(self) return DOTA_UNIT_TARGET_HEROES_AND_CREEPS end,
    GetModifierAura         = function(self) return "modifier_ability_disruptor_kinetic_field" end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_MOVESPEED_LIMIT
		}
	end,

	OnCreated				= function(self, kv)
		if not IsServer() then return end
		local ability = self:GetAbility()
		if ability then
			self.radius =  ability:GetSpecialValueFor( "radius" )
			self.BonusEvasion =  ability:GetSpecialValueFor( "bonus_evasion" )
		end

		self.owner = kv.isProvidedByAura~=1

		if self.owner then
			self.delay = ability:GetSpecialValueFor( "formation_time" )
			self.duration = ability:GetSpecialValueFor( "duration" )
			
			self:SetDuration( self.delay + self.duration, false )

			self.formed = false
			self:StartIntervalThink( self.delay )

			self:PlayEffects1()
			self.sound_loop = "Hero_Disruptor.KineticField"
			EmitSoundOn( self.sound_loop, self:GetParent() )
		else
			self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
			self.parent = self:GetParent()
			self.width = 100
			self.max_speed = 550
			self.min_speed = 0.1
			self.max_min = self.max_speed-self.min_speed

			self.limit = 0

			self.TimeToUnlock = 0

			self.inside = (self.parent:GetOrigin()-self.aura_origin):Length2D() < self.radius

			self:GetParent():AddNewModifier(self:GetCaster(), ability, "modifier_disruptor_kinetic_field", {})

			self:StartIntervalThink(0.03)
		end
	end,

	OnIntervalThink			= function(self)
		if self.owner then
			if self.formed == false then
				local time = self.BonusEvasion > 0 and 0.03 or -1
				self:StartIntervalThink( time )
				self.formed = true

				self:PlayEffects2()
			elseif self.BonusEvasion > 0 then
				local All = FindUnitsInRadius(
					self:GetParent():GetTeamNumber(), 
					self:GetParent():GetAbsOrigin(), 
					nil, 
					self.radius, 
					DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
					DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
					FIND_ANY_ORDER, 
					false
				)
				for _, unit in ipairs(All) do
					unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ability_disruptor_kinetic_field_buff", {duration=0.5})
				end
			end
		else
			local parent_vector = self.parent:GetOrigin()-self.aura_origin
			local parent_direction = parent_vector:Normalized()

			local actual_distance = parent_vector:Length2D()
			local wall_distance = actual_distance-self.radius
			local in_wall = math.abs(wall_distance) <= self.width

			if self.inside ~= (wall_distance < 0) then
				if math.abs(wall_distance) > self.width then
					self.inside = not self.inside
				end
			end

			if in_wall then
				self:CheckMotions()
			end

			if GameRules:GetGameTime() > self.TimeToUnlock then
				-- self:GetParent():RemoveHorizontalMotionController(self)
			end

			-- self:RemoveMotions()

			wall_distance = math.abs(wall_distance)
			if wall_distance>self.width then
				self.limit = 0
			end

			local parent_angle = 0
			if self.inside then
				parent_angle = VectorToAngles(parent_direction).y
			else
				parent_angle = VectorToAngles(-parent_direction).y
			end
			local unit_angle = self:GetParent():GetAnglesAsVector().y
			local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )

			if wall_angle<=90 then
				if in_wall then
					self.limit = self.min_speed
				end
				self.limit = (wall_distance/self.width)*self.max_min + self.min_speed
			else
				self.limit = 0
			end
		end
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end
		if self.owner then
			StopSoundOn( self.sound_loop, self:GetParent() )
			local sound_end = "Hero_Disruptor.KineticField.End"
			EmitSoundOn( sound_end, self:GetParent() )

			UTIL_Remove( self:GetParent() )
		else
			self:GetParent():RemoveModifierByName("modifier_disruptor_kinetic_field")
			self:GetParent():RemoveHorizontalMotionController(self)
		end
	end,

	GetModifierMoveSpeed_Limit		= function(self, event)
		if not IsServer() then return end
		if self.owner then return 0 end

		return self.limit
	end,

	GetMotionPriority	= function(self)
		return DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM
	end,

	CheckMotions		= function(self)
		local StopModifiers = {
			"modifier_item_forcestaff_active",
			"modifier_mirana_leap",
			"modifier_slark_pounce",
			"modifier_monkey_king_bounce",
			"modifier_monkey_king_bounce_leap",
			"modifier_phoenix_sun_ray",
			"modifier_item_hurricane_pike_active",
			"modifier_item_hurricane_pike_active_alternate",
		}

		for _, modifName in ipairs(StopModifiers) do
			if self.parent:HasModifier(modifName) then
			-- if true then
				self.parent:InterruptMotionControllers(false)
				-- self:ApplyHorizontalMotionController()
				-- self.TimeToUnlock = GameRules:GetGameTime() + 0.04
				break
			end
		end
	end,

	UpdateHorizontalMotion		= function(self, me, dt)
		local direction = CalculateDirection(self.parent:GetAbsOrigin(), self.aura_origin)
		local Radius = self.inside and self.radius - 50 or self.radius + 50
		local MaxPos = self.aura_origin + direction * Radius
		self.parent:SetAbsOrigin(GetGroundPosition(MaxPos, self.parent))
	end,

	PlayEffects1		= function(self)
		local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf"

		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.delay, 0, 0 ) )
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end,

	PlayEffects2		= function(self)
		local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf"

		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.duration, 0, 0 ) )
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end,
})

modifier_ability_disruptor_kinetic_field_buff = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_EVASION_CONSTANT
		}
	end,

	GetModifierEvasion_Constant			= function(self)
		return self.BonusEvasion or 0
	end,

	OnCreated				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.BonusEvasion = ability:GetSpecialValueFor( "bonus_evasion" )
		end
	end,

	OnRefresh				= function(self)
		self:OnCreated()
	end,
})