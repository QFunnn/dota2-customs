--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_ability"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["8"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 4,["14"] = 2});
BossAbility = __TS__Class()
BossAbility.name = "BossAbility"
__TS__ClassExtends(BossAbility, BaseAbility)
function BossAbility.prototype.GetCastPoint(self)
    local tKv = KeyValues.AbilitiesKv[self:GetAbilityName()]
    return tKv.AbilityCastPoint
end