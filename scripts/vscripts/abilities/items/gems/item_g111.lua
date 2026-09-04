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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____item_gems = require("abilities.items.gems.item_gems")
local item_gem_base = ____item_gems.item_gem_base
local AXE_011_ABILITY_NAME = "axe_011"
local VULNERABLE_MODIFIER_NAME = "modifier_generic_vulnerable"
local VULNERABLE_BASE_MAX_STACK = 5
local VULNERABLE_MAX_STACK_BONUS_KEY = "axe_012_vulnerable_max_stack_bonus"
____exports.item_G111 = __TS__Class()
local item_G111 = ____exports.item_G111
item_G111.name = "item_G111"
__TS__ClassExtends(item_G111, item_gem_base)
item_G111 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G111)
____exports.item_G111 = item_G111
____exports.item_G111_2 = __TS__Class()
local item_G111_2 = ____exports.item_G111_2
item_G111_2.name = "item_G111_2"
__TS__ClassExtends(item_G111_2, item_gem_base)
item_G111_2 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G111_2)
____exports.item_G111_2 = item_G111_2
____exports.item_G111_3 = __TS__Class()
local item_G111_3 = ____exports.item_G111_3
item_G111_3.name = "item_G111_3"
__TS__ClassExtends(item_G111_3, item_gem_base)
item_G111_3 = __TS__DecorateLegacy({ registerAbility(nil) }, item_G111_3)
____exports.item_G111_3 = item_G111_3
--- 符印「易伤倾泻」：攻击满层易伤目标时，额外触发嗜血斩击并清空易伤。
____exports.modifier_item_G111_vulnerable_dump = __TS__Class()
local modifier_item_G111_vulnerable_dump = ____exports.modifier_item_G111_vulnerable_dump
modifier_item_G111_vulnerable_dump.name = "modifier_item_G111_vulnerable_dump"
__TS__ClassExtends(modifier_item_G111_vulnerable_dump, BaseModifier_CS)
function modifier_item_G111_vulnerable_dump.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_G111_vulnerable_dump.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local vulnerable = target:FindModifierByName(VULNERABLE_MODIFIER_NAME)
	if not vulnerable then
		return
	end
	local ____math_max_4 = math.max
	local ____math_floor_3 = math.floor
	local ____tonumber_2 = tonumber
	local ____opt_0 = parent.GetCustomValue
	local maxStackBonus = ____math_max_4(
		0,
		____math_floor_3(____tonumber_2(____opt_0 and ____opt_0(parent, VULNERABLE_MAX_STACK_BONUS_KEY) or 0) or 0)
	)
	if vulnerable:GetStackCount() < VULNERABLE_BASE_MAX_STACK + maxStackBonus then
		return
	end
	local ability = parent:FindAbilityByName(AXE_011_ABILITY_NAME)
	if not ability or not IsValid(nil, ability) or ability:IsNull() or ability:GetLevel() <= 0 then
		return
	end
	if not ability:TriggerByAttack(target) then
		return
	end
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, target) or not IsValidEntity(target) then
			return nil
		end
		target:RemoveModifierByName(VULNERABLE_MODIFIER_NAME)
		return nil
	end)
end
function modifier_item_G111_vulnerable_dump.prototype.IsHidden(self)
	return true
end
function modifier_item_G111_vulnerable_dump.prototype.IsPurgable(self)
	return false
end
modifier_item_G111_vulnerable_dump = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_G111_vulnerable_dump)
____exports.modifier_item_G111_vulnerable_dump = modifier_item_G111_vulnerable_dump
return ____exports