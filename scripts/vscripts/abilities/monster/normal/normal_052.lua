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
local registerModifier = ____dota_ts_adapter.registerModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local ____tstl_2Dutils = require("utils.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 900
local CAST_POINT = 0.5
local PUNCH_COUNT = 1
local PUNCH_INTERVAL = 0.45
local PUNCH_DASH_DISTANCE = 200
local PUNCH_DASH_DURATION = 0.5
local CONE_RANGE = 400
local CONE_HALF_ANGLE = 45
local DAMAGE_RATE = 20
local CAST_DURATION = (PUNCH_COUNT - 1) * PUNCH_INTERVAL + PUNCH_DASH_DURATION + 0.15
local ATTACK_PARTICLE = "particles/dark_seer_punch_glove_attack.vpcf"
local HIT_PARTICLE = "particles/neutral_fx/miniboss_dire_shield_hit.vpcf"
local PUNCH_SOUND = "Hero_Ursa.Attack"
--- 普通技能52 - 三连焰拳：蓄力后连续挥出三拳，每拳造成扇形伤害并向前突进。
____exports.normal_052 = __TS__Class()
local normal_052 = ____exports.normal_052
normal_052.name = "normal_052"
__TS__ClassExtends(normal_052, MonsterAbility_CS)
function normal_052.prototype.Precache(self, context)
	PrecacheResource("particle", ATTACK_PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
end
function normal_052.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		cooldown = 4,
		castAnimation = ACT_DOTA_SPAWN,
		animationPlaybackRate = 1.6,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			return self:StartTriplePunch()
		end,
	}
end
function normal_052.prototype.StartTriplePunch(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector()
	local origin = caster:GetAbsOrigin()
	local dashEnd = GetGroundPosition(origin:__add(forward:__mul(PUNCH_DASH_DISTANCE)), caster)
	self:Timer(0.15, function()
		caster:Mover(dashEnd, PUNCH_DASH_DURATION, nil, false, true)
	end)
	self:Timer(0.08, function()
		caster:SetAnimation("golem_attack2")
	end)
	self:PerformPunch(caster)
end
function normal_052.prototype.PerformPunch(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector()
	local origin = caster:GetAbsOrigin()
	self:PlayAttackEffect(caster, origin, forward)
	self:Timer(0.5, function()
		EmitSoundOn(PUNCH_SOUND, caster)
		self:DamageCone(caster, origin, forward)
	end)
end
function normal_052.prototype.PlayAttackEffect(self, caster, origin, forward)
	local particle = ParticleManager:CreateParticle(ATTACK_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:ReleaseParticleIndex(particle)
end
function normal_052.prototype.DamageCone(self, caster, origin, forward)
	local minForwardDot = math.cos(math.rad(CONE_HALF_ANGLE))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		CONE_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			local offset = enemy:GetAbsOrigin():__sub(origin)
			offset.z = 0
			if offset:Length2D() > 0.01 and offset:Normalized():Dot(forward) < minForwardDot then
				goto __continue17
			end
			enemy:KnockBack(caster, self, {
				duration = 0.1,
				distance = 50,
				height = 0,
				stun = true,
				stunDuration = 0.5,
			})
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			self:PlayHitEffect(enemy)
		end
		::__continue17::
	end
end
function normal_052.prototype.PlayHitEffect(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local particle = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end
normal_052 = __TS__DecorateLegacy({
	registerAbility(nil),
	reloadable,
}, normal_052)
____exports.normal_052 = normal_052
____exports.modifier_test11 = __TS__Class()
local modifier_test11 = ____exports.modifier_test11
modifier_test11.name = "modifier_test11"
__TS__ClassExtends(modifier_test11, MonsterModifier_CS)
function modifier_test11.prototype.IsPurgable(self)
	return false
end
function modifier_test11.prototype.IsHidden(self)
	return true
end
function modifier_test11.prototype.CheckState(self)
	local state = { [MODIFIER_STATE_FROZEN] = true }
	return state
end
modifier_test11 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_test11)
____exports.modifier_test11 = modifier_test11
return ____exports