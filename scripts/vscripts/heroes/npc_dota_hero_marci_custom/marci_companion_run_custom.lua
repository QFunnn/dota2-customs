--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_companion_run_custom", "heroes/npc_dota_hero_marci_custom/marci_companion_run_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier("modifier_marci_companion_run_custom_buff", "heroes/npc_dota_hero_marci_custom/marci_companion_run_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_companion_run_custom_handler", "heroes/npc_dota_hero_marci_custom/marci_companion_run_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

marci_companion_run_custom = class({})

marci_companion_run_custom.modifier_marci_13 = {0.2,0.4,0.6}
marci_companion_run_custom.modifier_marci_11 = {30,60}

function marci_companion_run_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_charge_projectile.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_landing_zone.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_landing_zone.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_marci.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_marci.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_marci.vpcf", context)
end

function marci_companion_run_custom:GetCooldown( level )
	local percent = 1
	if self:GetCaster():HasModifier("modifier_marci_11") then
		percent = percent - ((self:GetCaster():GetModifierStackCount("modifier_marci_companion_run_custom_handler", self:GetCaster()) / 100 * self.modifier_marci_11[self:GetCaster():GetTalentLevel("modifier_marci_11")]) / 100)
	end
	return self.BaseClass.GetCooldown( self, level ) * percent
end

function marci_companion_run_custom:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end
    local flag_team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
    if self:GetCaster():HasModifier("modifier_marci_10") then
        flag_team = DOTA_UNIT_TARGET_TEAM_BOTH
    end
	local nResult = UnitFilter(
		hTarget,
		flag_team,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	self.targetcast = hTarget
	return UF_SUCCESS
end

function marci_companion_run_custom:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
	return ""
end

function marci_companion_run_custom:GetIntrinsicModifierName()
    return "modifier_marci_companion_run_custom_handler"
end

function marci_companion_run_custom:GetDamage()
    return self:GetSpecialValueFor("impact_damage")
end

function marci_companion_run_custom:DealDamage()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("landing_radius")
    local stun = self:GetSpecialValueFor("stun_duration")
    local debuff_duration = self:GetSpecialValueFor("debuff_duration")
    if self:GetCaster():HasModifier("modifier_marci_13") then
        debuff_duration = debuff_duration + self.modifier_marci_13[self:GetCaster():GetTalentLevel("modifier_marci_13")]
    end
    caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2_END,1)
    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    local damageTable = { attacker = caster, damage = self:GetDamage(), damage_type = DAMAGE_TYPE_MAGICAL, ability = self, }
    for _,enemy in pairs(enemies) do
        damageTable.victim = enemy
        ApplyDamage(damageTable)
        enemy:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - enemy:GetStatusResistance())*debuff_duration})
    end
    if self:GetCaster():HasModifier("modifier_marci_7") and self:GetCaster():HasModifier("modifier_marci_unleash_custom") then
        local marci_unleash_custom = self:GetCaster():FindAbilityByName("marci_unleash_custom")
        if marci_unleash_custom then
            marci_unleash_custom:Pulse( caster:GetOrigin() )
        end
    end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, caster:GetAbsOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, caster:GetAbsOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 9, Vector(radius, radius, radius) )
    ParticleManager:SetParticleControl( effect_cast, 10, caster:GetAbsOrigin() )
    ParticleManager:DestroyParticle(effect_cast, false)
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationWithCaster( caster:GetAbsOrigin(), "Hero_Marci.Rebound.Impact", caster )
end

function marci_companion_run_custom:OnVectorCastStart(vStartLocation, vDirection)
    local caster = self:GetCaster()
    local target = self.targetcast
    if target and target:GetTeamNumber() ~= caster:GetTeamNumber() and target:TriggerSpellAbsorb(self) then
        return
    end
    print("111")
    self.is_alt_cast = self:GetAltCastState()
    print("self.is_alt_cast", self.is_alt_cast)
    local speed = self:GetSpecialValueFor( "move_speed" )
    local info = { Target = target, Source = caster, Ability = self, iMoveSpeed = speed, bDodgeable = false, }
    local proj = ProjectileManager:CreateTrackingProjectile(info)
    local point = target:GetAbsOrigin()
    local point_check = point
    point = self:GetVector2Position()
    point_check = self:GetTargetPositionCheck()
    local jump_heh = false
    local sravnenie = ((point_check-point):Length2D())
    sravnenie = math.abs(sravnenie)
    if sravnenie<= 50 then
        jump_heh = true
    end
    local is_toggle = nil
    self.modifier = caster:AddNewModifier( caster, self, "modifier_marci_companion_run_custom", { proj = tostring(proj), target = target:entindex(), point_x = point.x, point_y = point.y, point_z = point.z, jump_heh = jump_heh, is_toggle = is_toggle} )
end

function marci_companion_run_custom:OnSpellStartOther()
    local caster = self:GetCaster()
    local target = self.targetcast
    if target and target:GetTeamNumber() ~= caster:GetTeamNumber() and target:TriggerSpellAbsorb(self) then
        return
    end
    local speed = self:GetSpecialValueFor( "move_speed" )
    local info = { Target = target, Source = caster, Ability = self, iMoveSpeed = speed, bDodgeable = false, }
    local proj = ProjectileManager:CreateTrackingProjectile(info)
    local point = target:GetAbsOrigin()
    local jump_heh = false
    local is_toggle = nil
    self.modifier = caster:AddNewModifier( caster, self, "modifier_marci_companion_run_custom", { proj = tostring(proj), target = target:entindex(), is_toggle = is_toggle} )
end

function marci_companion_run_custom:OnProjectileHit( target, location )
    if not self.modifier:IsNull() then
        if not target then
            self.modifier.interrupted = true
        end
        self.modifier:Destroy()
    end
end

modifier_marci_companion_run_custom = class({})
function modifier_marci_companion_run_custom:IsHidden() return true end
function modifier_marci_companion_run_custom:IsPurgable() return false end

function modifier_marci_companion_run_custom:OnCreated( kv )
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.duration = 0.5
    self.height = self.ability:GetSpecialValueFor( "min_height_above_highest" )
    self.min_distance = self.ability:GetSpecialValueFor( "min_jump_distance" )
    self.max_distance = self.ability:GetSpecialValueFor( "max_jump_distance" )
    self.radius = self.ability:GetSpecialValueFor( "landing_radius" )
    self.damage = self.ability:GetSpecialValueFor( "impact_damage" )
    self.debuff = self.ability:GetSpecialValueFor( "debuff_duration" )
    self.buff = self.ability:GetSpecialValueFor( "ally_buff_duration" )
    self.is_toggle = kv.is_toggle
    if not IsServer() then return end
    self.projectile = tonumber(kv.proj)
    self.target = EntIndexToHScript( kv.target )
    self.targetpos = self.target:GetOrigin()
    self.distancethreshold = 2000
    if not self:ApplyHorizontalMotionController() then
        self.interrupted = true
        self:Destroy()
    end
    local speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
    self:PlayEffects1( self.parent, speed )
    self.start_direction = self.targetpos - self.parent:GetAbsOrigin()
    self.point = Vector( kv.point_x, kv.point_y, kv.point_z )
    self.direction = self.point - self.target:GetAbsOrigin()
    self.distance = self.direction:Length2D()
    self.jump_heh = kv.jump_heh
    if self.jump_heh == 1 then
        self.direction = self.start_direction
    end
    self.direction.z = 0    
    self.direction = self.direction:Normalized()
    self.distance = math.min(math.max(self.distance,self.min_distance),self.max_distance)
    if not self.is_toggle then
        self:PlayEffects3( self.target:GetAbsOrigin() + self.distance * self.direction, self.radius )
    end
end

function modifier_marci_companion_run_custom:OnDestroy()
    if not IsServer() then return end	
    self.parent:RemoveHorizontalMotionController( self )
    if self.interrupted then return end
    local allied = self.target:GetTeamNumber()==self.parent:GetTeamNumber()
    if allied then
        self.target:AddNewModifier( self.parent, self.ability, "modifier_marci_companion_run_custom_buff", { duration = self.buff } )
    end
    if self:GetCaster():HasModifier("modifier_marci_9") then
        self:GetCaster():AddNewModifier( self.parent, self.ability, "modifier_marci_companion_run_custom_buff", { duration = self.buff } )
    end
    self.parent:SetForwardVector( self.direction )
    if self.is_toggle then
        self.ability:DealDamage()
        return
    end
    local arc = self.parent:AddNewModifier( self.parent, self:GetAbility(), "modifier_generic_arc_lua",
    { 
        dir_x = self.direction.x,
        dir_y = self.direction.y,
        duration = self.duration,
        distance = self.distance,
        height = self.height,
        fix_end = false,
        isStun = true,
        isForward = true,
        activity = ACT_DOTA_OVERRIDE_ABILITY_2,
    })
    if self:GetAbility().is_alt_cast then
        local arc_friendly = self.target:AddNewModifier( self.parent, self:GetAbility(), "modifier_generic_arc_lua",
        { 
            dir_x = self.direction.x,
            dir_y = self.direction.y,
            duration = self.duration,
            distance = self.distance,
            height = self.height,
            fix_end = false,
            isStun = true,
            isForward = true,
            activity = ACT_DOTA_FLAIL,
        })
        self:PlayEffects2( self.parent, arc_friendly, allied )
    end
    arc:SetEndCallback( function( interrupted )
        self.ability:DealDamage()
    end)
    self:PlayEffects2( self.parent, arc, allied )
end

function modifier_marci_companion_run_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_marci_companion_run_custom:GetOverrideAnimation()
	return ACT_DOTA_CAST_ABILITY_2_ALLY
end

function modifier_marci_companion_run_custom:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_marci_companion_run_custom:UpdateHorizontalMotion( me, dt )
    local targetpos = self.target:GetOrigin()
    if (targetpos - self.targetpos):Length2D()>self.distancethreshold then
        self.dodged = true
        self.interrupted = true
        return
    end
    self.targetpos = targetpos
    local loc = ProjectileManager:GetTrackingProjectileLocation( self.projectile )
    me:SetOrigin( GetGroundPosition( loc, me ) )
    me:FaceTowards( self.target:GetOrigin() )
end

function modifier_marci_companion_run_custom:OnHorizontalMotionInterrupted()
    self.interrupted = true
    self:Destroy()
end

function modifier_marci_companion_run_custom:PlayEffects1( caster, speed )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_charge_projectile.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( effect_cast, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( speed, 0, 0 ) )
    self:AddParticle( effect_cast, false, false, -1, false, false)
    caster:EmitSound("Hero_Marci.Rebound.Cast")
end

function modifier_marci_companion_run_custom:PlayEffects2( caster, buff )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( effect_cast, 1, caster, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
    ParticleManager:SetParticleControlEnt( effect_cast, 3, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    buff:AddParticle( effect_cast, false, false, -1, false, false )
    caster:EmitSound("Hero_Marci.Rebound.Leap")
end

function modifier_marci_companion_run_custom:PlayEffects3( center, radius )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_landing_zone.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, center )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
    ParticleManager:DestroyParticle(effect_cast, false)
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_marci_companion_run_custom:PlayEffects4( center, origin, radius )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, center )
    ParticleManager:SetParticleControl( effect_cast, 1, origin )
    ParticleManager:SetParticleControl( effect_cast, 9, Vector(radius, radius, radius) )
    ParticleManager:SetParticleControl( effect_cast, 10, center )
    ParticleManager:DestroyParticle(effect_cast, false)
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationWithCaster( center, "Hero_Marci.Rebound.Impact", self.parent )
end

modifier_marci_companion_run_custom_buff = class({})

function modifier_marci_companion_run_custom_buff:IsHidden() return false end
function modifier_marci_companion_run_custom_buff:IsPurgable() return true end
function modifier_marci_companion_run_custom_buff:OnCreated( kv )
    self.ally_movespeed_pct = self:GetAbility():GetSpecialValueFor( "ally_movespeed_pct" )
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Marci.Rebound.Ally")
end

function modifier_marci_companion_run_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_marci_companion_run_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.ally_movespeed_pct
end

function modifier_marci_companion_run_custom_buff:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end

function modifier_marci_companion_run_custom_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_marci_companion_run_custom_handler = class({})
function modifier_marci_companion_run_custom_handler:IsHidden() return true end
function modifier_marci_companion_run_custom_handler:IsPurgable() return false end
function modifier_marci_companion_run_custom_handler:IsPurgeException() return false end
function modifier_marci_companion_run_custom_handler:RemoveOnDeath() return false end
function modifier_marci_companion_run_custom_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_marci_companion_run_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    self:SetStackCount(self:GetCaster():GetEvasion() * 100)
end