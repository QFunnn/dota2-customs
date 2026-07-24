--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_8"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 19,["28"] = 19,["29"] = 23,["30"] = 23,["31"] = 23,["32"] = 29,["33"] = 29,["34"] = 29,["36"] = 23,["37"] = 28,["38"] = 32,["39"] = 33,["40"] = 36,["41"] = 36,["42"] = 36,["43"] = 36,["44"] = 36,["46"] = 41,["47"] = 42,["48"] = 43,["49"] = 49,["50"] = 50,["51"] = 51,["52"] = 51,["55"] = 55,["56"] = 56,["57"] = 56,["58"] = 56,["59"] = 57,["60"] = 58,["61"] = 59,["62"] = 59,["65"] = 61,["66"] = 56,["67"] = 56,["68"] = 63,["69"] = 64,["70"] = 65,["71"] = 65,["74"] = 70,["75"] = 70,["76"] = 70,["77"] = 71,["78"] = 72,["79"] = 73,["80"] = 73,["81"] = 73,["82"] = 74,["83"] = 75,["84"] = 76,["85"] = 76,["86"] = 76,["87"] = 76,["88"] = 76,["89"] = 76,["90"] = 78,["91"] = 79,["92"] = 80,["93"] = 81,["96"] = 73,["97"] = 73,["98"] = 85,["99"] = 86,["101"] = 88,["102"] = 70,["103"] = 70,["104"] = 90,["105"] = 91,["106"] = 91,["109"] = 96,["110"] = 96,["112"] = 99,["113"] = 29,["114"] = 104,["115"] = 105,["116"] = 104,["117"] = 108,["118"] = 110,["119"] = 111,["120"] = 23,["121"] = 108,["122"] = 117,["123"] = 117,["124"] = 117,["125"] = 118,["126"] = 117,["127"] = 120,["128"] = 121,["129"] = 121,["130"] = 121,["131"] = 122,["132"] = 122,["133"] = 122,["134"] = 122,["135"] = 122,["136"] = 122,["137"] = 122,["138"] = 122,["139"] = 122,["140"] = 122,["141"] = 122,["142"] = 133,["143"] = 134,["145"] = 136,["146"] = 121,["147"] = 121,["148"] = 138,["149"] = 118,["150"] = 142,["151"] = 142,["152"] = 142,["153"] = 143,["154"] = 142,["155"] = 145,["156"] = 146,["157"] = 146,["158"] = 146,["159"] = 147,["160"] = 147,["161"] = 147,["162"] = 147,["163"] = 147,["164"] = 147,["165"] = 147,["166"] = 147,["167"] = 147,["168"] = 147,["169"] = 147,["170"] = 158,["171"] = 159,["173"] = 161,["174"] = 146,["175"] = 146,["176"] = 163,["177"] = 143,["178"] = 167,["179"] = 167,["180"] = 167,["181"] = 168,["182"] = 167,["183"] = 170,["184"] = 171,["185"] = 171,["186"] = 171,["187"] = 172,["188"] = 172,["189"] = 172,["190"] = 172,["191"] = 172,["192"] = 172,["193"] = 172,["194"] = 172,["195"] = 172,["196"] = 172,["197"] = 172,["198"] = 183,["199"] = 184,["201"] = 186,["202"] = 171,["203"] = 171,["204"] = 188,["205"] = 168,["206"] = 192,["207"] = 192,["208"] = 192,["209"] = 193,["210"] = 192,["211"] = 195,["212"] = 196,["213"] = 196,["214"] = 196,["215"] = 197,["216"] = 197,["217"] = 197,["218"] = 197,["219"] = 197,["220"] = 197,["221"] = 197,["222"] = 197,["223"] = 197,["224"] = 197,["225"] = 197,["226"] = 208,["227"] = 209,["229"] = 211,["230"] = 196,["231"] = 196,["232"] = 213,["233"] = 193,["234"] = 217,["235"] = 217,["236"] = 217,["237"] = 218,["238"] = 217,["239"] = 218,["240"] = 221,["241"] = 217,["242"] = 223,["243"] = 221,["244"] = 225,["245"] = 217,["246"] = 227,["247"] = 228,["249"] = 230,["251"] = 232,["252"] = 225,["253"] = 234,["254"] = 235,["255"] = 236,["256"] = 237,["257"] = 242,["258"] = 243,["259"] = 245,["260"] = 246,["263"] = 217,["264"] = 234});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_8")
            __TS__New(AI_Boss_8, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_8 = __TS__Class()
AI_Boss_8.name = "AI_Boss_8"
__TS__ClassExtends(AI_Boss_8, BT_Tree)
function AI_Boss_8.prototype.____constructor(self, hUnit, tData)
    if tData == nil then
        tData = {}
    end
    BT_Tree.prototype.____constructor(self, hUnit, tData)
    self.fInterval = 1
    local root = __TS__New(BTC_Selector)
    root.tChildren = {}
    local ____root_tChildren_0 = root.tChildren
    ____root_tChildren_0[#____root_tChildren_0 + 1] = __TS__New(
        AI_BOSS_8_5,
        hUnit:FindAbilityByName("boss_8_5")
    )
    do
        local bt = __TS__New(BTC_Random)
        bt.tChildren = {}
        for ____, t in ipairs({{"boss_8_1", AI_BOSS_8_1}, {"boss_8_2", AI_BOSS_8_2}, {"boss_8_3", AI_BOSS_8_3}, {"boss_8_4", AI_BOSS_8_4}}) do
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
function AI_Boss_8.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_8.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_BOSS_8_1 = __TS__Class()
AI_BOSS_8_1.name = "AI_BOSS_8_1"
__TS__ClassExtends(AI_BOSS_8_1, BTA_CastAblity)
function AI_BOSS_8_1.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                hAblt.Values:range(),
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
    self.precondition.name = "魂击"
end
AI_BOSS_8_2 = __TS__Class()
AI_BOSS_8_2.name = "AI_BOSS_8_2"
__TS__ClassExtends(AI_BOSS_8_2, BTA_CastAblity)
function AI_BOSS_8_2.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                hAblt.Values:radius(),
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
    self.precondition.name = "魂灭"
end
AI_BOSS_8_3 = __TS__Class()
AI_BOSS_8_3.name = "AI_BOSS_8_3"
__TS__ClassExtends(AI_BOSS_8_3, BTA_CastAblity)
function AI_BOSS_8_3.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                2000,
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
    self.precondition.name = "魂释"
end
AI_BOSS_8_4 = __TS__Class()
AI_BOSS_8_4.name = "AI_BOSS_8_4"
__TS__ClassExtends(AI_BOSS_8_4, BTA_CastAblity)
function AI_BOSS_8_4.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                2000,
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
    self.precondition.name = "魂影"
end
AI_BOSS_8_5 = __TS__Class()
AI_BOSS_8_5.name = "AI_BOSS_8_5"
__TS__ClassExtends(AI_BOSS_8_5, BTA_CastAblity)
function AI_BOSS_8_5.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
end
function AI_BOSS_8_5.prototype.Init(self, hUnit, tData)
    BTA_CastAblity.prototype.Init(self, hUnit, tData)
    self.hUnit:AddNewModifier(self.hUnit, self.hAblt, "modifier_boss_8_5_ai", {})
end
function AI_BOSS_8_5.prototype.Evaluate(self)
    if BTA_CastAblity.prototype.Evaluate(self) > 0 then
        if self.typeResult == 1 or self.hUnit:HasModifier("modifier_boss_8_5_ai") and self.hUnit:GetHealthPercent() <= 50 then
            return 10000
        end
        return 0, "未达到50%血量"
    end
    return 0
end
function AI_BOSS_8_5.prototype.OnUpdate(self)
    if self.typeResult == 0 then
        self.hUnit:RemoveModifierByName("modifier_boss_8_5_ai")
        self:Execute()
        return 1
    elseif self.typeResult == 1 then
        if self.hUnit:GetCurrentActiveAbility() == self.hAblt then
            return 1
        end
    end
    return BTA_CastAblity.prototype.OnUpdate(self)
end