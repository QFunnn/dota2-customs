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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseBlankAbility = __TS__Class()
BaseBlankAbility.name = "BaseBlankAbility"
__TS__ClassExtends(BaseBlankAbility, BaseHeroAbility)
function BaseBlankAbility.prototype.GetBehavior(self)
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end
function BaseBlankAbility.prototype.GetMaxLevel(self)
	return 1
end
--- 通用空白占位（保留）。
____exports.ak_hero_blank = __TS__Class()
local ak_hero_blank = ____exports.ak_hero_blank
ak_hero_blank.name = "ak_hero_blank"
__TS__ClassExtends(ak_hero_blank, BaseBlankAbility)
ak_hero_blank = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank)
____exports.ak_hero_blank = ak_hero_blank
--- 未解锁的Q技能。
____exports.ak_hero_blank_q = __TS__Class()
local ak_hero_blank_q = ____exports.ak_hero_blank_q
ak_hero_blank_q.name = "ak_hero_blank_q"
__TS__ClassExtends(ak_hero_blank_q, BaseBlankAbility)
ak_hero_blank_q = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_q)
____exports.ak_hero_blank_q = ak_hero_blank_q
--- 未解锁的W技能。
____exports.ak_hero_blank_w = __TS__Class()
local ak_hero_blank_w = ____exports.ak_hero_blank_w
ak_hero_blank_w.name = "ak_hero_blank_w"
__TS__ClassExtends(ak_hero_blank_w, BaseBlankAbility)
ak_hero_blank_w = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_w)
____exports.ak_hero_blank_w = ak_hero_blank_w
--- 未解锁的E技能。
____exports.ak_hero_blank_e = __TS__Class()
local ak_hero_blank_e = ____exports.ak_hero_blank_e
ak_hero_blank_e.name = "ak_hero_blank_e"
__TS__ClassExtends(ak_hero_blank_e, BaseBlankAbility)
ak_hero_blank_e = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_e)
____exports.ak_hero_blank_e = ak_hero_blank_e
--- 未解锁的D技能。
____exports.ak_hero_blank_d = __TS__Class()
local ak_hero_blank_d = ____exports.ak_hero_blank_d
ak_hero_blank_d.name = "ak_hero_blank_d"
__TS__ClassExtends(ak_hero_blank_d, BaseBlankAbility)
ak_hero_blank_d = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_d)
____exports.ak_hero_blank_d = ak_hero_blank_d
--- 未解锁的F技能。
____exports.ak_hero_blank_f = __TS__Class()
local ak_hero_blank_f = ____exports.ak_hero_blank_f
ak_hero_blank_f.name = "ak_hero_blank_f"
__TS__ClassExtends(ak_hero_blank_f, BaseBlankAbility)
ak_hero_blank_f = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_f)
____exports.ak_hero_blank_f = ak_hero_blank_f
--- 未解锁的R技能。
____exports.ak_hero_blank_r = __TS__Class()
local ak_hero_blank_r = ____exports.ak_hero_blank_r
ak_hero_blank_r.name = "ak_hero_blank_r"
__TS__ClassExtends(ak_hero_blank_r, BaseBlankAbility)
ak_hero_blank_r = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_r)
____exports.ak_hero_blank_r = ak_hero_blank_r
--- 未解锁的被动天赋技能（P位）。
____exports.ak_hero_blank_passive = __TS__Class()
local ak_hero_blank_passive = ____exports.ak_hero_blank_passive
ak_hero_blank_passive.name = "ak_hero_blank_passive"
__TS__ClassExtends(ak_hero_blank_passive, BaseHeroAbility)
function ak_hero_blank_passive.prototype.GetBehavior(self)
	return DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN
end
function ak_hero_blank_passive.prototype.GetMaxLevel(self)
	return 1
end
ak_hero_blank_passive = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_blank_passive)
____exports.ak_hero_blank_passive = ak_hero_blank_passive
return ____exports