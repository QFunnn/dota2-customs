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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local AURA_RADIUS = 1200
local HEALTH_REGEN_BY_LEVEL = { 3, 5, 7, 11 }
--- 精英技能126 - 邪恶光环：提高自身和附近友军的生命恢复。
____exports.elite_126 = __TS__Class()
local elite_126 = ____exports.elite_126
elite_126.name = "elite_126"
__TS__ClassExtends(elite_126, MonsterAbility_CS)
function elite_126.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_elite_126_unholy_aura.name
end
function elite_126.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
elite_126 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_126)
____exports.elite_126 = elite_126
____exports.modifier_elite_126_unholy_aura = __TS__Class()
local modifier_elite_126_unholy_aura = ____exports.modifier_elite_126_unholy_aura
modifier_elite_126_unholy_aura.name = "modifier_elite_126_unholy_aura"
__TS__ClassExtends(modifier_elite_126_unholy_aura, MonsterModifier_CS)
function modifier_elite_126_unholy_aura.prototype.GetModifierAura(self)
	return ____exports.modifier_elite_126_unholy_aura_buff.name
end
function modifier_elite_126_unholy_aura.prototype.GetAuraRadius(self)
	return AURA_RADIUS
end
function modifier_elite_126_unholy_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_elite_126_unholy_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_elite_126_unholy_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_elite_126_unholy_aura.prototype.IsAura(self)
	return not self:GetParent():PassivesDisabled()
end
function modifier_elite_126_unholy_aura.prototype.IsHidden(self)
	return true
end
function modifier_elite_126_unholy_aura.prototype.IsPurgable(self)
	return false
end
modifier_elite_126_unholy_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_126_unholy_aura)
____exports.modifier_elite_126_unholy_aura = modifier_elite_126_unholy_aura
____exports.modifier_elite_126_unholy_aura_buff = __TS__Class()
local modifier_elite_126_unholy_aura_buff = ____exports.modifier_elite_126_unholy_aura_buff
modifier_elite_126_unholy_aura_buff.name = "modifier_elite_126_unholy_aura_buff"
__TS__ClassExtends(modifier_elite_126_unholy_aura_buff, MonsterModifier_CS)
function modifier_elite_126_unholy_aura_buff.GetLocalizationCN(self)
	return { name = "邪恶光环", description = "生命恢复速度提高。" }
end
function modifier_elite_126_unholy_aura_buff.prototype.GetAttributeBonus(self)
	return { health_regen = self:GetHealthRegen() }
end
function modifier_elite_126_unholy_aura_buff.prototype.IsHidden(self)
	return false
end
function modifier_elite_126_unholy_aura_buff.prototype.IsDebuff(self)
	return false
end
function modifier_elite_126_unholy_aura_buff.prototype.IsPurgable(self)
	return false
end
function modifier_elite_126_unholy_aura_buff.prototype.GetTexture(self)
	return "satyr_hellcaller_unholy_aura"
end
function modifier_elite_126_unholy_aura_buff.prototype.GetHealthRegen(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(1, ability:GetLevel())
	else
		____ability_0 = 1
	end
	local level = ____ability_0
	return HEALTH_REGEN_BY_LEVEL[math.min(level, #HEALTH_REGEN_BY_LEVEL)]
end
modifier_elite_126_unholy_aura_buff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_126_unholy_aura_buff)
____exports.modifier_elite_126_unholy_aura_buff = modifier_elite_126_unholy_aura_buff
return ____exports