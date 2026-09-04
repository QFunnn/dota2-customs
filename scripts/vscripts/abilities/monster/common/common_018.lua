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
local ____tstl_2Dutils = require("utils.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local HEAL_MAX_HEALTH_PCT = 5
--- 怪物通用技能18 - 嗜血攻击：攻击命中敌人时恢复自身最大生命值的5%。
____exports.common_018 = __TS__Class()
local common_018 = ____exports.common_018
common_018.name = "common_018"
__TS__ClassExtends(common_018, MonsterAbility_CS)
function common_018.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function common_018.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_018"
end
common_018 = __TS__DecorateLegacy({
	registerAbility(nil),
	reloadable,
}, common_018)
____exports.common_018 = common_018
local modifier_common_018 = __TS__Class()
modifier_common_018.name = "modifier_common_018"
__TS__ClassExtends(modifier_common_018, MonsterModifier_CS)
function modifier_common_018.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_common_018.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ____opt_0 = target.GetUnitType
	local unitType = ____opt_0 and ____opt_0(target)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	local healAmount = parent:GetMaxHealth() * HEAL_MAX_HEALTH_PCT / 100
	if healAmount <= 0 then
		return
	end
	parent:CustomHeal(healAmount, { ability = ability, source = "spell" })
end
function modifier_common_018.prototype.IsHidden(self)
	return true
end
function modifier_common_018.prototype.IsPurgable(self)
	return false
end
modifier_common_018 = __TS__DecorateLegacy({
	registerModifier(nil, "modifier_common_018"),
	reloadable,
}, modifier_common_018)
return ____exports