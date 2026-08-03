--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local sl_modifier_item_hand_of_blood
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 炼化之手
-- <h1>被动：炼化</h1>击杀英雄时，立刻获得%bonus_gold%金钱。
____exports.item_hand_of_blood = __TS__Class()
local item_hand_of_blood = ____exports.item_hand_of_blood
item_hand_of_blood.name = "item_hand_of_blood"
__TS__ClassExtends(item_hand_of_blood, SLItemBase)
function item_hand_of_blood.prototype.GetIntrinsicModifierName(self)
	return sl_modifier_item_hand_of_blood.name
end
item_hand_of_blood = __TS__Decorate({ registerAbility(nil) }, item_hand_of_blood)
____exports.item_hand_of_blood = item_hand_of_blood
sl_modifier_item_hand_of_blood = __TS__Class()
sl_modifier_item_hand_of_blood.name = "sl_modifier_item_hand_of_blood"
__TS__ClassExtends(sl_modifier_item_hand_of_blood, SLModifier_ItemIntrinsic)
function sl_modifier_item_hand_of_blood.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_HERO_KILLED, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end
function sl_modifier_item_hand_of_blood.prototype.OnHeroKilled(self, event)
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local parent = self:GetParent()
	if attacker:GetPlayerOwnerID() ~= parent:GetPlayerOwnerID() then
		return
	end
	if not self:IsLatestSource() then
		return
	end
	local gold = self:GetAbilitySpecialValueFor("bonus_gold")
	GameRules:ModifyGoldFiltered(parent:GetPlayerOwnerID(), gold, true, DOTA_ModifyGold_HeroKill)
	SLModules.ClientData:PushNumberData(parent, gold, 4)
	EmitSoundOnEntityForPlayer("item_hand_of_blood", parent, parent:GetPlayerOwnerID())
end
function sl_modifier_item_hand_of_blood.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self:GetAbilitySpecialValueFor("bonus_attack_speed")
end
sl_modifier_item_hand_of_blood =
	__TS__Decorate({ registerModifier(nil, "abilities/items/item_hand_of_blood") }, sl_modifier_item_hand_of_blood)
return ____exports