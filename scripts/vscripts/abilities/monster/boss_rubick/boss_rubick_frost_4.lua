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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_FROST_4_CAST_RANGE = 3000
--- 主动释放时的短前摇。
local RUBICK_FROST_4_CAST_POINT = 0.25
--- 雪阶段固定冰柱数量。
local RUBICK_FROST_4_SPIRE_COUNT = 4
--- 冰柱距离当前可用区域边缘的格数。
local RUBICK_FROST_4_CORNER_INSET = 2
--- 冰柱周围寒冷地板结算间隔。
local RUBICK_FROST_4_COLD_TICK_INTERVAL = 0.35
--- 寒冷地板施加的冰缓层数。
local RUBICK_FROST_4_COLD_SLOW_STACK = 1
--- 寒冷地板施加的冰缓持续时间。
local RUBICK_FROST_4_COLD_SLOW_DURATION = 1
--- 弹射冰球移动速度。
local RUBICK_FROST_4_BOUNCE_SPEED = 600
--- 弹射冰球碰撞伤害范围。
local RUBICK_FROST_4_BOUNCE_HIT_RADIUS = 75
--- 弹射冰球每次命中的伤害倍率。
local RUBICK_FROST_4_BOUNCE_DAMAGE_RATE = 14
--- 弹射冰球命中施加的冰缓层数。
local RUBICK_FROST_4_BOUNCE_SLOW_STACK = 3
--- 弹射冰球命中施加的冰缓持续时间。
local RUBICK_FROST_4_BOUNCE_SLOW_DURATION = 1.6
--- 弹射冰球离地高度。
local RUBICK_FROST_4_BOUNCE_HEIGHT = 128
--- 冰柱 thinker 相对地板表面的显示高度。
local RUBICK_FROST_4_SPIRE_VISUAL_HEIGHT = 32
--- 冰柱模型，复用原生巫妖冰柱。
local RUBICK_FROST_4_SPIRE_MODEL = "models/heroes/lich/ice_spire.vmdl"
--- 专属冰柱飞雪特效。
local RUBICK_FROST_4_SPIRE_PARTICLE =
	"particles/rebuild/spell/rubick_boss/hd_rubick_boss_ice_spire/effect_main/effect.vpcf"
--- 连环霜冻冰球特效。
local RUBICK_FROST_4_BOUNCE_PARTICLE = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"
--- 冰缓状态特效。
local RUBICK_FROST_4_SLOW_STATUS_PARTICLE = "particles/status_fx/status_effect_frost_armor.vpcf"
____exports.boss_rubick_frost_4 = __TS__Class()
local boss_rubick_frost_4 = ____exports.boss_rubick_frost_4
boss_rubick_frost_4.name = "boss_rubick_frost_4"
__TS__ClassExtends(boss_rubick_frost_4, RubickOriginAbility)
function boss_rubick_frost_4.prototype.Spawn(self)
	RubickOriginAbility.prototype.Spawn(self)
	self:ScheduleSnowPhaseSync()
end
function boss_rubick_frost_4.prototype.OnUpgrade(self)
	self:ScheduleSnowPhaseSync()
end
function boss_rubick_frost_4.prototype.Precache(self, context)
	PrecacheResource("model", RUBICK_FROST_4_SPIRE_MODEL, context)
	PrecacheResource("particle", RUBICK_FROST_4_SPIRE_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_4_BOUNCE_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_4_SLOW_STATUS_PARTICLE, context)
end
function boss_rubick_frost_4.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_rubick_frost_4_listener"
end
function boss_rubick_frost_4.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_FROST_4_CAST_RANGE,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		castPoint = RUBICK_FROST_4_CAST_POINT,
		castDuration = 0.3,
		canCast = function()
			local controller = ____exports.modifier_boss_rubick_frost_4_spire_controller:find_on(self:GetCaster())
			local ____temp_0
			if controller and controller:GetSpireCount() >= 2 then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnStart = function()
			local ____opt_1 = ____exports.modifier_boss_rubick_frost_4_spire_controller:find_on(self:GetCaster())
			if ____opt_1 ~= nil then
				____opt_1:LaunchBounceProjectile()
			end
		end,
	}
end
function boss_rubick_frost_4.prototype.OnRubickBossPhaseChanged(self, phaseId, floorId, playerIds)
	local caster = self:GetCaster()
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	if phaseId == "snow" and floorId then
		self:EnsureSpireController():InitializeForPhase(floorId, playerIds)
		return
	end
	____exports.modifier_boss_rubick_frost_4_spire_controller:remove(caster)
end
function boss_rubick_frost_4.prototype.EnsureSpireController(self)
	local caster = self:GetCaster()
	local controller = ____exports.modifier_boss_rubick_frost_4_spire_controller:find_on(caster)
	if not controller then
		controller = ____exports.modifier_boss_rubick_frost_4_spire_controller:applys(caster, caster, self, {})
	end
	return controller
end
function boss_rubick_frost_4.prototype.ScheduleSnowPhaseSync(self)
	if not IsServer() then
		return
	end
	for ____, delay in ipairs({
		FrameTime(),
		0.1,
		0.35,
	}) do
		Timers:CreateTimer(delay, function()
			if not IsValid(nil, self) or self:IsNull() then
				return nil
			end
			self:SyncCurrentSnowPhase()
			return nil
		end)
	end
end
function boss_rubick_frost_4.prototype.SyncCurrentSnowPhase(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not MyGameDynamicFloor or not MyGameRubickBossEnvironment then
		return
	end
	local ____MyGameDynamicFloor_6 = MyGameDynamicFloor
	local ____MyGameDynamicFloor_GetTileAtPoint_7 = MyGameDynamicFloor.GetTileAtPoint
	local ____temp_5 = caster:GetAbsOrigin()
	local ____opt_3 = caster.GetRoomId
	local tile =
		____MyGameDynamicFloor_GetTileAtPoint_7(____MyGameDynamicFloor_6, ____temp_5, ____opt_3 and ____opt_3(caster))
	if not tile or MyGameRubickBossEnvironment:GetCurrentPhase(tile.floorId) ~= "snow" then
		return
	end
	self:EnsureSpireController():InitializeForPhase(tile.floorId, self:FindRoomPlayerIds(caster))
end
function boss_rubick_frost_4.prototype.FindRoomPlayerIds(self, caster)
	local result = {}
	if not MyGamePlayers or not MyGameRoomManager then
		return result
	end
	local ____this_9
	____this_9 = caster
	local ____opt_8 = ____this_9.GetRoomId
	local roomId = ____opt_8 and ____opt_8(____this_9)
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_10 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_10 and ____opt_10:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue25
			end
			local ____opt_12 = MyGameRoomManager:GetPlayerRoom(playerId)
			local playerRoomId = ____opt_12 and ____opt_12:GetRoomId()
			if roomId and playerRoomId and playerRoomId ~= roomId then
				goto __continue25
			end
			result[#result + 1] = playerId
		end
		::__continue25::
	end
	return result
end
boss_rubick_frost_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_frost_4)
____exports.boss_rubick_frost_4 = boss_rubick_frost_4
____exports.modifier_boss_rubick_frost_4_listener = __TS__Class()
local modifier_boss_rubick_frost_4_listener = ____exports.modifier_boss_rubick_frost_4_listener
modifier_boss_rubick_frost_4_listener.name = "modifier_boss_rubick_frost_4_listener"
__TS__ClassExtends(modifier_boss_rubick_frost_4_listener, BaseModifier_CS)
function modifier_boss_rubick_frost_4_listener.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:InitializeEvents()
	self:Timer(0.03, function()
		self:SyncCurrentSnowPhase()
	end)
end
function modifier_boss_rubick_frost_4_listener.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:UnregisterAllEvents()
end
function modifier_boss_rubick_frost_4_listener.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_RUBICK_BOSS_PHASE_CHANGED, target = { scope = "global" } } }
end
function modifier_boss_rubick_frost_4_listener.prototype.OnRubickBossPhaseChanged_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or event.caster ~= parent:entindex() then
		return
	end
	if event.phaseId == "snow" then
		self:EnsureController():InitializeForPhase(event.floorId, event.playerIds)
		return
	end
	____exports.modifier_boss_rubick_frost_4_spire_controller:remove(parent)
end
function modifier_boss_rubick_frost_4_listener.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_frost_4_listener.prototype.IsPurgable(self)
	return false
end
function modifier_boss_rubick_frost_4_listener.prototype.SyncCurrentSnowPhase(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not MyGameDynamicFloor or not MyGameRubickBossEnvironment then
		return
	end
	local ____MyGameDynamicFloor_17 = MyGameDynamicFloor
	local ____MyGameDynamicFloor_GetTileAtPoint_18 = MyGameDynamicFloor.GetTileAtPoint
	local ____temp_16 = parent:GetAbsOrigin()
	local ____opt_14 = parent.GetRoomId
	local tile = ____MyGameDynamicFloor_GetTileAtPoint_18(
		____MyGameDynamicFloor_17,
		____temp_16,
		____opt_14 and ____opt_14(parent)
	)
	if not tile or MyGameRubickBossEnvironment:GetCurrentPhase(tile.floorId) ~= "snow" then
		return
	end
	self:EnsureController():InitializeForPhase(tile.floorId, self:FindRoomPlayerIds(parent))
end
function modifier_boss_rubick_frost_4_listener.prototype.EnsureController(self)
	local parent = self:GetParent()
	local controller = ____exports.modifier_boss_rubick_frost_4_spire_controller:find_on(parent)
	if not controller then
		controller =
			____exports.modifier_boss_rubick_frost_4_spire_controller:applys(parent, parent, self:GetAbility(), {})
	end
	return controller
end
function modifier_boss_rubick_frost_4_listener.prototype.FindRoomPlayerIds(self, parent)
	local result = {}
	if not MyGamePlayers or not MyGameRoomManager then
		return result
	end
	if not IsValidAlive(nil, parent) then
		return result
	end
	local ____this_20
	____this_20 = parent
	local ____opt_19 = ____this_20.GetRoomId
	local roomId = ____opt_19 and ____opt_19(____this_20)
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_21 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_21 and ____opt_21:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue49
			end
			local ____opt_23 = MyGameRoomManager:GetPlayerRoom(playerId)
			local playerRoomId = ____opt_23 and ____opt_23:GetRoomId()
			if roomId and playerRoomId and playerRoomId ~= roomId then
				goto __continue49
			end
			result[#result + 1] = playerId
		end
		::__continue49::
	end
	return result
end
modifier_boss_rubick_frost_4_listener =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_frost_4_listener)
____exports.modifier_boss_rubick_frost_4_listener = modifier_boss_rubick_frost_4_listener
____exports.modifier_boss_rubick_frost_4_spire_controller = __TS__Class()
local modifier_boss_rubick_frost_4_spire_controller = ____exports.modifier_boss_rubick_frost_4_spire_controller
modifier_boss_rubick_frost_4_spire_controller.name = "modifier_boss_rubick_frost_4_spire_controller"
__TS__ClassExtends(modifier_boss_rubick_frost_4_spire_controller, BaseModifier_CS)
function modifier_boss_rubick_frost_4_spire_controller.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.playerIds = {}
	self.spires = {}
	self.coldTiles = {}
	self.coldTileKeys = {}
	self.bounceGeneration = 0
	self.nextSpireId = 1
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:InitializeEvents()
	self:StartIntervalThink(RUBICK_FROST_4_COLD_TICK_INTERVAL)
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:UnregisterAllEvents()
	self:ClearBounces()
	self:ClearSpires()
	self.coldTiles = {}
	self.coldTileKeys = {}
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_RUBICK_BOSS_PHASE_CHANGED, target = { scope = "global" } } }
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.OnRubickBossPhaseChanged_CS(self, event)
	local parent = self:GetParent()
	if not IsServer() or not IsValidAlive(nil, parent) or event.caster ~= parent:entindex() then
		return
	end
	if event.phaseId ~= "snow" then
		self:Destroy()
		return
	end
	self:InitializeForPhase(event.floorId, event.playerIds)
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.InitializeForPhase(self, floorId, playerIds)
	if not IsServer() then
		return
	end
	if self.floorId == floorId and #self.spires > 0 then
		self.playerIds = { unpack(playerIds) }
		return
	end
	self.floorId = floorId
	self.playerIds = { unpack(playerIds) }
	self:ClearBounces()
	self:ClearSpires()
	self:SpawnSpires(floorId)
	self:RebuildColdTiles()
	self:LaunchBounceProjectile()
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.GetSpireCount(self)
	return #self:GetActiveSpires()
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.LaunchBounceProjectile(self)
	if not IsServer() then
		return
	end
	local spires = self:GetActiveSpires()
	if #spires < 2 then
		return
	end
	local fromIndex = RandomInt(0, #spires - 1)
	local toIndex = RandomInt(0, #spires - 1)
	if toIndex == fromIndex then
		toIndex = (toIndex + 1) % #spires
	end
	local from = self:GetBounceOrigin(spires[fromIndex + 1])
	self:LaunchBounceSegment(self.bounceGeneration, from, toIndex)
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not self.floorId or #self:GetActiveSpires() <= 0 then
		self:Destroy()
		return
	end
	self:ApplyColdTiles(caster)
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.IsPurgable(self)
	return false
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.SpawnSpires(self, floorId)
	if not MyGameDynamicFloor then
		return
	end
	local selected = self:SelectCornerTiles(floorId)
	for ____, tile in ipairs(selected) do
		self:CreateSpire(tile)
	end
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.SelectCornerTiles(self, floorId)
	if not MyGameDynamicFloor then
		return {}
	end
	local bounds = MyGameDynamicFloor:GetPlayableBounds(floorId)
	if
		not bounds.exists
		or bounds.minColumn == nil
		or bounds.maxColumn == nil
		or bounds.minRow == nil
		or bounds.maxRow == nil
	then
		return __TS__ArraySlice(
			__TS__ArrayFilter(MyGameDynamicFloor:GetAvailableTiles(floorId), function(____, tile)
				return self:CanUseTile(tile)
			end),
			0,
			RUBICK_FROST_4_SPIRE_COUNT
		)
	end
	local minColumn = math.min(bounds.minColumn + RUBICK_FROST_4_CORNER_INSET, bounds.maxColumn)
	local maxColumn = math.max(bounds.maxColumn - RUBICK_FROST_4_CORNER_INSET, bounds.minColumn)
	local minRow = math.min(bounds.minRow + RUBICK_FROST_4_CORNER_INSET, bounds.maxRow)
	local maxRow = math.max(bounds.maxRow - RUBICK_FROST_4_CORNER_INSET, bounds.minRow)
	local corners = {
		{ column = minColumn, row = minRow },
		{ column = maxColumn, row = minRow },
		{ column = minColumn, row = maxRow },
		{ column = maxColumn, row = maxRow },
	}
	local selected = {}
	local selectedKeys = {}
	for ____, corner in ipairs(corners) do
		do
			local tile = self:ResolveCornerTile(floorId, corner.column, corner.row)
			if not tile then
				goto __continue82
			end
			local key = self:GetTileKey(tile)
			if selectedKeys[key] then
				goto __continue82
			end
			selectedKeys[key] = true
			selected[#selected + 1] = tile
		end
		::__continue82::
	end
	return selected
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.ResolveCornerTile(self, floorId, column, row)
	if not MyGameDynamicFloor then
		return nil
	end
	local tile = MyGameDynamicFloor:GetTileByGrid(floorId, column, row)
	if tile and self:CanUseTile(tile) then
		return tile
	end
	local result = MyGameDynamicFloor:FindAvailableTileAround(floorId, column, row, RUBICK_FROST_4_CORNER_INSET + 2)
	if result.success and result.tile and self:CanUseTile(result.tile) then
		return result.tile
	end
	return nil
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.CreateSpire(self, tile)
	local caster = self:GetParent()
	local origin = tile.surfaceOrigin:__add(Vector(0, 0, RUBICK_FROST_4_SPIRE_VISUAL_HEIGHT))
	local thinker = CreateModifierThinker(
		caster,
		self:GetAbility(),
		"modifier_boss_rubick_frost_4_spire_thinker",
		{ radius = tile.radius },
		origin,
		caster:GetTeamNumber(),
		false
	)
	local ____self_spires_28 = self.spires
	local ____self_25, ____nextSpireId_26 = self, "nextSpireId"
	local ____self_nextSpireId_27 = ____self_25[____nextSpireId_26]
	____self_25[____nextSpireId_26] = ____self_nextSpireId_27 + 1
	____self_spires_28[#____self_spires_28 + 1] =
		{ id = ____self_nextSpireId_27, tile = tile, thinker = thinker, origin = origin }
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.RebuildColdTiles(self)
	self.coldTiles = {}
	self.coldTileKeys = {}
	if not MyGameDynamicFloor then
		return
	end
	for ____, spire in ipairs(self.spires) do
		do
			local dx = -1
			while dx <= 1 do
				do
					local dy = -1
					while dy <= 1 do
						do
							local tile = MyGameDynamicFloor:GetTileByGrid(
								spire.tile.floorId,
								spire.tile.gridColumn + dx,
								spire.tile.gridRow + dy
							)
							if not tile or not self:CanUseTile(tile) then
								goto __continue95
							end
							local key = self:GetTileKey(tile)
							if not self.coldTiles[key] then
								self.coldTiles[key] = tile
								local ____self_coldTileKeys_29 = self.coldTileKeys
								____self_coldTileKeys_29[#____self_coldTileKeys_29 + 1] = key
							end
						end
						::__continue95::
						dy = dy + 1
					end
				end
				dx = dx + 1
			end
		end
	end
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.ApplyColdTiles(self, caster)
	if not MyGamePlayers or not MyGameDynamicFloor then
		return
	end
	local ____temp_30
	if #self.playerIds > 0 then
		____temp_30 = self.playerIds
	else
		____temp_30 = MyGamePlayers:getAllPlayerIds()
	end
	local targetPlayerIds = ____temp_30
	for ____, playerId in ipairs(targetPlayerIds) do
		do
			local ____opt_31 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_31 and ____opt_31:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue101
			end
			local ____MyGameDynamicFloor_36 = MyGameDynamicFloor
			local ____MyGameDynamicFloor_GetTileAtPoint_37 = MyGameDynamicFloor.GetTileAtPoint
			local ____temp_35 = hero:GetAbsOrigin()
			local ____opt_33 = hero.GetRoomId
			local tile = ____MyGameDynamicFloor_GetTileAtPoint_37(
				____MyGameDynamicFloor_36,
				____temp_35,
				____opt_33 and ____opt_33(hero)
			)
			if not tile or not self.coldTiles[self:GetTileKey(tile)] then
				goto __continue101
			end
			AddDeBuffStatus(
				nil,
				hero,
				caster,
				self:GetAbility(),
				DebuffStatusType.ICE_SLOW,
				{
					stack = RUBICK_FROST_4_COLD_SLOW_STACK,
					duration = RUBICK_FROST_4_COLD_SLOW_DURATION,
					status_effect_name = RUBICK_FROST_4_SLOW_STATUS_PARTICLE,
				}
			)
		end
		::__continue101::
	end
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.LaunchBounceSegment(self, generation, start, toIndex)
	local spires = self:GetActiveSpires()
	local toSpire = spires[toIndex + 1]
	if
		not self:IsBounceGenerationValid(generation)
		or not toSpire
		or not IsValid(nil, toSpire.thinker)
		or toSpire.thinker:IsNull()
	then
		return
	end
	local hitTargets = {}
	CreateProjectile(nil, {
		caster = self:GetParent(),
		ability = self:GetAbility(),
		effect_name = RUBICK_FROST_4_BOUNCE_PARTICLE,
		projectile_type = "tracking",
		projectile_speed = RUBICK_FROST_4_BOUNCE_SPEED,
		start_point = start + Vector(0, 0, 75),
		target = toSpire.thinker,
		on_think = function(____, location)
			if not self:IsBounceGenerationValid(generation) then
				return true
			end
			self:DamageUnitsNearBounce(location, hitTargets)
			return false
		end,
		on_hit = function()
			if not self:IsBounceGenerationValid(generation) then
				return true
			end
			local latestSpires = self:GetActiveSpires()
			if #latestSpires < 2 then
				return true
			end
			local currentIndex = self:FindSpireIndex(latestSpires, toSpire.id)
			if currentIndex < 0 then
				return true
			end
			local nextIndex = self:PickNextSpireIndex(latestSpires, currentIndex)
			local nextStart = self:GetBounceOrigin(latestSpires[currentIndex + 1])
			self:LaunchBounceSegment(generation, nextStart, nextIndex)
			return true
		end,
	})
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.DamageUnitsNearBounce(self, position, hitTargets)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		RUBICK_FROST_4_BOUNCE_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue115
			end
			local id = enemy:entindex()
			if hitTargets[id] then
				goto __continue115
			end
			hitTargets[id] = true
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = RUBICK_FROST_4_BOUNCE_DAMAGE_RATE,
				ability = self:GetAbility(),
			})
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self:GetAbility(),
				DebuffStatusType.ICE_SLOW,
				{
					stack = RUBICK_FROST_4_BOUNCE_SLOW_STACK,
					duration = RUBICK_FROST_4_BOUNCE_SLOW_DURATION,
					status_effect_name = RUBICK_FROST_4_SLOW_STATUS_PARTICLE,
				}
			)
		end
		::__continue115::
	end
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.PickNextSpireIndex(self, spires, currentIndex)
	if #spires <= 1 then
		return currentIndex
	end
	local nextIndex = RandomInt(0, #spires - 1)
	if nextIndex == currentIndex then
		nextIndex = (nextIndex + 1) % #spires
	end
	return nextIndex
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.FindSpireIndex(self, spires, spireId)
	do
		local index = 0
		while index < #spires do
			if spires[index + 1].id == spireId then
				return index
			end
			index = index + 1
		end
	end
	return -1
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.GetActiveSpires(self)
	self.spires = __TS__ArrayFilter(self.spires, function(____, spire)
		return spire.thinker
			and IsValid(nil, spire.thinker)
			and not spire.thinker:IsNull()
			and self:CanUseTile(spire.tile)
	end)
	return self.spires
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.ClearSpires(self)
	for ____, spire in ipairs(self.spires) do
		if spire.thinker and IsValid(nil, spire.thinker) and not spire.thinker:IsNull() then
			spire.thinker:RemoveSelf()
		end
	end
	self.spires = {}
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.ClearBounces(self)
	self.bounceGeneration = self.bounceGeneration + 1
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.IsBounceGenerationValid(self, generation)
	if generation ~= self.bounceGeneration then
		return false
	end
	return IsValidAlive(nil, self:GetCaster()) and #self:GetActiveSpires() >= 2
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.GetBounceOrigin(self, spire)
	return spire.origin:__add(Vector(0, 0, RUBICK_FROST_4_BOUNCE_HEIGHT))
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
function modifier_boss_rubick_frost_4_spire_controller.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. "_") .. tostring(tile.gridColumn)) .. "_") .. tostring(tile.gridRow)
end
modifier_boss_rubick_frost_4_spire_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_frost_4_spire_controller)
____exports.modifier_boss_rubick_frost_4_spire_controller = modifier_boss_rubick_frost_4_spire_controller
____exports.modifier_boss_rubick_frost_4_spire_thinker = __TS__Class()
local modifier_boss_rubick_frost_4_spire_thinker = ____exports.modifier_boss_rubick_frost_4_spire_thinker
modifier_boss_rubick_frost_4_spire_thinker.name = "modifier_boss_rubick_frost_4_spire_thinker"
__TS__ClassExtends(modifier_boss_rubick_frost_4_spire_thinker, BaseModifier_CS)
function modifier_boss_rubick_frost_4_spire_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:SetOriginalModel(RUBICK_FROST_4_SPIRE_MODEL)
	parent:SetModelScale(0.6)
	self:Timer(FrameTime(), function()
		if IsValid(nil, parent) then
			if not IsValidAlive(nil, parent) then
				return
			end
			parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
		end
	end)
	local particle = ParticleManager:CreateParticle(RUBICK_FROST_4_SPIRE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	local radius = params.radius or 128
	ParticleManager:SetParticleControl(particle, 5, Vector(radius, radius, radius))
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_boss_rubick_frost_4_spire_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_boss_rubick_frost_4_spire_thinker.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_frost_4_spire_thinker.prototype.IsPurgable(self)
	return false
end
modifier_boss_rubick_frost_4_spire_thinker =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_frost_4_spire_thinker)
____exports.modifier_boss_rubick_frost_4_spire_thinker = modifier_boss_rubick_frost_4_spire_thinker
return ____exports