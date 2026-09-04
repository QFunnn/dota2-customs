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
____exports.item_0547 = __TS__Class()
local item_0547 = ____exports.item_0547
item_0547.name = "item_0547"
__TS__ClassExtends(item_0547, BaseItem_CS)
function item_0547.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0547.name
end
item_0547 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0547)
____exports.item_0547 = item_0547
____exports.modifier_item_0547 = __TS__Class()
local modifier_item_0547 = ____exports.modifier_item_0547
modifier_item_0547.name = "modifier_item_0547"
__TS__ClassExtends(modifier_item_0547, BaseModifier_CS)
function modifier_item_0547.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedShield = -1
end
function modifier_item_0547.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(RECALC_INTERVAL)
end
function modifier_item_0547.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0547.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0547.prototype.IsHidden(self)
	return true
end
function modifier_item_0547.prototype.IsPurgable(self)
	return false
end
function modifier_item_0547.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cachedShield > 0 then
		____temp_0 = self.cachedShield
	else
		____temp_0 = 0
	end
	return { base_energy_shield = ____temp_0 }
end
function modifier_item_0547.prototype.Recalc(self, force)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local intelligence = math.max(0, MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0)
	local perStat = math.max(0, ability:GetSpecialValueFor("ability_shield_per_stat"))
	local value = intelligence * perStat
	if not force and math.abs(value - self.cachedShield) < 0.01 then
		return
	end
	self.cachedShield = value
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0547 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0547)
____exports.modifier_item_0547 = modifier_item_0547
return ____exports