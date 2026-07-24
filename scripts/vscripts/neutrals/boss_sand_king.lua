--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_sand_king_burrow", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_sand_king_burrow_active", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_sand_king_burrow_attack", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

boss_sand_king_burrow = class({})

function boss_sand_king_burrow:GetIntrinsicModifierName()
	return "modifier_boss_sand_king_burrow"
end

function boss_sand_king_burrow:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_epicenter_tell.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/ogre_bruiser_smash.vpcf", context )
    PrecacheResource( "particle", "particles/test_particle/sand_king_cyclone.vpcf", context )
    PrecacheResource( "particle", "particles/test_particle/sand_king_cyclone.vpcf", context )
    PrecacheResource( "particle", "particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", "particles/test_particle/sandking_burrowstrike_no_models.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", context )
end

modifier_boss_sand_king_burrow = class({})

function modifier_boss_sand_king_burrow:IsHidden() return true end
function modifier_boss_sand_king_burrow:IsPurgable() return false end
function modifier_boss_sand_king_burrow:IsPurgeException() return false end

function modifier_boss_sand_king_burrow:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(1)
end

function modifier_boss_sand_king_burrow:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("boss_sand_king_sandstorm") then return end
	if not self:GetCaster():AbilityIsCooldown("boss_sand_king_burrowstrike") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		if self:GetParent():HasModifier("modifier_boss_sand_king_sandstorm_active") then return end
		if self:GetParent():HasModifier("modifier_boss_sand_king_burrowstrike_active") then return end
		self:GetParent().burrow = true
		self:StartBurrow()
		self:GetCaster():StartCooldownAbil( "boss_sand_king_sandstorm", 9 + self:GetAbility():GetSpecialValueFor("duration")+self:GetAbility():GetSpecialValueFor("delay") )
		self:GetCaster():StartCooldownAbil( "boss_sand_king_burrowstrike", 3 + self:GetAbility():GetSpecialValueFor("duration")+self:GetAbility():GetSpecialValueFor("delay") )
		self:GetAbility():StartCooldown(12+self:GetAbility():GetSpecialValueFor("duration")+self:GetAbility():GetSpecialValueFor("delay"))
	end
end

function modifier_boss_sand_king_burrow:StartBurrow()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_neutral_cast", {})
	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_RAZE_1, 0.75)
	self:GetParent():EmitSound("Hero_NyxAssassin.Burrow.In")

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControlForward( particle, 0, self:GetParent():GetForwardVector() )

	Timers:CreateTimer(self:GetAbility():GetSpecialValueFor("delay"), function()
		self:GetParent():RemoveModifierByName("modifier_neutral_cast")
		self:GetCaster():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_boss_sand_king_burrow_active", {duration = self:GetAbility():GetSpecialValueFor("delay") + self:GetAbility():GetSpecialValueFor("duration")} )
		self:GetCaster().nBurrowFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_inground.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControl( self:GetCaster().nBurrowFXIndex, 0, self:GetCaster():GetOrigin() )
	end)

	Timers:CreateTimer(self:GetAbility():GetSpecialValueFor("duration"), function()

		self:GetParent():RemoveModifierByName("modifier_boss_sand_king_burrow_attack")

		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_neutral_cast", {})

		if self:GetCaster().nBurrowFXIndex == nil then
			return true
		end

		ParticleManager:DestroyParticle( self:GetCaster().nBurrowFXIndex, false )

		self:GetParent():EmitSound("Hero_NyxAssassin.Burrow.Out")

		local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetOrigin() )

		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_RAZE_2, 0.75)

		Timers:CreateTimer(self:GetAbility():GetSpecialValueFor("delay"), function()
			UpdateCooldown(self:GetCaster(), self:GetAbility())
			self:GetParent():RemoveModifierByName("modifier_neutral_cast")
			self:GetParent():RemoveModifierByName("modifier_boss_sand_king_burrow_active")
			self:GetParent().burrow = false
		end)
	end)
end

modifier_boss_sand_king_burrow_active = class({})

function modifier_boss_sand_king_burrow_active:IsHidden()
	return true
end

function modifier_boss_sand_king_burrow_active:IsPurgable()
	return false
end

function modifier_boss_sand_king_burrow_active:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.attack_interval = self:GetAbility():GetSpecialValueFor("attack_interval")
	self.interval = self:GetAbility():GetSpecialValueFor("attack_interval") - 1
	self.origin = self:GetParent():GetOrigin()
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	self:StartIntervalThink(FrameTime())
end

function modifier_boss_sand_king_burrow_active:OnIntervalThink()
	if not IsServer() then return end
	self.interval = self.interval + FrameTime()

	if self.interval >= self.attack_interval then
		self.interval = 0
		if self:GetRemainingTime() >= 4.6 then
			self:Clap()
		end
	end

	if self:GetParent():HasModifier("modifier_boss_sand_king_burrow_attack") then return end
    local radius_check = 750
    if GetMapName() == "arena" then
        radius_check = -1
    end

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius_check, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false )
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
		self:SetDirection(enemies[1]:GetAbsOrigin())
	end

	self:TurnLogic( FrameTime() )
end

function modifier_boss_sand_king_burrow_active:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_boss_sand_king_burrow_active:TurnLogic( dt )
	if self.face_target then return end
	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = 360*dt

	local sign = -1
	if angle_diff<0 then sign = 1 end

	if math.abs( angle_diff )<1.1*turn_speed then
		self.current_angle = self.target_angle
		self.face_target = true
	else
		self.current_angle = self.current_angle + sign*turn_speed
	end

	local angles = self:GetParent():GetAnglesAsVector()
	self:GetParent():SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_boss_sand_king_burrow_active:Clap()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_boss_sand_king_burrow_attack", {duration = 3.5} )
end

function modifier_boss_sand_king_burrow_active:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_boss_sand_king_burrow_active:CheckState()
	local state =
	{
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_STUNNED] = false,
	}
	return state
end

function modifier_boss_sand_king_burrow_active:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_TURNING
	}
	return funcs
end

function modifier_boss_sand_king_burrow_active:GetModifierDisableTurning()
	return 1
end

function modifier_boss_sand_king_burrow_active:GetActivityTranslationModifiers( params )
	return "burrowed"
end

function modifier_boss_sand_king_burrow_active:GetModifierTurnRate_Percentage( params )
	return 20
end

modifier_boss_sand_king_burrow_attack = class({})

function modifier_boss_sand_king_burrow_attack:IsHidden()
	return true
end

function modifier_boss_sand_king_burrow_attack:IsPurgable()
	return false
end

function modifier_boss_sand_king_burrow_attack:OnCreated( kv )
	if IsServer() then
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_7, 0.7)
		self.nPreviewFX = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_epicenter_tell.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
		ParticleManager:SetParticleControlEnt( self.nPreviewFX, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_tail", self:GetCaster():GetOrigin(), true )
		self:AddParticle(self.nPreviewFX, false, false, -1, false, false)
		self.hHitTargets = {}
		self:StartIntervalThink( 2.4 )
	end
end

function modifier_boss_sand_king_burrow_attack:OnIntervalThink()
	if IsServer() then
		if not self:GetParent():HasModifier("modifier_boss_sand_king_burrow_active") then return end

		local forward = self:GetParent():GetForwardVector()
		forward.z = 0

		local point_1 = self:GetParent():GetAbsOrigin() + forward * 100
		local point_2 = self:GetParent():GetAbsOrigin() + forward * 200
		local point_3 = self:GetParent():GetAbsOrigin() + forward * 300
		local point_4 = self:GetParent():GetAbsOrigin() + forward * 400
		local point_5 = self:GetParent():GetAbsOrigin() + forward * 500
		local point_6 = self:GetParent():GetAbsOrigin() + forward * 600

		local Locations = {}
		table.insert( Locations, point_1 )
		table.insert( Locations, point_2 )
		table.insert( Locations, point_3 )
		table.insert( Locations, point_4 )
		table.insert( Locations, point_5 )
		table.insert( Locations, point_6 )
			
		local radius = self:GetAbility():GetSpecialValueFor("damage_radius")

		for _,vPos in pairs ( Locations ) do
			local nFXIndex = ParticleManager:CreateParticle( "particles/neutral_fx/ogre_bruiser_smash.vpcf", PATTACH_WORLDORIGIN,  self:GetCaster()  )
			ParticleManager:SetParticleControl( nFXIndex, 0, vPos )
			ParticleManager:SetParticleControl( nFXIndex, 1, Vector( radius, radius, radius ))
			ParticleManager:ReleaseParticleIndex( nFXIndex )

			local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), vPos, self:GetParent(), self:GetAbility():GetSpecialValueFor("damage_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
            for i = #enemies, 1, -1 do
                if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
                    table.remove(enemies, i)
                end
            end
            for _,enemy in pairs( enemies ) do
				if enemy ~= nil and enemy:IsInvulnerable() == false and self:HasHitTarget( enemy ) == false then
					self:AddHitTarget( enemy )

					local damageInfo = 
					{
						victim = enemy,
						attacker = self:GetCaster(),
						damage = self:GetAbility():GetSpecialValueFor("damage") / 100 * enemy:GetMaxHealth(),
						damage_type = DAMAGE_TYPE_PURE,
						ability = self:GetAbility(),
					}

					ApplyDamage( damageInfo )
					enemy:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self:GetAbility():GetSpecialValueFor("stun_duration") * (1-enemy:GetStatusResistance()) } )
				end
			end
		end

		self:GetParent():EmitSound("Item.OgreSealTotem.Smash")
		self:StartIntervalThink( -1 )
	end
end

function modifier_boss_sand_king_burrow_attack:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	return funcs
end

function modifier_boss_sand_king_burrow_attack:GetModifierDisableTurning( params )
	return 1
end

function modifier_boss_sand_king_burrow_attack:HasHitTarget( hTarget )
	for _, target in pairs( self.hHitTargets ) do
		if target == hTarget then
	    	return true
	    end
	end
	
	return false
end

function modifier_boss_sand_king_burrow_attack:AddHitTarget( hTarget )
	table.insert( self.hHitTargets, hTarget )
end

LinkLuaModifier("modifier_boss_sand_king_sandstorm", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_sand_king_sandstorm_active", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE)

boss_sand_king_sandstorm = class({})

function boss_sand_king_sandstorm:GetIntrinsicModifierName()
	return "modifier_boss_sand_king_sandstorm"
end

function boss_sand_king_sandstorm:OnProjectileThinkHandle( iProjectileHandle )
	if IsServer() then
		local mod = self:GetCaster():FindModifierByName("modifier_boss_sand_king_sandstorm_active")
		if mod then
			for _,Storm in pairs( mod.Storms ) do
				if Storm ~= nil and Storm.nProjHandle == iProjectileHandle then
					Storm.y = Storm.y + Storm.flAngleUpdate
					if Storm.bReverse then
						Storm.flAngleUpdate = math.min( Storm.flAngleUpdate + 0.03, -1 )
					else
						Storm.flAngleUpdate = math.max( Storm.flAngleUpdate - 0.03, 1 )
					end

					local angle = QAngle( 0, Storm.y, 0 )
					local vVelocity = ( RotatePosition( Vector( 0, 0, 0 ), angle, Vector( 1, 0, 0 ) ) ) * self:GetSpecialValueFor("storm_speed")
					ProjectileManager:UpdateLinearProjectileDirection( iProjectileHandle, vVelocity, 5000 )
				end
			end
		end
	end
end

modifier_boss_sand_king_sandstorm = class({})

function modifier_boss_sand_king_sandstorm:IsHidden() return true end
function modifier_boss_sand_king_sandstorm:IsPurgable() return false end
function modifier_boss_sand_king_sandstorm:IsPurgeException() return false end

function modifier_boss_sand_king_sandstorm:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_boss_sand_king_sandstorm:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("boss_sand_king_burrowstrike") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		if self:GetParent():HasModifier("modifier_boss_sand_king_burrowstrike_active") then return end
		if self:GetParent().burrow then return end
		self:StartSandStorm()
		self:GetCaster():StartCooldownAbil( "boss_sand_king_burrow", 6 + self:GetAbility():GetSpecialValueFor("duration") )
		self:GetCaster():StartCooldownAbil( "boss_sand_king_burrowstrike", 3 + self:GetAbility():GetSpecialValueFor("duration") )
		self:GetAbility():StartCooldown(12+ self:GetAbility():GetSpecialValueFor("duration"))
	end
end

function modifier_boss_sand_king_sandstorm:StartSandStorm()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_boss_sand_king_sandstorm_active", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end

modifier_boss_sand_king_sandstorm_active = class({})

function modifier_boss_sand_king_sandstorm_active:IsHidden() return true end
function modifier_boss_sand_king_sandstorm_active:IsPurgable() return false end
function modifier_boss_sand_king_sandstorm_active:IsPurgeException() return false end

function modifier_boss_sand_king_sandstorm_active:CheckState()
	local state =
	{
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_STUNNED] = false,
	}
	return state
end

function modifier_boss_sand_king_sandstorm_active:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	return funcs
end

function modifier_boss_sand_king_sandstorm_active:GetOverrideAnimation()
	return ACT_DOTA_CAST2_STATUE
end

function modifier_boss_sand_king_sandstorm_active:GetModifierDisableTurning()
	return 1
end

function modifier_boss_sand_king_sandstorm_active:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.storm_angle_step = self:GetAbility():GetSpecialValueFor( "storm_angle_step" )
	self.storm_speed = self:GetAbility():GetSpecialValueFor( "storm_speed" ) + self:GetAbility():GetSpecialValueFor( "storm_speed_step" )
	self.spiral_storm_count = self:GetAbility():GetSpecialValueFor( "spiral_storm_count" )
	
	local bReverse = RandomInt( 0, 1 )

	if bReverse == 1 then
		self.storm_angle_step = self.storm_angle_step * -1
	end

	self.Storms = {}
	
	local angle = QAngle( 0, 0, 0 )
	
	local Heroes = HeroList:GetAllHeroes()

	for _,Hero in pairs( Heroes ) do
		if Hero ~= nil and Hero:IsRealHero() and not Hero:IsIllusion() and not Hero:HasModifier("modifier_dazzle_nothl_projection_soul_clone") and not Hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
			for i=1,1 do
				local hStorm = CreateUnitByName( "npc_dota_sand_king_sandstorm", self:GetCaster():GetAbsOrigin(), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber() )
				if hStorm ~= nil then
					hStorm.hParent = self:GetCaster()
					hStorm.nFXIndex = ParticleManager:CreateParticle( "particles/test_particle/sand_king_cyclone.vpcf", PATTACH_ABSORIGIN_FOLLOW, hStorm )
					hStorm:SetForceAttackTarget( Hero )
					hStorm.Target = Hero
					hStorm.storm_speed = self.storm_speed
					local vSpawnPoint = Hero:GetOrigin() + RandomVector( 1 ) * 300
					FindClearSpaceForUnit( hStorm, vSpawnPoint, true )
					hStorm:AddNewModifier( hStorm, hStorm:FindAbilityByName( "sand_king_boss_sandstorm_storm_passive" ), "modifier_sand_king_boss_sandstorm", {} )
					table.insert( self.Storms, hStorm )
				end
			end
		end
	end

	for i=1, self.spiral_storm_count do
		local hStorm = CreateUnitByName( "npc_dota_sand_king_sandstorm", self:GetCaster():GetAbsOrigin(), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber() )
		if hStorm ~= nil then
			hStorm.hParent = self:GetCaster()
			hStorm.nFXIndex = ParticleManager:CreateParticle( "particles/test_particle/sand_king_cyclone.vpcf", PATTACH_ABSORIGIN_FOLLOW, hStorm )
			local vSpawnPoint = self:GetCaster():GetOrigin()
			FindClearSpaceForUnit( hStorm, vSpawnPoint, true )
			local info = 
			{
				EffectName = "",
				Ability = self:GetAbility(),
				vSpawnOrigin = vSpawnPoint,
				fDistance = 5000,
				fStartRadius = 50,
				fEndRadius = 50,
				Source = self:GetCaster(),
			}
			info.vVelocity = ( RotatePosition( Vector( 0, 0, 0 ), angle, Vector( 1, 0, 0 ) ) ) * self.storm_speed
			hStorm.nProjHandle = ProjectileManager:CreateLinearProjectile( info )
			hStorm.y = angle.y
			angle.y = angle.y + self.storm_angle_step
			hStorm.flAngleUpdate = 3.0 
			if bReverse then
				hStorm.flAngleUpdate = hStorm.flAngleUpdate * -1
				hStorm.bReverse = bReverse
			end
			hStorm:AddNewModifier( hStorm, hStorm:FindAbilityByName( "sand_king_boss_sandstorm_storm_passive" ), "modifier_sand_king_boss_sandstorm", {} )	
			table.insert( self.Storms, hStorm )
		end
	end
end

function modifier_boss_sand_king_sandstorm_active:OnDestroy()
	if not IsServer() then return end
	for _,Storm in pairs( self.Storms ) do
		if Storm ~= nil then
			if Storm.nProjHandle ~= nil then
				ProjectileManager:DestroyLinearProjectile( Storm.nProjHandle )				 
			end
			ParticleManager:DestroyParticle( Storm.nFXIndex, false )
			Storm:ForceKill( false )
		end
	end
end

LinkLuaModifier( "modifier_sand_king_boss_sandstorm", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_sand_king_boss_sandstorm_effect", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE )

sand_king_boss_sandstorm_storm_passive = class({})

function sand_king_boss_sandstorm_storm_passive:GetIntrinsicModifierName()
	return "modifier_sand_king_boss_sandstorm"
end

modifier_sand_king_boss_sandstorm = class({})

function modifier_sand_king_boss_sandstorm:IsHidden()
	return true
end

function modifier_sand_king_boss_sandstorm:IsPurgable()
	return false
end

function modifier_sand_king_boss_sandstorm:IsAura()
	return true
end

function modifier_sand_king_boss_sandstorm:GetModifierAura()
	return "modifier_sand_king_boss_sandstorm_effect"
end

function modifier_sand_king_boss_sandstorm:GetAuraRadius()
	return self.sand_storm_radius
end

function modifier_sand_king_boss_sandstorm:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_sand_king_boss_sandstorm:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sand_king_boss_sandstorm:GetAuraDuration()
	return 0
end

function modifier_sand_king_boss_sandstorm:OnCreated( kv )
	if IsServer() then
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
			return
		end
		self.nProjHandle = self:GetParent().nProjHandle
		self.sand_storm_radius = self:GetAbility():GetSpecialValueFor( "sand_storm_radius" )
		self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
		self:GetParent():EmitSound("Ability.SandKing_SandStorm.start")
		self.storm_move_speed = self:GetAbility():GetSpecialValueFor( "storm_move_speed" )
		self.storm_decreased_turn_rate = self:GetAbility():GetSpecialValueFor( "storm_decreased_turn_rate" )
		EmitSoundOn( "Ability.SandKing_SandStorm.loop", self:GetParent() )
	end
end

function modifier_sand_king_boss_sandstorm:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveHorizontalMotionController( self )
		StopSoundOn( "Ability.SandKing_SandStorm.loop", self:GetParent() )
		if self.nProjHandle ~= nil then
			ProjectileManager:DestroyLinearProjectile( self.nProjHandle )
		end
	end
end

function modifier_sand_king_boss_sandstorm:CheckState()
	local state =
	{
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
	return state
end

function modifier_sand_king_boss_sandstorm:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
	}
	return funcs
end

function modifier_sand_king_boss_sandstorm:GetModifierTurnRate_Percentage( params )
	return -self.storm_decreased_turn_rate
end

function modifier_sand_king_boss_sandstorm:UpdateHorizontalMotion( me, dt )
	if IsServer() then
		if self.nProjHandle == nil then
			local vForward = self:GetParent():GetForwardVector()
			local vNewPos = self:GetParent():GetOrigin() + vForward * dt * self:GetParent().storm_speed
			me:SetOrigin( vNewPos )
		else
			local vNewPos = ProjectileManager:GetLinearProjectileLocation( self.nProjHandle )
			me:SetOrigin( vNewPos )
		end
	end
end

function modifier_sand_king_boss_sandstorm:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

modifier_sand_king_boss_sandstorm_effect = class({})

function modifier_sand_king_boss_sandstorm_effect:IsHidden() return true end
function modifier_sand_king_boss_sandstorm_effect:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_sand_king_boss_sandstorm_effect:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink( 0.5 )
	end
end

function modifier_sand_king_boss_sandstorm_effect:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_sand_king_boss_sandstorm_effect:OnIntervalThink()
	if IsServer() then
		if self:GetParent() and self:GetParent():IsInvulnerable() == false then
	
			local damageInfo = 
			{
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.damage / 100 * self:GetParent():GetMaxHealth(),
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility()
			}

			ApplyDamage( damageInfo )
		end
	end
end

LinkLuaModifier("modifier_boss_sand_king_burrowstrike", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_sand_king_burrowstrike_active", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_boss_sand_king_burrowstrike_active_end", "neutrals/boss_sand_king", LUA_MODIFIER_MOTION_BOTH)

boss_sand_king_burrowstrike = class({})

function boss_sand_king_burrowstrike:GetIntrinsicModifierName()
	return "modifier_boss_sand_king_burrowstrike"
end

modifier_boss_sand_king_burrowstrike = class({})

function modifier_boss_sand_king_burrowstrike:IsHidden() return true end
function modifier_boss_sand_king_burrowstrike:IsPurgable() return false end
function modifier_boss_sand_king_burrowstrike:IsPurgeException() return false end

function modifier_boss_sand_king_burrowstrike:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_boss_sand_king_burrowstrike:OnIntervalThink()
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		if self:GetParent():HasModifier("modifier_boss_sand_king_sandstorm_active") then return end
		if self:GetParent().burrow then return end
		self:StartBurrowStrike()
		self:GetCaster():StartCooldownAbil( "boss_sand_king_burrow", 3 + 1 )
		self:GetCaster():StartCooldownAbil( "boss_sand_king_sandstorm", 3 + 1 )
		self:GetAbility():StartCooldown(6)
	end
end

function modifier_boss_sand_king_burrowstrike:StartBurrowStrike()
	if not IsServer() then return end

	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_SAND_KING_BURROW_IN, 0.3)

	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_neutral_cast", {})

	local origin = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 400

    local radius_check = 750
    if GetMapName() == "arena" then
        radius_check = -1
    end
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius_check, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_FARTHEST, false )
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
		origin = enemies[1]:GetAbsOrigin()
	end

	local vToTarget = origin - self:GetCaster():GetOrigin()
    vToTarget.z = 0

	local flDist = vToTarget:Length2D()

	local vDir = vToTarget:Normalized()
	vDir.z = 0.0

	local vTarget = self:GetCaster():GetOrigin() + vDir * flDist

	self:GetCaster():SetForwardVector(vDir)
	self:GetCaster():FaceTowards(vTarget)

	local particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, vTarget )
	ParticleManager:SetParticleControl( particle, 1, Vector( self:GetAbility():GetSpecialValueFor( "radius" ), 0, -500 ) )
	ParticleManager:SetParticleControl( particle, 2, Vector( flDist / self:GetAbility():GetSpecialValueFor( "speed" ), 0, 0 ) )

	local parent = self:GetParent()

	Timers:CreateTimer(1, function()

		if not parent:IsAlive() then
			ParticleManager:DestroyParticle(particle, true)
			return
		end

		self:GetCaster():EmitSound("Ability.SandKing_BurrowStrike")

		local kv = { x = vTarget.x, y = vTarget.y, z = vTarget.z, duration = flDist / ( self:GetAbility():GetSpecialValueFor( "speed" ) ) }

		local modik = self:GetCaster():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_boss_sand_king_burrowstrike_active", kv )

		modik:AddParticle(particle, false, false, -1, false, false)

		local nFXIndex = ParticleManager:CreateParticle( "particles/test_particle/sandking_burrowstrike_no_models.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetOrigin() + self:GetCaster():GetForwardVector() * 225  )
		ParticleManager:SetParticleControl( nFXIndex, 1, self:GetCaster():GetOrigin() + self:GetCaster():GetForwardVector() * 225  )
		ParticleManager:ReleaseParticleIndex( nFXIndex )

		self:GetParent():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_boss_sand_king_burrowstrike_active = class ({})

function modifier_boss_sand_king_burrowstrike_active:IsPurgable()
	return false
end

function modifier_boss_sand_king_burrowstrike_active:IsHidden()
	return true
end

function modifier_boss_sand_king_burrowstrike_active:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_boss_sand_king_burrowstrike_active:OnCreated( kv )
	if IsServer() then
		self.vTarget = Vector( kv["x"], kv["y"], kv["z"] )
		self.vDir = self.vTarget - self:GetParent():GetOrigin()
        self.vDir.z = 0
		self.vDir = self.vDir:Normalized()
		local flHealthPct = self:GetParent():GetHealthPercent() / 100
		self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self:GetParent():AddEffects( EF_NODRAW )
		self.nFXIndex = -1
		self.nFXIndex2 = -1
		self.nFXIndex3 = -1

		self:OnIntervalThink()
		self:StartIntervalThink( 0.33 )
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
			return
		end
	end
end

function modifier_boss_sand_king_burrowstrike_active:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveHorizontalMotionController( self )
		self:GetParent():RemoveEffects( EF_NODRAW )
		local kv = 
		{
			x = self.vDir.x,
			y = self.vDir.y,
			z = self.vDir.z,
		}
		self:GetParent():AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_boss_sand_king_burrowstrike_active_end", kv )
	end
end

function modifier_boss_sand_king_burrowstrike_active:OnIntervalThink()
	if IsServer() then
		if self.nFXIndex ~= -1 then
			ParticleManager:DestroyParticle( self.nFXIndex, false )
		end
		if self.nFXIndex2 ~= -1 then
			ParticleManager:DestroyParticle( self.nFXIndex2, false )
		end
		if self.nFXIndex3 ~= -1 then
			ParticleManager:DestroyParticle( self.nFXIndex3, false )
		end

		self.nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( self.nFXIndex, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControlForward( self.nFXIndex, 0, self:GetParent():GetForwardVector() )
		self.nFXIndex2 = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( self.nFXIndex2, 0, self:GetParent():GetOrigin() + RandomVector( 1 ) * RandomInt( 50, 150 ) )
		ParticleManager:SetParticleControlForward( self.nFXIndex2, 0, self:GetParent():GetRightVector() )
		self.nFXIndex3 = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( self.nFXIndex3, 0, self:GetParent():GetOrigin() + RandomVector( 1 ) * RandomInt( 50, 150 ) )
		ParticleManager:SetParticleControlForward( self.nFXIndex3, 0, -self:GetParent():GetRightVector() )

		EmitSoundOn( "Hero_NyxAssassin.Burrow.In", self:GetParent() )
	end
end

function modifier_boss_sand_king_burrowstrike_active:UpdateHorizontalMotion( me, dt )
	if IsServer() then
		local vNewLocation = self:GetParent():GetOrigin() + self.vDir * self.speed * dt
		me:SetOrigin( vNewLocation )
	end
end

function modifier_boss_sand_king_burrowstrike_active:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_boss_sand_king_burrowstrike_active:CheckState()
	local state =
	{
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
	return state
end

modifier_boss_sand_king_burrowstrike_active_end = class ({})

function modifier_boss_sand_king_burrowstrike_active_end:IsPurgable()
	return false
end

function modifier_boss_sand_king_burrowstrike_active_end:IsHidden()
	return true
end

function modifier_boss_sand_king_burrowstrike_active_end:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_boss_sand_king_burrowstrike_active_end:OnCreated( kv )
	if IsServer() then
		self.vDir = Vector( kv["x"], kv["y"], kv["z"] )
		self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
		self.delay = self:GetAbility():GetSpecialValueFor( "delay" ) 
		self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) 
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
		self.stun_duration = self:GetAbility():GetSpecialValueFor( "stun_duration" )
		self.knockback_distance = self:GetAbility():GetSpecialValueFor( "knockback_distance" )
		self.knockback_height = self:GetAbility():GetSpecialValueFor( "knockback_height" )
		self.bExitGround = false
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_SAND_KING_BURROW_OUT, 0.5)
		self:StartIntervalThink( 0.1 )
	end
end

function modifier_boss_sand_king_burrowstrike_active_end:OnIntervalThink()
	if not IsServer() then return end

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	for _,enemy in pairs( enemies ) do
		local damageInfo = 
		{
			victim = enemy,
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("damage") / 100 * enemy:GetMaxHealth(),
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(),
		}

		ApplyDamage( damageInfo )
		enemy:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self:GetAbility():GetSpecialValueFor("stun_duration") * (1-enemy:GetStatusResistance()) } )
	end

	self:Destroy()
end

function modifier_boss_sand_king_burrowstrike_active_end:OnDestroy()
	if IsServer() then
		self:GetCaster():StartCooldownAbil( "boss_sand_king_burrow", 3  )
		self:GetCaster():StartCooldownAbil( "boss_sand_king_sandstorm", 3 )
		self:GetAbility():StartCooldown(6)
		self:GetParent():RemoveGesture(ACT_DOTA_SAND_KING_BURROW_IN)
		self:GetParent():RemoveHorizontalMotionController( self )
	end
end

function modifier_boss_sand_king_burrowstrike_active_end:CheckState()
	if IsServer() then
		local state =
		{
			[MODIFIER_STATE_STUNNED] = false,
		}
	end
	return state
end

function modifier_boss_sand_king_burrowstrike_active_end:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
	return funcs
end

function modifier_boss_sand_king_burrowstrike_active_end:GetModifierDisableTurning( params )
	return 1
end

function UpdateCooldown(caster, ability)
	local boss_sand_king_burrow = caster:FindAbilityByName("boss_sand_king_burrow")
	if boss_sand_king_burrow and boss_sand_king_burrow ~= ability then
		local cooldown_time = boss_sand_king_burrow:GetCooldownTimeRemaining() + 3
		boss_sand_king_burrow:StartCooldown(cooldown_time)
	end

	local boss_sand_king_sandstorm = caster:FindAbilityByName("boss_sand_king_sandstorm")
	if boss_sand_king_sandstorm and boss_sand_king_sandstorm ~= ability then
		local cooldown_time = boss_sand_king_sandstorm:GetCooldownTimeRemaining() + 3
		boss_sand_king_sandstorm:StartCooldown(cooldown_time)
	end

	local boss_sand_king_burrowstrike = caster:FindAbilityByName("boss_sand_king_burrowstrike")
	if boss_sand_king_burrowstrike and boss_sand_king_burrowstrike ~= ability then
		local cooldown_time = boss_sand_king_burrowstrike:GetCooldownTimeRemaining() + 3
		boss_sand_king_burrowstrike:StartCooldown(cooldown_time)
	end
end



		