--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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