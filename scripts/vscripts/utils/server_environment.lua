--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ReleaseBootstrap = require("utils.release_bootstrap")
--- 仅供展示与诊断，不参与发布包选钥，也不能证明服务器或战绩可信。
function ____exports.GetServerEnvironment(self)
	local environment = { kind = "unknown" }
	local previewHost = ReleaseBootstrap.get_key_source() == "development" or ReleaseBootstrap.get_stage() == "test"
	local dedicated
	do
		pcall(function()
			dedicated = IsDedicatedServer()
			environment.kind = IsInToolsMode() and "tools" or (dedicated and "dedicated" or "listen")
		end)
	end
	do
		pcall(function()
			local playerId
			if previewHost then
				playerId = 0
			elseif dedicated == false then
				local host = GetListenServerHost()
				if IsValid(host) then
					playerId = host:GetPlayerID()
				end
			end
			if playerId ~= nil and playerId >= 0 and PlayerResource:IsValidPlayerID(playerId) then
				environment.host_player_id = playerId
				local accountId = PlayerResource:GetSteamAccountID(playerId)
				if accountId > 0 then
					environment.host_steam_account_id = tostring(accountId)
					environment.host_steam_id = PlayerResource:GetSteamID(playerId):__tostring()
				end
			end
		end)
	end
	return environment
end
--- 本局主机的 32 位 Steam AccountID 字符串；没有主机或账号未就绪时返回空字符串。
function ____exports.GetHostSteamAccountID(self)
	local ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0 = GameInfos.SERVER_ENVIRONMENT
	if ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0 ~= nil then
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0 =
			____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0.host_steam_account_id
	end
	local ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2 =
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0
	if ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2 == nil then
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2 =
			____exports.GetServerEnvironment(nil).host_steam_account_id
	end
	local ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2_3 =
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2
	if ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2_3 == nil then
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2_3 = ""
	end
	return ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_0_2_3
end
return ____exports