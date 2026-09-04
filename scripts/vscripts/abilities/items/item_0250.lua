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
--- 友军移速光环，提升范围内友军移动速度百分比。
____exports.item_0250 = __TS__Class()
local item_0250 = ____exports.item_0250
item_0250.name = "item_0250"
__TS__ClassExtends(item_0250, BaseItem_CS)
function item_0250.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0250_aura.name
end
item_0250 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0250)
____exports.item_0250 = item_0250
____exports.modifier_item_0250_aura = __TS__Class()
local modifier_item_0250_aura = ____exports.modifier_item_0250_aura
modifier_item_0250_aura.name = "modifier_item_0250_aura"
__TS__ClassExtends(modifier_item_0250_aura, BaseModifier_CS)
function modifier_item_0250_aura.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0250_aura_effect.name
end
function modifier_item_0250_aura.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_aura_radius")
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0250_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_0250_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0250_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0250_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0250_aura.prototype.IsPurgable(self)
	return false
end
modifier_item_0250_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0250_aura)
____exports.modifier_item_0250_aura = modifier_item_0250_aura
____exports.modifier_item_0250_aura_effect = __TS__Class()
local modifier_item_0250_aura_effect = ____exports.modifier_item_0250_aura_effect
modifier_item_0250_aura_effect.name = "modifier_item_0250_aura_effect"
__TS__ClassExtends(modifier_item_0250_aura_effect, BaseModifier_CS)
function modifier_item_0250_aura_effect.GetLocalizationCN(self)
	return { name = "干杯", description = "获得额外移动速度。" }
end
function modifier_item_0250_aura_effect.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_1
	if ability then
		____ability_1 = ability:GetSpecialValueFor("ability_value_bonus_movespeed_pct")
	else
		____ability_1 = 0
	end
	local bonusMovespeedPct = ____ability_1
	return { bonus_movespeed_pct = bonusMovespeedPct }
end
function modifier_item_0250_aura_effect.prototype.IsDebuff(self)
	return false
end
function modifier_item_0250_aura_effect.prototype.IsPurgable(self)
	return false
end
modifier_item_0250_aura_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0250_aura_effect)
____exports.modifier_item_0250_aura_effect = modifier_item_0250_aura_effect
return ____exports