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
--- 前摇时间（秒）
local CAST_POINT = 0.3
--- 起跳后到落地的时间
local JUMP_DURATION = 0.8
--- 施法持续阶段覆盖完整跳砸动作
local CAST_DURATION = JUMP_DURATION + 0.2
--- 跳起高度
local JUMP_HEIGHT = 420
--- 砸地伤害范围
local SMASH_RADIUS = 360
--- 砸地伤害系数
local DAMAGE_RATE = 30
--- 命中后击飞持续时间
local KNOCKBACK_DURATION = 0.35
--- 命中后击飞高度
local KNOCKBACK_HEIGHT = 260
local SMASH_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf"
local JUMP_SOUND = "Ability.TossThrow"
local LAND_SOUND = "Hero_Centaur.HoofStomp"
--- 跳跃砸地：原地跳起一次，落地时造成范围伤害并击飞。
____exports.elite_142 = __TS__Class()
local elite_142 = ____exports.elite_142
elite_142.name = "elite_142"
__TS__ClassExtends(elite_142, MonsterAbility_CS)
function elite_142.prototype.Precache(self, context)
	PrecacheResource("particle", SMASH_PARTICLE, context)
end
function elite_142.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 0,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 1,
		castPointDamageReduction = 0.4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				self.lockedLandPos = nil
				return
			end
			self.lockedLandPos = GetGroundPosition(caster:GetAbsOrigin(), caster)
			self:WarningRingEffect(self.lockedLandPos, SMASH_RADIUS, CAST_POINT + JUMP_DURATION)
		end,
		OnStart = function()
			self:JumpAndSmash()
		end,
		OnFinish = function()
			self.lockedLandPos = nil
		end,
		OnInterrupt = function()
			self.lockedLandPos = nil
		end,
	}
end
function elite_142.prototype.JumpAndSmash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local landPos = self.lockedLandPos or origin
	local peak = origin:__add(Vector(0, 0, JUMP_HEIGHT))
	EmitSoundOn(JUMP_SOUND, caster)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	caster:Bezier2Mover({ origin, peak, landPos }, JUMP_DURATION, nil, true, true)
	self:Timer(JUMP_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, landPos, false)
		self:SmashAt(caster, landPos)
	end)
end
function elite_142.prototype.SmashAt(self, caster, origin)
	local smashPoint = GetGroundPosition(origin, caster)
	EmitSoundOnLocationWithCaster(smashPoint, LAND_SOUND, caster)
	self:PlaySmashEffect(smashPoint)
	ScreenShake(smashPoint, 18, 18, 0.45, 1800, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		smashPoint,
		nil,
		SMASH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue14
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self, damage_type = 2 })
			enemy:KnockBack(caster, self, {
				origin_pos = smashPoint,
				duration = KNOCKBACK_DURATION,
				distance = 0,
				height = KNOCKBACK_HEIGHT,
				stun = true,
				stunDuration = KNOCKBACK_DURATION,
				particleName = "",
			})
		end
		::__continue14::
	end
end
function elite_142.prototype.PlaySmashEffect(self, origin)
	local particle = ParticleManager:CreateParticle(SMASH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(SMASH_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
elite_142 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_142)
____exports.elite_142 = elite_142
return ____exports