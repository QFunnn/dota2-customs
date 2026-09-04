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
local RUNE_DAMAGE_BASE_ATTACK_DAMAGE_PCT = 80
local RUNE_DAMAGE_SPELL_AMPLIFY_PCT = 15
____exports.modifier_ak_rune_damage = __TS__Class()
local modifier_ak_rune_damage = ____exports.modifier_ak_rune_damage
modifier_ak_rune_damage.name = "modifier_ak_rune_damage"
__TS__ClassExtends(modifier_ak_rune_damage, BaseModifier_CS)
function modifier_ak_rune_damage.GetLocalizationCN(self)
	return { name = "伤害神符", description = "基础攻击力提高 80%%，技能伤害 15%%。" }
end
function modifier_ak_rune_damage.prototype.GetAttributeBonus(self)
	return {
		base_attack_damage_percent = RUNE_DAMAGE_BASE_ATTACK_DAMAGE_PCT,
		spell_amplify_pct = RUNE_DAMAGE_SPELL_AMPLIFY_PCT,
	}
end
function modifier_ak_rune_damage.prototype.GetTexture(self)
	return "rune_doubledamage"
end
function modifier_ak_rune_damage.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_doubledamage_owner.vpcf"
end
function modifier_ak_rune_damage.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_ak_rune_damage.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_damage.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_damage.prototype.IsPurgable(self)
	return true
end
modifier_ak_rune_damage =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_ak_rune_damage") }, modifier_ak_rune_damage)
____exports.modifier_ak_rune_damage = modifier_ak_rune_damage
return ____exports