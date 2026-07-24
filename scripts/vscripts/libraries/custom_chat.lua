--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[
	Script for send custom messages with custom data in default dota chat.

	CustomChat:MessageToAll(sender_id, main_token, tokens, abilities, extra_data)
	CustomChat:MessageToTeam(sender_id, team_number, main_token, tokens, abilities, extra_data)

	@param sender_id number The ID of the sender. Can be -1, message will be send without player-owner.
	@param main_token string The main token for the message.
	@param tokens table Optional. A table containing various optional parameters for customizing the message.
		- not_localize table (optional) An array for storing non-localized information.
		- players table (optional) An array for storing player-specific information which will be get on client-side.
		- hard_replace table (optional) An array for hard replacements without localization.
		- Additional parameters: This table can also contain other key-value pairs which will be localized on client-side.
	@param abilities table Optional. Abilities related to the message. Array for render abilities' icons after at the end of the message
	@param extra_data table Specific extra data. Can contain any info, but should be implemted separately on client-side.
		- remainin_time talbe (k=v) for alt-ping buffs time remaning
		- mastery string for mastery icon

	@param team_number number for team message

	@usage
	local sender_id = 0
	local main_token = "#custom_chat_ability_ping"
	local abilities = { "pudge_meat_hook" }
	local tokens = {
		not_localize = {
			ability_cooldown_var = 12
		},
		players = {
			[0] = {
				player_color = C_CHAT_ENUM.PLAYER_COLOR,
				player_name = C_CHAT_ENUM.PLAYER_NAME
			}
		},
		hard_replace = {
			["%s2"] = "{s:dialog_var_gold_count}"
		},
		extra_data = {
			remaining_time = {
				key = "%s4",
				value = 12,
			},
			mastery = "tenacity"
		},
		loc_var_1 = "loc_token_1",
		loc_var_2 = "loc_token_2",
		loc_var_3 = "loc_token_3",
	}
	local team_id = 2

	CustomChat:MessageToAll(sender_id, main_token, tokens)
	CustomChat:MessageToTeam(sender_id, team_id, main_token, tokens)
]]--

if CustomChat == nil then CustomChat = class({}) end

ALT_PING_PENALTY_TIME = 2
C_CHAT_ENUM = {
	PLAYER_NAME = 0,
	PLAYER_COLOR = 1,
	HERO_NAME = 2,
}
C_CHAT_PRESETS = {
	---@param suffix string|number optional
	PLAYER = function (suffix)
		return {
			["player_color" .. (suffix and "_" .. suffix or "")] = C_CHAT_ENUM.PLAYER_COLOR,
			["player_name" .. (suffix and "_" .. suffix or "")] = C_CHAT_ENUM.PLAYER_NAME,
		}
	end,
	PLAYER_HERO = {
		player_color = C_CHAT_ENUM.PLAYER_COLOR,
		hero_name = C_CHAT_ENUM.HERO_NAME,
	},
}

function CustomChat:Init()
	self.last_ping_time = {}
	self.hero_ranks = {}

	EventStream:Listen("custom_chat:update_client_request", self.UpdateClient, self)
	EventStream:Listen("custom_chat:get_hero_ranks", self.UpdateHeroRanksResponse, self)
	EventStream:Listen("custom_chat:update_hero_rank", self.UpdateHeroRanks, self)
	EventStream:Listen("custom_chat:update_guild_tag_colors", self.UpdateGuildColors, self)
end

function CustomChat:UpdateGuildColors(event)
	if self.guild_tag_colors then return end

	self.guild_tag_colors = event.colors
end

function CustomChat:UpdateHeroRanksResponse(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "custom_chat:update_hero_ranks", self.hero_ranks)
end


function CustomChat:UpdateHeroRanks(event)
	local player_id = event.PlayerID
	if not player_id then return end

	self.hero_ranks[player_id] = event.hero_rank

	CustomGameEventManager:Send_ServerToAllClients("custom_chat:update_hero_ranks", self.hero_ranks)
end

function CustomChat:CanPlayerSendAltPing(player_id)
	if not player_id then return false end

	local current_time = Time()
	local is_can = (self.last_ping_time[player_id] or 0) + ALT_PING_PENALTY_TIME < current_time

	if is_can then
		self.last_ping_time[player_id] = current_time
	end

	return is_can
end

function CustomChat:UpdateClient(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "custom_chat:update_client", {
		hero_ranks = self.hero_ranks,
		guild_tag_colors = self.guild_tag_colors or {}
	})
end

function CustomChat:MessageToPlayer(sender_id, target_id, main_token, tokens, abilities, extra_data)
	if not sender_id or not target_id then return end

	local target = PlayerResource:GetPlayer(target_id)
	if not target then return end

	local sender_team = PlayerResource:GetTeam(sender_id)
	local target_team = PlayerResource:GetTeam(target_id)

	CustomGameEventManager:Send_ServerToPlayer(target, "custom_chat:message", {
		sender_id = sender_id,
		main_token = main_token,
		tokens = tokens,
		abilities = abilities,
		is_team = sender_team == target_team,
		extra_data = extra_data,
	})
end

function CustomChat:MessageToAll(sender_id, main_token, tokens, abilities, extra_data)
	if not sender_id then return end

	CustomGameEventManager:Send_ServerToAllClients("custom_chat:message", {
		sender_id = sender_id,
		main_token = main_token,
		tokens = tokens,
		abilities = abilities,
		extra_data = extra_data,
	})
end

function CustomChat:MessageToTeam(sender_id, team_number, main_token, tokens, abilities, extra_data)
	if not sender_id then return end

	CustomGameEventManager:Send_ServerToTeam(team_number, "custom_chat:message", {
		sender_id = sender_id,
		main_token = main_token,
		tokens = tokens,
		abilities = abilities,
		is_team = true,
		extra_data = extra_data,
	})
end