--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Tips = Tips or {}


function Tips:Init()
	Tips.used_total = {}
	Tips.used_this_game = {}
	Tips.last_tip_time = {}

	EventStream:Listen("Tips:tip", Tips.Tip, Tips)
	EventStream:Listen("Tips:get_data", Tips.GetData, Tips)

	EventDriver:Listen("WebInventory:update", function(event)
		Tips:UpdateClient(event.player_id)
	end)
end


--- Sets amount of tips player used today across all games
--- (usually set from before-match, as server keeps this counter)
---@param player_id number
---@param used_total number
function Tips:SetTipsData(player_id, used_total)
	Tips.used_total[player_id] = used_total
end


--- Tips targeted player on behalf of requestor.
--- Performs request to WebApi
---@param event table
function Tips:Tip(event)
	local source_player_id = event.PlayerID
	if not IsValidPlayerID(source_player_id) then return end

	local target_player_id = event.target_player_id
	if not IsValidPlayerID(target_player_id) then return end

	if source_player_id == target_player_id then return end

	local source_steam_id = tostring(PlayerResource:GetSteamID(source_player_id))
	local target_steam_id = tostring(PlayerResource:GetSteamID(target_player_id))

	local daily_limit = Tips:GetMaxDailyTips(source_player_id)
	local used_total = Tips.used_total[source_player_id]

	if used_total and used_total >= daily_limit then
		DisplayError(source_player_id, "#dota_hud_error_used_all_tips_for_today")
		return
	end

	local used_this_game = Tips.used_this_game[source_player_id]
	if used_this_game and used_this_game >= TIPS_PER_GAME_MAX then
		DisplayError(source_player_id, "#dota_hud_error_used_all_tips_for_this_game")
		return
	end

	local last_tip_time = Tips.last_tip_time[source_player_id]
	if last_tip_time and (GameRules:GetGameTime() - last_tip_time) < TIPS_COOLDOWN then
		DisplayError(source_player_id, "#dota_hud_error_tip_is_on_cooldown")
		return
	end

	if not GameMode:IsDeveloper(source_player_id) then
		Tips.used_this_game[source_player_id] = (Tips.used_this_game[source_player_id] or 0) + 1
		Tips.used_total[source_player_id] = (Tips.used_total[source_player_id] or 0) + 1

		Tips.last_tip_time[source_player_id] = GameRules:GetGameTime()
	end


	Tips:UpdateClient(source_player_id)

	WebApi:Send(
		"api/lua/match/tip",
		{
			source_steam_id = source_steam_id,
			source_daily_tip_limit = daily_limit,
			target_steam_id = target_steam_id,
			target_currency_amount = TIPS_CURRENCY_PER_TIP,
		},
		function(response)
			WebPlayer:AddCurrency(target_player_id, TIPS_CURRENCY_PER_TIP)

			Toasts:NewForAll("player_tip", {
				source_player_id = source_player_id,
				target_player_id = target_player_id,
				currency = TIPS_CURRENCY_PER_TIP
			})
		end,
		function(response)
			print("[Tips] failed to tip a player!", source_player_id, " => ", target_player_id)
		end
	)
end

--- Returns amount of tips player can use per day (across all games)
---@param player_id number
---@return number
function Tips:GetMaxDailyTips(player_id)
	if GameMode:IsDeveloper(player_id) then return 999999 end

	local subscription_tier = WebPlayer:GetSubscriptionTier(player_id)

	return TIPS_FROM_SUBSCRIPTION_TIER[subscription_tier] or 0
end

--- Sends player tips data to requestor client (max total, max this game, used total, used this game, cooldown)
---@param event table
function Tips:GetData(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	Tips:UpdateClient(player_id)
end


--- Updates client data regarding tips
--- Sends max total, max this game, used total, used this game, cooldown
---@param player_id number
function Tips:UpdateClient(player_id)
	if not IsValidPlayerID(player_id) then return end
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "Tips:update", {
		max_total = Tips:GetMaxDailyTips(player_id),
		used_total = Tips.used_total[player_id] or 0,
		max_this_game = TIPS_PER_GAME_MAX,
		used_this_game = Tips.used_this_game[player_id] or 0,
		cooldown = Tips.last_tip_time[player_id] or -10000,
	})
end


Tips:Init()