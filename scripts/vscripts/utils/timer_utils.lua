--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 启动一个执行N次的定时器
--
-- @export
-- @param callback 回调函数，如果返回数值，可以变成一个可变间隔的定时器
-- @param times 执行次数，如果不提供，那么只执行1次，如果不提供或者提供的数值为负数，那么会一直执行
function ____exports.LoopByTimer(self, callback, times)
	local repeatTimes = times or -10
	Timers:CreateTimer(function()
		repeatTimes = repeatTimes - 1
		local newInterval = callback(nil, repeatTimes)
		if repeatTimes == 0 then
			return
		end
		if newInterval and newInterval >= 0 then
			return newInterval
		end
	end)
end
return ____exports