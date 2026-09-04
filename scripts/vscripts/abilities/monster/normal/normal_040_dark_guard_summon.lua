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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ENEMY_SEARCH_RADIUS = 1000
local SUMMON_RADIUS = 700
local SUMMON_COUNT = 8
local SUMMON_TAG = "normal_040_dark_guard_summon"
local SUMMON_UNIT_NAMES = {
	"monster_11318",
	"monster_11318",
	"monster_11318",
	"monster_11318",
	"monster_11318",
	"monster_11318",
	"monster_11320",
	"monster_11320",
}
____exports.normal_040_dark_guard_summon = __TS__Class()
local normal_040_dark_guard_summon = ____exports.normal_040_dark_guard_summon
normal_040_dark_guard_summon.name = "normal_040_dark_guard_summon"
__TS__ClassExtends(normal_040_dark_guard_summon, MonsterAbility_CS)
function normal_040_dark_guard_summon.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ENEMY_SEARCH_RADIUS,
		castPoint = 0.5,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		isNotMove = true,
		canCast = function()
			return self:HasEnemyInRange()
		end,
		OnStart = function()
			return self:SummonMonsters()
		end,
	}
end
function normal_040_dark_guard_summon.prototype.HasEnemyInRange(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return UF_FAIL_CUSTOM
	end
	local enemies = self:FindUnitInRange(caster:GetAbsOrigin(), ENEMY_SEARCH_RADIUS)
	local ____temp_0
	if enemies and #enemies > 0 then
		____temp_0 = UF_SUCCESS
	else
		____temp_0 = UF_FAIL_CUSTOM
	end
	return ____temp_0
end
function normal_040_dark_guard_summon.prototype.SummonMonsters(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local ____opt_1 = caster.GetRoomId
	local roomId = ____opt_1 and ____opt_1(caster)
	local summonTag = (SUMMON_TAG .. "_") .. tostring(caster:entindex())
	do
		local index = 0
		while index < SUMMON_COUNT do
			local currentIndex = index
			local currentUnitName = SUMMON_UNIT_NAMES[currentIndex + 1]
			local angle = 360 / SUMMON_COUNT * currentIndex
			local direction = RotateVector2D(nil, Vector(1, 0, 0), angle):Normalized()
			local rawSpawnPosition = origin:__add(direction:__mul(SUMMON_RADIUS))
			local currentSpawnPosition = GetGroundPosition(rawSpawnPosition, caster)
			local currentForward = direction:__mul(-1)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = currentUnitName,
				summonTag = summonTag,
				maxSummons = SUMMON_COUNT,
				position = currentSpawnPosition,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
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
					unit:SetForwardVectorWithoutInterrupt(currentForward)
					unit:StartGesture(ACT_DOTA_SPAWN)
					unit:AddNewModifier(unit, self, "modifier_monster_born", { duration = 1 })
					unit:SetAcquisitionRange(2000)
				end,
			})
			index = index + 1
		end
	end
end
normal_040_dark_guard_summon = __TS__DecorateLegacy({ registerAbility(nil) }, normal_040_dark_guard_summon)
____exports.normal_040_dark_guard_summon = normal_040_dark_guard_summon
return ____exports