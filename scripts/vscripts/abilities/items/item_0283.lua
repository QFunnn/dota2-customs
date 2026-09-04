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
____exports.item_0283 = __TS__Class()
local item_0283 = ____exports.item_0283
item_0283.name = "item_0283"
__TS__ClassExtends(item_0283, BaseItem_CS)
function item_0283.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0283_resonance.name
end
item_0283 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0283)
____exports.item_0283 = item_0283
____exports.modifier_item_0283_resonance = __TS__Class()
local modifier_item_0283_resonance = ____exports.modifier_item_0283_resonance
modifier_item_0283_resonance.name = "modifier_item_0283_resonance"
__TS__ClassExtends(modifier_item_0283_resonance, BaseModifier_CS)
function modifier_item_0283_resonance.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.castCount = 0
end
function modifier_item_0283_resonance.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0283_resonance.prototype.IsHidden(self)
	return true
end
function modifier_item_0283_resonance.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	if castAbility:IsToggle() then
		return
	end
	if parent:HasModifier(____exports.modifier_item_0283_free_mana.name) then
		return
	end
	local ability_required_casts = ability:GetSpecialValue("item_0283", "ability_required_casts")
	local required = math.max(1, math.floor(ability_required_casts))
	self.castCount = self.castCount + 1
	if self.castCount < required then
		return
	end
	self.castCount = 0
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0283_free_mana.name, {})
	self:PlayEffects2(parent)
end
function modifier_item_0283_resonance.prototype.PlayEffects2(self, parent)
	parent:EmitSound("Blink_Layer.Arcane")
end
modifier_item_0283_resonance = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0283_resonance)
____exports.modifier_item_0283_resonance = modifier_item_0283_resonance
____exports.modifier_item_0283_free_mana = __TS__Class()
local modifier_item_0283_free_mana = ____exports.modifier_item_0283_free_mana
modifier_item_0283_free_mana.name = "modifier_item_0283_free_mana"
__TS__ClassExtends(modifier_item_0283_free_mana, BaseModifier_CS)
function modifier_item_0283_free_mana.GetLocalizationCN(self)
	return { name = "魔力共鸣", description = "下一次施放不消耗魔法值。" }
end
function modifier_item_0283_free_mana.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0283_free_mana.prototype.IsHidden(self)
	return false
end
function modifier_item_0283_free_mana.prototype.IsPurgable(self)
	return true
end
function modifier_item_0283_free_mana.prototype.GetAttributeBonus(self)
	return { mana_cost_reduction_pct = 100 }
end
function modifier_item_0283_free_mana.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local itemAbility = self:GetAbility()
	if not itemAbility then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	if castAbility:IsToggle() then
		return
	end
	self:PlayEffects1(parent)
	self:Destroy()
end
function modifier_item_0283_free_mana.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.ArcaneBoots.Activate")
end
function modifier_item_0283_free_mana.prototype.GetEffectName(self)
	return "particles/item/item_mana.vpcf"
end
function modifier_item_0283_free_mana.prototype.GetTexture(self)
	return "item_enchanters_bauble"
end
modifier_item_0283_free_mana = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0283_free_mana)
____exports.modifier_item_0283_free_mana = modifier_item_0283_free_mana
return ____exports