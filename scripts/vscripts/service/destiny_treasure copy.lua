--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "service\\destiny_treasure copy"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 5,["15"] = 5,["16"] = 6,["17"] = 6,["18"] = 6,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 10,["24"] = 11,["25"] = 12,["26"] = 13,["30"] = 17,["31"] = 18,["32"] = 19,["33"] = 19,["34"] = 19,["35"] = 19,["36"] = 19,["39"] = 5,["40"] = 5,["41"] = 4,["42"] = 25,["43"] = 26,["44"] = 30,["46"] = 31,["47"] = 37,["48"] = 38,["49"] = 38,["52"] = 39,["53"] = 39,["54"] = 40,["55"] = 40,["56"] = 40,["57"] = 40,["58"] = 41,["59"] = 42,["60"] = 43,["61"] = 44,["63"] = 46,["64"] = 46,["65"] = 47,["66"] = 48,["67"] = 49,["69"] = 51,["70"] = 51,["73"] = 39,["79"] = 56,["80"] = 25,["81"] = 3,["82"] = 2,["83"] = 3});
DestinyTreasure = __TS__Class()
DestinyTreasure.name = "DestinyTreasure"
__TS__ClassExtends(DestinyTreasure, Module)
function DestinyTreasure.InitGameplay(self, iPlayCount)
    EachPlayer(
        _G,
        function(____, iPlayerID)
            local tUserDestinyTreasure = NetEventData:GetTableValue(
                "service",
                "UserDestinyTreasure_" .. tostring(iPlayerID)
            ) or ({})
            local tEffect = self:CalcEffect(tUserDestinyTreasure)
            if table.count(tEffect.tAffix) > 0 then
                local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                if IsValid(hHero) then
                    local hBuff = hHero:AddPolymer(hHero, nil, "destiny_treasure_buff", tEffect.tAffix)
                    if hBuff then
                        print((("[DestinyTreasure]: " .. tostring(iPlayerID)) .. " 添加命座宝物buff: ") .. json.encode(tEffect.tAffix))
                    end
                end
            end
            if table.count(tEffect.tPrvg) > 0 then
                for iPrvgId, iValue in pairs(tEffect.tPrvg) do
                    Privilege:AddPrivilege(
                        iPlayerID,
                        tostring(iPrvgId),
                        iValue
                    )
                end
            end
        end
    )
end
function DestinyTreasure.CalcEffect(self, tUserDestinyTreasure)
    local tResult = {tAffix = {}, tPrvg = {}}
    for sId, tUser in pairs(tUserDestinyTreasure) do
        do
            local tDestinyTreasureCfg = _G.destiny_treasure[tostring(sId)]
            local iItemLevel = math.min(tUser.level, tDestinyTreasureCfg.max_level)
            if iItemLevel <= 0 then
                goto __continue10
            end
            do
                local i = 1
                while i <= iItemLevel do
                    local tEffect = Str2RewardMap(
                        _G,
                        tDestinyTreasureCfg["effect_" .. tostring(i)]
                    )
                    for iAttrId, iValue in pairs(tEffect) do
                        if ItemIs(_G, iAttrId, 106) then
                            if tResult.tAffix[iAttrId] == nil then
                                tResult.tAffix[iAttrId] = 0
                            end
                            local ____tResult_tAffix_0, ____iAttrId_1 = tResult.tAffix, iAttrId
                            ____tResult_tAffix_0[____iAttrId_1] = ____tResult_tAffix_0[____iAttrId_1] + iValue
                        elseif ItemIs(_G, iAttrId, 118) then
                            if tResult.tPrvg[iAttrId] == nil then
                                tResult.tPrvg[iAttrId] = 0
                            end
                            local ____tResult_tPrvg_2, ____iAttrId_3 = tResult.tPrvg, iAttrId
                            ____tResult_tPrvg_2[____iAttrId_3] = ____tResult_tPrvg_2[____iAttrId_3] + iValue
                        end
                    end
                    i = i + 1
                end
            end
        end
        ::__continue10::
    end
    return tResult
end
DestinyTreasure = __TS__DecorateLegacy(
    {module(_G)},
    DestinyTreasure
)