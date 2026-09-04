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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.3
local CAST_DURATION = 6
local RETURN_TO_SPAWN_DELAY = 0.5
local RETURN_TO_SPAWN_DURATION = 0.5
local WAVE_COUNT = 6
local WAVE_START_DELAY = 1
local WAVE_INTERVAL = 2
local WAVE_RELEASE_DELAY = 0.6
local WAVE_HIT_DELAY = 1
local WAVE_LINE_WIDTH = 90
local WAVE_DAMAGE_RANGE = 1000
local WAVE_EFFECT_RANGE = 3300
local DAMAGE_RATE = 30
local SELF_SLOW_DURATION = 6.5
local SELF_SLOW_MOVESPEED_PCT = -50
local SELF_SLOW_ATTACK_SPEED = -50
local PREPARE_EFFECT =
	"particles/econ/items/mirana/mirana_2021_immortal/mirana_2021_immortal_moonlight_crimson_ray.vpcf"
local SPLITTER_EFFECT = "particles/elder_titan_earth_splitter_red.vpcf"
local CAST_SOUND = "Hero_Dark_Seer.Vacuum"
local PROJECTILE_SOUND = "Hero_ElderTitan.EarthSplitter.Projectile"
local IMPACT_SOUND = "Hero_ElderTitan.EarthSplitter.Destroy"
--- 前摇月光射线粒子保留时长（秒）
local PREPARE_RAY_PFX_LIFETIME = 8
--- 地裂直线特效保留时长（秒）
local SPLITTER_PFX_LIFETIME = 3.5
____exports.warlock_burning = __TS__Class()
local warlock_burning = ____exports.warlock_burning
warlock_burning.name = "warlock_burning"
__TS__ClassExtends(warlock_burning, MonsterAbility_CS)
function warlock_burning.prototype.Precache(self, context)
	PrecacheResource("particle", PREPARE_EFFECT, context)
	PrecacheResource("particle", SPLITTER_EFFECT, context)
end
function warlock_burning.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		isNotMove = false,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(2500)
			if target then
				caster:LockTargetForSpeed(target, CAST_POINT, 3)
			end
		end,
		OnInterrupt = function()
			return self:endCastSession()
		end,
		OnFinish = function()
			return self:endCastSession()
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function warlock_burning.prototype.onStart(self)
	local caster = self:GetCaster()
	local castToken = self:beginCastSession()
	caster:EmitSound(CAST_SOUND)
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	____exports.modifier_warlock_burning:applys(caster, caster, self, { duration = SELF_SLOW_DURATION })
	self:playPrepareEffect()
	self:Timer(RETURN_TO_SPAWN_DELAY, function()
		if not self:isCastingActive(castToken) then
			return
		end
		local spawnPoint = caster:GetSpawnPoint()
	end)
	do
		local waveIndex = 0
		while waveIndex < self:getSchedulableWaveCount() do
			local waveStartTime = WAVE_START_DELAY + waveIndex * WAVE_INTERVAL
			self:Timer(waveStartTime, function()
				if not self:isCastingActive(castToken) then
					return
				end
				caster:AddNewModifier(caster, self, "modifier_pause_actions", { duration = 1 })
				caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
				self:Timer(WAVE_RELEASE_DELAY, function()
					if not self:isCastingActive(castToken) then
						return
					end
					self:playPrepareEffect()
					self:releaseBurningWave()
				end)
			end)
			waveIndex = waveIndex + 1
		end
	end
end
function warlock_burning.prototype.beginCastSession(self)
	local token = DoUniqueString("warlock_burning_cast")
	self.activeCastToken = token
	return token
end
function warlock_burning.prototype.endCastSession(self)
	self.activeCastToken = nil
end
function warlock_burning.prototype.getSchedulableWaveCount(self)
	local waveCount = 0
	do
		local waveIndex = 0
		while waveIndex < WAVE_COUNT do
			local releaseTime = WAVE_START_DELAY + waveIndex * WAVE_INTERVAL + WAVE_RELEASE_DELAY
			if releaseTime > CAST_DURATION then
				break
			end
			waveCount = waveCount + 1
			waveIndex = waveIndex + 1
		end
	end
	return waveCount
end
function warlock_burning.prototype.isCastingActive(self, castToken)
	local caster = self:GetCaster()
	return IsValidAlive(nil, caster)
		and self.activeCastToken == castToken
		and caster:HasModifier("modifier_monster_cast_controller")
end
function warlock_burning.prototype.playPrepareEffect(self)
	local pfx = ParticleManager:CreateParticle(PREPARE_EFFECT, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	Timers:CreateTimer(PREPARE_RAY_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function warlock_burning.prototype.releaseBurningWave(self)
	local caster = self:GetCaster()
	local casterPosition = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(150))
	local directions = GetRotateVectors(nil, caster:GetForwardVector(), 12, 30)
	self:shuffleDirections(directions)
	caster:EmitSound(PROJECTILE_SOUND)
	for ____, direction in ipairs(directions) do
		local damageEnd = casterPosition:__add(direction:__mul(WAVE_DAMAGE_RANGE))
		local effectEnd = casterPosition:__add(direction:__mul(WAVE_EFFECT_RANGE))
		local pfx = ParticleManager:CreateParticle(SPLITTER_EFFECT, PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(pfx, 0, casterPosition)
		ParticleManager:SetParticleControl(pfx, 1, effectEnd)
		ParticleManager:SetParticleControl(pfx, 3, Vector(0, 1, 0))
		Timers:CreateTimer(SPLITTER_PFX_LIFETIME, function()
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end)
		self:Timer(WAVE_HIT_DELAY, function()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound(IMPACT_SOUND)
			local enemies = FindUnitsInLine(
				caster:GetTeamNumber(),
				casterPosition,
				damageEnd,
				nil,
				WAVE_LINE_WIDTH,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				bit.bor(bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_BUILDING),
				DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue30
					end
					enemy:KnockBack(caster, self, { duration = 0.3, distance = 0, height = 0, stun = true })
					caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
				end
				::__continue30::
			end
		end)
	end
end
function warlock_burning.prototype.shuffleDirections(self, directions)
	do
		local i = #directions - 1
		while i > 0 do
			local j = math.random(0, i)
			local current = directions[i + 1]
			directions[i + 1] = directions[j + 1]
			directions[j + 1] = current
			i = i - 1
		end
	end
end
warlock_burning = __TS__DecorateLegacy({ registerAbility(nil) }, warlock_burning)
____exports.warlock_burning = warlock_burning
____exports.modifier_warlock_burning = __TS__Class()
local modifier_warlock_burning = ____exports.modifier_warlock_burning
modifier_warlock_burning.name = "modifier_warlock_burning"
__TS__ClassExtends(modifier_warlock_burning, MonsterModifier_CS)
function modifier_warlock_burning.prototype.IsHidden(self)
	return true
end
function modifier_warlock_burning.prototype.IsPurgable(self)
	return false
end
function modifier_warlock_burning.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = SELF_SLOW_MOVESPEED_PCT }
end
modifier_warlock_burning =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_warlock_burning") }, modifier_warlock_burning)
____exports.modifier_warlock_burning = modifier_warlock_burning
return ____exports