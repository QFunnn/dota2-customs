--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


local levelup_blink_common = require("abilities/levelup_blink_common")

levelup_earth_spirit_rolling_boulder = class({})

function levelup_earth_spirit_rolling_boulder:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_earth_spirit_rolling_boulder:GetManaCost(level)
	return levelup_blink_common.GetManaCost(self, level)
end

function levelup_earth_spirit_rolling_boulder:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local direction = point - origin
	direction.z = 0

	local distance = direction:Length2D()
	if distance <= 0.01 then
		return
	end

	local max_distance = self:GetSpecialValueFor("distance")
	local speed = self:GetSpecialValueFor("speed")
	local radius = self:GetSpecialValueFor("radius")
	local str_damage_pct = self:GetSpecialValueFor("str_damage_pct")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	direction = direction:Normalized()
	distance = math.min(distance, max_distance)

	local target = GetGroundPosition(origin + direction * distance, caster)
	caster:Stop()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START)
	Timers:CreateTimer(distance / speed, function()
		if caster then
			caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START)
			caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_END)
		end
	end)
	caster:SetForwardVector(direction)
	caster:FaceTowards(target)

	local strength = tonumber(caster:LevelUpGetCustomStrength()) or 0
	local damage = math.floor(strength * str_damage_pct * 0.01 + 0.5)

	ProjectileManager:CreateLinearProjectile({
		Source = caster,
		Ability = self,
		vSpawnOrigin = origin,
		EffectName = "",
		fDistance = distance,
		fStartRadius = radius,
		fEndRadius = radius,
		vVelocity = direction * speed,
		bDeleteOnHit = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		ExtraData = {
			damage = damage,
			stun_duration = stun_duration,
		},
	})

	caster:AddNewModifier(caster, self, "modifier_levelup_movement", {
		target_x = target.x,
		target_y = target.y,
		distance = distance,
		speed = speed,
		particle = "particles/econ/items/earth_spirit/earth_spirit_ti6_boulder/espirit_ti6_rollingboulder.vpcf",
		loop_sound = "Hero_EarthSpirit.RollingBoulder.Loop",
		end_sound = "Hero_EarthSpirit.RollingBoulder.Destroy",
		end_particle_cp = 3,
	})

	EmitSoundOn("Hero_EarthSpirit.RollingBoulder.Cast", caster)

	levelup_blink_common.OnSuccessfulBlink(caster, self)
end

function levelup_earth_spirit_rolling_boulder:OnProjectileHit_ExtraData(target, location, extra_data)
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

	local stun_duration = tonumber(extra_data.stun_duration) or 0
	if stun_duration > 0 then
		target:AddNewModifier(caster, self, "modifier_generic_stunned_lua", { duration = stun_duration })
	end

	local damage = tonumber(extra_data.damage) or 0
	if damage > 0 then
		local prepared_damage = health_system:BuildPreparedDamage({
			attacker = caster,
			ability = self,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_kind = "magical_spell",
		})
		health_system:ApplyPreparedDamage(prepared_damage, target, "levelup_earth_spirit_rolling_boulder")
	end

	return false
end