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
local ICE_STACK_PER_HIT = 1
local ICE_DURATION = 2
local ICE_HIT_PARTICLE = "particles/units/heroes/hero_drow/drow_base_attack.vpcf"
--- 普通技能25：暗影箭毒，攻击命中时为目标附加短暂冰缓
____exports.normal_025 = __TS__Class()
local normal_025 = ____exports.normal_025
normal_025.name = "normal_025"
__TS__ClassExtends(normal_025, MonsterAbility_CS)
function normal_025.prototype.Precache(self, context)
	PrecacheResource("particle", ICE_HIT_PARTICLE, context)
end
function normal_025.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_025.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_025"
end
normal_025 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_025)
____exports.normal_025 = normal_025
local modifier_normal_025 = __TS__Class()
modifier_normal_025.name = "modifier_normal_025"
__TS__ClassExtends(modifier_normal_025, MonsterModifier_CS)
function modifier_normal_025.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_025.prototype.OnAttackLanded_CS(self, event)
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
	if not self:IsValidEnemyTarget(parent, target) then
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
	parent:EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Tick")
end
function modifier_normal_025.prototype.IsValidEnemyTarget(self, parent, target)
	if not target or not IsValidAlive(nil, target) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	local ____this_1
	____this_1 = target
	local ____opt_0 = ____this_1.GetUnitType
	local unitType = ____opt_0 and ____opt_0(____this_1)
	return unitType ~= UnitType.BUILDING and unitType ~= UnitType.DESTRUCTIBLE
end
function modifier_normal_025.prototype.IsHidden(self)
	return true
end
function modifier_normal_025.prototype.IsPurgable(self)
	return false
end
modifier_normal_025 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_025") }, modifier_normal_025)
return ____exports