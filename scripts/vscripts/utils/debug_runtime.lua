--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- debug runtime bootstrap
local ____exports = {}
local ____rawget_result_0 = rawget(_G, "__sunlight_debug_runtime")
if ____rawget_result_0 == nil then
	____rawget_result_0 = { source_maps = {}, ambiguous_sources = {} }
end
local state = ____rawget_result_0
rawset(_G, "__sunlight_debug_runtime", state)
local source_maps = state.source_maps
local ambiguous_sources = state.ambiguous_sources
local function nativeLibrary()
	local library = rawget(_G, "debug")
	local ____temp_1
	if type(library) == "table" then
		____temp_1 = library
	else
		____temp_1 = nil
	end
	return ____temp_1
end
local function normalizeFile(file)
	local result = string.gsub(file, "\\", "/")
	result = string.gsub(result, "^@", "")
	result = string.gsub(result, "^.-scripts/vscripts/", "")
	return result
end
--- 也可转换无 debug 环境中 error() 留下的文件名与行号；未命中的内容原样保留。
function ____exports.formatTraceback(trace)
	local function replace(file, line)
		local normalized = normalizeFile(file)
		local entry = source_maps[normalized]
		if not entry and string.sub(normalized, 1, 3) == "..." then
			local suffix = string.sub(normalized, 4)
			for key in pairs(source_maps) do
				local candidate = source_maps[key]
				if suffix ~= "" and string.sub(candidate.file, -#suffix) == suffix then
					if entry and entry.file ~= candidate.file then
						return (file .. ":") .. line
					end
					entry = candidate
				end
			end
		end
		local ____entry_lines_line_2 = entry
		if ____entry_lines_line_2 ~= nil then
			____entry_lines_line_2 = ____entry_lines_line_2.lines[line]
		end
		local mapped = ____entry_lines_line_2
		if mapped == nil then
			return (file .. ":") .. line
		end
		local source = string.gsub(entry.file, "%.lua$", ".ts")
		return (source .. ":") .. tostring(mapped)
	end
	local result = string.gsub(trace, '%[string "([^"]+)"%]:(%d+)', function(file, line)
		local converted = replace(file, line)
		local ____temp_4
		if converted == (file .. ":") .. line then
			____temp_4 = (('[string "' .. file) .. '"]:') .. line
		else
			____temp_4 = converted
		end
		return ____temp_4
	end)
	result = string.gsub(result, '([^%s"%[%]]+%.lua):(%d+)', replace)
	return result
end
--- 仅封装 TSTL 使用的 getinfo 签名；失败返回 nil，让 Error 构造仍可继续。
local function getInfo(target, flags)
	local ____nativeLibrary_result_getinfo_5 = nativeLibrary()
	if ____nativeLibrary_result_getinfo_5 ~= nil then
		____nativeLibrary_result_getinfo_5 = ____nativeLibrary_result_getinfo_5.getinfo
	end
	local getinfo = ____nativeLibrary_result_getinfo_5
	if type(getinfo) ~= "function" then
		return nil
	end
	if type(target) == "number" and target > 256 then
		return nil
	end
	local ____flags_7 = flags
	if ____flags_7 == nil then
		____flags_7 = "flnSu"
	end
	local requested = ____flags_7
	local ____pcall_9 = pcall
	local ____temp_8
	if type(target) == "number" then
		____temp_8 = target + 2
	else
		____temp_8 = target
	end
	local ok, info = ____pcall_9(getinfo, ____temp_8, requested)
	if not ok or type(info) ~= "table" then
		return nil
	end
	if string.find(requested, "f", 1, true) and type(info.func) ~= "function" then
		return nil
	end
	if string.find(requested, "S", 1, true) and type(info.short_src) ~= "string" then
		return nil
	end
	return info
end
--- 支持 debug.traceback 的 message/level 和 thread/message/level 两种调用方式。
function ____exports.traceback(thread_or_message, message_or_level, level)
	local library = nativeLibrary()
	local ____temp_15
	local ____temp_12 = library == state.hooked_library
	if ____temp_12 then
		local ____library_traceback_10 = library
		if ____library_traceback_10 ~= nil then
			____library_traceback_10 = ____library_traceback_10.traceback
		end
		____temp_12 = ____library_traceback_10 == state.installed_traceback
	end
	if ____temp_12 then
		____temp_15 = state.original_traceback
	else
		local ____library_traceback_13 = library
		if ____library_traceback_13 ~= nil then
			____library_traceback_13 = ____library_traceback_13.traceback
		end
		____temp_15 = ____library_traceback_13
	end
	local native_traceback = ____temp_15
	local has_thread = type(thread_or_message) == "thread"
	local ____has_thread_16
	if has_thread then
		____has_thread_16 = message_or_level
	else
		____has_thread_16 = thread_or_message
	end
	local message = ____has_thread_16
	if message ~= nil and type(message) ~= "string" then
		return message
	end
	if type(native_traceback) == "function" and native_traceback ~= ____exports.traceback then
		local ____has_thread_24
		if has_thread then
			local ____pcall_20 = pcall
			local ____thread_or_message_19 = thread_or_message
			local ____message_17 = message
			if ____message_17 == nil then
				____message_17 = ""
			end
			local ____level_18 = level
			if ____level_18 == nil then
				____level_18 = 1
			end
			____has_thread_24 =
				{ ____pcall_20(native_traceback, ____thread_or_message_19, ____message_17, ____level_18) }
		else
			local ____pcall_23 = pcall
			local ____message_21 = message
			if ____message_21 == nil then
				____message_21 = ""
			end
			local ____message_or_level_22 = message_or_level
			if ____message_or_level_22 == nil then
				____message_or_level_22 = 1
			end
			____has_thread_24 = { ____pcall_23(native_traceback, ____message_21, ____message_or_level_22 + 2) }
		end
		local ok, trace = unpack(____has_thread_24)
		if ok and type(trace) == "string" and trace ~= "" then
			return ____exports.formatTraceback(trace)
		end
	end
	local ____exports_formatTraceback_26 = ____exports.formatTraceback
	local ____message_25 = message
	if ____message_25 == nil then
		____message_25 = ""
	end
	return ____exports_formatTraceback_26(____message_25) .. "\n[debug.traceback 不可用，未采集调用栈]"
end
--- 仅宿主调用全局 debug.traceback 时通知；构造 Error/主动取栈不会误上报。
local function hostTraceback(thread_or_message, message_or_level, level)
	local ____temp_30
	if type(thread_or_message) == "thread" then
		____temp_30 = ____exports.traceback(thread_or_message, message_or_level, level)
	else
		local ____exports_traceback_29 = ____exports.traceback
		local ____thread_or_message_28 = thread_or_message
		local ____message_or_level_27 = message_or_level
		if ____message_or_level_27 == nil then
			____message_or_level_27 = 1
		end
		____temp_30 = ____exports_traceback_29(____thread_or_message_28, ____message_or_level_27 + 1)
	end
	local trace = ____temp_30
	if state.on_traceback and not state.notifying then
		state.notifying = true
		local ok, err = pcall(state.on_traceback, trace)
		state.notifying = false
		if not ok then
			print("[错误收集回调失败]", err)
		end
	end
	return trace
end
--- 单一订阅者，热重载替换回调；项目层无需再次改写 debug.traceback。
function ____exports.setTracebackListener(listener)
	state.on_traceback = listener
end
____exports.safe_debug = setmetatable({ getinfo = getInfo, traceback = ____exports.traceback }, {
	__index = function(self, key)
		local ____nativeLibrary_result_key_31 = nativeLibrary()
		if ____nativeLibrary_result_key_31 ~= nil then
			____nativeLibrary_result_key_31 = ____nativeLibrary_result_key_31[key]
		end
		return ____nativeLibrary_result_key_31
	end,
})
--- 文件名来自编译期，因此注册映射不要求运行时存在 debug.getinfo。
function ____exports.register(file, map)
	local normalized = normalizeFile(file)
	local entry = { file = normalized, lines = map }
	source_maps[normalized] = entry
	local ____getInfo_result_short_src_33 = getInfo(2, "S")
	if ____getInfo_result_short_src_33 ~= nil then
		____getInfo_result_short_src_33 = ____getInfo_result_short_src_33.short_src
	end
	local source = ____getInfo_result_short_src_33
	if source then
		local alias = string.gsub(source, '^%[string "(.*)"%]$', "%1")
		alias = normalizeFile(alias)
		if source_maps[alias] and source_maps[alias].file ~= normalized then
			ambiguous_sources[alias] = true
			source_maps[alias] = nil
		end
		if not ambiguous_sources[alias] then
			source_maps[alias] = entry
		end
	end
	local library = nativeLibrary()
	local ____type_37 = type
	local ____library_traceback_35 = library
	if ____library_traceback_35 ~= nil then
		____library_traceback_35 = ____library_traceback_35.traceback
	end
	if ____type_37(____library_traceback_35) ~= "function" or library.traceback == hostTraceback then
		return
	end
	if library ~= state.hooked_library or library.traceback ~= state.installed_traceback then
		state.original_traceback = library.traceback
	end
	state.hooked_library = library
	state.installed_traceback = hostTraceback
	pcall(function()
		library.traceback = hostTraceback
	end)
end
return ____exports