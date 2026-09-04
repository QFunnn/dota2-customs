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
____exports.item_0584 = __TS__Class()
local item_0584 = ____exports.item_0584
item_0584.name = "item_0584"
__TS__ClassExtends(item_0584, BaseItem_CS)
function item_0584.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0584_arcane_spring.name
end
item_0584 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0584)
____exports.item_0584 = item_0584
____exports.modifier_item_0584_arcane_spring = __TS__Class()
local modifier_item_0584_arcane_spring = ____exports.modifier_item_0584_arcane_spring
modifier_item_0584_arcane_spring.name = "modifier_item_0584_arcane_spring"
__TS__ClassExtends(modifier_item_0584_arcane_spring, BaseModifier_CS)
function modifier_item_0584_arcane_spring.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_item_0584_arcane_spring.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0584_arcane_spring.prototype.GetMutexKey(self)
	return "yong_ling_mutex"
end
function modifier_item_0584_arcane_spring.prototype.GetMutexPriority(self)
	return 100
end
function modifier_item_0584_arcane_spring.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_mana_restore_max_mana_pct =
		math.max(0, ability:GetSpecialValueFor("ability_mana_restore_max_mana_pct"))
	if ability_mana_restore_max_mana_pct <= 0 then
		return
	end
	local ability_max_mana = math.max(0, parent:GetMaxMana())
	local ability_missing_mana = math.max(0, ability_max_mana - parent:GetMana())
	local ability_restore_mana =
		math.min(ability_missing_mana, ability_max_mana * (ability_mana_restore_max_mana_pct / 100))
	if ability_restore_mana > 0 then
		parent:GiveMana(ability_restore_mana)
	end
end
function modifier_item_0584_arcane_spring.prototype.IsHidden(self)
	return true
end
function modifier_item_0584_arcane_spring.prototype.IsPurgable(self)
	return false
end
modifier_item_0584_arcane_spring = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0584_arcane_spring)
____exports.modifier_item_0584_arcane_spring = modifier_item_0584_arcane_spring
return ____exports