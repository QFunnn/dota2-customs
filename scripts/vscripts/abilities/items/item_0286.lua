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
____exports.item_0286 = __TS__Class()
local item_0286 = ____exports.item_0286
item_0286.name = "item_0286"
__TS__ClassExtends(item_0286, BaseItem_CS)
function item_0286.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0286_desolation.name
end
item_0286 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0286)
____exports.item_0286 = item_0286
____exports.modifier_item_0286_desolation = __TS__Class()
local modifier_item_0286_desolation = ____exports.modifier_item_0286_desolation
modifier_item_0286_desolation.name = "modifier_item_0286_desolation"
__TS__ClassExtends(modifier_item_0286_desolation, BaseModifier_CS)
function modifier_item_0286_desolation.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0286_desolation.prototype.IsHidden(self)
	return true
end
function modifier_item_0286_desolation.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	target:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0286_armor_break.name,
		{ duration = ability:GetSpecialValueFor("ability_duration") }
	)
	target:EmitSound("Item_Desolator.Target")
end
modifier_item_0286_desolation = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0286_desolation)
____exports.modifier_item_0286_desolation = modifier_item_0286_desolation
____exports.modifier_item_0286_armor_break = __TS__Class()
local modifier_item_0286_armor_break = ____exports.modifier_item_0286_armor_break
modifier_item_0286_armor_break.name = "modifier_item_0286_armor_break"
__TS__ClassExtends(modifier_item_0286_armor_break, BaseModifier_CS)
function modifier_item_0286_armor_break.GetLocalizationCN(self)
	return { name = "腐甲", description = "护甲降低。" }
end
function modifier_item_0286_armor_break.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { bonus_armor = -math.abs(ability:GetSpecialValueFor("ability_armor_reduce")) }
end
function modifier_item_0286_armor_break.prototype.IsHidden(self)
	return false
end
function modifier_item_0286_armor_break.prototype.IsDebuff(self)
	return true
end
function modifier_item_0286_armor_break.prototype.IsPurgable(self)
	return true
end
function modifier_item_0286_armor_break.prototype.GetTexture(self)
	return "item_desolator_2"
end
modifier_item_0286_armor_break = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0286_armor_break)
____exports.modifier_item_0286_armor_break = modifier_item_0286_armor_break
return ____exports