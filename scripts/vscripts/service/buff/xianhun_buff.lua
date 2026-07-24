--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "service\\buff\\xianhun_buff"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 7,["16"] = 8,["17"] = 7,["18"] = 10,["19"] = 11,["20"] = 10,["21"] = 13,["22"] = 14,["23"] = 13,["24"] = 2,["25"] = 1,["26"] = 2});
xianhun_buff = __TS__Class()
xianhun_buff.name = "xianhun_buff"
__TS__ClassExtends(xianhun_buff, DiyPolymer)
function xianhun_buff.prototype.OnCreated(self, params)
    self.tAttr = params or ({})
end
function xianhun_buff.prototype.OnRefresh(self, params)
    self.tAttr = params or ({})
end
function xianhun_buff.prototype.RemoveOnDeath(self)
    return false
end
function xianhun_buff.prototype.DDeclareFunctions(self)
    return Attrbutes2DiyFuncsRegData(_G, self.tAttr)
end
xianhun_buff = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    xianhun_buff
)