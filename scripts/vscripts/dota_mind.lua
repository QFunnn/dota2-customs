--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Deprecated

local md5 = require 'utils/md5'

if DotaMind == nil then DotaMind = class({}) end
--TODO:包明
function DotaMind:Init()
	DotaMind.sAppId = "632d3496a4bb40479151bae72485b270"
	DotaMind.sSecret = "fe080efa081147688e31d5dcb1397c8b"
	DotaMind.sUrl = "https://apidota.gamesmindai.com/wisp/handler"
	DotaMind.sLog = ""

	--等待DotaMind返回分数的等待次数
	DotaMind.nWaitFinalScoreUpdate = 1
	DotaMind.bFinalScoreUpdateSuccess = false
	--每轮快照
	DotaMind.roundSnap = {}
	for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
		--每轮玩家快照
		DotaMind.roundSnap[nPlayerID] = {}
	end
	if IsInToolsMode() then
		DotaMind.sMatchId = "570" .. tostring(RandomInt(0, 8853419))
	end
end

--获取SteamID 测试环境下使用固定ID
function DotaMind:GetSteamID(nPlayerID)
	local sPlayerSteamId = tostring(PlayerResource:GetSteamAccountID(nPlayerID))
	-- 测试默认下，为玩家添加随机ID
	if sPlayerSteamId == "0" then
		sPlayerSteamId = tostring(80000000 + nPlayerID)
	end
	return sPlayerSteamId
end



function DotaMind:RecordSnap(nRoundNumber, nPlayerID)
	local heroInfo = DotaMind:CreateSnap(nPlayerID)
	DotaMind.roundSnap[nPlayerID][tostring(nRoundNumber)] = heroInfo
end


function DotaMind:CreateSnap(nPlayerID)

	local heroInfo = {}
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

	if hHero then
		local abilities = {}
		local talents = {}
		--添加技能
		for i = 0, hHero:GetAbilityCount() - 1 do
			local hAbility = hHero:GetAbilityByIndex(i)
			if hAbility and hAbility.GetAbilityName then
				--天赋
				if string.sub(hAbility:GetAbilityName(), 1, 14) == "special_bonus_" then
					talents[hAbility:GetAbilityName()] = hAbility:GetLevel()
					--技能
				else
					abilities[hAbility:GetAbilityName()] = hAbility:GetLevel()
				end
			end
		end

		--如果记录过消耗品
		local sConsumedItems = ""
		if hHero.sConsumedItems then
			sConsumedItems = hHero.sConsumedItems
		end

		if string.sub(sConsumedItems, string.len(sConsumedItems)) == "," then   --去掉最后一个逗号
			sConsumedItems = string.sub(sConsumedItems, 0, string.len(sConsumedItems) - 1)
		end

		local sItems = ""
		for i = 0, 5 do --遍历物品
			local hItem = hHero:GetItemInSlot(i)
			if hItem then
				sItems = sItems .. hItem:GetName() .. ","
			end
		end

		if string.sub(sItems, string.len(sItems)) == "," then   --去掉最后一个逗号
			sItems = string.sub(sItems, 0, string.len(sItems) - 1)
		end


		local sPackageItems = ""
		for i = 6, 8 do --遍历物品
			local hItem = hHero:GetItemInSlot(i)
			if hItem then
				sPackageItems = sPackageItems .. hItem:GetName() .. ","
			end
		end

		if string.sub(sPackageItems, string.len(sPackageItems)) == "," then   --去掉最后一个逗号
			sPackageItems = string.sub(sPackageItems, 0, string.len(sPackageItems) - 1)
		end

		local sNeutralItem = ""
		local hNeutralItem = hHero:GetItemInSlot(16)
		if hNeutralItem then
			sNeutralItem = hNeutralItem:GetName()
		end

		heroInfo.hero_name = hHero:GetUnitName()
		heroInfo.abilities = abilities
		heroInfo.talents = talents
		heroInfo.items = sItems
		heroInfo.package_items = sPackageItems
		heroInfo.neutral_item = sNeutralItem
		heroInfo.consumed_items = sConsumedItems
		heroInfo.hero_level = hHero:GetLevel()
		heroInfo.uid = DotaMind:GetSteamID(nPlayerID)
		local pvpRecord = CustomNetTables:GetTableValue("pvp_record", tostring(nPlayerID))
		if pvpRecord then
			heroInfo.pvp_win = pvpRecord.win
			heroInfo.pvp_lose = pvpRecord.lose
			heroInfo.total_bet_reward = pvpRecord.total_bet_reward
		else
			heroInfo.pvp_win = 0
			heroInfo.pvp_lose = 0
			heroInfo.total_bet_reward = 0
		end

		heroInfo.hero_name = PlayerResource:GetSelectedHeroEntity(nPlayerID):GetUnitName()
		heroInfo.team = PlayerResource:GetTeam(nPlayerID)

		heroInfo.kills = PlayerResource:GetKills(nPlayerID)
		heroInfo.deaths = PlayerResource:GetDeaths(nPlayerID)
		heroInfo.assists = PlayerResource:GetAssists(nPlayerID)

		local goldRecord = CustomNetTables:GetTableValue("player_info", tostring(nPlayerID))
		if goldRecord then
			heroInfo.total_gold = goldRecord.gold
		else
			heroInfo.total_gold = 600
		end

		local rankRecord = CustomNetTables:GetTableValue("team_rank", tostring(PlayerResource:GetTeam(nPlayerID)))
		if rankRecord and rankRecord.rank and rankRecord.rank > 0 then
			heroInfo.rank = rankRecord.rank
		else
			heroInfo.rank = -1
		end

		if rankRecord and rankRecord.defeat_round and rankRecord.defeat_round > 0 then
			heroInfo.defeat_round = rankRecord.defeat_round
		else
			heroInfo.defeat_round = -1
		end

		local damageRecord = 0--CustomNetTables:GetTableValue("hero_info", "damage_count")[tostring(nPlayerID)]
		if damageRecord and type(damageRecord) == "number" then
			heroInfo.damage = math.ceil(damageRecord)
		else
			heroInfo.damage = 0
		end
	end

	return heroInfo

end


function DotaMind:GameStart()

	-- 作弊模式不记录
	if GameRules:IsCheatMode() and (not IsInToolsMode()) then
		return
	end

	local request = CreateHTTPRequestScriptVM("POST", DotaMind.sUrl)
	request:SetHTTPRequestHeaderValue("Content-Type", "application/json")

	local data = {}
	data.matchId = tostring(GameRules:Script_GetMatchID())

	if IsInToolsMode() then
		data.matchId = DotaMind.sMatchId
	end

	data.mode = GetMapName()
	data.uids = {}
	data.season = {}
	data.season.type = "key"
	--更新赛季的时候 记得改这个值
	data.season.value = "2024-05"

	for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
		if PlayerResource:IsValidPlayer(nPlayerID) then
			local sPlayerSteamID = DotaMind:GetSteamID(nPlayerID)
			table.insert(data.uids, sPlayerSteamID)
		end
	end

	local body = { message = { appId = DotaMind.sAppId, signature = sSignature, data = data }, route = "wisp.game.start" }
	local sSignature = md5.sumhexa(tostring(JSON:encode({ body = tostring(JSON:encode(body)), secret = DotaMind.sSecret })))

	request:SetHTTPRequestHeaderValue("signature", sSignature)
	request:SetHTTPRequestRawPostBody("application/json", JSON:encode(body))

	request:SetHTTPRequestAbsoluteTimeoutMS(30 * 1000)
	request:Send(function(result)
		print("Dota Mind GameStart Return" .. result.StatusCode)
		if result.StatusCode == 200 and result.Body ~= nil then
			local body = JSON:decode(result.Body)
			if body ~= nil then
				if body.teams and #body.teams > 0 then
					print("This Game Start with APP Match")
					GameMode.sPasswordLobby = "true"
					Notifications:BottomToAll({ text = "#password_lobby_note", duration = 15, style = { color = "Red" } })
				end
				DotaMind.sLog = DotaMind.sLog .. "GameStart Success"
			end
		else
			DotaMind.sLog = DotaMind.sLog .. "GameStart Fail: result.StatusCode" .. tostring(result.StatusCode) .. " result.Body" .. tostring(result.Body)
		end
	end)
end

function DotaMind:GamePost()

	-- 作弊模式不记录
	if GameRules:IsCheatMode() and (not IsInToolsMode()) then
		return
	end

	local request = CreateHTTPRequestScriptVM("POST", DotaMind.sUrl)
	request:SetHTTPRequestHeaderValue("Content-Type", "application/json")

	local data = {}
	data.matchId = tostring(GameRules:Script_GetMatchID())

	if IsInToolsMode() then
		data.matchId = DotaMind.sMatchId
	end

	data.mode = GetMapName()
	data.endInfos = {}
	data.roundSnapInfos = {}
	data.gameDuration = tostring(GameRules:GetGameTime());

	for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
		if PlayerResource:IsValidPlayer(nPlayerID) then
			local nPlayerSteamID = DotaMind:GetSteamID(nPlayerID)
			local heroInfo = DotaMind:CreateSnap(nPlayerID)
			data.endInfos[nPlayerSteamID] = heroInfo
			data.roundSnapInfos[nPlayerSteamID] = DotaMind.roundSnap[nPlayerID]
		end
	end

	local body = { message = { appId = DotaMind.sAppId, signature = sSignature, data = data }, route = "wisp.game.post" }
	local sSignature = md5.sumhexa(tostring(JSON:encode({ body = tostring(JSON:encode(body)), secret = DotaMind.sSecret })))

	request:SetHTTPRequestHeaderValue("signature", sSignature)
	request:SetHTTPRequestRawPostBody("application/json", JSON:encode(body))


	print("Dota Mind GamePost")
	print(JSON:encode(body))
	print(sSignature)
	print("-------------------")

	if IsInToolsMode() then
		--Server:UploadErrorLog(tostring(JSON:encode(body)))
	end

	request:SetHTTPRequestAbsoluteTimeoutMS(30 * 1000)
	request:Send(function(result)
		print("Dota Mind GamePost Return" .. result.StatusCode)
		if result.StatusCode == 200 and result.Body ~= nil then
			if result.Body ~= nil then
				print(result.Body)
			end
			DotaMind.sLog = DotaMind.sLog .. "GamePost Success"
		else
			DotaMind.sLog = DotaMind.sLog .. "GamePost Fail: result.StatusCode" .. tostring(result.StatusCode) .. " result.Body" .. tostring(result.Body)
		end
	end)

end

--bGameEnd 本场游戏最后一次更新
function DotaMind:UpdateScore(bFinalScoreUpdate)

	-- 作弊模式不记录
	if GameRules:IsCheatMode() or IsInToolsMode() then
		return
	end

	local request = CreateHTTPRequestScriptVM("POST", DotaMind.sUrl)
	request:SetHTTPRequestHeaderValue("Content-Type", "application/json")

	local data = {}
	data.matchId = tostring(GameRules:Script_GetMatchID())

	if IsInToolsMode() then
		data.matchId = DotaMind.sMatchId
	end

	data.mode = GetMapName()
	data.ranks = {}
	data.teams = {}
	local tempTeams = {}

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(nPlayerID) and PlayerResource:GetSelectedHeroEntity(nPlayerID) then
			local sPlayerSteamId = DotaMind:GetSteamID(nPlayerID)
			local rank = -1
			for k, nTeamNumber in pairs(GameMode.rankMap) do
				if nTeamNumber == PlayerResource:GetSelectedHeroEntity(nPlayerID):GetTeamNumber() then
					rank = k
				end
			end
			data.ranks[sPlayerSteamId] = rank
		end
	end

	for nTeamNumber, _ in pairs(GameMode.vAliveTeam) do
		tempTeams[nTeamNumber] = {}
		for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if PlayerResource:IsValidPlayer(nPlayerID) and PlayerResource:GetSelectedHeroEntity(nPlayerID) and PlayerResource:GetSelectedHeroEntity(nPlayerID):GetTeamNumber() == nTeamNumber then
				local sPlayerSteamId = DotaMind:GetSteamID(nPlayerID)
				table.insert(tempTeams[nTeamNumber], sPlayerSteamId)
			end
		end
	end

	--过滤全部非空值 加入结果
	for k, v in pairs(tempTeams) do
		if v and #v > 0 then
			table.insert(data.teams, v)
		end
	end

	local body = { message = { appId = DotaMind.sAppId, signature = sSignature, data = data }, route = "wisp.score.calc" }
	local sSignature = md5.sumhexa(tostring(JSON:encode({ body = tostring(JSON:encode(body)), secret = DotaMind.sSecret })))

	request:SetHTTPRequestHeaderValue("signature", sSignature)
	request:SetHTTPRequestRawPostBody("application/json", JSON:encode(body))

	print("Dota Mind UpdateScore")
	print(JSON:encode(body))
	print(sSignature)
	print("-------------------")


	request:SetHTTPRequestAbsoluteTimeoutMS(30 * 1000)
	request:Send(function(result)
		print("Dota Mind UpdateScore Return" .. result.StatusCode)
		--最后一次分数更新提交成功
		if bFinalScoreUpdate then
			DotaMind.bFinalScoreUpdateSuccess = true
		end

		if result.StatusCode == 200 and result.Body ~= nil then
			local body = JSON:decode(result.Body)
			if body ~= nil then
				for _, v in pairs(body.scores) do
					--防止之前的数据回传比较慢，导致数据被覆盖
					if tostring(v.scoreUpdated) == "true" then
						-- CustomNetTables:SetTableValue("end_game_data", "dota_mind_score_" .. v.accountId, v)
						CustomNetTables:SetTableValue("dota_mind_score", tostring(v.accountId), v)
					end
				end
				if bFinalScoreUpdate then
					PrintTable(body)
				end
			end
			DotaMind.sLog = DotaMind.sLog .. "UpdateScore Success, body:" .. tostring(result.Body)
		else
			DotaMind.sLog = DotaMind.sLog .. "UpdateScore Fail: result.StatusCode" .. tostring(result.StatusCode) .. " result.Body" .. tostring(result.Body)
		end
	end)

end