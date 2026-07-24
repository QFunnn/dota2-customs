--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_goblin"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["6"] = 5,["9"] = 8,["10"] = 9,["11"] = 9,["12"] = 9,["13"] = 11,["14"] = 11,["16"] = 13,["17"] = 14,["18"] = 14,["19"] = 14,["20"] = 14,["21"] = 14,["22"] = 19,["23"] = 9,["24"] = 9,["25"] = 8});
if IsClient() then
    return
end
function Spawn(self, entityKeyValues)
    thisEntity:GameTimer(
        0.1,
        function()
            if not thisEntity:IsIdle() then
                return 0.1
            end
            local vEndPos = GS_Main.vMainPos + RandomVector(RandomInt(100, 2000))
            ExecuteOrderFromTable({
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                UnitIndex = thisEntity:entindex(),
                Position = vEndPos
            })
            return 3
        end
    )
end