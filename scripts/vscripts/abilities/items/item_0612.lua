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
____exports.item_0612 = __TS__Class()
local item_0612 = ____exports.item_0612
item_0612.name = "item_0612"
__TS__ClassExtends(item_0612, BaseItem_CS)
function item_0612.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0612.name
end
item_0612 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0612)
____exports.item_0612 = item_0612
--- 固有：冷却缩减溢出转技能伤害（层数=当前技伤加成）。
____exports.modifier_item_0612 = __TS__Class()
local modifier_item_0612 = ____exports.modifier_item_0612
modifier_item_0612.name = "modifier_item_0612"
__TS__ClassExtends(modifier_item_0612, BaseModifier_CS)
function modifier_item_0612.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedAmp = 0
end
function modifier_item_0612.GetLocalizationCN(self)
	return {
		name = "轮转逾限",
		description = "冷却缩减超出阈值的部分转化为技能伤害（层数=当前加成百分比）。",
	}
end
function modifier_item_0612.prototype.IsHidden(self)
	return false
end
function modifier_item_0612.prototype.IsDebuff(self)
	return false
end
function modifier_item_0612.prototype.IsPurgable(self)
	return false
end
function modifier_item_0612.prototype.GetTexture(self)
	return "item_cyclone"
end
function modifier_item_0612.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:OnIntervalThink()
end
function modifier_item_0612.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local threshold = math.max(0, ability:GetSpecialValueFor("ability_value_c_overflow_threshold_pct"))
	local rate = math.max(0, ability:GetSpecialValueFor("ability_value_convert_per_pct"))
	local cdr = MyGameAttribute:GetAttribute(parent, "cooldown_reduction_pct") or 0
	local overflow = math.max(0, cdr - threshold)
	self.cachedAmp = math.floor(overflow * rate)
	self:SetStackCount(self.cachedAmp)
	self:RefreshAttributes()
end
function modifier_item_0612.prototype.GetAttributeBonus(self)
	if self.cachedAmp <= 0 then
		return {}
	end
	return { spell_amplify_pct = self.cachedAmp }
end
modifier_item_0612 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0612)
____exports.modifier_item_0612 = modifier_item_0612
return ____exports