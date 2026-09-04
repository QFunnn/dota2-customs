--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local copyTables
function copyTables(self, destination, keysTable, valuesTable)
	valuesTable = valuesTable or keysTable
	local mt = getmetatable(keysTable)
	if mt and getmetatable(destination) ~= nil then
		setmetatable(destination, mt)
	end
	for k, v in pairs(keysTable) do
		if type(v) == "table" then
			destination[k] = copyTables(nil, {}, v, valuesTable[v])
		else
			destination[k] = valuesTable[k]
		end
	end
	return destination
end
--- MIT LICENSE
--
-- Copyright (c) 2014 Enrique García Cota, Yuichi Tateno, Emmanuel Oga
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- BASED ON https://github.com/kikito/tween.lua
-- Copyright (c) 2014 Enrique García Cota, Yuichi Tateno, Emmanuel Oga
-- MIT LICENSE
--
-- Modified to TypescriptToLua version by XavierCHN
--
-- @ 2025.04.28
-- @example ```Typescript
-- import { tween } from './utils/tween';
--
-- const pos = { x: 0, y: 0 };
-- const end = { x: 100, y: 100 };
-- const duration = 1;
-- const myTween = tween(duration, pos, end, 'outQuad')
-- let now = GameRules.GetGameTime();
-- Timers.CreateTimer(() => {
-- let newTime = GameRules.GetGameTime();
-- let deltaTime = newTime - now;
-- now = newTime;
-- const finished = myTween.update(deltaTime);
-- if (finished) {
-- print('Tween finished!');
-- return null;
-- } else {
-- print(pos.x, pos.y);
-- return 0.033;
-- }
-- });
-- ```
local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin
local EasingFunctions = {}
do
	--- 线性缓动函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.linear(self, t, b, c, d)
		return c * t / d + b
	end
	--- 二次方缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inQuad(self, t, b, c, d)
		return c * pow(t / d, 2) + b
	end
	--- 二次方缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outQuad(self, t, b, c, d)
		t = t / d
		return -c * t * (t - 2) + b
	end
	--- 二次方缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutQuad(self, t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return c / 2 * pow(t, 2) + b
		end
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
	--- 二次方缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInQuad(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outQuad(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inQuad(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 三次方缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inCubic(self, t, b, c, d)
		return c * pow(t / d, 3) + b
	end
	--- 三次方缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outCubic(self, t, b, c, d)
		return c * (pow(t / d - 1, 3) + 1) + b
	end
	--- 三次方缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutCubic(self, t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return c / 2 * t * t * t + b
		end
		t = t - 2
		return c / 2 * (t * t * t + 2) + b
	end
	--- 三次方缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInCubic(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outCubic(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inCubic(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 四次方缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inQuart(self, t, b, c, d)
		return c * pow(t / d, 4) + b
	end
	--- 四次方缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outQuart(self, t, b, c, d)
		return -c * (pow(t / d - 1, 4) - 1) + b
	end
	--- 四次方缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutQuart(self, t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return c / 2 * pow(t, 4) + b
		end
		return -c / 2 * (pow(t - 2, 4) - 2) + b
	end
	--- 四次方缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInQuart(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outQuart(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inQuart(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 五次方缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inQuint(self, t, b, c, d)
		return c * pow(t / d, 5) + b
	end
	--- 五次方缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outQuint(self, t, b, c, d)
		return c * (pow(t / d - 1, 5) + 1) + b
	end
	--- 五次方缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutQuint(self, t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return c / 2 * pow(t, 5) + b
		end
		return c / 2 * (pow(t - 2, 5) + 2) + b
	end
	--- 五次方缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInQuint(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outQuint(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inQuint(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 正弦缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inSine(self, t, b, c, d)
		return -c * cos(t / d * (pi / 2)) + c + b
	end
	--- 正弦缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outSine(self, t, b, c, d)
		return c * sin(t / d * (pi / 2)) + b
	end
	--- 正弦缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutSine(self, t, b, c, d)
		return -c / 2 * (cos(pi * t / d) - 1) + b
	end
	--- 正弦缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInSine(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outSine(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inSine(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 指数缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inExpo(self, t, b, c, d)
		if t == 0 then
			return b
		end
		return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end
	--- 指数缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outExpo(self, t, b, c, d)
		if t == d then
			return b + c
		end
		return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
	end
	--- 指数缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutExpo(self, t, b, c, d)
		if t == 0 then
			return b
		end
		if t == d then
			return b + c
		end
		t = t / d * 2
		if t < 1 then
			return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
		end
		return c / 2 * 1.0005 * (-pow(2, -10 * (t - 1)) + 2) + b
	end
	--- 指数缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInExpo(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outExpo(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inExpo(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 圆形缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inCirc(self, t, b, c, d)
		return -c * (sqrt(1 - pow(t / d, 2)) - 1) + b
	end
	--- 圆形缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outCirc(self, t, b, c, d)
		return c * sqrt(1 - pow(t / d - 1, 2)) + b
	end
	--- 圆形缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutCirc(self, t, b, c, d)
		t = t / d * 2
		if t < 1 then
			return -c / 2 * (sqrt(1 - t * t) - 1) + b
		end
		t = t - 2
		return c / 2 * (sqrt(1 - t * t) + 1) + b
	end
	--- 圆形缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInCirc(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outCirc(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inCirc(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
	--- 计算弹性缓动所需的参数 p, a, s
	--
	-- @param p 周期
	-- @param a 振幅
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 包含 p, a, s 的元组
	local function calculatePAS(self, p, a, c, d)
		p = p or d * 0.3
		a = a or 0
		if a < abs(c) then
			return { p, c, p / 4 }
		end
		return {
			p,
			a,
			p / (2 * pi) * asin(c / a),
		}
	end
	--- 弹性缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param a 振幅，可选参数
	-- @param p 周期，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.inElastic(self, t, b, c, d, a, p)
		if t == 0 then
			return b
		end
		t = t / d
		if t == 1 then
			return b + c
		end
		local pVal, aVal, s = unpack(calculatePAS(nil, p, a, c, d))
		t = t - 1
		return -(aVal * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / pVal)) + b
	end
	--- 弹性缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param a 振幅，可选参数
	-- @param p 周期，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.outElastic(self, t, b, c, d, a, p)
		if t == 0 then
			return b
		end
		t = t / d
		if t == 1 then
			return b + c
		end
		local pVal, aVal, s = unpack(calculatePAS(nil, p, a, c, d))
		return aVal * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / pVal) + c + b
	end
	--- 弹性缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param a 振幅，可选参数
	-- @param p 周期，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.inOutElastic(self, t, b, c, d, a, p)
		if t == 0 then
			return b
		end
		t = t / d * 2
		if t == 2 then
			return b + c
		end
		local pVal, aVal, s = unpack(calculatePAS(nil, p, a, c, d))
		t = t - 1
		if t < 0 then
			return -0.5 * (aVal * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / pVal)) + b
		end
		return aVal * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / pVal) * 0.5 + c + b
	end
	--- 弹性缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param a 振幅，可选参数
	-- @param p 周期，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.outInElastic(self, t, b, c, d, a, p)
		if t < d / 2 then
			return EasingFunctions.outElastic(nil, t * 2, b, c / 2, d, a, p)
		end
		return EasingFunctions.inElastic(nil, t * 2 - d, b + c / 2, c / 2, d, a, p)
	end
	--- 来自小丑牌的弹性缓动效果
	-- fuck 数学太差了，小丑牌的弹性缓动效果怎么那么好
	-- 不知道是不是小丑牌原创
	-- 总归目前为止据我所知 © LocalThunk
	--
	-- @export
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @return 计算后的当前值
	function EasingFunctions.elasticBalatro(self, t, b, c, d)
		local p = (d - t) / d
		p = -pow(2, 10 * p - 10) * sin((p * 10 - 10.75) * (2 * pi) / 3)
		return p * b + (1 - p) * (b + c)
	end
	--- 回退缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param s 回退量，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.inBack(self, t, b, c, d, s)
		s = s or 1.70158
		t = t / d
		return c * t * t * ((s + 1) * t - s) + b
	end
	--- 回退缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param s 回退量，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.outBack(self, t, b, c, d, s)
		s = s or 1.70158
		t = t / d - 1
		return c * (t * t * ((s + 1) * t + s) + 1) + b
	end
	--- 回退缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param s 回退量，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.inOutBack(self, t, b, c, d, s)
		s = (s or 1.70158) * 1.525
		t = t / d * 2
		if t < 1 then
			return c / 2 * (t * t * ((s + 1) * t - s)) + b
		end
		t = t - 2
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end
	--- 回退缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @param s 回退量，可选参数
	-- @returns 计算后的当前值
	function EasingFunctions.outInBack(self, t, b, c, d, s)
		if t < d / 2 then
			return EasingFunctions.outBack(nil, t * 2, b, c / 2, d, s)
		end
		return EasingFunctions.inBack(nil, t * 2 - d, b + c / 2, c / 2, d, s)
	end
	--- 弹跳缓动退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outBounce(self, t, b, c, d)
		t = t / d
		if t < 1 / 2.75 then
			return c * (7.5625 * t * t) + b
		end
		if t < 2 / 2.75 then
			t = t - 1.5 / 2.75
			return c * (7.5625 * t * t + 0.75) + b
		elseif t < 2.5 / 2.75 then
			t = t - 2.25 / 2.75
			return c * (7.5625 * t * t + 0.9375) + b
		end
		t = t - 2.625 / 2.75
		return c * (7.5625 * t * t + 0.984375) + b
	end
	--- 弹跳缓动进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inBounce(self, t, b, c, d)
		return c - EasingFunctions.outBounce(nil, d - t, 0, c, d) + b
	end
	--- 弹跳缓动进入和退出函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.inOutBounce(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.inBounce(nil, t * 2, 0, c, d) * 0.5 + b
		end
		return EasingFunctions.outBounce(nil, t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
	end
	--- 弹跳缓动退出和进入函数
	--
	-- @param t 当前时间
	-- @param b 初始值
	-- @param c 变化量
	-- @param d 总时长
	-- @returns 计算后的当前值
	function EasingFunctions.outInBounce(self, t, b, c, d)
		if t < d / 2 then
			return EasingFunctions.outBounce(nil, t * 2, b, c / 2, d)
		end
		return EasingFunctions.inBounce(nil, t * 2 - d, b + c / 2, c / 2, d)
	end
end
--- 递归检查 subject 和 target 对象
--
-- @param subject 源对象
-- @param target 目标对象
-- @param path 当前路径
local function checkSubjectAndTargetRecursively(self, subject, target, path)
	if path == nil then
		path = {}
	end
	local targetType
	local newPath
	for k, targetValue in pairs(target) do
		do
			targetType = type(targetValue)
			local ____ = targetType
			newPath = copyTables(nil, {}, path)
			local ____ = newPath
		end
		table.insert(newPath, tostring(k))
		if targetType == "number" then
			assert(
				type(subject[k]) == "number",
				("Parameter '" .. table.concat(newPath, "/")) .. "' is missing from subject or isn't a number"
			)
		elseif targetType == "table" then
			checkSubjectAndTargetRecursively(nil, subject[k], targetValue, newPath)
		else
			assert(
				targetType == "number",
				("Parameter '" .. table.concat(newPath, "/")) .. "' must be a number or table of numbers"
			)
		end
	end
end
--- 检查新参数的有效性
--
-- @param duration 持续时间
-- @param subject 源对象
-- @param target 目标对象
-- @param easing 缓动函数
local function checkNewParams(self, duration, subject, target, easing)
	assert(
		type(duration) == "number" and duration > 0,
		"duration must be a positive number. Was " .. tostring(duration)
	)
	local tsubject = type(subject)
	assert(
		tsubject == "table" or tsubject == "userdata",
		"subject must be a table or userdata. Was " .. tostring(subject)
	)
	assert(type(target) == "table", "target must be a table. Was " .. tostring(target))
	assert(type(easing) == "function", "easing must be a function. Was " .. tostring(easing))
	checkSubjectAndTargetRecursively(nil, subject, target)
end
--- 获取缓动函数
--
-- @param easing 缓动函数或函数名
-- @returns 缓动函数
local function getEasingFunction(self, easingName)
	if easingName == nil then
		easingName = "linear"
	end
	if type(easingName) == "function" then
		return easingName
	end
	local func = EasingFunctions[easingName]
	if type(func) ~= "function" then
		error(("The easing function name '" .. easingName) .. "' is invalid")
	end
	return func
end
--- 对 subject 对象执行缓动操作
--
-- @param subject 源对象
-- @param target 目标对象
-- @param initial 初始对象
-- @param clock 当前时钟
-- @param duration 持续时间
-- @param easing 缓动函数
local function performEasingOnSubject(self, subject, target, initial, clock, duration, easing)
	local t
	local b
	local c
	local d
	for k in pairs(target) do
		local v = target[k]
		if type(v) == "table" then
			performEasingOnSubject(nil, subject[k], v, initial[k], clock, duration, easing)
		else
			t = clock
			b = initial[k]
			c = v - initial[k]
			d = duration
			subject[k] = easing(nil, t, b, c, d)
		end
	end
end
local Tween = __TS__Class()
Tween.name = "Tween"
function Tween.prototype.____constructor(self, duration, subject, target, easing, clock)
	if clock == nil then
		clock = 0
	end
	self.duration = duration
	self.subject = subject
	self.target = target
	self.easing = easing
	self.clock = clock
end
function Tween.prototype.set(self, clock)
	assert(type(clock) == "number", "clock must be a number")
	self.initial = self.initial or copyTables(nil, {}, self.target, self.subject)
	self.clock = clock
	if self.clock <= 0 then
		self.clock = 0
		copyTables(nil, self.subject, self.initial)
	elseif self.clock >= self.duration then
		self.clock = self.duration
		copyTables(nil, self.subject, self.target)
	else
		performEasingOnSubject(nil, self.subject, self.target, self.initial, self.clock, self.duration, self.easing)
	end
	return self.clock >= self.duration
end
function Tween.prototype.reset(self)
	return self:set(0)
end
function Tween.prototype.update(self, dt)
	assert(type(dt) == "number", "dt must be a number")
	return self:set(self.clock + dt)
end
function ____exports.tween(self, duration, subject, target, easing)
	if easing == nil then
		easing = "linear"
	end
	local easingFunction = getEasingFunction(nil, easing)
	checkNewParams(nil, duration, subject, target, easingFunction)
	return __TS__New(Tween, duration, subject, target, easingFunction)
end
return ____exports