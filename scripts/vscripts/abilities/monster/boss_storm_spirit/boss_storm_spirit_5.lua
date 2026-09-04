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
local CAST_POINT = 1.5
local GROUP_COUNTS = {
	4,
	5,
	6,
	6,
	8,
}
local GROUP_INTERVAL = 1.2
local REMNANT_SPAWN_INTERVAL = 0.06
local REMNANT_MIN_ADJACENT_ANGLE = math.pi / 9
local REMNANT_MOVE_DURATION = 1.6
local REMNANT_MOVE_DISTANCE = 800
local REMNANT_MOVE_SPEED = REMNANT_MOVE_DISTANCE / REMNANT_MOVE_DURATION
local REMNANT_THINK_INTERVAL = 0.03
local REMNANT_TOUCH_RADIUS = 120
local REMNANT_COLLISION_EXPLOSION_DELAY = 0.1
local REMNANT_EXPLOSION_RADIUS = 240
local REMNANT_DAMAGE_RATE = 15
local REMNANT_THINKER_DURATION = REMNANT_MOVE_DURATION + REMNANT_COLLISION_EXPLOSION_DELAY + 0.2
local CAST_DURATION = (#GROUP_COUNTS - 1) * GROUP_INTERVAL
	+ (GROUP_COUNTS[#GROUP_COUNTS] - 1) * REMNANT_SPAWN_INTERVAL
	+ REMNANT_MOVE_DURATION
	+ REMNANT_COLLISION_EXPLOSION_DELAY
local PARTICLE_REMNANT = "particles/boss/boss_storm_spirit/ak_stormspirit_moving_remnant.vpcf"
local PARTICLE_EXPLOSION = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local SOUND_REMNANT_CAST = "Hero_StormSpirit.StaticRemnantPlant"
local SOUND_REMNANT_EXPLODE = "Hero_StormSpirit.StaticRemnantExplode"
--- 残影迸发：引导后分组向随机方向释放残影。
____exports.boss_storm_spirit_5 = __TS__Class()
local boss_storm_spirit_5 = ____exports.boss_storm_spirit_5
boss_storm_spirit_5.name = "boss_storm_spirit_5"
__TS__ClassExtends(boss_storm_spirit_5, MonsterAbility_CS)
function boss_storm_spirit_5.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_REMNANT, context)
	PrecacheResource("particle", PARTICLE_EXPLOSION, context)
end
function boss_storm_spirit_5.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_4,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function boss_storm_spirit_5.prototype.onStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local castCenter = GetGroundPosition(caster:GetAbsOrigin(), caster)
	do
		local groupIndex = 0
		while groupIndex < #GROUP_COUNTS do
			local currentGroupIndex = groupIndex
			local currentGroupCount = GROUP_COUNTS[currentGroupIndex + 1]
			local currentGroupDelay = currentGroupIndex * GROUP_INTERVAL
			self:Timer(currentGroupDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				if not caster:HasModifier("modifier_monster_cast_controller") then
					return
				end
				ScreenShake(caster:GetAbsOrigin(), 3, 12, 0.5, 3000, 0, true)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.25)
				self:Timer(0.25, function()
					caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.25)
				end)
				self:scheduleGroup(caster, castCenter, currentGroupCount)
			end)
			groupIndex = groupIndex + 1
		end
	end
end
function boss_storm_spirit_5.prototype.scheduleGroup(self, caster, center, count)
	local baseAngle = RandomFloat(0, math.pi * 2)
	local angleStep = math.pi * 2 / count
	local maxAngleJitter = math.max(0, (angleStep - REMNANT_MIN_ADJACENT_ANGLE) / 2)
	do
		local remnantIndex = 0
		while remnantIndex < count do
			local currentRemnantIndex = remnantIndex
			local currentDelay = currentRemnantIndex * REMNANT_SPAWN_INTERVAL
			local currentAngle = baseAngle
				+ currentRemnantIndex * angleStep
				+ RandomFloat(-maxAngleJitter, maxAngleJitter)
			local currentDirection = Vector(math.cos(currentAngle), math.sin(currentAngle), 0):Normalized()
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				if not caster:HasModifier("modifier_monster_cast_controller") then
					return
				end
				self:spawnRemnant(caster, center, currentDirection)
			end)
			remnantIndex = remnantIndex + 1
		end
	end
end
function boss_storm_spirit_5.prototype.spawnRemnant(self, caster, center, direction)
	caster:EmitSound(SOUND_REMNANT_CAST)
	CreateModifierThinker(caster, self, "modifier_boss_storm_spirit_5_remnant", {
		duration = REMNANT_THINKER_DURATION,
		parent_model = caster:GetModelName(),
		direction_x = direction.x,
		direction_y = direction.y,
	}, center, caster:GetTeamNumber(), false)
end
boss_storm_spirit_5 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_storm_spirit_5)
____exports.boss_storm_spirit_5 = boss_storm_spirit_5
local modifier_boss_storm_spirit_5_remnant = __TS__Class()
modifier_boss_storm_spirit_5_remnant.name = "modifier_boss_storm_spirit_5_remnant"
__TS__ClassExtends(modifier_boss_storm_spirit_5_remnant, MonsterModifier_CS)
function modifier_boss_storm_spirit_5_remnant.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.moveElapsed = 0
	self.explosionScheduled = false
	self.exploded = false
end
function modifier_boss_storm_spirit_5_remnant.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_spirit_5_remnant.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_storm_spirit_5_remnant.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local rawDirection = Vector(params.direction_x or 1, params.direction_y or 0, 0)
	local ____temp_0
	if rawDirection:Length2D() > 0.01 then
		____temp_0 = rawDirection:Normalized()
	else
		____temp_0 = Vector(1, 0, 0)
	end
	self.direction = ____temp_0
	thinker:SetOriginalModel(params.parent_model or "")
	thinker:SetModel(params.parent_model or "")
	thinker:SetModelScale(0.01)
	thinker:SetForwardVector(self.direction)
	self:createRemnantParticle(thinker)
	self:StartIntervalThink(REMNANT_THINK_INTERVAL)
end
function modifier_boss_storm_spirit_5_remnant.prototype.OnIntervalThink(self)
	if not IsServer() or self.exploded or self.explosionScheduled then
		return
	end
	local thinker = self:GetParent()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		self:Destroy()
		return
	end
	if self:hasTouchedEnemy(thinker) then
		self.explosionScheduled = true
		self:StartIntervalThink(-1)
		self:Timer(REMNANT_COLLISION_EXPLOSION_DELAY, function()
			return self:explode()
		end)
		return
	end
	local remainingDuration = REMNANT_MOVE_DURATION - self.moveElapsed
	local moveDuration = math.min(REMNANT_THINK_INTERVAL, remainingDuration)
	local nextPosition = thinker:GetAbsOrigin():__add(self.direction:__mul(REMNANT_MOVE_SPEED * moveDuration))
	nextPosition.z = GetGroundHeight(nextPosition, thinker)
	thinker:SetAbsOrigin(nextPosition)
	self:updateRemnantParticle(nextPosition)
	self.moveElapsed = self.moveElapsed + moveDuration
	if self.moveElapsed >= REMNANT_MOVE_DURATION then
		self:explode()
	end
end
function modifier_boss_storm_spirit_5_remnant.prototype.OnDestroy(self)
	if not IsServer() or self.exploded then
		return
	end
	self.exploded = true
	self:StartIntervalThink(-1)
	self:destroyRemnantParticle()
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local center = thinker:GetAbsOrigin()
	thinker:EmitSound(SOUND_REMNANT_EXPLODE)
	self:playExplosionParticle(center)
	self:damageEnemies(thinker, center)
	thinker:SelfRemoveSelf()
end
function modifier_boss_storm_spirit_5_remnant.prototype.hasTouchedEnemy(self, thinker)
	if not IsValidAlive(nil, thinker) then
		return false
	end
	local enemies = FindUnitsInRadius(
		thinker:GetTeamNumber(),
		thinker:GetAbsOrigin(),
		nil,
		REMNANT_TOUCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			return true
		end
	end
	return false
end
function modifier_boss_storm_spirit_5_remnant.prototype.explode(self)
	if self.exploded or self:IsRemoved() then
		return
	end
	self:Destroy()
end
function modifier_boss_storm_spirit_5_remnant.prototype.damageEnemies(self, thinker, center)
	local enemies = FindUnitsInRadius(
		thinker:GetTeamNumber(),
		center,
		nil,
		REMNANT_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	ScreenShake(caster:GetAbsOrigin(), 8, 3, 0.1, 3000, 0, true)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue42
			end
			if IsValidAlive(nil, caster) and ability and not ability:IsNull() then
				caster:MonsterDamage({ victim = enemy, damage_rate = REMNANT_DAMAGE_RATE, ability = ability })
				goto __continue42
			end
			ApplyMonsterDamage(nil, thinker, { victim = enemy, damage_rate = REMNANT_DAMAGE_RATE, damage_type = 2 })
		end
		::__continue42::
	end
end
function modifier_boss_storm_spirit_5_remnant.prototype.createRemnantParticle(self, thinker)
	self.pfxRemnant = ParticleManager:CreateParticle(PARTICLE_REMNANT, PATTACH_CUSTOMORIGIN, thinker)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxRemnant, false)
	ParticleManager:SetParticleControl(self.pfxRemnant, 0, thinker:GetAbsOrigin())
end
function modifier_boss_storm_spirit_5_remnant.prototype.updateRemnantParticle(self, position)
	if self.pfxRemnant == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxRemnant, 0, position)
end
function modifier_boss_storm_spirit_5_remnant.prototype.destroyRemnantParticle(self)
	if self.pfxRemnant == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxRemnant, false)
	ParticleManager:ReleaseParticleIndex(self.pfxRemnant)
	self.pfxRemnant = nil
end
function modifier_boss_storm_spirit_5_remnant.prototype.playExplosionParticle(self, position)
	local pfx = ParticleManager:CreateParticle(PARTICLE_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
modifier_boss_storm_spirit_5_remnant = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_5_remnant") },
	modifier_boss_storm_spirit_5_remnant
)
return ____exports