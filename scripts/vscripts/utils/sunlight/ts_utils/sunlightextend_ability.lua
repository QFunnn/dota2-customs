--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightExtend_Ability.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightExtend_Ability.lua",
	{
		["8"] = "28:5",
		["9"] = "29:15",
		["10"] = "30:9",
		["11"] = "28:36",
		["12"] = "33:5",
		["13"] = "34:15",
		["14"] = "35:15",
		["15"] = "36:14",
		["16"] = "36:34",
		["18"] = "37:9",
		["19"] = "33:46",
		["20"] = "40:5",
		["21"] = "41:15",
		["22"] = "42:13",
		["23"] = "43:13",
		["25"] = "45:13",
		["26"] = "46:13",
		["28"] = "40:39",
	}
)
local ____exports = {}
do
	CDOTABaseAbility.HasBehavior = function(self, behavior)
		local abilitybehavior = tonumber(tostring(self:GetBehavior()))
		return bit.band(abilitybehavior, behavior) > 0
	end
	CDOTABaseAbility.GetChannelElapsedTime = function(self)
		local start_time = self:GetChannelStartTime()
		local now = GameRules:GetGameTime()
		if not start_time or not now then
			return nil
		end
		return math.max(now - start_time, 0)
	end
	CDOTABaseAbility.ReduceCooldown = function(self, cooldown)
		local cooldownRemain = self:GetCooldownTimeRemaining()
		if cooldownRemain <= cooldown then
			self:EndCooldown()
		else
			self:EndCooldown()
			self:StartCooldown(cooldownRemain - cooldown)
		end
	end
end
return ____exports