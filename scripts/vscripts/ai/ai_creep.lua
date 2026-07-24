--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_creep"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["10"] = 4,["13"] = 7,["14"] = 8,["15"] = 8,["16"] = 8,["17"] = 9,["18"] = 8,["19"] = 8,["20"] = 7,["21"] = 14,["22"] = 14,["23"] = 17,["24"] = 17,["25"] = 17,["26"] = 22,["27"] = 22,["28"] = 22,["30"] = 17,["31"] = 21,["32"] = 25,["33"] = 26,["35"] = 31,["36"] = 31,["37"] = 31,["38"] = 31,["39"] = 31,["40"] = 31,["41"] = 31,["42"] = 31,["43"] = 38,["44"] = 41,["46"] = 42,["47"] = 42,["48"] = 43,["49"] = 44,["50"] = 45,["51"] = 46,["52"] = 46,["53"] = 46,["54"] = 46,["55"] = 46,["56"] = 47,["57"] = 47,["58"] = 47,["59"] = 47,["60"] = 48,["61"] = 49,["62"] = 47,["64"] = 52,["65"] = 48,["66"] = 47,["69"] = 42,["72"] = 60,["73"] = 60,["74"] = 63,["75"] = 64,["76"] = 64,["79"] = 104,["80"] = 105,["81"] = 105,["83"] = 108,["84"] = 22});
if IsClient() then
    return
end
function Spawn(self, entityKeyValues)
    thisEntity:GameTimer(
        0.1,
        function()
            __TS__New(AI_Creep, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Creep = __TS__Class()
AI_Creep.name = "AI_Creep"
__TS__ClassExtends(AI_Creep, BT_Tree)
function AI_Creep.prototype.____constructor(self, hUnit, tData)
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
            -1,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
            FIND_CLOSEST
        )
        find:Init(hUnit, tData)
        local fEnableAbltAITime = GameRules:GetGameTime() + RandomFloat(1, 3)
        do
            local i = 0
            while i < hUnit:GetAbilityCount() do
                local hAblt = hUnit:GetAbilityByIndex(i)
                if IsValid(hAblt) and not hAblt:IsHidden() and not hAblt:IsPassive() then
                    local tKv = KeyValues.AbilitiesKv[hAblt:GetAbilityName()]
                    if tKv and __TS__StringSubstring(
                        tostring(tKv.id),
                        0,
                        3
                    ) == "105" then
                        local ____root_tChildren_1 = root.tChildren
                        local ____class_0 = __TS__Class()
                        ____class_0.name = ____class_0.name
                        __TS__ClassExtends(____class_0, BTA_CastAblity)
                        function ____class_0.prototype.Evaluate(self)
                            if GameRules:GetGameTime() > fEnableAbltAITime then
                                return BTA_CastAblity.prototype.Evaluate(self)
                            end
                            return 0
                        end
                        ____root_tChildren_1[#____root_tChildren_1 + 1] = __TS__New(____class_0, hAblt, find)
                    end
                end
                i = i + 1
            end
        end
        local ____root_tChildren_2 = root.tChildren
        ____root_tChildren_2[#____root_tChildren_2 + 1] = __TS__New(BTA_WaitAblityCasting)
        local atk = __TS__New(BTA_AttackMove2, find)
        local ____root_tChildren_3 = root.tChildren
        ____root_tChildren_3[#____root_tChildren_3 + 1] = atk
    end
    do
        local idle = __TS__New(BTA_Idle)
        local ____root_tChildren_4 = root.tChildren
        ____root_tChildren_4[#____root_tChildren_4 + 1] = idle
    end
    self:Init(root)
end