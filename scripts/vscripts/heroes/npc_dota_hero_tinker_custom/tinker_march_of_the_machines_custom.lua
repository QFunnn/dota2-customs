--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tinker_march_of_the_machines_custom_thinker", "heroes/npc_dota_hero_tinker_custom/tinker_march_of_the_machines_custom", LUA_MODIFIER_MOTION_NONE )

tinker_march_of_the_machines_custom = class({})

tinker_march_of_the_machines_custom.modifier_tinker_2_cooldown = {-9,-14,-19}
tinker_march_of_the_machines_custom.modifier_tinker_2_duration = {1,2,3}
tinker_march_of_the_machines_custom.modifier_tinker_3 = {10,20,30}
tinker_march_of_the_machines_custom.modifier_tinker_4 = 5

function tinker_march_of_the_machines_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_tinker_2") then
        bonus = self.modifier_tinker_2_cooldown[self:GetCaster():GetTalentLevel("modifier_tinker_2")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function tinker_march_of_the_machines_custom:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    if point == caster:GetAbsOrigin() then
        point = caster:GetOrigin() + caster:GetForwardVector() * 25
    end
	CreateModifierThinker(caster, self, "modifier_tinker_march_of_the_machines_custom_thinker", {}, point, caster:GetTeamNumber(), false )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_motm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationForAllies( self:GetCaster():GetOrigin(), "Hero_Tinker.March_of_the_Machines.Cast", self:GetCaster() )
end

function tinker_march_of_the_machines_custom:OnProjectileHit_ExtraData( target, location, extraData )
	if not target then return true end
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), location, nil, extraData.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = extraData.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
	end
	return true
end

modifier_tinker_march_of_the_machines_custom_thinker = class({})

function modifier_tinker_march_of_the_machines_custom_thinker:OnCreated( kv )
	if not IsServer() then return end
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
    if self:GetCaster():HasModifier("modifier_tinker_2") then
        duration = duration + self:GetAbility().modifier_tinker_2_duration[self:GetCaster():GetTalentLevel("modifier_tinker_2")]
    end
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	local speed = self:GetAbility():GetSpecialValueFor( "speed" )
	local distance = self:GetAbility():GetSpecialValueFor( "distance" )
	local machines_per_sec = self:GetAbility():GetSpecialValueFor( "machines_per_sec" )
	local collision_radius = self:GetAbility():GetSpecialValueFor( "collision_radius" )
	local splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" )
	local splash_damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_tinker_3") then
        splash_damage = splash_damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_tinker_3[self:GetCaster():GetTalentLevel("modifier_tinker_3")])
    end
    local proj_name = "particles/units/heroes/hero_tinker/tinker_machine_custom.vpcf"
	local interval = 1 / machines_per_sec
    if self:GetCaster():HasModifier("modifier_tinker_4") then
        speed = speed * 1.15
        splash_damage = splash_damage * 5
        collision_radius = collision_radius * 2.2
        splash_radius = splash_radius * 2.2
        proj_name = "particles/units/heroes/hero_tinker/tinker_machine_custom_double.vpcf"
        interval = 0.4
    end
	local center = self:GetParent():GetOrigin()
	local direction = (center-self:GetCaster():GetOrigin())
	direction = Vector( direction.x, direction.y, 0 ):Normalized()
	self:GetParent():SetForwardVector( direction )
	self.spawn_vector = self:GetParent():GetRightVector()
	self.center_start = center - direction*self.radius
    self.projectile_info = 
    {
        Source = self:GetCaster(),
        Ability = self:GetAbility(),
        bDeleteOnHit = true,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = proj_name,
        fDistance = distance,
        fStartRadius = collision_radius,
        fEndRadius = collision_radius,
        vVelocity = direction * speed,
        ExtraData = 
        {
            radius = splash_radius,
            damage = splash_damage,
        }
    }
	self:SetDuration( duration, false )
	self:StartIntervalThink( interval )
	self:OnIntervalThink()
	self:GetParent():EmitSound("Hero_Tinker.March_of_the_Machines")
end

function modifier_tinker_march_of_the_machines_custom_thinker:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_tinker_march_of_the_machines_custom_thinker:OnDestroy( kv )
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Tinker.March_of_the_Machines")
	UTIL_Remove( self:GetParent() )
end

function modifier_tinker_march_of_the_machines_custom_thinker:OnIntervalThink()
    local radius_length = self.radius
    if self:GetCaster():HasModifier("modifier_tinker_4") then
        radius_length = radius_length * 0.7
    end
	local spawn = self.center_start + self.spawn_vector*RandomInt( -radius_length, radius_length )
	self.projectile_info.vSpawnOrigin = spawn
	ProjectileManager:CreateLinearProjectile(self.projectile_info)
end