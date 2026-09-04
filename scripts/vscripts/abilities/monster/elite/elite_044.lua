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
local REFLECT_DAMAGE_RATE = 5
local REFLECT_RADIUS = 250
local BUFF_DURATION = 4
--- 精英技能44 - 伤害反射
____exports.elite_044 = __TS__Class()
local elite_044 = ____exports.elite_044
elite_044.name = "elite_044"
__TS__ClassExtends(elite_044, MonsterAbility_CS)
function elite_044.prototype.Precache(self, context)
	PrecacheResource(
		"particle",
		"particles/econ/items/spectre/spectre_arcana/spectre_arcana_blademail_v2.vpcf",
		context
	)
	PrecacheResource("particle", "particles/spectre_arcana_minigame_v2_death_target_1.vpcf", context)
end
function elite_044.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.5,
		castDuration = 0.3,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.6,
		castRange = 1000,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("DOTA_Item.BladeMail.Activate")
			____exports.modifier_elite_044_reflect:applys(caster, caster, self, { duration = BUFF_DURATION })
		end,
	}
end
elite_044 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_044)
____exports.elite_044 = elite_044
____exports.modifier_elite_044_reflect = __TS__Class()
local modifier_elite_044_reflect = ____exports.modifier_elite_044_reflect
modifier_elite_044_reflect.name = "modifier_elite_044_reflect"
__TS__ClassExtends(modifier_elite_044_reflect, MonsterModifier_CS)
function modifier_elite_044_reflect.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._lastReflectTime = 0
end
function modifier_elite_044_reflect.prototype.OnCreated(self, params)
	if IsServer() then
		self._particleId = ParticleManager:CreateParticle(
			"particles/econ/items/spectre/spectre_arcana/spectre_arcana_blademail_v2.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
	end
end
function modifier_elite_044_reflect.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_elite_044_reflect.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.victim ~= parent then
		return
	end
	local ____opt_0 = event.source
	if ____opt_0 and ____opt_0.debuff_status then
		return
	end
	local now = GameRules:GetGameTime()
	if now - self._lastReflectTime < 0.1 then
		return
	end
	self._lastReflectTime = now
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		REFLECT_RADIUS,
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
			parent:MonsterDamage({ victim = enemy, damage_rate = REFLECT_DAMAGE_RATE, ability = ability })
			EmitSoundOn("DOTA_Item.BladeMail.Damage", enemy)
			local reflectParticle = ParticleManager:CreateParticle(
				"particles/spectre_arcana_minigame_v2_death_target_1.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			ParticleManager:ReleaseParticleIndex(reflectParticle)
		end
		::__continue14::
	end
end
function modifier_elite_044_reflect.prototype.OnDestroy(self)
	if IsServer() and self._particleId ~= -1 then
		ParticleManager:DestroyParticle(self._particleId, false)
		ParticleManager:ReleaseParticleIndex(self._particleId)
	end
end
function modifier_elite_044_reflect.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_elite_044_reflect.GetLocalizationCN(self)
	return { name = "伤害反射", description = "受到伤害时向自身附近敌人反弹伤害。" }
end
modifier_elite_044_reflect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_044_reflect)
____exports.modifier_elite_044_reflect = modifier_elite_044_reflect
return ____exports