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
local CAST_POINT = 0.1
local CAST_DURATION = 0.1
local ENEMY_SEARCH_RANGE = 400
local BLINK_MIN_DISTANCE_FROM_ENEMY = 600
local BLINK_MAX_DISTANCE_FROM_ENEMY = 900
local BLINK_POINT_ATTEMPTS = 64
local BLINK_AWAY_ARC_DEGREES = 120
local BLINK_PARTICLE =
	"particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8_start_burst.vpcf"
____exports.elite_106 = __TS__Class()
local elite_106 = ____exports.elite_106
elite_106.name = "elite_106"
__TS__ClassExtends(elite_106, MonsterAbility_CS)
function elite_106.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetEnemy = nil
end
function elite_106.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_PARTICLE, context)
end
function elite_106.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ENEMY_SEARCH_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindNearestEnemy(caster)) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local enemy = self:FindNearestEnemy(caster)
			local ____IsValidAlive_result_1
			if IsValidAlive(nil, enemy) then
				____IsValidAlive_result_1 = enemy
			else
				____IsValidAlive_result_1 = nil
			end
			self.targetEnemy = ____IsValidAlive_result_1
			if self.targetEnemy then
				caster:LockTargetForSpeed(self.targetEnemy, CAST_POINT)
			end
		end,
		OnInterrupt = function()
			self.targetEnemy = nil
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local enemy = self.targetEnemy or self:FindNearestEnemy(caster)
			self.targetEnemy = nil
			if not IsServer() or not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
				return
			end
			caster:EmitSound("Hero_ChaosKnight.RealityRift.Cast")
			local blinkPoint = self:FindBlinkPoint(caster, enemy)
			if not blinkPoint then
				return
			end
			local enemyOrigin = enemy:GetAbsOrigin()
			self:PlayBlinkParticle(caster:GetAbsOrigin())
			ProjectileManager:ProjectileDodge(caster)
			FindClearSpaceForUnit(caster, blinkPoint, true)
			caster:SetForwardVector(GetDirection(nil, enemyOrigin, blinkPoint))
			self:PlayBlinkParticle(blinkPoint)
			caster:AddNewModifier(caster, self, "modifier_elite_106_attack_distance", { duration = 5 })
		end,
	}
end
function elite_106.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(ENEMY_SEARCH_RANGE)
end
function elite_106.prototype.FindBlinkPoint(self, caster, enemy)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local enemyOrigin = GetGroundPosition(enemy:GetAbsOrigin(), enemy)
	local awayDirection = GetDirection(nil, casterOrigin, enemyOrigin)
	do
		local i = 0
		while i < BLINK_POINT_ATTEMPTS do
			local angle = RandomFloat(-BLINK_AWAY_ARC_DEGREES / 2, BLINK_AWAY_ARC_DEGREES / 2)
			local direction = RotateVector2D(nil, awayDirection, angle)
			local distance = RandomFloat(BLINK_MIN_DISTANCE_FROM_ENEMY, BLINK_MAX_DISTANCE_FROM_ENEMY)
			local candidate = enemyOrigin:__add(direction:__mul(distance))
			local groundedPoint = GetGroundPosition(candidate, caster)
			if self:IsValidBlinkPoint(casterOrigin, enemyOrigin, groundedPoint) then
				return groundedPoint
			end
			i = i + 1
		end
	end
	return nil
end
function elite_106.prototype.IsValidBlinkPoint(self, casterOrigin, enemyOrigin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(casterOrigin, point) then
		return false
	end
	if GridNav:FindPathLength(casterOrigin, point) == -1 then
		return false
	end
	local pathDistanceFromEnemy = GridNav:FindPathLength(enemyOrigin, point)
	if pathDistanceFromEnemy < BLINK_MIN_DISTANCE_FROM_ENEMY then
		return false
	end
	if pathDistanceFromEnemy > BLINK_MAX_DISTANCE_FROM_ENEMY then
		return false
	end
	return true
end
function elite_106.prototype.PlayBlinkParticle(self, position)
	local pfx = ParticleManager:CreateParticle(BLINK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_106 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_106)
____exports.elite_106 = elite_106
____exports.modifier_elite_106_attack_distance = __TS__Class()
local modifier_elite_106_attack_distance = ____exports.modifier_elite_106_attack_distance
modifier_elite_106_attack_distance.name = "modifier_elite_106_attack_distance"
__TS__ClassExtends(modifier_elite_106_attack_distance, MonsterModifier_CS)
function modifier_elite_106_attack_distance.prototype.GetAttributeBonus(self)
	return { bonus_attack_range = 200 }
end
modifier_elite_106_attack_distance = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_106_attack_distance") },
	modifier_elite_106_attack_distance
)
____exports.modifier_elite_106_attack_distance = modifier_elite_106_attack_distance
return ____exports