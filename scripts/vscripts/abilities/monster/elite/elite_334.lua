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
local modifier_elite_334_attack_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local EARTH_AMBIENT_PARTICLE = "particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient.vpcf"
local EARTH_ATTACK_SLOW_DURATION = 5
local EARTH_ATTACK_SLOW_PCT = 15
--- 酒仙土灵的预留精英技能。
____exports.elite_334 = __TS__Class()
local elite_334 = ____exports.elite_334
elite_334.name = "elite_334"
__TS__ClassExtends(elite_334, MonsterAbility_CS)
function elite_334.prototype.Precache(self, context)
	PrecacheResource("particle", EARTH_AMBIENT_PARTICLE, context)
end
function elite_334.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_334_death_effect"
end
function elite_334.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = bit.bor(DOTA_ABILITY_BEHAVIOR_PASSIVE, DOTA_ABILITY_BEHAVIOR_HIDDEN),
		castDuration = 0,
	}
end
elite_334 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_334)
____exports.elite_334 = elite_334
local modifier_elite_334_death_effect = __TS__Class()
modifier_elite_334_death_effect.name = "modifier_elite_334_death_effect"
__TS__ClassExtends(modifier_elite_334_death_effect, MonsterModifier_CS)
function modifier_elite_334_death_effect.prototype.GetEffectName(self)
	return EARTH_AMBIENT_PARTICLE
end
function modifier_elite_334_death_effect.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_334_death_effect.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_334_death_effect.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	local ability = self:GetAbility()
	if not ability or ability:IsNull() or not IsValidAlive(nil, target) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	modifier_elite_334_attack_slow:applys(target, parent, ability, { duration = EARTH_ATTACK_SLOW_DURATION })
end
modifier_elite_334_death_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_334_death_effect") }, modifier_elite_334_death_effect)
modifier_elite_334_attack_slow = __TS__Class()
modifier_elite_334_attack_slow.name = "modifier_elite_334_attack_slow"
__TS__ClassExtends(modifier_elite_334_attack_slow, MonsterModifier_CS)
function modifier_elite_334_attack_slow.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_elite_334_attack_slow.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = -EARTH_ATTACK_SLOW_PCT, bonus_movespeed_pct = -EARTH_ATTACK_SLOW_PCT }
end
function modifier_elite_334_attack_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_334_attack_slow.prototype.IsPurgable(self)
	return true
end
modifier_elite_334_attack_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_334_attack_slow") }, modifier_elite_334_attack_slow)
return ____exports