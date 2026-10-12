--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_hand_of_blood.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_hand_of_blood.lua",
	{
		["10"] = "17:7",
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:20",
		["15"] = "2:37",
		["16"] = "3:1",
		["17"] = "3:10",
		["20"] = "9:1",
		["21"] = "10:14",
		["22"] = "9:1",
		["23"] = "10:33",
		["24"] = "11:5",
		["25"] = "12:9",
		["26"] = "11:5",
		["27"] = "10:14",
		["28"] = "9:2",
		["29"] = "9:2",
		["30"] = "9:2",
		["32"] = "9:2",
		["33"] = "10:14",
		["35"] = "10:14",
		["36"] = "17:7",
		["37"] = "16:1",
		["38"] = "17:38",
		["39"] = "18:5",
		["40"] = "19:9",
		["41"] = "18:5",
		["42"] = "22:5",
		["43"] = "23:38",
		["44"] = "23:17",
		["45"] = "23:27",
		["46"] = "24:15",
		["47"] = "25:13",
		["50"] = "26:14",
		["53"] = "27:15",
		["54"] = "29:9",
		["55"] = "29:38",
		["56"] = "29:65",
		["57"] = "29:71",
		["59"] = "29:9",
		["60"] = "31:9",
		["61"] = "33:9",
		["62"] = "33:36",
		["63"] = "33:58",
		["64"] = "33:66",
		["65"] = "33:9",
		["66"] = "22:5",
		["67"] = "36:5",
		["68"] = "37:9",
		["69"] = "36:5",
		["70"] = "17:7",
		["71"] = "16:2",
		["72"] = "16:2",
		["73"] = "16:19",
		["74"] = "16:2",
		["76"] = "16:2",
		["77"] = "17:7",
	}
)
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
item_hand_of_blood = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_hand_of_blood)
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
sl_modifier_item_hand_of_blood = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_hand_of_blood", nil, getfenv()) },
	sl_modifier_item_hand_of_blood
)
return ____exports