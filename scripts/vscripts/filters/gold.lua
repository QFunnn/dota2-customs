--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function Filters:ModifyGoldFilter(event)
	local player_id = event.player_id_const
	local gold = event.gold
	local reason = event.reason_const
	-- local hero = (player_id and PlayerResource:GetSelectedHeroEntity(player_id)) or nil

	local scaled_gold = gold * GameLoop.current_gold_scale_factor

	if PlayerResource:GetTeam(player_id) == Shuffle.weak_team_id then
		scaled_gold = scaled_gold * Shuffle.gold_multiplier
		-- print("gold filter amped gold to", scaled_gold, Shuffle.gold_multiplier)
	end

	if reason == DOTA_ModifyGold_CreepKill then
		scaled_gold = scaled_gold * GOLD_MULTIPLIER_FOR_LANE_CREEPS
	end

	if reason ~= DOTA_ModifyGold_AbandonedRedistribute then
		event.gold = scaled_gold
	end

	local source = EntIndexToHScript(event.source_entindex_const)
	if source and source.reward_scale then
		event.gold = event.gold * source.reward_scale
	end

	--if player_id and GameLoop.do_stagger_gold then
	--	GameLoop:AddDelayedGold(player_id, event.gold)
	--	return false
	--end

	return true
end