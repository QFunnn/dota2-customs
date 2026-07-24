--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 7,["15"] = 8,["18"] = 7,["19"] = 17,["20"] = 18,["21"] = 17,["22"] = 23,["23"] = 24,["24"] = 25,["25"] = 23,["26"] = 2,["27"] = 1,["28"] = 2});
boss_7 = __TS__Class()
boss_7.name = "boss_7"
__TS__ClassExtends(boss_7, DiyPolymer)
function boss_7.prototype.Precache(self, context)
end
function boss_7.prototype.OnCreated(self)
    if IsServer() then
    else
    end
end
function boss_7.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_ABILITY_EXECUTED] = {source = self:GetParent()}}
end
function boss_7.prototype.OnAbilityExecuted(self, event)
    local bt = BT_Manager:GetUnitBT(self:GetParent())
    bt:UpdateAbltCastTime()
end
boss_7 = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    boss_7
)