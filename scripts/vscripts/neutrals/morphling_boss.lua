--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_morphling_boss_morphling_storm", "neutrals/morphling_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

morphling_boss_morphling_storm = class({})

function morphling_boss_morphling_storm:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf", context )
    PrecacheResource( "particle", "particles/act_2/siltbreaker_channel.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", context )
    PrecacheResource( "particle", "particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_morphling/morphling_waveform.vpcf', context )
end

function morphling_boss_morphling_storm:GetIntrinsicModifierName()
	return "modifier_morphling_boss_morphling_storm"
end

modifier_morphling_boss_morphling_storm = class({})

function modifier_morphling_boss_morphling_storm:IsHidden() return true end

function modifier_morphling_boss_morphling_storm:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(0)
end

function modifier_morphling_boss_morphling_storm:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("morphling_boss_waveform") then return end
	if not self:GetCaster():AbilityIsCooldown("morphling_boss_tidal_wave") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartTorrentSpawn()
		self:GetCaster():StartCooldownAbil( "morphling_boss_tidal_wave", 9 )
		self:GetCaster():StartCooldownAbil( "morphling_boss_waveform", 3 )
		self:GetAbility():StartCooldown(12)
	end
end

function modifier_morphling_boss_morphling_storm:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_morphling_boss_morphling_storm:GetModifierStatusResistanceStacking()
	if self:GetParent():HasModifier("modifier_woda_pve_creep_upgrade_wave") then return end
	if self:GetParent():HasModifier("modifier_wodaduel_boss_multiplier") then return end
	return 75
end

function modifier_morphling_boss_morphling_storm:StartTorrentSpawn()
	if not IsServer() then return end

	local delay_torrent = self:GetAbility():GetSpecialValueFor("delay_torrent")
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	local delay_spawn = self:GetAbility():GetSpecialValueFor("delay_spawn")
	local radius = self:GetAbility():GetSpecialValueFor("radius")
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	local torrent_radius = self:GetAbility():GetSpecialValueFor("torrent_radius")

	local count = duration / delay_spawn
	local parent = self:GetParent()

	for i = 0, count do
		Timers:CreateTimer(delay_spawn * i, function()
			if not parent:IsAlive() then
				return
			end
			local random_point = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(200, radius))
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl( particle, 0, random_point )
			ParticleManager:SetParticleControl( particle, 1, Vector( self:GetAbility():GetSpecialValueFor("torrent_radius"), 0, -self:GetAbility():GetSpecialValueFor("torrent_radius") + 65 ) )
			ParticleManager:SetParticleControl( particle, 2, Vector( delay_torrent, 0, 0 ) )
			EmitSoundOnLocationForAllies(random_point, "Ability.pre.Torrent", self:GetCaster())
			local bubbles_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(bubbles_pfx, 0, random_point)
			ParticleManager:SetParticleControl(bubbles_pfx, 1, Vector(torrent_radius,0,0))

			Timers:CreateTimer(delay_torrent, function()
				if particle then
					ParticleManager:DestroyParticle(particle, true )
					ParticleManager:ReleaseParticleIndex( particle )
				end
				if bubbles_pfx then
					ParticleManager:DestroyParticle(bubbles_pfx, true )
					ParticleManager:ReleaseParticleIndex( bubbles_pfx )
				end
				if not parent:IsAlive() then
					return
				end
				self:CreateTorrent(random_point)
			end)
		end)
	end
end

function modifier_morphling_boss_morphling_storm:CreateTorrent(origin)
	if not IsServer() then return end
	local torrent_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(torrent_fx, 0, origin)
	ParticleManager:SetParticleControl(torrent_fx, 1, Vector(self:GetAbility():GetSpecialValueFor("torrent_radius"),0,0))
	ParticleManager:ReleaseParticleIndex(torrent_fx)
	EmitSoundOnLocationWithCaster(origin, "Ability.Torrent", self:GetCaster())
	local knockback =
	{
		should_stun = 1,
		knockback_duration = self:GetAbility():GetSpecialValueFor("stun_duration"),
		duration = self:GetAbility():GetSpecialValueFor("stun_duration"),
		knockback_distance = 0,
		knockback_height = 400,
	}

    local damage = self:GetAbility():GetSpecialValueFor("damage")

    if self:GetParent():GetUnitName() == "boss_5" then
    	damage = damage / 2
    end

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), origin, nil, self:GetAbility():GetSpecialValueFor("torrent_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	for _,enemy in pairs(enemies) do
		self:GetCaster():EmitSound("Hero_Kunkka.TidalWave.Target")
		local damage = enemy:GetMaxHealth() / 100 * damage
		ApplyDamage({victim = enemy, attacker = self:GetCaster(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PURE})
		enemy:RemoveModifierByName("modifier_knockback")
		knockback.knockback_duration = self:GetAbility():GetSpecialValueFor("stun_duration") * (1-enemy:GetStatusResistance())
		knockback.duration = self:GetAbility():GetSpecialValueFor("stun_duration") * (1-enemy:GetStatusResistance())
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_knockback", knockback)
	end
end

LinkLuaModifier("modifier_morphling_boss_tidal_wave", "neutrals/morphling_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_boss_tidal_wave_buff", "neutrals/morphling_boss", LUA_MODIFIER_MOTION_BOTH)

morphling_boss_tidal_wave = class({})

morphling_boss_tidal_wave.Projectiles = {}

function morphling_boss_tidal_wave:GetIntrinsicModifierName()
	return "modifier_morphling_boss_tidal_wave"
end

modifier_morphling_boss_tidal_wave = class({})

function modifier_morphling_boss_tidal_wave:IsHidden() return true end

function modifier_morphling_boss_tidal_wave:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(0)
end

function modifier_morphling_boss_tidal_wave:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("morphling_boss_waveform") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:GetCaster():StartCooldownAbil( "morphling_boss_morphling_storm", 6 + self:GetAbility():GetSpecialValueFor("duration") )
		self:GetCaster():StartCooldownAbil( "morphling_boss_waveform", 3 + self:GetAbility():GetSpecialValueFor("duration") )
		self:GetAbility():StartCooldown(12)
		self:Start()
	end
end

function modifier_morphling_boss_tidal_wave:Start()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_boss_tidal_wave_buff", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end

modifier_morphling_boss_tidal_wave_buff = class({})

function modifier_morphling_boss_tidal_wave_buff:IsHidden()
	return true
end

function modifier_morphling_boss_tidal_wave_buff:IsPurgable()
	return false
end

function modifier_morphling_boss_tidal_wave_buff:GetActivityTranslationModifiers( params )
	return "channelling"
end

function modifier_morphling_boss_tidal_wave_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_DISABLE_TURNING
	}
end

function modifier_morphling_boss_tidal_wave_buff:GetOverrideAnimation()
	return ACT_DOTA_CAST_ABILITY_3
end

function modifier_morphling_boss_tidal_wave_buff:GetModifierDisableTurning() 
	return 1
end 

function modifier_morphling_boss_tidal_wave_buff:CheckState() 
	return 
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true 
	}
end

function modifier_morphling_boss_tidal_wave_buff:OnCreated( kv )
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.projectile_speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
	self.projectile_radius = self:GetAbility():GetSpecialValueFor( "projectile_radius" )
	self.cast_range = self:GetAbility():GetSpecialValueFor( "cast_range" )
	self.tick_interval = self:GetAbility():GetSpecialValueFor( "tick_interval" )
	self.pulses = self:GetAbility():GetSpecialValueFor( "pulses" )
	self.pulse_width = self:GetAbility():GetSpecialValueFor( "pulse_width" )
	self.bOffset = false
	self.nChannelFX = ParticleManager:CreateParticle( "particles/act_2/siltbreaker_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	self:AddParticle(self.nChannelFX, false, false, -1, false, false)
	self:StartIntervalThink( self.tick_interval )
end

function modifier_morphling_boss_tidal_wave_buff:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():StartCooldownAbil( "morphling_boss_morphling_storm", 6 )
	self:GetCaster():StartCooldownAbil( "morphling_boss_waveform", 3 )
	self:GetAbility():StartCooldown(12)
end

function modifier_morphling_boss_tidal_wave_buff:OnIntervalThink()
	if not IsServer() then return end
	local angle = QAngle( 0, 0, 0 )
	local nOffset = 0

	for i = 1, self.pulses do
		local info = 
		{
			EffectName = "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", 
			Ability = self:GetAbility(),
			vSpawnOrigin = self:GetCaster():GetOrigin(), 
			fStartRadius = self.projectile_radius,
			fEndRadius = self.projectile_radius,
			fDistance = self.cast_range,
			Source = self:GetCaster(),
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			bProvidesVision = true,
			iVisionRadius = self.projectile_radius,
			iVisionTeamNumber = self:GetParent():GetTeamNumber(),
		}

		info.vVelocity = ( RotatePosition( Vector( 0, 0, 0 ), angle, Vector( 1, 0, 0 ) ) ) * self.projectile_speed

		local proj = {}
		proj.handle = ProjectileManager:CreateLinearProjectile( info )

		self.last_y = angle.y

		if self.bOffset and i == 1 then
			nOffset = ( 360 / self.pulses ) / 2
		else
			nOffset = 0
		end

		angle.y = self.last_y + ( ( 360 / self.pulses ) + nOffset )
		table.insert( self:GetAbility().Projectiles, proj )
		self:GetCaster():EmitSound("Ability.GushCast")
	end

	self.bOffset = ( not self.bOffset )
end

function morphling_boss_tidal_wave:OnProjectileHitHandle( hTarget, vLocation, nProjectileHandle )
	if not IsServer() then return end

	if hTarget ~= nil and hTarget ~= self:GetCaster() then
		local projectile_radius = self:GetSpecialValueFor( "projectile_radius" )

		local damage = self:GetSpecialValueFor("damage")

	    if self:GetCaster():GetUnitName() == "boss_5" then
	    	damage = damage / 2
	    end

		local hEnemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), hTarget:GetOrigin(), self:GetCaster(), projectile_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
        for i = #hEnemies, 1, -1 do
            if hEnemies[i] and hEnemies[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(hEnemies, i)
            end
        end
		for _, hEnemy in pairs( hEnemies ) do
			if hEnemy ~= nil and hEnemy:IsInvulnerable() == false and hEnemy:IsMagicImmune() == false then
				local kv =
				{
					center_x = vLocation.x,
					center_y = vLocation.y,
					center_z = vLocation.z,
					should_stun = true, 
					duration = 0.5,
					knockback_duration = 0.5,
					knockback_distance = 250,
					knockback_height = 10,
				}
				hEnemy:AddNewModifier( self:GetCaster(), self, "modifier_knockback", kv )

				local damageInfo =
				{
					victim = hEnemy,
					attacker = self:GetCaster(),
					damage = damage / 100 * hEnemy:GetMaxHealth(),
					damage_type = DAMAGE_TYPE_PURE,
					ability = self,
				}
				ApplyDamage( damageInfo )
			end
		end

		hTarget:EmitSound("Ability.GushImpact")
	end

	local projectile = nil
	for _, proj in pairs( self.Projectiles ) do
		if proj ~= nil and proj.handle == nProjectileHandle then
			projectile = proj
		end
	end

	return false
end

LinkLuaModifier("modifier_morphling_boss_waveform", "neutrals/morphling_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_boss_waveform_buff", "neutrals/morphling_boss", LUA_MODIFIER_MOTION_HORIZONTAL)

morphling_boss_waveform = class({})

function morphling_boss_waveform:GetIntrinsicModifierName()
	return "modifier_morphling_boss_waveform"
end

modifier_morphling_boss_waveform = class({})

function modifier_morphling_boss_waveform:IsHidden() return true end

function modifier_morphling_boss_waveform:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(0)
end

function modifier_morphling_boss_waveform:OnIntervalThink()
	if not IsServer() then return end

	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then

		if not self:GetParent():IsAlive() then return end

		local radius_check = self:GetAbility():GetSpecialValueFor("cast_range")

		if self:GetParent():HasModifier("modifier_wodaduel_boss_multiplier") then
			if GetMapName() == "arena" then
	    		radius_check = -1
	    	end
	    end
    	
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius_check, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_FARTHEST, false)
        for i = #enemies, 1, -1 do
            if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(enemies, i)
            end
        end
		for count = #enemies, 1, -1 do
	        if enemies[count] and not enemies[count]:IsAlive() and not enemies[count]:IsRealHero() then
	            table.remove(units, count)
	        end
	    end

		if #enemies > 0 then
			self:GetCaster():StartCooldownAbil( "morphling_boss_morphling_storm", 3 + self:GetAbility():GetSpecialValueFor("delay") )
			self:GetCaster():StartCooldownAbil( "morphling_boss_tidal_wave", 3 + self:GetAbility():GetSpecialValueFor("delay") )
			self:GetAbility():StartCooldown(6)
			self:Start(enemies[1])
		end
	end
end

function modifier_morphling_boss_waveform:Start(target)
	if not IsServer() then return end

	local delay = self:GetAbility():GetSpecialValueFor("delay")

	if target then
		self.particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl( self.particle, 0, self:GetParent():GetAbsOrigin() )
		ParticleManager:SetParticleControl( self.particle, 1, Vector( 200, 0, -100 ) )
		ParticleManager:SetParticleControl( self.particle, 2, Vector( delay, 0, 0 ) )
	end

	local particle = self.particle

	local parent = self:GetParent()

	Timers:CreateTimer(delay, function()

		if not parent:IsAlive() then
			ParticleManager:DestroyParticle(particle, true)
			return
		end

		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
		end

        local caster_position = self:GetCaster():GetOrigin()
        local target_position = target:GetOrigin()
        if caster_position == target_position then
            caster_position = self:GetCaster():GetOrigin() + self:GetCaster():GetForwardVector()
        end

    	local vDirection = target_position - caster_position
    	vDirection.z = 0
    	local distance = vDirection:Length2D() + 150
    	vDirection = vDirection:Normalized()

    	self:GetParent():SetForwardVector(vDirection)

    	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_boss_waveform_buff", { duration = distance / 1200, x = target_position.x, y = target_position.y, z = target_position.z})

	    local info = 
	    {
	        EffectName = 'particles/units/heroes/hero_morphling/morphling_waveform.vpcf',
	        Ability = self:GetAbility(),
	        vSpawnOrigin = caster_position, 
	        fStartRadius = 100,
	        fEndRadius = 100,
	        vVelocity = vDirection * 1200,
	        fDistance = distance,
	        Source = self:GetCaster(),
	        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	        iUnitTargetFlags = DOTA_DAMAGE_FLAG_NONE,
	    }

    	ProjectileManager:CreateLinearProjectile( info )
	end)
end

function morphling_boss_waveform:OnProjectileHit(hTarget, vLocation)
    local caster = self:GetCaster()
    if hTarget then 
    	--if caster == nil then return end
    	--if caster:IsNull() then return end
    	--if not caster:IsAlive() then return end
    	--local damage = self:GetSpecialValueFor("damage")
--
	    --if self:GetCaster():GetUnitName() == "boss_5" then
	    --	damage = damage / 2
	    --end
--
        --local damage = hTarget:GetMaxHealth() / 100 * damage
        --ApplyDamage({victim = hTarget, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self})
    end
end 

modifier_morphling_boss_waveform_buff = class({})

function modifier_morphling_boss_waveform_buff:IsPurgable() return false end
function modifier_morphling_boss_waveform_buff:IsHidden() return true end
function modifier_morphling_boss_waveform_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_morphling_boss_waveform_buff:IgnoreTenacity() return true end
function modifier_morphling_boss_waveform_buff:IsMotionController() return true end
function modifier_morphling_boss_waveform_buff:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM end

function modifier_morphling_boss_waveform_buff:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE]       = true,
        [MODIFIER_STATE_DISARMED]       = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
    }
end

function modifier_morphling_boss_waveform_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_DISABLE_TURNING
	}
end

function modifier_morphling_boss_waveform_buff:GetModifierDisableTurning() 
	return 1
end 

function modifier_morphling_boss_waveform_buff:OnCreated(params)
    if IsServer() then
        if self:GetAbility():GetLevel() <= 0 then
            self:GetAbility():SetLevel(1)
        end
        local caster = self:GetCaster()
        local ability = self:GetAbility()
        local position = GetGroundPosition(Vector(params.x, params.y, params.z), nil)
        local distance = (caster:GetAbsOrigin() - position):Length2D()
        self.velocity = 1250
        self.direction = (position - caster:GetAbsOrigin()):Normalized()
        self.distance_traveled = 0
        self.distance = distance
        self.frametime = FrameTime()
        self:StartIntervalThink(FrameTime())
    end
end

function modifier_morphling_boss_waveform_buff:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():StartCooldownAbil( "morphling_boss_morphling_storm", 3 )
	self:GetCaster():StartCooldownAbil( "morphling_boss_tidal_wave", 3 )
	self:GetAbility():StartCooldown(6)
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end

function modifier_morphling_boss_waveform_buff:OnIntervalThink()
    ProjectileManager:ProjectileDodge( self:GetParent() )
    self:HorizontalMotion(self:GetParent(), self.frametime)
end

function modifier_morphling_boss_waveform_buff:HorizontalMotion( me, dt )
    if IsServer() then
        if self.distance_traveled <= self.distance then
            self:GetCaster():SetAbsOrigin(self:GetCaster():GetAbsOrigin() + self.direction * self.velocity * math.min(dt, self.distance - self.distance_traveled))
            self.distance_traveled = self.distance_traveled + self.velocity * math.min(dt, self.distance - self.distance_traveled)
        else
            if not self:IsNull() then
                self:Destroy()
            end
        end
    end
end
		