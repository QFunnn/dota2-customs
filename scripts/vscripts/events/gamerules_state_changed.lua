--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function Events:OnGameRulesStateChange(event)
	local new_state = GameRules:State_Get()

	EventDriver:Dispatch("Events:state_changed", {
		state = new_state,
	})

	--if new_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
	--	Shuffle:KickRemainingPlayers()
	--end

	if new_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
		GameLoop:SetTeamColors()

		Timers:CreateTimer(0.1, function()
			local ban_state_end = GameRules:GetGameTime() + (GameRules:IsInBanPhase() and 15 or 0)
			CustomNetTables:SetTableValue("game_state", "ban_state_endtime", { time = ban_state_end })
		end)
	end
end