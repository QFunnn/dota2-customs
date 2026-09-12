--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


print("loading addon dota_super_mid compiled@2026-9-11 16:46:43")
local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
require("_pre_init")
require("utils.sunlight.index")
require("utils._index")
require("extends._index_server")
require("global._index")
local _____index = require("modules._index")
local ActivateModules = _____index.ActivateModules
local ____precache = require("precache")
local Precache = ____precache.default
require("modifiers._loader")
__TS__ObjectAssign(getfenv(), {
	Activate = function()
		ActivateModules(nil)
	end,
	Precache = Precache,
})
return ____exports