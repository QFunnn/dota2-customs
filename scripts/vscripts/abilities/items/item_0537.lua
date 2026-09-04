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
____exports.item_0537 = __TS__Class()
local item_0537 = ____exports.item_0537
item_0537.name = "item_0537"
__TS__ClassExtends(item_0537, BaseItem_CS)
function item_0537.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0537_arcane.name
end
item_0537 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0537)
____exports.item_0537 = item_0537
--- 固有被动「智识涌魔」：总智力 × ability_value_mana_per_int → 额外 bonus_mana。
____exports.modifier_item_0537_arcane = __TS__Class()
local modifier_item_0537_arcane = ____exports.modifier_item_0537_arcane
modifier_item_0537_arcane.name = "modifier_item_0537_arcane"
__TS__ClassExtends(modifier_item_0537_arcane, BaseModifier_CS)
function modifier_item_0537_arcane.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedMana = -1
end
function modifier_item_0537_arcane.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(RECALC_INTERVAL)
end
function modifier_item_0537_arcane.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0537_arcane.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0537_arcane.prototype.IsHidden(self)
	return true
end
function modifier_item_0537_arcane.prototype.IsPurgable(self)
	return false
end
function modifier_item_0537_arcane.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cachedMana > 0 then
		____temp_0 = self.cachedMana
	else
		____temp_0 = 0
	end
	return { bonus_mana = ____temp_0 }
end
function modifier_item_0537_arcane.prototype.GetTagModifierRules(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_value_mana_cost_pct = math.max(0, ability:GetSpecialValueFor("ability_value_mana_cost_pct"))
	if ability_value_mana_cost_pct <= 0 then
		return {}
	end
	return { { id = "item_0537_mana_cost_up", statKey = 6, op = 1, value = ability_value_mana_cost_pct } }
end
function modifier_item_0537_arcane.prototype.Recalc(self, force)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local intelligence = math.max(0, MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0)
	local manaPerInt = math.max(0, ability:GetSpecialValueFor("ability_value_mana_per_int"))
	local value = math.max(0, intelligence * manaPerInt)
	if not force and math.abs(value - self.cachedMana) < 0.01 then
		return
	end
	self.cachedMana = value
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0537_arcane = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0537_arcane)
____exports.modifier_item_0537_arcane = modifier_item_0537_arcane
return ____exports