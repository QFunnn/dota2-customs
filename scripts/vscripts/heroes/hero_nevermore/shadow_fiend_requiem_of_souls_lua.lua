--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


shadow_fiend_requiem_of_souls_lua = class({})
LinkLuaModifier( "modifier_shadow_fiend_requiem_of_souls_lua", "heroes/hero_nevermore/modifier_shadow_fiend_requiem_of_souls_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_shadow_fiend_requiem_of_souls_lua_scepter", "heroes/hero_nevermore/modifier_shadow_fiend_requiem_of_souls_lua_scepter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function shadow_fiend_requiem_of_souls_lua:OnAbilityPhaseStart()
	self:PlayEffects1()
	return true -- if success
end
function shadow_fiend_requiem_of_souls_lua:OnAbilityPhaseInterrupted()
	self:StopEffects1( false )
end
--------------------------------------------------------------------------------

function shadow_fiend_requiem_of_souls_lua:GetCooldown(level)
   return self.BaseClass.GetCooldown(self, level)
end

--------------------------------------------------------------------------------
-- Ability Start
function shadow_fiend_requiem_of_souls_lua:OnSpellStart()

	--线条数为上限，18条
	local lines = 18
    
    if self:GetCaster():HasScepter() then
       lines = 23
    end

	self:Explode( lines )

	-- if has scepter, add modifier to implode
	if self:GetCaster():HasScepter() then
		local explodeDuration = self:GetSpecialValueFor("requiem_radius") / self:GetSpecialValueFor("requiem_line_speed")
		self:GetCaster():AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_shadow_fiend_requiem_of_souls_lua_scepter",
			{
				lineDuration = explodeDuration,
				lineNumber = lines,
			}
		)
	end
end

--------------------------------------------------------------------------------
-- Projectile Hit
function shadow_fiend_requiem_of_souls_lua:OnProjectileHit_ExtraData( hTarget, vLocation, params )
	if hTarget ~= nil then
		-- filter
		pass = false
		if hTarget:GetTeamNumber()~=self:GetCaster():GetTeamNumber() then
			pass = true
		end

		if pass then
			-- check if it is from explode or implode
			if params and params.scepter then

				-- reduce the damage
				damage = self.damage * (self.damage_pct/100)

				-- add to heal calculation
				if hTarget:IsHero() then
					local modifier = self:RetATValue( params.modifier )
					if modifier and not modifier:IsNull() then
					   modifier:AddTotalHeal( damage )
				   end
				end
			end

			if not hTarget:HasModifier("modifier_nevermore_requiem_fear") then
				hTarget:AddNewModifier(self:GetCaster(), self, "modifier_nevermore_requiem_fear", {duration  = 0.9 * (1 - hTarget:GetStatusResistance())})
			else
				hTarget:FindModifierByName("modifier_nevermore_requiem_fear"):SetDuration(math.min(hTarget:FindModifierByName("modifier_nevermore_requiem_fear"):GetRemainingTime() + 0.9, 2.7) * (1 - hTarget:GetStatusResistance()), true)
			end

			-- damage target
			local damage = {
				victim = hTarget,
				attacker = self:GetCaster(),
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}
			ApplyDamage( damage )

			-- apply modifier
			hTarget:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_shadow_fiend_requiem_of_souls_lua",
				{ duration = self.duration }
			)
		end
	end

	return false
end

--------------------------------------------------------------------------------
-- Triggers
function shadow_fiend_requiem_of_souls_lua:OnOwnerDied()
	-- do nothing if not learned
	if self:GetLevel()<1 then return end

	-- get number of souls
	local lines = 9
	if self:GetCaster():HasScepter() then
       lines = 12
    end

	-- explode
	self:Explode(lines)
end

--------------------------------------------------------------------------------
-- Helper
function shadow_fiend_requiem_of_souls_lua:Explode( lines )
	-- get references
	self.damage =  self:GetAbilityDamage()
	self.duration = self:GetSpecialValueFor("requiem_slow_duration")

	-- get projectile
	local line_length = self:GetSpecialValueFor("requiem_radius")
	local width_start = self:GetSpecialValueFor("requiem_line_width_start")
	local width_end = self:GetSpecialValueFor("requiem_line_width_end")
	local line_speed = self:GetSpecialValueFor("requiem_line_speed")

	-- create linear projectile
	local initial_angle_deg = self:GetCaster():GetAnglesAsVector().y
	local delta_angle = 360/lines
	for i=0,lines-1 do
		-- Determine velocity
		local facing_angle_deg = initial_angle_deg + delta_angle * i
		if facing_angle_deg>360 then facing_angle_deg = facing_angle_deg - 360 end
		local facing_angle = math.rad(facing_angle_deg)
		local facing_vector = Vector( math.cos(facing_angle), math.sin(facing_angle), 0 ):Normalized()
		local velocity = facing_vector * line_speed

		-- create projectile
		local info = {
			Source = self:GetCaster(),
			Ability = self,
			EffectName = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf",
			vSpawnOrigin = self:GetCaster():GetOrigin(),
			fDistance = line_length,
			vVelocity = velocity,
			fStartRadius = width_start,
			fEndRadius = width_end,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_SPELL_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			bReplaceExisting = false,
			bProvidesVision = false,
		}
		ProjectileManager:CreateLinearProjectile( info )

		local particle_lines_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(particle_lines_fx, 0, self:GetCaster():GetAbsOrigin())
		ParticleManager:SetParticleControl(particle_lines_fx, 1, velocity)
		ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, line_length/line_speed, 0))
		ParticleManager:ReleaseParticleIndex(particle_lines_fx)
	end

	-- Play effects
	self:StopEffects1( true )
	self:PlayEffects2( lines )
end

function shadow_fiend_requiem_of_souls_lua:Implode( lines, modifier )
	-- get data
	self.damage_pct = self:GetSpecialValueFor("requiem_damage_pct_scepter")
	self.damage_heal_pct = self:GetSpecialValueFor("requiem_heal_pct_scepter")

	-- create identifier
	local modifierAT = self:AddATValue( modifier )
	modifier.identifier = modifierAT

	-- get projectile
	local line_length = self:GetSpecialValueFor("requiem_radius")
	local width_start = self:GetSpecialValueFor("requiem_line_width_end")
	local width_end = self:GetSpecialValueFor("requiem_line_width_start")
	local line_speed = self:GetSpecialValueFor("requiem_line_speed")

	-- create linear projectile
	local initial_angle_deg = self:GetCaster():GetAnglesAsVector().y
	local delta_angle = 360/lines
	for i=0,lines-1 do
		-- Determine velocity
		local facing_angle_deg = initial_angle_deg + delta_angle * i
		if facing_angle_deg>360 then facing_angle_deg = facing_angle_deg - 360 end
		local facing_angle = math.rad(facing_angle_deg)
		local facing_vector = Vector( math.cos(facing_angle), math.sin(facing_angle), 0 ):Normalized()
		local velocity = facing_vector * line_speed

		
		-- create projectile
		local info = {
			Source = self:GetCaster(),
			Ability = self,
			EffectName = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf",
			vSpawnOrigin = self:GetCaster():GetOrigin() + facing_vector * line_length,
			fDistance = line_length,
			vVelocity = -velocity,
			fStartRadius = width_start,
			fEndRadius = width_end,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_SPELL_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			bReplaceExisting = false,
			bProvidesVision = false,
			ExtraData = {
				scepter = true,
				modifier = modifierAT,
			}
		}
		ProjectileManager:CreateLinearProjectile( info )

		local particle_lines_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(particle_lines_fx, 0, self:GetCaster():GetOrigin() + facing_vector * line_length)
		ParticleManager:SetParticleControl(particle_lines_fx, 1, -velocity)
		ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, line_length/line_speed, 0))
		ParticleManager:ReleaseParticleIndex(particle_lines_fx)
	end
end

--------------------------------------------------------------------------------
-- Effects
function shadow_fiend_requiem_of_souls_lua:PlayEffects1()
	-- Get Resources
	local particle_precast = "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf"
	local sound_precast = "Hero_Nevermore.RequiemOfSoulsCast"

	-- Create Particles
	self.effect_precast = ParticleManager:CreateParticle( particle_precast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )	

	-- Play Sounds
	self:GetCaster():EmitSound(sound_precast)
end
function shadow_fiend_requiem_of_souls_lua:StopEffects1( success )
	-- Get Resources
	local sound_precast = "Hero_Nevermore.RequiemOfSoulsCast"

	-- Destroy Particles
	if not success then
		ParticleManager:DestroyParticle( self.effect_precast, true )
		StopSoundOn(sound_precast, self:GetCaster())
	end
   
   if self.effect_precast then
	   ParticleManager:ReleaseParticleIndex( self.effect_precast )
	end
end

function shadow_fiend_requiem_of_souls_lua:PlayEffects2( lines )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf"
	local sound_cast = "Hero_Nevermore.RequiemOfSouls"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( lines, 0, 0 ) )	-- Lines
	ParticleManager:SetParticleControlForward( effect_cast, 2, self:GetCaster():GetForwardVector() )		-- initial direction
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Play Sounds
	self:GetCaster():EmitSound(sound_cast)
end

--------------------------------------------------------------------------------
-- Helper: Ability Table (AT)
function shadow_fiend_requiem_of_souls_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function shadow_fiend_requiem_of_souls_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function shadow_fiend_requiem_of_souls_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function shadow_fiend_requiem_of_souls_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	return ret
end

function shadow_fiend_requiem_of_souls_lua:DelATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
end