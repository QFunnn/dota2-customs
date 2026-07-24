--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_6"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["40"] = 37,["41"] = 37,["42"] = 37,["43"] = 37,["44"] = 37,["46"] = 42,["47"] = 43,["48"] = 44,["49"] = 44,["50"] = 44,["51"] = 44,["52"] = 44,["53"] = 44,["54"] = 44,["55"] = 44,["56"] = 52,["57"] = 53,["58"] = 54,["59"] = 54,["62"] = 58,["63"] = 59,["64"] = 59,["65"] = 59,["66"] = 60,["67"] = 61,["68"] = 62,["69"] = 62,["72"] = 64,["73"] = 59,["74"] = 59,["75"] = 66,["76"] = 69,["77"] = 70,["78"] = 71,["79"] = 72,["80"] = 73,["81"] = 73,["82"] = 73,["83"] = 73,["84"] = 74,["85"] = 74,["87"] = 76,["88"] = 77,["89"] = 77,["93"] = 83,["94"] = 83,["95"] = 83,["96"] = 84,["97"] = 85,["98"] = 86,["99"] = 86,["100"] = 86,["101"] = 87,["102"] = 88,["103"] = 89,["104"] = 89,["105"] = 89,["106"] = 89,["107"] = 89,["108"] = 89,["109"] = 91,["110"] = 92,["111"] = 93,["112"] = 94,["115"] = 86,["116"] = 86,["117"] = 98,["118"] = 99,["120"] = 101,["121"] = 83,["122"] = 83,["123"] = 103,["124"] = 104,["125"] = 104,["128"] = 109,["129"] = 109,["131"] = 112,["132"] = 30,["133"] = 116,["134"] = 117,["135"] = 116,["136"] = 120,["137"] = 122,["138"] = 123,["139"] = 24,["140"] = 120,["141"] = 130,["142"] = 130,["143"] = 130,["144"] = 131,["145"] = 130,["146"] = 133,["147"] = 134,["148"] = 134,["149"] = 134,["150"] = 135,["151"] = 136,["152"] = 137,["153"] = 137,["154"] = 137,["155"] = 137,["156"] = 137,["157"] = 137,["158"] = 137,["159"] = 137,["160"] = 137,["161"] = 137,["162"] = 137,["163"] = 144,["164"] = 145,["165"] = 146,["167"] = 148,["168"] = 134,["169"] = 134,["170"] = 150,["171"] = 131,["172"] = 155,["173"] = 155,["174"] = 155,["175"] = 156,["176"] = 155,["177"] = 158,["178"] = 159,["179"] = 159,["180"] = 159,["181"] = 160,["182"] = 161,["183"] = 162,["184"] = 162,["185"] = 162,["186"] = 162,["187"] = 162,["188"] = 162,["189"] = 162,["190"] = 162,["191"] = 162,["192"] = 162,["193"] = 162,["194"] = 169,["195"] = 170,["196"] = 171,["198"] = 173,["199"] = 159,["200"] = 159,["201"] = 175,["202"] = 156,["203"] = 180,["204"] = 180,["205"] = 180,["206"] = 181,["207"] = 180,["208"] = 183,["209"] = 184,["210"] = 184,["211"] = 184,["212"] = 185,["213"] = 186,["214"] = 186,["215"] = 186,["216"] = 186,["217"] = 186,["218"] = 186,["219"] = 186,["220"] = 186,["221"] = 186,["222"] = 186,["223"] = 186,["224"] = 193,["225"] = 194,["227"] = 196,["228"] = 184,["229"] = 184,["230"] = 198,["231"] = 181,["232"] = 203,["233"] = 203,["234"] = 203,["235"] = 204,["236"] = 203,["237"] = 206,["238"] = 207,["239"] = 207,["240"] = 207,["241"] = 209,["242"] = 210,["243"] = 210,["244"] = 210,["245"] = 211,["246"] = 212,["247"] = 213,["248"] = 214,["250"] = 210,["251"] = 210,["252"] = 217,["253"] = 217,["255"] = 218,["256"] = 207,["257"] = 207,["258"] = 220,["259"] = 204,["260"] = 225,["261"] = 225,["262"] = 225,["263"] = 226,["264"] = 225,["265"] = 228,["266"] = 229,["267"] = 229,["268"] = 229,["269"] = 231,["270"] = 232,["271"] = 232,["272"] = 232,["273"] = 233,["274"] = 234,["275"] = 235,["276"] = 236,["277"] = 237,["279"] = 232,["280"] = 232,["281"] = 240,["282"] = 240,["284"] = 241,["285"] = 229,["286"] = 229,["287"] = 243,["288"] = 226,["289"] = 248,["290"] = 248,["291"] = 248,["292"] = 249,["293"] = 248,["294"] = 251,["295"] = 252,["296"] = 252,["297"] = 252,["298"] = 254,["299"] = 255,["300"] = 255,["301"] = 255,["302"] = 256,["303"] = 257,["304"] = 258,["305"] = 259,["307"] = 255,["308"] = 255,["309"] = 262,["310"] = 262,["312"] = 263,["313"] = 264,["314"] = 264,["316"] = 265,["317"] = 266,["318"] = 266,["320"] = 267,["321"] = 252,["322"] = 252,["323"] = 269,["324"] = 249,["325"] = 274,["326"] = 274,["327"] = 274,["328"] = 275,["329"] = 274,["330"] = 277,["331"] = 278,["332"] = 278,["333"] = 278,["334"] = 278,["335"] = 278,["336"] = 278,["337"] = 278,["338"] = 278,["339"] = 278,["340"] = 278,["341"] = 279,["342"] = 280,["343"] = 281,["344"] = 281,["346"] = 282,["347"] = 279,["348"] = 284,["349"] = 275,["350"] = 289,["351"] = 289,["352"] = 289,["353"] = 290,["354"] = 289,["355"] = 290,["356"] = 294,["357"] = 289,["358"] = 296,["359"] = 297,["360"] = 298,["361"] = 299,["362"] = 300,["363"] = 301,["364"] = 302,["367"] = 294,["368"] = 307,["369"] = 289,["370"] = 309,["371"] = 310,["373"] = 312,["375"] = 314,["376"] = 307,["377"] = 317,["378"] = 318,["379"] = 319,["380"] = 320,["381"] = 321,["383"] = 289,["384"] = 317,["385"] = 328,["386"] = 329,["387"] = 328});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_6")
            __TS__New(AI_Boss_6, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_6 = __TS__Class()
AI_Boss_6.name = "AI_Boss_6"
__TS__ClassExtends(AI_Boss_6, BT_Tree)
function AI_Boss_6.prototype.____constructor(self, hUnit, tData)
    if tData == nil then
        tData = {}
    end
    BT_Tree.prototype.____constructor(self, hUnit, tData)
    self.fInterval = 1
    local root = __TS__New(BTC_Selector)
    root.tChildren = {}
    local ____root_tChildren_0 = root.tChildren
    ____root_tChildren_0[#____root_tChildren_0 + 1] = __TS__New(
        AI_Boss_6_8,
        hUnit:FindAbilityByName("boss_6_8")
    )
    do
        local bt = __TS__New(BTC_Random)
        bt.tChildren = {}
        for ____, t in ipairs({
            {"boss_6_1", AI_Boss_6_1},
            {"boss_6_2", AI_Boss_6_2},
            {"boss_6_3", AI_Boss_6_3},
            {"boss_6_4", AI_Boss_6_4},
            {"boss_6_6", AI_Boss_6_6},
            {"boss_6_7", AI_Boss_6_7}
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
        local hAblt5 = hUnit:FindAbilityByName("boss_6_5")
        if hAblt5 then
            local bt2 = __TS__New(BTC_Selector)
            bt2.precondition = bt_checkInterval
            bt2.tChildren = {
                bt,
                __TS__New(AI_Boss_6_5, hAblt5)
            }
            local ____root_tChildren_2 = root.tChildren
            ____root_tChildren_2[#____root_tChildren_2 + 1] = bt2
        else
            bt.precondition = bt_checkInterval
            local ____root_tChildren_3 = root.tChildren
            ____root_tChildren_3[#____root_tChildren_3 + 1] = bt
        end
    end
    do
        local btMove = __TS__New(
            BTA_Move,
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
        btMove.precondition.name = "寻找最近英雄"
        local ____root_tChildren_4 = root.tChildren
        ____root_tChildren_4[#____root_tChildren_4 + 1] = btMove
    end
    do
        local ____root_tChildren_5 = root.tChildren
        ____root_tChildren_5[#____root_tChildren_5 + 1] = __TS__New(BTA_Idle)
    end
    self:Init(root)
end
function AI_Boss_6.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_6.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_Boss_6_1 = __TS__Class()
AI_Boss_6_1.name = "AI_Boss_6_1"
__TS__ClassExtends(AI_Boss_6_1, BTA_CastAblity)
function AI_Boss_6_1.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local fRange = hAblt.Values:range()
            local vTarget = self.hUnit:GetAbsOrigin() + self.hUnit:GetForwardVector() * fRange
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                vTarget,
                nil,
                fRange,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                self.tData.target_pos = vTarget
                return iWeight * (#tTargets + 4)
            end
            return 0
        end
    )
    self.precondition.name = "扑击寻敌"
end
AI_Boss_6_2 = __TS__Class()
AI_Boss_6_2.name = "AI_Boss_6_2"
__TS__ClassExtends(AI_Boss_6_2, BTA_CastAblity)
function AI_Boss_6_2.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local fRange = hAblt.Values:range()
            local vTarget = self.hUnit:GetAbsOrigin() - self.hUnit:GetForwardVector() * fRange
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                vTarget,
                nil,
                fRange,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                self.tData.target_pos = self.hUnit:GetAbsOrigin() + self.hUnit:GetForwardVector() * fRange
                return iWeight * (#tTargets + 4)
            end
            return 0
        end
    )
    self.precondition.name = "扫尾寻敌"
end
AI_Boss_6_3 = __TS__Class()
AI_Boss_6_3.name = "AI_Boss_6_3"
__TS__ClassExtends(AI_Boss_6_3, BTA_CastAblity)
function AI_Boss_6_3.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local fRange = hAblt.Values:range()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                fRange,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                return iWeight * (#tTargets + 1)
            end
            return 0
        end
    )
    self.precondition.name = "旋转寻敌"
end
AI_Boss_6_4 = __TS__Class()
AI_Boss_6_4.name = "AI_Boss_6_4"
__TS__ClassExtends(AI_Boss_6_4, BTA_CastAblity)
function AI_Boss_6_4.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local b = false
            EachPlayer(
                _G,
                function(____, iPlayerID)
                    local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                    if hHero ~= nil and hHero:IsAlive() then
                        b = true
                        return true
                    end
                end
            )
            if b then
                return math.floor(iWeight / (table.count(hAblt.tMeteors) + 1))
            end
            return 0
        end
    )
    self.precondition.name = "陨石寻敌-任意英雄"
end
AI_Boss_6_5 = __TS__Class()
AI_Boss_6_5.name = "AI_Boss_6_5"
__TS__ClassExtends(AI_Boss_6_5, BTA_CastAblity)
function AI_Boss_6_5.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local b = false
            EachPlayer(
                _G,
                function(____, iPlayerID)
                    local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                    if hHero ~= nil and hHero:IsAlive() then
                        b = true
                        self.tData.target = hHero
                        return true
                    end
                end
            )
            if b then
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "冲锋寻敌-任意英雄"
end
AI_Boss_6_6 = __TS__Class()
AI_Boss_6_6.name = "AI_Boss_6_6"
__TS__ClassExtends(AI_Boss_6_6, BTA_CastAblity)
function AI_Boss_6_6.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local b = false
            EachPlayer(
                _G,
                function(____, iPlayerID)
                    local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                    if hHero ~= nil and hHero:IsAlive() then
                        b = true
                        return true
                    end
                end
            )
            if not b then
                return 0
            end
            local hAblt4 = self.hUnit:FindAbilityByName("boss_6_4")
            if not IsValid(hAblt4) then
                return 0, "没有陨石技能"
            end
            local iCount = table.count(hAblt4.tMeteors)
            if iCount <= 0 then
                return 0, "没有陨石"
            end
            return iWeight * iCount
        end
    )
    self.precondition.name = "旋风寻敌-任意英雄"
end
AI_Boss_6_7 = __TS__Class()
AI_Boss_6_7.name = "AI_Boss_6_7"
__TS__ClassExtends(AI_Boss_6_7, BTA_CastAblity)
function AI_Boss_6_7.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BTP_FindPoint_LinearDense,
        hAblt.Values:width(),
        hAblt.Values:width(),
        hAblt.Values:distance(),
        hAblt:GetAbilityTargetTeam(),
        hAblt:GetAbilityTargetType(),
        hAblt:GetAbilityTargetFlags(),
        FIND_ANY_ORDER
    )
    self.precondition.Evaluate = function(self)
        local i = BTP_FindPoint_LinearDense.prototype.Evaluate(self)
        if i > 0 then
            return iWeight
        end
        return 0
    end
    self.precondition.name = "怒击寻敌"
end
AI_Boss_6_8 = __TS__Class()
AI_Boss_6_8.name = "AI_Boss_6_8"
__TS__ClassExtends(AI_Boss_6_8, BTA_CastAblity)
function AI_Boss_6_8.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
end
function AI_Boss_6_8.prototype.Init(self, hUnit, tData)
    BTA_CastAblity.prototype.Init(self, hUnit, tData)
    self.hUnit:AddNewModifier(self.hUnit, self.hAblt, "modifier_boss_6_8_ai", {})
    local hAblt4 = self.hUnit:FindAbilityByName("boss_6_4")
    if hAblt4 == nil then
        hAblt4 = self.hUnit:AddAbility("boss_6_4")
        if hAblt4 then
            hAblt4:SetLevel(1)
            hAblt4:SetHidden(true)
        end
    end
end
function AI_Boss_6_8.prototype.Evaluate(self)
    if BTA_CastAblity.prototype.Evaluate(self) > 0 then
        if self.typeResult == 1 or self.hUnit:HasModifier("modifier_boss_6_8_ai") and self.hUnit:GetHealthPercent() <= 50 then
            return 10000
        end
        return 0, "未达到50%血量"
    end
    return 0
end
function AI_Boss_6_8.prototype.OnUpdate(self)
    if self.typeResult == 0 then
        self.hUnit:RemoveModifierByName("modifier_boss_6_8_ai")
        self.hUnit:AddNewModifier(self.hUnit, self.hAblt, "modifier_boss_6_8_casting", {})
        self.hUnit:SetForwardVector(Vector(-1, -1, 0))
    end
    return BTA_CastAblity.prototype.OnUpdate(self)
end
function AI_Boss_6_8.prototype.Clear(self)
    self.hUnit:RemoveModifierByName("modifier_boss_6_8_casting")
end