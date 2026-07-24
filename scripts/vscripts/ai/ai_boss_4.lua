--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["41"] = 42,["42"] = 43,["43"] = 44,["44"] = 50,["45"] = 51,["46"] = 52,["47"] = 52,["50"] = 56,["51"] = 57,["52"] = 57,["53"] = 57,["54"] = 58,["55"] = 59,["56"] = 60,["57"] = 60,["60"] = 62,["61"] = 57,["62"] = 57,["63"] = 64,["64"] = 65,["65"] = 66,["66"] = 66,["69"] = 71,["70"] = 71,["71"] = 71,["72"] = 72,["73"] = 73,["74"] = 74,["75"] = 74,["76"] = 74,["77"] = 75,["78"] = 76,["79"] = 77,["80"] = 77,["81"] = 77,["82"] = 77,["83"] = 77,["84"] = 77,["85"] = 79,["86"] = 80,["87"] = 81,["88"] = 82,["91"] = 74,["92"] = 74,["93"] = 86,["94"] = 87,["96"] = 89,["97"] = 71,["98"] = 71,["99"] = 91,["100"] = 92,["101"] = 92,["104"] = 97,["105"] = 97,["107"] = 100,["108"] = 30,["109"] = 104,["110"] = 105,["111"] = 104,["112"] = 108,["113"] = 110,["114"] = 111,["115"] = 24,["116"] = 108,["117"] = 117,["118"] = 117,["119"] = 117,["120"] = 118,["121"] = 117,["122"] = 120,["123"] = 121,["124"] = 121,["125"] = 121,["126"] = 122,["127"] = 122,["128"] = 122,["129"] = 122,["130"] = 122,["131"] = 122,["132"] = 122,["133"] = 122,["134"] = 122,["135"] = 122,["136"] = 122,["137"] = 133,["138"] = 134,["139"] = 135,["141"] = 137,["142"] = 121,["143"] = 121,["144"] = 139,["145"] = 118,["146"] = 143,["147"] = 143,["148"] = 143,["149"] = 144,["150"] = 143,["151"] = 146,["152"] = 147,["153"] = 147,["154"] = 147,["155"] = 148,["156"] = 148,["157"] = 148,["158"] = 148,["159"] = 148,["160"] = 148,["161"] = 148,["162"] = 148,["163"] = 148,["164"] = 148,["165"] = 148,["166"] = 159,["167"] = 160,["169"] = 162,["170"] = 147,["171"] = 147,["172"] = 164,["173"] = 144,["174"] = 168,["175"] = 168,["176"] = 168,["177"] = 169,["178"] = 168,["179"] = 171,["180"] = 172,["181"] = 172,["182"] = 172,["183"] = 173,["184"] = 173,["185"] = 173,["186"] = 173,["187"] = 173,["188"] = 173,["189"] = 173,["190"] = 173,["191"] = 173,["192"] = 173,["193"] = 173,["194"] = 184,["195"] = 185,["197"] = 187,["198"] = 172,["199"] = 172,["200"] = 189,["201"] = 169,["202"] = 193,["203"] = 193,["204"] = 193,["205"] = 194,["206"] = 193,["207"] = 196,["208"] = 197,["209"] = 197,["210"] = 197,["211"] = 198,["212"] = 198,["213"] = 198,["214"] = 198,["215"] = 198,["216"] = 198,["217"] = 198,["218"] = 198,["219"] = 198,["220"] = 198,["221"] = 198,["222"] = 209,["223"] = 210,["224"] = 211,["226"] = 213,["227"] = 197,["228"] = 197,["229"] = 215,["230"] = 194});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_4")
            __TS__New(AI_Boss_4, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_4 = __TS__Class()
AI_Boss_4.name = "AI_Boss_4"
__TS__ClassExtends(AI_Boss_4, BT_Tree)
function AI_Boss_4.prototype.____constructor(self, hUnit, tData)
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
        for ____, t in ipairs({{"boss_4_1", AI_BOSS_4_1}, {"boss_4_2", AI_BOSS_4_2}, {"boss_4_3", AI_BOSS_4_3}, {"boss_4_4", AI_BOSS_4_4}}) do
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
function AI_Boss_4.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_4.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_BOSS_4_1 = __TS__Class()
AI_BOSS_4_1.name = "AI_BOSS_4_1"
__TS__ClassExtends(AI_BOSS_4_1, BTA_CastAblity)
function AI_BOSS_4_1.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "冲锋"
end
AI_BOSS_4_2 = __TS__Class()
AI_BOSS_4_2.name = "AI_BOSS_4_2"
__TS__ClassExtends(AI_BOSS_4_2, BTA_CastAblity)
function AI_BOSS_4_2.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                500,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                return iWeight + 50
            end
            return 0
        end
    )
    self.precondition.name = "踏"
end
AI_BOSS_4_3 = __TS__Class()
AI_BOSS_4_3.name = "AI_BOSS_4_3"
__TS__ClassExtends(AI_BOSS_4_3, BTA_CastAblity)
function AI_BOSS_4_3.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                1000,
                hAblt:GetAbilityTargetTeam(),
                hAblt:GetAbilityTargetType(),
                hAblt:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )
            if #tTargets > 0 then
                return iWeight + 50
            end
            return 0
        end
    )
    self.precondition.name = "咤"
end
AI_BOSS_4_4 = __TS__Class()
AI_BOSS_4_4.name = "AI_BOSS_4_4"
__TS__ClassExtends(AI_BOSS_4_4, BTA_CastAblity)
function AI_BOSS_4_4.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = KeyValues.AbilitiesKv[hAblt:GetAbilityName()].Weight
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                1000,
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
    self.precondition.name = "锤"
end