--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_respawn_time_handler = class({})

function modifier_respawn_time_handler:IsHidden()
	return true
end
function modifier_respawn_time_handler:IsPurgable()
	return false
end
function modifier_respawn_time_handler:IsPurgeException()
	return false
end
function modifier_respawn_time_handler:RemoveOnDeath()
	return false
end

function modifier_respawn_time_handler:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_RESPAWNTIME_STACKING,
	}
end

function modifier_respawn_time_handler:GetModifierStackingRespawnTime()
	if IsClient() then
		return
	end

	local parent = self:GetParent()
	local time = 0

	local rax_bonus = GameLoop.barracks_bonus[parent:GetTeam()]
		- GameLoop.barracks_bonus[parent:GetOpposingTeamNumber()]
	if rax_bonus > 0 then
		time = time + (rax_bonus / RESPAWN_TIME_SCALE)
	end

	local hero_team = GetActivePlayerCountForTeam(parent:GetTeamNumber())
	local opposing_team = GetActivePlayerCountForTeam(parent:GetOpposingTeamNumber())
	local difference = hero_team - opposing_team

	-- print("respawn time calc:", rax_bonus, hero_team, opposing_team, difference)

	if difference < 0 then
		time = time + difference * RESPAWN_REDUCTION_PER_MISSING_HERO
	end

	return time
end