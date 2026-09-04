--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____secondary_hero_context = require("my_game_axe.secondary_hero.secondary_hero_context")
local GetSecondaryHeroContext = ____secondary_hero_context.GetSecondaryHeroContext
local IsPlayerCombatHero = ____secondary_hero_context.IsPlayerCombatHero
--- Boss 近场人数统计半径：与 Boss 出场镜头范围保持一致。
____exports.BOSS_ENCOUNTER_NEARBY_PLAYER_RADIUS = 2500
--- 统计 Boss 附近参与战斗的敌方玩家数；同一玩家的主/副英雄只算 1 人。
function ____exports.CountNearbyEnemyPlayersForBoss(self, unit, radius)
	if radius == nil then
		radius = ____exports.BOSS_ENCOUNTER_NEARBY_PLAYER_RADIUS
	end
	if not IsServer() or not IsValidAlive(nil, unit) then
		return 1
	end
	local units = FindUnitsInRadius(
		unit:GetTeamNumber(),
		unit:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local playerIds = __TS__New(Set)
	for ____, candidate in ipairs(units) do
		do
			if not IsValidAlive(nil, candidate) or not IsPlayerCombatHero(nil, candidate) then
				goto __continue4
			end
			local ____opt_0 = GetSecondaryHeroContext(nil, candidate)
			local playerId = ____opt_0 and ____opt_0.ownerPlayerId or candidate:GetPlayerOwnerID()
			local ____playerIds_add_3 = playerIds.add
			local ____temp_2
			if playerId >= 0 then
				____temp_2 = playerId
			else
				____temp_2 = candidate:entindex()
			end
			____playerIds_add_3(playerIds, ____temp_2)
		end
		::__continue4::
	end
	return math.max(1, playerIds.size)
end
--- 多人 Boss 压制倍率：1 人 100%，2 人 50%，4 人 25%。
function ____exports.GetNearbyEnemyPlayerShareMultiplier(self, unit, radius)
	if radius == nil then
		radius = ____exports.BOSS_ENCOUNTER_NEARBY_PLAYER_RADIUS
	end
	return 1 / ____exports.CountNearbyEnemyPlayersForBoss(nil, unit, radius)
end
return ____exports