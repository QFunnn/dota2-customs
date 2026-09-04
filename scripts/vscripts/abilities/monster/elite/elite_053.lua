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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_053_jump
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local LOCK_RANGE = 1500
local CAST_POINT = 0.75
local JUMP_UP = 0.25
local PEAK_TIME = 0.5
local JUMP_DOWN = 0.25
local CAST_DURATION = JUMP_UP + PEAK_TIME + JUMP_DOWN
local JUMP_HEIGHT = 0
local PROJECTILE_ROW_COUNTS = { 2, 3, 4 }
local PROJECTILE_ROW_INTERVAL = 0.1
local PROJECTILE_ROW_DISTANCE = 260
local FAN_ANGLE = 60
local PROJECTILE_DISTANCE = #PROJECTILE_ROW_COUNTS * PROJECTILE_ROW_DISTANCE
local PROJECTILE_SPEED = 1200
local EXPLOSION_RADIUS = 200
local DAMAGE_RATE = 18
local PROJECTILE_PARTICLE = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf"
local PROJECTILE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_skywrath_mage.vsndevts"
local PROJECTILE_CAST_SOUND = "Hero_SkywrathMage.ConcussiveShot.Cast"
local PROJECTILE_IMPACT_SOUND = "Hero_SkywrathMage.ConcussiveShot.Target"
--- 精英技能53 - 天翔羽刃
--
-- 跃向天空，在空中瞄准地面扇形区域发射6枚投射物，
-- 投射物落地爆炸造成范围伤害。
--
--   castPoint 0.25s  地面蓄力
--   castDuration 1.0s:
--     0.00→0.25  跃起
--     0.25→0.75  空中(0.5s) 发射投射物
--     0.75→1.00  落地
____exports.elite_053 = __TS__Class()
local elite_053 = ____exports.elite_053
elite_053.name = "elite_053"
__TS__ClassExtends(elite_053, MonsterAbility_CS)
function elite_053.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("soundfile", PROJECTILE_SOUND_EVENTS, context)
end
function elite_053.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.7,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(LOCK_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT + JUMP_UP - 0.1, 4)
			end
			local origin = caster:GetAbsOrigin()
			self:WarningEffect(
				origin,
				origin:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE)),
				CAST_POINT + JUMP_UP,
				{
					startWidth = 80,
					endWidth = 520,
					getDirection = function()
						return caster:GetForwardVector()
					end,
				}
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			modifier_elite_053_jump:remove(caster)
			modifier_elite_053_jump:applys(caster, caster, self, { duration = CAST_DURATION })
			self:Timer(JUMP_UP, function()
				self:FireFanProjectiles()
			end)
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if not IsValid(nil, caster) or caster:IsNull() then
				return
			end
			modifier_elite_053_jump:remove(caster)
		end,
	}
end
function elite_053.prototype.FireFanProjectiles(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local casterPos = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local startPos = casterPos
	local groundBase = Vector(casterPos.x, casterPos.y, 0)
	EmitSoundOn(PROJECTILE_CAST_SOUND, caster)
	__TS__ArrayForEach(PROJECTILE_ROW_COUNTS, function(____, projectileCount, rowIndex)
		local delay = rowIndex * PROJECTILE_ROW_INTERVAL
		self:Timer(delay, function()
			self:FireProjectileRow(
				startPos,
				groundBase,
				forward,
				projectileCount,
				(rowIndex + 1) * PROJECTILE_ROW_DISTANCE
			)
		end)
	end)
end
function elite_053.prototype.FireProjectileRow(self, startPos, groundBase, forward, projectileCount, distance)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_0
	if projectileCount > 1 then
		____temp_0 = FAN_ANGLE / (projectileCount - 1)
	else
		____temp_0 = 0
	end
	local interval = ____temp_0
	do
		local i = 0
		while i < projectileCount do
			local ____temp_1
			if projectileCount > 1 then
				____temp_1 = -(FAN_ANGLE / 2) + interval * i
			else
				____temp_1 = 0
			end
			local angle = ____temp_1
			local direction = RotateVector2D(nil, forward, angle):Normalized()
			local rawTargetPos = groundBase:__add(direction:__mul(distance))
			local targetZ = GetGroundHeight(rawTargetPos, caster) or rawTargetPos.z
			local targetPos = Vector(rawTargetPos.x, rawTargetPos.y, targetZ)
			local travelTime = self:GetBladeTravelTime(startPos, targetPos)
			self:WarningRingEffect(targetPos, EXPLOSION_RADIUS, travelTime)
			self:PlayBladeParticle(startPos, targetPos, travelTime)
			i = i + 1
		end
	end
end
function elite_053.prototype.PlayBladeParticle(self, startPos, targetPos, travelTime)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(PROJECTILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, startPos:__add(Vector(0, 0, 125)))
	ParticleManager:SetParticleControl(pfx, 1, targetPos + Vector(0, 0, 75))
	ParticleManager:SetParticleControl(pfx, 2, Vector(PROJECTILE_SPEED, 0, 0))
	Timers:CreateTimer(travelTime, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		if not IsValidAlive(nil, caster) then
			return
		end
		self:ExplodeAt(targetPos)
	end)
end
function elite_053.prototype.GetBladeTravelTime(self, startPos, targetPos)
	local dx = startPos.x - targetPos.x
	local dy = startPos.y - targetPos.y
	local dz = startPos.z - targetPos.z
	local travelDistance = math.sqrt(dx * dx + dy * dy + dz * dz)
	return travelDistance / PROJECTILE_SPEED
end
function elite_053.prototype.ExplodeAt(self, pos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOnLocationWithCaster(pos, PROJECTILE_IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue24::
	end
end
elite_053 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_053)
____exports.elite_053 = elite_053
modifier_elite_053_jump = __TS__Class()
modifier_elite_053_jump.name = "modifier_elite_053_jump"
__TS__ClassExtends(modifier_elite_053_jump, MonsterModifier_CS)
function modifier_elite_053_jump.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._elapsed = 0
end
function modifier_elite_053_jump.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local origin = parent:GetAbsOrigin()
	local groundZ = GetGroundHeight(origin, parent) or origin.z
	self._groundPos = Vector(origin.x, origin.y, groundZ)
	self._startGroundPos = self._groundPos
	self._elapsed = 0
	self:SetPosition(parent, 0)
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_053_jump.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self._groundPos then
		self:Destroy()
		return
	end
	self._elapsed = math.min(self._elapsed + FrameTime(), CAST_DURATION)
	local height = self:GetCurrentHeight(self._elapsed)
	self:SetPosition(parent, height)
	if self._elapsed >= CAST_DURATION then
		self:Destroy()
	end
end
function modifier_elite_053_jump.prototype.GetCurrentHeight(self, time)
	if time <= JUMP_UP then
		return JUMP_HEIGHT * self:SmootherStep(math.min(time / JUMP_UP, 1))
	end
	if time <= JUMP_UP + PEAK_TIME then
		return JUMP_HEIGHT
	end
	local fallProgress = math.min((time - JUMP_UP - PEAK_TIME) / JUMP_DOWN, 1)
	return JUMP_HEIGHT * (1 - self:SmootherStep(fallProgress))
end
function modifier_elite_053_jump.prototype.SmootherStep(self, t)
	return t * t * t * (t * (t * 6 - 15) + 10)
end
function modifier_elite_053_jump.prototype.SetPosition(self, parent, height)
	if not self._startGroundPos then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsOrigin(Vector(self._startGroundPos.x, self._startGroundPos.y, self._startGroundPos.z + height))
end
function modifier_elite_053_jump.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() or not self._startGroundPos then
		return
	end
	if IsValidAlive(nil, parent) then
		parent:SetAbsOrigin(self._startGroundPos)
		FindClearSpaceForUnit(parent, self._startGroundPos, true)
	end
end
function modifier_elite_053_jump.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_elite_053_jump.prototype.IsHidden(self)
	return true
end
function modifier_elite_053_jump.prototype.IsPurgable(self)
	return false
end
modifier_elite_053_jump =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_053_jump") }, modifier_elite_053_jump)
return ____exports