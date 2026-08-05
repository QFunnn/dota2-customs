--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


PlayersSummary = PlayersSummary or class({})
PlayersSummary.data = PlayersSummary.data or {}

function PlayersSummary:Init()
	if PlayersSummary.ready then
		return
	end

	CustomGameEventManager:RegisterListener("RequestPlayersSummary", function(_, data)
		self:RequestPlayersSummary(data)
	end)
	GameRules:GetGameModeEntity()
		:SetModifyExperienceFilter(Dynamic_Wrap(PlayersSummary, "ModifyExperienceFilter"), self)

	PlayersSummary.ready = true
end

function PlayersSummary:InitPlayerHero(playerId)
	if self.data[playerId] then
		return self.data[playerId]
	end

	local data = {
		accountId = PlayerResource:GetSteamAccountID(playerId),
		heroUnitName = PlayerResource:GetSelectedHeroEntity(playerId):GetUnitName(),

		creepsKilled = 0,
		deaths = 0,
		aegisDeaths = 0,
		goldReceived = 0,
		expReceived = 0,

		damageDealt = {
			physical = 0,
			physicalOriginal = 0,
			magical = 0,
			magicalOriginal = 0,
			pure = 0,
			total = 0,
			totalOriginal = 0,
		},

		damageReceived = {
			physical = 0,
			physicalOriginal = 0,
			magical = 0,
			magicalOriginal = 0,
			pure = 0,
			total = 0,
			totalOriginal = 0,
		},

		shieldsReceived = 0,
		shieldsTotal = 0,

		accountExpReceived = 0,
		guildExpReceived = 0,
	}

	if not Account_stats then
		data.accountLevel = 0
	else
		local playerAccountStats = Account_stats[data.accountId]
		if playerAccountStats then
			data.accountLevel = playerAccountStats.level or 0
		end
	end

	self.data[playerId] = data

	return data
end

function PlayersSummary:GetPlayerHeroData(playerId)
	return self.data[playerId] or self:InitPlayerHero(playerId)
end

function PlayersSummary:SyncPlayersSummaryWithClient(loseReason)
	self:UpdatePlayersDeaths()
	self:UpdatePlayersAccountLevel()

	if loseReason then
		LoseReason = loseReason
	end

	CustomNetTables:SetTableValue("players_summary", "data", self.data)
	CustomNetTables:SetTableValue(
		"players_summary",
		"extra_data",
		{ difficulty = Game_Difficulty, loseReason = LoseReason }
	)
end

function PlayersSummary:HandleAddPr(playerId, addRp, totalRp, accountExp, guildExp)
	local playerSummary = self:GetPlayerHeroData(playerId)

	playerSummary.shieldsReceived = playerSummary.shieldsReceived + addRp
	playerSummary.shieldsTotal = playerSummary.shieldsTotal + totalRp
	playerSummary.accountExpReceived = playerSummary.accountExpReceived + accountExp
	playerSummary.guildExpReceived = playerSummary.guildExpReceived + guildExp
end

local damageTypeToDamageKeyMap = {
	[DAMAGE_TYPE_PHYSICAL] = "physical",
	[DAMAGE_TYPE_MAGICAL] = "magical",
	[DAMAGE_TYPE_PURE] = "pure",
}

PLAYER_SUMMARY_DAMAGE_HANDLE_TYPE = {
	DEAL = "damageDealt",
	RECEIVE = "damageReceived",
}

function PlayersSummary:HandleDamage(handleType, playerId, damage, damageType, originalDamage)
	local playerSummary = self:GetPlayerHeroData(playerId)

	local playerSummaryDamageCategory = playerSummary[handleType]

	if not playerSummaryDamageCategory then
		return
	end

	local damageKey = damageTypeToDamageKeyMap[damageType] or "pure"

	if damageKey == "pure" then
		playerSummaryDamageCategory[damageKey] = playerSummaryDamageCategory[damageKey] + originalDamage
		playerSummaryDamageCategory.total = playerSummaryDamageCategory.total + originalDamage
		playerSummaryDamageCategory.totalOriginal = playerSummaryDamageCategory.totalOriginal + originalDamage
	else
		playerSummaryDamageCategory[damageKey] = playerSummaryDamageCategory[damageKey] + damage
		playerSummaryDamageCategory[damageKey .. "Original"] = playerSummaryDamageCategory[damageKey .. "Original"]
			+ originalDamage
		playerSummaryDamageCategory.total = playerSummaryDamageCategory.total + damage
		playerSummaryDamageCategory.totalOriginal = playerSummaryDamageCategory.totalOriginal + originalDamage
	end
end

function PlayersSummary:HandleKill(playerId)
	local playerSummary = self:GetPlayerHeroData(playerId)

	playerSummary.creepsKilled = playerSummary.creepsKilled + 1
end

PlayersSummary.CDOTA_BaseNPC_Hero_ModifyGold = PlayersSummary.CDOTA_BaseNPC_Hero_ModifyGold
	or CDOTA_BaseNPC_Hero.ModifyGold
local CDOTA_BaseNPC_Hero_ModifyGold = PlayersSummary.CDOTA_BaseNPC_Hero_ModifyGold

function CDOTA_BaseNPC_Hero:ModifyGold(goldChange, reliable, reason)
	CDOTA_BaseNPC_Hero_ModifyGold(self, goldChange, reliable, reason)

	if goldChange <= 0 then
		return
	end

	local playerSummary = PlayersSummary:GetPlayerHeroData(self:GetPlayerOwnerID())

	playerSummary.goldReceived = playerSummary.goldReceived + goldChange
end

function PlayersSummary:ModifyExperienceFilter(data)
	local playerId = data.player_id_const
	if playerId < 0 or playerId > 4 then
		return
	end

	local exp = data.experience
	if exp <= 0 then
		return
	end

	local playerSummary = self:GetPlayerHeroData(playerId)

	playerSummary.expReceived = playerSummary.expReceived + exp

	return true
end

function PlayersSummary:HandleAegisDeath(hero)
	local playerSummary = self:GetPlayerHeroData(hero:GetPlayerOwnerID())

	playerSummary.aegisDeaths = playerSummary.aegisDeaths + 1
end

function PlayersSummary:UpdatePlayersDeaths()
	for playerId, playerSummary in pairs(self.data) do
		local hero = PlayerResource:GetSelectedHeroEntity(playerId)

		if hero then
			playerSummary.deaths = playerSummary.aegisDeaths + hero:GetDeaths()
		else
			playerSummary.deaths = playerSummary.aegisDeaths
		end
	end
end

function PlayersSummary:UpdatePlayersAccountLevel()
	if not Account_stats then
		return
	end

	for _, playerSummary in pairs(self.data) do
		local playerAccountStats = Account_stats[playerSummary.accountId]
		if playerAccountStats then
			playerSummary.accountLevel = playerAccountStats.level or 0
		else
			playerSummary.accountLevel = 0
		end
	end
end