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
____exports.item_0273 = __TS__Class()
local item_0273 = ____exports.item_0273
item_0273.name = "item_0273"
__TS__ClassExtends(item_0273, BaseItem_CS)
function item_0273.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0273_immolation.name
end
item_0273 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0273)
____exports.item_0273 = item_0273
____exports.modifier_item_0273_immolation = __TS__Class()
local modifier_item_0273_immolation = ____exports.modifier_item_0273_immolation
modifier_item_0273_immolation.name = "modifier_item_0273_immolation"
__TS__ClassExtends(modifier_item_0273_immolation, BaseModifier_CS)
function modifier_item_0273_immolation.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_item_0273_immolation.prototype.IsHidden(self)
	return true
end
function modifier_item_0273_immolation.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.target ~= parent then
		return
	end
	local attacker = event.attacker
	if not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if event.is_base_attack == false then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValue("item_0273", "ability_value_trigger_chance_pct")
	if ability_trigger_chance_pct <= 0 then
		return
	end
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_burn_duration = ability:GetSpecialValue("item_0273", "ability_burn_duration")
	AddDeBuffStatus(nil, attacker, parent, ability, DebuffStatusType.BURN, { duration = ability_burn_duration })
	self:PlayEffects1(attacker)
end
function modifier_item_0273_immolation.prototype.PlayEffects1(self, target)
	target:EmitSound("Hero_Huskar.Burning_Spear.Cast")
end
modifier_item_0273_immolation = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0273_immolation)
____exports.modifier_item_0273_immolation = modifier_item_0273_immolation
return ____exports