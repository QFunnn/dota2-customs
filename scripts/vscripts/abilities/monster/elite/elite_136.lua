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
local modifier_elite_136_bramble_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1
local CAST_DURATION = 1
local LOCK_RANGE = 1000
local LINE_LENGTH = 1000
local LINE_WIDTH = 100
local LINE_START_OFFSET = 80
local WARNING_START_WIDTH = 150
local WARNING_END_WIDTH = 700
local POINT_INTERVAL = 100
local AREA_DURATION = 4
local SEARCH_INTERVAL = 0.25
local DAMAGE_RATE = 1
local SLOW_PCT = -90
local SLOW_REFRESH_DURATION = SEARCH_INTERVAL + 0.1
local ROOT_LOOP_SOUND_INTERVAL = 1
local BRAMBLE_PARTICLE = "particles/units/heroes/hero_treant/treant_bramble_root.vpcf"
local BRAMBLE_CAST_SOUND = "Hero_Treant.LeechSeed.Target"
local BRAMBLE_POINT_SOUND = "Tree.GrowBack"
local ROOT_LOOP_SOUND = "Hero_Treant.Overgrowth.Target"
local BRAMBLE_ANGLES = { -26, 0, 26 }
--- 精英技能136 - 绞架之怨：向前方扇形生成多条根须区域，区域内持续伤害并减速
____exports.elite_136 = __TS__Class()
local elite_136 = ____exports.elite_136
elite_136.name = "elite_136"
__TS__ClassExtends(elite_136, MonsterAbility_CS)
function elite_136.prototype.Precache(self, context)
	PrecacheResource("particle", BRAMBLE_PARTICLE, context)
end
function elite_136.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = LOCK_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 0.7,
		castColor = Vector(80, 180, 80),
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LOCK_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			local forward = self:GetFlatForward(caster)
			self:PlayBrambleWarning(caster, origin, forward)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local forward = self:GetFlatForward(caster)
			local lines = self:BuildBrambleLines(origin, forward)
			EmitSoundOnLocationWithCaster(origin, BRAMBLE_CAST_SOUND, caster)
			self:SpawnBrambleParticles(caster, lines)
			self:StartBrambleAreaThinker(caster, lines)
		end,
	}
end
function elite_136.prototype.BuildBrambleLines(self, origin, forward)
	local lines = {}
	do
		local index = 0
		while index < #BRAMBLE_ANGLES do
			local currentAngle = BRAMBLE_ANGLES[index + 1]
			local direction = self:RotateDirection(forward, currentAngle)
			local start = origin:__add(direction:__mul(LINE_START_OFFSET))
			local ____end = start:__add(direction:__mul(LINE_LENGTH))
			lines[#lines + 1] = { start = start, ["end"] = ____end, direction = direction }
			index = index + 1
		end
	end
	return lines
end
function elite_136.prototype.PlayBrambleWarning(self, caster, origin, forward)
	local start = origin:__add(forward:__mul(LINE_START_OFFSET))
	local ____end = start:__add(forward:__mul(LINE_LENGTH))
	self:WarningEffect(start, ____end, CAST_POINT, {
		startWidth = WARNING_START_WIDTH,
		endWidth = WARNING_END_WIDTH,
		getDirection = function()
			return self:GetFlatForward(caster)
		end,
	})
end
function elite_136.prototype.SpawnBrambleParticles(self, caster, lines)
	local pointCount = math.floor(LINE_LENGTH / POINT_INTERVAL)
	for ____, line in ipairs(lines) do
		local currentLine = line
		do
			local pointIndex = 0
			while pointIndex <= pointCount do
				local currentDistance = pointIndex * POINT_INTERVAL
				local currentPoint = currentLine.start:__add(currentLine.direction:__mul(currentDistance))
				local particlePoint = GetGroundPosition(currentPoint, caster)
				local particle = ParticleManager:CreateParticle(BRAMBLE_PARTICLE, PATTACH_WORLDORIGIN, nil)
				ParticleManager:SetParticleShouldCheckFoW(particle, false)
				ParticleManager:SetParticleControl(particle, 0, particlePoint)
				EmitSoundOnLocationWithCaster(particlePoint, BRAMBLE_POINT_SOUND, caster)
				self:DestroyParticleLater(particle, AREA_DURATION)
				pointIndex = pointIndex + 1
			end
		end
	end
end
function elite_136.prototype.StartBrambleAreaThinker(self, caster, lines)
	local activeUntil = GameRules:GetGameTime() + AREA_DURATION
	local rootSoundTimestamps = {}
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		if GameRules:GetGameTime() >= activeUntil then
			return
		end
		local hitTargets = {}
		for ____, line in ipairs(lines) do
			local currentLine = line
			local enemies = FindUnitsInLine(
				caster:GetTeamNumber(),
				currentLine.start,
				currentLine["end"],
				nil,
				LINE_WIDTH,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue22
					end
					if self:HasHitTarget(hitTargets, enemy) then
						goto __continue22
					end
					hitTargets[#hitTargets + 1] = enemy
					caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
					modifier_elite_136_bramble_slow:applys(enemy, caster, self, { duration = SLOW_REFRESH_DURATION })
					self:PlayRootLoopSound(enemy, caster, rootSoundTimestamps)
				end
				::__continue22::
			end
		end
		return SEARCH_INTERVAL
	end)
end
function elite_136.prototype.DestroyParticleLater(self, particle, delay)
	local currentParticle = particle
	Timers:CreateTimer(delay, function()
		ParticleManager:DestroyParticle(currentParticle, false)
		ParticleManager:ReleaseParticleIndex(currentParticle)
	end)
end
function elite_136.prototype.HasHitTarget(self, targets, enemy)
	for ____, target in ipairs(targets) do
		if target == enemy then
			return true
		end
	end
	return false
end
function elite_136.prototype.PlayRootLoopSound(self, enemy, caster, timestamps)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local key = enemy:entindex()
	local now = GameRules:GetGameTime()
	local lastPlayTime = timestamps[key] or -ROOT_LOOP_SOUND_INTERVAL
	if now - lastPlayTime < ROOT_LOOP_SOUND_INTERVAL then
		return
	end
	timestamps[key] = now
	EmitSoundOnLocationWithCaster(enemy:GetAbsOrigin(), ROOT_LOOP_SOUND, caster)
end
function elite_136.prototype.GetFlatForward(self, caster)
	local rawForward = caster:GetForwardVector()
	local flatForward = Vector(rawForward.x, rawForward.y, 0)
	if flatForward:Length2D() <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flatForward:Normalized()
end
function elite_136.prototype.RotateDirection(self, forward, angle)
	local radians = angle * math.pi / 180
	local cosValue = math.cos(radians)
	local sinValue = math.sin(radians)
	return Vector(forward.x * cosValue - forward.y * sinValue, forward.x * sinValue + forward.y * cosValue, 0):Normalized()
end
elite_136 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_136)
____exports.elite_136 = elite_136
modifier_elite_136_bramble_slow = __TS__Class()
modifier_elite_136_bramble_slow.name = "modifier_elite_136_bramble_slow"
__TS__ClassExtends(modifier_elite_136_bramble_slow, MonsterModifier_CS)
function modifier_elite_136_bramble_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = SLOW_PCT }
end
function modifier_elite_136_bramble_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_136_bramble_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_136_bramble_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_136_bramble_slow.GetLocalizationCN(self)
	return { name = "怨根阻滞", description = "被根须严重拖慢，移动速度降低90%。" }
end
modifier_elite_136_bramble_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_136_bramble_slow") }, modifier_elite_136_bramble_slow)
return ____exports