--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightExtend_Npc_Client.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightExtend_Npc_Client.lua",
	{ ["8"] = "7:5", ["9"] = "8:9", ["10"] = "7:31" }
)
local ____exports = {}
do
	C_DOTA_BaseNPC.HasShard = function(self)
		return self:HasModifier("modifier_item_aghanims_shard")
	end
end
return ____exports