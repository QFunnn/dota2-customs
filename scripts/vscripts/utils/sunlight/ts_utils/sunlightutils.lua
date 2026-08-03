--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
function SunlightSayHello(self)
	print("Hello")
end
--- 只在在工具模式下print
-- 可以使用更为简写的方式 printd
--
-- @both
function DebugPrint(self, ...)
	if IsInToolsMode() then
		print(...)
	end
end
SLUtils = SLUtils or {}
do
	--- 回调遍历单位的所有技能
	--
	-- @param unit 单位
	-- @param callback 遍历的callback
	-- @server
	function SLUtils.UnitAbilitiesForEach(self, unit, callback)
		do
			local i = 0
			while i < DOTA_MAX_ABILITIES do
				local a = unit:GetAbilityByIndex(i)
				if a then
					callback(_G, a)
				end
				i = i + 1
			end
		end
	end
	--- 创建一个有生命周期的计时器。
	--
	-- @param lifetime 生命周期。从计时器开始运行时计算（不计算delay）
	-- @param callback 计时器的回调函数
	-- @param delay 延迟
	-- @param callbackOnDestroy 计时器到达生命周期时的回调函数
	-- @server
	function SLUtils.CreateTimerWithLifetime(self, lifetime, callback, delay, callbackOnDestroy)
		local counter = 0
		local runInterval = FrameTime()
		local callbackInterval = 0
		local callbackCounter = 0
		local ____Timers_2 = Timers
		local ____Timers_CreateTimer_3 = Timers.CreateTimer
		local ____delay_0 = delay
		if ____delay_0 == nil then
			____delay_0 = 0
		end
		return ____Timers_CreateTimer_3(____Timers_2, ____delay_0, function()
			if counter >= lifetime then
				if callbackOnDestroy then
					callbackOnDestroy(_G)
				end
				return
			end
			if callbackInterval and type(callbackInterval) == "number" and callbackCounter >= callbackInterval then
				local ____callback_result_1 = callback(_G)
				if ____callback_result_1 == nil then
					____callback_result_1 = nil
				end
				callbackInterval = ____callback_result_1
				callbackCounter = 0
			end
			counter = counter + runInterval
			callbackCounter = callbackCounter + runInterval
			return runInterval
		end)
	end
	--- 摧毁投射物并release
	--
	-- @both
	function SLUtils.DestoryParticleAndRelease(self, pid)
		if pid then
			ParticleManager:DestroyParticle(pid, false)
			ParticleManager:ReleaseParticleIndex(pid)
		end
	end
	--- 热力图rgb
	--
	-- @param progress 强度(0~1)
	-- @returns R(0-255) G(0-255) B(0-255)
	function SLUtils.HotMapRGB(self, progress)
		local aR = 0
		local aG = 255
		local aB = 0
		local bR = 255
		local bG = 0
		local bB = 0
		return (bR - aR) * progress + aR, (bG - aG) * progress + aG, (bB - aB) * progress + aB
	end
	--- 是否是夜晚的游戏时间（不管夜魔大和临时夜晚）
	--
	-- @returns
	function SLUtils.IsGameTimeNight(self)
		local time_of_day = GameRules:GetTimeOfDay()
		if time_of_day < 0.25 and time_of_day > 0.75 then
			return true
		end
		return false
	end
end