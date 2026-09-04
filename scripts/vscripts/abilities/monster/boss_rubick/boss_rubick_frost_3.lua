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
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_FROST_3_CAST_RANGE = 3000
--- 冲刺前直线预警时间。
local RUBICK_FROST_3_CAST_POINT = 0.55
--- 冰雨冲刺距离。
local RUBICK_FROST_3_DASH_DISTANCE = 1200
--- 冰雨冲刺速度。
local RUBICK_FROST_3_DASH_SPEED = 2000
--- 冰雨冲刺持续时间。
local RUBICK_FROST_3_DASH_DURATION = RUBICK_FROST_3_DASH_DISTANCE / RUBICK_FROST_3_DASH_SPEED
--- 冲刺结束后停止动作的表现时间。
local RUBICK_FROST_3_STOP_DURATION = 0.45
--- 冲刺线预警宽度。
local RUBICK_FROST_3_WARNING_WIDTH = 220
--- 冲刺动作。
local RUBICK_FROST_3_DASH_ANIMATION = "rubick_steal_ssroll"
--- 冲刺结束动作，复用原三技能落地停止读法。
local RUBICK_FROST_3_STOP_ANIMATION = "rubick_steal_arm_tail_thump"
--- 冰雨地板持续时间。
local RUBICK_FROST_3_RAIN_DURATION = 3
--- 冰雨地板结算间隔。
local RUBICK_FROST_3_RAIN_TICK_INTERVAL = 0.3
--- 冰雨每次结算造成的持续伤害倍率。
local RUBICK_FROST_3_RAIN_DAMAGE_RATE_PER_TICK = 4
--- 冰雨每次结算施加的冰缓层数。
local RUBICK_FROST_3_RAIN_SLOW_STACK_PER_TICK = 1
--- 冰雨每次结算施加的冰缓持续时间。
local RUBICK_FROST_3_RAIN_SLOW_DURATION = 1
--- 冰雨地板特效。
local RUBICK_FROST_3_RAIN_PARTICLE = "particles/dd/ice_rain_drop_control_core.vpcf"
--- 冰缓状态特效。
local RUBICK_FROST_3_SLOW_STATUS_PARTICLE = "particles/status_fx/status_effect_frost_armor.vpcf"
____exports.boss_rubick_frost_3 = __TS__Class()
local boss_rubick_frost_3 = ____exports.boss_rubick_frost_3
boss_rubick_frost_3.name = "boss_rubick_frost_3"
__TS__ClassExtends(boss_rubick_frost_3, RubickOriginAbility)
function boss_rubick_frost_3.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.dashDirection = Vector(1, 0, 0)
	self.gridDirection = { dx = 1, dy = 0 }
end
function boss_rubick_frost_3.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_FROST_3_RAIN_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_3_SLOW_STATUS_PARTICLE, context)
end
function boss_rubick_frost_3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_FROST_3_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_FROST_3_CAST_POINT,
		castDuration = RUBICK_FROST_3_DASH_DURATION + RUBICK_FROST_3_STOP_DURATION,
		canCast = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(RUBICK_FROST_3_CAST_RANGE)
			if not MyGameDynamicFloor or not IsValidAlive(nil, target) then
				return UF_FAIL_CUSTOM
			end
			local ____temp_0
			if self:GetUnitTile(caster) and self:GetUnitTile(target) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			return self:PrepareIceRainDash()
		end,
		OnStart = function()
			return self:StartIceRainDash(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearRainController()
		end,
	}
end
function boss_rubick_frost_3.prototype.PrepareIceRainDash(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_FROST_3_CAST_RANGE)
	self.castToken = self.castToken + 1
	self.dashEndPosition = nil
	self:ClearRainController()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	local startPos = caster:GetAbsOrigin()
	local rawDirection = target:GetAbsOrigin():__sub(startPos)
	local flatDirection = Vector(rawDirection.x, rawDirection.y, 0)
	local ____temp_1
	if flatDirection:Length2D() > 0.001 then
		____temp_1 = flatDirection:Normalized()
	else
		____temp_1 = self:GetFlatForward(caster)
	end
	self.dashDirection = ____temp_1
	self.gridDirection = self:GetCardinalDirectionFromVector(self.dashDirection)
	self.dashEndPosition = self:GetDashEndPosition(caster, startPos, self.dashDirection)
	caster:LockTargetForSpeed(target, RUBICK_FROST_3_CAST_POINT + RUBICK_FROST_3_DASH_DURATION, 8)
	self:WarningEffect(
		startPos,
		self.dashEndPosition,
		RUBICK_FROST_3_CAST_POINT,
		{ startWidth = RUBICK_FROST_3_WARNING_WIDTH, endWidth = RUBICK_FROST_3_WARNING_WIDTH }
	)
end
function boss_rubick_frost_3.prototype.StartIceRainDash(self, token)
	local caster = self:GetCaster()
	local endPosition = self.dashEndPosition
	if token ~= self.castToken or not IsValidAlive(nil, caster) or not endPosition then
		return
	end
	local controller = self:EnsureRainController()
	caster:SetAnimation(RUBICK_FROST_3_DASH_ANIMATION)
	self:AddRainTilesAroundPosition(caster:GetAbsOrigin(), controller)
	caster:Mover(endPosition, RUBICK_FROST_3_DASH_DURATION, function(____, position)
		if token ~= self.castToken then
			return true
		end
		self:AddRainTilesAroundPosition(position, controller)
		return false
	end, false, true, false, "outQuad")
	SysTimers:CreateTimer(RUBICK_FROST_3_DASH_DURATION, function()
		if token == self.castToken and IsValidAlive(nil, caster) then
			caster:SetAnimation(RUBICK_FROST_3_STOP_ANIMATION)
		end
		return nil
	end)
end
function boss_rubick_frost_3.prototype.AddRainTilesAroundPosition(self, position, controller)
	if not controller then
		return
	end
	local caster = self:GetCaster()
	local ____self_GetPointTile_5 = self.GetPointTile
	local ____position_4 = position
	local ____opt_2 = caster.GetRoomId
	local centerTile = ____self_GetPointTile_5(self, ____position_4, ____opt_2 and ____opt_2(caster))
	if not centerTile or not self:CanUseTile(centerTile) then
		return
	end
	for ____, tile in ipairs(self:SelectRainTiles(centerTile)) do
		controller:AddRainTile(tile)
	end
end
function boss_rubick_frost_3.prototype.SelectRainTiles(self, centerTile)
	local side = { dx = -self.gridDirection.dy, dy = self.gridDirection.dx }
	local back = { dx = -self.gridDirection.dx, dy = -self.gridDirection.dy }
	local offsets = {
		{ dx = 0, dy = 0 },
		side,
		{ dx = -side.dx, dy = -side.dy },
		back,
		{ dx = back.dx + side.dx, dy = back.dy + side.dy },
		{ dx = back.dx - side.dx, dy = back.dy - side.dy },
	}
	local candidates = {}
	for ____, offset in ipairs(offsets) do
		local tile =
			self:GetTileByGrid(centerTile.floorId, centerTile.gridColumn + offset.dx, centerTile.gridRow + offset.dy)
		if tile and self:CanUseTile(tile) then
			candidates[#candidates + 1] = {
				tile = tile,
				roll = RandomFloat(0, 1),
			}
		end
	end
	__TS__ArraySort(candidates, function(____, left, right)
		return left.roll - right.roll
	end)
	return __TS__ArrayMap(__TS__ArraySlice(candidates, 0, math.min(3, #candidates)), function(____, candidate)
		return candidate.tile
	end)
end
function boss_rubick_frost_3.prototype.EnsureRainController(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local controller = ____exports.modifier_boss_rubick_frost_3_ice_rain_controller:find_on(caster)
	if not controller then
		controller = ____exports.modifier_boss_rubick_frost_3_ice_rain_controller:applys(caster, caster, self, {})
	end
	return controller
end
function boss_rubick_frost_3.prototype.ClearRainController(self)
	____exports.modifier_boss_rubick_frost_3_ice_rain_controller:remove(self:GetCaster())
end
function boss_rubick_frost_3.prototype.GetDashEndPosition(self, caster, startPos, direction)
	local targetPos = startPos:__add(direction:__mul(RUBICK_FROST_3_DASH_DISTANCE))
	local groundZ = GetGroundHeight(targetPos, caster) or startPos.z
	return Vector(targetPos.x, targetPos.y, groundZ)
end
function boss_rubick_frost_3.prototype.GetFlatForward(self, unit)
	local forward = unit:GetForwardVector()
	local flat = Vector(forward.x, forward.y, 0)
	if flat:Length2D() > 0.001 then
		return flat:Normalized()
	end
	return Vector(1, 0, 0)
end
function boss_rubick_frost_3.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_frost_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_frost_3)
____exports.boss_rubick_frost_3 = boss_rubick_frost_3
____exports.modifier_boss_rubick_frost_3_ice_rain_controller = __TS__Class()
local modifier_boss_rubick_frost_3_ice_rain_controller = ____exports.modifier_boss_rubick_frost_3_ice_rain_controller
modifier_boss_rubick_frost_3_ice_rain_controller.name = "modifier_boss_rubick_frost_3_ice_rain_controller"
__TS__ClassExtends(modifier_boss_rubick_frost_3_ice_rain_controller, BaseModifier_CS)
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.rainAreas = {}
	self.rainAreaKeys = {}
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(RUBICK_FROST_3_RAIN_TICK_INTERVAL)
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:ClearRainAreas()
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.AddRainTile(self, tile)
	if not IsServer() then
		return
	end
	local tileKey = self:GetTileKey(tile)
	local expireTime = GameRules:GetGameTime() + RUBICK_FROST_3_RAIN_DURATION
	local existing = self.rainAreas[tileKey]
	if existing then
		existing.tile = tile
		existing.expireTime = expireTime
		return
	end
	local particle = ParticleManager:CreateParticle(RUBICK_FROST_3_RAIN_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_FROST_3_RAIN_DURATION, 0, 0))
	ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
	self.rainAreas[tileKey] = { tile = tile, expireTime = expireTime, particle = particle }
	local ____self_rainAreaKeys_6 = self.rainAreaKeys
	____self_rainAreaKeys_6[#____self_rainAreaKeys_6 + 1] = tileKey
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self:RemoveExpiredRainAreas()
	if #self.rainAreaKeys <= 0 then
		self:Destroy()
		return
	end
	self:ApplyRainToRoomPlayers(caster)
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.ApplyRainToRoomPlayers(self, caster)
	if not MyGamePlayers or not MyGameDynamicFloor then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____this_8
	____this_8 = caster
	local ____opt_7 = ____this_8.GetRoomId
	local casterRoomId = ____opt_7 and ____opt_7(____this_8)
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_9 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_9 and ____opt_9:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue50
			end
			local ____casterRoomId_13 = casterRoomId
			if ____casterRoomId_13 then
				local ____opt_11 = hero.GetRoomId
				____casterRoomId_13 = (____opt_11 and ____opt_11(hero)) ~= casterRoomId
			end
			if ____casterRoomId_13 then
				goto __continue50
			end
			local ____MyGameDynamicFloor_17 = MyGameDynamicFloor
			local ____MyGameDynamicFloor_GetTileAtPoint_18 = MyGameDynamicFloor.GetTileAtPoint
			local ____temp_16 = hero:GetAbsOrigin()
			local ____opt_14 = hero.GetRoomId
			local tile = ____MyGameDynamicFloor_GetTileAtPoint_18(
				____MyGameDynamicFloor_17,
				____temp_16,
				____opt_14 and ____opt_14(hero)
			)
			if not tile or not self.rainAreas[self:GetTileKey(tile)] then
				goto __continue50
			end
			AddDeBuffStatus(
				nil,
				hero,
				caster,
				self:GetAbility(),
				DebuffStatusType.ICE_SLOW,
				{
					stack = RUBICK_FROST_3_RAIN_SLOW_STACK_PER_TICK,
					duration = RUBICK_FROST_3_RAIN_SLOW_DURATION,
					status_effect_name = RUBICK_FROST_3_SLOW_STATUS_PARTICLE,
				}
			)
			caster:MonsterDamage({
				victim = hero,
				damage_rate = RUBICK_FROST_3_RAIN_DAMAGE_RATE_PER_TICK,
				ability = self:GetAbility(),
			})
		end
		::__continue50::
	end
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.RemoveExpiredRainAreas(self)
	local now = GameRules:GetGameTime()
	do
		local index = #self.rainAreaKeys - 1
		while index >= 0 do
			do
				local tileKey = self.rainAreaKeys[index + 1]
				local area = self.rainAreas[tileKey]
				if area and now < area.expireTime and self:CanUseTile(area.tile) then
					goto __continue56
				end
				self:RemoveRainArea(tileKey)
			end
			::__continue56::
			index = index - 1
		end
	end
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.RemoveRainArea(self, tileKey)
	self:DestroyRainAreaParticle(self.rainAreas[tileKey])
	__TS__Delete(self.rainAreas, tileKey)
	local index = __TS__ArrayIndexOf(self.rainAreaKeys, tileKey)
	if index ~= -1 then
		__TS__ArraySplice(self.rainAreaKeys, index, 1)
	end
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.ClearRainAreas(self)
	for ____, tileKey in ipairs(self.rainAreaKeys) do
		self:DestroyRainAreaParticle(self.rainAreas[tileKey])
	end
	self.rainAreas = {}
	self.rainAreaKeys = {}
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.DestroyRainAreaParticle(self, area)
	if not area then
		return
	end
	ParticleManager:DestroyParticle(area.particle, false)
	ParticleManager:ReleaseParticleIndex(area.particle)
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. "_") .. tostring(tile.gridColumn)) .. "_") .. tostring(tile.gridRow)
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_frost_3_ice_rain_controller.prototype.IsPurgable(self)
	return false
end
modifier_boss_rubick_frost_3_ice_rain_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_frost_3_ice_rain_controller)
____exports.modifier_boss_rubick_frost_3_ice_rain_controller = modifier_boss_rubick_frost_3_ice_rain_controller
return ____exports