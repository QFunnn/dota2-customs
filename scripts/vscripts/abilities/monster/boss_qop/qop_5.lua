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
local modifier_qop_5_cast_state
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_POINT = 0.6
local BASE_WAVE_COUNT = 5
local BARRAGE_DURATION_MULTIPLIER = 1.5
local WAVE_COUNT = math.ceil(BASE_WAVE_COUNT * BARRAGE_DURATION_MULTIPLIER)
local WAVE_INTERVAL = 1
local PROJECTILE_COUNT_PER_WAVE = 7
local PROJECTILE_ROW_SPACING = 260
local PROJECTILE_EMPTY_SLOT_CHANCE = 35
local PROJECTILE_MIN_EMPTY_SLOTS = 2
local PROJECTILE_MIN_PROJECTILES = 3
local PROJECTILE_START_OFFSET = 1500
local PROJECTILE_START_HEIGHT = 900
local PROJECTILE_DISTANCE = 3000
local PROJECTILE_MIN_SPEED = 900
local PROJECTILE_MAX_SPEED = 1350
local PROJECTILE_RADIUS = 125
local PROJECTILE_DAMAGE_RATE = 15
local PROJECTILE_STUN_DURATION = 1.5
local PROJECTILE_YAW_ANGLE = 45
local BASE_PROJECTILE_TRAVEL_DURATION = PROJECTILE_DISTANCE / PROJECTILE_MIN_SPEED
local BASE_BARRAGE_DURATION = (BASE_WAVE_COUNT - 1) * WAVE_INTERVAL + BASE_PROJECTILE_TRAVEL_DURATION + 0.2
local BARRAGE_DURATION = BASE_BARRAGE_DURATION * BARRAGE_DURATION_MULTIPLIER
local PROJECTILE_EFFECT = "particles/boss/qop_5.vpcf"
local PROJECTILE_HIT_EFFECT = "particles/econ/items/invoker/invoker_apex/invoker_sun_strike_immortal1.vpcf"
local PROJECTILE_BASE_DIRECTION = Vector(0, 1, 0)
local CAST_ANIMATION_NAME = "qop_arc_victory_versus"
--- 苦痛魅魔技能5：从上方斜向释放多轮投射物。
____exports.qop_5 = __TS__Class()
local qop_5 = ____exports.qop_5
qop_5.name = "qop_5"
__TS__ClassExtends(qop_5, MonsterAbility_CS)
function qop_5.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.waveToken = 0
	self.lockedDirection = Vector(1, 0, 0)
	self.barrageCenter = Vector(0, 0, 0)
end
function qop_5.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_HIT_EFFECT, context)
end
function qop_5.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = BARRAGE_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.8,
		isNotMove = true,
		OnPhaseStart = function()
			return self:prepareBarrage()
		end,
		OnStart = function()
			return self:startBarrage()
		end,
		OnInterrupt = function()
			return self:cancelBarrage()
		end,
		OnFinish = function()
			return self:cancelBarrage()
		end,
	}
end
function qop_5.prototype.prepareBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(2600)
	self.lockedDirection = RotateVector2D(nil, PROJECTILE_BASE_DIRECTION, PROJECTILE_YAW_ANGLE):Normalized()
	self.barrageCenter = caster:GetAbsOrigin()
	if target then
		caster:LockTargetForSpeed(target, CAST_POINT, 6)
	end
	caster:EmitSound("Hero_QueenOfPain.ScreamOfPain")
end
function qop_5.prototype.startBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.waveToken = self.waveToken + 1
	local token = self.waveToken
	caster:SetForwardVectorWithoutInterrupt(self.lockedDirection)
	caster:SetAnimation(CAST_ANIMATION_NAME)
	modifier_qop_5_cast_state:applys(caster, caster, self, { duration = BARRAGE_DURATION })
	ScreenShake(caster:GetAbsOrigin(), 10, 10, 8, 3000, 0, true)
	self:fireWave(token, 0)
end
function qop_5.prototype.cancelBarrage(self)
	local caster = self:GetCaster()
	self.waveToken = self.waveToken + 1
	if IsValidAlive(nil, caster) then
		modifier_qop_5_cast_state:remove(caster)
		caster:FadeGesture(ACT_DOTA_VICTORY)
	end
end
function qop_5.prototype.fireWave(self, token, waveIndex)
	local caster = self:GetCaster()
	if token ~= self.waveToken or not IsValidAlive(nil, caster) then
		return
	end
	if waveIndex >= WAVE_COUNT then
		return
	end
	caster:EmitSound("Hero_QueenOfPain.ScreamOfPain")
	local direction = self:getWaveDirection(waveIndex)
	local side = RotateVector2D(nil, direction, 90):Normalized()
	local groundStartCenter =
		GetGroundPosition(self.barrageCenter:__add(direction:__mul(PROJECTILE_START_OFFSET)), caster)
	local firstOffset = -((PROJECTILE_COUNT_PER_WAVE - 1) * PROJECTILE_ROW_SPACING) / 2
	local activeSlots = self:rollActiveSlots()
	do
		local index = 0
		while index < PROJECTILE_COUNT_PER_WAVE do
			do
				if not activeSlots[index + 1] then
					goto __continue18
				end
				local sideOffset = firstOffset + index * PROJECTILE_ROW_SPACING
				local groundStart = GetGroundPosition(groundStartCenter:__add(side:__mul(sideOffset)), caster)
				self:createSlantedProjectile(groundStart, direction:__mul(-1), self:getProjectileSpeed(waveIndex))
			end
			::__continue18::
			index = index + 1
		end
	end
	self:Timer(WAVE_INTERVAL, function()
		return self:fireWave(token, waveIndex + 1)
	end)
end
function qop_5.prototype.getProjectileSpeed(self, waveIndex)
	if WAVE_COUNT <= 1 then
		return PROJECTILE_MAX_SPEED
	end
	local progress = math.max(0, math.min(1, waveIndex / (WAVE_COUNT - 1)))
	return PROJECTILE_MIN_SPEED + (PROJECTILE_MAX_SPEED - PROJECTILE_MIN_SPEED) * progress
end
function qop_5.prototype.getWaveDirection(self, waveIndex)
	local angle = waveIndex % 2 == 0 and PROJECTILE_YAW_ANGLE or -PROJECTILE_YAW_ANGLE
	return RotateVector2D(nil, PROJECTILE_BASE_DIRECTION, angle):Normalized()
end
function qop_5.prototype.rollActiveSlots(self)
	local slots = {}
	do
		local index = 0
		while index < PROJECTILE_COUNT_PER_WAVE do
			slots[#slots + 1] = RandomFloat(0, 100) >= PROJECTILE_EMPTY_SLOT_CHANCE
			index = index + 1
		end
	end
	self:ensureEmptySlotCount(slots)
	self:ensureProjectileCount(slots)
	return slots
end
function qop_5.prototype.ensureEmptySlotCount(self, slots)
	while #__TS__ArrayFilter(slots, function(____, active)
		return not active
	end) < PROJECTILE_MIN_EMPTY_SLOTS do
		local activeIndexes = self:getSlotIndexes(slots, true)
		if #activeIndexes <= PROJECTILE_MIN_PROJECTILES then
			return
		end
		slots[activeIndexes[RandomInt(0, #activeIndexes - 1) + 1] + 1] = false
	end
end
function qop_5.prototype.ensureProjectileCount(self, slots)
	while #__TS__ArrayFilter(slots, function(____, active)
		return active
	end) < PROJECTILE_MIN_PROJECTILES do
		local emptyIndexes = self:getSlotIndexes(slots, false)
		if #emptyIndexes <= PROJECTILE_MIN_EMPTY_SLOTS then
			return
		end
		slots[emptyIndexes[RandomInt(0, #emptyIndexes - 1) + 1] + 1] = true
	end
end
function qop_5.prototype.getSlotIndexes(self, slots, isActive)
	local indexes = {}
	do
		local index = 0
		while index < #slots do
			if slots[index + 1] == isActive then
				indexes[#indexes + 1] = index
			end
			index = index + 1
		end
	end
	return indexes
end
function qop_5.prototype.createSlantedProjectile(self, groundStart, direction, projectileSpeed)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_0
	if direction:Length2D() > 0.01 then
		____temp_0 = direction:Normalized()
	else
		____temp_0 = Vector(1, 0, 0)
	end
	local flyDirection = ____temp_0
	local airStart = groundStart:__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = PROJECTILE_EFFECT,
		projectile_type = "linear",
		start_point = airStart,
		direction = flyDirection,
		projectile_speed = projectileSpeed,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		on_think = function(____, location, extraData) end,
		on_hit = function(____, target, position)
			if not target or not IsValidAlive(nil, target) then
				return true
			end
			local ____this_2
			____this_2 = target
			local ____opt_1 = ____this_2.GetTotalEnergyShield
			local maxShield = ____opt_1 and ____opt_1(____this_2)
				or MyGameAttribute:GetAttribute(target, "total_energy_shield")
				or 0
			local expectedDamageBase = target:GetMaxHealth() + math.max(0, maxShield)
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:MonsterDamage({
				victim = target,
				damage_rate = PROJECTILE_DAMAGE_RATE,
				expected_damage_health_base_override = expectedDamageBase,
				ability = self,
			})
			AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = PROJECTILE_STUN_DURATION })
			self:playHitEffect(self:getHitGroundPosition(position, target, caster))
			return true
		end,
	})
end
function qop_5.prototype.getHitGroundPosition(self, position, target, caster)
	if position then
		return GetGroundPosition(position, caster)
	end
	if not IsValidAlive(nil, target) then
		return GetGroundPosition(caster:GetAbsOrigin(), caster)
	end
	return GetGroundPosition(target:GetAbsOrigin(), target)
end
function qop_5.prototype.playHitEffect(self, position)
	local pfx = ParticleManager:CreateParticle(PROJECTILE_HIT_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
qop_5 = __TS__DecorateLegacy({ registerAbility(nil) }, qop_5)
____exports.qop_5 = qop_5
modifier_qop_5_cast_state = __TS__Class()
modifier_qop_5_cast_state.name = "modifier_qop_5_cast_state"
__TS__ClassExtends(modifier_qop_5_cast_state, BaseModifier_CS)
function modifier_qop_5_cast_state.prototype.IsHidden(self)
	return true
end
function modifier_qop_5_cast_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_qop_5_cast_state.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(nil, parent) then
		parent:FadeGesture(ACT_DOTA_VICTORY)
	end
end
modifier_qop_5_cast_state = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_qop_5_cast_state)
return ____exports