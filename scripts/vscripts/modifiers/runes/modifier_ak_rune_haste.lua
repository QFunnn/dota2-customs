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
local RUNE_HASTE_MOVESPEED_PCT = 100
local RUNE_HASTE_ATTACK_SPEED = 100
____exports.modifier_ak_rune_haste = __TS__Class()
local modifier_ak_rune_haste = ____exports.modifier_ak_rune_haste
modifier_ak_rune_haste.name = "modifier_ak_rune_haste"
__TS__ClassExtends(modifier_ak_rune_haste, BaseModifier_CS)
function modifier_ak_rune_haste.GetLocalizationCN(self)
	return { name = "极速神符", description = "移动速度提高 100点，攻击速度提高 100。" }
end
function modifier_ak_rune_haste.prototype.GetAttributeBonus(self)
	return { bonus_movespeed = RUNE_HASTE_MOVESPEED_PCT, attack_speed = RUNE_HASTE_ATTACK_SPEED }
end
function modifier_ak_rune_haste.prototype.GetTexture(self)
	return "rune_haste"
end
function modifier_ak_rune_haste.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_haste_owner.vpcf"
end
function modifier_ak_rune_haste.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_ak_rune_haste.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_haste.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_haste.prototype.IsPurgable(self)
	return true
end
modifier_ak_rune_haste =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_ak_rune_haste") }, modifier_ak_rune_haste)
____exports.modifier_ak_rune_haste = modifier_ak_rune_haste
return ____exports