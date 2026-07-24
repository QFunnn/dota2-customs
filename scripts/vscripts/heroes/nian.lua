--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nian_bash", "heroes/nian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

nian_bash = class({})

function nian_bash:GetIntrinsicModifierName()
	return "modifier_nian_bash"
end

modifier_nian_bash = class({})

function modifier_nian_bash:IsHidden() return true end
function modifier_nian_bash:IsPurgable() return false end
function modifier_nian_bash:IsPurgeException() return false end

function modifier_nian_bash:AttackLandedModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end

	if RollPercentage(self:GetAbility():GetSpecialValueFor("chance")) then
		self:GetParent():EmitSound("Roshan.Bash")
		params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bashed", {duration = self:GetAbility():GetSpecialValueFor("duration")})

		local direction = params.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()
		direction.z = 0
		direction = direction:Normalized()

		local knockback = params.target:AddNewModifier(
	        params.target,
	        nil,	
	        "modifier_generic_knockback_lua",
	        {
	            direction_x = direction.x,
	            direction_y = direction.y,
	            distance = 143,
	            height = 50,	
	            duration = 0.5,
	            IsStun = true,
	        }
	    )

	    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf", PATTACH_POINT_FOLLOW, params.target )
		ParticleManager:SetParticleControlEnt( effect_cast, 0, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:ReleaseParticleIndex( effect_cast )

	    local callback = function( bInterrupted )
	    	params.target:Stop()
	    	FindClearSpaceForUnit(params.target, params.target:GetAbsOrigin(), true)
	    end

	    knockback:SetEndCallback( callback )
	end
end

LinkLuaModifier("modifier_nian_rush_cast", "heroes/nian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nian_rush", "heroes/nian", LUA_MODIFIER_MOTION_BOTH)

nian_rush = class({})

function nian_rush:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor( "delay" )

	local target = self:GetCursorTarget()
    if self:GetCaster():HasModifier("modifier_creep_spawner_cha_ready") then
        self:EndCooldown()
        self:RefundManaCost()
        return
    end
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_nian_rush_cast", { duration = duration, target = target:entindex() } )
end

function nian_rush:OnChargeFinish( interrupt, target )
	if not IsServer() then return end
	local max_duration = self:GetSpecialValueFor( "delay" ) 
	local base_duration = max_duration
	local max_distance = 1000 * (max_duration/base_duration)
	local speed = self:GetSpecialValueFor( "speed" )
	local charge_duration = max_duration
	local charge_target = target 

	local mod = self:GetCaster():FindModifierByName( "modifier_nian_rush_cast" )
	if mod then
		if mod.effect_cast then
			ParticleManager:DestroyParticle(mod.effect_cast, true)
		end

		if mod.target then 
			charge_target = mod.target
		end 

		charge_duration = mod:GetElapsedTime()
		mod.charge_finish = true
		mod:Destroy()
	end

	local k = charge_duration / max_duration
	local damage_amp = 1
	local distance = max_distance * k
	local duration = distance / speed
	if interrupt then return end
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_nian_rush", {damage = damage_amp, duration = duration } )
	self:GetCaster():EmitSound("Hero_PrimalBeast.Onslaught")
end

modifier_nian_rush_cast = class({})

function modifier_nian_rush_cast:IsPurgable()
	return false
end

function modifier_nian_rush_cast:OnCreated( kv )
	self.speed = self:GetAbility():GetSpecialValueFor( "speed" ) + 500
	self.turn_speed = 140
	self.max_time = self:GetAbility():GetSpecialValueFor( "delay" ) 
	if not IsServer() then return end
	self.anim_return = 0
	self.origin = self:GetParent():GetOrigin()
	self.charge_finish = false
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	self.time = 1000 / (self:GetAbility():GetSpecialValueFor( "speed" ) +500)

	if kv.target then 
		self.target = EntIndexToHScript(kv.target)
	end

	self:StartIntervalThink( FrameTime() )
	
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_nian_rush_cast:OnRemoved()
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_PrimalBeast.Onslaught.Channel")
	self:GetParent():RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
	if not self.charge_finish then
		self:GetAbility():OnChargeFinish( false, self.target )
	end
end

function modifier_nian_rush_cast:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
	return funcs
end

function modifier_nian_rush_cast:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_nian_rush_cast:GetModifierMoveSpeed_Limit()
	return 0.1
end

function modifier_nian_rush_cast:CheckState()
	local state = 
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}

	if self.target then 
		state = 
		{
			[MODIFIER_STATE_DISARMED] = true,
			[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
			[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
		}
	end

	return state
end

function modifier_nian_rush_cast:OnIntervalThink()
	if IsServer() then
		self.anim_return = self.anim_return + FrameTime()
		if self.anim_return >= 1 then
			self.anim_return = 0
			self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2)
		end
	end

	if self.target and self.target:IsAlive() then 
		self:SetDirection(self.target:GetAbsOrigin())
	end

	if self:GetParent():IsRooted() or self:GetParent():IsStunned() or
		self:GetParent():IsCurrentlyHorizontalMotionControlled() or self:GetParent():IsCurrentlyVerticalMotionControlled()
	then
		self:GetAbility():OnChargeFinish( true, self.target )
	end

	self:TurnLogic( FrameTime() )
	self:SetEffects()
end

function modifier_nian_rush_cast:TurnLogic( dt )
	if self.face_target then return end
	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = self.turn_speed*dt

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

function modifier_nian_rush_cast:PlayEffects1()
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_range_finder.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	self:AddParticle( self.effect_cast, false, false, -1, false, false )
	self:SetEffects()
end

function modifier_nian_rush_cast:SetEffects()
	local time = self:GetElapsedTime()
	local k =  time/self.max_time
	local speed_time = k*self.time
	local target_pos = self.origin + self:GetParent():GetForwardVector() * self.speed * speed_time
	ParticleManager:SetParticleControl( self.effect_cast, 1, target_pos )
end

function modifier_nian_rush_cast:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self:GetParent():EmitSound("Hero_PrimalBeast.Onslaught.Channel")
end

modifier_nian_rush = class({})

function modifier_nian_rush:IsPurgable()
	return false
end

function modifier_nian_rush:CheckState()
	local state = 
	{
		[MODIFIER_STATE_DISARMED] = true,
	}
	return state
end

function modifier_nian_rush:OnCreated( kv )
	self.speed = 1000
	self.turn_speed = 120
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.distance = 100
	self.duration = 0.2
	self.stun = self:GetAbility():GetSpecialValueFor( "stun_duration" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" ) + ( (math.floor(GameRules:GetDOTATime(false, false) / 60)) * self:GetAbility():GetSpecialValueFor("damage_prirost") )
	self.tree_radius = 100
	self.height = 50
	self.duration = 0.3
	if not IsServer() then return end
	damage = damage*kv.damage
	self.damage = damage
	self.target_angle = self:GetParent():GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true
	self.knockback_units = {}
	self.knockback_units[self:GetParent()] = true
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
	self.distance_pass = 0
	self.damageTable = { attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() }
end

function modifier_nian_rush:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return funcs
end

function modifier_nian_rush:GetModifierDisableTurning()
	return 1
end

function modifier_nian_rush:SetDirection( location )
	local dir = ((location-self:GetParent():GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_nian_rush:GetOverrideAnimation()
	return ACT_DOTA_RUN
end

function modifier_nian_rush:GetActivityTranslationModifiers()
	return "onslaught_movement"
end

function modifier_nian_rush:TurnLogic( dt )
	if self.face_target then return end
	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = self.turn_speed*dt

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

function modifier_nian_rush:HitLogic()
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree_radius, false )
	local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 0, 0, false )
	for _,unit in pairs(units) do
		if not self.knockback_units[unit] then
			self.knockback_units[unit] = true
			local enemy = unit
			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)
			enemy:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_stunned", { duration = self.stun } )
			if is_enemy or not (unit:IsCurrentlyHorizontalMotionControlled() or unit:IsCurrentlyVerticalMotionControlled()) then
				local direction = unit:GetOrigin()-self:GetParent():GetOrigin()
				direction.z = 0
				direction = direction:Normalized()
		        local knockbackProperties =
		        {
		            center_x = unit:GetOrigin().x,
		            center_y = unit:GetOrigin().y,
		            center_z = unit:GetOrigin().z,
		            duration = self.duration,
		            knockback_duration = self.duration,
		            knockback_distance = self.distance,
		            knockback_height = self.height
		        }
		        unit:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_knockback", knockbackProperties )
			end
			self:PlayEffects( unit, self.radius )
		end
	end
end

function modifier_nian_rush:UpdateHorizontalMotion( me, dt )
	self:HitLogic()
	self:TurnLogic( dt )
	local nextpos = me:GetOrigin() + me:GetForwardVector() * self.speed * dt
	me:SetOrigin(nextpos)

end

function modifier_nian_rush:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_nian_rush:GetEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end

function modifier_nian_rush:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_nian_rush:PlayEffects( target, radius )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
end

function modifier_nian_rush:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit( self:GetParent(), self:GetParent():GetOrigin(), false )
end





LinkLuaModifier("modifier_nian_apocalypse_2", "heroes/nian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nian_apocalypse_bkb", "heroes/nian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nian_apocalypse_meteor", "heroes/nian", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nian_apocalypse_debuff", "heroes/nian", LUA_MODIFIER_MOTION_NONE)

nian_apocalypse = class({})

function nian_apocalypse:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function nian_apocalypse:GetIntrinsicModifierName()
	return "modifier_nian_apocalypse_2"
end

modifier_nian_apocalypse_2 = class({})

function modifier_nian_apocalypse_2:IsHidden() return true end
function modifier_nian_apocalypse_2:IsPurgable() return false end

function modifier_nian_apocalypse_2:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_nian_apocalypse_2:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetAbility():IsFullyCastable() then return end
    if self:GetCaster():HasModifier("modifier_creep_spawner_cha_ready") then return end
	self:GetParent():Purge(false, true, false, true, true)
	if not self:GetParent():HasModifier("modifier_nian_apocalypse_bkb") then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_nian_apocalypse_bkb", {duration = self:GetAbility():GetSpecialValueFor("duration")})
	end
	self:GetParent():Purge(false, true, false, true, true)
	self:GetAbility():UseResources(false, false, false, true)
end

modifier_nian_apocalypse_bkb = class({})

function modifier_nian_apocalypse_bkb:OnCreated()
	if not IsServer() then return end
	self.flNextCast = 0.0
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
end

function modifier_nian_apocalypse_bkb:OnIntervalThink()
	if not IsServer() then return end
	local nMaxAttempts = 1
	local nAttempts = 0
	local vPos = nil
	repeat
		vPos = self:GetCaster():GetOrigin() + RandomVector( RandomInt( 100, 1000 ) )
		local hThinkersNearby = Entities:FindAllByClassnameWithin( "npc_dota_thinker", vPos, 600 )
		local hOverlappingWrathThinkers = {}

		for _, hThinker in pairs( hThinkersNearby ) do
			if ( hThinker:HasModifier( "modifier_nian_apocalypse_meteor" ) ) then
				table.insert( hOverlappingWrathThinkers, hThinker )
			end
		end
		nAttempts = nAttempts + 1
		if nAttempts >= nMaxAttempts then
			break
		end
	until ( #hOverlappingWrathThinkers == 0 )

	CreateModifierThinker( self:GetCaster(), self:GetAbility(), "modifier_nian_apocalypse_meteor", {}, vPos, self:GetCaster():GetTeamNumber(), false )
end

function modifier_nian_apocalypse_bkb:IsPurgable() return false end
function modifier_nian_apocalypse_bkb:IsHidden() return true end

function modifier_nian_apocalypse_bkb:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_nian_apocalypse_bkb:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_nian_apocalypse_bkb:DeclareFunctions()
    local decFuncs = 
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING
    }

    return decFuncs
end

function modifier_nian_apocalypse_bkb:GetModifierDisableTurning()
	return 1
end

function modifier_nian_apocalypse_bkb:CheckState()
	return 
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_ROOTED] = true
	}
end

function modifier_nian_apocalypse_bkb:GetOverrideAnimation()
    return ACT_DOTA_TELEPORT
end

function modifier_nian_apocalypse_bkb:GetModifierStatusResistance()
    return 100
end

function modifier_nian_apocalypse_bkb:GetModifierStatusResistanceCaster()
    return 100
end

function modifier_nian_apocalypse_bkb:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_nian_apocalypse_bkb:StatusEffectPriority()
    return 99999
end

modifier_nian_apocalypse_debuff = class({})

function modifier_nian_apocalypse_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_nian_apocalypse_debuff:GetModifierLifestealRegenAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("heal_reduce")
end

function modifier_nian_apocalypse_debuff:GetModifierHealAmplify_PercentageTarget()
	return self:GetAbility():GetSpecialValueFor("heal_reduce")
end

function modifier_nian_apocalypse_debuff:GetModifierHPRegenAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("heal_reduce")
end

modifier_nian_apocalypse_meteor = class({})

function modifier_nian_apocalypse_meteor:IsPurgable()
	return false
end

function modifier_nian_apocalypse_meteor:IsHidden()
	return true
end

function modifier_nian_apocalypse_meteor:OnCreated(kv)
	if not IsServer() then return end
	self.delay = self:GetAbility():GetSpecialValueFor( "delay" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.duration_debuff = self:GetAbility():GetSpecialValueFor("duration_debuff")
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) + ( (math.floor(GameRules:GetDOTATime(false, false) / 60)) * self:GetAbility():GetSpecialValueFor("damage_prirost") )

	self.nPreviewFX = ParticleManager:CreateParticle( "particles/neutral_fx/tower_mortar_marker.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( self.nPreviewFX, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.nPreviewFX, 1, Vector( self.radius, -self.radius, -self.radius ) )
	ParticleManager:SetParticleControl( self.nPreviewFX, 2, Vector( 2, 0, 0 ) )
	ParticleManager:SetParticleControl( self.nPreviewFX, 3, Vector( 1.0, 0.4, 0.8 ) )
	ParticleManager:ReleaseParticleIndex( self.nPreviewFX )
	self:AddParticle(self.nPreviewFX, false, false, -1, false, false)

	self.start_meteor = false

	self:StartIntervalThink( 1 )
end

function modifier_nian_apocalypse_meteor:OnIntervalThink()
	if not IsServer() then return end

	if self.start_meteor == false then
		local vRandomOffset = self:GetParent():GetAbsOrigin() + RandomVector( 500 )
		local nFXIndex = ParticleManager:CreateParticle( "particles/gameplay/spring_meteor_crash/spring_meteor_crash.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, vRandomOffset + Vector( 0, 0, 1000 ) )
		ParticleManager:SetParticleControl( nFXIndex, 1, self:GetParent():GetAbsOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 2, Vector( 1, 0, 0 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		self:GetParent():EmitSound("Hero_Invoker.ChaosMeteor.Cast")
		self.start_meteor = true
	else
		local nFXIndex2 = ParticleManager:CreateParticle( "particles/gameplay/spring_meteor_explosion/spring_meteor_explosion.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex2, 0, self:GetParent():GetAbsOrigin() )
		ParticleManager:SetParticleControl( nFXIndex2, 1, Vector( self.radius, 1, 1 ) )
		ParticleManager:SetParticleFoWProperties( nFXIndex2, 0, -1, self.radius )
		ParticleManager:ReleaseParticleIndex( nFXIndex2 );

		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
		for _,enemy in pairs( enemies ) do
			if enemy ~= nil then
				local damageInfo = { victim = enemy, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE, ability = self.ability }
				ApplyDamage( damageInfo )
				enemy:AddNewModifier(self.caster, self.ability, "modifier_nian_apocalypse_debuff", {duration = self.duration_debuff})
			end
		end

		self:GetParent():EmitSound("Hero_Invoker.ChaosMeteor.Impact")

		UTIL_Remove( self:GetParent() )
	end
end










		