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
____exports.item_0282 = __TS__Class()
local item_0282 = ____exports.item_0282
item_0282.name = "item_0282"
__TS__ClassExtends(item_0282, BaseItem_CS)
function item_0282.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0282_antidote.name
end
item_0282 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0282)
____exports.item_0282 = item_0282
____exports.modifier_item_0282_antidote = __TS__Class()
local modifier_item_0282_antidote = ____exports.modifier_item_0282_antidote
modifier_item_0282_antidote.name = "modifier_item_0282_antidote"
__TS__ClassExtends(modifier_item_0282_antidote, BaseModifier_CS)
function modifier_item_0282_antidote.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0282_antidote.prototype.IsHidden(self)
	return true
end
function modifier_item_0282_antidote.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.ctx.spec.victim ~= parent then
		return
	end
	local source = event.ctx.spec.source
	if not source or source.debuff_status ~= DebuffStatusType.POISON then
		return
	end
	local ability_poison_damage_reduce_pct = ability:GetSpecialValue("item_0282", "ability_poison_damage_reduce_pct")
	local reducePct = math.max(0, math.min(100, ability_poison_damage_reduce_pct))
	if reducePct <= 0 then
		return
	end
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] =
		{ value = 1 - reducePct / 100, source = "item_0282:中毒减伤" }
end
modifier_item_0282_antidote = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0282_antidote)
____exports.modifier_item_0282_antidote = modifier_item_0282_antidote
return ____exports