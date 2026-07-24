--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local function handleKillPlayer(payload, initiatorName)
    if not payload or not payload.uid then
        logger:Log("kill_player: payload.uid отсутствует")
        return
    end

    local targetUid = tostring(payload.uid)
    local foundPlayerId = nil

    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsValidPlayer(playerId)
            and PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED
        then
            if GetSteamID(playerId) == targetUid then
                foundPlayerId = playerId
                break
            end
        end
    end

    if foundPlayerId == nil then
        logger:Logf("kill_player: игрок с uid=%s не найден или не подключён", targetUid)
        return
    end

    local hero = PlayerResource:GetSelectedHeroEntity(foundPlayerId)
    if not hero then
        logger:Logf("kill_player: герой игрока uid=%s не найден", targetUid)
        return
    end

    if not hero:IsAlive() then
        logger:Logf("kill_player: герой игрока uid=%s уже мёртв", targetUid)
        return
    end

    -- Kill (не ForceKill): проводит смерть через пайплайн и поднимает entity_killed,
    -- иначе PvP-развязка (OnEntityKilled → EndPvp → респаун) не сработает.
    hero:Kill(nil, nil)
    logger:Logf("kill_player: герой игрока uid=%s убит (инициатор: %s)", targetUid, tostring(initiatorName or "ADMIN"))

    local targetName = PlayerResource:GetPlayerName(foundPlayerId)
    if not targetName or targetName == "" then
        targetName = hero:GetUnitName()
    end
    if not targetName or targetName == "" then
        targetName = targetUid
    end
    MatchCommandService:Notify(initiatorName, "убил игрока " .. targetName)
end

MatchCommandService:Register("kill_player", handleKillPlayer)