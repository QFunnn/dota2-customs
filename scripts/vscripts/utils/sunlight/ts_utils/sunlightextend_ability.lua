--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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