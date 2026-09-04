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
local ELITE_014_MAX_SUMMONS = 5
local ELITE_014_SUMMON_PER_CAST = 3
local ELITE_014_SUMMON_NAME = "monster_10055"
local ELITE_014_SUMMON_RADIUS = 250
local ELITE_014_CAST_RANGE = 800
local ELITE_014_COUNT_KEY = "elite_014_summon_count"
--- 精英技能14 - 召唤骷髅战士，最多维持5只
____exports.elite_014 = __TS__Class()
local elite_014 = ____exports.elite_014
elite_014.name = "elite_014"
__TS__ClassExtends(elite_014, MonsterAbility_CS)
function elite_014.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = ELITE_014_CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 1,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		canCast = function()
			local caster = self:GetCaster()
			local currentCountRaw = caster:GetCustomValue(ELITE_014_COUNT_KEY)
			local ____temp_0
			if type(currentCountRaw) == "number" then
				____temp_0 = currentCountRaw
			else
				____temp_0 = 0
			end
			local currentCount = ____temp_0
			if currentCount >= ELITE_014_MAX_SUMMONS then
				print("不可召唤")
				return UF_FAIL_CUSTOM
			end
		end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_ArcWarden.SparkWraith.Cast")
			local team = caster:GetTeamNumber()
			local origin = caster:GetAbsOrigin()
			local ownerId = caster:GetEntityIndex()
			local currentCountRaw = caster:GetCustomValue(ELITE_014_COUNT_KEY)
			local ____temp_1
			if type(currentCountRaw) == "number" then
				____temp_1 = currentCountRaw
			else
				____temp_1 = 0
			end
			local currentCount = ____temp_1
			local canSummon = math.min(ELITE_014_SUMMON_PER_CAST, ELITE_014_MAX_SUMMONS - currentCount)
			local ____caster_GetRoomId_2
			if caster.GetRoomId then
				____caster_GetRoomId_2 = caster:GetRoomId()
			else
				____caster_GetRoomId_2 = nil
			end
			local roomId = ____caster_GetRoomId_2
			local dirs = GetRotateVectors(nil, caster:GetForwardVector(), 3, 35)
			do
				local i = 0
				while i < canSummon do
					local dir = dirs[i + 1]
					local rawPos = origin:__add(dir:__mul(180))
					local groundZ = GetGroundHeight(rawPos, caster) or rawPos.z
					local spawnPos = Vector(rawPos.x, rawPos.y, groundZ)
					MyGameUnit:CreateSummonedUnitAsync({
						unitName = ELITE_014_SUMMON_NAME,
						maxSummons = ELITE_014_MAX_SUMMONS,
						position = spawnPos,
						roomId = roomId,
						team = team,
						owner = caster,
						findClearSpace = true,
						onSpawn = function(____, unit)
							if not unit or not IsValidAlive(nil, unit) then
								return
							end
							unit:SetCustomValue("elite_014_owner", ownerId)
							caster:AddCustomValue(ELITE_014_COUNT_KEY, 1)
							unit:AddNewModifier(unit, nil, "modifier_monster_born", { duration = 0.5 })
							unit:SetForwardVector(dir)
						end,
						onDeath = function()
							if not IsValidAlive(nil, caster) then
								return
							end
							caster:AddCustomValue(ELITE_014_COUNT_KEY, -1)
						end,
					})
					i = i + 1
				end
			end
		end,
	}
end
elite_014 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_014)
____exports.elite_014 = elite_014
return ____exports