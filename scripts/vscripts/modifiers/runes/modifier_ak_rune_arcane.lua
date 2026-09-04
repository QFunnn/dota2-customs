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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local RUNE_ARCANE_COOLDOWN_REDUCTION_PCT = 25
local RUNE_ARCANE_MANACOST_REDUCTION_PCT = 30
____exports.modifier_ak_rune_arcane = __TS__Class()
local modifier_ak_rune_arcane = ____exports.modifier_ak_rune_arcane
modifier_ak_rune_arcane.name = "modifier_ak_rune_arcane"
__TS__ClassExtends(modifier_ak_rune_arcane, BaseModifier_CS)
function modifier_ak_rune_arcane.GetLocalizationCN(self)
	return { name = "奥术神符", description = "冷却缩减 25%，耗蓝降低 30%。" }
end
function modifier_ak_rune_arcane.prototype.GetAttributeBonus(self)
	return { cooldown_reduction_pct = RUNE_ARCANE_COOLDOWN_REDUCTION_PCT }
end
function modifier_ak_rune_arcane.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING }
end
function modifier_ak_rune_arcane.prototype.GetModifierPercentageManacostStacking(self)
	return RUNE_ARCANE_MANACOST_REDUCTION_PCT
end
function modifier_ak_rune_arcane.prototype.GetTexture(self)
	return "rune_arcane"
end
function modifier_ak_rune_arcane.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_arcane_owner.vpcf"
end
function modifier_ak_rune_arcane.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_ak_rune_arcane.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_arcane.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_arcane.prototype.IsPurgable(self)
	return true
end
modifier_ak_rune_arcane =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_ak_rune_arcane") }, modifier_ak_rune_arcane)
____exports.modifier_ak_rune_arcane = modifier_ak_rune_arcane
return ____exports