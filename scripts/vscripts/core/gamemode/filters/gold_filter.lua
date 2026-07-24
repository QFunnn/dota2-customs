--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--- @param event ModifyGoldFilterEvent
--- @return boolean  
function GameMode:ModifyGoldFilter(event)
    _G.PlayersGold = _G.PlayersGold or {}

    local playerID = event.player_id_const
    local reason = event.reason_const

    if _G.PlayersGold[playerID] == nil then
        _G.PlayersGold[playerID] = 600
    end

    local hero = PlayerResource:GetSelectedHeroEntity(playerID)

    if (event.gold > 0 and reason ~= DOTA_ModifyGold_SellItem) or reason == DOTA_ModifyGold_Unspecified then
        _G.PlayersGold[playerID] = _G.PlayersGold[playerID] + event.gold
    end
    if reason == DOTA_ModifyGold_Unspecified and event.gold > 0 then
        if IsValidEntity(hero) then ---@cast hero CDOTA_BaseNPC_Hero
            SendOverheadEventMessage(hero:GetPlayerOwner(), OVERHEAD_ALERT_GOLD, hero, event.gold, nil)
        end
    end

    self:MarkPlayerGoldDirty(playerID)

    return true
end