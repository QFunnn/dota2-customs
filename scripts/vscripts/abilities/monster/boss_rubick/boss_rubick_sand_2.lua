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
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_SAND_2_CAST_RANGE = 3000
--- 本次钻地穿刺的循环次数。
local RUBICK_SAND_2_ROUND_COUNT = 3
--- 钻地动作完整持续时间。
local RUBICK_SAND_2_BURROW_ANIMATION_DURATION = 0.97
--- 钻地动作开始后隐藏本体的时间点。
local RUBICK_SAND_2_HIDE_TIME = 0.23
--- 钻入地下后给出的穿刺线预警时间。
local RUBICK_SAND_2_UNDERGROUND_WARNING_DURATION = 0.8
--- 出土动作持续时间。
local RUBICK_SAND_2_EMERGE_DURATION = 0.83
--- 穿刺方块抬升高度。
local RUBICK_SAND_2_STRIKE_LIFT_HEIGHT = 120
--- 穿刺方块抬升动画时长。
local RUBICK_SAND_2_STRIKE_LIFT_DURATION = 0.08
--- 穿刺方块抬升后的保持时间。
local RUBICK_SAND_2_STRIKE_HOLD_DURATION = 0
--- 穿刺方块回落动画时长。
local RUBICK_SAND_2_STRIKE_RELEASE_DURATION = 0.14
--- 穿刺方块依次抬升的间隔。
local RUBICK_SAND_2_TILE_STAGGER_DELAY = 0.025
--- 穿刺线总长度，按动态地板格数计算。
local RUBICK_SAND_2_STRIKE_TILE_DISTANCE = 6
--- 六格为偶数时，玩家格到拉比克出现格的距离。
local RUBICK_SAND_2_STRIKE_DISTANCE_TO_RUBICK = 3
--- 六格为偶数时，玩家格到反方向起始格的距离。
local RUBICK_SAND_2_STRIKE_DISTANCE_FROM_OPPOSITE = RUBICK_SAND_2_STRIKE_TILE_DISTANCE
	- RUBICK_SAND_2_STRIKE_DISTANCE_TO_RUBICK
	- 1
--- 穿刺造成的怪物伤害倍率。
local RUBICK_SAND_2_DAMAGE_RATE = 18
--- 穿刺命中附加眩晕时间。
local RUBICK_SAND_2_STUN_DURATION = 0.9
--- 穿刺命中击飞持续时间。
local RUBICK_SAND_2_KNOCKUP_DURATION = 0.45
--- 穿刺命中击飞高度。
local RUBICK_SAND_2_KNOCKUP_HEIGHT = 160
--- 钻地动作。
local RUBICK_SAND_2_BURROW_ANIMATION = "rubick_steal_skburrowa"
--- 出土动作。
local RUBICK_SAND_2_EMERGE_ANIMATION = "rubick_steal_skburrowb"
--- 播放在目标方块原始地面上的沙漠穿刺材质特效。
local RUBICK_SAND_2_BURROWSTRIKE_TILE_PARTICLE =
	"particles/rebuild/spell/rubick_boss/hd_rubick_boss_burrowstrike/effect_2/effect.vpcf"
--- 沙漠穿刺格子预警特效。
local RUBICK_SAND_2_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_sand/effect.vpcf"
--- 穿刺材质特效覆盖范围比例。
local RUBICK_SAND_2_BURROWSTRIKE_TILE_EFFECT_SCALE = 0.5
--- 单轮钻地、隐藏、出土的总时长。
local RUBICK_SAND_2_ROUND_DURATION = math.max(
	RUBICK_SAND_2_BURROW_ANIMATION_DURATION,
	RUBICK_SAND_2_HIDE_TIME + RUBICK_SAND_2_UNDERGROUND_WARNING_DURATION
) + RUBICK_SAND_2_EMERGE_DURATION
--- 拉比克沙漠技能二：遁地穿刺。
--
-- 技能形态：
-- 1. 播放钻地动作，0.23 秒后隐藏本体。
-- 2. 从目标英雄周围 8 个方向中随机选择一条可用 6 格穿刺线，并在地下阶段显示格子预警。
-- 3. 预警结束后，拉比克出现在预警线一端，立即播放出土动作和穿刺。
-- 4. 整套流程重复多次。
____exports.boss_rubick_sand_2 = __TS__Class()
local boss_rubick_sand_2 = ____exports.boss_rubick_sand_2
boss_rubick_sand_2.name = "boss_rubick_sand_2"
__TS__ClassExtends(boss_rubick_sand_2, RubickOriginAbility)
function boss_rubick_sand_2.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.hidden = false
	self.strikeTileParticles = {}
	self.warningParticles = {}
	self.liftedStrikeTiles = {}
end
function boss_rubick_sand_2.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_SAND_2_BURROWSTRIKE_TILE_PARTICLE, context)
	PrecacheResource("particle", RUBICK_SAND_2_WARNING_PARTICLE, context)
end
function boss_rubick_sand_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_SAND_2_CAST_RANGE,
		castAnimation = "",
		castPoint = 0,
		castDuration = RUBICK_SAND_2_ROUND_DURATION * RUBICK_SAND_2_ROUND_COUNT,
		canCast = function()
			if not MyGameDynamicFloor then
				return UF_FAIL_CUSTOM
			end
			local floorId = self:GetCastFloorId()
			if not floorId then
				return UF_FAIL_CUSTOM
			end
			local ____temp_0
			if #MyGameDynamicFloor:GetAvailableTiles(floorId) > 0 then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnStart = function()
			self.castToken = self.castToken + 1
			self:PrintDebug("OnStart token=" .. tostring(self.castToken))
			self:StartBurrowSequence(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self.strikePlan = nil
			self:ReleaseStrikeTiles(0.1)
			self:ClearStrikeTileParticles()
			self:ClearWarnings()
			self:RestoreRender()
		end,
		OnFinish = function()
			self.strikePlan = nil
			self:ReleaseStrikeTiles(0.1)
			self:ClearStrikeTileParticles()
			self:ClearWarnings()
			self:RestoreRender()
		end,
	}
end
function boss_rubick_sand_2.prototype.StartBurrowSequence(self, token)
	do
		local round = 0
		while round < RUBICK_SAND_2_ROUND_COUNT do
			local roundStartDelay = round * RUBICK_SAND_2_ROUND_DURATION
			SysTimers:CreateTimer(roundStartDelay, function()
				if token ~= self.castToken then
					return nil
				end
				self:StartBurrowRound(token)
				return nil
			end)
			round = round + 1
		end
	end
end
function boss_rubick_sand_2.prototype.StartBurrowRound(self, token)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:PrintDebug("StartBurrowRound 跳过：施法者无效 token=" .. tostring(token))
		return
	end
	self:PrintDebug("StartBurrowRound 开始 token=" .. tostring(token))
	caster:SetAnimation(RUBICK_SAND_2_BURROW_ANIMATION)
	SysTimers:CreateTimer(RUBICK_SAND_2_HIDE_TIME, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			self:PrintDebug(
				(
					("HideAndPrepareStrike 跳过：token失效或施法者无效 timerToken=" .. tostring(token))
					.. " currentToken="
				) .. tostring(self.castToken)
			)
			return nil
		end
		self:HideAndPrepareStrike()
		return nil
	end)
	SysTimers:CreateTimer(RUBICK_SAND_2_HIDE_TIME + RUBICK_SAND_2_UNDERGROUND_WARNING_DURATION, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			self:PrintDebug(
				(
					("EmergeAndStrike 跳过：token失效或施法者无效 timerToken=" .. tostring(token))
					.. " currentToken="
				) .. tostring(self.castToken)
			)
			return nil
		end
		self:EmergeAndStrike()
		return nil
	end)
end
function boss_rubick_sand_2.prototype.HideAndPrepareStrike(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:AddNoDraw()
	self.hidden = true
	local plan = self:CreateStrikePlan()
	self.strikePlan = plan
	if not plan then
		self:PrintDebug("HideAndPrepareStrike 未生成有效穿刺计划")
		return
	end
	local ____self_PrintDebug_3 = self.PrintDebug
	local ____opt_1 = plan.strikeTiles
	____self_PrintDebug_3(
		self,
		"HideAndPrepareStrike 生成穿刺计划 tiles=" .. tostring(____opt_1 and #____opt_1 or 0)
	)
	self:PlayStrikeTileWarnings(plan.strikeTiles or {})
	caster:SetAbsOrigin(plan.appearPos)
	caster:SetForwardVector(plan.appearForward)
	FindClearSpaceForUnit(caster, plan.appearPos, true)
end
function boss_rubick_sand_2.prototype.EmergeAndStrike(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:RestoreRender()
	self:ClearWarnings()
	self:PrintDebug("EmergeAndStrike 执行 strikePlan=" .. (self.strikePlan and "有" or "无"))
	if self.strikePlan then
		caster:SetAbsOrigin(self.strikePlan.appearPos)
		caster:SetForwardVector(self.strikePlan.appearForward)
		FindClearSpaceForUnit(caster, self.strikePlan.appearPos, true)
	end
	caster:SetAnimation(RUBICK_SAND_2_EMERGE_ANIMATION)
	self:FireBurrowstrikeLine()
end
function boss_rubick_sand_2.prototype.FireBurrowstrikeLine(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local plan = self.strikePlan
	local ____self_PrintDebug_8 = self.PrintDebug
	local ____opt_4 = plan and plan.strikeTiles
	____self_PrintDebug_8(self, "FireBurrowstrikeLine 执行 tiles=" .. tostring(____opt_4 and #____opt_4 or 0))
	self:LiftAndPlayStrikeTiles(plan and plan.strikeTiles, self.castToken, plan and plan.targetEntIndex)
	self.strikePlan = nil
end
function boss_rubick_sand_2.prototype.LiftAndPlayStrikeTiles(self, tiles, token, targetEntIndex)
	if not tiles or #tiles <= 0 or not MyGameDynamicFloor then
		self:PrintDebug("LiftAndPlayStrikeTiles 无有效格子 token=" .. tostring(token))
		self:PrintStrikeDebug({}, targetEntIndex, {})
		return
	end
	local sequenceTiles = self:MergeTiles(tiles)
	self:PrintDebug(
		(("LiftAndPlayStrikeTiles 开始序列格子数=" .. tostring(#sequenceTiles)) .. " token=") .. tostring(token)
	)
	local ____self_MergeTiles_14 = self.MergeTiles
	local ____array_13 = __TS__SparseArrayNew(unpack(self.liftedStrikeTiles))
	__TS__SparseArrayPush(____array_13, unpack(sequenceTiles))
	self.liftedStrikeTiles = ____self_MergeTiles_14(self, { __TS__SparseArraySpread(____array_13) })
	do
		local index = 0
		while index < #sequenceTiles do
			local currentIndex = index
			local tile = sequenceTiles[currentIndex + 1]
			local delay = currentIndex * RUBICK_SAND_2_TILE_STAGGER_DELAY
			local isLastTile = currentIndex == #sequenceTiles - 1
			SysTimers:CreateTimer(delay, function()
				if token ~= self.castToken then
					return nil
				end
				self:MoveSingleStrikeTile(
					tile,
					Vector(0, 0, RUBICK_SAND_2_STRIKE_LIFT_HEIGHT),
					RUBICK_SAND_2_STRIKE_LIFT_DURATION,
					"easeOut"
				)
				return nil
			end)
			SysTimers:CreateTimer(delay + RUBICK_SAND_2_STRIKE_LIFT_DURATION, function()
				if token ~= self.castToken then
					return nil
				end
				self:PlayStrikeTileEffects({ tile }, false)
				if isLastTile then
					self:DamageStrikeEnemies(sequenceTiles, targetEntIndex)
				end
				return nil
			end)
			SysTimers:CreateTimer(
				delay + RUBICK_SAND_2_STRIKE_LIFT_DURATION + RUBICK_SAND_2_STRIKE_HOLD_DURATION,
				function()
					if token ~= self.castToken then
						return nil
					end
					self:MoveSingleStrikeTile(tile, Vector(0, 0, 0), RUBICK_SAND_2_STRIKE_RELEASE_DURATION, "easeIn")
					return nil
				end
			)
			index = index + 1
		end
	end
	local totalDuration = math.max(0, #sequenceTiles - 1) * RUBICK_SAND_2_TILE_STAGGER_DELAY
		+ RUBICK_SAND_2_STRIKE_LIFT_DURATION
		+ RUBICK_SAND_2_STRIKE_HOLD_DURATION
		+ RUBICK_SAND_2_STRIKE_RELEASE_DURATION
	SysTimers:CreateTimer(totalDuration, function()
		if token ~= self.castToken then
			return nil
		end
		self:ClearStrikeTileParticles()
		return nil
	end)
end
function boss_rubick_sand_2.prototype.PlayStrikeTileEffects(self, tiles, clearExisting)
	if clearExisting == nil then
		clearExisting = true
	end
	if clearExisting then
		self:ClearStrikeTileParticles()
	end
	for ____, tile in ipairs(tiles) do
		local origin = tile.surfaceOrigin
		local particle =
			ParticleManager:CreateParticle(RUBICK_SAND_2_BURROWSTRIKE_TILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, origin)
		ParticleManager:SetParticleControl(particle, 1, origin)
		ParticleManager:SetParticleControl(
			particle,
			10,
			Vector(
				tile.tileSize * RUBICK_SAND_2_BURROWSTRIKE_TILE_EFFECT_SCALE,
				tile.tileSize * RUBICK_SAND_2_BURROWSTRIKE_TILE_EFFECT_SCALE,
				0
			)
		)
		local ____self_strikeTileParticles_15 = self.strikeTileParticles
		____self_strikeTileParticles_15[#____self_strikeTileParticles_15 + 1] = particle
	end
end
function boss_rubick_sand_2.prototype.ClearStrikeTileParticles(self)
	for ____, particle in ipairs(self.strikeTileParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.strikeTileParticles = {}
end
function boss_rubick_sand_2.prototype.PlayStrikeTileWarnings(self, tiles)
	self:ClearWarnings()
	for ____, tile in ipairs(tiles) do
		local particle = ParticleManager:CreateParticle(RUBICK_SAND_2_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
		ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
		ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_SAND_2_UNDERGROUND_WARNING_DURATION, 0, 0))
		ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
		local ____self_warningParticles_16 = self.warningParticles
		____self_warningParticles_16[#____self_warningParticles_16 + 1] = particle
	end
end
function boss_rubick_sand_2.prototype.ClearWarnings(self)
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
function boss_rubick_sand_2.prototype.ReleaseStrikeTiles(self, duration)
	if #self.liftedStrikeTiles <= 0 or not MyGameDynamicFloor then
		return
	end
	local tiles = self:MergeTiles(self.liftedStrikeTiles)
	MyGameDynamicFloor:MoveTilesToWorldOffsets(tiles[1].floorId, {
		tiles = __TS__ArrayMap(tiles, function(____, tile)
			return {
				gridColumn = tile.gridColumn,
				gridRow = tile.gridRow,
				offset = Vector(0, 0, 0),
			}
		end),
		duration = duration,
		motion = "easeIn",
	})
	self.liftedStrikeTiles = {}
end
function boss_rubick_sand_2.prototype.DamageStrikeEnemies(self, tiles, targetEntIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = self:FindEnemyUnitsOnTiles(tiles)
	self:PrintDebug((("DamageStrikeEnemies 执行 tiles=" .. tostring(#tiles)) .. " enemies=") .. tostring(#enemies))
	self:PrintStrikeDebug(tiles, targetEntIndex, enemies)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue58
			end
			self:ApplyStrikeHit(caster, enemy)
		end
		::__continue58::
	end
end
function boss_rubick_sand_2.prototype.ApplyStrikeHit(self, caster, enemy)
	if not IsValidAlive(nil, enemy) then
		return
	end
	caster:MonsterDamage({ victim = enemy, damage_rate = RUBICK_SAND_2_DAMAGE_RATE, ability = self })
	enemy:KnockBack(caster, self, {
		duration = RUBICK_SAND_2_KNOCKUP_DURATION,
		distance = 1,
		height = RUBICK_SAND_2_KNOCKUP_HEIGHT,
		direction = Vector(0, 0, 0),
		heightType = "parabola",
		stun = true,
		stunDuration = RUBICK_SAND_2_STUN_DURATION,
		block = false,
		ignore_walls = 1,
		removeOnDeath = true,
	})
end
function boss_rubick_sand_2.prototype.CreateStrikePlan(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not MyGameDynamicFloor then
		return nil
	end
	local target = caster:GetMinDistanceUnit(RUBICK_SAND_2_CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return nil
	end
	local targetTile = self:GetUnitTile(target)
	if targetTile then
		local candidates = self:GetShuffledStrikeDirections()
		for ____, direction in ipairs(candidates) do
			do
				local strikeTiles = self:GetStrikeTilesFromDirection(targetTile, direction)
				if #strikeTiles ~= RUBICK_SAND_2_STRIKE_TILE_DISTANCE then
					goto __continue67
				end
				local startTile = strikeTiles[1]
				local endTile = strikeTiles[#strikeTiles]
				return {
					startPos = self:GetTileGroundPosition(startTile, caster),
					endPos = self:GetTileGroundPosition(endTile, caster),
					appearPos = self:GetTileGroundPosition(endTile, caster),
					appearForward = Vector(-direction.dx, -direction.dy, 0),
					targetEntIndex = target:GetEntityIndex(),
					strikeTiles = strikeTiles,
				}
			end
			::__continue67::
		end
	end
	return self:CreateWorldFallbackStrikePlan(caster, target)
end
function boss_rubick_sand_2.prototype.RestoreRender(self)
	local caster = self:GetCaster()
	if not self.hidden or not IsValid(nil, caster) then
		return
	end
	caster:RemoveNoDraw()
	self.hidden = false
end
function boss_rubick_sand_2.prototype.GetShuffledStrikeDirections(self)
	local directions = {
		{ dx = 1, dy = 0 },
		{ dx = -1, dy = 0 },
		{ dx = 0, dy = 1 },
		{ dx = 0, dy = -1 },
		{ dx = 1, dy = 1 },
		{ dx = 1, dy = -1 },
		{ dx = -1, dy = 1 },
		{ dx = -1, dy = -1 },
	}
	do
		local index = #directions - 1
		while index > 0 do
			local swapIndex = RandomInt(0, index)
			local current = directions[index + 1]
			directions[index + 1] = directions[swapIndex + 1]
			directions[swapIndex + 1] = current
			index = index - 1
		end
	end
	return directions
end
function boss_rubick_sand_2.prototype.GetStrikeTilesFromDirection(self, targetTile, direction)
	local tiles = {}
	do
		local distance = -RUBICK_SAND_2_STRIKE_DISTANCE_FROM_OPPOSITE
		while distance <= RUBICK_SAND_2_STRIKE_DISTANCE_TO_RUBICK do
			local tile = self:GetTileByGrid(
				targetTile.floorId,
				targetTile.gridColumn + direction.dx * distance,
				targetTile.gridRow + direction.dy * distance
			)
			if not tile or not self:CanUseTile(tile) then
				return {}
			end
			tiles[#tiles + 1] = tile
			distance = distance + 1
		end
	end
	return tiles
end
function boss_rubick_sand_2.prototype.CreateWorldFallbackStrikePlan(self, caster, target)
	local direction = self:GetShuffledStrikeDirections()[1]
	if not IsValidAlive(nil, target) then
		return
	end
	local targetTile = self:GetUnitTile(target)
	local ____temp_21 = targetTile and targetTile.tileSize
	if ____temp_21 == nil then
		local ____opt_19 = self:GetUnitTile(caster)
		____temp_21 = ____opt_19 and ____opt_19.tileSize
	end
	local tileSize = ____temp_21 or 512
	local appearForward = Vector(-direction.dx, -direction.dy, 0)
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), caster)
	local directionVector = Vector(direction.dx, direction.dy, 0)
	local startPos = GetGroundPosition(
		targetOrigin:__sub(directionVector:__mul(tileSize * RUBICK_SAND_2_STRIKE_DISTANCE_FROM_OPPOSITE)),
		caster
	)
	local endPos = GetGroundPosition(
		targetOrigin:__add(directionVector:__mul(tileSize * RUBICK_SAND_2_STRIKE_DISTANCE_TO_RUBICK)),
		caster
	)
	return {
		startPos = startPos,
		endPos = endPos,
		appearPos = endPos,
		appearForward = appearForward,
		targetEntIndex = target:GetEntityIndex(),
	}
end
function boss_rubick_sand_2.prototype.PrintStrikeDebug(self, tiles, targetEntIndex, enemies)
	local target = self:GetStrikeDebugTarget(targetEntIndex)
	local tileText = table.concat(
		__TS__ArrayMap(tiles, function(____, tile, index)
			local origin = tile.surfaceOrigin
			return (
				(
					(
						(
							(
								(((tostring(index + 1) .. ":grid(") .. tostring(tile.gridColumn)) .. ",")
								.. tostring(tile.gridRow)
							) .. ") xy("
						) .. tostring(math.floor(origin.x))
					) .. ","
				) .. tostring(math.floor(origin.y))
			) .. ")"
		end),
		" | "
	)
	local ____IsValidAlive_result_22
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_22 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_22 = nil
	end
	local targetOrigin = ____IsValidAlive_result_22
	local ____targetOrigin_23
	if targetOrigin then
		____targetOrigin_23 = (
			(("xy(" .. tostring(math.floor(targetOrigin.x))) .. ",") .. tostring(math.floor(targetOrigin.y))
		) .. ")"
	else
		____targetOrigin_23 = "无有效目标"
	end
	local targetText = ____targetOrigin_23
	local hitTarget = IsValidAlive(nil, target)
		and __TS__ArraySome(enemies, function(____, enemy)
			return IsValidAlive(nil, enemy) and enemy:GetEntityIndex() == target:GetEntityIndex()
		end)
	print("[RubickSand2] 本轮6格: " .. (tileText or "无有效格子"))
	print("[RubickSand2] 目标英雄位置: " .. targetText)
	print("[RubickSand2] 是否伤害到目标英雄: " .. (hitTarget and "是" or "否"))
end
function boss_rubick_sand_2.prototype.PrintDebug(self, message)
	print("[RubickSand2] " .. message)
end
function boss_rubick_sand_2.prototype.GetStrikeDebugTarget(self, targetEntIndex)
	local ____temp_24
	if targetEntIndex ~= nil then
		____temp_24 = EntIndexToHScript(targetEntIndex)
	else
		____temp_24 = nil
	end
	local target = ____temp_24
	if IsValidAlive(nil, target) then
		return target
	end
	local caster = self:GetCaster()
	local ____IsValidAlive_result_25
	if IsValidAlive(nil, caster) then
		____IsValidAlive_result_25 = caster:GetMinDistanceUnit(RUBICK_SAND_2_CAST_RANGE)
	else
		____IsValidAlive_result_25 = nil
	end
	return ____IsValidAlive_result_25
end
function boss_rubick_sand_2.prototype.MergeTiles(self, tiles)
	local result = {}
	for ____, tile in ipairs(tiles) do
		if not __TS__ArraySome(result, function(____, existing)
			return self:IsSameTile(existing, tile)
		end) then
			result[#result + 1] = tile
		end
	end
	return result
end
function boss_rubick_sand_2.prototype.GetCastFloorId(self)
	local caster = self:GetCaster()
	local casterTile = self:GetUnitTile(caster)
	if casterTile then
		return casterTile.floorId
	end
	local target = caster:GetMinDistanceUnit(RUBICK_SAND_2_CAST_RANGE)
	local ____IsValidAlive_result_28
	if IsValidAlive(nil, target) then
		local ____opt_26 = self:GetUnitTile(target)
		____IsValidAlive_result_28 = ____opt_26 and ____opt_26.floorId
	else
		____IsValidAlive_result_28 = nil
	end
	return ____IsValidAlive_result_28
end
function boss_rubick_sand_2.prototype.GetTileGroundPosition(self, tile, caster)
	return GetGroundPosition(Vector(tile.origin.x, tile.origin.y, tile.origin.z), caster)
end
function boss_rubick_sand_2.prototype.MoveSingleStrikeTile(self, tile, offset, duration, motion)
	if not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(
		tile.floorId,
		{
			tiles = { { gridColumn = tile.gridColumn, gridRow = tile.gridRow, offset = offset } },
			duration = duration,
			motion = motion,
		}
	)
end
function boss_rubick_sand_2.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_sand_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_sand_2)
____exports.boss_rubick_sand_2 = boss_rubick_sand_2
return ____exports