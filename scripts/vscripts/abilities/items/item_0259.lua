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
--- 监听砍树事件，后续在这里接入意外之喜的奖励规则。
____exports.item_0259 = __TS__Class()
local item_0259 = ____exports.item_0259
item_0259.name = "item_0259"
__TS__ClassExtends(item_0259, BaseItem_CS)
function item_0259.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0259.name
end
item_0259 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0259)
____exports.item_0259 = item_0259
____exports.modifier_item_0259 = __TS__Class()
local modifier_item_0259 = ____exports.modifier_item_0259
modifier_item_0259.name = "modifier_item_0259"
__TS__ClassExtends(modifier_item_0259, BaseModifier_CS)
function modifier_item_0259.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TREE_DESTROYED }
end
function modifier_item_0259.prototype.IsHidden(self)
	return true
end
function modifier_item_0259.prototype.OnTreeDestroyed_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or event.caster ~= parent then
		return
	end
	if event.tree_count <= 0 then
		return
	end
	DebugPrint(nil, "[item_0259] OnTreeDestroyed_CS: " .. tostring(event.tree_count))
end
modifier_item_0259 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0259)
____exports.modifier_item_0259 = modifier_item_0259
return ____exports