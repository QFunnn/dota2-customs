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
local modifier_elite_036_stack
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 单次普攻叠加层数
local STACK_PER_HIT = 1
--- 层数大于该值时触发眩晕并清空（即第 6 层触发）
local STACK_STUN_THRESHOLD = 5
--- 眩晕时间（秒），实际时长受眩晕抗性缩减
local STUN_DURATION = 2
--- 未继续叠层时印记持续时间（秒），每次命中刷新
local STACK_MARK_DURATION = 8
--- 精英技能36 - 被动：普攻为目标叠加重击印记，层数大于 5 时眩晕 2 秒并清空层数。
____exports.elite_036 = __TS__Class()
local elite_036 = ____exports.elite_036
elite_036.name = "elite_036"
__TS__ClassExtends(elite_036, MonsterAbility_CS)
function elite_036.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_036.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_036_passive"
end
elite_036 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_036)
____exports.elite_036 = elite_036
local modifier_elite_036_passive = __TS__Class()
modifier_elite_036_passive.name = "modifier_elite_036_passive"
__TS__ClassExtends(modifier_elite_036_passive, MonsterModifier_CS)
function modifier_elite_036_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_036_passive.prototype.OnAttackLanded_CS(self, event)
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
	local ____opt_0 = target.GetUnitType
	local unitType = ____opt_0 and ____opt_0(target)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	local existing = target:FindModifierByNameAndCaster("modifier_elite_036_stack", parent)
	if not existing or existing:IsNull() then
		modifier_elite_036_stack:applys(
			target,
			parent,
			ability,
			{ duration = STACK_MARK_DURATION, stacks = STACK_PER_HIT }
		)
		return
	end
	local next = existing:GetStackCount() + STACK_PER_HIT
	existing:SetStackCount(next)
	existing:SetDuration(STACK_MARK_DURATION, true)
	if next > STACK_STUN_THRESHOLD then
		AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.STUN, { duration = STUN_DURATION })
		target:EmitSound("Hero_Slardar.Bash")
		existing:Destroy()
	end
end
function modifier_elite_036_passive.prototype.IsHidden(self)
	return true
end
function modifier_elite_036_passive.prototype.IsPurgable(self)
	return false
end
modifier_elite_036_passive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_036_passive") }, modifier_elite_036_passive)
modifier_elite_036_stack = __TS__Class()
modifier_elite_036_stack.name = "modifier_elite_036_stack"
__TS__ClassExtends(modifier_elite_036_stack, MonsterModifier_CS)
function modifier_elite_036_stack.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	local d = kv and kv.duration or STACK_MARK_DURATION
	local stacks = math.max(1, kv and kv.stacks or 1)
	self:SetDuration(d, true)
	self:SetStackCount(stacks)
end
function modifier_elite_036_stack.prototype.IsHidden(self)
	return false
end
function modifier_elite_036_stack.prototype.IsDebuff(self)
	return true
end
function modifier_elite_036_stack.prototype.IsPurgable(self)
	return true
end
function modifier_elite_036_stack.GetLocalizationCN(self)
	return {
		name = "重击印记",
		description = "每层来自该单位的普攻；层数大于 5 时将被震晕并重置。",
	}
end
modifier_elite_036_stack =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_036_stack") }, modifier_elite_036_stack)
return ____exports