--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class Pvp
---@field pair DOTATeam_t[]
---@field ended boolean
---@field homeTeamId integer?
---@field homeCenter Vector?
if Pvp == nil then
	Pvp = class({})
end

function Pvp:constructor()
	self.pair = {}
	self.ended = true
	self.homeTeamId = nil
	self.homeCenter = nil
end

---@return boolean
function Pvp:IsEnded()
	return self.ended
end

function Pvp:End()
	self.ended = true
end

---Начинает дуэль между двумя командами (пара активна, дуэль не завершена).
---@param teamId1 DOTATeam_t
---@param teamId2 DOTATeam_t
function Pvp:Start(teamId1, teamId2)
	self.pair = { teamId1, teamId2 }
	self.ended = false
end

---@param homeTeamId integer
---@param homeCenter Vector
function Pvp:SetHome(homeTeamId, homeCenter)
	self.homeTeamId = homeTeamId
	self.homeCenter = homeCenter
end

---@return DOTATeam_t[]
function Pvp:GetPair()
	return self.pair
end

function Pvp:ResetPair()
	self.pair = {}
end

---@return boolean
function Pvp:HasActivePair()
	return (not self.ended) and self.pair[1] ~= nil and self.pair[2] ~= nil
end

---@return integer?
function Pvp:GetHomeTeamId()
	return self.homeTeamId
end

---@return Vector?
function Pvp:GetHomeCenter()
	return self.homeCenter
end

---@param teamId DOTATeam_t
---@return boolean
function Pvp:IsTeamAllDead(teamId)
	for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
		local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
		local hero = PlayerResource:GetSelectedHeroEntity(playerId)
		if hero and (hero:IsAlive() or hero:IsReincarnating()) then
			return false
		end
	end
	return true
end

---Чистое решение исхода дуэли по факту смерти команды (без сайд-эффектов).
---В SOLO проигрывает добитая команда; в командных режимах — когда вся команда мертва.
---@param killedTeamId DOTATeam_t
---@param isSolo boolean
---@return { winner: DOTATeam_t, loser: DOTATeam_t }?
function Pvp:ResolveDeath(killedTeamId, isSolo)
	local pair = self.pair
	if not (pair and pair[1] and pair[2]) then
		return nil
	end
	for i, teamId in ipairs(pair) do
		if killedTeamId == teamId and (isSolo or self:IsTeamAllDead(teamId)) then
			return { winner = pair[3 - i], loser = teamId }
		end
	end
	return nil
end