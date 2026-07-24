--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebFeedback = WebFeedback or {}
WebFeedback.cooldown = 30
-- status: complete, untested

function WebFeedback:Init()
	EventStream:Listen("WebFeedback:send_feedback", WebFeedback.Send, WebFeedback)
	EventStream:Listen("WebFeedback:get_cooldown", WebFeedback.GetCooldown, WebFeedback)

	WebFeedback.last_used_time = {}
end


function WebFeedback:Send(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	-- feedback cooldown check
	local used_time = WebFeedback.last_used_time[player_id]

	if used_time and (GameRules:GetGameTime() - used_time) < WebFeedback.cooldown then return end

	WebFeedback.last_used_time[player_id] = GameRules:GetGameTime()

	-- feedback cooldown reset
	Timers:CreateTimer(WebFeedback.cooldown, function()
		local player = PlayerResource:GetPlayer(player_id)
		if not IsValidEntity(player) then return end

		CustomGameEventManager:Send_ServerToPlayer(player, "WebFeedback:update_cooldown", {
			cooldown = 0
		})
	end)

	WebApi:Send(
		"api/lua/match/feedback",
		{
			steam_id = steam_id,
			content = event.text,
			subscription_tier = WebPlayer:GetSubscriptionTier(player_id),
		},
		function(data)
			print("[WebFeedback] sent successfully")
		end,
		function(error)
			print("[WebFeedback] error:")
			DeepPrintTable(error)
		end
	)
end


function WebFeedback:GetCooldown(event)
	print("[WebFeedback] GetCooldown")
	DeepPrintTable(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebFeedback:update_cooldown", {
		cooldown = WebFeedback.last_used_time[player_id] or 0
	})
end


WebFeedback:Init()