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
local ITEM_0201_HEALTH_RESTORE_PCT = 5
local ITEM_0201_MANA_RESTORE_PCT = 2
____exports.item_0201 = __TS__Class()
local item_0201 = ____exports.item_0201
item_0201.name = "item_0201"
__TS__ClassExtends(item_0201, BaseItem_CS)
function item_0201.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0201_sustain.name
end
item_0201 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0201)
____exports.item_0201 = item_0201
____exports.modifier_item_0201_sustain = __TS__Class()
local modifier_item_0201_sustain = ____exports.modifier_item_0201_sustain
modifier_item_0201_sustain.name = "modifier_item_0201_sustain"
__TS__ClassExtends(modifier_item_0201_sustain, BaseModifier_CS)
function modifier_item_0201_sustain.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0201_sustain.prototype.IsHidden(self)
	return true
end
function modifier_item_0201_sustain.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not ability then
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
	local maxHealth = parent:GetMaxHealth()
	local maxMana = parent:GetMaxMana()
	if maxHealth > 0 then
		parent:CustomHeal(maxHealth * (ITEM_0201_HEALTH_RESTORE_PCT / 100), { ability = ability, source = "item" })
	end
	if maxMana > 0 then
		parent:GiveMana(maxMana * (ITEM_0201_MANA_RESTORE_PCT / 100))
	end
end
modifier_item_0201_sustain = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0201_sustain)
____exports.modifier_item_0201_sustain = modifier_item_0201_sustain
return ____exports