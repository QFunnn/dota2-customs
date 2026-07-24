--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_creep_45"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 10,["21"] = 10,["22"] = 8,["23"] = 16,["24"] = 16,["25"] = 19,["26"] = 19,["27"] = 19,["28"] = 24,["29"] = 24,["30"] = 24,["32"] = 19,["33"] = 23,["34"] = 27,["35"] = 28,["37"] = 33,["38"] = 33,["39"] = 33,["40"] = 33,["41"] = 33,["42"] = 33,["43"] = 33,["44"] = 33,["45"] = 40,["46"] = 44,["47"] = 45,["48"] = 45,["51"] = 50,["52"] = 51,["53"] = 51,["55"] = 54,["56"] = 24});
if IsClient() then
    return
end
function Spawn(self, entityKeyValues)
    if IsClient() then
        return
    end
    thisEntity:GameTimer(
        0.1,
        function()
            __TS__New(AI_Creep_45, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Creep_45 = __TS__Class()
AI_Creep_45.name = "AI_Creep_45"
__TS__ClassExtends(AI_Creep_45, BT_Tree)
function AI_Creep_45.prototype.____constructor(self, hUnit, tData)
    if tData == nil then
        tData = {}
    end
    BT_Tree.prototype.____constructor(self, hUnit, tData)
    self.fInterval = 0.5
    local root = __TS__New(BTC_Selector)
    root.tChildren = {}
    do
        local find = __TS__New(
            BTP_FindUnit,
            700,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
            FIND_CLOSEST
        )
        find:Init(hUnit, tData)
        local atk = __TS__New(BTA_AttackMove, find)
        local ____root_tChildren_0 = root.tChildren
        ____root_tChildren_0[#____root_tChildren_0 + 1] = atk
    end
    do
        local idle = __TS__New(BTA_Idle)
        local ____root_tChildren_1 = root.tChildren
        ____root_tChildren_1[#____root_tChildren_1 + 1] = idle
    end
    self:Init(root)
end