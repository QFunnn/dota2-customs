--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class GoldService
GoldService = GoldService or {}

---@param playerId integer
local function PushPlayerGold(playerId)
	local player = PlayerResource:GetPlayer(playerId)
	if not player or not GameRulesCustom.gameStartTime then
		return
	end
	CustomNetTables:SetTableValue("player_info", tostring(playerId), {
		gold = _G.PlayersGold[playerId],
	})
end

---@param playerId integer
function GoldService:MarkDirty(playerId)
	self.dirtyGold = self.dirtyGold or {}
	self.dirtyGold[playerId] = true

	if self.goldFlushScheduled then
		return
	end
	self.goldFlushScheduled = true
	Timers:CreateTimer(0.5, function()
		self.goldFlushScheduled = false
		local dirty = self.dirtyGold
		self.dirtyGold = {}
		for pid in pairs(dirty) do
			PushPlayerGold(pid)
		end
	end)
end

---@param playerId integer
---@return integer
function GoldService:GetTotalGoldForPlayer(playerId)
	if PlayersGold == nil then
		_G.PlayersGold = {}
	end
	if PlayersGold[playerId] == nil then
		PlayersGold[playerId] = 600
	end
	return PlayersGold[playerId] or 0
end

---@param nPlayerID integer
---@return integer
function GoldService:GetBotEarnedGold(nPlayerID)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if hHero then
		if GameRulesCustom.gameStartTime then
			local nGold = math.ceil(
				PlayerResource:GetGoldPerMin(nPlayerID)
					* (GameRulesCustom:GetGameTime() - GameRulesCustom.gameStartTime)
					/ 60
			) + 600 - BetService:GetTotalBetSum(nPlayerID)
			return nGold
		end
	end
	return 600
end

---Возвращает текущий уровень дополнительной награды за игрока
---@param playerId integer
---@return integer
function GoldService:GetPlayerBonusGoldPercentage(playerId)
	local pct = 0
	local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
	if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
		if hHero:HasModifier("modifier_relief_fund") then
			local stack = hHero:FindModifierByName("modifier_relief_fund"):GetStackCount() or 0
			pct = pct + stack * 8
		end
	end
	return pct
end