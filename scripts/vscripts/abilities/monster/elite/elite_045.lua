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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
--- 精英技能45 - 待实现
____exports.elite_045 = __TS__Class()
local elite_045 = ____exports.elite_045
elite_045.name = "elite_045"
__TS__ClassExtends(elite_045, MonsterAbility_CS)
function elite_045.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.5,
		castDuration = 0.5,
		castAnimation = "",
		OnStart = function()
			self._caster:SetAnimation("cast1_shadowraze_a_desolation")
			self._caster:SetAnimation("cast1_shadowraze_b_desolation")
			self._caster:SetAnimation("cast1_shadowraze_c_desolation")
		end,
	}
end
elite_045 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_045)
____exports.elite_045 = elite_045
return ____exports