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
____exports.item_0278 = __TS__Class()
local item_0278 = ____exports.item_0278
item_0278.name = "item_0278"
__TS__ClassExtends(item_0278, BaseItem_CS)
function item_0278.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0278_resonant_armor.name
end
item_0278 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0278)
____exports.item_0278 = item_0278
____exports.modifier_item_0278_resonant_armor = __TS__Class()
local modifier_item_0278_resonant_armor = ____exports.modifier_item_0278_resonant_armor
modifier_item_0278_resonant_armor.name = "modifier_item_0278_resonant_armor"
__TS__ClassExtends(modifier_item_0278_resonant_armor, BaseModifier_CS)
function modifier_item_0278_resonant_armor.GetLocalizationCN(self)
	return { name = "共振护甲", description = "附近敌人越多，伤害减免越高。" }
end
function modifier_item_0278_resonant_armor.prototype.IsHidden(self)
	return false
end
function modifier_item_0278_resonant_armor.prototype.IsPurgable(self)
	return false
end
function modifier_item_0278_resonant_armor.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:UpdateStacks()
end
function modifier_item_0278_resonant_armor.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateStacks()
end
function modifier_item_0278_resonant_armor.prototype.UpdateStacks(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	local ability_radius = ability:GetSpecialValue("item_0278", "ability_radius")
	if ability_radius <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local count = enemies and #enemies or 0
	if self:GetStackCount() ~= count then
		self:SetStackCount(count)
		self:RefreshAttributes()
	end
end
function modifier_item_0278_resonant_armor.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local perEnemy = ability:GetSpecialValue("item_0278", "ability_damage_reduction_pct_per_enemy")
	return { damage_reduction_pct = self:GetStackCount() * perEnemy }
end
function modifier_item_0278_resonant_armor.prototype.GetTexture(self)
	return "item_rattlecage"
end
modifier_item_0278_resonant_armor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0278_resonant_armor)
____exports.modifier_item_0278_resonant_armor = modifier_item_0278_resonant_armor
return ____exports