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
local ITEM_0247_POISON_EFFECT = "particles/econ/items/viper/viper_ti7_immortal/viper_poison_crimson_debuff_ti7.vpcf"
____exports.item_0247 = __TS__Class()
local item_0247 = ____exports.item_0247
item_0247.name = "item_0247"
__TS__ClassExtends(item_0247, BaseItem_CS)
function item_0247.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0247"
end
item_0247 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0247)
____exports.item_0247 = item_0247
____exports.modifier_item_0247 = __TS__Class()
local modifier_item_0247 = ____exports.modifier_item_0247
modifier_item_0247.name = "modifier_item_0247"
__TS__ClassExtends(modifier_item_0247, BaseModifier_CS)
function modifier_item_0247.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function modifier_item_0247.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.caster ~= parent then
		return
	end
	if event.status ~= DebuffStatusType.POISON then
		return
	end
	local p = event.params
	p.effect_name = ITEM_0247_POISON_EFFECT
end
function modifier_item_0247.prototype.IsHidden(self)
	return true
end
modifier_item_0247 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0247)
____exports.modifier_item_0247 = modifier_item_0247
return ____exports