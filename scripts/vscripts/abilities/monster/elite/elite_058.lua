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
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____obstruction = require("utils.obstruction")
local SpawnSquareObstructions = ____obstruction.SpawnSquareObstructions
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 0.15
local PROJECTILE_SPEED = 2500
local WALL_DURATION = 8.5
local WALL_WARNING_DURATION = 0.5
local SHARD_COUNT = 7
local SHARD_RADIUS = 300
local WALL_ARC_DEGREES = 270
local WALL_WARNING_RADIUS = 380
local OBSTRUCTION_STEP = 80
local UNIT_ARRANGE_RADIUS = SHARD_RADIUS + 120
local HERO_SAFE_OFFSET = 80
local MONSTER_GATE_DISTANCE = SHARD_RADIUS - 75
local MONSTER_GATE_SPACING = 90
local PILLAR_KNOCKBACK_RADIUS = 140
local PILLAR_KNOCKBACK_DISTANCE = 220
local PILLAR_KNOCKBACK_DURATION = 0.25
local PILLAR_KNOCKBACK_HEIGHT = 0
local CAST_DURATION = CAST_RANGE / PROJECTILE_SPEED + WALL_WARNING_DURATION
local TUSK_ICE_SHARDS_PARTICLE = "particles/units/heroes/hero_tusk/tusk_ice_shards.vpcf"
local TUSK_ICE_SHARDS_PROJECTILE_PARTICLE = "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf"
local ICE_SHARDS_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts"
local ICE_SHARDS_CAST_SOUND = "Hero_Tusk.IceShards"
--- 精英技能58 - 寒冰围栏：在目标周围立起半包围冰墙，留下一个狭窄出口
____exports.elite_058 = __TS__Class()
local elite_058 = ____exports.elite_058
elite_058.name = "elite_058"
__TS__ClassExtends(elite_058, MonsterAbility_CS)
function elite_058.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetPos = nil
	self.openDir = nil
end
function elite_058.prototype.Precache(self, context)
	PrecacheResource("particle", TUSK_ICE_SHARDS_PARTICLE, context)
	PrecacheResource("particle", TUSK_ICE_SHARDS_PROJECTILE_PARTICLE, context)
	PrecacheResource("soundfile", ICE_SHARDS_SOUND_EVENTS, context)
end
function elite_058.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:GetCaster():GetMinDistanceUnit(CAST_RANGE)) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				return
			end
			self.targetPos = target:GetAbsOrigin()
			self.openDir = caster:GetAbsOrigin():__sub(self.targetPos):Normalized()
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) or not self.targetPos or not self.openDir then
				self.targetPos = nil
				self.openDir = nil
				return
			end
			local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
			local endPoint = GetGroundPosition(self.targetPos, caster)
			local projectileDistance = math.max(1, endPoint:__sub(startPoint):Length2D())
			local dir = self.openDir
			EmitSoundOn(ICE_SHARDS_CAST_SOUND, caster)
			self.targetPos = nil
			self.openDir = nil
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = TUSK_ICE_SHARDS_PROJECTILE_PARTICLE,
				projectile_type = "linear",
				projectile_speed = PROJECTILE_SPEED,
				start_point = startPoint,
				target = endPoint,
				projectile_distance = projectileDistance,
				projectile_range = 96,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				on_hit = function(____, hitTarget, location)
					if hitTarget then
						return false
					end
					if not IsServer() or not IsValidAlive(nil, caster) then
						return true
					end
					local groundPos = GetGroundPosition(location, caster)
					self:WarningRingEffect(groundPos, WALL_WARNING_RADIUS, WALL_WARNING_DURATION, { speed = 0 })
					self:CreateIceShardsAfterWarning(caster, groundPos, dir)
					return true
				end,
			})
		end,
	}
end
function elite_058.prototype.CreateIceShardsAfterWarning(self, caster, groundPos, dir)
	self:Timer(WALL_WARNING_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		CreateModifierThinker(
			caster,
			self,
			"modifier_elite_058_ice_shards",
			{ duration = WALL_DURATION, dir_x = dir.x, dir_y = dir.y },
			groundPos,
			caster:GetTeamNumber(),
			false
		)
	end)
end
elite_058 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_058)
____exports.elite_058 = elite_058
local modifier_elite_058_ice_shards = __TS__Class()
modifier_elite_058_ice_shards.name = "modifier_elite_058_ice_shards"
__TS__ClassExtends(modifier_elite_058_ice_shards, MonsterModifier_CS)
function modifier_elite_058_ice_shards.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.obstructions = {}
end
function modifier_elite_058_ice_shards.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	local center = GetGroundPosition(parent:GetAbsOrigin(), parent)
	local openDir = self:GetOpenDirection(params)
	local shardPoints = self:BuildShardPoints(center, openDir)
	self:ArrangeUnits(center, openDir)
	self:CreateObstructions(shardPoints)
	self:CreateParticle(center, shardPoints)
	self:KnockBackEnemiesNearShardOuterSide(center, shardPoints)
end
function modifier_elite_058_ice_shards.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	for ____, obstruction in ipairs(self.obstructions) do
		if IsValid(nil, obstruction) then
			obstruction:RemoveSelf()
		end
	end
	self.obstructions = {}
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_058_ice_shards.prototype.IsHidden(self)
	return true
end
function modifier_elite_058_ice_shards.prototype.IsPurgable(self)
	return false
end
function modifier_elite_058_ice_shards.prototype.GetOpenDirection(self, params)
	local raw = Vector(params.dir_x or 1, params.dir_y or 0, 0)
	if raw:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return raw:Normalized()
end
function modifier_elite_058_ice_shards.prototype.BuildShardPoints(self, center, openDir)
	local points = {}
	local startAngle = -WALL_ARC_DEGREES / 2
	local angleStep = WALL_ARC_DEGREES / math.max(1, SHARD_COUNT - 1)
	local wallCenterDir = openDir:__mul(-1)
	do
		local i = 0
		while i < SHARD_COUNT do
			local dir = RotateVector2D(nil, wallCenterDir, startAngle + angleStep * i)
			local rawPoint = center:__add(dir:__mul(SHARD_RADIUS))
			points[#points + 1] = GetGroundPosition(rawPoint, self:GetParent())
			i = i + 1
		end
	end
	return points
end
function modifier_elite_058_ice_shards.prototype.CreateObstructions(self, points)
	local placed = {}
	do
		local i = 0
		while i < #points do
			do
				if i == 0 then
					self:SpawnObstructionAt(points[i + 1], placed)
					goto __continue32
				end
				local from = points[i]
				local to = points[i + 1]
				local delta = to:__sub(from)
				local distance = delta:Length2D()
				local ____temp_1
				if distance > 0 then
					____temp_1 = delta:Normalized()
				else
					____temp_1 = Vector(1, 0, 0)
				end
				local dir = ____temp_1
				local count = math.max(1, math.ceil(distance / OBSTRUCTION_STEP))
				do
					local step = 1
					while step <= count do
						local t = step / count
						local pos = from:__add(dir:__mul(distance * t))
						self:SpawnObstructionAt(pos, placed)
						step = step + 1
					end
				end
			end
			::__continue32::
			i = i + 1
		end
	end
	for ____, obstruction in ipairs(self.obstructions) do
		if IsValid(nil, obstruction) then
			obstruction:SetEnabled(true, false)
		end
	end
end
function modifier_elite_058_ice_shards.prototype.SpawnObstructionAt(self, pos, placed)
	for ____, existing in ipairs(placed) do
		if existing:__sub(pos):Length2D() < OBSTRUCTION_STEP * 0.6 then
			return
		end
	end
	placed[#placed + 1] = pos
	local yaw = RandomFloat(0, 360)
	__TS__ArrayPushArray(self.obstructions, SpawnSquareObstructions(nil, pos, yaw))
end
function modifier_elite_058_ice_shards.prototype.ArrangeUnits(self, center, openDir)
	local units = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),
		center,
		nil,
		UNIT_ARRANGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local heroes = {}
	local monsters = {}
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(nil, unit) or unit == self:GetParent() then
				goto __continue43
			end
			if unit.IsHero and unit:IsHero() then
				heroes[#heroes + 1] = unit
			else
				monsters[#monsters + 1] = unit
			end
		end
		::__continue43::
	end
	do
		local i = 0
		while i < #heroes do
			local targetPos = self:GetHeroSafePoint(center, i, #heroes)
			self:MoveUnitToSafePoint(heroes[i + 1], targetPos)
			i = i + 1
		end
	end
	do
		local i = 0
		while i < #monsters do
			local targetPos = self:GetMonsterGatePoint(center, openDir, i)
			self:MoveUnitToSafePoint(monsters[i + 1], targetPos)
			i = i + 1
		end
	end
end
function modifier_elite_058_ice_shards.prototype.KnockBackEnemiesNearShardOuterSide(self, center, shardPoints)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	local knockedEnemies = __TS__New(Map)
	for ____, shardPoint in ipairs(shardPoints) do
		local direction = self:GetOuterDirection(center, shardPoint)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			shardPoint,
			nil,
			PILLAR_KNOCKBACK_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue53
				end
				local enemyIndex = enemy:GetEntityIndex()
				if knockedEnemies:get(enemyIndex) then
					goto __continue53
				end
				knockedEnemies:set(enemyIndex, true)
				enemy:KnockBack(caster, ability, {
					direction = direction,
					distance = PILLAR_KNOCKBACK_DISTANCE,
					duration = PILLAR_KNOCKBACK_DURATION,
					height = PILLAR_KNOCKBACK_HEIGHT,
					stun = false,
					block = true,
					blockUntraversable = true,
					destroyTreesRange = 80,
				})
			end
			::__continue53::
		end
	end
end
function modifier_elite_058_ice_shards.prototype.GetOuterDirection(self, center, shardPoint)
	local direction = Vector(shardPoint.x - center.x, shardPoint.y - center.y, 0)
	if direction:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return direction:Normalized()
end
function modifier_elite_058_ice_shards.prototype.GetHeroSafePoint(self, center, index, count)
	if count <= 1 then
		return center
	end
	local angle = 360 / count * index
	local offset = RotateVector2D(nil, Vector(HERO_SAFE_OFFSET, 0, 0), angle)
	return center:__add(offset)
end
function modifier_elite_058_ice_shards.prototype.GetMonsterGatePoint(self, center, openDir, index)
	local right = RotateVector2D(nil, openDir, 90)
	local row = math.floor(index / 3)
	local column = index % 3
	local sideOffset = (column - 1) * MONSTER_GATE_SPACING
	local forwardOffset = MONSTER_GATE_DISTANCE + row * MONSTER_GATE_SPACING
	return center:__add(openDir:__mul(forwardOffset)):__add(right:__mul(sideOffset))
end
function modifier_elite_058_ice_shards.prototype.MoveUnitToSafePoint(self, unit, pos)
	local groundPos = GetGroundPosition(pos, unit)
	GridNav:DestroyTreesAroundPoint(groundPos, 80, false)
	FindClearSpaceForUnit(unit, groundPos, true)
end
function modifier_elite_058_ice_shards.prototype.CreateParticle(self, center, points)
	self.particleId = ParticleManager:CreateParticle(TUSK_ICE_SHARDS_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particleId, 0, center)
	do
		local i = 0
		while i < SHARD_COUNT do
			ParticleManager:SetParticleControl(self.particleId, i + 1, points[i + 1])
			i = i + 1
		end
	end
	ParticleManager:SetParticleControl(self.particleId, 21, Vector(WALL_DURATION, 0, 0))
end
modifier_elite_058_ice_shards =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_058_ice_shards") }, modifier_elite_058_ice_shards)
return ____exports