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
____exports.item_0619 = __TS__Class()
local item_0619 = ____exports.item_0619
item_0619.name = "item_0619"
__TS__ClassExtends(item_0619, BaseItem_CS)
function item_0619.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0619.name
end
item_0619 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0619)
____exports.item_0619 = item_0619
____exports.modifier_item_0619 = __TS__Class()
local modifier_item_0619 = ____exports.modifier_item_0619
modifier_item_0619.name = "modifier_item_0619"
__TS__ClassExtends(modifier_item_0619, BaseModifier_CS)
function modifier_item_0619.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.pendingConvertRatio = 0
end
function modifier_item_0619.GetLocalizationCN(self)
	return { name = "太阳熔炉", description = "非普通攻击的物理伤害转化为等比例魔法伤害。" }
end
function modifier_item_0619.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_TYPE_QUERY, BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER }
end
function modifier_item_0619.prototype.OnDamageTypeQuery_CS(self, event)
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
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local convertPct = math.max(0, ability:GetSpecialValueFor("ability_value_magic_amp_pct"))
	if convertPct <= 0 then
		return
	end
	local ____event_requested_types_0 = event.requested_types
	____event_requested_types_0[#____event_requested_types_0 + 1] = 2
	self.pendingConvertCtx = event.ctx
	self.pendingConvertRatio = convertPct / 100
end
function modifier_item_0619.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx ~= self.pendingConvertCtx then
		return
	end
	local ratio = self.pendingConvertRatio
	self.pendingConvertCtx = nil
	self.pendingConvertRatio = 0
	if ratio <= 0 or ratio == 1 then
		return
	end
	local ____event_final_1, ____mul_2 = event.final, "mul"
	if ____event_final_1[____mul_2] == nil then
		____event_final_1[____mul_2] = {}
	end
	local ____event_final_mul_3 = event.final.mul
	____event_final_mul_3[#____event_final_mul_3 + 1] = { value = ratio, source = "item_0619:太阳熔炉" }
end
function modifier_item_0619.prototype.IsHidden(self)
	return false
end
function modifier_item_0619.prototype.IsDebuff(self)
	return false
end
function modifier_item_0619.prototype.IsPurgable(self)
	return false
end
modifier_item_0619 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0619)
____exports.modifier_item_0619 = modifier_item_0619
return ____exports