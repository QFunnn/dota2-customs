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
____exports.item_0549 = __TS__Class()
local item_0549 = ____exports.item_0549
item_0549.name = "item_0549"
__TS__ClassExtends(item_0549, BaseItem_CS)
function item_0549.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0549.name
end
item_0549 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0549)
____exports.item_0549 = item_0549
____exports.modifier_item_0549 = __TS__Class()
local modifier_item_0549 = ____exports.modifier_item_0549
modifier_item_0549.name = "modifier_item_0549"
__TS__ClassExtends(modifier_item_0549, BaseModifier_CS)
function modifier_item_0549.GetLocalizationCN(self)
	return { name = "幽影护体", description = "受到的物理伤害全部转化为魔法伤害。" }
end
function modifier_item_0549.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_DAMAGE_TYPE_QUERY, target = { scope = "global" } } }
end
function modifier_item_0549.prototype.OnDamageTypeQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local spec = event.ctx.spec
	if spec.victim ~= self:GetParent() then
		return
	end
	if spec.damage_type ~= 1 then
		return
	end
	local ____event_requested_types_0 = event.requested_types
	____event_requested_types_0[#____event_requested_types_0 + 1] = 2
end
function modifier_item_0549.prototype.IsHidden(self)
	return false
end
function modifier_item_0549.prototype.IsDebuff(self)
	return false
end
function modifier_item_0549.prototype.IsPurgable(self)
	return false
end
modifier_item_0549 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0549)
____exports.modifier_item_0549 = modifier_item_0549
return ____exports