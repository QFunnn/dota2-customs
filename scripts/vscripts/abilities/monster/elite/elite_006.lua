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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_POINT = 1
local CAST_RANGE = 1500
local AOE_RADIUS = 200
local DAMAGE_RATE = 25
local LIGHTNING_PARTICLE = "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf"
--- 精英技能6 - 蓄力指定英雄目标位置，1秒后落雷造成范围伤害。前摇时选定落点，释放时以预警落点为实际打击点
____exports.elite_006 = __TS__Class()
local elite_006 = ____exports.elite_006
elite_006.name = "elite_006"
__TS__ClassExtends(elite_006, MonsterAbility_CS)
function elite_006.prototype.Precache(self, context)
	PrecacheResource("particle", LIGHTNING_PARTICLE, context)
end
function elite_006.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local target = self:GetMinDistanceUnit(CAST_RANGE)
			if target then
				local pos = target:GetAbsOrigin()
				self._caster:SetForwardVector(GetDirection(nil, pos, self._caster:GetAbsOrigin()))
				self._lockedTargetPos = pos
				self:WarningRingEffect(pos, AOE_RADIUS, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Zuus.ArcLightning.Cast")
			local targetPos = self._lockedTargetPos or caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(500))
			self._lockedTargetPos = nil
			self:CreateLightningEffect(targetPos)
			self:DamageArea(targetPos, AOE_RADIUS, DAMAGE_RATE)
		end,
	}
end
function elite_006.prototype.CreateLightningEffect(self, origin)
	local ground = GetGroundPosition(origin, self:GetCaster())
	local landZ = ground.z + 25
	local skyHeight = 1200
	local center = Vector(ground.x, ground.y, landZ)
	self:SpawnLightning(Vector(ground.x, ground.y, ground.z + skyHeight), center)
	local dirs = GetRotateVectors(nil, Vector(1, 0, 0), 4, 90)
	local ring = AOE_RADIUS * 0.5
	for ____, d in ipairs(dirs) do
		local land = Vector(ground.x + d.x * ring, ground.y + d.y * ring, landZ)
		self:SpawnLightning(land:__add(Vector(0, 0, skyHeight)), land)
	end
end
function elite_006.prototype.SpawnLightning(self, start, ____end)
	local effect = ParticleManager:CreateParticle(LIGHTNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, start)
	ParticleManager:SetParticleControl(effect, 1, ____end)
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_006.prototype.DamageArea(self, origin, radius, damageRate)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
	end)
end
elite_006 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_006)
____exports.elite_006 = elite_006
return ____exports