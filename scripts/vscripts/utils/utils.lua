--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


-- 报错处理
-- _G.old_debug_traceback = old_debug_traceback or debug.traceback;
-- if not _G.tErrorGsub then
-- 	_G.tErrorGsub = {};
-- end;
-- debug.traceback = function(error, ...)
-- 	local a = old_debug_traceback(error, ...);
-- 	for k, v in pairs(_G.tErrorGsub) do
-- 		a = string.gsub(a, k, v);
-- 	end;
--   if(error) then
--       print('报错效果')
--       print("[debug error]:", a);
--       Event:send("error_msg", a);
--       print('发送报错数据到服务器!')
--       -- Event.FireEvent("system:error", a);
--   end
-- 	return a;
-- end;

-- 查找所有匹配项
-- 参数:
-- str: 要匹配的字符串
-- pattern: Lua模式匹配字符串
-- 返回: 包含所有匹配结果的数组
StringMatchAll = function(str, pattern)
	if not str or not pattern then
		return {}
	end

	local results = {}
	local index = 1

	-- 循环查找所有匹配项
	while index <= #str do
		local matches = { string.match(str:sub(index), pattern) }
		if #matches == 0 then
			break
		end

		table.insert(results, matches)

		-- 更新索引位置，向前移动匹配字符串的长度
		local matchedText = matches[1]
		local matchPos = string.find(str:sub(index), matchedText, 1, true)
		if not matchPos then
			break
		end

		index = index + matchPos + #matchedText - 1
	end

	return results
end

-- 提取函数名和行号的辅助函数
-- 专门用于解析调用堆栈
ExtractFunctionInfo = function(stackLine)
	if not stackLine then
		return nil
	end

	-- 尝试匹配 "function name:line"
	local funcName, lineNum = string.match(stackLine, "function%s+([^:]+):(%d+)")
	if funcName and lineNum then
		return { funcName, lineNum }
	end

	-- 尝试匹配 "in function <name>"
	funcName = string.match(stackLine, "in%s+function%s+['<]([^'>]+)['<]")
	if funcName then
		return { funcName, "0" }
	end

	-- 尝试匹配文件名和行号
	local fileName, lineNum = string.match(stackLine, "([%w_%.]+%.%w+):(%d+)")
	if fileName and lineNum then
		return { fileName, lineNum }
	end

	return nil
end

Bezier3 = function(p, t)
	return (1 - t) ^ 3 * p[1] + 3 * p[2] * t * (1 - t) ^ 2 + 3 * p[3] * t ^ 2 * (1 - t) + p[4] * t ^ 3
end
Bezier2 = function(p, t)
	return (1 - t) ^ 2 * p[1] + 2 * t * (1 - t) * p[2] + t ^ 2 * p[3]
end

Split = function(str, symbol)
	if str == nil or str == "" or symbol == nil then
		return
	end
	local tab = {}
	for match in (str .. symbol):gmatch("(.-)" .. symbol) do
		table.insert(tab, match)
	end
	return tab
end

--缓存时间戳
_G._unix_time_str = _G._unix_time_str or 0
_G._unix_time = _G._unix_time or 0
GetUnix = function()
	local time = GetSystemTime()
	--如果时间戳相同，则直接返回,减少计算开销
	if time == _G._unix_time_str then
		return _G._unix_time
	end
	_G._unix_time_str = time
	local dateArr = Split(GetSystemDate(), "/")
	dateArr[3] = "20" .. dateArr[3]
	local timeArr = Split(time, ":")
	local sec = (tonumber(timeArr[3]) or 0)
		+ (tonumber(timeArr[2]) or 0) * 60
		+ (tonumber(timeArr[1]) or 0) * 60 * 60
		+ ((tonumber(dateArr[2]) or 1) - 1) * 60 * 60 * 24
	local year = tonumber(dateArr[3]) or 1970
	local min = (tonumber(dateArr[1]) or 1) - 1
	for i = 1, min do
		if i == 1 or i == 3 or i == 5 or i == 7 or i == 8 or i == 10 or i == 12 then
			sec = sec + 31 * 60 * 60 * 24
		elseif i == 4 or i == 6 or i == 9 or i == 11 then
			sec = sec + 30 * 60 * 60 * 24
		else
			if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
				sec = sec + 29 * 60 * 60 * 24
			else
				sec = sec + 28 * 60 * 60 * 24
			end
		end
	end
	local day = 0
	for i = 1970, year - 1 do
		if (i % 4 == 0 and i % 100 ~= 0) or (i % 400 == 0) then
			day = day + 366
		else
			day = day + 365
		end
	end
	sec = sec + day * 60 * 60 * 24
	if IsDedicatedServer() then
		sec = sec + 8 * 3600
	end
	_G._unix_time = sec - 8 * 3600
	return _G._unix_time
end

split = function(str, p)
	local rt = {}
	-- 检查 str 和 p 是否都不为 nil
	if str and p then
		str:gsub("[^" .. p .. "]+", function(w)
			table.insert(rt, w)
		end)
	end
	return rt
end