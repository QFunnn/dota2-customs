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
____exports.item_0293 = __TS__Class()
local item_0293 = ____exports.item_0293
item_0293.name = "item_0293"
__TS__ClassExtends(item_0293, BaseItem_CS)
function item_0293.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0293_holy_aura.name
end
item_0293 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0293)
____exports.item_0293 = item_0293
____exports.modifier_item_0293_holy_aura = __TS__Class()
local modifier_item_0293_holy_aura = ____exports.modifier_item_0293_holy_aura
modifier_item_0293_holy_aura.name = "modifier_item_0293_holy_aura"
__TS__ClassExtends(modifier_item_0293_holy_aura, BaseModifier_CS)
function modifier_item_0293_holy_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0293_holy_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0293_holy_aura.prototype.IsPurgable(self)
	return false
end
function modifier_item_0293_holy_aura.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0293_holy_aura_effect.name
end
function modifier_item_0293_holy_aura.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_aura_radius")
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0293_holy_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_0293_holy_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
modifier_item_0293_holy_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0293_holy_aura)
____exports.modifier_item_0293_holy_aura = modifier_item_0293_holy_aura
____exports.modifier_item_0293_holy_aura_effect = __TS__Class()
local modifier_item_0293_holy_aura_effect = ____exports.modifier_item_0293_holy_aura_effect
modifier_item_0293_holy_aura_effect.name = "modifier_item_0293_holy_aura_effect"
__TS__ClassExtends(modifier_item_0293_holy_aura_effect, BaseModifier_CS)
function modifier_item_0293_holy_aura_effect.GetLocalizationCN(self)
	return { name = "神圣光环", description = "生命恢复速度提高，护甲按百分比提高。" }
end
function modifier_item_0293_holy_aura_effect.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		regen_amp_pct = ability:GetSpecialValueFor("ability_regen_amp_pct"),
		base_armor_pct = ability:GetSpecialValueFor("ability_bonus_armor"),
	}
end
function modifier_item_0293_holy_aura_effect.prototype.IsHidden(self)
	return false
end
function modifier_item_0293_holy_aura_effect.prototype.IsDebuff(self)
	return false
end
function modifier_item_0293_holy_aura_effect.prototype.IsPurgable(self)
	return false
end
modifier_item_0293_holy_aura_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0293_holy_aura_effect)
____exports.modifier_item_0293_holy_aura_effect = modifier_item_0293_holy_aura_effect
return ____exports