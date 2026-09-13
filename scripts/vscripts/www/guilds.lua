--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if guilds == nil then
	_G.guilds = class({})
end

do
	_G.GuildsQuestsCollector = _G.GuildsQuestsCollector or class({})
	collector = _G.GuildsQuestsCollector

	collector.data = {}

	collector.InitPlayerData = function(playerId)
		collector.data[playerId] = {
			boss_kills = 0,
			boss_neutral_kills = 0,
			roshan_kills = 0,
			creep_kills = 0,
			game_over = 0,
			game_win = 0,
			gold_earned = 0,
		}

		return collector.data[playerId]
	end

	---@param recordData {hero?: metatable, playerId?: int, key: string, value: int}
	collector.Record = function(recordData)
		if GameRules:IsCheatMode() and not IsInToolsMode() then
			return
		end

		local playerId = recordData.playerId and tonumber(recordData.playerId) or nil
		if not playerId then
			local hero = recordData.hero
			if not hero or hero:IsNull() then
				return
			end

			playerId = hero:GetPlayerID()
			if playerId == -1 then
				local owner = hero:GetOwner()
				if not owner or owner:IsNull() then
					return
				end

				playerId = owner:GetPlayerID()
			end
		end

		if playerId < 0 or playerId > 4 then
			return
		end

		playerData = collector.data[playerId] or collector.InitPlayerData(playerId)

		if not playerData[recordData.key] then
			return
		end

		playerData[recordData.key] = playerData[recordData.key] + recordData.value
	end

	collector.Send = function()
		if GameRules:IsCheatMode() and not IsInToolsMode() then
			return
		end

		local players = {}

		for playerId, playerData in pairs(collector.data) do
			players[tostring(PlayerResource:GetSteamID(playerId))] = playerData
		end

		local arr = {
			players = players,
		}

		collector.data = {}

		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_quest_progress/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			if res.StatusCode == 200 and res.Body ~= nil then
				guilds:UseGuildResponseBody(t, json.decode(res.Body))
			end
		end)
	end
end

function guilds:RegisterHudListener(event_name, function_name)
	CustomGameEventManager:RegisterListener(event_name, function(_, kv)
		self[function_name](self, kv)
	end)
end

function guilds:init()
	-- Old event names removed: no corresponding methods (get_game_guilds, create_game_guilds, add_member, etc.)
	self:RegisterHudListener("Guild:RequestConfigs", "RequestConfigs")

	self:RegisterHudListener("Guild:Init", "Init")

	-- self:RegisterHudListener("Guild:OpenMenu", "OpenMenu")

	self:RegisterHudListener("Guild:RequestGuilds", "RequestGuilds")

	self:RegisterHudListener("Guild:CreateGuild", "CreateGuild")

	self:RegisterHudListener("Guild:RequestMessages", "RequestMessages")
	self:RegisterHudListener("Guild:SendMessage", "SendMessage")
	self:RegisterHudListener("Guild:DeleteMessage", "DeleteMessage")

	self:RegisterHudListener("Guild:RequestJoinRequests", "RequestJoinRequests")
	self:RegisterHudListener("Guild:SendJoinRequest", "SendJoinRequest")
	self:RegisterHudListener("Guild:ManageJoinRequest", "ManageJoinRequest")

	self:RegisterHudListener("Guild:EditSettings", "EditSettings")
	self:RegisterHudListener("Guild:EditRoles", "EditRoles")

	self:RegisterHudListener("Guild:RequestAuditLogs", "RequestAuditLogs")

	self:RegisterHudListener("Guild:LinkDiscord", "LinkDiscord")

	self:RegisterHudListener("Guild:ChangeMemberRole", "ChangeMemberRole")
	self:RegisterHudListener("Guild:KickMember", "KickMember")

	self:RegisterHudListener("Guild:UpgradeTalent", "UpgradeTalent")

	self:RegisterHudListener("Guild:QuestDonate", "QuestDonate")

	self:RegisterHudListener("Guild:BuyService", "BuyService")
	self:RegisterHudListener("Guild:ShopDonate", "ShopDonate")

	self:RegisterHudListener("Guild:BuyEventTicket", "BuyEventTicket")
	self:RegisterHudListener("Guild:UseEventTicket", "UseEventTicket")

	self:RegisterHudListener("Guild:Leave", "Leave")

	self:RegisterHudListener("Guild:RequestPlayersRenderGuildData", "RequestPlayersRenderGuildData")
end

function guilds:InitPlayerGuild(pid)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "Guild:RequestInit", {})
end

function guilds:PrepareArrWithPlayer(t)
	return {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
	}
end

function guilds:ResolveGuildData(rawGuildData)
	local guildData = {
		id = rawGuildData.id,
		name = rawGuildData.name,
		showGuildInfo = false,
		showTitle = false,
	}

	local talentsData = {}
	for _, talentData in pairs(rawGuildData.talents) do
		talentsData[talentData.id] = talentData.level
	end

	guildData.talents = talentsData

	for _, serviceData in pairs(rawGuildData.services) do
		if serviceData.id == "visual_guild_info" then
			guildData.showGuildInfo = serviceData.purchases_count > 0
		elseif serviceData.id == "visual_guild_title" then
			guildData.showTitle = serviceData.purchases_count > 0
		end
	end

	return guildData
end

function guilds:UpdateHeroGuildDataByPatch(hero, guildPatch)
	local guildData = hero.guildData
	if not guildData then
		return
	end

	guildData.id = guildPatch.id

	local sendRenderUpdate = false

	if guildPatch.name then
		guildData.name = guildPatch.name
		sendRenderUpdate = true
	end

	if guildPatch.talents then
		for talentId, talentData in pairs(guildPatch.talents) do
			guildData.talents[talentId] = talentData.level
		end
		guilds:UpdateModifier(hero)
	end

	if guildPatch.services then
		for serviceId, serviceData in pairs(guildPatch.services) do
			if serviceId == "visual_guild_info" then
				guildData.showGuildInfo = serviceData.purchases_count > 0
				sendRenderUpdate = true
			elseif serviceId == "visual_guild_title" then
				guildData.showTitle = serviceData.purchases_count > 0
				sendRenderUpdate = true
			end
		end
		guilds:UpdateModifier(hero)
	end

	return sendRenderUpdate
end

function guilds:UseGuildResponseBody(t, body, sentBackData)
	local patch = body.patch
	if patch then
		if patch.guild then
			local guildId = patch.guild.id

			for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				if PlayerResource:IsValidPlayer(playerId) then
					local hero = PlayerResource:GetSelectedHeroEntity(playerId)
					if hero and hero.guildData and hero.guildData.id == guildId then
						CustomGameEventManager:Send_ServerToPlayer(
							PlayerResource:GetPlayer(playerId),
							"Guild:Patch",
							patch
						)

						if patch.guild.delete then
							hero.hasGuild = false
							hero.guildData = nil

							local shopData = Shop.pShop[playerId]
							if shopData then
								shopData.guild_id = nil
							end

							guilds:UpdateModifier(hero)
						else
							if guilds:UpdateHeroGuildDataByPatch(hero, patch.guild) then
								guilds:RequestPlayersRenderGuildData({ PlayerID = playerId })
							end

							local membersPatch = patch.guild.members
							if membersPatch then
								local memberPatch = membersPatch[tostring(PlayerResource:GetSteamID(playerId))]
								if memberPatch and memberPatch.delete then
									hero.hasGuild = false
									hero.guildData = nil

									local shopData = Shop.pShop[playerId]
									if shopData then
										shopData.guild_id = nil
									end

									guilds:UpdateModifier(hero)
									guilds:RequestPlayersRenderGuildData({ PlayerID = playerId })
								end
							end
						end
					end
				end
			end
		end
		-- патч содержит только список гильдий, поэтому нет смысла обновлять модификатор гильдии
		if patch.guilds then
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "Guild:Patch", patch)
		end
	end
	-- mass_patch приходит только от квестов, поэтому нет смысла обновлять модификатор гильдии
	local massPatch = body.mass_patch
	if massPatch then
		for guildId, guildPatch in pairs(massPatch) do
			for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				if PlayerResource:IsValidPlayer(i) then
					local hero = PlayerResource:GetSelectedHeroEntity(i)
					if hero and hero.guildData and tostring(hero.guildData.id) == guildId then
						CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(i), "Guild:Patch", {
							guild = guildPatch,
						})
					end
				end
			end
		end
	end
	local initData = body.init_data
	if initData then
		local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)

		if initData.guild then
			if sentBackData then
				for k, v in pairs(sentBackData) do
					initData[k] = v
				end
			end

			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(t.PlayerID),
				"Guild:PopulateGuild",
				initData
			)

			local guildData = guilds:ResolveGuildData(initData.guild)

			if hero then
				hero.hasGuild = true
				hero.guildData = guildData

				guilds:RequestPlayersRenderGuildData({ PlayerID = t.PlayerID })
			end

			local shopData = Shop.pShop[t.PlayerID]
			if shopData then
				shopData.guild_id = guildData.id
			end
		else
			local data = {}

			if sentBackData then
				for k, v in pairs(sentBackData) do
					data[k] = v
				end
			end
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(t.PlayerID),
				"Guild:PopulateGuild",
				data
			)

			if hero then
				hero.hasGuild = false
				hero.guildData = nil
			end

			local shopData = Shop.pShop[t.PlayerID]
			if shopData then
				shopData.guild_id = nil
			end
		end

		if hero then
			guilds:UpdateModifier(t.PlayerID)
		end
	end
end

guilds.guildExpBoosterValue = 0

function guilds:RequestConfigs(t)
	local arr = guilds:PrepareArrWithPlayer(t)

	local req = CreateHTTPRequestScriptVM("GET", _G.host .. "/api_guilds_get_guild_configs/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local body = json.decode(res.Body)

			if not guilds.configs or IsInToolsMode() then
				guilds.guildExpBoosterValue = max(0, body.guild_configs.guild_config.guild_exp_booster_value) / 100
				guilds.configs = {}

				local talentsConfig = {}
				for _, talentConfigData in pairs(body.guild_configs.talents_config) do
					local talentConfig = {}

					talentConfig.id = talentConfigData.id

					talentConfig.isGuildPower = not not talentConfigData.is_guild_power

					if not talentConfig.isGuildPower then
						talentConfig.levels = {}

						for levelString, levelData in pairs(talentConfigData.levels) do
							talentConfig.levels[tonumber(levelString)] = levelData.value
						end
					end

					talentsConfig[talentConfig.id] = talentConfig
				end

				guilds.configs.talentsConfig = talentsConfig
			end

			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(t.PlayerID),
				"Guild:RequestConfigs",
				body.guild_configs
			)
		end
	end)
end

function guilds:GetGuildPowerValue(level)
	return level * 0.05
end

function guilds:GetConfigTalentValueByLevel(talentId, level)
	local talentConfig = guilds.configs.talentsConfig[talentId]
	if talentConfig.isGuildPower then
		return guilds:GetGuildPowerValue(level)
	end

	return talentConfig.levels[level] or 0
end

function guilds:Init(t)
	local arr = guilds:PrepareArrWithPlayer(t)

	local req = CreateHTTPRequestScriptVM("GET", _G.host .. "/api_guilds_game_init_guild/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body), { openGuildMenu = t.isUpdate == 1 })
		end
	end)
end

function guilds:RequestGuilds(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.from_guilds_list = t.fromGuildsList == 1

	local req = CreateHTTPRequestScriptVM("GET", _G.host .. "/api_guilds_get_guilds_list/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body), { openGuildMenu = arr.from_guilds_list })
		end
	end)
end

function guilds:CreateGuild(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.avatar_num = t.avatarNum
	arr.name = t.name
	arr.locale = t.locale

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_create_guild/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body), { openGuildMenu = true })
		end
	end)
end

function guilds:RequestMessages(t)
	local arr = guilds:PrepareArrWithPlayer(t)

	local req = CreateHTTPRequestScriptVM("GET", _G.host .. "/api_guilds_get_chat_messages/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:SendMessage(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.content = t.text

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_send_chat_message/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:DeleteMessage(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.msg_id = t.messageId

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_delete_chat_message/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:SendJoinRequest(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.guild_id = t.guildId

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_send_join_request/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body), { openGuildMenu = true })
		end
	end)
end

function guilds:RequestJoinRequests(t)
	local arr = guilds:PrepareArrWithPlayer(t)

	local req = CreateHTTPRequestScriptVM("GET", _G.host .. "/api_guilds_get_join_requests/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:ManageJoinRequest(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.join_request_id = t.id
	arr.accept = t.accept

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_manage_join_request/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:EditSettings(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.changes = t.changes

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_edit_settings/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:EditRoles(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.changes = t.changes

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_edit_roles/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:RequestAuditLogs(t)
	local arr = guilds:PrepareArrWithPlayer(t)

	local req = CreateHTTPRequestScriptVM("GET", _G.host .. "/api_guilds_get_audit_logs/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:LinkDiscord(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.discord_id = t.discordId

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_send_discord_link_message/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:ChangeMemberRole(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.sid64 = t.targetId
	arr.role_id = t.roleId

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_change_member_role/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:KickMember(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.sid64 = t.targetId

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_kick_member/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:UpgradeTalent(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.talent_key = t.talentId
	arr.currency = t.currency

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_upgrade_talent/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:QuestDonate(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.quest_id = t.questId
	arr.currency = t.currency
	arr.amount = t.amount

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_quest_donate/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		else
			local msg = "Ошибка"
			if res and res.Body and #res.Body > 0 then
				local ok, decoded = pcall(function()
					return json.decode(res.Body)
				end)
				if ok and decoded and decoded.error then
					msg = tostring(decoded.error)
				end
			end
			local player = PlayerResource:GetPlayer(t.PlayerID)
			if player then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"mountain_dota_hud_show_hud_error",
					{ message = msg }
				)
			end
		end
	end)
end

function guilds:BuyService(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.service_key = t.serviceId
	arr.currency = t.currency
	arr.locale = t.locale

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_buy_service/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

function guilds:ShopDonate(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.amount = t.amount

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_shop_donate_crystals/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		else
			local msg = "Ошибка"
			if res and res.Body and #res.Body > 0 then
				local ok, decoded = pcall(function()
					return json.decode(res.Body)
				end)
				if ok and decoded and decoded.error then
					msg = tostring(decoded.error)
				end
			end
			local player = PlayerResource:GetPlayer(t.PlayerID)
			if player then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"mountain_dota_hud_show_hud_error",
					{ message = msg }
				)
			end
		end
	end)
end

function guilds:BuyEventTicket(t)
	local arr = guilds:PrepareArrWithPlayer(t)
	arr.ticket_id = t.ticketId
	arr.currency = t.currency
	arr.amount = 1

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_buy_event_tickets/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))
		end
	end)
end

local useEventTicketCreateArrFuncMap = {
	["guild_farm"] = function(t)
		if not guild_events:CanStartTeamEvent(t.PlayerID) then
			return
		end

		local arr = {}
		arr.ticket_id = t.ticketId

		local initiator_sid64 = tostring(PlayerResource:GetSteamID(t.PlayerID))

		arr.player_sid64s = {}

		for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if PlayerResource:IsValidPlayer(playerId) and PlayerResource:HasSelectedHero(playerId) then
				table.insert(arr.player_sid64s, tostring(PlayerResource:GetSteamID(playerId)))
			end
		end

		table.sort(arr.player_sid64s, function(a, b)
			if a == initiator_sid64 then
				return true
			elseif b == initiator_sid64 then
				return false
			else
				return false
			end
		end)

		return arr
	end,
	["solo_farm"] = function(t)
		if not guild_events:CanStartSoloEvent(t.PlayerID) then
			return
		end

		local arr = {}
		arr.ticket_id = t.ticketId
		arr.player_sid64s = { tostring(PlayerResource:GetSteamID(t.PlayerID)) }

		return arr
	end,
}

local useEventTicketSuccessCallbackMap = {
	["guild_farm"] = function()
		guild_events:StartTeamEvent()
	end,
	["solo_farm"] = function(playerId)
		guild_events:StartSoloEvent(playerId)
	end,
}

function guilds:UseEventTicket(t)
	local ticketId = t.ticketId

	local createArr = useEventTicketCreateArrFuncMap[ticketId]
	if not createArr then
		return
	end

	local arr = createArr(t)
	if not arr then
		return
	end

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_use_event_tickets/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))

			local callback = useEventTicketSuccessCallbackMap[ticketId]
			if callback then
				callback(t.PlayerID)
			end
		elseif res.StatusCode == 403 and res.Body ~= nil then
			local body = json.decode(res.Body)
			if body and body.error_loc_key then
				rules:DisplayError(t.PlayerID, body.error_loc_key)
			end
		end
	end)
end

function guilds:Leave(t)
	local arr = guilds:PrepareArrWithPlayer(t)

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_leave/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))

			local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)
			hero.hasGuild = false
			hero.guildData = nil

			local shopData = Shop.pShop[t.PlayerID]
			if shopData then
				shopData.guild_id = nil
			end

			guilds:UpdateModifier(hero)
		end
	end)
end

function guilds:RequestPlayerRenderGuildData(requesterPlayerId, targetPlayerId)
	if not PlayerResource:IsValidPlayer(targetPlayerId) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(targetPlayerId)
	if not hero then
		return
	end

	if not hero.hasGuild then
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(requesterPlayerId),
			"Guild:UpdatePlayerRenderGuildData",
			{
				playerId = targetPlayerId,
			}
		)
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(requesterPlayerId),
		"Guild:UpdatePlayerRenderGuildData",
		{
			playerId = targetPlayerId,
			sid64 = tostring(PlayerResource:GetSteamID(targetPlayerId)),
			name = hero.guildData.name,
			showGuildInfo = hero.guildData.showGuildInfo,
			showTitle = hero.guildData.showTitle,
		}
	)
end

function guilds:RequestPlayersRenderGuildData(t)
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		guilds:RequestPlayerRenderGuildData(t.PlayerID, playerId)
	end
end

function guilds:AddGuildExp(pid, exp, showOnScreen)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end

	local arr = {
		sid = tostring(PlayerResource:GetSteamID(pid)),
		exp = exp,
	}

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_add_exp/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			guilds:UseGuildResponseBody(t, json.decode(res.Body))

			if showOnScreen then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(pid),
					"show_reward_notifications",
					{ guild_exp = exp }
				)
			end
		end
	end)
end

function guilds:UpdateModifier(heroOrPlayerId)
	local hero
	if type(heroOrPlayerId) == "number" then
		hero = PlayerResource:GetSelectedHeroEntity(heroOrPlayerId)
	else
		hero = heroOrPlayerId
	end

	if not hero.hasGuild or not hero.guildData then
		if hero:HasModifier("modifier_guild") then
			hero:RemoveModifierByName("modifier_guild")
		end
		return
	end

	if hero:HasModifier("modifier_guild") then
		hero:RemoveModifierByName("modifier_guild")
		hero:AddNewModifier(hero, nil, "modifier_guild", {})
	else
		hero:AddNewModifier(hero, nil, "modifier_guild", {})
	end
end

function guilds:SendSpeedrunRecord()
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end

	local arr = {
		difficulty = Game_Difficulty,
		game_time_seconds = GameRules:GetDOTATime(false, false),
	}

	local players = {}

	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(playerId) then
			local hero = PlayerResource:GetSelectedHeroEntity(playerId)
			if hero then
				local player = {
					sid64 = tostring(PlayerResource:GetSteamID(playerId)),
					hero_name = hero:GetUnitName(),
				}

				local items = {}

				for slot = 0, 5 do
					local item = hero:GetItemInSlot(slot)
					if item then
						table.insert(items, item:GetAbilityName())
					end
				end
				player.items = items

				table.insert(players, player)
			end
		end
	end

	arr.players = players

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_guilds_register_speedrun_game/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function() end)
end

guilds:init()