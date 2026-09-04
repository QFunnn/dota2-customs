--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


---@diagnostic disable: missing-parameter
local typeName = "pool"

--- removeByValue   [删除值] 从表格中删除指定值，返回删除的值的个数
--- @param array table  表格
--- @param value any  要删除的值
--- @param removeAll boolean  是否删除所有相同的值
--- @return integer
function table.removeByValue(array, value, removeAll)
	local c, i, max = 0, 1, #array
	while i <= max do
		if array[i] == value then
			table.remove(array, i)
			c = c + 1
			i = i - 1
			max = max - 1
			if not removeAll then
				break
			end
		end
		i = i + 1
	end
	return c
end

-- 将奖品置换成权重奖品
local prizeChange = function(self, object, proportion)
	return {
		object = object,
		proportion = proportion,
		virtualProportion = proportion * self.gain,
	}
end

--- 添加总权重
local addTotalProportion = function(self, proportion)
	self.totalProportion = self.totalProportion + proportion
	self.virtualTotalProportion = math.modf(self.totalProportion * self.gain)
end

local mt = {
	--- 往奖池添加奖品
	add = function(self, object, proportion)
		if self.mappingTable[object] then
			local pro = self:get(object)
			self:remove(object)
			return self:add(object, pro + proportion)
		end
		if self.upperLimit and self.len >= self.upperLimit then
			print("addingPrizes - 添加失败,当前权重池已满!", object)
			return
		end
		proportion = proportion or 1
		addTotalProportion(self, proportion)
		local weightPrize = prizeChange(self, object, proportion)
		self.mappingTable[object] = weightPrize
		table.insert(self.data, weightPrize)
		self.len = self.len + 1
		return self
	end,

	--- 降低奖品概率
	sub = function(self, object, proportion)
		if self.mappingTable[object] then
			local pro = self:get(object)
			self:remove(object)
			return self:add(object, pro - proportion)
		else
			print("没有这个奖品,降低权重失败!", object)
			return
		end
	end,

	--- 将奖品移除出奖池
	remove = function(self, object)
		if not self.mappingTable[object] then
			print("removePrizes - 移除失败,不存在的索引!", object)
			return
		end
		self.mappingTable[object] = nil
		for _, value in ipairs(self.data) do
			if value.object == object then
				table.removeByValue(self.data, value)
				addTotalProportion(self, -value.proportion)
				self.len = self.len - 1
				break
			end
		end
		return self
	end,
	--- 获取奖品得奖概率
	getProbability = function(self, object)
		local weightPrize = self.mappingTable[object]
		return weightPrize.proportion / self.totalProportion, weightPrize.proportion
	end,

	--获取权重
	get = function(self, object)
		local weightPrize = self.mappingTable[object]
		return weightPrize and weightPrize.proportion
	end,

	--获取权重
	getWeightPrize = function(self, object)
		local weightPrize = self.mappingTable[object]
		return weightPrize and weightPrize.proportion
	end,
	--- 修改奖品权重
	setWeightPrize = function(self, object, proportion)
		local weightPrize = self.mappingTable[object]
		if not weightPrize then
			return
		end
		local used = weightPrize.proportion
		self.totalProportion = self.totalProportion - used
		weightPrize.proportion = proportion or used
		weightPrize.virtualProportion = weightPrize.proportion * self.gain
		self.totalProportion = self.totalProportion + weightPrize.proportion
		self.virtualTotalProportion = math.modf(self.totalProportion * self.gain)
		return used, weightPrize.proportion
	end,
	--- 随机抽取 没有则返回nil
	random = function(self)
		if self.len == 0 then
			return nil
		end
		local winningProbability = self._random_(self.virtualTotalProportion)
		for _, value in ipairs(self.data) do
			winningProbability = winningProbability - value.virtualProportion
			if winningProbability <= 0 then
				return value.object
			end
		end
	end,
	--- 随机抽取并移除抽取对象 没有则返回nil
	randomAndRemove = function(self)
		if self.len == 0 then
			return nil
		end
		local winningProbability = self._random_(self.virtualTotalProportion)
		for _, value in ipairs(self.data) do
			winningProbability = winningProbability - value.virtualProportion
			if winningProbability <= 0 then
				table.removeByValue(self.data, value, false)
				addTotalProportion(self, -value.proportion)
				self.mappingTable[value.object] = nil
				self.len = self.len - 1
				return value.object
			end
		end
	end,
	--- 清空奖池内奖品
	clear = function(self)
		self.len = 0
		self.data = {}
		self.mappingTable = {}
		self.totalProportion = 0
		self.virtualTotalProportion = 0
		return self
	end,

	--随机抽取n个不重复的对象
	randomSole = function(self, n)
		local t = {}
		local t2 = {}
		for i = 1, n do
			local obj = self:random()
			if obj then
				table.insert(t, obj)
				t2[i] = { obj, self:getWeightPrize(obj) }
				self:setWeightPrize(obj, 0)
			end
		end
		for i = 1, n do
			if t2[i] and t2[i] then
				self:add(t2[i][1], t2[i][2])
			end
		end
		return t
	end,

	--抽卡随机[取出n张卡牌]
	randomCard = function(self, n)
		local t = {}
		local t2 = {}
		for i = 1, n do
			local obj = self:random()
			if obj then
				table.insert(t, obj)
				local w = self:getWeightPrize(obj)
				t2[i] = { obj, 1 }
				self:setWeightPrize(obj, w - 1)
			end
		end
		for i = 1, n do
			if t2[i] and t2[i] then
				self:add(t2[i][1], 1)
			end
		end
		return t
	end,

	--随机抽取n个不重复的对象，排除指定对象
	randomSoleExclude = function(self, n, ...)
		local excludeItems = { ... } -- 将可变参数转为表
		local excludeSet = {}
		for _, item in ipairs(excludeItems) do
			excludeSet[item] = true
		end

		local t = {}
		local t2 = {}
		local originalWeights = {}

		-- 先保存排除项的原始权重并设为0
		for _, item in ipairs(excludeItems) do
			if self.mappingTable[item] then
				originalWeights[item] = self:getWeightPrize(item)
				self:setWeightPrize(item, 0)
			end
		end

		-- 随机抽取
		for i = 1, n do
			local obj = self:random()
			if obj then
				table.insert(t, obj)
				t2[i] = { obj, self:getWeightPrize(obj) }
				self:setWeightPrize(obj, 0)
			end
		end

		-- 恢复所有权重
		for i = 1, n do
			if t2[i] then
				self:add(t2[i][1], t2[i][2])
			end
		end
		-- 恢复排除项的原始权重
		for item, weight in pairs(originalWeights) do
			self:setWeightPrize(item, weight)
		end
		return t
	end,
}

local meta = {
	__index = mt,
	__tostring = function(self)
		return ("{%s | 名称(%s) 奖品数量(%d) 总比重(%s)}"):format(
			typeName,
			self.name,
			self.len,
			self.totalProportion
		)
	end,
	--- 获取奖池内奖品数量
	__len = function(self)
		return self.len
	end,
	--- 遍历奖池内所有奖品
	__pairs = function(self)
		return ipairs(self.data)
	end,
}
setmetatable(meta, meta)

local virtual = 10000

--- @class prizePool

-- 创建池子的工厂函数
local function createPool(name, upperLimit, gain)
	---@type prizePool
	local object = {
		type = typeName,
		len = 0,
		name = name or "未命名奖池",
		upperLimit = upperLimit,
		totalProportion = 0,
		virtualTotalProportion = 0,
		gain = gain or virtual,
		data = {},
		mappingTable = {},
	}
	object._random_ = math.random
	setmetatable(object, meta)
	return object
end

-- 创建 RandomPool 全局对象（类似 Timers）
if _G.RandomPool == nil then
	print("[RandomPool] creating RandomPool")
	_G.RandomPool = {}
	setmetatable(RandomPool, {
		__call = function(t, ...)
			return t:CreatePool(...)
		end,
	})
end

function RandomPool:CreatePool(name, upperLimit, gain)
	return createPool(name, upperLimit, gain)
end

GameRules.RandomPool = GameRules.RandomPool or RandomPool

-- --示例:

-- local pool1 = RandomPool:CreatePool("我的奖池")
-- -- 或者使用简写: local pool1 = RandomPool("我的奖池")
-- pool1:add("ability1",100)
-- pool1:add("ability2",100)
-- pool1:add("ability3",100)

-- --第一次随机
-- local item=pool1:random()
-- print("random:",item, pool1:getWeightPrize(item))
-- pool1:setWeightPrize(item,pool1:getWeightPrize(item)/10)    ---修改权重

-- --第二次随机
-- item=pool1:random()
-- print("random:",item, pool1:getWeightPrize(item))
-- pool1:setWeightPrize(item,pool1:getWeightPrize(item)/10)

-- --第三次随机
-- item=pool1:random()
-- print("random:",item, pool1:getWeightPrize(item))
-- pool1:setWeightPrize(item,pool1:getWeightPrize(item)/10)

-- print(pool1:getProbability("ability1"))