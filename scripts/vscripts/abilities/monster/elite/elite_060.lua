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
local modifier_elite_060_slow_field, modifier_elite_060_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1.43
local STRIKE_DURATION = 8.57
local SEARCH_RADIUS = 1500
local STRIKE_RADIUS = 128
local STRIKE_INTERVAL = 1
local EXPLOSION_DELAY = 0.4
local EXPLOSION_DAMAGE_DELAY = 0.4
local LINE_LENGTH = 500
local LINE_STEP = 125
local LINE_EXPLOSION_INTERVAL = 0.05
local DAMAGE_RATE = 8
local CASTER_FIELD_RADIUS = 650
local SLOW_FIELD_RADIUS = 900
local SLOW_FIELD_PCT = 40
local SLOW_FIELD_INTERVAL = 0.2
local SLOW_FIELD_DEBUFF_DURATION = 0.35
local SNOW_SHARD_PARTICLE =
	"particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_snow_shard.vpcf"
local EXPLOSION_PARTICLE = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"
local FREEZING_FIELD_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts"
local FREEZING_FIELD_SOUND = "hero_Crystal.freezingField.wind"
local EXPLOSION_SOUND = "hero_Crystal.freezingField.explosion"
--- 精英技能60 - 极寒追击：持续对英雄脚下生成线性冰爆轰炸
____exports.elite_060 = __TS__Class()
local elite_060 = ____exports.elite_060
elite_060.name = "elite_060"
__TS__ClassExtends(elite_060, MonsterAbility_CS)
function elite_060.prototype.Precache(self, context)
	PrecacheResource("particle", SNOW_SHARD_PARTICLE, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
	PrecacheResource("soundfile", FREEZING_FIELD_SOUND_EVENTS, context)
end
function elite_060.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = STRIKE_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(SEARCH_RADIUS)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			return self:StartTrackingStrikes()
		end,
	}
end
function elite_060.prototype.StartTrackingStrikes(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayCasterFieldEffect(caster)
	EmitSoundOn(FREEZING_FIELD_SOUND, caster)
	modifier_elite_060_slow_field:remove(caster)
	modifier_elite_060_slow_field:applys(caster, caster, self, { duration = STRIKE_DURATION })
	self:Timer(STRIKE_DURATION, function()
		if IsValidAlive(nil, caster) then
			StopSoundOn(FREEZING_FIELD_SOUND, caster)
		end
	end)
	local strikeCount = math.floor(STRIKE_DURATION / STRIKE_INTERVAL)
	do
		local i = 0
		while i < strikeCount do
			self:Timer(i * STRIKE_INTERVAL, function()
				local currentCaster = self:GetCaster()
				if not IsValidAlive(nil, currentCaster) then
					return
				end
				self:LaunchLineStrikesAtHeroes(currentCaster)
			end)
			i = i + 1
		end
	end
end
function elite_060.prototype.LaunchLineStrikesAtHeroes(self, caster)
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, hero in ipairs(heroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue15
			end
			self:LaunchLineStrikeAtPoint(caster, GetGroundPosition(hero:GetAbsOrigin(), hero))
		end
		::__continue15::
	end
end
function elite_060.prototype.LaunchLineStrikeAtPoint(self, caster, center)
	local direction = self:GetLineDirectionThroughTarget(caster, center)
	local halfLength = LINE_LENGTH * 0.5
	local start = GetGroundPosition(center:__add(direction:__mul(-halfLength)), caster)
	local ____end = GetGroundPosition(center:__add(direction:__mul(halfLength)), caster)
	self:WarningEffect(start, ____end, EXPLOSION_DELAY, { startWidth = STRIKE_RADIUS, endWidth = STRIKE_RADIUS })
	local points = self:BuildLinePoints(start, ____end)
	do
		local i = 0
		while i < #points do
			local targetPos = points[i + 1]
			self:Timer(EXPLOSION_DELAY + i * LINE_EXPLOSION_INTERVAL, function()
				return self:ExplodeAt(targetPos)
			end)
			i = i + 1
		end
	end
end
function elite_060.prototype.GetLineDirectionThroughTarget(self, caster, center)
	local raw = center:__sub(caster:GetAbsOrigin())
	if raw:Length2D() > 1 then
		return raw:Normalized()
	end
	return caster:GetForwardVector():Normalized()
end
function elite_060.prototype.BuildLinePoints(self, start, ____end)
	local delta = ____end:__sub(start)
	local distance = delta:Length2D()
	local ____temp_0
	if distance > 0 then
		____temp_0 = delta:Normalized()
	else
		____temp_0 = Vector(1, 0, 0)
	end
	local direction = ____temp_0
	local count = math.max(1, math.ceil(distance / LINE_STEP))
	local points = {}
	do
		local i = 0
		while i <= count do
			local t = i / count
			points[#points + 1] = GetGroundPosition(start:__add(direction:__mul(distance * t)), self:GetCaster())
			i = i + 1
		end
	end
	return points
end
function elite_060.prototype.PlayCasterFieldEffect(self, caster)
	local pfx = ParticleManager:CreateParticle(SNOW_SHARD_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(CASTER_FIELD_RADIUS, CASTER_FIELD_RADIUS, CASTER_FIELD_RADIUS))
	self:Timer(STRIKE_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_060.prototype.ExplodeAt(self, pos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(STRIKE_RADIUS, STRIKE_RADIUS, STRIKE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(pos, EXPLOSION_SOUND, caster)
	self:Timer(EXPLOSION_DAMAGE_DELAY, function()
		return self:DamageAt(pos)
	end)
end
function elite_060.prototype.DamageAt(self, pos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		STRIKE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue32::
	end
end
elite_060 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_060)
____exports.elite_060 = elite_060
modifier_elite_060_slow_field = __TS__Class()
modifier_elite_060_slow_field.name = "modifier_elite_060_slow_field"
__TS__ClassExtends(modifier_elite_060_slow_field, MonsterModifier_CS)
function modifier_elite_060_slow_field.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(SLOW_FIELD_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_060_slow_field.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:OnIntervalThink()
end
function modifier_elite_060_slow_field.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		SLOW_FIELD_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue42
			end
			modifier_elite_060_slow:applys(enemy, caster, ability, { duration = SLOW_FIELD_DEBUFF_DURATION })
		end
		::__continue42::
	end
end
function modifier_elite_060_slow_field.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_060_slow_field.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_elite_060_slow_field =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_060_slow_field") }, modifier_elite_060_slow_field)
modifier_elite_060_slow = __TS__Class()
modifier_elite_060_slow.name = "modifier_elite_060_slow"
__TS__ClassExtends(modifier_elite_060_slow, MonsterModifier_CS)
function modifier_elite_060_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SLOW_FIELD_PCT }
end
function modifier_elite_060_slow.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true }
end
function modifier_elite_060_slow.prototype.GetTexture(self)
	return "crystal_maiden_freezing_field"
end
function modifier_elite_060_slow.GetLocalizationCN(self)
	return { name = "极寒追击", description = "移动速度降低40%。" }
end
modifier_elite_060_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_060_slow") }, modifier_elite_060_slow)
return ____exports