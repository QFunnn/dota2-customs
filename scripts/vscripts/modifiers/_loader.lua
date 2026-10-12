--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/_loader.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register("modifiers/_loader.lua", { ["7"] = "1:8", ["8"] = "2:8", ["9"] = "3:8" })
local ____exports = {}
require("modifiers.game_modifiers._loader")
require("modifiers.bless_modifiers._loader")
require("modifiers.hero._loader")
return ____exports