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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local LINA_002_FIRESTORM_WAVE_PARTICLE = "particles/hero/lina/lina001.vpcf"
local LINA_002_FIXED_DAMAGE_PER_TICK = 5
____exports.lina_002 = __TS__Class()
local lina_002 = ____exports.lina_002
lina_002.name = "lina_002"
__TS__ClassExtends(lina_002, BaseHeroAbility)
function lina_002.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_002_FIRESTORM_WAVE_PARTICLE, context)
end
function lina_002.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.45,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		behavior = bit.bor(DOTA_ABILITY_BEHAVIOR_POINT, DOTA_ABILITY_BEHAVIOR_AOE),
	}
end
function lina_002.prototype.GetRainRadius(self)
	return self:GetSpecialValue("lina_002", "rain_radius")
end
function lina_002.prototype.GetRainDuration(self)
	return self:GetSpecialValue("lina_002", "rain_duration")
end
function lina_002.prototype.GetRainInterval(self)
	return self:GetSpecialValue("lina_002", "rain_interval")
end
function lina_002.prototype.GetAttackDamagePctPerTick(self)
	return self:GetSpecialValue("lina_002", "per_tick_damage_pct")
end
function lina_002.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local center = self:GetCursorPosition():__add(Vector(0, 0, 0))
	local radius = self:GetRainRadius()
	local duration = self:GetRainDuration()
	local interval = self:GetRainInterval()
	if interval <= 0 then
		return
	end
	self:PlayFirestormWave(center, radius)
	self:DealRainDamage(caster, center, radius)
	local elapsedDuration = 0
	Timers:CreateTimer(interval, function()
		if not IsValidAlive(nil, caster) then
			return nil
		end
		elapsedDuration = elapsedDuration + interval
		if elapsedDuration > duration then
			return nil
		end
		self:PlayFirestormWave(center, radius)
		self:DealRainDamage(caster, center, radius)
		return interval
	end)
end
function lina_002.prototype.DealRainDamage(self, caster, center, radius)
	local attackDamagePctPerTick = self:GetAttackDamagePctPerTick()
	local damage = self:GetAllAttackDamage(caster) * attackDamagePctPerTick / 100 + LINA_002_FIXED_DAMAGE_PER_TICK
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(caster, center, radius, self)
	end
	local enemies = self:FindMonsterEnemies(center, radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = self,
			})
		end
		::__continue15::
	end
end
function lina_002.prototype.PlayFirestormWave(self, center, radius)
	local caster = self:GetCaster()
	local pid =
		MyGameHeroParticleManager:CreateParticle(LINA_002_FIRESTORM_WAVE_PARTICLE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, center)
	MyGameHeroParticleManager:SetParticleControl(pid, 4, Vector(radius, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
lina_002 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_002)
____exports.lina_002 = lina_002
return ____exports