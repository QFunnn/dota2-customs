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
local RECALC_INTERVAL = 0.5
____exports.item_0552 = __TS__Class()
local item_0552 = ____exports.item_0552
item_0552.name = "item_0552"
__TS__ClassExtends(item_0552, BaseItem_CS)
function item_0552.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0552.name
end
item_0552 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0552)
____exports.item_0552 = item_0552
____exports.modifier_item_0552 = __TS__Class()
local modifier_item_0552 = ____exports.modifier_item_0552
modifier_item_0552.name = "modifier_item_0552"
__TS__ClassExtends(modifier_item_0552, BaseModifier_CS)
function modifier_item_0552.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(RECALC_INTERVAL)
end
function modifier_item_0552.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0552.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0552.prototype.IsHidden(self)
	return true
end
function modifier_item_0552.prototype.IsPurgable(self)
	return false
end
function modifier_item_0552.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
	local pctPerPoint = math.max(0, ability:GetSpecialValueFor("ability_evasion_pct_per_agility"))
	return { evasion_pct = agility * pctPerPoint }
end
modifier_item_0552 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0552)
____exports.modifier_item_0552 = modifier_item_0552
return ____exports