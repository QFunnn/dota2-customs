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
____exports.item_0525 = __TS__Class()
local item_0525 = ____exports.item_0525
item_0525.name = "item_0525"
__TS__ClassExtends(item_0525, BaseItem_CS)
function item_0525.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0525.name
end
item_0525 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0525)
____exports.item_0525 = item_0525
____exports.modifier_item_0525 = __TS__Class()
local modifier_item_0525 = ____exports.modifier_item_0525
modifier_item_0525.name = "modifier_item_0525"
__TS__ClassExtends(modifier_item_0525, BaseModifier_CS)
function modifier_item_0525.GetLocalizationCN(self)
	return { name = "奥术熔炉", description = "非普通攻击的物理伤害全部转化为魔法伤害。" }
end
function modifier_item_0525.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_TYPE_QUERY }
end
function modifier_item_0525.prototype.OnDamageTypeQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local spec = event.ctx.spec
	if spec.attacker ~= self:GetParent() then
		return
	end
	if spec.is_base_attack then
		return
	end
	if spec.damage_type ~= 1 then
		return
	end
	local ____event_requested_types_0 = event.requested_types
	____event_requested_types_0[#____event_requested_types_0 + 1] = 2
end
function modifier_item_0525.prototype.IsHidden(self)
	return false
end
function modifier_item_0525.prototype.IsDebuff(self)
	return false
end
function modifier_item_0525.prototype.IsPurgable(self)
	return false
end
modifier_item_0525 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0525)
____exports.modifier_item_0525 = modifier_item_0525
return ____exports