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
local HEAL_MAX_HEALTH_PCT = 1
local HEAL_SOUND = "Hero_Oracle.FalsePromise.Healed"
--- normal_045 - 疗愈：每次受到敌方攻击时，恢复自身最大生命值的 1%。
____exports.normal_045 = __TS__Class()
local normal_045 = ____exports.normal_045
normal_045.name = "normal_045"
__TS__ClassExtends(normal_045, MonsterAbility_CS)
function normal_045.prototype.Precache(self, context) end
function normal_045.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_045.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_normal_045.name
end
normal_045 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_045)
____exports.normal_045 = normal_045
____exports.modifier_normal_045 = __TS__Class()
local modifier_normal_045 = ____exports.modifier_normal_045
modifier_normal_045.name = "modifier_normal_045"
__TS__ClassExtends(modifier_normal_045, MonsterModifier_CS)
function modifier_normal_045.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_normal_045.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local attacker = event.attacker
	if not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local healAmount = parent:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT / 100)
	if healAmount <= 0 then
		return
	end
	local healEvent = parent:CustomHeal(healAmount, { ability = ability, source = "spell" })
	if healEvent.actual_amount <= 0 then
		return
	end
end
function modifier_normal_045.prototype.IsHidden(self)
	return true
end
function modifier_normal_045.prototype.IsPurgable(self)
	return false
end
modifier_normal_045 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_045)
____exports.modifier_normal_045 = modifier_normal_045
return ____exports