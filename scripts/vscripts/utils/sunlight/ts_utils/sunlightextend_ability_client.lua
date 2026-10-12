--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightExtend_Ability_Client.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightExtend_Ability_Client.lua",
	{
		["8"] = "7:5",
		["9"] = "8:15",
		["10"] = "9:9",
		["11"] = "7:37",
		["12"] = "12:5",
		["13"] = "13:15",
		["14"] = "14:15",
		["15"] = "15:14",
		["16"] = "15:53",
		["18"] = "16:9",
		["19"] = "12:47",
	}
)
local ____exports = {}
do
	C_DOTABaseAbility.HasBehavior = function(self, behavior)
		local abilitybehavior = tonumber(tostring(self:GetBehavior()))
		return bit.band(abilitybehavior, behavior) > 0
	end
	C_DOTABaseAbility.GetChannelElapsedTime = function(self)
		local start_time = self:GetChannelStartTime()
		local now = GameRules:GetGameTime()
		if not start_time or not now or start_time == 0 then
			return nil
		end
		return math.max(now - start_time, 0)
	end
end
return ____exports