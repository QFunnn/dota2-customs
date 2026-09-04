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
local RADIUS = 420
local PARTICLE = "particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axes_melee.vpcf"
local BUFF_PARTICLE = "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf"
____exports.elite_317 = __TS__Class()
local elite_317 = ____exports.elite_317
elite_317.name = "elite_317"
__TS__ClassExtends(elite_317, MonsterAbility_CS)
function elite_317.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
	PrecacheResource("particle", BUFF_PARTICLE, context)
end
function elite_317.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.5,
		castDuration = 2.2,
		castAnimation = ACT_DOTA_CAST_ABILITY_6,
		cooldown = 14,
		OnPhaseStart = function()
			return self:WarningRingEffect(self:GetCaster():GetAbsOrigin(), RADIUS, 1.8)
		end,
		OnStart = function()
			return self:Dance()
		end,
	}
end
function elite_317.prototype.Dance(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn("Hero_TrollWarlord.BattleTrance.Cast", caster)
	local buff = ParticleManager:CreateParticle(BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		buff,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	do
		local index = 0
		while index < 5 do
			local currentIndex = index
			self:Timer(currentIndex * 0.32, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0.03, 0.12, 1.6)
				local origin = caster:GetAbsOrigin()
				self:PlayWhirlingAxeEffect(caster, origin, currentIndex)
				self:DamageEnemiesInRadius(caster, origin, currentIndex == 4 and 0.35 or 0)
			end)
			index = index + 1
		end
	end
	self:Timer(1.9, function()
		ParticleManager:DestroyParticle(buff, false)
		ParticleManager:ReleaseParticleIndex(buff)
	end)
end
function elite_317.prototype.PlayWhirlingAxeEffect(self, caster, origin, pulseIndex)
	local particle = ParticleManager:CreateParticle(PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(RADIUS, pulseIndex, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_317.prototype.DamageEnemiesInRadius(self, caster, origin, stunDuration)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		RADIUS,
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
			caster:MonsterDamage({ victim = enemy, damage_rate = 6, ability = self, effectName = PARTICLE })
			if stunDuration > 0 then
				AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = stunDuration })
			end
		end
		::__continue14::
	end
end
elite_317 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_317)
____exports.elite_317 = elite_317
return ____exports