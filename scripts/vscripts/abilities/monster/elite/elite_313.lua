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
local PARTICLE = "particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf"
____exports.elite_313 = __TS__Class()
local elite_313 = ____exports.elite_313
elite_313.name = "elite_313"
__TS__ClassExtends(elite_313, MonsterAbility_CS)
function elite_313.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
end
function elite_313.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.4,
		castDuration = 2.1,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 13,
		OnPhaseStart = function()
			return self:WarningRingEffect(self:GetCaster():GetAbsOrigin(), 620, 1.8)
		end,
		OnStart = function()
			return self:Spray()
		end,
	}
end
function elite_313.prototype.Spray(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	do
		local index = 0
		while index < 5 do
			local currentIndex = index
			self:Timer(currentIndex * 0.35, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local radius = 300 + currentIndex * 70
				local origin = caster:GetAbsOrigin()
				EmitSoundOn("Hero_Bristleback.QuillSpray.Cast", caster)
				self:PlayQuillSprayEffect(caster, origin, radius)
				self:DamageEnemiesInRadius(caster, origin, radius, currentIndex == 4 and 0.3 or 0)
			end)
			index = index + 1
		end
	end
end
function elite_313.prototype.PlayQuillSprayEffect(self, caster, origin, radius)
	local particle = ParticleManager:CreateParticle(PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_313.prototype.DamageEnemiesInRadius(self, caster, origin, radius, stunDuration)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue13
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = 5, ability = self, effectName = PARTICLE })
			if stunDuration > 0 then
				AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = stunDuration })
			end
		end
		::__continue13::
	end
end
elite_313 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_313)
____exports.elite_313 = elite_313
return ____exports