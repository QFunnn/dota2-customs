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
--- 常驻幸运，直接提升掉落幸运百分比。
____exports.item_0254 = __TS__Class()
local item_0254 = ____exports.item_0254
item_0254.name = "item_0254"
__TS__ClassExtends(item_0254, BaseItem_CS)
function item_0254.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0254.name
end
item_0254 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0254)
____exports.item_0254 = item_0254
____exports.modifier_item_0254 = __TS__Class()
local modifier_item_0254 = ____exports.modifier_item_0254
modifier_item_0254.name = "modifier_item_0254"
__TS__ClassExtends(modifier_item_0254, BaseModifier_CS)
function modifier_item_0254.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_item_drop_luck_pct")
	else
		____ability_0 = 0
	end
	local bonusLuckPct = ____ability_0
	return { item_drop_luck_pct = bonusLuckPct }
end
function modifier_item_0254.prototype.IsHidden(self)
	return true
end
modifier_item_0254 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0254)
____exports.modifier_item_0254 = modifier_item_0254
return ____exports