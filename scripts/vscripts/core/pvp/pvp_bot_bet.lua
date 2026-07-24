--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Автоматически поставить ставку бота
---@param playerId integer
function PvpModule:BotAutoBet(playerId)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if not IsValid(hHero) then return end ---@cast hHero CDOTA_BaseNPC_Hero

    if hHero.nBotSpendGold == nil then hHero.nBotSpendGold = 0 end

    local nCurrentGold = Util:GetBotEarnedGold(playerId) - hHero.nBotSpendGold

    local nMaxGold = math.floor(PlayerResource:GetGold(playerId) / 2)

    if PvpModule.IsPvpBetClose then
        logger:Log("Bet already end")
        return
    end

    if not GameMode.aliveTeamMap[PlayerResource:GetTeam(playerId)] then
        logger:Log("Team Already Lose")
        return
    end

    local isAlreadyBet = false

    for _, dataList in pairs(PvpModule.betMap) do
        for _, data in ipairs(dataList) do
            if data.nPlayerId == playerId then isAlreadyBet = true end
        end
    end

    if isAlreadyBet then
        logger:Log("Already Bet")
        return
    end

    local nGoldSum = 0
    local wishTeamList = {}

    local nFinialWishTeamID

    for nPvpTeamID, _ in pairs(PvpModule.betMap) do
        local nTotalGold = 0
        for _, nPvpPlayerID in ipairs(GameMode.teamPlayerMap[nPvpTeamID]) do
            local playerInfo = CustomNetTables:GetTableValue("player_info", tostring(nPvpPlayerID))
            if playerInfo then
                nTotalGold = nTotalGold + playerInfo.gold
            else
                nTotalGold = nTotalGold + 600
            end
        end
        table.insert(wishTeamList,
                     {nGold = nTotalGold, nWishTeamID = nPvpTeamID})
        nGoldSum = nGoldSum + nTotalGold
    end

    if RandomFloat(0, 1) < wishTeamList[1].nGold / nGoldSum then
        nFinialWishTeamID = wishTeamList[1].nWishTeamID
    else
        nFinialWishTeamID = wishTeamList[2].nWishTeamID
    end

    local nValue = math.floor(RandomFloat(0, 1) * nCurrentGold * 0.4)

    if nValue <= 0 then return end

    local data = {}
    data.nPlayerId = playerId
    data.nValue = nValue
    table.insert(PvpModule.betMap[nFinialWishTeamID], data)

    PvpModule.BaseBetBonus = PvpModule.BaseBetBonus + nValue;

    if PvpModule.TotalBetSum[playerId] then
        PvpModule.TotalBetSum[playerId] =
            PvpModule.TotalBetSum[playerId] + nValue
    end

    hHero.nBotSpendGold = hHero.nBotSpendGold + nValue
    hHero:EmitSound("DOTA_Item.Hand_Of_Midas")
    local pfx = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf", PATTACH_ABSORIGIN, hHero)
    ParticleManager:ReleaseParticleIndex(pfx)
end