--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_4\\boss_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 3,["14"] = 6,["15"] = 6,["16"] = 9,["17"] = 10,["18"] = 10,["19"] = 10,["20"] = 10,["21"] = 9,["22"] = 16,["23"] = 17,["24"] = 18,["25"] = 16,["26"] = 20,["27"] = 21,["28"] = 21,["29"] = 21,["30"] = 21,["31"] = 22,["32"] = 23,["34"] = 20,["35"] = 2,["36"] = 1,["37"] = 2});
boss_4 = __TS__Class()
boss_4.name = "boss_4"
__TS__ClassExtends(boss_4, DiyPolymer)
function boss_4.prototype.Precache(self, context)
end
function boss_4.prototype.OnCreated(self)
end
function boss_4.prototype.DDeclareFunctions(self)
    return {
        [MODIFIER_EVENT_ON_ABILITY_EXECUTED] = {source = self:GetParent()},
        [MODIFIER_EVENT_ON_ABILITY_END_CHANNEL] = {source = self:GetParent()}
    }
end
function boss_4.prototype.OnAbilityEndChannel(self, event)
    local bt = BT_Manager:GetUnitBT(self:GetParent())
    bt:UpdateAbltCastTime()
end
function boss_4.prototype.OnAbilityExecuted(self, event)
    if bit.band(
        event.ability:GetBehaviorInt(),
        DOTA_ABILITY_BEHAVIOR_CHANNELLED
    ) ~= DOTA_ABILITY_BEHAVIOR_CHANNELLED then
        local bt = BT_Manager:GetUnitBT(self:GetParent())
        bt:UpdateAbltCastTime()
    end
end
boss_4 = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    boss_4
)