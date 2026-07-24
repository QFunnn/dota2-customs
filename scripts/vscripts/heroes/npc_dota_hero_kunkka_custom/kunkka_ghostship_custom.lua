--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_ghostship_custom_damage_tick", "heroes/npc_dota_hero_kunkka_custom/kunkka_ghostship_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_ghostship_custom_magic_immune", "heroes/npc_dota_hero_kunkka_custom/kunkka_ghostship_custom", LUA_MODIFIER_MOTION_NONE)

kunkka_ghostship_custom = class({})

function kunkka_ghostship_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_ghostship_marker.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_marker.vpcf", context )
    PrecacheResource( "particle", "particles/kunkka_purge.vpcf", context )
    PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_avatar.vpcf", context )
end

kunkka_ghostship_custom.modifier_kunkka_14 = -2.1
kunkka_ghostship_custom.modifier_kunkka_14_damage = 100
kunkka_ghostship_custom.modifier_kunkka_14_time = 4
kunkka_ghostship_custom.modifier_kunkka_13 = {1.5,3,4.5}
kunkka_ghostship_custom.modifier_kunkka_17 = {2, 3}
kunkka_ghostship_custom.modifier_kunkka_20 = 80

function kunkka_ghostship_custom:GetIntrinsicModifierName()
	return "modifier_kunkka_ghostship_custom_damage_tick"
end

function kunkka_ghostship_custom:GetSpecialValueWithDefault(name, default)
    local value = self:GetSpecialValueFor(name)
    if value == 0 then
        return default
    end
    return value
end

function kunkka_ghostship_custom:RotateVector2D(vector, degrees)
    local radians = math.rad(degrees)
    local cos = math.cos(radians)
    local sin = math.sin(radians)

    return Vector(vector.x * cos - vector.y * sin, vector.x * sin + vector.y * cos, 0):Normalized()
end

function kunkka_ghostship_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorPosition()
	if target == self:GetCaster():GetAbsOrigin() then
		target = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
	end
	local damage = self:GetSpecialValueFor("damage")
	local speed = self:GetSpecialValueFor("ghostship_speed")
	local radius = self:GetSpecialValueFor("ghostship_width")
	local start_distance = 1000
	local crash_distance = 1000
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local buff_duration = self:GetSpecialValueFor("buff_duration")
	local caster_pos = caster:GetAbsOrigin()
	local closest_target = true
	local spawn_pos
	local boat_direction
	local crash_pos
	local travel_time
	boat_direction = ( target - caster_pos ):Normalized()
	crash_pos = target
	spawn_pos = target + boat_direction * (start_distance + crash_distance) * (-1)
	travel_time = ((start_distance + crash_distance ) / speed )
	if self:GetCaster():HasModifier("modifier_kunkka_14") then
		travel_time = travel_time + self.modifier_kunkka_14
		speed = 1750
	end
	local boat_velocity = boat_direction * speed
    local parti = "particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf"
	local mark = "particles/units/heroes/hero_kunkka/kunkka_ghostship_marker.vpcf"
    if self:GetCaster():HasModifier("modifier_kunkka_20") then
        parti = "particles/units/heroes/hero_kunkka/kunkka_ghost_ship_cannons.vpcf"
    end
	if self:GetCaster():HasModifier("modifier_kunkka_14") then
		parti = "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship.vpcf"
		mark = "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_marker.vpcf"
        if self:GetCaster():HasModifier("modifier_kunkka_20") then
            parti = "particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_cannons.vpcf"
        end
	end
    local max_count = 1
    if self:GetCaster():HasModifier("modifier_kunkka_17") then
        max_count = self.modifier_kunkka_17[self:GetCaster():GetTalentLevel("modifier_kunkka_17")]
    end
    Timers:CreateTimer(0, function()
        self:StartShip(parti, spawn_pos, start_distance, crash_distance, radius, travel_time, crash_pos, boat_velocity, stun_duration, caster, speed, target, mark, damage)
        max_count = max_count - 1
        if max_count > 0 then
            return 2.5
        end
    end)
end

function kunkka_ghostship_custom:OnProjectileThink_ExtraData(vLocation, data)
    local caster = self:GetCaster()
    if data.index and data.is_boat then
        local projectile = self[data.index]
        if not projectile then return end
        if not caster:HasModifier("modifier_kunkka_20") then return end

        local velocity = ProjectileManager:GetLinearProjectileVelocity( projectile.proj )
        local boatDirection = velocity:Normalized()
        local cannonDirection = Vector( -boatDirection.y, boatDirection.x, 0 ):Normalized()
        local projPosition = ProjectileManager:GetLinearProjectileLocation( projectile.proj )
        if projectile.delay and data.cannonade_interval < GameRules:GetGameTime() - projectile.delay then
            local cannonCount = self:GetSpecialValueWithDefault("cannon_count", 4)
            local cannonDistance = self:GetSpecialValueWithDefault("cannon_ball_distance", 1200)
            local cannonSpeed = self:GetSpecialValueWithDefault("cannon_ball_speed", 1400)
            local cannonRadius = self:GetSpecialValueWithDefault("cannon_ball_radius", 100)
            local numVolleys = self:GetSpecialValueWithDefault("num_cannon_volleys", 3)
            local baseRotation = self:GetSpecialValueWithDefault("base_cannon_rotation", 20)
            local rotationPerCannon = self:GetSpecialValueWithDefault("rotation_per_cannon", 12)
            local initialOffset = self:GetSpecialValueWithDefault("initial_cannon_offset", -150)
            local distanceBetweenCannons = self:GetSpecialValueWithDefault("distance_between_cannons", 75)
            local pfx = "particles/units/heroes/hero_kunkka/kunkka_cannonball.vpcf"
            if self:GetCaster():HasModifier("modifier_kunkka_14") then
                pfx = "particles/units/heroes/hero_kunkka/kunkka_cannonball_immortal.vpcf"
            end
            projectile.volley_count = (projectile.volley_count or 0) + 1
            if projectile.volley_count > numVolleys then
                projectile.delay = nil
                return
            end
            local index = DoUniqueString("kunkka_ghostship_custom")
            self[index] = {}
            for cannonRank = 1, cannonCount do
                for sideIndex = 1, 2 do
                    local cannonSide = sideIndex == 1 and -1 or 1
                    local angle = baseRotation + (cannonRank - 1) * rotationPerCannon
                    local direction = self:RotateVector2D(cannonDirection * cannonSide, angle * cannonSide)
                    local forwardOffset = initialOffset + (cannonRank - 1) * distanceBetweenCannons
                    local cannonBallPosition = projPosition + boatDirection * forwardOffset + cannonDirection * cannonSide * cannonRadius
                    local cannon_proj = 
                    {
                        Ability = self,
                        EffectName = pfx,
                        vSpawnOrigin = cannonBallPosition,
                        fDistance = cannonDistance,
                        fStartRadius = cannonRadius,
                        fEndRadius = cannonRadius,
                        fExpireTime = GameRules:GetGameTime() + 8,
                        bProvidesVision = true,
                        iVisionRadius = cannonRadius,
                        bDeleteOnHit = false,
                        Source = self:GetCaster(),
                        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
                        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                        vVelocity = (-direction) * cannonSpeed,
                        ExtraData = { is_cannon = true, index = index }
                    }
                    ProjectileManager:CreateLinearProjectile(cannon_proj)
                end
                EmitSoundOnLocationWithCaster( projPosition, "Ability.Ghostship.Cannon.Fire", caster)
            end
            projectile.delay = GameRules:GetGameTime()
        end
    end
end

function kunkka_ghostship_custom:StartShip(parti, spawn_pos, start_distance, crash_distance, radius, travel_time, crash_pos, boat_velocity, stun_duration, caster, speed, target, mark, damage)
    local index = DoUniqueString("kunkka_ghostship_custom")

    local boat_projectile = 
    {
		Ability = self,
		EffectName = parti,
		vSpawnOrigin = spawn_pos,
		fDistance = start_distance + crash_distance,
		fStartRadius = radius,
		fEndRadius = radius,
		fExpireTime = GameRules:GetGameTime() + travel_time + 2,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		bProvidesVision = true,
		iVisionRadius = radius,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		vVelocity = boat_velocity,
		ExtraData =
		{
			crash_x = crash_pos.x,
			crash_y = crash_pos.y,
			crash_z = crash_pos.z,
			speed = speed,
            radius = radius,
            index = index,
            is_boat = true,
            cannonade_interval = self:GetSpecialValueWithDefault("cannon_fire_interval", 0.78),
            last_cannonade = GameRules:GetGameTime(),
		}
	}

	self[index] = {proj = ProjectileManager:CreateLinearProjectile(boat_projectile), delay = GameRules:GetGameTime()}
	EmitSoundOnLocationWithCaster( spawn_pos, "Ability.Ghostship.bell", caster )
	EmitSoundOnLocationWithCaster( spawn_pos, "Ability.Ghostship", caster )
	EmitSoundOnLocationWithCaster( target, "Ability.Ghostship.bell", caster )
	EmitSoundOnLocationWithCaster( target, "Ability.Ghostship", caster )

	local crash_pfx = ParticleManager:CreateParticleForTeam(mark, PATTACH_ABSORIGIN, caster, caster:GetTeam())
	ParticleManager:SetParticleControl(crash_pfx, 0, crash_pos )

	Timers:CreateTimer(travel_time, function()
        if crash_pfx then
		    ParticleManager:DestroyParticle(crash_pfx, false)
		    ParticleManager:ReleaseParticleIndex(crash_pfx)
        end
		EmitSoundOnLocationWithCaster(crash_pos, "Ability.Ghostship.crash", caster)
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), crash_pos, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
		local damage_tick_talent = self:GetCaster().damage_tick_talent
		if self:GetCaster():HasModifier("modifier_kunkka_14") then
			damage = damage + (damage_tick_talent / 100 * self.modifier_kunkka_14_damage)
		end
		for k, enemy in pairs(enemies) do
			ApplyDamage({victim = enemy, attacker = caster, ability = self, damage = damage, damage_type = self:GetAbilityDamageType()})
			enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration * (1 - enemy:GetStatusResistance()) })
		end
	end)
end

function kunkka_ghostship_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
    if not ExtraData.is_boat and target then
        
    end
	if target then
		local caster = self:GetCaster()
		if caster:GetTeam() == target:GetTeam() and ExtraData.is_boat then
            local kunkka_admirals_rum_custom = self:GetCaster():FindAbilityByName("kunkka_admirals_rum_custom")
            if kunkka_admirals_rum_custom then
                kunkka_admirals_rum_custom:ApplyGhostShip(target)
            end
			if self:GetCaster():HasModifier("modifier_kunkka_13") then
				target:AddNewModifier(self:GetCaster(), self, "modifier_kunkka_ghostship_custom_magic_immune", { duration = self.modifier_kunkka_13[self:GetCaster():GetTalentLevel("modifier_kunkka_13")] })
			end
		end
        if ExtraData.is_cannon then
            if not self[ExtraData.index][target:entindex()] then
                local damage = self:GetSpecialValueFor("damage")
                local damage_tick_talent = self:GetCaster().damage_tick_talent
                if self:GetCaster():HasModifier("modifier_kunkka_14") then
                    damage = damage + (damage_tick_talent / 100 * self.modifier_kunkka_14_damage)
                end
                self[ExtraData.index][target:entindex()] = true
                ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = self.modifier_kunkka_20 / 100 * damage, damage_type = DAMAGE_TYPE_MAGICAL})
            end
        end
	end
	return false
end

modifier_kunkka_ghostship_custom_damage_tick = class({})

function modifier_kunkka_ghostship_custom_damage_tick:IsHidden() return true end
function modifier_kunkka_ghostship_custom_damage_tick:IsPurgable() return false end
function modifier_kunkka_ghostship_custom_damage_tick:IsPurgeException() return false end

function modifier_kunkka_ghostship_custom_damage_tick:DeclareFunctions()
	return { }
end

function modifier_kunkka_ghostship_custom_damage_tick:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.damage_time = self:GetAbility().modifier_kunkka_14_time
	if IsServer() then
		if not self.caster.damage_tick_talent then
			self.caster.damage_tick_talent = 0
		end
	end
end

function modifier_kunkka_ghostship_custom_damage_tick:OnTakeDamage( keys )
	if IsServer() then
		local unit = keys.unit
		local damage_taken = keys.damage
		if unit == self.caster then
			self.caster.damage_tick_talent = self.caster.damage_tick_talent + damage_taken
			Timers:CreateTimer(self.damage_time, function()
				if self.caster.damage_tick_talent then
					self.caster.damage_tick_talent = self.caster.damage_tick_talent - damage_taken
				end
			end)
		end
	end
end

modifier_kunkka_ghostship_custom_magic_immune = class({})

function modifier_kunkka_ghostship_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_kunkka_ghostship_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_kunkka_ghostship_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_kunkka_ghostship_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_kunkka_ghostship_custom_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
   }
end

function modifier_kunkka_ghostship_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_kunkka_ghostship_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_kunkka_ghostship_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end