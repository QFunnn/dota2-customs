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
local modifier_item_0202_execute
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0202 = __TS__Class()
local item_0202 = ____exports.item_0202
item_0202.name = "item_0202"
__TS__ClassExtends(item_0202, BaseItem_CS)
function item_0202.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0202_execute.name
end
item_0202 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0202)
____exports.item_0202 = item_0202
modifier_item_0202_execute = __TS__Class()
modifier_item_0202_execute.name = "modifier_item_0202_execute"
__TS__ClassExtends(modifier_item_0202_execute, BaseModifier_CS)
function modifier_item_0202_execute.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0202_execute.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_execute_health_pct = ability:GetSpecialValueFor("ability_value_execute_health_pct")
	local ____target_IsBoss_result_0
	if target:IsBoss() then
		____target_IsBoss_result_0 = ability_execute_health_pct * 0.5
	else
		____target_IsBoss_result_0 = ability_execute_health_pct
	end
	local ability_effective_execute_health_pct = ____target_IsBoss_result_0
	local ability_execute_health = target:GetMaxHealth() * ability_effective_execute_health_pct * 0.01
	if target:GetHealth() >= ability_execute_health then
		return
	end
	target:CustomKill(parent, ability)
end
function modifier_item_0202_execute.prototype.IsHidden(self)
	return true
end
modifier_item_0202_execute = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0202_execute)
return ____exports