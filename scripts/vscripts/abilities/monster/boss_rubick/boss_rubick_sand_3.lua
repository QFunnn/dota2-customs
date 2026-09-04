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
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_SAND_3_CAST_RANGE = 3000
--- 施法前摇。
local RUBICK_SAND_3_CAST_POINT = 0.45
--- 施法生命周期持续时间，风暴本身会持续到下次释放时刷新。
local RUBICK_SAND_3_CAST_DURATION = 0.5
--- 沙尘暴簇数量下限。
local RUBICK_SAND_3_MIN_CLUSTER_COUNT = 3
--- 沙尘暴簇数量上限。
local RUBICK_SAND_3_MAX_CLUSTER_COUNT = 4
--- 每簇沙尘暴中心数量下限。
local RUBICK_SAND_3_MIN_STORMS_PER_CLUSTER = 1
--- 每簇沙尘暴中心数量上限。
local RUBICK_SAND_3_MAX_STORMS_PER_CLUSTER = 2
--- 单个沙尘暴占据方块数量。
local RUBICK_SAND_3_TILES_PER_STORM = 4
--- 沙尘暴伤害检测间隔。
local RUBICK_SAND_3_DAMAGE_INTERVAL = 0.35
--- 单次周期伤害倍率。
local RUBICK_SAND_3_DAMAGE_RATE = 4
--- 方块沙尘暴特效。
local RUBICK_SAND_3_SANDSTORM_PARTICLE =
	"particles/rebuild/spell/rubick_boss/cube_ground_effect/effect_sand/effectbaby_roshan_desert_sands_ambient.vpcf"
--- 拉比克沙漠技能三：沙尘暴地块。
--
-- 技能形态：
-- 1. 随机生成几簇沙尘暴。
-- 2. 每簇由 1-2 个相邻风暴中心扎堆组成。
-- 3. 每个风暴占据最多 4 个相邻方块，特效中心取作用方块的几何中心。
-- 4. 沙尘暴持续对站在作用方块上的敌人造成伤害，直到下次释放时刷新。
____exports.boss_rubick_sand_3 = __TS__Class()
local boss_rubick_sand_3 = ____exports.boss_rubick_sand_3
boss_rubick_sand_3.name = "boss_rubick_sand_3"
__TS__ClassExtends(boss_rubick_sand_3, RubickOriginAbility)
function boss_rubick_sand_3.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.sandstormTiles = {}
	self.sandstormParticles = {}
end
function boss_rubick_sand_3.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_SAND_3_SANDSTORM_PARTICLE, context)
end
function boss_rubick_sand_3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_SAND_3_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_SAND_3_CAST_POINT,
		castDuration = RUBICK_SAND_3_CAST_DURATION,
		canCast = function()
			local floorId = self:GetCastFloorId()
			if not floorId or not MyGameDynamicFloor then
				return UF_FAIL_CUSTOM
			end
			local ____MyGameDynamicFloor_GetAvailableTiles_result_some_result_0
			if
				__TS__ArraySome(MyGameDynamicFloor:GetAvailableTiles(floorId), function(____, tile)
					return self:CanUseTile(tile)
				end)
			then
				____MyGameDynamicFloor_GetAvailableTiles_result_some_result_0 = UF_SUCCESS
			else
				____MyGameDynamicFloor_GetAvailableTiles_result_some_result_0 = UF_FAIL_CUSTOM
			end
			return ____MyGameDynamicFloor_GetAvailableTiles_result_some_result_0
		end,
		OnStart = function()
			self.castToken = self.castToken + 1
			self:StartSandstorms(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearSandstorms()
		end,
	}
end
function boss_rubick_sand_3.prototype.StartSandstorms(self, token)
	self:ClearSandstorms()
	local floorId = self:GetCastFloorId()
	if not floorId or not MyGameDynamicFloor then
		return
	end
	local availableTiles = __TS__ArrayFilter(MyGameDynamicFloor:GetAvailableTiles(floorId), function(____, tile)
		return self:CanUseTile(tile)
	end)
	if #availableTiles <= 0 then
		return
	end
	local clusterCount = RandomInt(RUBICK_SAND_3_MIN_CLUSTER_COUNT, RUBICK_SAND_3_MAX_CLUSTER_COUNT)
	local stormCenters = {}
	do
		local index = 0
		while index < clusterCount do
			local clusterCenters = self:SelectClusterCenters(availableTiles, stormCenters)
			self:AppendUniqueTiles(stormCenters, clusterCenters)
			index = index + 1
		end
	end
	local storms = {}
	for ____, center in ipairs(stormCenters) do
		local stormTiles = self:GetStormEffectTiles(center)
		storms[#storms + 1] = {
			tiles = stormTiles,
			center = self:GetStormCenter(stormTiles),
			tileSize = center.tileSize,
		}
	end
	local effectTiles = {}
	for ____, storm in ipairs(storms) do
		self:AppendUniqueTiles(effectTiles, storm.tiles)
	end
	self.sandstormTiles = effectTiles
	self:PlaySandstormParticles(storms)
	self:StartDamageThink(token)
end
function boss_rubick_sand_3.prototype.SelectClusterCenters(self, availableTiles, excludedTiles)
	local candidates = __TS__ArrayFilter(availableTiles, function(____, tile)
		return not __TS__ArraySome(excludedTiles, function(____, existing)
			return self:IsSameTile(existing, tile)
		end)
	end)
	if #candidates <= 0 then
		return {}
	end
	local ____temp_1
	if #candidates > 0 then
		____temp_1 = candidates[RandomInt(0, #candidates - 1) + 1]
	else
		____temp_1 = availableTiles[RandomInt(0, #availableTiles - 1) + 1]
	end
	local center = ____temp_1
	local targetCount = RandomInt(RUBICK_SAND_3_MIN_STORMS_PER_CLUSTER, RUBICK_SAND_3_MAX_STORMS_PER_CLUSTER)
	local result = { center }
	local neighbors = self:ShuffleTiles(__TS__ArrayFilter(self:GetNeighborTiles8(center), function(____, tile)
		return self:CanUseTile(tile)
	end))
	for ____, neighbor in ipairs(neighbors) do
		do
			if #result >= targetCount then
				break
			end
			if
				__TS__ArraySome(excludedTiles, function(____, existing)
					return self:IsSameTile(existing, neighbor)
				end)
				or __TS__ArraySome(result, function(____, existing)
					return self:IsSameTile(existing, neighbor)
				end)
			then
				goto __continue23
			end
			result[#result + 1] = neighbor
		end
		::__continue23::
	end
	return result
end
function boss_rubick_sand_3.prototype.GetStormEffectTiles(self, center)
	local squareOffsets = self:ShuffleOffsetGroups({
		{ { dx = 0, dy = 0 }, { dx = 1, dy = 0 }, { dx = 0, dy = 1 }, { dx = 1, dy = 1 } },
		{ { dx = 0, dy = 0 }, { dx = -1, dy = 0 }, { dx = 0, dy = 1 }, { dx = -1, dy = 1 } },
		{ { dx = 0, dy = 0 }, { dx = 1, dy = 0 }, { dx = 0, dy = -1 }, { dx = 1, dy = -1 } },
		{ { dx = 0, dy = 0 }, { dx = -1, dy = 0 }, { dx = 0, dy = -1 }, { dx = -1, dy = -1 } },
	})
	for ____, offsets in ipairs(squareOffsets) do
		local tiles = __TS__ArrayFilter(self:GetTilesByOffsets(center, offsets), function(____, tile)
			return self:CanUseTile(tile)
		end)
		if #tiles == RUBICK_SAND_3_TILES_PER_STORM then
			return tiles
		end
	end
	local fallbackTiles = { center }
	self:AppendUniqueTiles(
		fallbackTiles,
		self:ShuffleTiles(__TS__ArrayFilter(self:GetNeighborTiles8(center), function(____, tile)
			return self:CanUseTile(tile)
		end)),
		RUBICK_SAND_3_TILES_PER_STORM
	)
	return fallbackTiles
end
function boss_rubick_sand_3.prototype.GetStormCenter(self, tiles)
	local x = 0
	local y = 0
	local z = 0
	local count = math.max(1, #tiles)
	for ____, tile in ipairs(tiles) do
		x = x + tile.surfaceOrigin.x
		y = y + tile.surfaceOrigin.y
		z = z + tile.surfaceOrigin.z
	end
	return Vector(x / count, y / count, z / count)
end
function boss_rubick_sand_3.prototype.AppendUniqueTiles(self, targetTiles, sourceTiles, maxCount)
	for ____, tile in ipairs(sourceTiles) do
		if maxCount ~= nil and #targetTiles >= maxCount then
			return
		end
		if
			not __TS__ArraySome(targetTiles, function(____, existing)
				return self:IsSameTile(existing, tile)
			end)
		then
			targetTiles[#targetTiles + 1] = tile
		end
	end
end
function boss_rubick_sand_3.prototype.ShuffleOffsetGroups(self, groups)
	local result = { unpack(groups) }
	do
		local index = #result - 1
		while index > 0 do
			local swapIndex = RandomInt(0, index)
			local current = result[index + 1]
			result[index + 1] = result[swapIndex + 1]
			result[swapIndex + 1] = current
			index = index - 1
		end
	end
	return result
end
function boss_rubick_sand_3.prototype.PlaySandstormParticles(self, storms)
	for ____, storm in ipairs(storms) do
		local particle = ParticleManager:CreateParticle(RUBICK_SAND_3_SANDSTORM_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, storm.center)
		ParticleManager:SetParticleControl(particle, 1, storm.center)
		ParticleManager:SetParticleControl(particle, 10, Vector(storm.tileSize, storm.tileSize, 0))
		local ____self_sandstormParticles_2 = self.sandstormParticles
		____self_sandstormParticles_2[#____self_sandstormParticles_2 + 1] = particle
	end
end
function boss_rubick_sand_3.prototype.StartDamageThink(self, token)
	if token ~= self.castToken or #self.sandstormTiles <= 0 then
		return
	end
	self:DamageEnemiesOnSandstormTiles()
	SysTimers:CreateTimer(RUBICK_SAND_3_DAMAGE_INTERVAL, function()
		self:StartDamageThink(token)
		return nil
	end)
end
function boss_rubick_sand_3.prototype.DamageEnemiesOnSandstormTiles(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, enemy in ipairs(self:FindEnemyUnitsOnTiles(self.sandstormTiles)) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue54
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = RUBICK_SAND_3_DAMAGE_RATE, ability = self })
		end
		::__continue54::
	end
end
function boss_rubick_sand_3.prototype.ShuffleTiles(self, tiles)
	local result = { unpack(tiles) }
	do
		local index = #result - 1
		while index > 0 do
			local swapIndex = RandomInt(0, index)
			local current = result[index + 1]
			result[index + 1] = result[swapIndex + 1]
			result[swapIndex + 1] = current
			index = index - 1
		end
	end
	return result
end
function boss_rubick_sand_3.prototype.GetCastFloorId(self)
	local caster = self:GetCaster()
	local casterTile = self:GetUnitTile(caster)
	if casterTile then
		return casterTile.floorId
	end
	local target = caster:GetMinDistanceUnit(RUBICK_SAND_3_CAST_RANGE)
	local ____IsValidAlive_result_5
	if IsValidAlive(nil, target) then
		local ____opt_3 = self:GetUnitTile(target)
		____IsValidAlive_result_5 = ____opt_3 and ____opt_3.floorId
	else
		____IsValidAlive_result_5 = nil
	end
	return ____IsValidAlive_result_5
end
function boss_rubick_sand_3.prototype.ClearSandstorms(self)
	for ____, particle in ipairs(self.sandstormParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.sandstormParticles = {}
	self.sandstormTiles = {}
end
function boss_rubick_sand_3.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_sand_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_sand_3)
____exports.boss_rubick_sand_3 = boss_rubick_sand_3
return ____exports