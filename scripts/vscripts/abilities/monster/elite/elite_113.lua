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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local KNOCKBACK_DURATION = 0.18
local KNOCKBACK_DISTANCE = 140
local LIGHT_DAMAGE_RATE = 8
local CAST_RANGE = 1200
local CAST_POINT = 0.5
local CAST_DURATION = 5
local STRIKE_INTERVAL = 1
local WARNING_DURATION = 0.5
local STRIKE_POINT_COUNT = 5
local STRIKE_RADIUS = 100
local TARGET_OFFSET_RADIUS = 450
local RANDOM_MIN_DISTANCE = 150
local DAMAGE_RATE = 15
local LIGHTNING_SKY_Z = 2000
local LIGHTNING_PARTICLE = "particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath_start.vpcf"
local LIGHTNING_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts"
local LIGHTNING_CAST_SOUND = "Hero_Zuus.LightningBolt.Cast"
local LIGHTNING_IMPACT_SOUND = "Hero_Zuus.LightningBolt"
--- 精英怪宙斯技能：持续 5 秒周期生成随机圆形预警，并在预警后落雷造成范围伤害。
____exports.elite_113 = __TS__Class()
local elite_113 = ____exports.elite_113
elite_113.name = "elite_113"
__TS__ClassExtends(elite_113, MonsterAbility_CS)
function elite_113.prototype.Precache(self, context)
	PrecacheResource("particle", LIGHTNING_PARTICLE, context)
	PrecacheResource("soundfile", LIGHTNING_SOUND_EVENTS, context)
end
function elite_113.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:GetCaster()) then
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
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(LIGHTNING_CAST_SOUND, caster)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.2)
			local roundCount = math.floor(CAST_DURATION / STRIKE_INTERVAL)
			do
				local roundIndex = 0
				while roundIndex < roundCount do
					self:Timer(roundIndex * STRIKE_INTERVAL, function()
						return self:StartStrikeRound()
					end)
					roundIndex = roundIndex + 1
				end
			end
		end,
	}
end
function elite_113.prototype.StartStrikeRound(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.2)
	local points = self:CreateStrikePoints(caster)
	for ____, point in ipairs(points) do
		self:WarningRingEffect(point, STRIKE_RADIUS, WARNING_DURATION)
	end
	self:Timer(WARNING_DURATION, function()
		for ____, point in ipairs(points) do
			self:StrikeAt(point)
		end
	end)
end
function elite_113.prototype.CreateStrikePoints(self, caster)
	local enemies = self:FindEnemies(caster)
	local points = {}
	do
		local index = 0
		while index < STRIKE_POINT_COUNT do
			points[#points + 1] = self:CreateStrikePoint(caster, enemies)
			index = index + 1
		end
	end
	return points
end
function elite_113.prototype.CreateStrikePoint(self, caster, enemies)
	do
		local retry = 0
		while retry < 12 do
			local point = self:CreateStrikePointCandidate(caster, enemies)
			if IsGridNavDisplacementWalkable(nil, point) then
				return point
			end
			retry = retry + 1
		end
	end
	return GetGroundPosition(caster:GetAbsOrigin(), caster)
end
function elite_113.prototype.CreateStrikePointCandidate(self, caster, enemies)
	if #enemies > 0 then
		local enemy = enemies[RandomInt(0, #enemies - 1) + 1]
		if IsValidAlive(nil, enemy) then
			local candidate = enemy:GetAbsOrigin():__add(RandomVector(RandomFloat(0, TARGET_OFFSET_RADIUS)))
			return GetGroundPosition(candidate, enemy)
		end
	end
	local candidate = caster:GetAbsOrigin():__add(RandomVector(RandomFloat(RANDOM_MIN_DISTANCE, CAST_RANGE)))
	return GetGroundPosition(candidate, caster)
end
function elite_113.prototype.FindEnemies(self, caster)
	return __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, CAST_RANGE, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
end
function elite_113.prototype.StrikeAt(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local strikePoint = GetGroundPosition(point, caster)
	self:CreateLightningEffect(strikePoint)
	self:DamageAt(strikePoint)
end
function elite_113.prototype.CreateLightningEffect(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(LIGHTNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 1, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 2, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 3, point:__add(Vector(0, 0, 50)))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(point, LIGHTNING_IMPACT_SOUND, caster)
end
function elite_113.prototype.DamageAt(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		STRIKE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue35
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = math.min(DAMAGE_RATE, LIGHT_DAMAGE_RATE),
				ability = self,
			})
		end
		::__continue35::
	end
end
elite_113 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_113)
____exports.elite_113 = elite_113
return ____exports