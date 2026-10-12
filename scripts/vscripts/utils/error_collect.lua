--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/error_collect.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__ArrayFindIndex = ____lualib.__TS__ArrayFindIndex
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__StringSplit = ____lualib.__TS__StringSplit
____debugRuntime.register(
	"utils/error_collect.lua",
	{
		["10"] = "87:10",
		["11"] = "2:1",
		["12"] = "2:10",
		["13"] = "2:27",
		["14"] = "2:49",
		["15"] = "87:1",
		["16"] = "88:10",
		["19"] = "89:9",
		["20"] = "90:5",
		["21"] = "90:45",
		["22"] = "90:61",
		["25"] = "91:5",
		["26"] = "92:13",
		["29"] = "93:13",
		["30"] = "94:13",
		["31"] = "95:13",
		["32"] = "96:13",
		["33"] = "97:28",
		["34"] = "98:22",
		["37"] = "99:17",
		["38"] = "100:17",
		["39"] = "101:22",
		["40"] = "101:31",
		["42"] = "97:19",
		["43"] = "103:13",
		["44"] = "104:20",
		["45"] = "106:24",
		["46"] = "107:17",
		["47"] = "107:17",
		["48"] = "108:21",
		["49"] = "110:42",
		["50"] = "110:69",
		["52"] = "110:69",
		["54"] = "107:17",
		["55"] = "107:17",
		["56"] = "108:21",
		["57"] = "109:21",
		["58"] = "110:21",
		["59"] = "111:21",
		["60"] = "112:21",
		["61"] = "107:17",
		["62"] = "104:32",
		["63"] = "115:13",
		["64"] = "116:18",
		["65"] = "116:22",
		["70"] = "31:27",
		["72"] = "31:27",
		["74"] = "31:7",
		["75"] = "32:1",
		["76"] = "33:7",
		["77"] = "34:7",
		["78"] = "35:7",
		["79"] = "37:1",
		["80"] = "38:12",
		["81"] = "39:13",
		["82"] = "39:34",
		["84"] = "40:15",
		["85"] = "42:13",
		["86"] = "43:19",
		["87"] = "44:17",
		["88"] = "44:104",
		["91"] = "46:9",
		["92"] = "38:30",
		["93"] = "48:12",
		["94"] = "48:28",
		["95"] = "48:28",
		["96"] = "48:33",
		["98"] = "48:40",
		["100"] = "48:5",
		["101"] = "37:1",
		["102"] = "51:1",
		["103"] = "51:38",
		["104"] = "51:38",
		["106"] = "52:11",
		["107"] = "54:9",
		["108"] = "54:26",
		["110"] = "56:9",
		["113"] = "57:5",
		["114"] = "58:13",
		["118"] = "60:9",
		["119"] = "62:15",
		["120"] = "62:24",
		["121"] = "62:48",
		["122"] = "62:24",
		["123"] = "63:13",
		["126"] = "64:9",
		["128"] = "66:5",
		["129"] = "66:5",
		["130"] = "66:26",
		["131"] = "66:41",
		["132"] = "66:52",
		["133"] = "66:65",
		["134"] = "66:80",
		["135"] = "66:24",
		["136"] = "67:5",
		["137"] = "51:1",
		["138"] = "70:1",
		["139"] = "70:37",
		["140"] = "70:37",
		["142"] = "71:18",
		["143"] = "71:63",
		["144"] = "71:63",
		["145"] = "71:72",
		["147"] = "71:95",
		["149"] = "71:11",
		["150"] = "72:5",
		["151"] = "70:1",
		["152"] = "75:1",
		["153"] = "75:53",
		["154"] = "75:53",
		["156"] = "76:12",
		["157"] = "76:33",
		["158"] = "76:43",
		["159"] = "77:9",
		["160"] = "78:9",
		["161"] = "76:43",
		["162"] = "76:26",
		["163"] = "80:12",
		["164"] = "80:12",
		["165"] = "80:17",
		["167"] = "80:26",
		["169"] = "80:5",
		["170"] = "75:1",
		["171"] = "83:1",
		["172"] = "84:5",
		["173"] = "84:45",
		["175"] = "83:1",
		["176"] = "121:1",
		["177"] = "122:5",
		["178"] = "123:10",
		["179"] = "124:9",
		["180"] = "125:9",
		["182"] = "127:9",
		["183"] = "128:9",
		["184"] = "128:44",
		["185"] = "128:47",
		["186"] = "130:13",
		["187"] = "131:13",
		["188"] = "128:47",
		["189"] = "128:23",
		["191"] = "134:5",
		["192"] = "121:1",
		["193"] = "137:1",
		["194"] = "138:1",
		["195"] = "139:1",
		["196"] = "140:1",
		["197"] = "141:1",
		["198"] = "142:1",
		["199"] = "143:1",
	}
)
local ____exports = {}
local FlushErrorReports, state, MAX_ATTEMPTS, MAX_IN_FLIGHT
local ____debug_runtime = require("utils.debug_runtime")
local formatTraceback = ____debug_runtime.formatTraceback
local setTracebackListener = ____debug_runtime.setTracebackListener
local traceback = ____debug_runtime.traceback
function FlushErrorReports()
	if not state.enabled or state.dispatching or not IsServer() or not HTTP or not GameInfos then
		return
	end
	local active = 0
	for ____, report in ipairs(state.reports) do
		if report.sending then
			active = active + 1
		end
	end
	for ____, report in ipairs(state.reports) do
		if active >= MAX_IN_FLIGHT then
			break
		end
		if report.pending and not report.sending and report.attempts < MAX_ATTEMPTS then
			report.sending = true
			report.attempts = report.attempts + 1
			active = active + 1
			local function finish(success)
				if not report.sending then
					return
				end
				report.sending = false
				report.pending = not success
				if not success then
					print("[错误上报失败]", report.attempts, "/", MAX_ATTEMPTS)
				end
			end
			state.dispatching = true
			local ok = pcall(function()
				local message = string.gsub(report.message, "[\r\n]+$", "")
				local ____HTTP_10 = HTTP
				local ____HTTP_Request_11 = HTTP.Request
				local ____report_player_id_9 = report.player_id
				local ____temp_8 = message .. "\n\n"
				local ____PUBLISH_TIMESTAMP_7 = PUBLISH_TIMESTAMP
				if ____PUBLISH_TIMESTAMP_7 == nil then
					____PUBLISH_TIMESTAMP_7 = "unknown"
				end
				____HTTP_Request_11(
					____HTTP_10,
					____report_player_id_9,
					"/api/game/v1/gameLog/save",
					{ info = nil, error = ____temp_8, version = ____PUBLISH_TIMESTAMP_7, matchId = GameInfos.MATCH_ID },
					function()
						return finish(true)
					end,
					function()
						return finish(false)
					end
				)
			end)
			state.dispatching = false
			if not ok then
				finish(false)
			end
		end
	end
end
local ____rawget_result_0 = rawget(_G, "__sunlight_error_state")
if ____rawget_result_0 == nil then
	____rawget_result_0 = { reports = {} }
end
state = ____rawget_result_0
rawset(_G, "__sunlight_error_state", state)
local MAX_REPORTS = 200
MAX_ATTEMPTS = 3
MAX_IN_FLIGHT = 4
local function errorText(value)
	local ok, text = pcall(function()
		if value == nil then
			return "未提供错误信息"
		end
		local message = tostring(value)
		if type(value) == "table" then
			local stack = value.stack
			if type(stack) == "string" and stack ~= "" and not string.find(message, stack, 1, true) then
				return (message .. "\n") .. stack
			end
		end
		return message
	end)
	local ____formatTraceback_2 = formatTraceback
	local ____ok_1
	if ok then
		____ok_1 = text
	else
		____ok_1 = "[错误对象无法转换为字符串]"
	end
	return ____formatTraceback_2(____ok_1)
end
local function SaveError(message, player_id)
	if player_id == nil then
		player_id = -1
	end
	local text = errorText(message)
	if IsInToolsMode() then
		print(text)
	end
	if state.dispatching or not IsServer() then
		return
	end
	for ____, report in ipairs(state.reports) do
		if report.message == text and report.player_id == player_id then
			return
		end
	end
	if #state.reports >= MAX_REPORTS then
		local oldest = __TS__ArrayFindIndex(state.reports, function(____, report)
			return not report.sending
		end)
		if oldest < 0 then
			return
		end
		__TS__ArraySplice(state.reports, oldest, 1)
	end
	local ____state_reports_3 = state.reports
	____state_reports_3[#____state_reports_3 + 1] = {
		message = text,
		player_id = player_id,
		attempts = 0,
		pending = true,
		sending = false,
	}
	FlushErrorReports()
end
local function SLError(message, context, source)
	if context == nil then
		context = "SLError"
	end
	local ____temp_5 = (("[" .. context) .. "] ") .. errorText(message)
	local ____source_4
	if source then
		____source_4 = "\n[调用位置] " .. source
	else
		____source_4 = ""
	end
	local text = ____temp_5 .. ____source_4
	SaveError(traceback(text, 2))
end
local function SafelyCall(callback, context, source)
	if context == nil then
		context = "SafelyCall"
	end
	local ok, result = xpcall(callback, function(err)
		SLError(err, context, source)
		return err
	end)
	local ____ok_6
	if ok then
		____ok_6 = result
	else
		____ok_6 = nil
	end
	return ____ok_6
end
local function DebugPrintStrByLine(message)
	for ____, line in ipairs(__TS__StringSplit(message, "\n")) do
		print(line)
	end
end
local function InitErrorReporting(server_address)
	state.enabled = IsServer() and server_address ~= "" and server_address ~= nil
	if not state.enabled and state.timer ~= nil then
		SysTimer:RemoveTimer(state.timer)
		state.timer = nil
	end
	if state.enabled and state.timer == nil then
		state.timer = SysTimer:CreateTimer(5, function()
			_G.FlushErrorReports()
			return 5
		end)
	end
	FlushErrorReports()
end
_G.SaveError = SaveError
_G.SLError = SLError
_G.SafelyCall = SafelyCall
_G.DebugPrintStrByLine = DebugPrintStrByLine
_G.InitErrorReporting = InitErrorReporting
_G.FlushErrorReports = FlushErrorReports
setTracebackListener(function(trace)
	return SaveError(trace)
end)
return ____exports