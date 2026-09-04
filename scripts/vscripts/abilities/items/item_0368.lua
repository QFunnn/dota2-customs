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
____exports.item_0368 = __TS__Class()
local item_0368 = ____exports.item_0368
item_0368.name = "item_0368"
__TS__ClassExtends(item_0368, BaseItem_CS)
function item_0368.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0368_infinity.name
end
item_0368 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0368)
____exports.item_0368 = item_0368
____exports.modifier_item_0368_infinity = __TS__Class()
local modifier_item_0368_infinity = ____exports.modifier_item_0368_infinity
modifier_item_0368_infinity.name = "modifier_item_0368_infinity"
__TS__ClassExtends(modifier_item_0368_infinity, BaseModifier_CS)
function modifier_item_0368_infinity.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedBonusCritDamagePct = -1
end
function modifier_item_0368_infinity.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusCritDamage(true)
	self:StartIntervalThink(____exports.modifier_item_0368_infinity.RECALCULATE_INTERVAL)
end
function modifier_item_0368_infinity.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusCritDamage(false)
end
function modifier_item_0368_infinity.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0368_infinity.prototype.GetAttributeBonus(self)
	return { crit_damage_pct = math.max(0, self.cachedBonusCritDamagePct) }
end
function modifier_item_0368_infinity.prototype.IsHidden(self)
	return true
end
function modifier_item_0368_infinity.prototype.IsPurgable(self)
	return false
end
function modifier_item_0368_infinity.prototype.RecalculateBonusCritDamage(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_value_crit_damage_convert_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_crit_damage_convert_pct"))
	local ability_physical_crit_chance_pct =
		math.max(0, MyGameAttribute:GetAttribute(parent, "physical_crit_chance_pct") or 0)
	local ability_magical_crit_chance_pct =
		math.max(0, MyGameAttribute:GetAttribute(parent, "magical_crit_chance_pct") or 0)
	local ability_omni_crit_chance_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "omni_crit_chance_pct") or 0)
	local ability_bonus_crit_damage_pct = (
		ability_physical_crit_chance_pct
		+ ability_omni_crit_chance_pct
		+ ability_magical_crit_chance_pct
		+ ability_omni_crit_chance_pct
	) * (ability_value_crit_damage_convert_pct / 100)
	if not forceRefresh and math.abs(ability_bonus_crit_damage_pct - self.cachedBonusCritDamagePct) < 0.01 then
		return
	end
	self.cachedBonusCritDamagePct = ability_bonus_crit_damage_pct
	self:RefreshAttributes()
end
modifier_item_0368_infinity.RECALCULATE_INTERVAL = 0.5
modifier_item_0368_infinity = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0368_infinity)
____exports.modifier_item_0368_infinity = modifier_item_0368_infinity
return ____exports