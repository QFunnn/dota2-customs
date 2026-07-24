--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_jakiro_dual_breath_custom", "heroes/npc_dota_hero_jakiro_custom/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_jakiro_dual_breath_custom_ice", "heroes/npc_dota_hero_jakiro_custom/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_jakiro_dual_breath_custom_fire", "heroes/npc_dota_hero_jakiro_custom/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_jakiro_dual_breath_custom_ice_rooted", "heroes/npc_dota_hero_jakiro_custom/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

jakiro_dual_breath_custom = class({})

jakiro_dual_breath_custom.modifier_jakiro_3 = {-1,-2,-3}
jakiro_dual_breath_custom.modifier_jakiro_4 = 400
jakiro_dual_breath_custom.modifier_jakiro_18 = {1,2}
jakiro_dual_breath_custom.modifier_jakiro_20 = {50,100}

function jakiro_dual_breath_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_jakiro_20") then
        return "jakiro_20"
    end
    return "jakiro_dual_breath"
end

function jakiro_dual_breath_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_dual_breath_ice.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire_launch_2.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
    PrecacheResource("particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_jakiro.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_jakiro.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_jakiro.vpcf", context)
end

function jakiro_dual_breath_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_jakiro_18") then
        return 0
    end
    return self.BaseClass.GetCastPoint(self)
end

function jakiro_dual_breath_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_jakiro_4") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function jakiro_dual_breath_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_jakiro_3") then
        bonus = self.modifier_jakiro_3[self:GetCaster():GetTalentLevel("modifier_jakiro_3")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function jakiro_dual_breath_custom:GetCastRange(vLocation, hTarget)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_jakiro_20") then
        bonus = self.modifier_jakiro_20[self:GetCaster():GetTalentLevel("modifier_jakiro_20")]
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget) + bonus
end

function jakiro_dual_breath_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local target = self:GetCursorTarget()
    if target then
		point = target:GetOrigin()
	end
    local delay = self:GetSpecialValueFor( "fire_delay" )
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_jakiro_dual_breath_custom", { duration = delay, x = point.x, y = point.y } )
end

function jakiro_dual_breath_custom:OnProjectileHit_ExtraData( target, location, data )
    if not IsServer() then return end
	if not target then return end
	local modifier = "modifier_jakiro_dual_breath_custom_ice"
	if data.fire then 
        modifier = "modifier_jakiro_dual_breath_custom_fire"
    end

    if self:GetCaster():HasModifier("modifier_jakiro_4") and data.fire then
        target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.5, distance = self.modifier_jakiro_4, IsStun = false, direction_x = data.dir_x, direction_y = data.dir_y} )
    end

    if self:GetCaster():HasModifier("modifier_jakiro_18") and not data.fire then
        target:AddNewModifier(self:GetCaster(), self, "modifier_jakiro_dual_breath_custom_ice_rooted", {duration = self.modifier_jakiro_18[self:GetCaster():GetTalentLevel("modifier_jakiro_18")] * (1-target:GetStatusResistance())})
    end

    local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier( self:GetCaster(), self, modifier, { duration = duration * (1-target:GetStatusResistance()) })
end

modifier_jakiro_dual_breath_custom = class({})
function modifier_jakiro_dual_breath_custom:IsHidden() return true end
function modifier_jakiro_dual_breath_custom:IsPurgable() return false end
function modifier_jakiro_dual_breath_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE  end
function modifier_jakiro_dual_breath_custom:RemoveOnDeath() return false end
function modifier_jakiro_dual_breath_custom:OnCreated( kv )
	local distance = self:GetAbility():GetCastRange(self:GetParent():GetAbsOrigin(), self:GetParent()) + self:GetCaster():GetCastRangeBonus()
    self.distance = distance
	local start_radius = self:GetAbility():GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetAbility():GetSpecialValueFor( "end_radius" )
	self.speed_ice = self:GetAbility():GetSpecialValueFor( "speed" )
	self.speed_fire = self:GetAbility():GetSpecialValueFor( "speed_fire" )
	if not IsServer() then return end
	local caster = self:GetCaster()
	self.direction = Vector( kv.x, kv.y, 0 ) - self:GetCaster():GetOrigin()
	self.direction.z = 0
	self.direction = self.direction:Normalized()
	self.info = 
    {
		Source = self:GetCaster(),
		Ability = self:GetAbility(),
		vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    fDistance = distance,
	    fStartRadius = start_radius,
	    fEndRadius = end_radius,
	}
	self.info.vVelocity = self.direction * self.speed_ice
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_dual_breath_ice.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self.info.vVelocity)
    ParticleManager:SetParticleControl(particle, 2, Vector(0, start_radius, 0))
    ParticleManager:SetParticleControl(particle, 9, self:GetParent():GetAbsOrigin())
    Timers:CreateTimer(distance / self.speed_ice, function()
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
    end)
	ProjectileManager:CreateLinearProjectile( self.info )
	self:GetCaster():EmitSound("Hero_Jakiro.DualBreath.Cast")
end

function modifier_jakiro_dual_breath_custom:OnRemoved()
	if not IsServer() then return end
	self.info.vVelocity = self.direction * self.speed_fire
	self.info.ExtraData = 
    {
		fire = 1,
        dir_x = self.direction.x,
        dir_y = self.direction.y
	}
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self.info.vVelocity)
    ParticleManager:SetParticleControl(particle, 2, Vector(0, start_radius, 0))
    ParticleManager:SetParticleControl(particle, 9, self:GetParent():GetAbsOrigin())
    Timers:CreateTimer(self.distance / self.speed_fire, function()
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
    end)
	ProjectileManager:CreateLinearProjectile( self.info )
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire_launch_2.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( particle, 1, self.info.vVelocity )
	ParticleManager:SetParticleControlEnt( particle, 9, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( particle )
end

modifier_jakiro_dual_breath_custom_fire = class({})

function modifier_jakiro_dual_breath_custom_fire:OnCreated( kv )
	if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
    if self:GetCaster():HasModifier("modifier_jakiro_20") then
        damage = damage + self:GetAbility().modifier_jakiro_20[self:GetCaster():GetTalentLevel("modifier_jakiro_20")]
    end
	self.damageTable = 
    {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage * 0.5,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	self:StartIntervalThink( 0.5 )
	self:OnIntervalThink()
end

function modifier_jakiro_dual_breath_custom_fire:OnRefresh( kv )
	if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
    if self:GetCaster():HasModifier("modifier_jakiro_20") then
        damage = damage + self:GetAbility().modifier_jakiro_20[self:GetCaster():GetTalentLevel("modifier_jakiro_20")]
    end
	self.damageTable.damage = damage
end

function modifier_jakiro_dual_breath_custom_fire:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

function modifier_jakiro_dual_breath_custom_fire:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_jakiro_dual_breath_custom_fire:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_jakiro_dual_breath_custom_ice = class({})

function modifier_jakiro_dual_breath_custom_ice:OnCreated( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed_pct" )
end

function modifier_jakiro_dual_breath_custom_ice:OnRefresh( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed_pct" )	
end

function modifier_jakiro_dual_breath_custom_ice:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_jakiro_dual_breath_custom_ice:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_jakiro_dual_breath_custom_ice:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_jakiro_dual_breath_custom_ice:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_jakiro_dual_breath_custom_ice:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_jakiro_dual_breath_custom_ice_rooted = class({})

function modifier_jakiro_dual_breath_custom_ice_rooted:GetTexture() return "jakiro_18" end

function modifier_jakiro_dual_breath_custom_ice_rooted:GetEffectName()
    return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_jakiro_dual_breath_custom_ice_rooted:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_jakiro_dual_breath_custom_ice_rooted:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true,
    }
end