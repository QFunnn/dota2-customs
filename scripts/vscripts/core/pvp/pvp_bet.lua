--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Обработчик события ставки с UI
---@param event any
function PvpModule:ConfirmBet(event)
    if not event.PlayerID then return end

    local nPlayerId = event.PlayerID;
    local maxBetGold = math.floor(PlayerResource:GetGold(nPlayerId) / 2)

    if type(event.value) ~= "number" then
        logger:Log("Bet value is not number")
        return
    end

    if PvpModule.IsPvpBetClose then
        logger:Log("Bet already end")
        return
    end

    if not GameMode.aliveTeamMap[PlayerResource:GetTeam(nPlayerId)] then
        logger:Log("Team Already Lose")
        return
    end

    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerId)
    if hHero == nil or hHero:IsNull() then return end
    if not hHero:IsAlive() and not hHero:IsReincarnating() then
        logger:Log("Dead player can't bet")
        return
    end

    local isAlreadyBet = false

    for _, dataList in pairs(PvpModule.betMap) do
        for _, data in ipairs(dataList) do
            if data.nPlayerId == nPlayerId then isAlreadyBet = true end
        end
    end

    if isAlreadyBet then
        logger:Log("Already Bet")
        return
    end

    local betValue = math.floor(event.value)

    if betValue <= 0 then return end
    if betValue > maxBetGold then betValue = maxBetGold end

    if PvpModule.betMap[event.wish_team_id] == nil then
        logger:Log("Bet wish team Id:" .. event.wish_team_id .. "is null")
        return
    end

    if PvpModule.betMap[PlayerResource:GetTeam(nPlayerId)] ~= nil then
        logger:Log("Duel participant can't bet")
        return
    end

    local data = {}
    data.nPlayerId = nPlayerId
    data.nValue = betValue
    table.insert(PvpModule.betMap[event.wish_team_id], data)

    PvpModule.BaseBetBonus = PvpModule.BaseBetBonus + betValue;

    if PvpModule.TotalBetSum[nPlayerId] then
        PvpModule.TotalBetSum[nPlayerId] = PvpModule.TotalBetSum[nPlayerId] + betValue
    end

    hHero:SpendGold(betValue, DOTA_ModifyGold_Unspecified)
    hHero:EmitSound("DOTA_Item.Hand_Of_Midas")
    local pfx = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf", PATTACH_ABSORIGIN, hHero)
    ParticleManager:ReleaseParticleIndex(pfx)

    self:BroadcastPvpBetAcceptedForTeam(event.wish_team_id, nPlayerId)
end

---@param teamId integer
---@param betPlayerId integer
function PvpModule:BroadcastPvpBetAcceptedForTeam(teamId, betPlayerId)
    for playerId = 0, CHC_MAX_PLAYER_COUNT - 1 do
        if PlayerResource:IsValidPlayer(playerId) then
            local hPlayer = PlayerResource:GetPlayer(playerId)
            if hPlayer then
                -- Ищем команду, на которую поставил САМ получатель события,
                -- иначе при ставке другого игрока potential_win считается для
                -- "не моей" команды и возвращает 0, обнуляя прогноз.
                local recipientBetTeam = nil
                for tid, list in pairs(PvpModule.betMap) do
                    for _, d in ipairs(list) do
                        if d and d.nPlayerId == playerId then
                            recipientBetTeam = tid
                            break
                        end
                    end
                    if recipientBetTeam then break end
                end

                local potentialWin = 0
                if recipientBetTeam then
                    potentialWin = self:GetPotentialBetWin(playerId, recipientBetTeam)
                end

                CustomGameEventManager:Send_ServerToPlayer(hPlayer, "PvpBetAccepted", {
                    betMap = PvpModule.betMap,
                    potential_win = potentialWin,
                    is_self = (playerId == betPlayerId) and 1 or 0,
                })
            end
        end
    end
end

---@param playerId integer
---@param teamId integer
---@return integer
function PvpModule:GetPotentialBetWin(playerId, teamId)
    local list = PvpModule.betMap[teamId]
    if not list then return 0 end

    local totalBet = 0
    local playerBet = 0
    for _, data in ipairs(list) do
        if data and data.nValue then
            totalBet = totalBet + data.nValue
            if data.nPlayerId == playerId then
                playerBet = playerBet + data.nValue
            end
        end
    end

    if totalBet <= 0 or playerBet <= 0 then return 0 end

    local flRatio = playerBet / totalBet
    local bonusGoldCount = math.floor(PvpModule.BaseBetBonus * flRatio)
    local payout = math.ceil(bonusGoldCount * (100 + Util:GetPlayerBonusGoldPercentage(playerId)) * 0.01)
    local netWin = payout - playerBet
    if netWin < 0 then netWin = 0 end
    return netWin
end

-- Награждаем победителя дуели
function PvpModule:RewardWinnerBonus(nPlayerId, nBonusGold)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerId)
    if not hHero then return end
    
    local nTotalWave
    if (nBonusGold > 7000) then
        nTotalWave = 80 -- если выиграл больше 7к, отдаём выигранное за 40 волн
    else
        nTotalWave = math.ceil(nBonusGold / 66)
    end
    local nGoldPerWave = math.ceil(nBonusGold / nTotalWave)

    local nParticle1 = ParticleManager:CreateParticle("particles/econ/events/ti6/teleport_start_ti6.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hHero)
    ParticleManager:SetParticleControlEnt(nParticle1, 0, hHero, PATTACH_POINT_FOLLOW, "attach_hitloc", hHero:GetOrigin(), true)
    local nParticle2 = ParticleManager:CreateParticle("particles/econ/events/ti6/teleport_start_ti6_lvl3_rays.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hHero)
    ParticleManager:SetParticleControlEnt(nParticle2, 0, hHero, PATTACH_POINT_FOLLOW, "attach_hitloc", hHero:GetOrigin(), true)
    local nWave = 0

    Timers:CreateTimer(function()
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, hHero, nGoldPerWave, nil)
        hHero:ModifyGoldFiltered(nGoldPerWave, true, DOTA_ModifyGold_Unspecified)
        nWave = nWave + 1
        if nWave == nTotalWave then
            ParticleManager:DestroyParticle(nParticle1, false)
            ParticleManager:DestroyParticle(nParticle2, false)
            ParticleManager:ReleaseParticleIndex(nParticle1)
            ParticleManager:ReleaseParticleIndex(nParticle2)
            return nil
        else
            return 0.15
        end
    end)
end


---Выдать награду победителю ставки
---@param playerId integer
---@param bonusGold integer
function PvpModule:RewardBetBonus(playerId, bonusGold)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if not hHero then return end

    local nTotalWave
    if (bonusGold > 7000) then
        nTotalWave = 80 -- если выиграл больше 7к, отдаём выигранное за 40 волн
    else
        nTotalWave = math.ceil(bonusGold / 66)
    end
    local nGoldPerWave = math.ceil(bonusGold / nTotalWave)

    local nWave = 0

    Timers:CreateTimer(function()
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, hHero, nGoldPerWave, nil)
        hHero:ModifyGoldFiltered(nGoldPerWave, true, DOTA_ModifyGold_Unspecified)
        if math.mod(nWave, 15) == 0 then
            local nParticle = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_spindle_rig.vpcf", PATTACH_OVERHEAD_FOLLOW, hHero)
            ParticleManager:ReleaseParticleIndex(nParticle)
        end
        nWave = nWave + 1
        if nWave == nTotalWave then
            return nil
        else
            return 0.15
        end
    end)

end

---comment
---@param playerId integer
---@param value integer
function PvpModule:SumBetReward(playerId, value)
    PvpModule.PvpRecord[playerId].total_bet_reward = PvpModule.PvpRecord[playerId].total_bet_reward + value
end

---Подвести итог информации о ставках и отправить сообщение в Barrage
function PvpModule:SummarizeBetInfo()
    PvpModule.IsPvpBetClose = true

    if PvpModule.IsPvpEnd then return end

    -- Бесплатные ставки участников PVP
    local pvpFreeBet = 0

    for teamId, list in pairs(PvpModule.betMap) do

        local totalBet = 0

        for _, data in ipairs(list) do
            totalBet = totalBet + data.nValue
        end

        if string.find(GetMapName(), "1x8") then
            local data = {}
            data.type = "bet_summary_solo"
            data.playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, 1)
            data.gold_value = totalBet
            Barrage:FireBullet(data, {
                PvpModule.currentPvpPair[1], PvpModule.currentPvpPair[2]
            })
        end

        if GetMapName() == "2x6" then
            local data = {}
            data.type = "bet_summary"
            data.teamId = teamId
            data.gold_value = totalBet
            Barrage:FireBullet(data, {
                PvpModule.currentPvpPair[1], PvpModule.currentPvpPair[2]
            })
        end

        for _, nPlayerID in ipairs(GameMode.teamPlayerMap[teamId]) do
            local data = {}
            local pvpBetRatio = 0.05

            if GetMapName() == "2x6" then pvpBetRatio = 0.02 end

            if GetMapName() == "5v5" then pvpBetRatio = 0.08 end

            data.nValue = math.floor(PvpModule.BaseBetBonus * pvpBetRatio)
            data.nPlayerId = nPlayerID
            data.sType = "pvp_free"
            totalBet = totalBet + data.nValue
            pvpFreeBet = pvpFreeBet + data.nValue

            table.insert(list, data)
        end

        -- Рассчитать процентное соотношение ставок
        for _, data in ipairs(list) do
            local flRatio = data.nValue / totalBet
            data.flRatio = flRatio
        end

    end

    PvpModule.BaseBetBonus = PvpModule.BaseBetBonus + pvpFreeBet
end