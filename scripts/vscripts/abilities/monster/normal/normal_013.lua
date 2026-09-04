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
local SPLIT_SUMMON_UNIT = "monster_10079"
local SPLIT_COUNT = 2
local SPLIT_DISTANCE = 110
local SPLIT_HEIGHT = 140
local SPLIT_DURATION = 0.4
local SPLIT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local SPLIT_SOUND = "Ability.TossImpact"
--- 普通技能13 - 泥土傀儡死亡时分裂出 2 个较小的召唤傀儡
____exports.normal_013 = __TS__Class()
local normal_013 = ____exports.normal_013
normal_013.name = "normal_013"
__TS__ClassExtends(normal_013, MonsterAbility_CS)
function normal_013.prototype.Precache(self, context)
	PrecacheResource("particle", SPLIT_PARTICLE, context)
end
function normal_013.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_013.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_013_split"
end
normal_013 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_013)
____exports.normal_013 = normal_013
local modifier_normal_013_split = __TS__Class()
modifier_normal_013_split.name = "modifier_normal_013_split"
__TS__ClassExtends(modifier_normal_013_split, MonsterModifier_CS)
function modifier_normal_013_split.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._triggered = false
end
function modifier_normal_013_split.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_normal_013_split.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() or self._triggered then
		return
	end
	local parent = self:GetParent()
	local ____event_entindex_killed_0
	if event.entindex_killed then
		____event_entindex_killed_0 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_0 = nil
	end
	local victim = ____event_entindex_killed_0
	if not victim or victim ~= parent then
		return
	end
	if parent:IsSummoned() then
		return
	end
	self._triggered = true
	self:Split(parent)
end
function modifier_normal_013_split.prototype.Split(self, parent)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local origin = parent:GetAbsOrigin()
	local baseForward = parent:GetForwardVector()
	local ____parent_GetRoomId_1
	if parent.GetRoomId then
		____parent_GetRoomId_1 = parent:GetRoomId()
	else
		____parent_GetRoomId_1 = nil
	end
	local roomId = ____parent_GetRoomId_1
	local dirs = GetRotateVectors(nil, baseForward, SPLIT_COUNT, 60)
	for ____, dir in ipairs(dirs) do
		local rawPos = origin:__add(dir:__mul(SPLIT_DISTANCE))
		local spawnPos = GetGroundPosition(rawPos, parent)
		MyGameUnit:CreateSummonedUnitAsync({
			unitName = SPLIT_SUMMON_UNIT,
			position = spawnPos,
			roomId = roomId,
			team = parent:GetTeamNumber(),
			owner = parent,
			entityOwner = parent,
			summoner = parent,
			summonTag = SPLIT_SUMMON_UNIT,
			findClearSpace = true,
			destroyWithSummoner = false,
			onSpawn = function(____, unit)
				if not unit or not IsValidAlive(nil, unit) then
					return
				end
				unit:SetForwardVector(dir)
				unit:AddNewModifier(unit, ability, "modifier_monster_born", { duration = 0.35 })
				local pfx = ParticleManager:CreateParticle(SPLIT_PARTICLE, PATTACH_WORLDORIGIN, unit)
				ParticleManager:SetParticleControl(pfx, 0, unit:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(pfx)
				EmitSoundOnLocationWithCaster(unit:GetAbsOrigin(), SPLIT_SOUND, unit)
				unit:KnockBack(parent, ability, {
					duration = SPLIT_DURATION,
					distance = 0,
					height = SPLIT_HEIGHT,
					heightType = "parabola",
					stun = true,
					stunDuration = SPLIT_DURATION,
					removeOnDeath = true,
					origin_pos = unit:GetAbsOrigin(),
				})
			end,
		})
	end
end
function modifier_normal_013_split.prototype.IsHidden(self)
	return true
end
function modifier_normal_013_split.prototype.IsPurgable(self)
	return false
end
modifier_normal_013_split =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_013_split") }, modifier_normal_013_split)
return ____exports