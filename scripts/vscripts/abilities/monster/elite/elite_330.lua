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
local NATIVE_CRUSH_ABILITY = "slardar_slithereen_crush"
local CRUSH_CAST_RANGE = 350
local CRUSH_CAST_POINT = 0.45
local CRUSH_CAST_DURATION = 0.1
local FALLBACK_DAMAGE_RATE = 20
local FALLBACK_STUN_DURATION = 0.8
local CRUSH_PARTICLE = "particles/units/heroes/hero_slardar/ak_slardar_crush.vpcf"
local CRUSH_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_slardar.vsndevts"
local CRUSH_SOUND = "Hero_Slardar.Slithereen_Crush"
____exports.elite_330 = __TS__Class()
local elite_330 = ____exports.elite_330
elite_330.name = "elite_330"
__TS__ClassExtends(elite_330, MonsterAbility_CS)
function elite_330.prototype.Precache(self, context)
	PrecacheResource("particle", CRUSH_PARTICLE, context)
	PrecacheResource("soundfile", CRUSH_SOUND_EVENTS, context)
end
function elite_330.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CRUSH_CAST_RANGE,
		castPoint = CRUSH_CAST_POINT,
		castDuration = CRUSH_CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		castProgressBarColor = "red",
		OnPhaseStart = function()
			return self:ShowCrushWarning()
		end,
		OnStart = function()
			return self:CastNativeCrush()
		end,
	}
end
function elite_330.prototype.ShowCrushWarning(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CRUSH_CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CRUSH_CAST_POINT)
	end
	self:WarningRingEffect(caster:GetAbsOrigin(), CRUSH_CAST_RANGE, CRUSH_CAST_POINT, { follow = true })
end
function elite_330.prototype.CastNativeCrush(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local nativeAbility = self:EnsureNativeCrush(caster)
	if not nativeAbility then
		self:FallbackCrush(caster)
		return
	end
	nativeAbility:EndCooldown()
	self:EnsureNativeAbilityMana(caster, nativeAbility)
	caster:CastAbilityImmediately(nativeAbility, caster:GetPlayerOwnerID())
end
function elite_330.prototype.EnsureNativeCrush(self, caster)
	local ability = caster:FindAbilityByName(NATIVE_CRUSH_ABILITY)
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		ability = caster:AddAbility(NATIVE_CRUSH_ABILITY)
	end
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return nil
	end
	if ability:GetLevel() <= 0 then
		ability:SetLevel(1)
	end
	ability:SetHidden(true)
	ability:SetActivated(true)
	return ability
end
function elite_330.prototype.EnsureNativeAbilityMana(self, caster, ability)
	local manaCost = ability:GetManaCost(math.max(ability:GetLevel() - 1, 0))
	local missingMana = manaCost - caster:GetMana()
	if missingMana > 0 then
		caster:GiveMana(missingMana)
	end
end
function elite_330.prototype.FallbackCrush(self, caster)
	WarningPrint(
		("[elite_330] 无法添加原生技能 " .. NATIVE_CRUSH_ABILITY) .. "，使用同粒子的兜底效果。"
	)
	local origin = caster:GetAbsOrigin()
	local particle = ParticleManager:CreateParticle(CRUSH_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(1, 1, CRUSH_CAST_RANGE))
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOnLocationWithCaster(origin, CRUSH_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		CRUSH_CAST_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = FALLBACK_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = FALLBACK_STUN_DURATION })
		end
		::__continue19::
	end
end
elite_330 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_330)
____exports.elite_330 = elite_330
return ____exports