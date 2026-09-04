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
____exports.item_0371 = __TS__Class()
local item_0371 = ____exports.item_0371
item_0371.name = "item_0371"
__TS__ClassExtends(item_0371, BaseItem_CS)
function item_0371.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0371.name
end
item_0371 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0371)
____exports.item_0371 = item_0371
____exports.modifier_item_0371 = __TS__Class()
local modifier_item_0371 = ____exports.modifier_item_0371
modifier_item_0371.name = "modifier_item_0371"
__TS__ClassExtends(modifier_item_0371, BaseModifier_CS)
function modifier_item_0371.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0371.prototype.IsHidden(self)
	return true
end
function modifier_item_0371.prototype.IsPurgable(self)
	return false
end
function modifier_item_0371.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if
		not NotifyCustomDebuffApplyQuery(nil, target, parent, ability, ____exports.modifier_item_0371_corrosion.name)
	then
		return
	end
	____exports.modifier_item_0371_corrosion:applys(
		target,
		parent,
		ability,
		{ duration = ability:GetSpecialValueFor("ability_duration") }
	)
end
modifier_item_0371 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0371)
____exports.modifier_item_0371 = modifier_item_0371
____exports.modifier_item_0371_corrosion = __TS__Class()
local modifier_item_0371_corrosion = ____exports.modifier_item_0371_corrosion
modifier_item_0371_corrosion.name = "modifier_item_0371_corrosion"
__TS__ClassExtends(modifier_item_0371_corrosion, BaseModifier_CS)
function modifier_item_0371_corrosion.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.armorReduction = 0
	self.maxStacks = 1
end
function modifier_item_0371_corrosion.GetLocalizationCN(self)
	return { name = "腐蚀", description = "物理护甲降低，随层数增强。" }
end
function modifier_item_0371_corrosion.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(1)
	self:RefreshAttributes()
end
function modifier_item_0371_corrosion.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(math.min(self.maxStacks, self:GetStackCount() + 1))
	self:RefreshAttributes()
end
function modifier_item_0371_corrosion.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.armorReduction = math.abs(ability:GetSpecialValueFor("ability_armor_reduction"))
	self.maxStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_stacks")))
end
function modifier_item_0371_corrosion.prototype.GetAttributeBonus(self)
	return { bonus_armor = -self.armorReduction * math.max(1, self:GetStackCount()) }
end
function modifier_item_0371_corrosion.prototype.IsHidden(self)
	return false
end
function modifier_item_0371_corrosion.prototype.IsDebuff(self)
	return true
end
function modifier_item_0371_corrosion.prototype.IsPurgable(self)
	return true
end
modifier_item_0371_corrosion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0371_corrosion)
____exports.modifier_item_0371_corrosion = modifier_item_0371_corrosion
return ____exports