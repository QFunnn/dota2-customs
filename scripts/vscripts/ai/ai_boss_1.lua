--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_boss_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["22"] = 14,["23"] = 15,["24"] = 10,["25"] = 10,["26"] = 8,["27"] = 20,["28"] = 20,["29"] = 24,["30"] = 24,["31"] = 24,["32"] = 30,["33"] = 30,["34"] = 30,["36"] = 24,["37"] = 29,["38"] = 33,["39"] = 34,["41"] = 42,["42"] = 43,["43"] = 44,["44"] = 49,["45"] = 50,["46"] = 51,["47"] = 51,["50"] = 55,["51"] = 56,["52"] = 56,["53"] = 56,["54"] = 57,["55"] = 58,["56"] = 59,["57"] = 59,["60"] = 61,["61"] = 56,["62"] = 56,["63"] = 63,["64"] = 64,["65"] = 65,["66"] = 65,["69"] = 70,["70"] = 70,["71"] = 70,["72"] = 71,["73"] = 72,["74"] = 73,["75"] = 73,["76"] = 73,["77"] = 74,["78"] = 75,["79"] = 76,["80"] = 76,["81"] = 76,["82"] = 76,["83"] = 76,["84"] = 76,["85"] = 78,["86"] = 79,["87"] = 80,["88"] = 81,["91"] = 73,["92"] = 73,["93"] = 85,["94"] = 86,["96"] = 88,["97"] = 70,["98"] = 70,["99"] = 90,["100"] = 91,["101"] = 91,["104"] = 96,["105"] = 96,["107"] = 99,["108"] = 30,["109"] = 103,["110"] = 104,["111"] = 103,["112"] = 107,["113"] = 109,["114"] = 110,["115"] = 24,["116"] = 107,["117"] = 117,["118"] = 117,["119"] = 117,["120"] = 118,["121"] = 117,["122"] = 120,["123"] = 121,["124"] = 121,["125"] = 121,["126"] = 122,["127"] = 122,["128"] = 122,["129"] = 122,["130"] = 122,["131"] = 122,["132"] = 122,["133"] = 122,["134"] = 122,["135"] = 122,["136"] = 122,["137"] = 133,["138"] = 134,["139"] = 135,["141"] = 137,["142"] = 121,["143"] = 121,["144"] = 139,["145"] = 118,["146"] = 144,["147"] = 144,["148"] = 144,["149"] = 145,["150"] = 144,["151"] = 147,["152"] = 148,["153"] = 148,["154"] = 148,["155"] = 149,["156"] = 149,["157"] = 149,["158"] = 149,["159"] = 149,["160"] = 149,["161"] = 149,["162"] = 149,["163"] = 149,["164"] = 149,["165"] = 149,["166"] = 160,["167"] = 161,["168"] = 162,["170"] = 164,["171"] = 148,["172"] = 148,["173"] = 166,["174"] = 145,["175"] = 171,["176"] = 171,["177"] = 171,["178"] = 172,["179"] = 171,["180"] = 174,["181"] = 175,["182"] = 175,["183"] = 175,["184"] = 176,["185"] = 176,["186"] = 176,["187"] = 176,["188"] = 176,["189"] = 176,["190"] = 176,["191"] = 176,["192"] = 176,["193"] = 176,["194"] = 176,["195"] = 187,["196"] = 188,["198"] = 190,["199"] = 175,["200"] = 175,["201"] = 192,["202"] = 172,["203"] = 194,["204"] = 171,["205"] = 196,["206"] = 194,["207"] = 198,["208"] = 199,["209"] = 200,["210"] = 201,["211"] = 202,["212"] = 204,["213"] = 205,["216"] = 208,["217"] = 198});
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
            thisEntity:AddPolymer(thisEntity, nil, "boss_1")
            __TS__New(AI_Boss_1, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Boss_1 = __TS__Class()
AI_Boss_1.name = "AI_Boss_1"
__TS__ClassExtends(AI_Boss_1, BT_Tree)
function AI_Boss_1.prototype.____constructor(self, hUnit, tData)
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
        for ____, t in ipairs({{"boss_1_1", AI_BOSS_1_1}, {"boss_1_2", AI_BOSS_1_2}}) do
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
function AI_Boss_1.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Boss_1.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_BOSS_1_1 = __TS__Class()
AI_BOSS_1_1.name = "AI_BOSS_1_1"
__TS__ClassExtends(AI_BOSS_1_1, BTA_CastAblity)
function AI_BOSS_1_1.prototype.____constructor(self, hAblt)
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
AI_BOSS_1_2 = __TS__Class()
AI_BOSS_1_2.name = "AI_BOSS_1_2"
__TS__ClassExtends(AI_BOSS_1_2, BTA_CastAblity)
function AI_BOSS_1_2.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "怒吼"
end
AI_BOSS_1_3 = __TS__Class()
AI_BOSS_1_3.name = "AI_BOSS_1_3"
__TS__ClassExtends(AI_BOSS_1_3, BTA_CastAblity)
function AI_BOSS_1_3.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "裂地"
end
function AI_BOSS_1_3.prototype.Evaluate(self)
    local i = BTA_CastAblity.prototype.Evaluate(self)
    return i
end
function AI_BOSS_1_3.prototype.OnUpdate(self)
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