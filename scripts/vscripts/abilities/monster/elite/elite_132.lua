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
local SPIT_INTERVAL = 0.3
local SPIT_ANGLES = {
	45,
	30,
	15,
	0,
	-15,
	-30,
	-45,
	-25,
	-10,
	5,
	20,
	40,
}
--- 精英技能3 - 蓄力后发射法球
____exports.elite_132 = __TS__Class()
local elite_132 = ____exports.elite_132
elite_132.name = "elite_132"
__TS__ClassExtends(elite_132, MonsterAbility_CS)
function elite_132.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1200,
		castPoint = 1.2,
		castDuration = 3.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.5,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			local caster_pos = self._caster:GetAbsOrigin()
			if target then
				caster:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), caster_pos))
				caster:LockTargetForSpeed(target, 1)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, 0.9)
			do
				local index = 0
				while index < #SPIT_ANGLES do
					local currentAngle = SPIT_ANGLES[index + 1]
					local currentDelay = index * SPIT_INTERVAL
					self:Timer(currentDelay, function()
						local start_point = self._caster
							:GetAbsOrigin()
							:__add(Vector(0, 0, 128))
							:__add(self._caster:GetForwardVector():__mul(80))
						local caster = self:GetCaster()
						local forward_vector = self._caster:GetForwardVector()
						local BOSS_001_CAST_SOUND = "Hero_SkywrathMage.MysticFlare.Target"
						EmitSoundOnLocationWithCaster(start_point, BOSS_001_CAST_SOUND, caster)
						local target_pos =
							start_point:__add(RotateVector2D(nil, forward_vector, currentAngle):__mul(2000))
						CreateProjectile(nil, {
							ability = self,
							caster = caster,
							effect_name = "particles/boss/boss_001_2.vpcf",
							target = target_pos,
							start_point = start_point,
							projectile_type = "linear",
							projectile_speed = 300,
							projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
							projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
							projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
							projectile_distance = 2000,
							projectile_range = 60,
							on_hit = function(____, hitTarget)
								if not IsValidAlive(nil, hitTarget) then
									return true
								end
								if not hitTarget or not hitTarget:IsAlive() then
									return true
								end
								if not IsValidAlive(nil, caster) then
									return true
								end
								caster:MonsterDamage({ victim = hitTarget, damage_rate = 12, ability = self })
								return true
							end,
							on_think = function(____, location)
								return not GridNav:IsTraversable(location)
							end,
						})
						caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
					end)
					index = index + 1
				end
			end
		end,
	}
end
elite_132 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_132)
____exports.elite_132 = elite_132
return ____exports