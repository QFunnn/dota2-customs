--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier( "modifier_dawnbreaker_solar_guardian_custom", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_solar_guardian_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_solar_guardian_custom_leap", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_solar_guardian_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

dawnbreaker_solar_guardian_custom = class({})
dawnbreaker_solar_guardian_custom.modifier_dawnbreaker_8 = {200, 400}
dawnbreaker_solar_guardian_custom.modifier_dawnbreaker_10 = {45, 90}
dawnbreaker_solar_guardian_custom.modifier_dawnbreaker_11 = {45, 90}
dawnbreaker_solar_guardian_custom.modifier_dawnbreaker_13 = {-20,-40}
dawnbreaker_solar_guardian_custom.modifier_dawnbreaker_12 = {1,2,3}

function dawnbreaker_solar_guardian_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_14") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED
end

function dawnbreaker_solar_guardian_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return 1
    end
end

function dawnbreaker_solar_guardian_custom:GetChannelTime()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_12") then
        return FrameTime()
    end
    return 1.7
end

function dawnbreaker_solar_guardian_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_dawnbreaker_13") then
        bonus = self.modifier_dawnbreaker_13[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_13")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function dawnbreaker_solar_guardian_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_dawnbreaker_14") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function dawnbreaker_solar_guardian_custom:FindValidPoint( point )
	local caster = self:GetCaster()
	local offset = self:GetSpecialValueFor( "max_offset_distance" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_8") then
        offset = offset + self.modifier_dawnbreaker_8[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_8")]
    end
	local allies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	local target = caster
	local distance = (caster:GetAbsOrigin()-point):Length2D()
	for _,ally in pairs(allies) do
		local d = (ally:GetAbsOrigin()-point):Length2D()
		if d<distance then
			distance = d
			target = ally
		end
	end

	if distance<offset then
		return target,point
	end

	local direction = point-target:GetAbsOrigin()
	direction.z = 0
	direction = direction:Normalized()

	point = target:GetAbsOrigin() + direction*offset
	point = GetGroundPosition( point, caster )
	return target, point
end

function dawnbreaker_solar_guardian_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function dawnbreaker_solar_guardian_custom:CastFilterResultLocation( vLoc )
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" ) then
		return UF_FAIL_CUSTOM
	end
	if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_dawnbreaker_14") then return UF_SUCCESS end
	local caster = self:GetCaster()
	local max_offset_distance = self:GetSpecialValueFor("max_offset_distance")
    if self:GetCaster():HasModifier("modifier_dawnbreaker_8") then
        max_offset_distance = max_offset_distance + self.modifier_dawnbreaker_8[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_8")]
    end
	local allies = FindUnitsInRadius( caster:GetTeamNumber(), vLoc, nil, 1200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if #allies<1 then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function dawnbreaker_solar_guardian_custom:GetCustomCastErrorLocation( vLoc )
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_custom_nohammer" ) then
		return "#dota_hud_error_nohammer"
	end
	if not IsServer() then return "" end
	local caster = self:GetCaster()
	local max_offset_distance = self:GetSpecialValueFor("max_offset_distance")
    if self:GetCaster():HasModifier("modifier_dawnbreaker_8") then
        max_offset_distance = max_offset_distance + self.modifier_dawnbreaker_8[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_8")]
    end
	local allies = FindUnitsInRadius( caster:GetTeamNumber(), vLoc, nil, 1200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	if #allies<1 then
		return "#dota_hud_error_no_hero_in_range"
	end
	return ""
end

function dawnbreaker_solar_guardian_custom:OnAbilityPhaseStart()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_fire_wreath_custom") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#dota_hud_error_fire_wreath_in_progress"})
        end
        return false
    end
    return true
end

function dawnbreaker_solar_guardian_custom:OnSpellStart()
    if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local target, point = self:FindValidPoint( point )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_14") then
        point = self:GetCursorPosition()
    end
	local channel = self:GetChannelTime()
	local leaptime = self:GetSpecialValueFor( "airtime_duration" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_12") then
        channel = self.modifier_dawnbreaker_12[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_12")]
    end
    caster:RemoveModifierByName("modifier_dawnbreaker_solar_guardian_custom")
	caster:AddNewModifier( caster, self, "modifier_dawnbreaker_solar_guardian_custom", {duration = channel + leaptime, x = point.x, y = point.y })
	self.point = point
    SetOnlyDay(self:GetSpecialValueFor("daytime_duration"))
end

function dawnbreaker_solar_guardian_custom:OnChannelFinish( interrupted )
	local caster = self:GetCaster()
	if interrupted then
		local mod = caster:FindModifierByName( "modifier_dawnbreaker_solar_guardian_custom" )
		if mod and (not mod:IsNull()) then
			mod:Destroy()
		end
		return
	end
	local duration = self:GetSpecialValueFor( "airtime_duration" )
	caster:AddNewModifier( caster, self, "modifier_dawnbreaker_solar_guardian_custom_leap", { duration = duration, x = self.point.x, y = self.point.y })
end

function dawnbreaker_solar_guardian_custom:FastPulse(point)
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor( "radius" )

    local damage = self:GetSpecialValueFor( "base_damage" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_10") then
        damage = damage + (self:GetCaster():GetAgility() / 100 * self.modifier_dawnbreaker_10[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_10")])
    end
    
	local heal = self:GetSpecialValueFor( "base_heal" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_11") then
        heal = heal + (self:GetCaster():GetAgility() / 100 * self.modifier_dawnbreaker_11[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_11")])
    end

    point = GetGroundPosition( point, self:GetCaster() )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_damage.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( point, "Hero_Dawnbreaker.Solar_Guardian.Damage", self:GetCaster() )
    
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbilityDamageType(), ability = self})
	end

	local allies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,ally in pairs(allies) do
		ally:Heal(heal, self)
		SendOverheadEventMessage( nil, OVERHEAD_ALERT_HEAL, ally, heal, self:GetCaster():GetPlayerOwner())
	end
end

function dawnbreaker_solar_guardian_custom:LandDamage(point)
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor( "land_damage" )
    local duration = self:GetSpecialValueFor( "land_stun_duration" )
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local damageTable = 
    {
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}
	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage( damageTable )
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration * (1 - enemy:GetStatusResistance()) } )
	end

	GridNav:DestroyTreesAroundPoint(point, radius / 2, false )
	
    point = GetGroundPosition( point, self:GetCaster() )

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_landing.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOnLocationWithCaster(point, "Hero_Dawnbreaker.Solar_Guardian.Impact", self:GetCaster())
end

modifier_dawnbreaker_solar_guardian_custom = class({})

function modifier_dawnbreaker_solar_guardian_custom:IsHidden()
	return false
end

function modifier_dawnbreaker_solar_guardian_custom:IsDebuff()
	return false
end

function modifier_dawnbreaker_solar_guardian_custom:IsPurgable()
	return false
end

function modifier_dawnbreaker_solar_guardian_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.damage = self:GetAbility():GetSpecialValueFor( "base_damage" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_10") then
        self.damage = self.damage + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_dawnbreaker_10[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_10")])
    end
	self.heal = self:GetAbility():GetSpecialValueFor( "base_heal" )
    if self:GetCaster():HasModifier("modifier_dawnbreaker_11") then
        self.heal = self.heal + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_dawnbreaker_11[self:GetCaster():GetTalentLevel("modifier_dawnbreaker_11")])
    end
	self.interval = self:GetAbility():GetSpecialValueFor( "pulse_interval" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.point = Vector( kv.x, kv.y, 0 )
	self.damageTable = 
    {
		attacker = self.parent,
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}
    self.change_bind = false
    self.ticks_counter = 0
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
	self:PlayEffects1()
	self:PlayEffects2( self.point, self.radius )
end

function modifier_dawnbreaker_solar_guardian_custom:ChangeBind()
    print("skibidi")
    if self.particle then
        ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
        ParticleManager:DestroyParticle(self.particle, true)
        self:PlayEffects2(self.parent:GetAbsOrigin(), self.radius, self.parent )
    end
    self.change_bind = true
end

function modifier_dawnbreaker_solar_guardian_custom:OnDestroy()
	if not IsServer() then return end
	FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), false )
	local sound_cast1 = "Hero_Dawnbreaker.Solar_Guardian.Channel"
	local sound_cast2 = "Hero_Dawnbreaker.Solar_Guardian.Target"
	StopSoundOn( sound_cast1, self.parent )
	StopSoundOn( sound_cast2, self.parent )
end

function modifier_dawnbreaker_solar_guardian_custom:CheckState()
    if self:GetCaster():HasModifier("modifier_dawnbreaker_12") then
        if self:GetElapsedTime() >= 1 then return end
    end
	return
    {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

function modifier_dawnbreaker_solar_guardian_custom:OnIntervalThink()
    if self.change_bind then
        self.point = self:GetParent():GetOrigin()
    end
    if self:GetParent():HasModifier("modifier_dawnbreaker_14") then
        AddFOWViewer(self:GetParent():GetTeamNumber(), self.point, self.radius, self.interval + FrameTime(), false)
    end
    if not self:GetParent():HasModifier("modifier_dawnbreaker_12") then
        if self.ticks_counter == 5 then return end
        self.ticks_counter = self.ticks_counter + 1
    end
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.point, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end
	local allies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.point, nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,ally in pairs(allies) do
		ally:Heal( self.heal, self.ability )
		self:PlayEffects4( ally )
		SendOverheadEventMessage( nil, OVERHEAD_ALERT_HEAL, ally, self.heal, self.parent:GetPlayerOwner())
	end
	self:PlayEffects3( self.point, self.radius )
end

function modifier_dawnbreaker_solar_guardian_custom:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.parent:EmitSound("Hero_Dawnbreaker.Solar_Guardian.Channel")
end

function modifier_dawnbreaker_solar_guardian_custom:PlayEffects2( point, radius, caster )
	point = GetGroundPosition( point, self.parent )
	local effect_cast
    if caster then
        effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
        ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
    else
        effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_aoe.vpcf", PATTACH_WORLDORIGIN, self.parent )
        ParticleManager:SetParticleControl( effect_cast, 0, point )
        ParticleManager:SetParticleControl( effect_cast, 1, point )
    end
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
    self.particle = effect_cast
    if not caster then
	    EmitSoundOnLocationWithCaster( point, "Hero_Dawnbreaker.Solar_Guardian.Target", self.parent )
    end
end

function modifier_dawnbreaker_solar_guardian_custom:PlayEffects3( point, radius )
	point = GetGroundPosition( point, self.parent )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_damage.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( point, "Hero_Dawnbreaker.Solar_Guardian.Damage", self.parent )
end

function modifier_dawnbreaker_solar_guardian_custom:PlayEffects4( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_healing_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dawnbreaker_solar_guardian_custom_leap = class({})

function modifier_dawnbreaker_solar_guardian_custom_leap:IsHidden()
	return false
end

function modifier_dawnbreaker_solar_guardian_custom_leap:IsDebuff()
	return false
end

function modifier_dawnbreaker_solar_guardian_custom_leap:IsPurgable()
	return false
end

function modifier_dawnbreaker_solar_guardian_custom_leap:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.damage = self:GetAbility():GetSpecialValueFor( "land_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "land_stun_duration" )
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	local arc_height = 2000
	self.point = Vector( kv.x, kv.y, 0 )
	self.interrupted = false
	local arc = self.parent:AddNewModifier( self.parent, self:GetAbility(), "modifier_generic_arc_lua", { duration = kv.duration, height = arc_height, isStun = false, isForward = true })
	arc:SetEndCallback(function( interrupted )
		if interrupted then
			self.interrupted = interrupted
			self:Destroy()
		end
	end)
	self:StartIntervalThink( kv.duration / 2 )
	self:PlayEffects1()
end

function modifier_dawnbreaker_solar_guardian_custom_leap:OnDestroy()
	if not IsServer() then return end
	if self.interrupted then return end
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.point, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	local damageTable = 
    {
		attacker = self.parent,
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self.ability,
	}

	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage( damageTable )
		enemy:AddNewModifier( self.parent, self.ability, "modifier_stunned", { duration = self.duration * (1 - enemy:GetStatusResistance()) } )
	end

    local modifier_dawnbreaker_solar_guardian_custom = self.parent:FindModifierByName("modifier_dawnbreaker_solar_guardian_custom")
    if modifier_dawnbreaker_solar_guardian_custom then
        modifier_dawnbreaker_solar_guardian_custom:ChangeBind()
    end

    self.parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
	GridNav:DestroyTreesAroundPoint( self.point, self.radius/2, false )
	self:PlayEffects2( self.point, self.radius )

    FindClearSpaceForUnit(self.parent, self.point, true)
end

function modifier_dawnbreaker_solar_guardian_custom_leap:OnIntervalThink()
	self.point.z = self.parent:GetOrigin().z
	self.parent:SetOrigin( self.point )
end

function modifier_dawnbreaker_solar_guardian_custom_leap:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_airtime_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.parent:EmitSound("Hero_Dawnbreaker.Solar_Guardian.BlastOff")
end

function modifier_dawnbreaker_solar_guardian_custom_leap:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
    }
end

function modifier_dawnbreaker_solar_guardian_custom_leap:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_dawnbreaker_solar_guardian_custom_leap:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_dawnbreaker_solar_guardian_custom_leap:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_dawnbreaker_solar_guardian_custom_leap:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_dawnbreaker_solar_guardian_custom_leap:PlayEffects2( point, radius )
	point = GetGroundPosition( point, self.parent )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_landing.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( point, "Hero_Dawnbreaker.Solar_Guardian.Impact", self.parent )
end

dawnbreaker_land_custom = class({})