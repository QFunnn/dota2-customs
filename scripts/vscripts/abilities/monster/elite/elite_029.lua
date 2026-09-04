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
local modifier_elite_029_egg_hatch
local ____utils = require("modifiers.utils.index")
local modifier_attacks_to_destroy = ____utils.modifier_attacks_to_destroy
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_029_EGG_UNIT = "monster_10070"
local ELITE_029_HATCH_UNITS = { "monster_10068", "monster_10068", "monster_10068" }
local ELITE_029_EGG_COUNT = 4
local ELITE_029_EGG_ATTACKS_TO_DESTROY = 1
local ELITE_029_SPAWN_RADIUS = 420
local ELITE_029_MIN_DISTANCE = 120
local ELITE_029_HATCH_DURATION = 2
local ELITE_029_HATCH_PFX = "particles/unit/monster/courier_trail_hw_2012.vpcf"
local ELITE_029_CAST_SOUND = "Hero_Broodmother.SpawnSpiderlingsCast"
local ELITE_029_HATCH_SOUND = "Hero_Broodmother.SpawnSpiderlings"
--- 精英技能29 - 产卵：召唤蜘蛛，10秒CD
____exports.elite_029 = __TS__Class()
local elite_029 = ____exports.elite_029
elite_029.name = "elite_029"
__TS__ClassExtends(elite_029, MonsterAbility_CS)
function elite_029.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_029_HATCH_PFX, context)
end
function elite_029.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = 1500,
		castPoint = 0,
		castDuration = 0,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(ELITE_029_CAST_SOUND, caster)
			local ____caster_GetRoomId_0
			if caster.GetRoomId then
				____caster_GetRoomId_0 = caster:GetRoomId()
			else
				____caster_GetRoomId_0 = nil
			end
			local roomId = ____caster_GetRoomId_0
			local origin = caster:GetAbsOrigin()
			local spawnPoints = self:GetEggSpawnPoints(origin)
			for ____, point in ipairs(spawnPoints) do
				MyGameUnit:CreateSummonedUnitAsync({
					unitName = ELITE_029_EGG_UNIT,
					maxSummons = 5,
					position = point,
					roomId = roomId,
					team = caster:GetTeamNumber(),
					owner = caster,
					entityOwner = caster,
					summoner = caster,
					summonTag = ELITE_029_EGG_UNIT,
					findClearSpace = false,
					onSpawn = function(____, egg)
						if not egg or not IsValidAlive(nil, egg) then
							return
						end
						modifier_attacks_to_destroy:applys(
							egg,
							caster,
							self,
							{ attacks_to_destroy = ELITE_029_EGG_ATTACKS_TO_DESTROY }
						)
						modifier_elite_029_egg_hatch:applys(egg, caster, self, { duration = ELITE_029_HATCH_DURATION })
					end,
				})
			end
		end,
	}
end
function elite_029.prototype.GetEggSpawnPoints(self, origin)
	local validPoints = {}
	local rawPoints =
		GetRandomPointsInCircle(nil, origin, ELITE_029_SPAWN_RADIUS, ELITE_029_EGG_COUNT * 3, ELITE_029_MIN_DISTANCE)
	for ____, rawPoint in ipairs(rawPoints) do
		do
			local groundedPoint = GetGroundPosition(rawPoint, self:GetCaster())
			if not groundedPoint then
				goto __continue12
			end
			if not IsGridNavDisplacementWalkable(nil, groundedPoint) then
				goto __continue12
			end
			if not GridNav:CanFindPath(origin, groundedPoint) then
				goto __continue12
			end
			if GridNav:FindPathLength(origin, groundedPoint) == -1 then
				goto __continue12
			end
			validPoints[#validPoints + 1] = groundedPoint
			if #validPoints >= ELITE_029_EGG_COUNT then
				break
			end
		end
		::__continue12::
	end
	return validPoints
end
elite_029 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_029)
____exports.elite_029 = elite_029
modifier_elite_029_egg_hatch = __TS__Class()
modifier_elite_029_egg_hatch.name = "modifier_elite_029_egg_hatch"
__TS__ClassExtends(modifier_elite_029_egg_hatch, MonsterModifier_CS)
function modifier_elite_029_egg_hatch.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	if parent.__remove then
		return
	end
	if not parent:IsAlive() then
		return
	end
	if parent.__elite_029_hatched then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	parent.__elite_029_hatched = true
	local caster = self:GetCaster()
	local ____parent_GetRoomId_1
	if parent.GetRoomId then
		____parent_GetRoomId_1 = parent:GetRoomId()
	else
		____parent_GetRoomId_1 = nil
	end
	local roomId = ____parent_GetRoomId_1
	local hatchUnit = ELITE_029_HATCH_UNITS[RandomInt(0, #ELITE_029_HATCH_UNITS - 1) + 1]
	local hatchPos = GetGroundPosition(parent:GetAbsOrigin(), parent)
	local ____MyGameUnit_7 = MyGameUnit
	local ____MyGameUnit_CreateSummonedUnitAsync_8 = MyGameUnit.CreateSummonedUnitAsync
	local ____roomId_5 = roomId
	local ____temp_6 = parent:GetTeamNumber()
	local ____temp_2
	if IsValid(nil, caster) and not caster:IsNull() then
		____temp_2 = caster
	else
		____temp_2 = nil
	end
	local ____temp_3
	if IsValid(nil, caster) and not caster:IsNull() then
		____temp_3 = caster
	else
		____temp_3 = nil
	end
	local ____temp_4
	if IsValid(nil, caster) and not caster:IsNull() then
		____temp_4 = caster
	else
		____temp_4 = nil
	end
	____MyGameUnit_CreateSummonedUnitAsync_8(____MyGameUnit_7, {
		unitName = hatchUnit,
		maxSummons = 5,
		position = hatchPos,
		roomId = ____roomId_5,
		team = ____temp_6,
		owner = ____temp_2,
		entityOwner = ____temp_3,
		summoner = ____temp_4,
		summonTag = ELITE_029_EGG_UNIT,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValidAlive(nil, unit) then
				parent:SafeDestroy()
				return
			end
			EmitSoundOn(ELITE_029_HATCH_SOUND, parent)
			unit:SetForwardVector(GetDirection(nil, parent:GetAbsOrigin(), hatchPos))
			local pfx = ParticleManager:CreateParticle(
				"particles/units/monster/broodmother_spiderlings_spawn.vpcf",
				PATTACH_WORLDORIGIN,
				unit
			)
			ParticleManager:SetParticleControl(pfx, 0, unit:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(pfx)
			parent:SafeDestroy()
		end,
	})
end
function modifier_elite_029_egg_hatch.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local pfx = ParticleManager:CreateParticle(ELITE_029_HATCH_PFX, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(pfx, true, false, -1, false, false)
end
function modifier_elite_029_egg_hatch.prototype.IsHidden(self)
	return false
end
function modifier_elite_029_egg_hatch.prototype.IsPurgable(self)
	return false
end
function modifier_elite_029_egg_hatch.prototype.IsDebuff(self)
	return false
end
modifier_elite_029_egg_hatch =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_029_egg_hatch") }, modifier_elite_029_egg_hatch)
return ____exports