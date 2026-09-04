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
local RUNE_REGEN_HEALTH_PCT = 5
local RUNE_REGEN_MANA_PCT = 5
____exports.modifier_ak_rune_regen = __TS__Class()
local modifier_ak_rune_regen = ____exports.modifier_ak_rune_regen
modifier_ak_rune_regen.name = "modifier_ak_rune_regen"
__TS__ClassExtends(modifier_ak_rune_regen, BaseModifier_CS)
function modifier_ak_rune_regen.GetLocalizationCN(self)
	return { name = "恢复神符", description = "每秒恢复 5%% 生命和 5%% 魔法。" }
end
function modifier_ak_rune_regen.prototype.GetAttributeBonus(self)
	return { health_regen_pct = RUNE_REGEN_HEALTH_PCT, mana_regen_pct = RUNE_REGEN_MANA_PCT }
end
function modifier_ak_rune_regen.prototype.GetTexture(self)
	return "rune_regen"
end
function modifier_ak_rune_regen.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_regen_owner.vpcf"
end
function modifier_ak_rune_regen.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_ak_rune_regen.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_regen.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_regen.prototype.IsPurgable(self)
	return true
end
modifier_ak_rune_regen =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_ak_rune_regen") }, modifier_ak_rune_regen)
____exports.modifier_ak_rune_regen = modifier_ak_rune_regen
return ____exports