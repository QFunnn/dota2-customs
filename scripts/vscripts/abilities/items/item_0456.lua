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
____exports.item_0456 = __TS__Class()
local item_0456 = ____exports.item_0456
item_0456.name = "item_0456"
__TS__ClassExtends(item_0456, BaseItem_CS)
function item_0456.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0456_polar_day.name
end
item_0456 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0456)
____exports.item_0456 = item_0456
____exports.modifier_item_0456_polar_day = __TS__Class()
local modifier_item_0456_polar_day = ____exports.modifier_item_0456_polar_day
modifier_item_0456_polar_day.name = "modifier_item_0456_polar_day"
__TS__ClassExtends(modifier_item_0456_polar_day, BaseModifier_CS)
function modifier_item_0456_polar_day.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0456_polar_day.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	self:RestoreVitality(parent, ability)
end
function modifier_item_0456_polar_day.prototype.RestoreVitality(self, parent, ability)
	local ability_mana_pct = math.max(0, ability:GetSpecialValueFor("ability_value_mana_pct"))
	local maxMana = math.max(0, parent:GetMaxMana())
	if ability_mana_pct <= 0 or maxMana <= 0 then
		return
	end
	local restoreAmount = maxMana * (ability_mana_pct / 100)
	if restoreAmount <= 0 then
		return
	end
	local restoreMana = math.min(restoreAmount, math.max(0, maxMana - parent:GetMana()))
	if restoreMana > 0 then
		parent:GiveMana(restoreMana)
		Popups:manaGain(parent, math.floor(restoreMana))
	end
	local healEvent = parent:CustomHeal(restoreAmount, { ability = ability, source = "item" })
	if restoreMana > 0 or healEvent.actual_amount > 0 then
		self:PlayEffects1(parent)
	end
end
function modifier_item_0456_polar_day.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.ArcaneBoots.Activate")
end
function modifier_item_0456_polar_day.prototype.IsHidden(self)
	return true
end
function modifier_item_0456_polar_day.prototype.IsDebuff(self)
	return false
end
function modifier_item_0456_polar_day.prototype.IsPurgable(self)
	return false
end
modifier_item_0456_polar_day = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0456_polar_day)
____exports.modifier_item_0456_polar_day = modifier_item_0456_polar_day
return ____exports