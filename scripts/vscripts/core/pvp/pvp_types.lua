--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


---@class PvpPair
---@field nFirstTeamId integer   # ID первой команды
---@field nSecondeTeamId integer # ID второй команды
---@field nTeamJoinTimes integer # Общее количество участий в PVP
---@field nScore integer

---@class OnEnitityKilledEvent
---@field entindex_killed EntityIndex
---@field entindex_attacker EntityIndex
---@field entindex_inflictor EntityIndex
---@field damagebits integer

---@class Bet
---@field winners integer[]
---@field losers integer[]
---@field value integer