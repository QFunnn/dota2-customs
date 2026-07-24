--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["41"] = 42,["42"] = 43,["43"] = 44,["44"] = 48,["45"] = 49,["46"] = 50,["47"] = 50,["50"] = 54,["51"] = 55,["52"] = 55,["53"] = 55,["54"] = 56,["55"] = 57,["56"] = 58,["57"] = 58,["60"] = 60,["61"] = 55,["62"] = 55,["63"] = 62,["64"] = 63,["65"] = 64,["66"] = 64,["69"] = 69,["70"] = 69,["71"] = 69,["72"] = 70,["73"] = 71,["74"] = 72,["75"] = 72,["76"] = 72,["77"] = 73,["78"] = 74,["79"] = 75,["80"] = 75,["81"] = 75,["82"] = 75,["83"] = 75,["84"] = 75,["85"] = 77,["86"] = 78,["87"] = 79,["88"] = 80,["91"] = 72,["92"] = 72,["93"] = 84,["94"] = 85,["96"] = 87,["97"] = 69,["98"] = 69,["99"] = 89,["100"] = 90,["101"] = 90,["104"] = 95,["105"] = 95,["107"] = 98,["108"] = 30,["109"] = 102,["110"] = 103,["111"] = 102,["112"] = 106,["113"] = 108,["114"] = 109,["115"] = 24,["116"] = 106,["117"] = 116,["118"] = 116,["119"] = 116,["120"] = 117,["121"] = 116,["122"] = 119,["123"] = 120,["124"] = 120,["125"] = 120,["126"] = 121,["127"] = 121,["128"] = 121,["129"] = 121,["130"] = 121,["131"] = 121,["132"] = 121,["133"] = 121,["134"] = 121,["135"] = 121,["136"] = 121,["137"] = 132,["138"] = 133,["139"] = 134,["141"] = 136,["142"] = 120,["143"] = 120,["144"] = 138,["145"] = 117,["146"] = 143,["147"] = 143,["148"] = 143,["149"] = 144,["150"] = 143,["151"] = 146,["152"] = 147,["153"] = 147,["154"] = 147,["155"] = 148,["156"] = 148,["157"] = 148,["158"] = 148,["159"] = 148,["160"] = 148,["161"] = 148,["162"] = 148,["163"] = 148,["164"] = 148,["165"] = 148,["166"] = 159,["167"] = 160,["168"] = 161,["170"] = 163,["171"] = 147,["172"] = 147,["173"] = 165,["174"] = 144});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_3")
            __TS__New(AI_Boss_3, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_3 = __TS__Class()
AI_Boss_3.name = "AI_Boss_3"
__TS__ClassExtends(AI_Boss_3, BT_Tree)
function AI_Boss_3.prototype.____constructor(self, hUnit, tData)
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
        for ____, t in ipairs({{"boss_3_1", AI_BOSS_3_1}, {"boss_3_2", AI_BOSS_3_2}}) do
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
function AI_Boss_3.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_3.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_BOSS_3_1 = __TS__Class()
AI_BOSS_3_1.name = "AI_BOSS_3_1"
__TS__ClassExtends(AI_BOSS_3_1, BTA_CastAblity)
function AI_BOSS_3_1.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "踩踏"
end
AI_BOSS_3_2 = __TS__Class()
AI_BOSS_3_2.name = "AI_BOSS_3_2"
__TS__ClassExtends(AI_BOSS_3_2, BTA_CastAblity)
function AI_BOSS_3_2.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "冲击"
end