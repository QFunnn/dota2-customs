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
local modifier_normal_049_weaken
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 600
local CAST_POINT = 0.9
local CAST_DURATION = 0.5
local COOLDOWN = 8
local PROJECTILE_SPEED = 1000
local PROJECTILE_DISTANCE = 1080
local PROJECTILE_RADIUS_START = 150
local PROJECTILE_RADIUS_END = 250
local PROJECTILE_START_FORWARD = 90
local PROJECTILE_START_HEIGHT = 64
local DAMAGE_RATE = 20
local WEAKEN_DURATION = 8
local WEAKEN_PARTICLE = "particles/neutral_fx/satyr_hellcaller.vpcf"
local WEAKEN_CAST_PARTICLE = "particles/neutral_fx/satyr_hellcaller_cast.vpcf"
local WEAKEN_CAST_SOUND = "n_creep_SatyrHellcaller.Shockwave"
local WEAKEN_HIT_SOUND = "n_creep_SatyrHellcaller.Shockwave.Damage"
--- 普通技能49 - 弱化：释放冲击波，对命中的敌人造成伤害并降低暴击几率。
____exports.normal_049 = __TS__Class()
local normal_049 = ____exports.normal_049
normal_049.name = "normal_049"
__TS__ClassExtends(normal_049, MonsterAbility_CS)
function normal_049.prototype.Precache(self, context)
	PrecacheResource("particle", WEAKEN_PARTICLE, context)
	PrecacheResource("particle", WEAKEN_CAST_PARTICLE, context)
end
function normal_049.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		cooldown = COOLDOWN,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.7,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindCastTarget(caster)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT * 0.8, 2)
			end
			local direction = caster:GetForwardVector()
			local startPoint = self:GetShockwaveStartPoint(caster, direction, 0)
			local endPoint = startPoint:__add(direction:__mul(1000))
			self:WarningEffect(startPoint, endPoint, CAST_POINT, {
				startWidth = PROJECTILE_RADIUS_START * 0.7,
				endWidth = PROJECTILE_RADIUS_END * 0.7,
				getDirection = function(self)
					local ____IsValidAlive_result_0
					if IsValidAlive(nil, caster) then
						____IsValidAlive_result_0 = caster:GetForwardVector()
					else
						____IsValidAlive_result_0 = Vector(1, 0, 0)
					end
					return ____IsValidAlive_result_0
				end,
				follow = true,
			})
			self:PlayCastEffect(caster)
		end,
		OnStart = function()
			self:FireWeakenWave()
		end,
	}
end
function normal_049.prototype.FireWeakenWave(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = caster:GetForwardVector()
	local startPoint = self:GetShockwaveStartPoint(caster, direction, PROJECTILE_START_HEIGHT)
	local targetPoint = startPoint:__add(direction:__mul(PROJECTILE_DISTANCE))
	self:EmitSoundParams(WEAKEN_CAST_SOUND, 1, 5, 0)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = WEAKEN_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		target = targetPoint,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS_START,
		projectile_end_range = PROJECTILE_RADIUS_END,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not IsValidAlive(nil, caster) then
				return true
			end
			if hitTarget and IsValidAlive(nil, hitTarget) then
				EmitSoundOn(WEAKEN_HIT_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) then
					return false
				end
				modifier_normal_049_weaken:applys(hitTarget, caster, self, { duration = WEAKEN_DURATION })
				if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) then
					return false
				end
				hitTarget:KnockBack(caster, self, {
					origin_pos = caster:GetAbsOrigin(),
					duration = 0.3,
					stun = true,
					stunDuration = 0.5,
					distance = 80,
					height = 60,
				})
				return false
			end
			return true
		end,
	})
end
function normal_049.prototype.FindCastTarget(self, caster)
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function normal_049.prototype.GetShockwaveStartPoint(self, caster, direction, height)
	if not IsValidAlive(nil, caster) then
		return Vector(0, 0, 0)
	end
	local startPoint = caster:GetAbsOrigin():__add(direction:__mul(PROJECTILE_START_FORWARD))
	startPoint.z = GetGroundHeight(startPoint, caster) + height
	return startPoint
end
function normal_049.prototype.PlayCastEffect(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(WEAKEN_CAST_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
normal_049 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_049)
____exports.normal_049 = normal_049
modifier_normal_049_weaken = __TS__Class()
modifier_normal_049_weaken.name = "modifier_normal_049_weaken"
__TS__ClassExtends(modifier_normal_049_weaken, MonsterModifier_CS)
function modifier_normal_049_weaken.GetLocalizationCN(self)
	return { name = "弱化", description = "无法造成暴击。" }
end
function modifier_normal_049_weaken.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_CRIT_QUERY }
end
function modifier_normal_049_weaken.prototype.OnDamageCritQuery_CS(self, event)
	if event.ctx.spec.attacker ~= self:GetParent() then
		return
	end
	event.force_no_crit = true
end
function modifier_normal_049_weaken.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true }
end
function modifier_normal_049_weaken.prototype.GetTexture(self)
	return "satyr_hellcaller_shockwave"
end
modifier_normal_049_weaken =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_049_weaken") }, modifier_normal_049_weaken)
return ____exports