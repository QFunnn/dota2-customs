--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/_index.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/_index.lua",
	{ ["7"] = "10:8", ["8"] = "2:1", ["9"] = "3:1", ["10"] = "4:1", ["11"] = "5:1", ["12"] = "8:1" }
)
local ____exports = {}
require("utils.multi_extends")
require("utils.aeslua")
require("utils.decrypt")
require("utils.json")
require("utils.md5")
_G.SHA = require("utils.sha")
return ____exports