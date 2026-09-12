--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local queryHostPlayer
local ReleaseBootstrap = require("utils.release_bootstrap")
function queryHostPlayer(self, environment)
	local queries = {
		{
			source = "GetListenServerHost",
			get = function()
				return GetListenServerHost()
			end,
		},
		{
			source = "Entities.GetLocalPlayer",
			get = function()
				return Entities:GetLocalPlayer()
			end,
		},
	}
	for ____, query in ipairs(queries) do
		local queryStep = query.source
		do
			local function ____catch(____error)
				environment.host_query_state = "error"
				local ____environment_11 = environment
				local ____environment_host_query_reason_10 = environment.host_query_reason
				if ____environment_host_query_reason_10 == nil then
					____environment_host_query_reason_10 = queryStep
				end
				____environment_11.host_query_reason = ____environment_host_query_reason_10
				local ____environment_13 = environment
				local ____environment_host_query_error_12
				if environment.host_query_error then
					____environment_host_query_error_12 = environment.host_query_error .. "; "
				else
					____environment_host_query_error_12 = ""
				end
				____environment_13.host_query_error = ((____environment_host_query_error_12 .. queryStep) .. ": ")
					.. tostring(____error)
			end
			local ____try, ____hasReturned, ____returnValue = pcall(function()
				local host = query:get()
				if host and IsValidEntity(host) then
					queryStep = query.source .. ".GetController"
					local ____temp_1
					if type(host.GetController) == "function" then
						____temp_1 = host:GetController()
					else
						____temp_1 = host
					end
					local controller = ____temp_1
					if controller and IsValidEntity(controller) then
						queryStep = query.source .. ".GetEntityIndex"
						local hostEntityIndex = controller:GetEntityIndex()
						if hostEntityIndex ~= nil and hostEntityIndex > 0 then
							queryStep = query.source .. ".PlayerResource.GetPlayer"
							do
								local slot = 0
								while slot < DOTA_MAX_PLAYERS do
									local playerId = slot
									if PlayerResource:IsValidPlayerID(playerId) then
										local player = PlayerResource:GetPlayer(playerId)
										if
											player
											and IsValidEntity(player)
											and player:GetEntityIndex() == hostEntityIndex
										then
											environment.host_query_source = query.source
											return true, playerId
										end
									end
									slot = slot + 1
								end
							end
							local ____environment_3 = environment
							local ____environment_host_query_reason_2 = environment.host_query_reason
							if ____environment_host_query_reason_2 == nil then
								____environment_host_query_reason_2 = "player_resource_unavailable"
							end
							____environment_3.host_query_reason = ____environment_host_query_reason_2
						else
							local ____environment_5 = environment
							local ____environment_host_query_reason_4 = environment.host_query_reason
							if ____environment_host_query_reason_4 == nil then
								____environment_host_query_reason_4 = "entity_index_unavailable"
							end
							____environment_5.host_query_reason = ____environment_host_query_reason_4
						end
					else
						local ____environment_7 = environment
						local ____environment_host_query_reason_6 = environment.host_query_reason
						if ____environment_host_query_reason_6 == nil then
							____environment_host_query_reason_6 = "controller_unavailable"
						end
						____environment_7.host_query_reason = ____environment_host_query_reason_6
					end
				else
					local ____environment_9 = environment
					local ____environment_host_query_reason_8 = environment.host_query_reason
					if ____environment_host_query_reason_8 == nil then
						____environment_host_query_reason_8 = "host_entity_unavailable"
					end
					____environment_9.host_query_reason = ____environment_host_query_reason_8
				end
			end)
			if not ____try then
				____hasReturned, ____returnValue = ____catch(____hasReturned)
			end
			if ____hasReturned then
				return ____returnValue
			end
		end
	end
	return nil
end
--- 仅供展示与诊断，不参与发布包选钥，也不能证明服务器或战绩可信。
function ____exports.GetServerEnvironment(self)
	local environment = { kind = "unknown", host_query_state = "pending" }
	local previewHost = ReleaseBootstrap.get_key_source() == "development" or ReleaseBootstrap.get_stage() == "test"
	local dedicated
	do
		local function ____catch(____error)
			environment.server_query_error = tostring(____error)
		end
		local ____try, ____hasReturned = pcall(function()
			dedicated = IsDedicatedServer()
			environment.kind = IsInToolsMode() and "tools"
				or (dedicated == true and "dedicated" or (dedicated == false and "listen" or "unknown"))
		end)
		if not ____try then
			____catch(____hasReturned)
		end
	end
	if not previewHost and dedicated == true then
		environment.host_query_state = "dedicated"
		return environment
	end
	local playerId = previewHost and 0 or queryHostPlayer(nil, environment)
	if previewHost then
		environment.host_query_source = "preview_player_0"
	end
	local queryStep = "IsValidPlayerID"
	do
		local function ____catch(____error)
			environment.host_query_state = "error"
			environment.host_query_reason = queryStep
			environment.host_query_error = tostring(____error)
		end
		local ____try, ____hasReturned, ____returnValue = pcall(function()
			if playerId == nil or playerId < 0 or not PlayerResource:IsValidPlayerID(playerId) then
				local ____environment_host_query_reason_0 = environment.host_query_reason
				if ____environment_host_query_reason_0 == nil then
					____environment_host_query_reason_0 = "player_id_unavailable"
				end
				environment.host_query_reason = ____environment_host_query_reason_0
				return true, environment
			end
			environment.host_player_id = playerId
			queryStep = "GetSteamAccountID"
			local accountId = PlayerResource:GetSteamAccountID(playerId)
			if not (accountId > 0) then
				environment.host_query_reason = "steam_account_unavailable"
				return true, environment
			end
			environment.host_steam_account_id = tostring(accountId)
			queryStep = "GetSteamID"
			local steamId = PlayerResource:GetSteamID(playerId):__tostring()
			if steamId == nil or steamId == "" or steamId == "0" then
				environment.host_query_reason = "steam_id_unavailable"
				return true, environment
			end
			environment.host_steam_id = steamId
			environment.host_query_state = "ready"
			environment.host_query_reason = nil
		end)
		if not ____try then
			____hasReturned, ____returnValue = ____catch(____hasReturned)
		end
		if ____hasReturned then
			return ____returnValue
		end
	end
	return environment
end
--- 本局主机的 32 位 Steam AccountID 字符串；没有主机或账号未就绪时返回空字符串。
function ____exports.GetHostSteamAccountID(self)
	local ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14 = GameInfos.SERVER_ENVIRONMENT
	if ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14 ~= nil then
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14 =
			____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14.host_steam_account_id
	end
	local ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16 =
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14
	if ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16 == nil then
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16 =
			____exports.GetServerEnvironment(nil).host_steam_account_id
	end
	local ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16_17 =
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16
	if ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16_17 == nil then
		____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16_17 = ""
	end
	return ____GameInfos_SERVER_ENVIRONMENT_host_steam_account_id_14_16_17
end
return ____exports