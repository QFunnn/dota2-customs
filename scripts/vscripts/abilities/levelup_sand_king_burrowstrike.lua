--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


local levelup_blink_common = require("abilities/levelup_blink_common")

levelup_sand_king_burrowstrike = class({})

function levelup_sand_king_burrowstrike:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_sand_king_burrowstrike:GetManaCost(level)
	return levelup_blink_common.GetManaCost(self, level)
end

function levelup_sand_king_burrowstrike:OnSpellStart()
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_SAND_KING_BURROW_IN)
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local direction = point - origin
	direction.z = 0

	local distance = direction:Length2D()
	if distance <= 0.01 then
		return
	end

	local max_distance = self:GetSpecialValueFor("max_travel_distance")
	local movement_speed = self:GetSpecialValueFor("movement_speed")
	local radius = self:GetSpecialValueFor("radius")
	local int_damage_pct = self:GetSpecialValueFor("int_damage_pct")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local knockback_duration = self:GetSpecialValueFor("knockback_duration")
	local knockback_height = self:GetSpecialValueFor("knockback_height")
	local cast_backswing = self:GetSpecialValueFor("cast_backswing")

	direction = direction:Normalized()
	distance = math.min(distance, max_distance)

	local target = GetGroundPosition(origin + direction * distance, caster)
	caster:SetForwardVector(direction)
	caster:FaceTowards(target)
	caster:Stop()

	local intellect = tonumber(caster:LevelUpGetCustomIntellect()) or 0
	local damage = math.floor(intellect * int_damage_pct * 0.01 + 0.5)
	local burrow_duration = movement_speed > 0 and distance / movement_speed or 0
	local max_burrow_duration = movement_speed > 0 and max_distance / movement_speed or 0
	local teleport_duration = math.max(0, cast_backswing - max_burrow_duration)
	local total_duration = math.max(burrow_duration + teleport_duration, burrow_duration)

	ProjectileManager:CreateLinearProjectile({
		Source = caster,
		Ability = self,
		vSpawnOrigin = origin,
		fDistance = distance,
		fStartRadius = radius,
		fEndRadius = radius,
		vVelocity = direction * movement_speed,
		bDeleteOnHit = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		ExtraData = {
			damage = damage,
			stun_duration = stun_duration,
			knockback_duration = knockback_duration,
			knockback_height = knockback_height,
		},
	})

	local particle = LevelUpParticleManager:CreateParticle(
		"particles/econ/items/sand_king/sandking_barren_crown/sandking_rubyspire_burrowstrike.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	LevelUpParticleManager:SetParticleControl(particle, 0, origin)
	LevelUpParticleManager:SetParticleControl(particle, 1, target)
	LevelUpParticleManager:ReleaseParticleIndex(particle)

	EmitSoundOn("Ability.SandKing_BurrowStrike", caster)

	caster:AddNewModifier(
		caster,
		self,
		"modifier_generic_stunned_lua",
		{ duration = total_duration - 0.25, particle = "none" }
	)

	Timers:CreateTimer(total_duration / 2, function()
		if not IsValid(caster) or not caster:IsAlive() then
			return
		end
		GridNav:DestroyTreesAroundPoint(target, 125, true)
		FindClearSpaceForUnit(caster, target, true)
		caster:FadeGesture(ACT_DOTA_SAND_KING_BURROW_IN)
		caster:StartGesture(ACT_DOTA_SAND_KING_BURROW_OUT)

		levelup_blink_common.OnSuccessfulBlink(caster, self)
	end)
end

function levelup_sand_king_burrowstrike:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return false
	end
	if not IsValid(target) or not target:IsAlive() then
		return false
	end

	local caster = self:GetCaster()
	if not IsValid(caster) then
		return false
	end

	local damage = tonumber(extra_data.damage) or 0
	local stun_duration = tonumber(extra_data.stun_duration) or 0
	local knockback_duration = tonumber(extra_data.knockback_duration) or 0
	local knockback_height = tonumber(extra_data.knockback_height) or 0

	if stun_duration > 0 then
		target:AddNewModifier(caster, self, "modifier_generic_stunned_lua", { duration = stun_duration })
	end

	if knockback_duration > 0 then
		target:AddNewModifier(caster, self, "modifier_generic_knockback_lua", {
			duration = knockback_duration,
			distance = 0,
			height = knockback_height,
			IsStun = 1,
		})
	end

	if damage > 0 then
		local prepared_damage = health_system:BuildPreparedDamage({
			attacker = caster,
			ability = self,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_kind = "magical_spell",
		})
		health_system:ApplyPreparedDamage(prepared_damage, target, "levelup_sand_king_burrowstrike")
	end

	return false
end