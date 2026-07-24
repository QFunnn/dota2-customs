--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_7"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["40"] = 37,["41"] = 37,["42"] = 37,["43"] = 37,["44"] = 37,["46"] = 42,["47"] = 43,["48"] = 44,["49"] = 44,["50"] = 44,["51"] = 44,["52"] = 44,["53"] = 44,["54"] = 44,["55"] = 51,["56"] = 52,["57"] = 53,["58"] = 53,["61"] = 57,["62"] = 58,["63"] = 58,["64"] = 58,["65"] = 59,["66"] = 60,["67"] = 61,["68"] = 61,["71"] = 63,["72"] = 58,["73"] = 58,["74"] = 65,["75"] = 66,["76"] = 67,["77"] = 67,["80"] = 72,["81"] = 72,["82"] = 72,["83"] = 73,["84"] = 74,["85"] = 75,["86"] = 75,["87"] = 75,["88"] = 76,["89"] = 77,["90"] = 78,["91"] = 78,["92"] = 78,["93"] = 78,["94"] = 78,["95"] = 78,["96"] = 80,["97"] = 81,["98"] = 82,["99"] = 83,["102"] = 75,["103"] = 75,["104"] = 87,["105"] = 88,["107"] = 90,["108"] = 72,["109"] = 72,["110"] = 92,["111"] = 93,["112"] = 93,["115"] = 98,["116"] = 98,["118"] = 101,["119"] = 30,["120"] = 105,["121"] = 106,["122"] = 105,["123"] = 110,["124"] = 110,["125"] = 110,["126"] = 111,["127"] = 110,["128"] = 113,["129"] = 114,["130"] = 114,["131"] = 114,["132"] = 115,["133"] = 115,["134"] = 115,["135"] = 115,["136"] = 115,["137"] = 115,["138"] = 115,["139"] = 115,["140"] = 115,["141"] = 115,["142"] = 115,["143"] = 126,["144"] = 127,["145"] = 128,["147"] = 130,["148"] = 114,["149"] = 114,["150"] = 132,["151"] = 111,["152"] = 137,["153"] = 137,["154"] = 137,["155"] = 138,["156"] = 137,["157"] = 140,["158"] = 141,["159"] = 141,["160"] = 141,["161"] = 142,["162"] = 142,["163"] = 142,["164"] = 142,["165"] = 142,["166"] = 142,["167"] = 142,["168"] = 142,["169"] = 142,["170"] = 142,["171"] = 142,["172"] = 153,["173"] = 154,["175"] = 156,["176"] = 141,["177"] = 141,["178"] = 158,["179"] = 138,["180"] = 163,["181"] = 163,["182"] = 163,["183"] = 164,["184"] = 163,["185"] = 166,["186"] = 167,["187"] = 167,["188"] = 167,["189"] = 168,["190"] = 168,["191"] = 168,["192"] = 168,["193"] = 168,["194"] = 168,["195"] = 168,["196"] = 168,["197"] = 168,["198"] = 168,["199"] = 168,["200"] = 179,["201"] = 180,["202"] = 181,["204"] = 183,["205"] = 167,["206"] = 167,["207"] = 185,["208"] = 164,["209"] = 189,["210"] = 189,["211"] = 189,["212"] = 190,["213"] = 189,["214"] = 192,["215"] = 193,["216"] = 193,["217"] = 193,["218"] = 194,["219"] = 194,["220"] = 194,["221"] = 194,["222"] = 194,["223"] = 194,["224"] = 194,["225"] = 194,["226"] = 194,["227"] = 194,["228"] = 194,["229"] = 205,["230"] = 206,["231"] = 207,["233"] = 209,["234"] = 193,["235"] = 193,["236"] = 211,["237"] = 190,["238"] = 215,["239"] = 215,["240"] = 215,["241"] = 216,["242"] = 215,["243"] = 218,["244"] = 219,["245"] = 219,["246"] = 219,["247"] = 220,["248"] = 220,["249"] = 220,["250"] = 220,["251"] = 220,["252"] = 220,["253"] = 220,["254"] = 220,["255"] = 220,["256"] = 220,["257"] = 220,["258"] = 231,["259"] = 232,["261"] = 234,["262"] = 219,["263"] = 219,["264"] = 236,["265"] = 216,["266"] = 240,["267"] = 240,["268"] = 240,["269"] = 241,["270"] = 240,["271"] = 241,["272"] = 244,["273"] = 240,["274"] = 246,["275"] = 244,["276"] = 248,["277"] = 240,["278"] = 250,["279"] = 251,["281"] = 253,["283"] = 255,["284"] = 248,["285"] = 257,["286"] = 258,["287"] = 259,["289"] = 240,["290"] = 257});
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
            if thisEntity:FindModifierByName("modifier_boss_spawn") then
                return 0.1
            end
            thisEntity:AddPolymer(thisEntity, nil, "boss_7")
            __TS__New(AI_Boss_7, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_7 = __TS__Class()
AI_Boss_7.name = "AI_Boss_7"
__TS__ClassExtends(AI_Boss_7, BT_Tree)
function AI_Boss_7.prototype.____constructor(self, hUnit, tData)
    if tData == nil then
        tData = {}
    end
    BT_Tree.prototype.____constructor(self, hUnit, tData)
    self.fInterval = 1
    local root = __TS__New(BTC_Selector)
    root.tChildren = {}
    local ____root_tChildren_0 = root.tChildren
    ____root_tChildren_0[#____root_tChildren_0 + 1] = __TS__New(
        AI_Boss_7_6,
        hUnit:FindAbilityByName("boss_7_6")
    )
    do
        local bt = __TS__New(BTC_Random)
        bt.tChildren = {}
        for ____, t in ipairs({
            {"boss_7_1", AI_Boss_7_1},
            {"boss_7_2", AI_Boss_7_2},
            {"boss_7_3", AI_Boss_7_3},
            {"boss_7_4", AI_Boss_7_4},
            {"boss_7_5", AI_Boss_7_5}
        }) do
            local hAblt = hUnit:FindAbilityByName(t[1])
            if IsValid(hAblt) then
                local ____bt_tChildren_1 = bt.tChildren
                ____bt_tChildren_1[#____bt_tChildren_1 + 1] = __TS__New(t[2], hAblt)
            end
        end
        local iAbltInterval = 3
        local bt_checkInterval = __TS__New(
            BT_Precondition,
            function()
                if self.tData.fCastTime ~= nil then
                    local f = GameRules:GetGameTime() - self.tData.fCastTime
                    if f < iAbltInterval then
                        return 0, ("剩余时间" .. tostring(math.floor((3 - f) * 100) / 100)) .. "秒"
                    end
                end
                return 1
            end
        )
        bt_checkInterval.name = "技能释放间隔"
        bt.precondition = bt_checkInterval
        local ____root_tChildren_2 = root.tChildren
        ____root_tChildren_2[#____root_tChildren_2 + 1] = bt
    end
    do
        local btAttack = __TS__New(
            BTA_AttackMove,
            function()
                local fDis
                self.tData.target = nil
                EachPlayer(
                    _G,
                    function(____, iPlayerID)
                        local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                        if IsValid(hHero) and UnitFilter(
                            hHero,
                            DOTA_UNIT_TARGET_TEAM_ENEMY,
                            DOTA_UNIT_TARGET_HERO,
                            DOTA_UNIT_TARGET_FLAG_NONE,
                            self.hUnit:GetTeamNumber()
                        ) == UF_SUCCESS then
                            local fDisCur = (self.hUnit:GetAbsOrigin() - hHero:GetAbsOrigin()):Length2D()
                            if fDis == nil or fDisCur < fDis then
                                fDis = fDisCur
                                self.tData.target = hHero
                            end
                        end
                    end
                )
                if self.tData.target then
                    return 1
                end
                return 0
            end
        )
        btAttack.precondition.name = "攻击最近英雄"
        local ____root_tChildren_3 = root.tChildren
        ____root_tChildren_3[#____root_tChildren_3 + 1] = btAttack
    end
    do
        local ____root_tChildren_4 = root.tChildren
        ____root_tChildren_4[#____root_tChildren_4 + 1] = __TS__New(BTA_Idle)
    end
    self:Init(root)
end
function AI_Boss_7.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
AI_Boss_7_1 = __TS__Class()
AI_Boss_7_1.name = "AI_Boss_7_1"
__TS__ClassExtends(AI_Boss_7_1, BTA_CastAblity)
function AI_Boss_7_1.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                -1,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                self.tData.target_pos = tTargets[1]:GetAbsOrigin()
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "毒爆"
end
AI_Boss_7_2 = __TS__Class()
AI_Boss_7_2.name = "AI_Boss_7_2"
__TS__ClassExtends(AI_Boss_7_2, BTA_CastAblity)
function AI_Boss_7_2.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                -1,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "毒刃"
end
AI_Boss_7_3 = __TS__Class()
AI_Boss_7_3.name = "AI_Boss_7_3"
__TS__ClassExtends(AI_Boss_7_3, BTA_CastAblity)
function AI_Boss_7_3.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                -1,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                self.tData.target_pos = tTargets[1]:GetAbsOrigin()
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "织网"
end
AI_Boss_7_4 = __TS__Class()
AI_Boss_7_4.name = "AI_Boss_7_4"
__TS__ClassExtends(AI_Boss_7_4, BTA_CastAblity)
function AI_Boss_7_4.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                -1,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                self.tData.target_pos = tTargets[1]:GetAbsOrigin()
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "蛛纱"
end
AI_Boss_7_5 = __TS__Class()
AI_Boss_7_5.name = "AI_Boss_7_5"
__TS__ClassExtends(AI_Boss_7_5, BTA_CastAblity)
function AI_Boss_7_5.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                -1,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "生蛋"
end
AI_Boss_7_6 = __TS__Class()
AI_Boss_7_6.name = "AI_Boss_7_6"
__TS__ClassExtends(AI_Boss_7_6, BTA_CastAblity)
function AI_Boss_7_6.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
end
function AI_Boss_7_6.prototype.Init(self, hUnit, tData)
    BTA_CastAblity.prototype.Init(self, hUnit, tData)
    self.hUnit:AddNewModifier(self.hUnit, self.hAblt, "modifier_boss_7_6_ai", {})
end
function AI_Boss_7_6.prototype.Evaluate(self)
    if BTA_CastAblity.prototype.Evaluate(self) > 0 then
        if self.typeResult == 1 or self.hUnit:HasModifier("modifier_boss_7_6_ai") and self.hUnit:GetHealthPercent() <= 50 then
            return 10000
        end
        return 0, "未达到50%血量"
    end
    return 0
end
function AI_Boss_7_6.prototype.OnUpdate(self)
    if self.typeResult == 0 then
        self.hUnit:RemoveModifierByName("modifier_boss_7_6_ai")
    end
    return BTA_CastAblity.prototype.OnUpdate(self)
end