--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 准入前及无效局禁止业务请求；Tools Mode 保留现有调试入口。
function ____exports.CanUseMatchBackend(self)
	local ____GameInfos_MATCH_ADMISSION_2 = GameInfos
	if ____GameInfos_MATCH_ADMISSION_2 ~= nil then
		____GameInfos_MATCH_ADMISSION_2 = ____GameInfos_MATCH_ADMISSION_2.MATCH_ADMISSION
	end
	local ____GameInfos_MATCH_ADMISSION_status_0 = ____GameInfos_MATCH_ADMISSION_2
	if ____GameInfos_MATCH_ADMISSION_status_0 ~= nil then
		____GameInfos_MATCH_ADMISSION_status_0 = ____GameInfos_MATCH_ADMISSION_status_0.status
	end
	local status = ____GameInfos_MATCH_ADMISSION_status_0
	return status ~= "rejected" and (IsInToolsMode() or status == "accepted")
end
return ____exports