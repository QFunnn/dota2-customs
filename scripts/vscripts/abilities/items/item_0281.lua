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
local ITEM_0281_SUPPLY_ITEM_NAME = ""
____exports.item_0281 = __TS__Class()
local item_0281 = ____exports.item_0281
item_0281.name = "item_0281"
__TS__ClassExtends(item_0281, BaseItem_CS)
function item_0281.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0281_rend_and_chew.name
end
item_0281 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0281)
____exports.item_0281 = item_0281
____exports.modifier_item_0281_rend_and_chew = __TS__Class()
local modifier_item_0281_rend_and_chew = ____exports.modifier_item_0281_rend_and_chew
modifier_item_0281_rend_and_chew.name = "modifier_item_0281_rend_and_chew"
__TS__ClassExtends(modifier_item_0281_rend_and_chew, BaseModifier_CS)
function modifier_item_0281_rend_and_chew.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_UNIT_DEATH_BEFORE }
end
function modifier_item_0281_rend_and_chew.prototype.IsHidden(self)
	return true
end
function modifier_item_0281_rend_and_chew.prototype.OnUnitDeathBefore_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	local victim = event.victim
	if not IsValid(nil, victim) or victim:IsBuilding() then
		return
	end
	if not victim:HasModifier("modifier_generic_bleed") then
		return
	end
	local ability_drop_chance_pct = ability:GetSpecialValue("item_0281", "ability_drop_chance_pct")
	if ability_drop_chance_pct <= 0 then
		return
	end
	if not RollPercentage(ability_drop_chance_pct) then
		return
	end
	if ITEM_0281_SUPPLY_ITEM_NAME == "" then
		return
	end
	local player = MyGamePlayers:getPlayer(parent:GetPlayerId())
	local ____opt_2 = player and player.knapsack
	local ____opt_0 = ____opt_2 and ____opt_2.AddItemByName
	if ____opt_0 ~= nil then
		____opt_0(____opt_2, ITEM_0281_SUPPLY_ITEM_NAME, 1)
	end
	self:PlayEffects1(parent)
end
function modifier_item_0281_rend_and_chew.prototype.PlayEffects1(self, parent)
	parent:EmitSound("General.Coins")
end
modifier_item_0281_rend_and_chew = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0281_rend_and_chew)
____exports.modifier_item_0281_rend_and_chew = modifier_item_0281_rend_and_chew
return ____exports