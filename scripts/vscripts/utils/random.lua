--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local UINT32_MOD = 4294967296
local BOX_MULLER_MIN_U1 = 1e-12
local function normalizeSeed(self, seed)
	if not seed or not __TS__NumberIsFinite(__TS__Number(seed)) then
		return 1
	end
	local normalized = math.floor(math.abs(seed)) % UINT32_MOD
	return normalized <= 0 and 1 or normalized
end
--- 可设种子的伪随机数生成器。
--
-- 示例：
-- ```ts
-- const rng = new SeededRandom(12345);
--
-- const uniform = rng.next(); // [0, 1)
-- const intValue = rng.nextInt(1, 100); // [1, 100] 整数
-- const floatValue = rng.nextFloat(10, 20); // [10, 20) 浮点数
--
-- const normalValue = rng.normal({
--     mean: 50,
--     standardDeviation: 10,
--     min: 1,
--     max: 100,
-- });
--
-- const normalIntValue = rng.normalInt({
--     mean: 10,
--     standardDeviation: 2,
--     min: 1,
--     max: 20,
-- });
-- ```
____exports.SeededRandom = __TS__Class()
local SeededRandom = ____exports.SeededRandom
SeededRandom.name = "SeededRandom"
function SeededRandom.prototype.____constructor(self, seed)
	local actualSeed = math.floor(seed / 100)
	local iterationCount = math.floor(seed % 100 / 10)
	self.iterationCount = iterationCount
	self.state = normalizeSeed(nil, actualSeed)
end
function SeededRandom.prototype.setSeed(self, seed)
	self.state = normalizeSeed(nil, seed)
	self.cachedNormal = nil
end
function SeededRandom.prototype.getSeed(self)
	return self.state
end
function SeededRandom.prototype.next(self)
	self.state = (1664525 * self.state + 1013904223) % UINT32_MOD
	return self.state / UINT32_MOD
end
function SeededRandom.prototype.nextInt(self, min, max)
	local low = math.floor(math.min(min, max))
	local high = math.floor(math.max(min, max))
	return low + math.floor(self:next() * (high - low + 1))
end
function SeededRandom.prototype.nextFloat(self, min, max)
	if min == nil then
		min = 0
	end
	if max == nil then
		max = 1
	end
	local low = math.min(min, max)
	local high = math.max(min, max)
	return low + (high - low) * self:next()
end
function SeededRandom.prototype.standardNormal(self)
	if self.cachedNormal ~= nil then
		local value = self.cachedNormal
		self.cachedNormal = nil
		return value
	end
	local u1 = math.max(self:next(), BOX_MULLER_MIN_U1)
	local u2 = self:next()
	local radius = math.sqrt(-2 * math.log(u1))
	local theta = 2 * math.pi * u2
	self.cachedNormal = radius * math.sin(theta)
	return radius * math.cos(theta)
end
function SeededRandom.prototype.normal01(self, options)
	local value = self:normal({
		mean = options and options.mean or 0.5,
		standardDeviation = options and options.standardDeviation or 1 / 5,
		min = 0,
		max = 1,
	})
	local iterationBonus = math.sqrt(math.min(9, self.iterationCount) / 9) * 0.4 - 0.1
	return math.min(0.5, math.floor(value * 5 + 0.5) / 5 - 0.5 + iterationBonus)
end
function SeededRandom.prototype.normal(self, options)
	local mean = options and options.mean or 0
	local standardDeviation = math.max(0, options and options.standardDeviation or 1)
	local min = options and options.min
	local max = options and options.max
	if standardDeviation <= 0 then
		return self:clamp(mean, min, max)
	end
	do
		local i = 0
		while i < 8 do
			local value = mean + self:standardNormal() * standardDeviation
			if (min == nil or value >= min) and (max == nil or value <= max) then
				return value
			end
			i = i + 1
		end
	end
	return self:clamp(mean + self:standardNormal() * standardDeviation, min, max)
end
function SeededRandom.prototype.clamp(self, value, min, max)
	local result = value
	if min ~= nil then
		result = math.max(min, result)
	end
	if max ~= nil then
		result = math.min(max, result)
	end
	return result
end
function ____exports.createSeededRandom(self, seed)
	return __TS__New(____exports.SeededRandom, seed)
end
--- 单次创建随机源并采样正态分布。
--
-- 示例：
-- ```ts
-- const damageFactor = randomNormal(12345, {
--     mean: 1,
--     standardDeviation: 0.15,
--     min: 0.7,
--     max: 1.3,
-- });
-- ```
function ____exports.randomNormal(self, seed, options)
	return __TS__New(____exports.SeededRandom, seed):normal(options)
end
return ____exports