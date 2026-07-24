--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_5"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["40"] = 37,["41"] = 37,["42"] = 37,["43"] = 37,["44"] = 37,["46"] = 42,["47"] = 43,["48"] = 44,["49"] = 50,["50"] = 51,["51"] = 52,["52"] = 52,["55"] = 56,["56"] = 57,["57"] = 57,["58"] = 57,["59"] = 58,["60"] = 59,["61"] = 60,["62"] = 60,["65"] = 62,["66"] = 57,["67"] = 57,["68"] = 64,["69"] = 65,["70"] = 66,["71"] = 66,["74"] = 71,["75"] = 71,["76"] = 71,["77"] = 72,["78"] = 73,["79"] = 74,["80"] = 74,["81"] = 74,["82"] = 75,["83"] = 76,["84"] = 77,["85"] = 77,["86"] = 77,["87"] = 77,["88"] = 77,["89"] = 77,["90"] = 79,["91"] = 80,["92"] = 81,["93"] = 82,["96"] = 74,["97"] = 74,["98"] = 86,["99"] = 87,["101"] = 89,["102"] = 71,["103"] = 71,["104"] = 91,["105"] = 92,["106"] = 92,["109"] = 97,["110"] = 97,["112"] = 100,["113"] = 30,["114"] = 104,["115"] = 105,["116"] = 104,["117"] = 108,["118"] = 110,["119"] = 111,["120"] = 24,["121"] = 108,["122"] = 117,["123"] = 117,["124"] = 117,["125"] = 118,["126"] = 117,["127"] = 120,["128"] = 121,["129"] = 121,["130"] = 121,["131"] = 122,["132"] = 122,["133"] = 122,["134"] = 122,["135"] = 122,["136"] = 122,["137"] = 122,["138"] = 122,["139"] = 122,["140"] = 122,["141"] = 122,["142"] = 133,["143"] = 134,["144"] = 135,["146"] = 137,["147"] = 121,["148"] = 121,["149"] = 139,["150"] = 118,["151"] = 143,["152"] = 143,["153"] = 143,["154"] = 144,["155"] = 143,["156"] = 146,["157"] = 147,["158"] = 147,["159"] = 147,["160"] = 148,["161"] = 148,["162"] = 148,["163"] = 148,["164"] = 148,["165"] = 148,["166"] = 148,["167"] = 148,["168"] = 148,["169"] = 148,["170"] = 148,["171"] = 159,["172"] = 160,["174"] = 162,["175"] = 147,["176"] = 147,["177"] = 164,["178"] = 144,["179"] = 168,["180"] = 168,["181"] = 168,["182"] = 169,["183"] = 168,["184"] = 171,["185"] = 172,["186"] = 172,["187"] = 172,["188"] = 173,["189"] = 173,["190"] = 173,["191"] = 173,["192"] = 173,["193"] = 173,["194"] = 173,["195"] = 173,["196"] = 173,["197"] = 173,["198"] = 173,["199"] = 184,["200"] = 185,["202"] = 187,["203"] = 172,["204"] = 172,["205"] = 189,["206"] = 169,["207"] = 191,["208"] = 168,["209"] = 193,["210"] = 191,["211"] = 195,["212"] = 196,["213"] = 197,["214"] = 198,["215"] = 199,["216"] = 201,["217"] = 202,["220"] = 205,["221"] = 195,["222"] = 209,["223"] = 209,["224"] = 209,["225"] = 210,["226"] = 209,["227"] = 212,["228"] = 213,["229"] = 213,["230"] = 213,["231"] = 214,["232"] = 214,["233"] = 214,["234"] = 214,["235"] = 214,["236"] = 214,["237"] = 214,["238"] = 214,["239"] = 214,["240"] = 214,["241"] = 214,["242"] = 225,["243"] = 226,["245"] = 228,["246"] = 213,["247"] = 213,["248"] = 230,["249"] = 210,["250"] = 234,["251"] = 234,["252"] = 234,["253"] = 235,["254"] = 234,["255"] = 235,["256"] = 238,["257"] = 234,["258"] = 240,["259"] = 238,["260"] = 242,["261"] = 234,["262"] = 244,["263"] = 245,["265"] = 247,["267"] = 249,["268"] = 242,["269"] = 251,["270"] = 252,["271"] = 253,["273"] = 234,["274"] = 251});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_5")
            __TS__New(AI_Boss_5, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_5 = __TS__Class()
AI_Boss_5.name = "AI_Boss_5"
__TS__ClassExtends(AI_Boss_5, BT_Tree)
function AI_Boss_5.prototype.____constructor(self, hUnit, tData)
    if tData == nil then
        tData = {}
    end
    BT_Tree.prototype.____constructor(self, hUnit, tData)
    self.fInterval = 1
    local root = __TS__New(BTC_Selector)
    root.tChildren = {}
    local ____root_tChildren_0 = root.tChildren
    ____root_tChildren_0[#____root_tChildren_0 + 1] = __TS__New(
        AI_BOSS_5_6,
        hUnit:FindAbilityByName("boss_5_6")
    )
    do
        local bt = __TS__New(BTC_Random)
        bt.tChildren = {}
        for ____, t in ipairs({{"boss_5_2", AI_BOSS_5_2}, {"boss_5_3", AI_BOSS_5_3}, {"boss_5_4", AI_BOSS_5_4}, {"boss_5_5", AI_BOSS_5_5}}) do
            local hAblt = hUnit:FindAbilityByName(t[1])
            if IsValid(hAblt) then
                local ____bt_tChildren_1 = bt.tChildren
                ____bt_tChildren_1[#____bt_tChildren_1 + 1] = __TS__New(t[2], hAblt)
            end
        end
        local iAbltInterval = RandomInt(7, 10)
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
function AI_Boss_5.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_5.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_BOSS_5_2 = __TS__Class()
AI_BOSS_5_2.name = "AI_BOSS_5_2"
__TS__ClassExtends(AI_BOSS_5_2, BTA_CastAblity)
function AI_BOSS_5_2.prototype.____constructor(self, hAblt)
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
                self.tData.target_pos = tTargets[1]:GetAbsOrigin()
                return iWeight
            end
            return 0
        end
    )
    self.precondition.name = "炽焰"
end
AI_BOSS_5_3 = __TS__Class()
AI_BOSS_5_3.name = "AI_BOSS_5_3"
__TS__ClassExtends(AI_BOSS_5_3, BTA_CastAblity)
function AI_BOSS_5_3.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "炽羽"
end
AI_BOSS_5_4 = __TS__Class()
AI_BOSS_5_4.name = "AI_BOSS_5_4"
__TS__ClassExtends(AI_BOSS_5_4, BTA_CastAblity)
function AI_BOSS_5_4.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "炽灭"
end
function AI_BOSS_5_4.prototype.Evaluate(self)
    local i = BTA_CastAblity.prototype.Evaluate(self)
    return i
end
function AI_BOSS_5_4.prototype.OnUpdate(self)
    if self.typeResult == 0 then
        self:Execute()
        return 1
    elseif self.typeResult == 1 then
        if self.hUnit:GetCurrentActiveAbility() == self.hAblt then
            return 1
        end
    end
    return 2
end
AI_BOSS_5_5 = __TS__Class()
AI_BOSS_5_5.name = "AI_BOSS_5_5"
__TS__ClassExtends(AI_BOSS_5_5, BTA_CastAblity)
function AI_BOSS_5_5.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "炽凰"
end
AI_BOSS_5_6 = __TS__Class()
AI_BOSS_5_6.name = "AI_BOSS_5_6"
__TS__ClassExtends(AI_BOSS_5_6, BTA_CastAblity)
function AI_BOSS_5_6.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
end
function AI_BOSS_5_6.prototype.Init(self, hUnit, tData)
    BTA_CastAblity.prototype.Init(self, hUnit, tData)
    self.hUnit:AddNewModifier(self.hUnit, self.hAblt, "modifier_boss_5_6_ai", {})
end
function AI_BOSS_5_6.prototype.Evaluate(self)
    if BTA_CastAblity.prototype.Evaluate(self) > 0 then
        if self.typeResult == 1 or self.hUnit:HasModifier("modifier_boss_5_6_ai") and self.hUnit:GetHealthPercent() <= 50 then
            return 10000
        end
        return 0, "未达到50%血量"
    end
    return 0
end
function AI_BOSS_5_6.prototype.OnUpdate(self)
    if self.typeResult == 0 then
        self.hUnit:RemoveModifierByName("modifier_boss_5_6_ai")
    end
    return BTA_CastAblity.prototype.OnUpdate(self)
end