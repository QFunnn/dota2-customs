--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 8,["16"] = 9,["18"] = 12,["19"] = 13,["20"] = 14,["21"] = 14,["22"] = 14,["23"] = 14,["24"] = 14,["25"] = 14,["26"] = 14,["27"] = 14,["29"] = 8,["30"] = 18,["31"] = 19,["32"] = 18,["33"] = 24,["34"] = 25,["35"] = 26,["36"] = 24,["37"] = 3,["38"] = 2,["39"] = 3});
boss_6 = __TS__Class()
boss_6.name = "boss_6"
__TS__ClassExtends(boss_6, DiyPolymer)
function boss_6.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/body/body.vpcf", context)
end
function boss_6.prototype.OnCreated(self)
    if IsServer() then
    else
        local hParent = self:GetParent()
        local iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/body/body.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        self:AddParticle(
            iPtclID,
            false,
            false,
            -1,
            false,
            false
        )
    end
end
function boss_6.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_ABILITY_EXECUTED] = {source = self:GetParent()}}
end
function boss_6.prototype.OnAbilityExecuted(self, event)
    local bt = BT_Manager:GetUnitBT(self:GetParent())
    bt:UpdateAbltCastTime()
end
boss_6 = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    boss_6
)