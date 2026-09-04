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
local BaseModifier = ____dota_ts_adapter.BaseModifier
____exports.modifier_dummy_thinker = __TS__Class()
local modifier_dummy_thinker = ____exports.modifier_dummy_thinker
modifier_dummy_thinker.name = "modifier_dummy_thinker"
__TS__ClassExtends(modifier_dummy_thinker, BaseModifier)
modifier_dummy_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_dummy_thinker)
____exports.modifier_dummy_thinker = modifier_dummy_thinker
return ____exports