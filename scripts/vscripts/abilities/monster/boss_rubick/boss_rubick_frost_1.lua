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
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__Delete = ____lualib.__TS__Delete
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
local RUBICK_FROST_1_CAST_RANGE = 3000
--- 埋设冰霜陷阱前摇。
local RUBICK_FROST_1_CAST_POINT = 0.65
--- 埋设动作结束后的短暂停留。
local RUBICK_FROST_1_CAST_DURATION = 0.35
--- 每次释放新增的陷阱数量。
local RUBICK_FROST_1_TRAP_COUNT_PER_CAST = 5
--- 陷阱检测间隔。
local RUBICK_FROST_1_TRAP_THINK_INTERVAL = 0.1
--- 陷阱触发范围额外扩张。
local RUBICK_FROST_1_TRIGGER_RADIUS_PADDING = 24
--- 陷阱爆炸范围额外扩张。
local RUBICK_FROST_1_DAMAGE_RADIUS_PADDING = 96
--- 陷阱范围伤害倍率。
local RUBICK_FROST_1_DAMAGE_RATE = 18
--- 陷阱触发后附加的眩晕时间。
local RUBICK_FROST_1_STUN_DURATION = 0.8
--- 陷阱触发后附加的冰缓层数。
local RUBICK_FROST_1_ICE_SLOW_STACK = 10
--- 陷阱触发后附加的冰缓持续时间。
local RUBICK_FROST_1_ICE_SLOW_DURATION = 4
--- 埋设陷阱动作。
local RUBICK_FROST_1_CAST_ANIMATION = "rubick_steal_mk_cast04_spring"
--- 冰霜陷阱待触发特效。
local RUBICK_FROST_1_TRAP_PARTICLE = "particles/rebuild/spell/rubick_boss/hd_rubick_boss_ice_trap/active/effectde.vpcf"
--- 冰霜陷阱触发爆炸特效。
local RUBICK_FROST_1_TRIGGER_PARTICLE = "particles/dd/snowball_projectile_explosion.vpcf"
--- 冰缓状态特效。
local RUBICK_FROST_1_SLOW_STATUS_PARTICLE = "particles/status_fx/status_effect_frost_armor.vpcf"
--- 眩晕时附带的冻结状态特效。
local RUBICK_FROST_1_STUN_STATUS_PARTICLE = "particles/status_fx/status_effect_frost.vpcf"
____exports.boss_rubick_frost_1 = __TS__Class()
local boss_rubick_frost_1 = ____exports.boss_rubick_frost_1
boss_rubick_frost_1.name = "boss_rubick_frost_1"
__TS__ClassExtends(boss_rubick_frost_1, RubickOriginAbility)
function boss_rubick_frost_1.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_FROST_1_TRAP_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_1_TRIGGER_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_1_SLOW_STATUS_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_1_STUN_STATUS_PARTICLE, context)
end
function boss_rubick_frost_1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_FROST_1_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_FROST_1_CAST_POINT,
		castDuration = RUBICK_FROST_1_CAST_DURATION,
		canCast = function()
			if not MyGameDynamicFloor then
				return UF_FAIL_CUSTOM
			end
			local floorId = self:GetTrapFloorId()
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
		OnPhaseStart = function()
			self:GetCaster():SetAnimation(RUBICK_FROST_1_CAST_ANIMATION)
		end,
		OnStart = function()
			return self:CreateFrostTraps()
		end,
	}
end
function boss_rubick_frost_1.prototype.CreateFrostTraps(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not MyGameDynamicFloor then
		return
	end
	local floorId = self:GetTrapFloorId()
	if not floorId then
		return
	end
	local controller = self:EnsureTrapController()
	if not controller then
		return
	end
	for ____, tile in ipairs(self:SelectRandomTrapTiles(floorId, controller)) do
		controller:AddTrapTile(tile)
	end
end
function boss_rubick_frost_1.prototype.EnsureTrapController(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local controller = ____exports.modifier_boss_rubick_frost_1_trap_controller:find_on(caster)
	if not controller then
		controller = ____exports.modifier_boss_rubick_frost_1_trap_controller:applys(caster, caster, self, {})
	end
	return controller
end
function boss_rubick_frost_1.prototype.SelectRandomTrapTiles(self, floorId, controller)
	if not MyGameDynamicFloor then
		return {}
	end
	local candidates = __TS__ArrayMap(
		__TS__ArrayFilter(MyGameDynamicFloor:GetAvailableTiles(floorId), function(____, tile)
			return self:CanUseTile(tile) and not controller:HasTrapTile(tile)
		end),
		function(____, tile)
			return {
				tile = tile,
				roll = RandomFloat(0, 1),
			}
		end
	)
	__TS__ArraySort(candidates, function(____, left, right)
		return left.roll - right.roll
	end)
	return __TS__ArrayMap(
		__TS__ArraySlice(candidates, 0, math.min(RUBICK_FROST_1_TRAP_COUNT_PER_CAST, #candidates)),
		function(____, candidate)
			return candidate.tile
		end
	)
end
function boss_rubick_frost_1.prototype.GetTrapFloorId(self)
	local caster = self:GetCaster()
	local casterTile = self:GetUnitTile(caster)
	if casterTile then
		return casterTile.floorId
	end
	local target = caster:GetMinDistanceUnit(RUBICK_FROST_1_CAST_RANGE)
	local ____IsValidAlive_result_3
	if IsValidAlive(nil, target) then
		local ____opt_1 = self:GetUnitTile(target)
		____IsValidAlive_result_3 = ____opt_1 and ____opt_1.floorId
	else
		____IsValidAlive_result_3 = nil
	end
	return ____IsValidAlive_result_3
end
function boss_rubick_frost_1.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_frost_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_frost_1)
____exports.boss_rubick_frost_1 = boss_rubick_frost_1
____exports.modifier_boss_rubick_frost_1_trap_controller = __TS__Class()
local modifier_boss_rubick_frost_1_trap_controller = ____exports.modifier_boss_rubick_frost_1_trap_controller
modifier_boss_rubick_frost_1_trap_controller.name = "modifier_boss_rubick_frost_1_trap_controller"
__TS__ClassExtends(modifier_boss_rubick_frost_1_trap_controller, BaseModifier_CS)
function modifier_boss_rubick_frost_1_trap_controller.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.traps = {}
	self.trapKeys = {}
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(RUBICK_FROST_1_TRAP_THINK_INTERVAL)
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:ClearTraps()
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.AddTrapTile(self, tile)
	if not IsServer() then
		return
	end
	local tileKey = self:GetTileKey(tile)
	local existing = self.traps[tileKey]
	if existing then
		existing.tile = tile
		return
	end
	local particle = ParticleManager:CreateParticle(RUBICK_FROST_1_TRAP_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:SetParticleControl(particle, 10, Vector(tile.tileSize, tile.tileSize, 0))
	ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
	self.traps[tileKey] = { tile = tile, particle = particle }
	local ____self_trapKeys_4 = self.trapKeys
	____self_trapKeys_4[#____self_trapKeys_4 + 1] = tileKey
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.HasTrapTile(self, tile)
	return self.traps[self:GetTileKey(tile)] ~= nil
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self:RemoveInvalidTraps()
	if #self.trapKeys <= 0 then
		self:Destroy()
		return
	end
	self:TriggerSteppedTraps(caster)
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.TriggerSteppedTraps(self, caster)
	if not MyGamePlayers or not MyGameDynamicFloor then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____this_6
	____this_6 = caster
	local ____opt_5 = ____this_6.GetRoomId
	local casterRoomId = ____opt_5 and ____opt_5(____this_6)
	local triggeredKeys = {}
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_7 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_7 and ____opt_7:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue42
			end
			local ____casterRoomId_11 = casterRoomId
			if ____casterRoomId_11 then
				local ____opt_9 = hero.GetRoomId
				____casterRoomId_11 = (____opt_9 and ____opt_9(hero)) ~= casterRoomId
			end
			if ____casterRoomId_11 then
				goto __continue42
			end
			local ____MyGameDynamicFloor_15 = MyGameDynamicFloor
			local ____MyGameDynamicFloor_GetTileAtPoint_16 = MyGameDynamicFloor.GetTileAtPoint
			local ____temp_14 = hero:GetAbsOrigin()
			local ____opt_12 = hero.GetRoomId
			local heroTile = ____MyGameDynamicFloor_GetTileAtPoint_16(
				____MyGameDynamicFloor_15,
				____temp_14,
				____opt_12 and ____opt_12(hero)
			)
			if not heroTile then
				goto __continue42
			end
			local tileKey = self:GetTileKey(heroTile)
			local trap = self.traps[tileKey]
			if not trap or __TS__ArrayIndexOf(triggeredKeys, tileKey) ~= -1 then
				goto __continue42
			end
			if
				GetDistance(nil, hero:GetAbsOrigin(), trap.tile.surfaceOrigin)
				> trap.tile.radius + RUBICK_FROST_1_TRIGGER_RADIUS_PADDING
			then
				goto __continue42
			end
			triggeredKeys[#triggeredKeys + 1] = tileKey
			self:TriggerTrap(tileKey, trap, caster)
		end
		::__continue42::
	end
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.TriggerTrap(self, tileKey, trap, caster)
	self:PlayTriggerParticle(trap.tile)
	self:ApplyTrapDamage(trap.tile, caster)
	self:RemoveTrap(tileKey)
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.ApplyTrapDamage(self, tile, caster)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		tile.surfaceOrigin,
		nil,
		tile.radius + RUBICK_FROST_1_DAMAGE_RADIUS_PADDING,
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
			caster:MonsterDamage({ victim = enemy, damage_rate = RUBICK_FROST_1_DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				ability,
				DebuffStatusType.ICE_SLOW,
				{
					stack = RUBICK_FROST_1_ICE_SLOW_STACK,
					duration = RUBICK_FROST_1_ICE_SLOW_DURATION,
					status_effect_name = RUBICK_FROST_1_SLOW_STATUS_PARTICLE,
				}
			)
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				ability,
				DebuffStatusType.STUN,
				{ duration = RUBICK_FROST_1_STUN_DURATION, status_effect_name = RUBICK_FROST_1_STUN_STATUS_PARTICLE }
			)
		end
		::__continue53::
	end
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.PlayTriggerParticle(self, tile)
	local particle = ParticleManager:CreateParticle(RUBICK_FROST_1_TRIGGER_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.RemoveInvalidTraps(self)
	do
		local index = #self.trapKeys - 1
		while index >= 0 do
			do
				local tileKey = self.trapKeys[index + 1]
				local trap = self.traps[tileKey]
				if trap and self:CanUseTile(trap.tile) then
					goto __continue58
				end
				self:RemoveTrap(tileKey)
			end
			::__continue58::
			index = index - 1
		end
	end
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.RemoveTrap(self, tileKey)
	self:DestroyTrapParticle(self.traps[tileKey])
	__TS__Delete(self.traps, tileKey)
	local index = __TS__ArrayIndexOf(self.trapKeys, tileKey)
	if index ~= -1 then
		__TS__ArraySplice(self.trapKeys, index, 1)
	end
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.ClearTraps(self)
	for ____, tileKey in ipairs(self.trapKeys) do
		self:DestroyTrapParticle(self.traps[tileKey])
	end
	self.traps = {}
	self.trapKeys = {}
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.DestroyTrapParticle(self, trap)
	if not trap then
		return
	end
	ParticleManager:DestroyParticle(trap.particle, false)
	ParticleManager:ReleaseParticleIndex(trap.particle)
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. "_") .. tostring(tile.gridColumn)) .. "_") .. tostring(tile.gridRow)
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_frost_1_trap_controller.prototype.IsPurgable(self)
	return false
end
modifier_boss_rubick_frost_1_trap_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_frost_1_trap_controller)
____exports.modifier_boss_rubick_frost_1_trap_controller = modifier_boss_rubick_frost_1_trap_controller
return ____exports