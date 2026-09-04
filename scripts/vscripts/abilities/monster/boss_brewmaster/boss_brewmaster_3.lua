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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local BARREL_WAVE_COUNT = 6
local BARREL_COUNT_PER_WAVE = 5
local BARREL_WAVE_INTERVAL = 1.1
local BARREL_CAST_POINT = 0.6
local BARREL_START_BEHIND_DISTANCE = 1000
local BARREL_START_LATERAL_RANGE = 1000
local BARREL_MIN_LATERAL_SPACING = 100
local BARREL_DISTANCE = 3000
local BARREL_SPEED = 1000
local BARREL_EFFECT_CLEANUP_BUFFER = 0.1
local BARREL_DAMAGE_RATE = 39
local BARREL_STUN_DURATION = 0.5
local BARREL_PROJECTILE_EFFECT = "particles/brewmaster_barrel_of_ale.vpcf"
local BARREL_EXPLOSION_EFFECT = "particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_aoe.vpcf"
local BARREL_EXPLOSION_RADIUS = 350
local BARREL_CAST_SOUND = "Hero_Brewmaster.Barrel.Cast"
local BARREL_EXPLOSION_SOUND = "Hero_Brewmaster.ThunderClap"
--- 酒仙 BOSS 技能 3。
____exports.boss_brewmaster_3 = __TS__Class()
local boss_brewmaster_3 = ____exports.boss_brewmaster_3
boss_brewmaster_3.name = "boss_brewmaster_3"
__TS__ClassExtends(boss_brewmaster_3, MonsterAbility_CS)
function boss_brewmaster_3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.particleEffects = __TS__New(Set)
end
function boss_brewmaster_3.prototype.Precache(self, context)
	PrecacheResource("particle", BARREL_PROJECTILE_EFFECT, context)
	PrecacheResource("particle", BARREL_EXPLOSION_EFFECT, context)
end
function boss_brewmaster_3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = BARREL_CAST_POINT,
		castDuration = BARREL_WAVE_INTERVAL * (BARREL_WAVE_COUNT - 1) + BARREL_DISTANCE / BARREL_SPEED,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnStart = function()
			return self:StartBarrelSequence()
		end,
		OnInterrupt = function()
			return self:StopBarrelChanneling()
		end,
		OnFinish = function()
			return self:StopBarrelChanneling()
		end,
	}
end
function boss_brewmaster_3.prototype.StartBarrelSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
	self:ThrowBarrelWave(0)
end
function boss_brewmaster_3.prototype.StopBarrelChanneling(self)
	local caster = self:GetCaster()
	if not IsValid(nil, caster) then
		return
	end
	caster:FadeGesture(ACT_DOTA_CHANNEL_ABILITY_2)
end
function boss_brewmaster_3.prototype.ThrowBarrelWave(self, waveIndex)
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.5, 3000, 0, true)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector():Normalized()
	local right = Vector(-forward.y, forward.x, 0)
	local lateralOffsets = self:GetRandomBarrelLateralOffsets()
	for ____, lateralOffset in ipairs(lateralOffsets) do
		local startPoint = origin:__sub(forward:__mul(BARREL_START_BEHIND_DISTANCE)):__add(right:__mul(lateralOffset))
		self:CreateBarrelProjectile(caster, startPoint, forward)
	end
	if waveIndex < BARREL_WAVE_COUNT - 1 then
		local nextWaveIndex = waveIndex + 1
		self:Timer(BARREL_WAVE_INTERVAL, function()
			return self:ThrowBarrelWave(nextWaveIndex)
		end)
	end
end
function boss_brewmaster_3.prototype.GetRandomBarrelLateralOffsets(self)
	local candidates = {}
	do
		local offset = -BARREL_START_LATERAL_RANGE
		while offset <= BARREL_START_LATERAL_RANGE do
			candidates[#candidates + 1] = offset
			offset = offset + BARREL_MIN_LATERAL_SPACING
		end
	end
	local selectedOffsets = {}
	do
		local selectionIndex = 0
		while selectionIndex < BARREL_COUNT_PER_WAVE do
			local currentSelectionIndex = selectionIndex
			local randomIndex = RandomInt(currentSelectionIndex, #candidates - 1)
			local selectedOffset = candidates[randomIndex + 1]
			candidates[randomIndex + 1] = candidates[currentSelectionIndex + 1]
			candidates[currentSelectionIndex + 1] = selectedOffset
			selectedOffsets[#selectedOffsets + 1] = selectedOffset
			selectionIndex = selectionIndex + 1
		end
	end
	return selectedOffsets
end
function boss_brewmaster_3.prototype.CreateBarrelProjectile(self, caster, startPoint, forward)
	local endPoint = startPoint:__add(forward:__mul(BARREL_DISTANCE))
	local effect = ParticleManager:CreateParticle(BARREL_PROJECTILE_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, startPoint)
	ParticleManager:SetParticleControl(effect, 1, Vector(BARREL_SPEED, 0, 0))
	ParticleManager:SetParticleControl(effect, 2, Vector(0, 50, 0))
	ParticleManager:SetParticleControl(effect, 3, endPoint)
	self.particleEffects:add(effect)
	EmitSoundOnLocationWithCaster(startPoint, BARREL_CAST_SOUND, caster)
	local currentEffect = effect
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = "",
		start_point = startPoint,
		target = endPoint,
		projectile_type = "linear",
		projectile_speed = BARREL_SPEED,
		projectile_distance = BARREL_DISTANCE,
		projectile_range = 80,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		extra_data = { effect = effect },
		on_hit = function(____, target, location, _extraData)
			self:DestroyBarrelEffect(currentEffect)
			if not target then
				return true
			end
			if not IsValidAlive(nil, target) or not IsValidAlive(nil, caster) then
				return true
			end
			caster:MonsterDamage({ victim = target, damage_rate = BARREL_DAMAGE_RATE, ability = self })
			target:KnockBack(caster, self, {
				duration = 0.2,
				distance = 35,
				height = 25,
				stun = true,
				stunDuration = BARREL_STUN_DURATION,
			})
			self:PlayBarrelExplosion(location)
			return true
		end,
	})
	self:Timer(BARREL_DISTANCE / BARREL_SPEED + BARREL_EFFECT_CLEANUP_BUFFER, function()
		self:DestroyBarrelEffect(currentEffect)
	end)
end
function boss_brewmaster_3.prototype.PlayBarrelExplosion(self, location)
	local effect = ParticleManager:CreateParticle(BARREL_EXPLOSION_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, location)
	ParticleManager:SetParticleControl(effect, 1, Vector(BARREL_EXPLOSION_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOnLocationWithCaster(location, BARREL_EXPLOSION_SOUND, self:GetCaster())
end
function boss_brewmaster_3.prototype.DestroyBarrelEffect(self, effect)
	if effect == nil or not self.particleEffects:has(effect) then
		return
	end
	ParticleManager:DestroyParticle(effect, true)
	ParticleManager:ReleaseParticleIndex(effect)
	self.particleEffects:delete(effect)
end
boss_brewmaster_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_brewmaster_3)
____exports.boss_brewmaster_3 = boss_brewmaster_3
return ____exports