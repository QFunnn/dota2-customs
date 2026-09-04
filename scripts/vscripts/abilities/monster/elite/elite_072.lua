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
local modifier_elite_072_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SEARCH_RANGE = 900
local CAST_POINT = 0.35
local CAST_DURATION = 1.5
local BLINK_DISTANCE_FROM_TARGET = 420
local BLINK_POINT_ATTEMPTS = 16
local PROJECTILE_DISTANCE = 1800
local PROJECTILE_SPEED = 1800
local PROJECTILE_RADIUS = 100
local PROJECTILE_GAP = 100
local PROJECTILE_SPACING = PROJECTILE_RADIUS * 2 + PROJECTILE_GAP
local PROJECTILE_DAMAGE_RATE = 25
local PROJECTILE_GESTURE_DELAY = 0.5
local PROJECTILE_FIRE_DELAY = 0.8
local HIT_SLOW_PCT = 50
local HIT_SLOW_DURATION = 3
local BLINK_PARTICLE = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
local PROJECTILE_PARTICLE = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf"
local CAST_SOUND = "Hero_ShadowDemon.Disruption"
local PROJECTILE_SOUND = "Hero_ShadowDemon.ShadowPoison"
--- 精英技能72 - 暗影换位：闪烁换位后发射三条平行暗影弹道
____exports.elite_072 = __TS__Class()
local elite_072 = ____exports.elite_072
elite_072.name = "elite_072"
__TS__ClassExtends(elite_072, MonsterAbility_CS)
function elite_072.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetEnemy = nil
end
function elite_072.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_PARTICLE, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
end
function elite_072.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = SEARCH_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:FindNearestEnemy(caster)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindNearestEnemy(caster)
			local ____IsValidAlive_result_1
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_1 = target
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
			local target = self.targetEnemy or self:FindNearestEnemy(caster)
			self.targetEnemy = nil
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			local oldOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
			local blinkPoint = self:FindBlinkPoint(caster, target)
			if not blinkPoint then
				return
			end
			self:PlayBlinkParticle(oldOrigin)
			EmitSoundOn(CAST_SOUND, caster)
			ProjectileManager:ProjectileDodge(caster)
			FindClearSpaceForUnit(caster, blinkPoint, true)
			self:PlayBlinkParticle(blinkPoint)
			local lockedDirection = GetDirection(nil, target:GetAbsOrigin(), blinkPoint)
			caster:SetForwardVector(lockedDirection)
			self:ShowParallelWarnings(blinkPoint, lockedDirection)
			self:Timer(PROJECTILE_GESTURE_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
			end)
			self:Timer(PROJECTILE_FIRE_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local fireOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
				caster:SetForwardVector(lockedDirection)
				self:FireParallelProjectiles(fireOrigin, lockedDirection)
			end)
		end,
	}
end
function elite_072.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(SEARCH_RANGE)
end
function elite_072.prototype.FindBlinkPoint(self, caster, target)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), target)
	local baseDirection = GetDirection(nil, targetOrigin, casterOrigin)
	local angles = {
		0,
		35,
		-35,
		70,
		-70,
		110,
		-110,
		180,
	}
	do
		local i = 0
		while i < BLINK_POINT_ATTEMPTS do
			local angle = angles[i % #angles + 1]
			local direction = RotateVector2D(nil, baseDirection, angle):Normalized()
			local rawPoint = targetOrigin:__add(direction:__mul(BLINK_DISTANCE_FROM_TARGET))
			local point = GetGroundPosition(rawPoint, caster)
			if self:IsValidBlinkPoint(casterOrigin, point) then
				return point
			end
			i = i + 1
		end
	end
	return nil
end
function elite_072.prototype.IsValidBlinkPoint(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function elite_072.prototype.FireParallelProjectiles(self, origin, direction)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(PROJECTILE_SOUND, caster)
	local side = Vector(-direction.y, direction.x, 0)
	local target = origin:__add(direction:__mul(PROJECTILE_DISTANCE))
	do
		local i = 0
		while i < 3 do
			local offset = (i - 1) * PROJECTILE_SPACING
			local offsetVector = side:__mul(offset)
			local startPoint = origin:__add(offsetVector)
			local endPoint = target:__add(offsetVector)
			CreateProjectile(nil, {
				caster = caster,
				ability = self,
				effect_name = PROJECTILE_PARTICLE,
				projectile_type = "linear",
				start_point = startPoint,
				target = endPoint,
				projectile_speed = PROJECTILE_SPEED,
				projectile_distance = PROJECTILE_DISTANCE,
				projectile_range = PROJECTILE_RADIUS,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				on_hit = function(____, hitTarget)
					if hitTarget and IsValidAlive(nil, hitTarget) then
						if not IsValidAlive(nil, caster) then
							return true
						end
						caster:MonsterDamage({
							victim = hitTarget,
							damage_rate = PROJECTILE_DAMAGE_RATE,
							ability = self,
						})
						modifier_elite_072_slow:applys(hitTarget, caster, self, { duration = HIT_SLOW_DURATION })
						return false
					end
					return true
				end,
			})
			i = i + 1
		end
	end
end
function elite_072.prototype.ShowParallelWarnings(self, origin, direction)
	local side = Vector(-direction.y, direction.x, 0)
	local target = origin:__add(direction:__mul(PROJECTILE_DISTANCE))
	do
		local i = 0
		while i < 3 do
			local offset = (i - 1) * PROJECTILE_SPACING
			local offsetVector = side:__mul(offset)
			local startPoint = origin:__add(offsetVector)
			local endPoint = target:__add(offsetVector)
			self:WarningEffect(
				startPoint,
				endPoint,
				PROJECTILE_FIRE_DELAY,
				{ startWidth = PROJECTILE_RADIUS, endWidth = PROJECTILE_RADIUS }
			)
			i = i + 1
		end
	end
end
function elite_072.prototype.PlayBlinkParticle(self, position)
	local pfx = ParticleManager:CreateParticle(BLINK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_072 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_072)
____exports.elite_072 = elite_072
--- 暗影毒弹命中减速
modifier_elite_072_slow = __TS__Class()
modifier_elite_072_slow.name = "modifier_elite_072_slow"
__TS__ClassExtends(modifier_elite_072_slow, MonsterModifier_CS)
function modifier_elite_072_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -HIT_SLOW_PCT }
end
function modifier_elite_072_slow.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true }
end
function modifier_elite_072_slow.prototype.GetTexture(self)
	return "shadow_demon_shadow_poison"
end
function modifier_elite_072_slow.GetLocalizationCN(self)
	return { name = "暗影毒雾", description = "移动速度降低50%。" }
end
modifier_elite_072_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_072_slow") }, modifier_elite_072_slow)
return ____exports