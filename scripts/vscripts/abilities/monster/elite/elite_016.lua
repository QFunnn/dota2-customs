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
local CAST_POINT = 1.5
local LOCK_RANGE = 1200
local CAST_RANGE = 1000
local PROJECTILE_DELAY = 0.2
local RECOIL_DURATION = 0.2
local RECOIL_DISTANCE = 100
local PROJECTILE_DISTANCE = 1200
local PROJECTILE_WIDTH = 150
local PROJECTILE_SPEED = 1500
local DAMAGE_RATE = 15
local FIRE_PARTICLE = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf"
--- 精英技能16 - 黑龙喷火：前摇锁定最近玩家，延迟发射线性火焰投射物
____exports.elite_016 = __TS__Class()
local elite_016 = ____exports.elite_016
elite_016.name = "elite_016"
__TS__ClassExtends(elite_016, MonsterAbility_CS)
function elite_016.prototype.Precache(self, context)
	PrecacheResource("particle", FIRE_PARTICLE, context)
end
function elite_016.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.5,
		castDuration = PROJECTILE_DELAY + 0.3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LOCK_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			local forward = caster:GetForwardVector()
			local warnEnd = origin:__add(forward:__mul(PROJECTILE_DISTANCE))
			self:WarningEffect(origin, warnEnd, CAST_POINT, {
				startWidth = PROJECTILE_WIDTH,
				endWidth = PROJECTILE_WIDTH,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_DragonKnight.BreathFire")
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			caster:StartGestureWithFade(ACT_DOTA_ATTACK, 0.1, 0.3)
			self:Timer(PROJECTILE_DELAY, function()
				caster:Mover(origin:__add(forward:__mul(-RECOIL_DISTANCE)), RECOIL_DURATION)
			end)
			self:Timer(PROJECTILE_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local startPoint = origin:__add(Vector(0, 0, 96)):__add(forward:__mul(80))
				local endPoint = startPoint:__add(forward:__mul(PROJECTILE_DISTANCE))
				CreateProjectile(nil, {
					ability = self,
					caster = caster,
					effect_name = FIRE_PARTICLE,
					projectile_type = "linear",
					start_point = startPoint,
					target = endPoint,
					projectile_speed = PROJECTILE_SPEED,
					projectile_distance = PROJECTILE_DISTANCE,
					projectile_range = PROJECTILE_WIDTH,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
					projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
					on_hit = function(____, hitTarget)
						if hitTarget and IsValidAlive(nil, hitTarget) then
							if not IsValidAlive(nil, caster) then
								return true
							end
							caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
							hitTarget:AddNewModifier(
								caster,
								self,
								____exports.modifier_elite_016_burn.name,
								{ duration = 5 }
							)
							return false
						end
						return true
					end,
				})
			end)
		end,
	}
end
elite_016 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_016)
____exports.elite_016 = elite_016
--- 灼烧 Buff：每秒 5 点伤害，持续 5 秒
____exports.modifier_elite_016_burn = __TS__Class()
local modifier_elite_016_burn = ____exports.modifier_elite_016_burn
modifier_elite_016_burn.name = "modifier_elite_016_burn"
__TS__ClassExtends(modifier_elite_016_burn, MonsterModifier_CS)
function modifier_elite_016_burn.prototype.IsDebuff(self)
	return true
end
function modifier_elite_016_burn.prototype.IsPurgable(self)
	return true
end
function modifier_elite_016_burn.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_elite_016_burn.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = self:GetParent(),
		damage = 8,
		damage_type = 2,
		ability = self:GetAbility(),
	})
end
function modifier_elite_016_burn.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end
function modifier_elite_016_burn.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_elite_016_burn = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_016_burn)
____exports.modifier_elite_016_burn = modifier_elite_016_burn
return ____exports