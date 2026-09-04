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
local ITEM_0349_AURA_RADIUS = 800
____exports.item_0349 = __TS__Class()
local item_0349 = ____exports.item_0349
item_0349.name = "item_0349"
__TS__ClassExtends(item_0349, BaseItem_CS)
function item_0349.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0349_boil_aura.name
end
item_0349 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0349)
____exports.item_0349 = item_0349
____exports.modifier_item_0349_boil_aura = __TS__Class()
local modifier_item_0349_boil_aura = ____exports.modifier_item_0349_boil_aura
modifier_item_0349_boil_aura.name = "modifier_item_0349_boil_aura"
__TS__ClassExtends(modifier_item_0349_boil_aura, BaseModifier_CS)
function modifier_item_0349_boil_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0349_boil_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0349_boil_aura.prototype.IsPurgable(self)
	return false
end
function modifier_item_0349_boil_aura.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0349_boil_aura_effect.name
end
function modifier_item_0349_boil_aura.prototype.GetAuraRadius(self)
	return ITEM_0349_AURA_RADIUS
end
function modifier_item_0349_boil_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_0349_boil_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0349_boil_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_0349_boil_aura.prototype.GetAuraEntityReject(self, target)
	return not IsValidAlive(nil, target) or target:IsBuilding()
end
modifier_item_0349_boil_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0349_boil_aura)
____exports.modifier_item_0349_boil_aura = modifier_item_0349_boil_aura
____exports.modifier_item_0349_boil_aura_effect = __TS__Class()
local modifier_item_0349_boil_aura_effect = ____exports.modifier_item_0349_boil_aura_effect
modifier_item_0349_boil_aura_effect.name = "modifier_item_0349_boil_aura_effect"
__TS__ClassExtends(modifier_item_0349_boil_aura_effect, BaseModifier_CS)
function modifier_item_0349_boil_aura_effect.GetLocalizationCN(self)
	return { name = "沸腾", description = "攻击速度提高。" }
end
function modifier_item_0349_boil_aura_effect.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_attack_speed")
	else
		____ability_0 = 0
	end
	local attackSpeedPct = ____ability_0
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local multiplier = parent == caster and 2 or 1
	return { attack_speed = attackSpeedPct * multiplier }
end
function modifier_item_0349_boil_aura_effect.prototype.IsDebuff(self)
	return false
end
function modifier_item_0349_boil_aura_effect.prototype.IsPurgable(self)
	return false
end
modifier_item_0349_boil_aura_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0349_boil_aura_effect)
____exports.modifier_item_0349_boil_aura_effect = modifier_item_0349_boil_aura_effect
return ____exports