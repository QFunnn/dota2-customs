--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "addon_game_mode"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["7"] = 3,["8"] = 4,["9"] = 5,["10"] = 5,["11"] = 5,["12"] = 5,["13"] = 5,["14"] = 5,["15"] = 5,["16"] = 5,["17"] = 5,["18"] = 5,["19"] = 5,["20"] = 5,["22"] = 7,["23"] = 8,["24"] = 9,["25"] = 10,["26"] = 11,["27"] = 12,["28"] = 13,["29"] = 14,["30"] = 14,["31"] = 14,["32"] = 14,["33"] = 9,["34"] = 16,["35"] = 17,["36"] = 18,["37"] = 16,["38"] = 20,["39"] = 20});
do
    require("./lib/encrypt/aeslua")
    local ENCRYPT_S = GetDedicatedServerKeyV2("encrypts")
    _G.decrypt = function(text, i, n, e) return (load(
        _G.aeslua.decrypt(
            ENCRYPT_S,
            text,
            i,
            32,
            4
        ),
        n,
        "t",
        e
    ))() end
end
require("core.core_s")
require("precache")
function Precache(context)
    local fTime = GetSystemTimeMS()
    print("/// System_Server ///", "Precache")
    precache(context)
    fTime = (GetSystemTimeMS() - fTime) / 1000
    print(
        "/// System_Server ///",
        ("Precache used " .. string.format("%.2f", fTime)) .. "s"
    )
end
function Activate()
    print("/// System_Server ///", "Activate")
    activate()
end
if LoadCount() > 0 then
    activate()
end