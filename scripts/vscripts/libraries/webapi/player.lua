--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebPlayer = WebPlayer or {}
-- status: in progress

function WebPlayer:Init()
	EventStream:Listen("WebPlayer:get_data", WebPlayer.GetData, WebPlayer)

	WebPlayer.players_data = {}
end


function WebPlayer:SetPlayerData(player_id, player_data)
	WebPlayer:SetSubscriptionStatus(player_id, player_data.subscription)
	WebSettings:Validate(player_id, player_data.settings)
	WebSettings:IncludeDefaults(player_data.settings or {})

	WebPlayer.players_data[player_id] = {
		currency = player_data.currency,
		subscription = player_data.subscription,
		stats = player_data.stats,
		battle_pass = player_data.battle_pass,
		settings = player_data.settings,
		punishment_level = player_data.punishment_level or 0,
	}
end


function WebPlayer:UpdatePlayersStats()
	local stats = {}

	for player_id, data in pairs(WebPlayer.players_data or {}) do
		stats[player_id] = data.stats
		stats[player_id].streak_hidden = WebSettings:GetSettingValue(player_id, "hide_streaks", 0)
	end

	CustomNetTables:SetTableValue("game_state", "player_stats", stats)
end


--- Returns player current subscription tier or 0 (if player is not subscribed)
---@param player_id number
---@return number
function WebPlayer:GetSubscriptionTier(player_id)
	return WebPlayer:GetSubscriptionData(player_id).tier or 0
end


--- Returns player subscription data
--- Data contains tier, end_date and metadata
---@param player_id number
---@return table
function WebPlayer:GetSubscriptionData(player_id)
	return (WebPlayer.players_data[player_id] or {}).subscription or {}
end


--- Sets player subscription status
--- `subscription` should contain at least tier and end_date
---@param player_id number
---@param subscription table
function WebPlayer:SetSubscriptionStatus(player_id, subscription)
	if not WebPlayer.players_data[player_id] then WebPlayer.players_data[player_id] = {} end
	WebPlayer.players_data[player_id].subscription = subscription
end


--- Get current subscription type (if any)
--- Possible values: `payment`, `automatic`
---@param player_id number
---@return nil | "payment" | "automatic"
function WebPlayer:GetSubscriptionType(player_id)
	return WebPlayer.players_data[player_id].subscription.type
end


--- Get current subscription source (if any)
--- Source is only defined for `automatic` subscriptions
--- Possible values: `xsolla`, `stripe`, `patreon`
---@param player_id number
---@return string
function WebPlayer:GetSubscriptionSource(player_id)
	return WebPlayer.players_data[player_id].subscription.metadata.source
end


--- Returns player current currency (or 0 if none)
---@param player_id number
---@return number
function WebPlayer:GetCurrency(player_id)
	return (WebPlayer.players_data[player_id] or {}).currency or 0
end


--- Sets player current currency to `new_value`
---@param player_id number
---@param new_value number
function WebPlayer:SetCurrency(player_id, new_value)
	if not WebPlayer.players_data[player_id] then WebPlayer.players_data[player_id] = {} end
	WebPlayer.players_data[player_id].currency = new_value
end


--- Adds **local** currency to player
---@param player_id number
---@param value number
function WebPlayer:AddCurrency(player_id, value)
	if not WebPlayer.players_data[player_id] then WebPlayer.players_data[player_id] = {} end
	WebPlayer.players_data[player_id].currency = (WebPlayer.players_data[player_id].currency or 0) + value
end


--- Adds **backend** currency to player
--- WARNING: changes made by this methods are permanent. Invokes request to backend server.
---@param player_id number
---@param value number
function WebPlayer:AddBackendCurrency(player_id, value)
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/match/add_currency",
		{
			steam_id = steam_id,
			amount = value,
		},
		function(response)
			WebPlayer:SetCurrency(player_id, response.currency)
			WebPlayer:UpdateClient(player_id)

			print("[WebPlayer] successfully added backend currency to player", player_id, " | new currency: ", response.currency)
		end,
		function(err)
			print("[WebPlayer] failed to add backend currency", player_id, value)
		end
	)
end


--- Returns rating of player on current map
---@param player_id number
---@return number
function WebPlayer:GetRating(player_id)
	return WebPlayer:GetStats(player_id).rating or DEFAULT_RATING
end


--- Returns stats of player on current map
--- Stats include: `kills`, `deaths`, `assists`, `victories`, `defeats`, `streak_current`, `streak_max`, `last_winner_heroes`, `rating`
---@param player_id number
---@return table
function WebPlayer:GetStats(player_id)
	return (WebPlayer.players_data[player_id] or {}).stats or {}
end


--- Returns player battle pass data
--- Data includes: `current_exp`, `level`, `redeemed_levels`
---@param player_id number
---@return table
function WebPlayer:GetBattlepassData(player_id)
	return (WebPlayer.players_data[player_id] or {}).battle_pass or {}
end


--- Returns punishment level of player (usually set from web page)
---@param player_id number
function WebPlayer:GetPunishmentLevel(player_id)
	return (WebPlayer.players_data[player_id] or {}).punishment_level or 0
end


--- Sets punishment level of player to passed value
--- If `submit_to_backend` is passed and true, then updates said value on backend as well (making it persistant)
---@param player_id number
---@param punishment_level number
---@param punishment_reason string
---@param submit_to_backend boolean
function WebPlayer:SetPunishmentLevel(player_id, punishment_level, punishment_reason, submit_to_backend)
	if not WebPlayer.players_data[player_id] then WebPlayer.players_data[player_id] = {} end
	WebPlayer.players_data[player_id].punishment_level = punishment_level

	WebPlayer:UpdateClient(player_id)

	if submit_to_backend then
		WebApi:Send(
			"api/lua/match/set_punishment_level",
			{
				steam_id = tostring(PlayerResource:GetSteamID(player_id)),
				punishment_level = punishment_level,
				punishment_reason = punishment_reason or "automated punishment from Lua"
			},
			function(data)
				print("[WebPlayer] successfully set punishment level for", player_id, "to", punishment_level)
			end,
			function(err)
				print("[WebPlayer] failed to update punishment level of player", player_id)
			end
		)
	end
end


function WebPlayer:GetData(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	WebPlayer:UpdateClient(player_id)
end


function WebPlayer:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	-- print("[WebPlayer] update client")
	-- DeepPrintTable(WebPlayer.players_data)

	CustomGameEventManager:Send_ServerToPlayer(player, "WebPlayer:update", {
		player_data = WebPlayer.players_data[player_id]
	})
end


-- handy shortcut to perform currency-based operations
-- spends currency on backend, calls callback on success
-- validates and updates internal state by itself
function WebPlayer:UseCurrency(player_id, amount_to_spend, on_spent_callback, on_fail_callback)
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/match/spend_currency",
		{
			steam_id = steam_id,
			currency_value = amount_to_spend
		},
		function(data)
			WebPlayer:SetCurrency(data.currency)
			if on_spent_callback then
				ErrorTracking.Try(on_spent_callback, data)
			end
			WebPlayer:UpdateClient(player_id)
		end,
		function(err)
			print("[WebPlayer] failed to spend currency", player_id, amount_to_spend)
			if on_fail_callback then
				ErrorTracking.Try(on_fail_callback)
			end
		end
	)
end


WebPlayer:Init()