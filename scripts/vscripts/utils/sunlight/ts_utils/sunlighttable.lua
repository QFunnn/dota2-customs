--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightTable.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
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
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightTable.lua",
	{
		["16"] = "1:11",
		["21"] = "6:5",
		["22"] = "7:13",
		["23"] = "7:28",
		["25"] = "8:15",
		["27"] = "9:18",
		["28"] = "9:25",
		["29"] = "9:48",
		["30"] = "10:19",
		["31"] = "11:17",
		["32"] = "12:17",
		["34"] = "9:60",
		["37"] = "15:9",
		["38"] = "6:5",
		["42"] = "22:5",
		["43"] = "23:13",
		["44"] = "23:28",
		["46"] = "24:13",
		["48"] = "25:18",
		["49"] = "25:25",
		["50"] = "26:19",
		["52"] = "27:22",
		["53"] = "27:33",
		["54"] = "28:21",
		["55"] = "29:21",
		["56"] = "30:21",
		["57"] = "31:21",
		["59"] = "27:45",
		["62"] = "25:37",
		["65"] = "22:5",
		["69"] = "41:5",
		["70"] = "42:15",
		["71"] = "43:9",
		["72"] = "41:5",
		["78"] = "52:5",
		["79"] = "52:38",
		["80"] = "53:15",
		["81"] = "54:9",
		["82"] = "55:24",
		["83"] = "56:23",
		["84"] = "57:17",
		["87"] = "60:9",
		["88"] = "52:5",
		["93"] = "68:5",
		["94"] = "69:15",
		["96"] = "70:18",
		["97"] = "70:25",
		["99"] = "71:22",
		["100"] = "71:33",
		["101"] = "72:17",
		["102"] = "71:49",
		["105"] = "70:41",
		["108"] = "75:9",
		["109"] = "68:5",
		["114"] = "83:5",
		["115"] = "83:37",
		["116"] = "84:15",
		["117"] = "85:9",
		["118"] = "86:24",
		["119"] = "87:23",
		["120"] = "88:31",
		["122"] = "88:31",
		["124"] = "88:17",
		["125"] = "89:17",
		["128"] = "92:9",
		["129"] = "83:5",
		["134"] = "100:5",
		["135"] = "101:15",
		["137"] = "102:18",
		["138"] = "102:25",
		["139"] = "103:19",
		["140"] = "104:31",
		["142"] = "104:31",
		["144"] = "104:13",
		["145"] = "105:13",
		["146"] = "102:41",
		["149"] = "107:13",
		["150"] = "108:13",
		["151"] = "109:20",
		["152"] = "110:17",
		["153"] = "111:17",
		["154"] = "112:17",
		["157"] = "115:9",
		["158"] = "100:5",
		["166"] = "126:5",
		["167"] = "127:15",
		["168"] = "128:13",
		["169"] = "129:21",
		["170"] = "129:21",
		["171"] = "129:34",
		["173"] = "129:47",
		["175"] = "129:13",
		["176"] = "130:13",
		["177"] = "131:13",
		["178"] = "132:13",
		["181"] = "134:18",
		["182"] = "134:25",
		["183"] = "135:17",
		["184"] = "136:23",
		["185"] = "137:21",
		["186"] = "138:25",
		["187"] = "139:25",
		["188"] = "140:32",
		["189"] = "141:25",
		["192"] = "144:21",
		["194"] = "146:17",
		["195"] = "147:17",
		["197"] = "134:41",
		["200"] = "150:13",
		["201"] = "151:19",
		["202"] = "152:17",
		["203"] = "153:21",
		["204"] = "154:21",
		["205"] = "155:28",
		["206"] = "156:21",
		["209"] = "159:17",
		["212"] = "162:9",
		["213"] = "126:5",
		["218"] = "170:5",
		["219"] = "179:15",
		["220"] = "171:15",
		["221"] = "171:15",
		["222"] = "172:17",
		["223"] = "172:37",
		["224"] = "172:37",
		["225"] = "172:30",
		["228"] = "173:22",
		["229"] = "173:33",
		["230"] = "174:42",
		["231"] = "174:18",
		["232"] = "174:31",
		["233"] = "175:17",
		["234"] = "176:42",
		["235"] = "176:18",
		["236"] = "176:31",
		["237"] = "173:40",
		["240"] = "171:27",
		["241"] = "179:15",
		["242"] = "180:9",
		["243"] = "181:9",
		["244"] = "170:5",
		["248"] = "188:5",
		["249"] = "189:15",
		["251"] = "190:18",
		["252"] = "190:31",
		["253"] = "191:19",
		["254"] = "192:19",
		["255"] = "193:13",
		["256"] = "190:65",
		["259"] = "195:9",
		["260"] = "188:5",
		["264"] = "202:5",
		["265"] = "205:9",
		["266"] = "205:9",
		["268"] = "207:15",
		["269"] = "209:15",
		["270"] = "210:15",
		["271"] = "210:32",
		["272"] = "210:32",
		["273"] = "211:18",
		["274"] = "210:32",
		["275"] = "212:19",
		["276"] = "210:32",
		["278"] = "213:18",
		["279"] = "213:25",
		["280"] = "214:19",
		["281"] = "215:19",
		["282"] = "216:17",
		["283"] = "216:21",
		["284"] = "1:11",
		["285"] = "216:48",
		["286"] = "216:56",
		["287"] = "216:56",
		["288"] = "216:56",
		["289"] = "216:48",
		["290"] = "216:21",
		["292"] = "213:46",
		["295"] = "219:15",
		["296"] = "220:15",
		["297"] = "221:9",
		["298"] = "221:9",
		["299"] = "221:30",
		["300"] = "222:19",
		["301"] = "223:17",
		["303"] = "224:22",
		["304"] = "224:29",
		["305"] = "225:23",
		["307"] = "226:26",
		["308"] = "226:33",
		["309"] = "227:27",
		["310"] = "228:26",
		["311"] = "229:25",
		["312"] = "230:25",
		["315"] = "226:57",
		["318"] = "224:49",
		["321"] = "235:17",
		["322"] = "236:17",
		["324"] = "221:30",
		["325"] = "221:9",
		["326"] = "239:13",
		["327"] = "240:13",
		["328"] = "241:17",
		["329"] = "242:17",
		["331"] = "244:13",
		["333"] = "246:13",
		["335"] = "202:5",
		["340"] = "255:5",
		["341"] = "256:13",
		["342"] = "257:13",
		["344"] = "258:18",
		["345"] = "258:25",
		["346"] = "259:17",
		["347"] = "260:17",
		["349"] = "262:17",
		["350"] = "263:17",
		["352"] = "258:45",
		["355"] = "266:9",
		["356"] = "255:5",
	}
)
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