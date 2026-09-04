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
local BOSS_009_HEALTH_THRESHOLD_PCT = 55
local BOSS_009_SUMMON_INTERVAL = 15
local BOSS_009_CHECK_INTERVAL = 0.25
local BOSS_009_MAX_SUMMONS = 3
local BOSS_009_MIN_DISTANCE_FROM_PLAYER = 1000
local BOSS_009_SUMMON_SEARCH_RADIUS_MIN = 1000
local BOSS_009_SUMMON_SEARCH_RADIUS_MAX = 1800
local BOSS_009_SUMMON_POSITION_ATTEMPTS = 48
local BOSS_009_SUMMON_UNIT_NAME = "monster_11328"
local BOSS_009_SUMMON_TAG = "boss_009_void_fanatic"
--- 黑羽援军：低血量时周期性召唤虚空狂热者。
____exports.boss_009 = __TS__Class()
local boss_009 = ____exports.boss_009
boss_009.name = "boss_009"
__TS__ClassExtends(boss_009, MonsterAbility_CS)
function boss_009.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function boss_009.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_009"
end
boss_009 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_009)
____exports.boss_009 = boss_009
____exports.modifier_boss_009 = __TS__Class()
local modifier_boss_009 = ____exports.modifier_boss_009
modifier_boss_009.name = "modifier_boss_009"
__TS__ClassExtends(modifier_boss_009, MonsterModifier_CS)
function modifier_boss_009.prototype.IsHidden(self)
	return true
end
function modifier_boss_009.prototype.IsPurgable(self)
	return false
end
function modifier_boss_009.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(BOSS_009_CHECK_INTERVAL)
end
function modifier_boss_009.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if caster:GetHealthPercent() >= BOSS_009_HEALTH_THRESHOLD_PCT then
		self.nextSummonTime = nil
		return
	end
	local currentTime = GameRules:GetGameTime()
	if self.nextSummonTime == nil then
		self.nextSummonTime = currentTime + BOSS_009_SUMMON_INTERVAL
		return
	end
	if currentTime < self.nextSummonTime then
		return
	end
	self.nextSummonTime = currentTime + BOSS_009_SUMMON_INTERVAL
	self:SummonVoidFanatic(caster)
end
function modifier_boss_009.prototype.SummonVoidFanatic(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local spawnPosition = self:FindSummonPosition(caster)
	if not spawnPosition then
		return
	end
	local ____MyGameUnit_2 = MyGameUnit
	local ____MyGameUnit_CreateSummonedUnitAsync_3 = MyGameUnit.CreateSummonedUnitAsync
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetRoomId
	____MyGameUnit_CreateSummonedUnitAsync_3(____MyGameUnit_2, {
		unitName = BOSS_009_SUMMON_UNIT_NAME,
		summonTag = BOSS_009_SUMMON_TAG,
		maxSummons = BOSS_009_MAX_SUMMONS,
		replaceOldestWhenFull = false,
		position = spawnPosition,
		roomId = ____opt_0 and ____opt_0(____this_1),
		team = caster:GetTeamNumber(),
		owner = caster,
		entityOwner = caster,
		summoner = caster,
		destroyWithSummoner = true,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValidAlive(nil, unit) then
				return
			end
			if not IsValidAlive(nil, caster) then
				MyGameUnit:DestroyUnit(unit)
				return
			end
			unit:StartGesture(ACT_DOTA_SPAWN)
			unit:AddNewModifier(unit, self:GetAbility(), "modifier_monster_born", { duration = 1 })
			unit:SetAcquisitionRange(2000)
		end,
	})
end
function modifier_boss_009.prototype.FindSummonPosition(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local playerHeroes = self:GetPlayerHeroesInRoom(caster)
	if #playerHeroes <= 0 then
		return nil
	end
	do
		local attempt = 0
		while attempt < BOSS_009_SUMMON_POSITION_ATTEMPTS do
			local direction = RotateVector2D(nil, Vector(1, 0, 0), RandomFloat(0, 360))
			local distance = RandomFloat(BOSS_009_SUMMON_SEARCH_RADIUS_MIN, BOSS_009_SUMMON_SEARCH_RADIUS_MAX)
			local candidate = casterOrigin:__add(direction:__mul(distance))
			local groundPoint = GetGroundPosition(candidate, caster)
			if self:IsValidSummonPosition(casterOrigin, groundPoint, playerHeroes) then
				return groundPoint
			end
			attempt = attempt + 1
		end
	end
	return nil
end
function modifier_boss_009.prototype.GetPlayerHeroesInRoom(self, caster)
	if not IsValidAlive(nil, caster) then
		return {}
	end
	local ____this_5
	____this_5 = caster
	local ____opt_4 = ____this_5.GetRoomId
	local casterRoomId = ____opt_4 and ____opt_4(____this_5)
	local heroes = {}
	for ____, hero in ipairs(MyGamePlayers:GetAllHeroes()) do
		do
			if not IsValidAlive(nil, hero) or hero:GetTeamNumber() == caster:GetTeamNumber() then
				goto __continue27
			end
			local ____temp_8 = casterRoomId ~= nil
			if ____temp_8 then
				local ____opt_6 = hero.GetRoomId
				____temp_8 = (____opt_6 and ____opt_6(hero)) ~= casterRoomId
			end
			if ____temp_8 then
				goto __continue27
			end
			heroes[#heroes + 1] = hero
		end
		::__continue27::
	end
	return heroes
end
function modifier_boss_009.prototype.IsValidSummonPosition(self, casterOrigin, point, playerHeroes)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(casterOrigin, point) then
		return false
	end
	if GridNav:FindPathLength(casterOrigin, point) == -1 then
		return false
	end
	for ____, hero in ipairs(playerHeroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue36
			end
			if GetDistance(nil, point, hero:GetAbsOrigin()) < BOSS_009_MIN_DISTANCE_FROM_PLAYER then
				return false
			end
		end
		::__continue36::
	end
	return true
end
modifier_boss_009 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_009)
____exports.modifier_boss_009 = modifier_boss_009
return ____exports