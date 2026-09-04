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
local PARTICLE_THINKER = "particles/boss/boss_006ambient.vpcf"
local PARTICLE_DAMAGE = "particles/boss/boss_006ambient_container.vpcf"
local BOSS_005_COLLISION_RADIUS = 230
local BOSS_005_DAMAGE_RATE = 40
local PRE_CAST_DASH_DURATION = 0.5
local BOSS_005_CAST_SOUND = "Hero_SkywrathMage.ArcaneBolt.Cast"
local BOSS_005_THINKER_SOUND = "Hero_SkywrathMage.MysticFlare"
local BOSS_005_DAMAGE_SOUND = "Hero_SkywrathMage.MysticFlare.Target"
local BOSS_005_EXTRA_TRIGGER_HEALTH_PCT = 50
local BOSS_005_EXTRA_THINKER_COUNT = 3
local BOSS_005_EXTRA_TARGET_DISTANCE = 1200
local BOSS_005_EXTRA_WARNING_DURATION = 1
local BOSS_005_EXTRA_MOVE_SPEED = 450
local BOSS_005_EXTRA_DURATION = 3
local BOSS_005_EXTRA_GROUP_SPAWN_DELAYS = { 1, 2.5 }
--- Boss技能5：召唤一个 Thinker，有移速上限、转弯限制，追踪附近英雄，碰撞到英雄造成伤害 。
____exports.boss_005 = __TS__Class()
local boss_005 = ____exports.boss_005
boss_005.name = "boss_005"
__TS__ClassExtends(boss_005, MonsterAbility_CS)
function boss_005.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.thinkerDurationSec = 5
	self.thinkerMoveSpeed = 280
	self.thinkerMaxSpeed = 350
	self.thinkerMaxTurnDegPerSec = 90
	self.thinkerSearchRadius = 2000
	self.thinkerCollisionRadius = BOSS_005_COLLISION_RADIUS
	self.thinkerDamage = BOSS_005_DAMAGE_RATE
end
function boss_005.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/boss/boss_006ambient.vpcf", context)
	PrecacheResource("particle", "particles/boss/boss_006ambient_container.vpcf", context)
end
function boss_005.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_POINT,
		castPoint = 2,
		castDuration = 8,
		castAnimation = ACT_DOTA_TELEPORT,
		animationPlaybackRate = 1,
		OnPhaseStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			local spawnPoint = caster:GetSpawnPoint()
			if not spawnPoint then
				return
			end
			local currentPos = caster:GetAbsOrigin()
			local control = (currentPos + spawnPoint) * 0.5
			caster:AddNewModifier(caster, self, "modifier_boss_004", { duration = 4 })
			caster:Bezier2Mover({ currentPos, control, spawnPoint }, PRE_CAST_DASH_DURATION, nil, true)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			EmitSoundOn(BOSS_005_CAST_SOUND, caster)
			caster:AddNewModifier(caster, self, "modifier_boss_004", { duration = 10 })
			local searchRadiusForAssign = 1500
			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				origin,
				nil,
				searchRadiusForAssign,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			if #enemies == 0 then
				local forward = caster:GetForwardVector()
				local dir = Vector(forward.x, forward.y, 0):Normalized()
				if dir:Length2D() < 0.01 then
					dir.x = 1
					dir.y = 0
				end
				local spawnPos = origin + dir * 120
				spawnPos.z = GetGroundHeight(spawnPos, caster) or origin.z
				CreateModifierThinker(
					caster,
					self,
					"modifier_boss_005_thinker",
					{ duration = self.thinkerDurationSec },
					spawnPos,
					caster:GetTeamNumber(),
					false
				)
			else
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue11
						end
						local to = enemy:GetAbsOrigin() - origin
						local len = math.sqrt(to.x * to.x + to.y * to.y) or 1
						local dir = Vector(to.x / len, to.y / len, 0)
						local spawnPos = origin + dir * 120
						spawnPos.z = GetGroundHeight(spawnPos, caster) or origin.z
						CreateModifierThinker(caster, self, "modifier_boss_005_thinker", {
							duration = self.thinkerDurationSec,
							target_entindex = enemy:GetEntityIndex(),
						}, spawnPos, caster:GetTeamNumber(), false)
					end
					::__continue11::
				end
			end
			self:ScheduleLowHealthExtraThinkers(caster)
			self:Timer(self.thinkerDurationSec + 1, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:MoveToPosition(origin)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 1)
				return
			end)
			return
		end,
	}
end
function boss_005.prototype.ScheduleLowHealthExtraThinkers(self, caster)
	if caster:GetHealthPercent() >= BOSS_005_EXTRA_TRIGGER_HEALTH_PCT then
		return
	end
	do
		local index = 0
		while index < #BOSS_005_EXTRA_GROUP_SPAWN_DELAYS do
			local currentIndex = index
			local currentSpawnDelay = BOSS_005_EXTRA_GROUP_SPAWN_DELAYS[currentIndex + 1]
			local currentWarningDelay = math.max(currentSpawnDelay - BOSS_005_EXTRA_WARNING_DURATION, 0)
			self:Timer(currentWarningDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:CreateLowHealthExtraThinkerGroup(caster)
			end)
			index = index + 1
		end
	end
end
function boss_005.prototype.CreateLowHealthExtraThinkerGroup(self, caster)
	local origin = caster:GetAbsOrigin()
	local spawnPosition = GetGroundPosition(origin, caster)
	local baseTargetAngle = RandomFloat(0, 360)
	local targetAngleStep = 360 / BOSS_005_EXTRA_THINKER_COUNT
	do
		local index = 0
		while index < BOSS_005_EXTRA_THINKER_COUNT do
			local currentIndex = index
			local currentTargetDirection =
				RotateVector2D(nil, Vector(1, 0, 0), baseTargetAngle + currentIndex * targetAngleStep):Normalized()
			local currentTargetPosition =
				GetGroundPosition(origin:__add(currentTargetDirection:__mul(BOSS_005_EXTRA_TARGET_DISTANCE)), caster)
			local toCurrentTarget = currentTargetPosition:__sub(spawnPosition)
			local currentMoveDirection = Vector(toCurrentTarget.x, toCurrentTarget.y, 0):Normalized()
			local currentSpawnPosition = spawnPosition
			self:WarningEffect(
				currentSpawnPosition,
				currentTargetPosition,
				BOSS_005_EXTRA_WARNING_DURATION,
				{ startWidth = BOSS_005_COLLISION_RADIUS * 0.8, endWidth = BOSS_005_COLLISION_RADIUS * 0.8 }
			)
			self:Timer(BOSS_005_EXTRA_WARNING_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				CreateModifierThinker(caster, self, "modifier_boss_005_thinker", {
					duration = BOSS_005_EXTRA_DURATION,
					free_move = 1,
					move_direction_x = currentMoveDirection.x,
					move_direction_y = currentMoveDirection.y,
					move_speed = BOSS_005_EXTRA_MOVE_SPEED,
				}, currentSpawnPosition, caster:GetTeamNumber(), false)
			end)
			index = index + 1
		end
	end
end
function boss_005.prototype.getThinkerMoveSpeed(self)
	return self.thinkerMoveSpeed
end
function boss_005.prototype.getThinkerMaxSpeed(self)
	return self.thinkerMaxSpeed
end
function boss_005.prototype.getThinkerMaxTurnDegPerSec(self)
	return self.thinkerMaxTurnDegPerSec
end
function boss_005.prototype.getThinkerSearchRadius(self)
	return self.thinkerSearchRadius
end
function boss_005.prototype.getThinkerCollisionRadius(self)
	return self.thinkerCollisionRadius
end
function boss_005.prototype.getThinkerDamage(self)
	return self.thinkerDamage
end
function boss_005.prototype.getThinkerDurationSec(self)
	return self.thinkerDurationSec
end
function boss_005.prototype.getThinkerDamageIntervalSec(self)
	return 0.1
end
boss_005 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_005)
____exports.boss_005 = boss_005
____exports.modifier_boss_005_thinker = __TS__Class()
local modifier_boss_005_thinker = ____exports.modifier_boss_005_thinker
modifier_boss_005_thinker.name = "modifier_boss_005_thinker"
__TS__ClassExtends(modifier_boss_005_thinker, MonsterModifier_CS)
function modifier_boss_005_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.lastDamageTime = 0
	self.freeMove = false
end
function modifier_boss_005_thinker.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	local thinker = self:GetParent()
	self.freeMove = (kv and kv.free_move) == 1
	if self.freeMove then
		local moveDirection = Vector(kv.move_direction_x or 1, kv.move_direction_y or 0, 0):Normalized()
		local ____temp_2
		if moveDirection:Length2D() >= 0.01 then
			____temp_2 = moveDirection
		else
			____temp_2 = Vector(1, 0, 0)
		end
		self.dir = ____temp_2
		self.speed = kv.move_speed or BOSS_005_EXTRA_MOVE_SPEED
	end
	if not self.freeMove and kv and kv.target_entindex ~= nil then
		local target = EntIndexToHScript(kv.target_entindex)
		if target and IsValidAlive(nil, target) then
			self.target = target
		end
	end
	if not self.freeMove and not self.target then
		self:Destroy()
		return
	end
	if not self.freeMove and self.target then
		local origin = thinker:GetAbsOrigin()
		local targetPos = self.target:GetAbsOrigin()
		local to = targetPos - origin
		local len = math.sqrt(to.x * to.x + to.y * to.y) or 1
		self.dir = Vector(to.x / len, to.y / len, 0)
		if self.dir:Length2D() < 0.01 then
			self.dir.x = 1
			self.dir.y = 0
		end
		self.speed = self.ability:getThinkerMoveSpeed()
	end
	local pos = thinker:GetAbsOrigin()
	self.thinkerFx = ParticleManager:CreateParticle(PARTICLE_THINKER, PATTACH_WORLDORIGIN, thinker)
	ParticleManager:SetParticleControl(self.thinkerFx, 0, pos)
	ParticleManager:SetParticleControl(
		self.thinkerFx,
		1,
		Vector(BOSS_005_COLLISION_RADIUS + 50, BOSS_005_COLLISION_RADIUS + 50, BOSS_005_COLLISION_RADIUS + 50)
	)
	ParticleManager:SetParticleShouldCheckFoW(self.thinkerFx, false)
	EmitSoundOn(BOSS_005_THINKER_SOUND, thinker)
	self:StartIntervalThink(0.03)
end
function modifier_boss_005_thinker.prototype.OnDestroy(self)
	if IsServer() and self.thinkerFx ~= nil then
		ParticleManager:DestroyParticle(self.thinkerFx, false)
		ParticleManager:ReleaseParticleIndex(self.thinkerFx)
	end
end
function modifier_boss_005_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local origin = thinker:GetAbsOrigin()
	local moveSpeed = self.ability:getThinkerMoveSpeed()
	local maxSpeed = self.ability:getThinkerMaxSpeed()
	local maxTurnDegPerSec = self.ability:getThinkerMaxTurnDegPerSec()
	local collisionRadius = self.ability:getThinkerCollisionRadius()
	if not self.freeMove then
		local target = self.target
		if not target or not IsValidAlive(nil, target) then
			self:Destroy()
			return
		end
		local toTarget = target:GetAbsOrigin() - origin
		local lenToTarget = math.sqrt(toTarget.x * toTarget.x + toTarget.y * toTarget.y) or 1
		local desiredDir = Vector(toTarget.x / lenToTarget, toTarget.y / lenToTarget, 0)
		local currentAngle = math.atan2(self.dir.y, self.dir.x) * (180 / math.pi)
		local desiredAngle = math.atan2(desiredDir.y, desiredDir.x) * (180 / math.pi)
		local delta = desiredAngle - currentAngle
		while delta > 180 do
			delta = delta - 360
		end
		while delta < -180 do
			delta = delta + 360
		end
		local maxTurn = maxTurnDegPerSec * 0.03
		local turn = math.max(-maxTurn, math.min(maxTurn, delta))
		local newAngle = (currentAngle + turn) * (math.pi / 180)
		self.dir = Vector(math.cos(newAngle), math.sin(newAngle), 0)
		self.speed = math.min(maxSpeed, self.speed + moveSpeed * 0.1 * 0.03)
	end
	local move = self.dir * self.speed * 0.03
	local newPos = origin + move
	newPos.z = GetGroundHeight(newPos, thinker) or origin.z
	thinker:SetAbsOrigin(newPos)
	ParticleManager:SetParticleControl(self.thinkerFx, 0, newPos)
	local damageFx = ParticleManager:CreateParticle(PARTICLE_DAMAGE, PATTACH_WORLDORIGIN, thinker)
	ParticleManager:SetParticleControl(damageFx, 0, newPos)
	ParticleManager:SetParticleShouldCheckFoW(damageFx, false)
	ParticleManager:ReleaseParticleIndex(damageFx)
	local now = GameRules:GetGameTime()
	local damageInterval = self.ability:getThinkerDamageIntervalSec()
	if now - self.lastDamageTime >= damageInterval then
		self.lastDamageTime = now
		EmitSoundOnLocationWithCaster(newPos, BOSS_005_DAMAGE_SOUND, caster)
		local hitUnits = FindUnitsInRadius(
			caster:GetTeamNumber(),
			newPos,
			nil,
			collisionRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, u in ipairs(hitUnits) do
			do
				if not IsValidAlive(nil, u) then
					goto __continue53
				end
				caster:MonsterDamage({
					victim = u,
					damage_rate = self.ability:getThinkerDamage() * self.ability:getThinkerDamageIntervalSec(),
					ability = self.ability,
				})
			end
			::__continue53::
		end
	end
end
function modifier_boss_005_thinker.prototype.IsHidden(self)
	return true
end
function modifier_boss_005_thinker.prototype.IsPurgable(self)
	return false
end
modifier_boss_005_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_005_thinker") }, modifier_boss_005_thinker)
____exports.modifier_boss_005_thinker = modifier_boss_005_thinker
return ____exports