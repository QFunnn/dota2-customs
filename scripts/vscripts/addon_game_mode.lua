--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


_G.PUBLISH_TIMESTAMP = "2026-8-3 11:28"

print("loading addon dota_super_mid compiled@2026-8-3 11:27:46")
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