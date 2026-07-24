--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


HostOptions = HostOptions or {}

--- Known host option types
---@type table<string, string>
HOST_OPTION = {
	TOURNAMENT = "tournament_mode",
	BOTS = "fill_with_bots"
}


function HostOptions:Init()
	HostOptions.options = {}
	HostOptions.available_options = {
		[HOST_OPTION.BOTS] = true,
	}
	HostOptions.host = nil

	EventStream:Listen("HostOptions:set_option_state", function(event)
		local player_id = event.PlayerID
		if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

		local player = PlayerResource:GetPlayer(player_id)
		if not IsValidEntity(player) or HostOptions.host ~= player then return end

		HostOptions:SetOptionState(event.name, toboolean(event.state))
	end)

	EventDriver:Listen("Events:state_changed", function(event)
		if event.state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
			HostOptions:UpdateHostPlayer()
		end

		if event.state == DOTA_GAMERULES_STATE_HERO_SELECTION then
			if HostOptions:GetOption(HOST_OPTION.TOURNAMENT) then
				-- delay is needed otherwise it sends to team select chat
				-- state is not yet switched to hero selection on client
				Timers:CreateTimer(1, function()
					GameRules:SendCustomMessage("#tournament_mode_note", HostOptions.host:GetPlayerID(), 1)
				end)
			end

			if HostOptions:GetOption(HOST_OPTION.BOTS) then
				print("filling with bots")
				SendToServerConsole("dota_bot_populate")
			end
		end
	end)
end


function HostOptions:SetOptionState(option_name, state)
	if not HostOptions:IsOptionAvailable(option_name) then
		print("[Host Options] attempted to change state of unavailable host option!\nHINT: use SetOptionAvailable or edit available_options to enable by default")
		return
	end

	HostOptions.options[option_name] = state

	CustomNetTables:SetTableValue("game_options", "host_options", HostOptions.options)
end


function HostOptions:GetOption(option_name)
	return HostOptions.options[option_name] or false
end


function HostOptions:SetOptionAvailable(option_name, state)
	HostOptions.available_options[option_name] = state

	if IsValidEntity(HostOptions.host) then
		CustomGameEventManager:Send_ServerToPlayer(HostOptions.host, "HostOptions:show", {
			available_options = HostOptions.available_options,
		})
	end
end


function HostOptions:IsOptionAvailable(option_name)
	return HostOptions.available_options[option_name] or false
end


function HostOptions:UpdateHostPlayer()
	for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		local player = PlayerResource:GetPlayer(i)
		if player and GameRules:PlayerHasCustomGameHostPrivileges(player) then
			HostOptions.host = player
			CustomGameEventManager:Send_ServerToPlayer(player, "HostOptions:show", {
				available_options = HostOptions.available_options,
			})
		end
	end
end


HostOptions:Init()