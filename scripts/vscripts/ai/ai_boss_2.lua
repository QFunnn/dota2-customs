--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["41"] = 42,["42"] = 43,["43"] = 44,["44"] = 49,["45"] = 50,["46"] = 51,["47"] = 51,["50"] = 55,["51"] = 56,["52"] = 56,["53"] = 56,["54"] = 57,["55"] = 58,["56"] = 59,["57"] = 59,["60"] = 61,["61"] = 56,["62"] = 56,["63"] = 63,["64"] = 64,["65"] = 65,["66"] = 65,["69"] = 70,["70"] = 70,["71"] = 70,["72"] = 71,["73"] = 72,["74"] = 73,["75"] = 73,["76"] = 73,["77"] = 74,["78"] = 75,["79"] = 76,["80"] = 76,["81"] = 76,["82"] = 76,["83"] = 76,["84"] = 76,["85"] = 78,["86"] = 79,["87"] = 80,["88"] = 81,["91"] = 73,["92"] = 73,["93"] = 85,["94"] = 86,["96"] = 88,["97"] = 70,["98"] = 70,["99"] = 90,["100"] = 91,["101"] = 91,["104"] = 96,["105"] = 96,["107"] = 99,["108"] = 30,["109"] = 103,["110"] = 104,["111"] = 103,["112"] = 107,["113"] = 109,["114"] = 110,["115"] = 24,["116"] = 107,["117"] = 116,["118"] = 116,["119"] = 116,["120"] = 117,["121"] = 116,["122"] = 119,["123"] = 120,["124"] = 120,["125"] = 120,["126"] = 121,["127"] = 121,["128"] = 121,["129"] = 121,["130"] = 121,["131"] = 121,["132"] = 121,["133"] = 121,["134"] = 121,["135"] = 121,["136"] = 121,["137"] = 132,["138"] = 133,["139"] = 134,["141"] = 136,["142"] = 120,["143"] = 120,["144"] = 138,["145"] = 117,["146"] = 142,["147"] = 142,["148"] = 142,["149"] = 143,["150"] = 142,["151"] = 145,["152"] = 146,["153"] = 146,["154"] = 146,["155"] = 147,["156"] = 147,["157"] = 147,["158"] = 147,["159"] = 147,["160"] = 147,["161"] = 147,["162"] = 147,["163"] = 147,["164"] = 147,["165"] = 147,["166"] = 158,["167"] = 159,["168"] = 160,["170"] = 162,["171"] = 146,["172"] = 146,["173"] = 164,["174"] = 143,["175"] = 168,["176"] = 168,["177"] = 168,["178"] = 169,["179"] = 168,["180"] = 171,["181"] = 172,["182"] = 172,["183"] = 172,["184"] = 173,["185"] = 173,["186"] = 173,["187"] = 173,["188"] = 173,["189"] = 173,["190"] = 173,["191"] = 173,["192"] = 173,["193"] = 173,["194"] = 173,["195"] = 184,["196"] = 185,["198"] = 187,["199"] = 172,["200"] = 172,["201"] = 189,["202"] = 169});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_2")
            __TS__New(AI_Boss_2, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_2 = __TS__Class()
AI_Boss_2.name = "AI_Boss_2"
__TS__ClassExtends(AI_Boss_2, BT_Tree)
function AI_Boss_2.prototype.____constructor(self, hUnit, tData)
    if tData == nil then
        tData = {}
    end
    BT_Tree.prototype.____constructor(self, hUnit, tData)
    self.fInterval = 1
    local root = __TS__New(BTC_Selector)
    root.tChildren = {}
    do
        local bt = __TS__New(BTC_Random)
        bt.tChildren = {}
        for ____, t in ipairs({{"boss_2_1", AI_BOSS_2_1}, {"boss_2_2", AI_BOSS_2_2}, {"boss_2_3", AI_BOSS_2_3}}) do
            local hAblt = hUnit:FindAbilityByName(t[1])
            if IsValid(hAblt) then
                local ____bt_tChildren_0 = bt.tChildren
                ____bt_tChildren_0[#____bt_tChildren_0 + 1] = __TS__New(t[2], hAblt)
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
        local ____root_tChildren_1 = root.tChildren
        ____root_tChildren_1[#____root_tChildren_1 + 1] = bt
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
        local ____root_tChildren_2 = root.tChildren
        ____root_tChildren_2[#____root_tChildren_2 + 1] = btAttack
    end
    do
        local ____root_tChildren_3 = root.tChildren
        ____root_tChildren_3[#____root_tChildren_3 + 1] = __TS__New(BTA_Idle)
    end
    self:Init(root)
end
function AI_Boss_2.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_2.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_BOSS_2_1 = __TS__Class()
AI_BOSS_2_1.name = "AI_BOSS_2_1"
__TS__ClassExtends(AI_BOSS_2_1, BTA_CastAblity)
function AI_BOSS_2_1.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "震击大地"
end
AI_BOSS_2_2 = __TS__Class()
AI_BOSS_2_2.name = "AI_BOSS_2_2"
__TS__ClassExtends(AI_BOSS_2_2, BTA_CastAblity)
function AI_BOSS_2_2.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                450,
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
    self.precondition.name = "抓取"
end
AI_BOSS_2_3 = __TS__Class()
AI_BOSS_2_3.name = "AI_BOSS_2_3"
__TS__ClassExtends(AI_BOSS_2_3, BTA_CastAblity)
function AI_BOSS_2_3.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "山崩"
end