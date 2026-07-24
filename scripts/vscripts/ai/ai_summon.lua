--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_summon"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["6"] = 5,["9"] = 8,["10"] = 9,["13"] = 10,["14"] = 10,["15"] = 10,["16"] = 12,["17"] = 12,["19"] = 15,["20"] = 15,["21"] = 15,["22"] = 15,["23"] = 15,["24"] = 15,["25"] = 15,["26"] = 15,["27"] = 15,["28"] = 15,["29"] = 15,["30"] = 26,["31"] = 27,["33"] = 30,["34"] = 10,["35"] = 10,["36"] = 8});
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
            if thisEntity:IsAttacking() then
                return 0.1
            end
            local hTarget = FindUnitsInRadius(
                thisEntity:GetTeamNumber(),
                thisEntity:GetAbsOrigin(),
                nil,
                -1,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_CLOSEST,
                false
            )[1]
            if IsValid(hTarget) and thisEntity:GetForceAttackTarget() ~= hTarget then
                thisEntity:SetForceAttackTarget(hTarget)
            end
            return 0.1
        end
    )
end