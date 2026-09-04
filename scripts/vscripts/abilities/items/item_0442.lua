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
local item_0442_REFRESH_INTERVAL = 0.2
____exports.item_0442 = __TS__Class()
local item_0442 = ____exports.item_0442
item_0442.name = "item_0442"
__TS__ClassExtends(item_0442, BaseItem_CS)
function item_0442.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0442_sage_cloak.name
end
item_0442 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0442)
____exports.item_0442 = item_0442
____exports.modifier_item_0442_sage_cloak = __TS__Class()
local modifier_item_0442_sage_cloak = ____exports.modifier_item_0442_sage_cloak
modifier_item_0442_sage_cloak.name = "modifier_item_0442_sage_cloak"
__TS__ClassExtends(modifier_item_0442_sage_cloak, BaseModifier_CS)
function modifier_item_0442_sage_cloak.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedMaxMana = -1
	self.cachedBonusHealth = -1
end
function modifier_item_0442_sage_cloak.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_0442_sage_cloak.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusHealth(true)
	self:StartIntervalThink(item_0442_REFRESH_INTERVAL)
end
function modifier_item_0442_sage_cloak.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusHealth(false)
end
function modifier_item_0442_sage_cloak.prototype.GetAttributeBonus(self)
	return { bonus_health = self.cachedBonusHealth }
end
function modifier_item_0442_sage_cloak.prototype.IsHidden(self)
	return true
end
function modifier_item_0442_sage_cloak.prototype.IsPurgable(self)
	return false
end
function modifier_item_0442_sage_cloak.prototype.RecalculateBonusHealth(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	local ability_max_mana_to_health_pct =
		math.max(0, ability and ability:GetSpecialValueFor("ability_value_max_mana_to_health_pct") or 0)
	local maxMana = math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or parent:GetMaxMana())
	local bonusHealth = math.floor(maxMana * (ability_max_mana_to_health_pct / 100))
	local manaChanged = math.abs(maxMana - self.cachedMaxMana) > 0.01
	local bonusChanged = bonusHealth ~= self.cachedBonusHealth
	if not forceRefresh and not manaChanged and not bonusChanged then
		return
	end
	self.cachedMaxMana = maxMana
	self.cachedBonusHealth = bonusHealth
	self:RefreshAttributes()
end
modifier_item_0442_sage_cloak = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0442_sage_cloak)
____exports.modifier_item_0442_sage_cloak = modifier_item_0442_sage_cloak
return ____exports