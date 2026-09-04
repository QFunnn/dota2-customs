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
____exports.item_0603 = __TS__Class()
local item_0603 = ____exports.item_0603
item_0603.name = "item_0603"
__TS__ClassExtends(item_0603, BaseItem_CS)
function item_0603.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0603.name
end
item_0603 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0603)
____exports.item_0603 = item_0603
--- 固有：三维达标计数（层数 0~3），集齐三维激活增伤+减伤。
____exports.modifier_item_0603 = __TS__Class()
local modifier_item_0603 = ____exports.modifier_item_0603
modifier_item_0603.name = "modifier_item_0603"
__TS__ClassExtends(modifier_item_0603, BaseModifier_CS)
function modifier_item_0603.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.active = false
end
function modifier_item_0603.GetLocalizationCN(self)
	return {
		name = "六极",
		description = "力量、敏捷、智力均达标时，造成的伤害提高、受到的伤害降低（层数=当前达标维度数）。",
	}
end
function modifier_item_0603.prototype.IsHidden(self)
	return false
end
function modifier_item_0603.prototype.IsDebuff(self)
	return false
end
function modifier_item_0603.prototype.IsPurgable(self)
	return false
end
function modifier_item_0603.prototype.GetTexture(self)
	return "item_apex"
end
function modifier_item_0603.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:OnIntervalThink()
end
function modifier_item_0603.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local threshold = math.max(0, ability:GetSpecialValueFor("ability_attr_threshold"))
	local met = 0
	for ____, key in ipairs({ "total_strength", "total_agility", "total_intelligence" }) do
		if (MyGameAttribute:GetAttribute(parent, key) or 0) > threshold then
			met = met + 1
		end
	end
	self.active = met >= 3
	self:SetStackCount(met)
	self:RefreshAttributes()
end
function modifier_item_0603.prototype.GetAttributeBonus(self)
	if not self.active then
		return {}
	end
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		outgoing_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_damage_bonus_pct")),
		damage_reduction_pct = math.max(0, ability:GetSpecialValueFor("ability_damage_reduction_pct")),
	}
end
modifier_item_0603 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0603)
____exports.modifier_item_0603 = modifier_item_0603
return ____exports