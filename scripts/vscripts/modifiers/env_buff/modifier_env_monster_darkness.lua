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
local ____dark_domain = require("my_game_axe.room.dark_domain")
local IsDarkDomainUnit = ____dark_domain.IsDarkDomainUnit
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 怪物暗域环境增益
-- 处于暗域时施加，作为怪物技能判断暗域状态的统一接口。
____exports.modifier_env_monster_darkness = __TS__Class()
local modifier_env_monster_darkness = ____exports.modifier_env_monster_darkness
modifier_env_monster_darkness.name = "modifier_env_monster_darkness"
__TS__ClassExtends(modifier_env_monster_darkness, BaseModifier_CS)
function modifier_env_monster_darkness.GetLocalizationCN(self)
	return {
		name = "暗域庇护",
		description = "攻击力、攻击速度、移动速度显著提升，获得高额伤害减免，并免疫异常状态。",
	}
end
function modifier_env_monster_darkness.prototype.GetAttributeBonus(self)
	if not IsDarkDomainUnit(nil, self:GetParent()) then
		return {}
	end
	return {
		all_attack_damage_percent = ____exports.modifier_env_monster_darkness.ATTACK_DAMAGE_PCT,
		attack_speed_pct = ____exports.modifier_env_monster_darkness.ATTACK_SPEED_PCT,
		bonus_movespeed_pct = ____exports.modifier_env_monster_darkness.MOVE_SPEED_PCT,
		damage_reduction_pct = ____exports.modifier_env_monster_darkness.DAMAGE_REDUCTION_PCT,
	}
end
function modifier_env_monster_darkness.prototype.IsHidden(self)
	return false
end
function modifier_env_monster_darkness.prototype.IsDebuff(self)
	return false
end
function modifier_env_monster_darkness.prototype.IsPurgable(self)
	return false
end
function modifier_env_monster_darkness.prototype.CheckState(self)
	if not IsDarkDomainUnit(nil, self:GetParent()) then
		return {}
	end
	return { [MODIFIER_STATE_DEBUFF_IMMUNE] = true }
end
function modifier_env_monster_darkness.prototype.GetTexture(self)
	return "night_stalker_darkness"
end
modifier_env_monster_darkness.ATTACK_DAMAGE_PCT = 100
modifier_env_monster_darkness.ATTACK_SPEED_PCT = 100
modifier_env_monster_darkness.MOVE_SPEED_PCT = 100
modifier_env_monster_darkness.DAMAGE_REDUCTION_PCT = 70
modifier_env_monster_darkness = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_monster_darkness)
____exports.modifier_env_monster_darkness = modifier_env_monster_darkness
return ____exports