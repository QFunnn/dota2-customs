--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__Number = ____lualib.__TS__Number
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
SLTable = SLTable or {}
do
	--- 列表去重 不改变原数据  O(n²)
	--
	-- @both
	function SLTable.UniqueArray(self, array)
		if array == nil then
			return {}
		end
		local result = {}
		do
			local i = 0
			local length = #array
			while i < length do
				local value = array[i + 1]
				if __TS__ArrayIndexOf(result, value) < 0 then
					result[#result + 1] = value
				end
				i = i + 1
			end
		end
		return result
	end
	--- 列表去重 改变原数据 O(n)
	--
	-- @both
	function SLTable.UniqueArrayInplace(self, array)
		if array == nil then
			return {}
		end
		local length = #array
		do
			local i = 0
			while i < length do
				local value = array[i + 1]
				do
					local j = i + 1
					while j < length do
						if value == array[j + 1] then
							__TS__ArraySplice(array, j, 1)
							length = length - 1
							j = j - 1
						end
						j = j + 1
					end
				end
				i = i + 1
			end
		end
	end
	--- 获取数组中的任意元素
	--
	-- @both
	function SLTable.GetRandomElement(self, arr)
		local count = #arr
		return arr[math.floor(math.random() * count) + 1]
	end
	--- 合并Record（相同的key会覆盖，只保留一个value）
	--
	-- @param records 需要合并的Record
	-- @returns 合并后的record
	-- @both
	function SLTable.GetJoinRecord(self, ...)
		local records = { ... }
		local result = {}
		for ____, record in ipairs(records) do
			for key in pairs(record) do
				local value = record[key]
				result[key] = value
			end
		end
		return result
	end
	--- 两两组合算法
	--
	-- @param arr 数组
	-- @both
	function SLTable.GetCombineList(self, arr)
		local result = {}
		do
			local i = 0
			while i < #arr do
				do
					local j = i + 1
					while j < #arr do
						result[#result + 1] = { arr[i + 1], arr[j + 1] }
						j = j + 1
					end
				end
				i = i + 1
			end
		end
		return result
	end
	--- 合并Record（相同的key会累加，只保留一个value，需要value为数字类型）
	--
	-- @param records 需要合并的Record
	-- @both
	function SLTable.GetSumRecord(self, ...)
		local records = { ... }
		local result = {}
		for ____, record in ipairs(records) do
			for key in pairs(record) do
				local value = record[key]
				local ____result_key_0 = result[key]
				if ____result_key_0 == nil then
					____result_key_0 = 0
				end
				result[key] = ____result_key_0
				result[key] = result[key] + value
			end
		end
		return result
	end
	--- 获取数组中出现次数最多的元素
	--
	-- @param arr 需要查找的数组
	-- both
	function SLTable.GetMostCommonElement(self, arr)
		local result = {}
		do
			local i = 0
			while i < #arr do
				local element = arr[i + 1]
				local ____result_element_1 = result[element]
				if ____result_element_1 == nil then
					____result_element_1 = 0
				end
				result[element] = ____result_element_1
				result[element] = result[element] + 1
				i = i + 1
			end
		end
		local max = 0
		local maxElement
		for key in pairs(result) do
			if result[key] > max then
				max = result[key]
				maxElement = key
			end
		end
		return maxElement
	end
	--- 字符串分割成record
	--
	-- @param str 需要分割的字符串
	-- @param pattern 分割符
	-- @param startIndex 起始索引
	-- @param splitType 分隔类型 0:Record<number,string> 1:Record<number,number>
	-- @both
	function SLTable.StringToRecord(self, str, pattern, startIndex, splitType)
		local result = {}
		local prev = 0
		local ____startIndex_2
		if startIndex then
			____startIndex_2 = startIndex
		else
			____startIndex_2 = 0
		end
		local index = ____startIndex_2
		if type(str) == "number" then
			result[index] = str
			return result
		end
		do
			local i = 0
			while i < #str do
				if __TS__StringAccess(str, i) == pattern then
					local temp = __TS__StringSubstring(str, prev, i)
					if splitType then
						if splitType == 0 then
							result[index] = temp
						elseif splitType == 1 then
							result[index] = __TS__Number(temp)
						end
					else
						result[index] = temp
					end
					prev = i + 1
					index = index + 1
				end
				i = i + 1
			end
		end
		if prev <= #str then
			local temp = __TS__StringSubstring(str, prev, #str)
			if splitType then
				if splitType == 0 then
					result[index] = temp
				elseif splitType == 1 then
					result[index] = __TS__Number(temp)
				end
			else
				result[index] = temp
			end
		end
		return result
	end
	--- 全排列算法
	--
	-- @param nums
	-- @returns both
	function SLTable.Permute(self, nums)
		local result
		local backtrack
		backtrack = function(____, n, nums, first)
			if first == n then
				local ____temp_3 = #result + 1
				result[____temp_3] = __TS__ArraySlice(nums)
				return ____temp_3
			end
			do
				local i = first
				while i < n do
					local ____temp_4 = { nums[i + 1], nums[first + 1] }
					nums[first + 1] = ____temp_4[1]
					nums[i + 1] = ____temp_4[2]
					backtrack(_G, n, nums, first + 1)
					local ____temp_5 = { nums[i + 1], nums[first + 1] }
					nums[first + 1] = ____temp_5[1]
					nums[i + 1] = ____temp_5[2]
					i = i + 1
				end
			end
		end
		result = {}
		backtrack(_G, #nums, nums, 0)
		return result
	end
	--- 把当前的playerid变成group
	--
	-- @both
	function SLTable.GroupPlayerIDs(self, playerIds)
		local res = {}
		do
			local groupNo = 0
			while playerIds[groupNo * 2 + 1] ~= nil do
				local player1 = playerIds[groupNo * 2 + 1]
				local player2 = playerIds[groupNo * 2 + 1 + 1]
				res[#res + 1] = { player1, player2 }
				groupNo = groupNo + 1
			end
		end
		return res
	end
	--- TODO: ???
	--
	-- @both
	function SLTable.SetupOpponentNoDuplicate(self, playerIds, pairRecord, considerCount)
		if considerCount == nil then
			considerCount = #playerIds - 1
		end
		local all_permutes = SLTable.Permute(_G, playerIds)
		local old_pairs = {}
		local sort = __TS__ArraySort(
			__TS__ArrayMap(__TS__ObjectKeys(pairRecord), function(____, a)
				return __TS__Number(a)
			end),
			function(____, a, b)
				return b - a
			end
		)
		do
			local i = 0
			while i < considerCount do
				local r = sort[i + 1]
				local ss = pairRecord[r]
				if ss then
					__TS__ArrayForEach(SLTable.GroupPlayerIDs(_G, ss), function(____, pair)
						local ____temp_6 = #old_pairs + 1
						old_pairs[____temp_6] = pair
						return ____temp_6
					end)
				end
				i = i + 1
			end
		end
		local res = {}
		local failure = {}
		__TS__ArrayForEach(all_permutes, function(____, arrangement)
			local ____pairs = SLTable.GroupPlayerIDs(_G, arrangement)
			local valid = true
			do
				local i = 0
				while i < #____pairs do
					local new_pair = ____pairs[i + 1]
					do
						local i = 0
						while i < #old_pairs do
							local old_pair = old_pairs[i + 1]
							if
								new_pair[1] == old_pair[1] and new_pair[2] == old_pair[2]
								or new_pair[1] == old_pair[2] and new_pair[2] == old_pair[1]
							then
								failure[#failure + 1] = { ____pairs, new_pair, old_pair }
								valid = false
								break
							end
							i = i + 1
						end
					end
					i = i + 1
				end
			end
			if valid then
				res[#res + 1] = arrangement
			end
		end)
		if #res <= 0 then
			considerCount = considerCount - 1
			if considerCount > 0 then
				return SLTable.SetupOpponentNoDuplicate(_G, playerIds, pairRecord, considerCount)
			end
			return SLTable.GetRandomElement(_G, all_permutes)
		else
			return SLTable.GetRandomElement(_G, res)
		end
	end
	--- 获取一个数字数组最大值与最小值的差值
	--
	-- @param arr
	-- @both
	function SLTable.GetMaxSubMinNumberInArray(self, numbers)
		local max = numbers[1]
		local min = numbers[1]
		do
			local i = 0
			while i < #numbers do
				if max < numbers[i + 1] then
					max = numbers[i + 1]
				end
				if min > numbers[i + 1] then
					min = numbers[i + 1]
				end
				i = i + 1
			end
		end
		return max - min
	end
end