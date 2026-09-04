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
local CAST_RANGE = 900
local CAST_POINT = 0.67
local TOTAL_DURATION = 1.53
local CAST_DURATION = TOTAL_DURATION - CAST_POINT
local DAMAGE_RADIUS = 450
local DAMAGE_CENTER_DISTANCE = 450
local DAMAGE_RATE = 40
local HIT_EFFECT = "particles/unit/monster_13005death_hit.vpcf"
local AREA_EFFECT =
	"particles/econ/items/underlord/underlord_ti8_immortal_weapon/underlord_crimson_ti8_immortal_pitofmalice_pre.vpcf"
local SLASH_SOUND = "Hero_Kez.RaptorDance.Katana.Slash"
local DAMAGE_SOUND = "Hero_PhantomAssassin.CoupDeGrace"
local PARTICLE_POOL = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 普通技能37 - 堕影挥击：挥舞时对面前圆形区域造成伤害
____exports.normal_037 = __TS__Class()
local normal_037 = ____exports.normal_037
normal_037.name = "normal_037"
__TS__ClassExtends(normal_037, MonsterAbility_CS)
function normal_037.prototype.Precache(self, context)
	PrecacheResource("particle", HIT_EFFECT, context)
	PrecacheResource("particle", AREA_EFFECT, context)
end
function normal_037.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 6,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self:WarningRingEffect(self:GetHitCenter(caster, target), DAMAGE_RADIUS, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:SwingHit(caster)
		end,
	}
end
function normal_037.prototype.SwingHit(self, caster)
	local origin = self:GetCasterOrigin(caster)
	local forward = caster:GetForwardVector()
	local center = self:GetHitCenterByForward(caster, forward)
	caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(250)), 0.09)
	self:Timer(0.1, function()
		self:PlayAreaEffect(center)
		self:PlayHitEffect(origin, center, forward)
		self:PlayHitEffect2(origin, center, forward)
		EmitSoundOnLocationWithCaster(center, SLASH_SOUND, caster)
		self:DamageEnemies(caster, center)
		ScreenShake(center, 25, 25, 0.15, 2500, 0, true)
	end)
end
function normal_037.prototype.GetHitCenter(self, caster, target)
	if IsValidAlive(nil, target) then
		local origin = self:GetCasterOrigin(caster)
		local direction = GetDirection(nil, target:GetAbsOrigin(), origin)
		if direction:Length2D() > 0.01 then
			return self:GetHitCenterByForward(caster, direction)
		end
	end
	return self:GetHitCenterByForward(caster, caster:GetForwardVector())
end
function normal_037.prototype.GetHitCenterByForward(self, caster, forward)
	local origin = self:GetCasterOrigin(caster)
	return getGroundPosition(nil, origin:__add(forward:__mul(DAMAGE_CENTER_DISTANCE)), caster)
end
function normal_037.prototype.GetCasterOrigin(self, caster)
	return getGroundPosition(nil, caster:GetAbsOrigin(), caster)
end
function normal_037.prototype.PlayAreaEffect(self, center)
	local pfx = ParticleManager:CreateParticle(AREA_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControl(pfx, 1, Vector(DAMAGE_RADIUS, DAMAGE_RADIUS, DAMAGE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_037.prototype.PlayHitEffect(self, origin, center, forward)
	local pfx = ParticleManager:CreateParticle(HIT_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControl(pfx, 4, origin)
	ParticleManager:SetParticleControlForward(pfx, 4, forward)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_037.prototype.PlayHitEffect2(self, origin, center, forward)
	local pfx = ParticleManager:CreateParticle(PARTICLE_POOL, PATTACH_WORLDORIGIN, self._caster)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControl(pfx, 1, Vector(DAMAGE_RADIUS, DAMAGE_RADIUS, DAMAGE_RADIUS))
	ParticleManager:SetParticleControl(pfx, 2, Vector(DAMAGE_RADIUS, DAMAGE_RADIUS, DAMAGE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_037.prototype.DamageEnemies(self, caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			EmitSoundOn(DAMAGE_SOUND, enemy)
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue21::
	end
end
normal_037 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_037)
____exports.normal_037 = normal_037
return ____exports