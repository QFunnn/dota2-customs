--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


_G.PUBLISH_TIMESTAMP = "2026-8-27 10:56"

local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
require("utils.index")
require("modules.frame_type.index")
require("modifiers.index")
require("abilities.index")
require("type.index")
require("enhance.init")
require("modules.custom_projectile_manager")
require("modules.GlobalFunctions")
local ____modules = require("modules.index")
local ActivateModules = ____modules.ActivateModules
local ____precache = require("utils.precache")
local Precache = ____precache.default
require("OnTrigger")
__TS__ObjectAssign(getfenv(), {
	Activate = function()
		ActivateModules(nil)
	end,
	Precache = Precache,
})
return ____exports