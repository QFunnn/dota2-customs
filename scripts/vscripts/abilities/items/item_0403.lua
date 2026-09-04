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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0403 = __TS__Class()
local item_0403 = ____exports.item_0403
item_0403.name = "item_0403"
__TS__ClassExtends(item_0403, BaseItem_CS)
function item_0403.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0403_bleed_execute.name
end
item_0403 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0403)
____exports.item_0403 = item_0403
____exports.modifier_item_0403_bleed_execute = __TS__Class()
local modifier_item_0403_bleed_execute = ____exports.modifier_item_0403_bleed_execute
modifier_item_0403_bleed_execute.name = "modifier_item_0403_bleed_execute"
__TS__ClassExtends(modifier_item_0403_bleed_execute, BaseModifier_CS)
function modifier_item_0403_bleed_execute.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_BLEED_STACK_CHANGED }
end
function modifier_item_0403_bleed_execute.prototype.OnBleedStackChanged_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_execute_threshold_pct = math.max(0, ability:GetSpecialValueFor("ability_execute_threshold_pct"))
	if ability_execute_threshold_pct <= 0 then
		return
	end
	local ability_execute_pool_threshold = target:GetHealth() * (ability_execute_threshold_pct / 100)
	if event.total_bleed_stacks <= ability_execute_pool_threshold then
		return
	end
	target:CustomKill(parent, ability)
end
function modifier_item_0403_bleed_execute.prototype.IsHidden(self)
	return true
end
function modifier_item_0403_bleed_execute.prototype.IsPurgable(self)
	return false
end
modifier_item_0403_bleed_execute = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0403_bleed_execute)
____exports.modifier_item_0403_bleed_execute = modifier_item_0403_bleed_execute
return ____exports