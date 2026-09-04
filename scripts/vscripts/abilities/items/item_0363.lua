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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0363 = __TS__Class()
local item_0363 = ____exports.item_0363
item_0363.name = "item_0363"
__TS__ClassExtends(item_0363, BaseItem_CS)
function item_0363.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0363_curse.name
end
item_0363 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0363)
____exports.item_0363 = item_0363
____exports.modifier_item_0363_curse = __TS__Class()
local modifier_item_0363_curse = ____exports.modifier_item_0363_curse
modifier_item_0363_curse.name = "modifier_item_0363_curse"
__TS__ClassExtends(modifier_item_0363_curse, BaseModifier_CS)
function modifier_item_0363_curse.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0363_curse.prototype.IsHidden(self)
	return true
end
function modifier_item_0363_curse.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct"))
	if not RollPercentage(math.min(100, ability_trigger_chance_pct)) then
		return
	end
	local ability_vulnerable_duration = math.max(0.1, ability:GetSpecialValueFor("ability_vulnerable_duration"))
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.VULNERABLE,
		{ duration = ability_vulnerable_duration, stack = 1 }
	)
	AddDeBuffStatus(
		nil,
		parent,
		parent,
		ability,
		DebuffStatusType.VULNERABLE,
		{ duration = ability_vulnerable_duration, stack = 1 }
	)
end
modifier_item_0363_curse = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0363_curse)
____exports.modifier_item_0363_curse = modifier_item_0363_curse
return ____exports