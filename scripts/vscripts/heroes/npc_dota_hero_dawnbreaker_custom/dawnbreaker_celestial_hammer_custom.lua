--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dawnbreaker_celestial_hammer_custom", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_celestial_hammer_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_celestial_hammer_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_dawnbreaker_celestial_hammer_custom_thinker", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_celestial_hammer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_celestial_hammer_custom_trail", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_celestial_hammer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_celestial_hammer_custom_debuff", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_celestial_hammer_custom", LUA_MODIFIER_MOTION_NONE )

dawnbreaker_celestial_hammer_custom = class({})
dawnbreaker_celestial_hammer_custom.modifier_dawnbreaker_15 = {-1,-2}
dawnbreaker_celestial_hammer_custom.modifier_dawnbreaker_16 = {25,40,55}
dawnbreaker_celestial_hammer_custom.modifier_dawnbreaker_20 = {12,24}
dawnbreaker_celestial_hammer_custom.modifier_dawnbreaker_19 = {0.8,1.2}
dawnbreaker_celestial_hammer_custom.modifier_dawnbreaker_18 = {2,3,4}
dawnbreaker_celestial_hammer_custom.modifier_dawnbreaker_21 = 0

function dawnbreaker_celestial_hammer_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_dawnbreaker_15") then
        bonus = self.modifier_dawnbreaker_15[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_15")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function dawnbreaker_celestial_hammer_custom:CastFilterResultLocation( vLoc )
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" ) then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function dawnbreaker_celestial_hammer_custom:GetCustomCastErrorLocation( vLoc )
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" ) then
		return "#dota_hud_error_nohammer"
	end
	return ""
end

function dawnbreaker_celestial_hammer_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        local cast_range_multiplier = 1
        if self:GetCaster():HasModifier("modifier_dawnbreaker_20") then
            cast_range_multiplier = cast_range_multiplier + self.modifier_dawnbreaker_20[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_20")] / 100
        end
        return self:GetSpecialValueFor( "range" ) * cast_range_multiplier
    end
end

function dawnbreaker_celestial_hammer_custom:OnAbilityPhaseStart()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_fire_wreath_custom") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#dota_hud_error_fire_wreath_in_progress"})
        end
        return false
    end
    return true
end

function dawnbreaker_celestial_hammer_custom:OnSpellStart()
    if not IsServer() then return end
    if not self.projectiles then
        self.projectiles = {}
    end
    if not self.thinkers then
        self.thinkers = {}
    end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local name = ""
	local radius = self:GetSpecialValueFor( "projectile_radius" )
	local speed = self:GetSpecialValueFor( "projectile_speed" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_20") then
        speed = speed + (speed / 100 * self.modifier_dawnbreaker_20[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_20")])
    end
    local dawnbreaker_celestial_hammer_custom_immune = self:GetCaster():FindAbilityByName("dawnbreaker_celestial_hammer_custom_immune")
    if dawnbreaker_celestial_hammer_custom_immune then
        dawnbreaker_celestial_hammer_custom_immune:SetLevel(self:GetLevel())
    end
    local cast_range_multiplier = 1
    if self:GetCaster():HasModifier("modifier_dawnbreaker_20") then
        cast_range_multiplier = cast_range_multiplier + self.modifier_dawnbreaker_20[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_20")] / 100
    end
	local distance = (self:GetSpecialValueFor( "range" ) + self:GetCaster():GetCastRangeBonus()) * cast_range_multiplier
	local direction = point-caster:GetOrigin()
	local len = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	distance = math.min( distance, len )
	local thinker = CreateModifierThinker( caster, self, "modifier_dawnbreaker_celestial_hammer_custom_thinker", {}, caster:GetOrigin(), self:GetCaster():GetTeamNumber(), false )

	local info = 
    {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		EffectName = name,
		fDistance = distance,
		fStartRadius = radius,
		fEndRadius = radius,
		vVelocity = direction * speed,
	}

	local data = 
    {
		cast = 1,
		targets = {},
		thinker = thinker,
	}

	local id = ProjectileManager:CreateLinearProjectile( info )
	thinker.id = id
	self.projectiles[id] = data
	table.insert( self.thinkers, thinker )

	local ability = caster:FindAbilityByName( "dawnbreaker_converge_custom" )
	if ability then
		ability:SetActivated( true )
		caster:SwapAbilities( "dawnbreaker_celestial_hammer_custom", "dawnbreaker_converge_custom", false, true )
		ability:StartCooldown( ability:GetCooldown( -1 ) )
	end

	caster:AddNewModifier( caster, self, "modifier_dawnbreaker_celestial_hammer_custom_nohammer", {})

	data.effect = self:PlayEffects1( caster:GetOrigin(), distance, direction * speed )
end

function dawnbreaker_celestial_hammer_custom:OnProjectileThinkHandle( handle )
	local data = self.projectiles[handle]
	if data.thinker:IsNull() then return end
	if data.cast == 1 then
		local location = ProjectileManager:GetLinearProjectileLocation( handle )
		data.thinker:SetOrigin( location )
		local radius = self:GetSpecialValueFor( "projectile_radius" )
		GridNav:DestroyTreesAroundPoint( location, radius, false )
	elseif data.cast==2 then
		local location = ProjectileManager:GetTrackingProjectileLocation( handle )
		local radius = self:GetSpecialValueFor( "projectile_radius" )
		data.thinker:SetOrigin( location )
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), location, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(enemies) do
			if not data.targets[enemy] then
				data.targets[enemy] = true
				self:HammerHit( enemy, location )
			end
		end
		local radius = self:GetSpecialValueFor( "projectile_radius" )
		GridNav:DestroyTreesAroundPoint( location, radius, false )
	end
end

function dawnbreaker_celestial_hammer_custom:OnProjectileHitHandle( target, location, handle )
	local data = self.projectiles[handle]
	if not handle then return end
	if data.cast==1 then
		if target then
			self:HammerHit( target, location )
			return false
		end
		local loc = GetGroundPosition( location, self:GetCaster() )
		data.thinker:SetOrigin( loc )
		local mod = data.thinker:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom_thinker" )
		mod:Delay()
		self:StopEffects( data.effect )
		self.projectiles[handle] = nil
	elseif data.cast==2 then
		local caster = self:GetCaster()
		for i,thinker in pairs(self.thinkers) do
			if thinker == data.thinker then
				table.remove( self.thinkers, i )
				break
			end
		end
		local mod = data.thinker:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom_thinker" )
        if mod then
            mod:Destroy()
            local ability = caster:FindAbilityByName( "dawnbreaker_converge_custom" )
            if ability then
                caster:SwapAbilities( "dawnbreaker_converge_custom", "dawnbreaker_celestial_hammer_custom", false, true )
            end
        end
        caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
		local nohammer = caster:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" )
		if nohammer then
            print("cast 1")
			nohammer:Decrement()
		end

		local converge = caster:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom" )
		if converge then
			converge:Destroy()
		end

		self.projectiles[handle] = nil

		self:PlayEffects3()
	end
end

function dawnbreaker_celestial_hammer_custom:HammerHit( target, location )
	local damage = self:GetSpecialValueFor( "hammer_damage" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_21") then
        damage = damage + self.modifier_dawnbreaker_21
    end
    local damage_type = self:GetAbilityDamageType()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_21") then
        damage_type = DAMAGE_TYPE_PURE
    end
    local ability = self
    if self:GetCaster():HasModifier("modifier_dawnbreaker_21") then
        ability = self:GetCaster():FindAbilityByName("dawnbreaker_celestial_hammer_custom_immune")
    end
	local damageTable = 
    {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = damage_type,
		ability = ability,
	}
	ApplyDamage(damageTable)
    if self:GetCaster():HasModifier("modifier_dawnbreaker_19") then
        target:AddNewModifier(self:GetCaster(), ability, "modifier_stunned", {duration = self.modifier_dawnbreaker_19[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_19")] * (1-target:GetStatusResistance())})
    end
    if self:GetCaster():HasModifier("modifier_dawnbreaker_17") then
        self:GetCaster():PerformAttack(target, true, true, true, true, false, false, true)
    end
	self:PlayEffects2( target )
end

function dawnbreaker_celestial_hammer_custom:Converge()
	local caster = self:GetCaster()
	local target
	for i,thinker in ipairs(self.thinkers) do
		target = thinker
		break
	end
	if not target then return end
	if self.projectiles[target.id] then
		self:StopEffects( self.projectiles[target.id].effect )
		self.projectiles[target.id] = nil
		ProjectileManager:DestroyLinearProjectile( target.id )
	end

	local mod = target:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom_thinker" )
	mod:Return(true)
	caster:AddNewModifier(caster, self, "modifier_dawnbreaker_celestial_hammer_custom", {target = target:entindex()})

	caster:EmitSound("Hero_Dawnbreaker.Converge.Cast")
end

function dawnbreaker_celestial_hammer_custom:PlayEffects1( start, distance, velocity )
	local min_rate = 1
	local duration = distance/velocity:Length2D()
	local rotation = 0.5
	local rate = rotation/duration
	while rate<min_rate do
		rotation = rotation + 1
		rate = rotation/duration
	end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_projectile.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, start )
	ParticleManager:SetParticleControl( effect_cast, 1, velocity )
	ParticleManager:SetParticleControl( effect_cast, 4, Vector( rate, 0, 0 ) )
	self:GetCaster():EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Cast")
	return effect_cast
end

function dawnbreaker_celestial_hammer_custom:PlayEffects2( target )
	local radius = self:GetSpecialValueFor( "projectile_radius" )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_aoe_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Damage")
end

function dawnbreaker_celestial_hammer_custom:PlayEffects3()
	local radius = self:GetSpecialValueFor( "projectile_radius" )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 3, hTarget, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function dawnbreaker_celestial_hammer_custom:StopEffects( effect )
	ParticleManager:DestroyParticle( effect, false )
	ParticleManager:ReleaseParticleIndex( effect )
end

dawnbreaker_converge_custom = class({})

function dawnbreaker_converge_custom:OnAbilityPhaseStart()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_fire_wreath_custom") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#dota_hud_error_fire_wreath_in_progress"})
        end
        return false
    end
    return true
end

function dawnbreaker_converge_custom:OnSpellStart()
	local caster = self:GetCaster()
	local main = caster:FindAbilityByName( "dawnbreaker_celestial_hammer_custom" )
	if main then
		main:Converge()
	end
	self:SetActivated( false )
end

modifier_dawnbreaker_celestial_hammer_custom = class({})
function modifier_dawnbreaker_celestial_hammer_custom:IsPurgable() return false end
function modifier_dawnbreaker_celestial_hammer_custom:IsPurgeException() return false end

function modifier_dawnbreaker_celestial_hammer_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_20") then
        self.speed = self.speed + (self.speed / 100 * self:GetAbility().modifier_dawnbreaker_20[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_20")])
    end
	self.speed_pct = self:GetAbility():GetSpecialValueFor( "travel_speed_pct" )
	self.duration = self:GetAbility():GetSpecialValueFor( "flare_debuff_duration" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_18") then
        self.duration = self.duration + self:GetAbility().modifier_dawnbreaker_18[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_18")]
    end
	self.interval = 0.1
	if not IsServer() then return end
    local cast_range_multiplier = 1
    if self:GetCaster():HasModifier("modifier_dawnbreaker_20") then
        cast_range_multiplier = cast_range_multiplier + self:GetAbility().modifier_dawnbreaker_20[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_20")] / 100
    end
    self.max_range = self:GetAbility():GetSpecialValueFor( "range" ) * cast_range_multiplier
	self.origin = self.parent:GetOrigin()
	self.prev_pos = self.parent:GetOrigin()
	self.actual_speed = self.speed*self.speed_pct/100
	self.target = EntIndexToHScript( kv.target )
    self.distance_to_target = (self.target:GetOrigin()-self.parent:GetOrigin()):Length2D()

	local direction = self.target:GetOrigin()-self.parent:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	self.parent:SetForwardVector( direction )

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
	self:PlayEffects()
end

function modifier_dawnbreaker_celestial_hammer_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_17") then
        local caster = self:GetCaster()
		for i,thinker in pairs(self:GetAbility().thinkers) do
			if thinker == self.target then
				table.remove( self:GetAbility().thinkers, i )
				break
			end
		end
        local is_delete = false
        if self.target and not self.target:IsNull() then
            local mod = self.target:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom_thinker" )
            if mod then
                is_delete = true
                mod:Destroy()
            end
        end
        if is_delete then
            local ability = caster:FindAbilityByName( "dawnbreaker_converge_custom" )
            if ability then
                caster:SwapAbilities( "dawnbreaker_converge_custom", "dawnbreaker_celestial_hammer_custom", false, true )
            end
        end
        caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
		local nohammer = caster:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" )
		if nohammer then
            print("cast 2")
			nohammer:Decrement()
		end
		local converge = caster:FindModifierByName( "modifier_dawnbreaker_celestial_hammer_custom" )
		if converge then
			converge:Destroy()
		end
    end
end

function modifier_dawnbreaker_celestial_hammer_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end

function modifier_dawnbreaker_celestial_hammer_custom:GetOverrideAnimation()
    return ACT_DOTA_OVERRIDE_ABILITY_2
end

function modifier_dawnbreaker_celestial_hammer_custom:GetModifierDisableTurning()
	return 1
end

function modifier_dawnbreaker_celestial_hammer_custom:CheckState()
	return
    {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_dawnbreaker_celestial_hammer_custom:OnIntervalThink()
	local thinker = CreateModifierThinker( self.parent, self.ability, "modifier_dawnbreaker_celestial_hammer_custom_trail", { duration = self.duration, x = self.prev_pos.x, y = self.prev_pos.y,}, self.parent:GetOrigin(), self.parent:GetTeamNumber(), false )
	self.prev_pos = self.parent:GetOrigin()
end

function modifier_dawnbreaker_celestial_hammer_custom:UpdateHorizontalMotion( me, dt )
    if not self:GetParent():HasModifier("modifier_dawnbreaker_17") then
        local dist = (self.origin-me:GetOrigin()):Length2D()
        if dist>self.max_range then
            self:Destroy()
            return
        end
    end
    self.distance_to_target = self.distance_to_target - (self.actual_speed * dt)
    if (self.distance_to_target <= 0) then
        self:Destroy()
        return
    end
	local pos = me:GetOrigin() + me:GetForwardVector() * self.actual_speed * dt
	pos = GetGroundPosition( pos, me )
	me:SetOrigin( pos )
end

function modifier_dawnbreaker_celestial_hammer_custom:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_dawnbreaker_celestial_hammer_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_trail.vpcf", PATTACH_ABSORIGIN, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlForward( effect_cast, 0, self.parent:GetForwardVector() )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end

modifier_dawnbreaker_celestial_hammer_custom_debuff = class({})

function modifier_dawnbreaker_celestial_hammer_custom_debuff:OnCreated( kv )
	self.interval = self:GetAbility():GetSpecialValueFor( "burn_interval" )
	self.slow = self:GetAbility():GetSpecialValueFor( "move_slow" )
	if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_16") then
        self.damage = self.damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_dawnbreaker_16[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_16")])
    end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_21") then
        self.abilityDamageType = DAMAGE_TYPE_PURE
    end
    local ability = self:GetAbility()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_21") then
        ability = self:GetCaster():FindAbilityByName("dawnbreaker_celestial_hammer_custom_immune")
    end
	self.damageTable = 
    {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage*self.interval,
		damage_type = self.abilityDamageType,
		ability = ability,
	}
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_dawnbreaker_celestial_hammer_custom_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_dawnbreaker_celestial_hammer_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_dawnbreaker_celestial_hammer_custom_debuff:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

function modifier_dawnbreaker_celestial_hammer_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_debuff.vpcf"
end

function modifier_dawnbreaker_celestial_hammer_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


modifier_dawnbreaker_celestial_hammer_custom_nohammer = class({})

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:IsHidden()
	return true
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:IsPurgable()
	return false
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:OnDestroy()
    if not IsServer() then return end
    if self:GetCaster() and self:GetCaster():IsHero() then
        local hHook = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
        if hHook ~= nil then
            hHook:RemoveEffects( EF_NODRAW )
        end
    end
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:OnCreated( kv )
	if not IsServer() then return end
	self:IncrementStackCount()
    if self:GetCaster() and self:GetCaster():IsHero() then
        local hHook = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
        if hHook ~= nil then
            hHook:AddEffects( EF_NODRAW )
        end
    end
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:Decrement()
	self:DecrementStackCount()
	if self:GetStackCount()<1 then
		self:Destroy()
	end
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_dawnbreaker_celestial_hammer_custom_nohammer:GetActivityTranslationModifiers()
    return "no_hammer"
end

modifier_dawnbreaker_celestial_hammer_custom_thinker = class({})

function modifier_dawnbreaker_celestial_hammer_custom_thinker:IsHidden()
	return true
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:IsPurgable()
	return false
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.name = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_return.vpcf"
	self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_20") then
        self.speed = self.speed + (self.speed / 100 * self:GetAbility().modifier_dawnbreaker_20[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_20")])
    end
	self.delay = self:GetAbility():GetSpecialValueFor( "pause_duration" )
	self.duration = self:GetAbility():GetSpecialValueFor( "flare_debuff_duration" )
	self.vision = 200
	self.interval = 0.1
	self.max_return = 1.5
	if not IsServer() then return end
	self.parent:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Projectile")
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:OnIntervalThink()
	if not self.converge then
		self:Return()
		return
	end
    local ability = self:GetAbility()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_21") then
        ability = self:GetCaster():FindAbilityByName("dawnbreaker_celestial_hammer_custom_immune")
    end
	local thinker = CreateModifierThinker( self.caster, ability, "modifier_dawnbreaker_celestial_hammer_custom_trail", { duration = self.duration, x = self.prev_pos.x, y = self.prev_pos.y }, self.parent:GetOrigin(), self.caster:GetTeamNumber(), false )
	self.prev_pos = self.parent:GetOrigin()
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:Delay()
	self:PlayEffects1()
	self:StartIntervalThink( self.delay )
	AddFOWViewer( self.caster:GetTeamNumber(), self.parent:GetOrigin(), self.vision, self.delay, false)
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:Return(is_use)
	if self.converge then return end
	self.converge = true
	self.prev_pos = self.parent:GetOrigin()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_17") and is_use then
        return
    end
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
	self.distance = (self.parent:GetOrigin()-self.caster:GetOrigin()):Length2D()
	if self.distance > self.speed*self.max_return then
		self.speed = self.distance/self.max_return
	end
	local info = 
    {
		Target = self.caster,
		Source = self.parent,
		Ability = self.ability,	
		EffectName = self.name,
		iMoveSpeed = self.speed,
		bDodgeable = false,
	}
	local data = 
    {
		cast = 2,
		targets = {},
		thinker = self.parent,
	}
	local id = ProjectileManager:CreateTrackingProjectile(info)
	self.ability.projectiles[id] = data
	self:PlayEffects2()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_celestial_hammer_custom_thinker:PlayEffects1()
	local direction = self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_grounded.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 0, direction )
	self.effect_cast = effect_cast
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.parent:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Impact")
end

function modifier_dawnbreaker_celestial_hammer_custom_thinker:PlayEffects2()
	if self.effect_cast then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
	self.parent:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Return")
end

modifier_dawnbreaker_celestial_hammer_custom_trail = class({})

function modifier_dawnbreaker_celestial_hammer_custom_trail:IsHidden()
	return true
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:IsPurgable()
	return false
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "flare_radius" )
	if not IsServer() then return end
	self.prev_pos = Vector( kv.x, kv.y, 0 )
	self.prev_pos = GetGroundPosition( self.prev_pos, self:GetParent() )
	self:PlayEffects( kv.duration )
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:IsAura()
	return true
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:GetModifierAura()
	return "modifier_dawnbreaker_celestial_hammer_custom_debuff"
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:GetAuraRadius()
	return self.radius
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:GetAuraDuration()
	return 0.5
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:GetAuraSearchFlags()
	return 0
end

function modifier_dawnbreaker_celestial_hammer_custom_trail:PlayEffects( duration )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_burning_trail.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self.prev_pos )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

dawnbreaker_celestial_hammer_custom_immune = dawnbreaker_celestial_hammer_custom