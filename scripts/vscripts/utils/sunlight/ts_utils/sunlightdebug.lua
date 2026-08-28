--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
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