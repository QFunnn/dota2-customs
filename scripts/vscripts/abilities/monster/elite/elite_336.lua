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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local STORM_AMBIENT_PARTICLE = "particles/units/heroes/hero_brewmaster/brewmaster_storm_ambient.vpcf"
local STORM_STRIKE_PARTICLE =
	"particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_immortal_lightning.vpcf"
local STORM_STRIKE_SMALL_PARTICLE = "particles/units/heroes/hero_zuus/zuus_smaller_lightning_bolt.vpcf"
local STORM_STRIKE_RADIUS = 1200
local STORM_STRIKE_DELAY = 0.9
local STORM_STRIKE_WARNING_RADIUS = 150
local STORM_STRIKE_WARNING_TRACK_SPEED = 600
local STORM_STRIKE_DAMAGE_RATE = 20
local STORM_STRIKE_STUN_DURATION = 0.5
local STORM_STRIKE_SOUND = "Hero_Zuus.LightningBolt"
--- 酒仙风灵的预留精英技能。
____exports.elite_336 = __TS__Class()
local elite_336 = ____exports.elite_336
elite_336.name = "elite_336"
__TS__ClassExtends(elite_336, MonsterAbility_CS)
function elite_336.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castSequence = 0
end
function elite_336.prototype.Precache(self, context)
	PrecacheResource("particle", STORM_AMBIENT_PARTICLE, context)
	PrecacheResource("particle", STORM_STRIKE_PARTICLE, context)
	PrecacheResource("particle", STORM_STRIKE_SMALL_PARTICLE, context)
	PrecacheResource("soundfile", STORM_STRIKE_SOUND, context)
end
function elite_336.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_336_death_effect"
end
function elite_336.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = STORM_STRIKE_RADIUS,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		castPoint = STORM_STRIKE_DELAY,
		castDuration = 0,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, caster:GetMinDistanceUnit(STORM_STRIKE_RADIUS)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			return self:PrepareStormStrike()
		end,
		OnStart = function()
			return self:ReleaseStormStrike()
		end,
		OnInterrupt = function()
			return self:ClearStormStrikeState()
		end,
		OnFinish = function()
			return self:ClearStormStrikeState()
		end,
	}
end
function elite_336.prototype.PrepareStormStrike(self)
	local caster = self:GetCaster()
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(STORM_STRIKE_RADIUS)
	local ____self_1, ____castSequence_2 = self, "castSequence"
	local ____self_castSequence_3 = ____self_1[____castSequence_2] + 1
	____self_1[____castSequence_2] = ____self_castSequence_3
	local sequence = ____self_castSequence_3
	if not target or not IsValidAlive(nil, target) then
		self.lockedStrikePosition = nil
		return
	end
	local warningPosition = GetGroundPosition(target:GetAbsOrigin(), target)
	self.lockedStrikePosition = warningPosition
	caster:AddNewModifier(caster, self, "modifier_boss_brewmaster_2_face_nearest", { duration = STORM_STRIKE_DELAY })
	self:WarningRingEffect(warningPosition, STORM_STRIKE_WARNING_RADIUS, STORM_STRIKE_DELAY, {
		getCenter = function()
			if sequence ~= self.castSequence or not IsValidAlive(nil, caster) then
				return nil
			end
			if not IsValidAlive(nil, target) then
				return warningPosition
			end
			local targetPosition = GetGroundPosition(target:GetAbsOrigin(), target)
			local delta = targetPosition:__sub(warningPosition)
			local distance = delta:Length2D()
			local maxStep = STORM_STRIKE_WARNING_TRACK_SPEED * 0.03
			local ____temp_4
			if distance > maxStep then
				____temp_4 = warningPosition:__add(delta:Normalized():__mul(maxStep))
			else
				____temp_4 = targetPosition
			end
			warningPosition = ____temp_4
			self.lockedStrikePosition = warningPosition
			return warningPosition
		end,
	})
end
function elite_336.prototype.ReleaseStormStrike(self)
	local caster = self:GetCaster()
	local targetPosition = self.lockedStrikePosition
	if not IsServer() or not IsValidAlive(nil, caster) or not targetPosition then
		return
	end
	local lightning = ParticleManager:CreateParticle(STORM_STRIKE_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(lightning, 1, targetPosition)
	ParticleManager:SetParticleControl(lightning, 0, targetPosition:__add(Vector(0, 0, 1500)))
	ParticleManager:ReleaseParticleIndex(lightning)
	local smallerLightning = ParticleManager:CreateParticle(STORM_STRIKE_SMALL_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(smallerLightning, 0, targetPosition:__add(Vector(0, 0, 1500)))
	ParticleManager:SetParticleControl(smallerLightning, 1, targetPosition)
	ParticleManager:ReleaseParticleIndex(smallerLightning)
	EmitSoundOnLocationWithCaster(targetPosition, STORM_STRIKE_SOUND, caster)
	for ____, enemy in ipairs(self:FindUnitInRange(targetPosition, STORM_STRIKE_WARNING_RADIUS)) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue18
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = STORM_STRIKE_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STORM_STRIKE_STUN_DURATION })
		end
		::__continue18::
	end
end
function elite_336.prototype.ClearStormStrikeState(self)
	self.castSequence = self.castSequence + 1
	self.lockedStrikePosition = nil
end
elite_336 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_336)
____exports.elite_336 = elite_336
local modifier_elite_336_death_effect = __TS__Class()
modifier_elite_336_death_effect.name = "modifier_elite_336_death_effect"
__TS__ClassExtends(modifier_elite_336_death_effect, MonsterModifier_CS)
function modifier_elite_336_death_effect.prototype.GetEffectName(self)
	return STORM_AMBIENT_PARTICLE
end
function modifier_elite_336_death_effect.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_elite_336_death_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_336_death_effect") }, modifier_elite_336_death_effect)
return ____exports