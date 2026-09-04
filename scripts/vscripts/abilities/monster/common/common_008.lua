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
--- 每次攻击命中附加的冰冻层数
local ICE_STACK_PER_HIT = 1
--- 冰冻持续时间（秒），再次命中会刷新并叠层
local ICE_DURATION = 4
--- 怪物通用技能8 - 寒霜攻击：被动，攻击命中时为目标叠加通用冰冻
____exports.common_008 = __TS__Class()
local common_008 = ____exports.common_008
common_008.name = "common_008"
__TS__ClassExtends(common_008, MonsterAbility_CS)
function common_008.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function common_008.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_008"
end
common_008 = __TS__DecorateLegacy({ registerAbility(nil) }, common_008)
____exports.common_008 = common_008
local modifier_common_008 = __TS__Class()
modifier_common_008.name = "modifier_common_008"
__TS__ClassExtends(modifier_common_008, MonsterModifier_CS)
function modifier_common_008.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_common_008.prototype.OnAttackLanded_CS(self, event)
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
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.ICE_SLOW,
		{ stack = ICE_STACK_PER_HIT, duration = ICE_DURATION }
	)
	target:EmitSound("Hero_Ancient_Apparition.ChillingTouch.Target")
end
function modifier_common_008.prototype.IsHidden(self)
	return true
end
function modifier_common_008.prototype.IsPurgable(self)
	return false
end
modifier_common_008 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_common_008") }, modifier_common_008)
return ____exports