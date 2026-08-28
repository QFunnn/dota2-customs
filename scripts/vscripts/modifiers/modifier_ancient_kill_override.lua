--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_ancient_kill_override = class({})

function modifier_ancient_kill_override:IsHidden()
	return false
end
function modifier_ancient_kill_override:IsPurgable()
	return false
end
function modifier_ancient_kill_override:DestroyOnExpire()
	return true
end
function modifier_ancient_kill_override:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

if not IsServer() then
	return
end

function modifier_ancient_kill_override:OnCreated()
	self.parent = self:GetParent()
end

function modifier_ancient_kill_override:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_ancient_kill_override:GetMinHealth(params)
	-- if before-match failed, after-match shouldn't submit anyway
	if not WebApi.__before_match_loaded then
		return
	end
	if WebApi.__after_match_failed then
		return
	end

	if not self.parent or self.parent:IsNull() then
		return
	end

	if self.parent:GetHealth() > 5 or GameLoop.game_over then
		return 5
	end

	GameLoop.game_over = true
	local winner_team = self.parent:GetOpposingTeamNumber()

	Timers:CreateTimer({
		useGameTime = false,
		endTime = 6,
		callback = function()
			DebugMessage("[WebApi] forcing game end on timeout - has after-match failed entirely?")
			GameRules:SetGameWinner(winner_team)
			if self and not self:IsNull() then
				self:Destroy()
			end
		end,
	})

	Timers:CreateTimer({
		useGameTime = false,
		endTime = 4,
		callback = function()
			if next(ErrorTracking.collected_errors) ~= nil then
				WebApi:Send("api/lua/match/script-errors", {
					errors = ErrorTracking.collected_errors,
				})
				ErrorTracking.collected_errors = {}
			end
		end,
	})

	self:SetDuration(5, true)

	GameRules:GetGameModeEntity():SetPauseEnabled(false)
	if GameRules:IsGamePaused() then
		PauseGame(false)
	end

	CustomChat:MessageToAll(-1, "game_ended_process_warning", {
		team_name = winner_team == DOTA_TEAM_BADGUYS and "team_dire_colored" or "team_radiant_colored",
	})

	ErrorTracking.TryImmediate(function()
		DebugMessage("[WebApi] finalizing stats from ancient death call")
		EndGameStats:FinalizeStats(winner_team)
		DebugMessage("[WebApi] finalize done")
	end)

	ErrorTracking.TryImmediate(function()
		DebugMessage("[WebApi] submitting after-match")
		if not EndGameStats:IsSubmissionAllowed() then
			DebugMessage("[WebApi] submission is prevented by errors, forcing game end as-is")
			GameRules:SetGameWinner(winner_team)
		else
			DebugMessage("[WebApi] submission allowed, starting after-match submission process")
			WebApi:AfterMatch(winner_team)
		end
		DebugMessage("[WebApi] after-match done!")
	end)

	-- safeguards in case something goes very wrong
	-- if this delay is reached, it means something in after-match retry loop broke, and we may benefit from actually knowing what
end

function modifier_ancient_kill_override:GetDisableHealing()
	return GameMode.game_ended and 1 or 0
end