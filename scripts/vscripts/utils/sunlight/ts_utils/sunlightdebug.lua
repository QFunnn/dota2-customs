--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightDebug.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightDebug.lua",
	{
		["19"] = "10:1",
		["20"] = "12:11",
		["21"] = "12:28",
		["22"] = "12:59",
		["23"] = "12:28",
		["24"] = "13:9",
		["25"] = "14:15",
		["26"] = "15:15",
		["27"] = "16:15",
		["28"] = "17:15",
		["29"] = "18:15",
		["30"] = "19:13",
		["31"] = "20:13",
		["32"] = "21:13",
		["33"] = "22:13",
		["34"] = "23:13",
		["35"] = "18:40",
		["36"] = "25:13",
		["37"] = "27:19",
		["38"] = "27:34",
		["39"] = "27:52",
		["40"] = "27:34",
		["41"] = "28:17",
		["42"] = "29:30",
		["43"] = "29:30",
		["44"] = "29:30",
		["46"] = "29:23",
		["47"] = "30:17",
		["48"] = "31:21",
		["49"] = "32:21",
		["53"] = "37:13",
		["56"] = "10:1",
		["57"] = "62:11",
		["60"] = "66:5",
		["61"] = "67:9",
		["62"] = "68:9",
		["63"] = "69:9",
		["64"] = "70:9",
		["65"] = "66:5",
		["67"] = "76:5",
		["68"] = "77:9",
		["69"] = "76:5",
		["71"] = "83:5",
		["72"] = "84:55",
		["73"] = "84:17",
		["74"] = "84:27",
		["75"] = "84:32",
		["76"] = "84:38",
		["77"] = "84:46",
		["78"] = "85:15",
		["79"] = "86:13",
		["80"] = "87:19",
		["81"] = "88:18",
		["82"] = "89:17",
		["85"] = "83:5",
		["87"] = "97:5",
		["88"] = "98:55",
		["89"] = "98:17",
		["90"] = "98:27",
		["91"] = "98:32",
		["92"] = "98:38",
		["93"] = "98:46",
		["94"] = "99:14",
		["97"] = "101:13",
		["98"] = "102:13",
		["99"] = "103:19",
		["100"] = "104:17",
		["101"] = "105:17",
		["104"] = "109:9",
		["105"] = "110:13",
		["106"] = "111:13",
		["107"] = "112:17",
		["108"] = "112:28",
		["110"] = "109:28",
		["111"] = "97:5",
		["113"] = "116:7",
		["114"] = "142:7",
		["115"] = "142:27",
		["116"] = "142:44",
		["117"] = "142:27",
	}
)
--- 响应 player_chat 事件的监听，并执行一些默认调试功能的回调。
-- 在 player_chat 的回调函数中调用。不要直接作为事件的回调函数使用，因为这样无法重载
-- 部分指令被设定为默认指令(比如 'r' 'rs')，不可覆写。
--
-- @param event
-- @param CustomFunc
function RespondPlayerChat(event, CustomFunc)
	local lower_msg_list = __TS__StringSplit(string.lower(event.text), " ")
	if lower_msg_list and #lower_msg_list > 0 then
		local lower_msg = lower_msg_list[1]
		local args = __TS__ArraySplice(lower_msg_list, 1)
		local player = PlayerResource:GetPlayer(event.playerid)
		local hero = player:GetAssignedHero()
		local params = {
			playerId = event.playerid,
			key = lower_msg,
			args = args,
			player = player,
			hero = hero,
		}
		if __TS__ArrayIncludes(genericEvent_keys, lower_msg) then
			local event_record = __TS__ArrayFind(genericEvent, function(____, v)
				return v.key == lower_msg
			end)
			if event_record then
				local ____event_record_func_0 = event_record
				if ____event_record_func_0 ~= nil then
					____event_record_func_0 = ____event_record_func_0.func
				end
				local func = ____event_record_func_0
				DebugPrint(_G, "调用debug事件: " .. event_record.desc)
				if func then
					func(params)
				end
			end
		else
			CustomFunc(params)
		end
	end
end
DebugScripts = DebugScripts or {}
do
	--- 重载脚本 r
	function DebugScripts.ReloadScripts(params)
		SendToServerConsole("cl_script_reload")
		SendToServerConsole("script_reload")
		GameRules:Playtesting_UpdateAddOnKeyValues()
		FireGameEvent("client_reload_game_keyvalues", {})
	end
	--- 重启项目 rs
	function DebugScripts.Restart(params)
		SendToServerConsole("restart")
	end
	--- 设置时间缩放 tis
	function DebugScripts.TimeScale(params)
		local ____params_2 = params
		local playerId = ____params_2.playerId
		local key = ____params_2.key
		local args = ____params_2.args
		local player = ____params_2.player
		local hero = ____params_2.hero
		local scale = table.remove(args, 1)
		if scale then
			local num_scale = tonumber(scale)
			if not __TS__NumberIsNaN(__TS__Number(num_scale)) then
				Convars:SetFloat("host_timescale", num_scale)
			end
		end
	end
	--- 玩家英雄升级 lvlup
	function DebugScripts.HeroLevelUp(params)
		local ____params_3 = params
		local playerId = ____params_3.playerId
		local key = ____params_3.key
		local args = ____params_3.args
		local player = ____params_3.player
		local hero = ____params_3.hero
		if not IsValid(hero) then
			return
		end
		local level = 1
		if args and #args > 0 then
			local read_level = tonumber(args[1])
			if read_level then
				level = read_level
			end
		end
		Timers:CreateTimer(function()
			hero:HeroLevelUp(false)
			level = level - 1
			if level > 0 then
				return 0.15
			end
		end)
	end
end
genericEvent = {
	{ key = "r", desc = "重载脚本", func = DebugScripts.ReloadScripts },
	{ key = "rs", desc = "重启项目", func = DebugScripts.Restart },
	{ key = "tis", desc = "设置时间缩放", func = DebugScripts.TimeScale },
	{ key = "lvlup", desc = "玩家所属英雄升级", func = DebugScripts.HeroLevelUp },
}
genericEvent_keys = __TS__ArrayMap(genericEvent, function(____, v)
	return v.key
end)