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
local ____elite_063 = require("abilities.monster.elite.elite_063")
local LICH_SPIRE_BOUNCE_DISTANCE = ____elite_063.LICH_SPIRE_BOUNCE_DISTANCE
local LICH_SPIRE_KEY = ____elite_063.LICH_SPIRE_KEY
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_RANGE = 900
local CAST_POINT = 0.45
local BOUNCE_RADIUS = LICH_SPIRE_BOUNCE_DISTANCE + 100
local PROJECTILE_SPEED = 900
local MAX_BOUNCES = 12
local DAMAGE_RATE = 18
local SLOW_STACK = 3
local SLOW_DURATION = 1.6
local PROJECTILE_PARTICLE = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"
local CHAIN_FROST_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_lich.vsndevts"
local CHAIN_FROST_CAST_SOUND = "Hero_Lich.ChainFrost"
local CHAIN_FROST_IMPACT_SOUND = "Hero_Lich.ChainFrostImpact.Creep"
--- 精英技能64 - 连环霜冻：冰球在敌人与冰柱之间弹射，命中敌人造成伤害和寒冷减速
____exports.elite_064 = __TS__Class()
local elite_064 = ____exports.elite_064
elite_064.name = "elite_064"
__TS__ClassExtends(elite_064, MonsterAbility_CS)
function elite_064.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.firstTarget = nil
end
function elite_064.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("soundfile", CHAIN_FROST_SOUND_EVENTS, context)
end
function elite_064.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				return
			end
			self.firstTarget = target
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = self.firstTarget
			self.firstTarget = nil
			if not IsServer() or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			EmitSoundOn(CHAIN_FROST_CAST_SOUND, caster)
			self:LaunchBounce(caster:GetAbsOrigin():__add(Vector(0, 0, 120)), { kind = "unit", unit = target }, 0)
		end,
	}
end
function elite_064.prototype.LaunchBounce(self, source, target, bounceIndex)
	local caster = self:GetCaster()
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local projectileTarget = self:GetProjectileTarget(target)
	if not projectileTarget then
		return
	end
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "tracking",
		projectile_speed = PROJECTILE_SPEED,
		start_point = source,
		target = projectileTarget,
		on_hit = function(____, _hitTarget, location)
			if not IsValid(nil, self) or self:IsNull() or not IsValidAlive(nil, caster) then
				return true
			end
			local currentPos = self:GetTargetPosition(target) or location
			if not currentPos then
				return true
			end
			self:ImpactTarget(target)
			if bounceIndex + 1 >= MAX_BOUNCES then
				return true
			end
			local next = self:FindNextTarget(target, currentPos)
			if not next then
				return true
			end
			self:LaunchBounce(currentPos:__add(Vector(0, 0, 96)), next, bounceIndex + 1)
			return true
		end,
	})
end
function elite_064.prototype.GetProjectileTarget(self, target)
	if target.kind == "unit" then
		local ____IsValidAlive_result_0
		if IsValidAlive(nil, target.unit) then
			____IsValidAlive_result_0 = target.unit
		else
			____IsValidAlive_result_0 = nil
		end
		return ____IsValidAlive_result_0
	end
	local thinker = target.spire.thinker
	if not thinker or not IsValid(nil, thinker) or thinker:IsNull() then
		return nil
	end
	return thinker
end
function elite_064.prototype.ImpactTarget(self, target)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if target.kind ~= "unit" then
		return
	end
	local enemy = target.unit
	if not IsValidAlive(nil, enemy) then
		return
	end
	EmitSoundOn(CHAIN_FROST_IMPACT_SOUND, enemy)
	caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
	AddDeBuffStatus(
		nil,
		enemy,
		caster,
		self,
		DebuffStatusType.ICE_SLOW,
		{ stack = SLOW_STACK, duration = SLOW_DURATION }
	)
end
function elite_064.prototype.FindNextTarget(self, current, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		BOUNCE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local bestEnemy = nil
	local bestEnemyDistance = 999999
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue25
			end
			if current.kind == "unit" and current.unit == enemy then
				goto __continue25
			end
			local dist = GetDistance(nil, origin, enemy:GetAbsOrigin())
			if dist < bestEnemyDistance then
				bestEnemy = { kind = "unit", unit = enemy }
				bestEnemyDistance = dist
			end
		end
		::__continue25::
	end
	if bestEnemy then
		return bestEnemy
	end
	local bestSpire = nil
	local bestSpireDistance = 999999
	for ____, spire in ipairs(self:GetActiveSpires(caster)) do
		do
			if current.kind == "spire" and current.spire.id == spire.id then
				goto __continue31
			end
			if GetDistance(nil, origin, spire.pos) > BOUNCE_RADIUS then
				goto __continue31
			end
			local pos = self:GetTargetPosition({ kind = "spire", spire = spire })
			if not pos then
				goto __continue31
			end
			local dist = GetDistance(nil, origin, pos)
			if dist < bestSpireDistance then
				bestSpire = { kind = "spire", spire = spire }
				bestSpireDistance = dist
			end
		end
		::__continue31::
	end
	return bestSpire
end
function elite_064.prototype.GetActiveSpires(self, caster)
	local list = caster[LICH_SPIRE_KEY] or {}
	local now = GameRules:GetGameTime()
	local active = {}
	for ____, spire in ipairs(list) do
		do
			if not IsValidAlive(nil, spire.thinker) then
				goto __continue38
			end
			if not spire.thinker or not IsValid(nil, spire.thinker) or spire.thinker:IsNull() then
				goto __continue38
			end
			if spire.endTime <= now then
				goto __continue38
			end
			spire.pos = spire.thinker:GetAbsOrigin()
			active[#active + 1] = spire
		end
		::__continue38::
	end
	caster[LICH_SPIRE_KEY] = active
	return active
end
function elite_064.prototype.GetTargetPosition(self, target)
	if target.kind == "unit" then
		if not IsValidAlive(nil, target.unit) then
			return nil
		end
		return target.unit:GetAbsOrigin()
	end
	local thinker = target.spire.thinker
	if not thinker or not IsValid(nil, thinker) or thinker:IsNull() then
		return nil
	end
	if not IsValidAlive(nil, thinker) then
		return nil
	end
	target.spire.pos = thinker:GetAbsOrigin()
	return target.spire.pos
end
elite_064 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_064)
____exports.elite_064 = elite_064
return ____exports