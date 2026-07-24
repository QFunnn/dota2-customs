--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param uid string
---@param tag {code: string, name: string, colorHex: string, icon: string}|nil
function GameMode:UpdatePlayerTag(uid, tag)
    local playerTagTable = CustomNetTables:GetTableValue("service", "player_tag") or {}
    playerTagTable[uid] = {
        code = tag and tag.code or nil,
        name = tag and tag.name or nil,
        colorHex = tag and tag.colorHex or nil,
        icon = tag and tag.icon or nil
    }
    CustomNetTables:SetTableValue("service", "player_tag", playerTagTable)
end

---@param uid string
---@param ratingInfos table<integer, {rating: integer, matchTypeCode: string, playTime: integer}>
function GameMode:UpdateRankTable(uid, ratingInfos)
    local playerRankTable = CustomNetTables:GetTableValue("service", "player_rank") or {}
    for _, ratingInfo in pairs(ratingInfos) do
        if self:GetMatchType() == ratingInfo.matchTypeCode then
            playerRankTable[uid] = {
                score = ratingInfo.rating,
                play_time = ratingInfo.playTime
            }
            CustomNetTables:SetTableValue("service", "player_rank", playerRankTable)
        end
    end
end

function GameMode:KickBannedPlayer(uid, banned)
    if not banned then return end
    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if uid == GetSteamID(playerId) then
            local player = PlayerResource:GetPlayer(playerId)
            if not player then return end
            local bannedPlayersTable = CustomNetTables:GetTableValue("service", "banned_players") or {}
            table.insert(bannedPlayersTable, playerId)
            CustomNetTables:SetTableValue("service", "banned_players", bannedPlayersTable)
            CustomGameEventManager:Send_ServerToPlayer(player, "KickPlayer", {
                security_key = Security:GetSecurityKey(playerId),
                player_id = playerId
            })
        end
    end
end

---@param uid string
---@param bans {abilities: table<integer, string>, heroes: table<integer, string>}
function GameMode:UpdateRecentBans(uid, bans)
    logger:Log(string.format("Update NetTables recent bans for user %s started.", uid))
    local abilityBansTable = CustomNetTables:GetTableValue("service", "player_ban_ability") or {}
    local heroBansTable = CustomNetTables:GetTableValue("service", "player_ban_hero") or {}
    abilityBansTable[uid] = bans and bans.abilities or {}
    heroBansTable[uid] = bans and bans.heroes or {}
    CustomNetTables:SetTableValue("service", "player_ban_ability", abilityBansTable)
    CustomNetTables:SetTableValue("service", "player_ban_hero", heroBansTable)
    logger:Log(string.format("Update NetTables recent bans for user %s finished.", uid))
end

---@class BanPresetTable
---@field name string
---@field heroes table<integer, string>
---@field abilities table<integer, string>

---@param uid string
---@param banPresets table<integer, BanPresetTable>|nil
function GameMode:UpdateBanPresets(uid, banPresets)
    logger:Log(string.format("Update NetTables ban presets for user %s started.", uid))
    local banPresetsTable = CustomNetTables:GetTableValue("service", "player_ban_presets") or {}
    banPresetsTable[uid] = banPresets or {}
    CustomNetTables:SetTableValue("service", "player_ban_presets", banPresetsTable)
    logger:Log(string.format("Update NetTables ban presets for user %s finished.", uid))
end