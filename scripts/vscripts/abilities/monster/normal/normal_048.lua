--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_normal_048_hidden_shot_state
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 2000
local CAST_POINT = 0.8
local ROUND_COUNT = 3
local ROUND_INTERVAL = 1.5
local WARNING_DURATION = 0.8
local CAST_DURATION = (ROUND_COUNT - 1) * ROUND_INTERVAL + WARNING_DURATION + 0.4
local STEALTH_DURATION = (ROUND_COUNT - 1) * ROUND_INTERVAL + WARNING_DURATION + 0.2
local RANDOM_CENTER_RADIUS = 500
local WARNING_RADIUS = 300
local MIN_POINT_DISTANCE = 280
local MIN_POINT_COUNT = 3
local MAX_POINT_COUNT = 4
local ARROWS_PER_WARNING = 10
local DAMAGE_RATE = 14
local STUN_DURATION = 0.5
local SKY_HEIGHT = 1000
local FALL_ARROW_HORIZONTAL_OFFSET = 650
local FALL_ARROW_FLIGHT_DURATION = WARNING_DURATION / 3
local FALL_ARROW_LAUNCH_DELAY = WARNING_DURATION - FALL_ARROW_FLIGHT_DURATION
local FALL_ARROW_SPEED = FALL_ARROW_HORIZONTAL_OFFSET / FALL_ARROW_FLIGHT_DURATION
local ARROW_EFFECT = "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_base_attack.vpcf"
local STEALTH_START_EFFECT = "particles/generic_hero_status/status_invisibility_start.vpcf"
local STEALTH_END_EFFECT = "particles/generic_hero_status/respawn.vpcf"
local STEALTH_START_SOUND = "Hero_Riki.Invisibility"
local STEALTH_END_SOUND = "Hero_Invoker.GhostWalk"
local RAIN_ROUND_SOUND = "Hero_Windrunner.ShackleshotCast"
local RAIN_LAND_SOUND = "Hero_DrowRanger.ProjectileImpact"
local IMPACT_SOUND = "Hero_Windrunner.ProjectileImpact"
____exports.normal_048 = __TS__Class()
local normal_048 = ____exports.normal_048
normal_048.name = "normal_048"
__TS__ClassExtends(normal_048, MonsterAbility_CS)
function normal_048.prototype.Precache(self, context)
	PrecacheResource("particle", ARROW_EFFECT, context)
	PrecacheResource("particle", STEALTH_START_EFFECT, context)
	PrecacheResource("particle", STEALTH_END_EFFECT, context)
end
function normal_048.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = "",
		cooldown = 8,
		animationPlaybackRate = 1,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:SetAnimation("wr_arc_spawn_loadout_breeze")
		end,
		OnStart = function()
			return self:StartArrowRain()
		end,
		OnFinish = function()
			return self:RevealCaster()
		end,
		OnInterrupt = function()
			return self:RevealCaster()
		end,
	}
end
function normal_048.prototype.PlaySelfEffect(self, effectName)
	local parent = self:GetCaster()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(effectName, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_048.prototype.StartArrowRain(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlaySelfEffect(STEALTH_START_EFFECT)
	EmitSoundOn(STEALTH_START_SOUND, caster)
	self:Timer(0.1, function()
		modifier_normal_048_hidden_shot_state:applys(caster, caster, self, { duration = STEALTH_DURATION })
	end)
	do
		local round = 0
		while round < ROUND_COUNT do
			local currentRound = round
			local currentDelay = currentRound * ROUND_INTERVAL
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:StartRainRound(caster)
			end)
			round = round + 1
		end
	end
	self:Timer(ROUND_COUNT * ROUND_INTERVAL - 0.3, function()
		caster:SetAnimation("wr_arc_forcestaff_end_injured")
	end)
end
function normal_048.prototype.RevealCaster(self)
	local caster = self:GetCaster()
	if not IsValid(nil, caster) then
		return
	end
	modifier_normal_048_hidden_shot_state:remove(caster)
end
function normal_048.prototype.StartRainRound(self, caster)
	local points = self:CreateWarningPoints(caster)
	local soundPoint = points[1]
	if soundPoint then
		EmitSoundOnLocationWithCaster(soundPoint, RAIN_ROUND_SOUND, caster)
	end
	do
		local index = 0
		while index < #points do
			do
				local currentPoint = points[index + 1]
				if not currentPoint then
					goto __continue24
				end
				self:WarningRingEffect(currentPoint, WARNING_RADIUS, WARNING_DURATION + 0.2)
				self:FireArrowRain(caster, currentPoint)
			end
			::__continue24::
			index = index + 1
		end
	end
end
function normal_048.prototype.CreateWarningPoints(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return {}
	end
	local center = target:GetAbsOrigin()
	local pointCount = RandomInt(MIN_POINT_COUNT, MAX_POINT_COUNT)
	local points = GetRandomPointsInCircle(nil, center, RANDOM_CENTER_RADIUS, pointCount, MIN_POINT_DISTANCE)
	local result = {}
	do
		local index = 0
		while index < #points do
			do
				local currentPoint = points[index + 1]
				if not currentPoint then
					goto __continue28
				end
				result[#result + 1] = GetGroundPosition(currentPoint, caster)
			end
			::__continue28::
			index = index + 1
		end
	end
	return result
end
function normal_048.prototype.FireArrowRain(self, caster, center)
	self:Timer(FALL_ARROW_LAUNCH_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local damagePoint = GetGroundPosition(center, caster)
		self:FireFallingArrow(caster, damagePoint, true)
		do
			local index = 1
			while index < ARROWS_PER_WARNING do
				local currentOffset = RandomVector(RandomFloat(0, WARNING_RADIUS))
				local currentPoint = GetGroundPosition(center:__add(currentOffset), caster)
				self:FireFallingArrow(caster, currentPoint, false)
				index = index + 1
			end
		end
	end)
end
function normal_048.prototype.FireFallingArrow(self, caster, point, shouldDealDamage)
	local direction = RandomVector(FALL_ARROW_HORIZONTAL_OFFSET):Normalized()
	local startPoint = point:__add(direction:__mul(FALL_ARROW_HORIZONTAL_OFFSET)):__add(Vector(0, 0, SKY_HEIGHT))
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = ARROW_EFFECT,
		projectile_type = "collideground",
		projectile_speed = FALL_ARROW_SPEED,
		start_point = startPoint,
		target = point,
		on_hit = function(____, _hitTarget, location)
			if not IsValidAlive(nil, caster) then
				return true
			end
			if not shouldDealDamage then
				return true
			end
			local landPos = GetGroundPosition(location, caster)
			EmitSoundOnLocationWithCaster(landPos, RAIN_LAND_SOUND, caster)
			EmitSoundOnLocationWithCaster(landPos, IMPACT_SOUND, caster)
			ScreenShake(landPos, 8, 8, 0.12, 1800, 0, true)
			self:DamageEnemies(caster, landPos)
			return true
		end,
	})
end
function normal_048.prototype.DamageEnemies(self, caster, point)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		WARNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue40
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue40::
	end
end
normal_048 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_048)
____exports.normal_048 = normal_048
modifier_normal_048_hidden_shot_state = __TS__Class()
modifier_normal_048_hidden_shot_state.name = "modifier_normal_048_hidden_shot_state"
__TS__ClassExtends(modifier_normal_048_hidden_shot_state, MonsterModifier_CS)
function modifier_normal_048_hidden_shot_state.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
end
function modifier_normal_048_hidden_shot_state.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:PlaySelfEffect(STEALTH_END_EFFECT)
	EmitSoundOn(STEALTH_END_SOUND, parent)
end
function modifier_normal_048_hidden_shot_state.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_normal_048_hidden_shot_state.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVISIBLE] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_normal_048_hidden_shot_state.prototype.GetModifierInvisibilityLevel(self)
	return 1
end
function modifier_normal_048_hidden_shot_state.prototype.IsHidden(self)
	return true
end
function modifier_normal_048_hidden_shot_state.prototype.IsPurgable(self)
	return false
end
function modifier_normal_048_hidden_shot_state.prototype.PlaySelfEffect(self, effectName)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(effectName, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:ReleaseParticleIndex(pfx)
end
modifier_normal_048_hidden_shot_state =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_048_hidden_shot_state)
return ____exports