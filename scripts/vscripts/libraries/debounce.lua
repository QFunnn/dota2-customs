--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function Debounce(delay, callback)
	local nextTimeKey, lastResultKey = DoUniqueString("DebounceNextTime"), DoUniqueString("DebounceLastResult")

	return function(self, ...)
		local curTime = GameRules:GetGameTime()
		if self[nextTimeKey] and self[nextTimeKey] > curTime then
			return self[lastResultKey] and unpack(self[lastResultKey])
		end

		local result = { callback(self, ...) }
		local notEmptyResult = next(result) ~= nil

		self[lastResultKey] = notEmptyResult and result
		self[nextTimeKey] = curTime + delay

		return notEmptyResult and unpack(result)
	end
end