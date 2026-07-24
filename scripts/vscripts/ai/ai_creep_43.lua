--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_creep_43"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 10,["22"] = 10,["23"] = 8,["24"] = 17,["25"] = 17,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 27,["30"] = 27,["31"] = 27,["33"] = 21,["34"] = 26,["35"] = 30,["36"] = 31,["38"] = 36,["39"] = 37,["40"] = 38,["41"] = 43,["42"] = 44,["43"] = 45,["44"] = 45,["47"] = 49,["48"] = 50,["49"] = 50,["50"] = 50,["51"] = 51,["52"] = 52,["53"] = 53,["54"] = 53,["57"] = 55,["58"] = 50,["59"] = 50,["60"] = 57,["61"] = 58,["62"] = 59,["63"] = 59,["66"] = 64,["67"] = 64,["68"] = 64,["69"] = 65,["70"] = 66,["71"] = 66,["72"] = 66,["73"] = 66,["74"] = 66,["75"] = 66,["76"] = 66,["77"] = 66,["78"] = 66,["79"] = 66,["80"] = 66,["81"] = 77,["82"] = 78,["83"] = 79,["85"] = 81,["86"] = 64,["87"] = 64,["88"] = 83,["89"] = 84,["90"] = 84,["93"] = 89,["94"] = 89,["96"] = 92,["97"] = 27,["98"] = 96,["99"] = 97,["100"] = 96,["101"] = 100,["102"] = 102,["103"] = 103,["104"] = 21,["105"] = 100,["106"] = 109,["107"] = 109,["108"] = 109,["109"] = 110,["110"] = 109,["111"] = 112,["112"] = 113,["113"] = 113,["114"] = 113,["115"] = 114,["116"] = 114,["117"] = 114,["118"] = 114,["119"] = 118,["120"] = 118,["121"] = 118,["122"] = 114,["123"] = 114,["124"] = 114,["125"] = 114,["126"] = 114,["127"] = 114,["128"] = 114,["129"] = 125,["130"] = 126,["131"] = 127,["133"] = 129,["134"] = 113,["135"] = 113,["136"] = 131,["137"] = 110,["138"] = 133,["139"] = 109,["140"] = 135,["141"] = 133,["142"] = 137,["143"] = 138,["144"] = 139,["145"] = 140,["146"] = 141,["147"] = 143,["148"] = 144,["151"] = 147,["152"] = 137,["153"] = 151,["154"] = 151,["155"] = 151,["156"] = 152,["157"] = 151,["158"] = 154,["159"] = 155,["160"] = 155,["161"] = 155,["162"] = 156,["163"] = 156,["164"] = 156,["165"] = 156,["166"] = 160,["167"] = 160,["168"] = 160,["169"] = 156,["170"] = 156,["171"] = 156,["172"] = 156,["173"] = 156,["174"] = 156,["175"] = 156,["176"] = 167,["177"] = 168,["178"] = 169,["180"] = 171,["181"] = 155,["182"] = 155,["183"] = 173,["184"] = 152,["185"] = 175,["186"] = 151,["187"] = 177,["188"] = 175,["189"] = 179,["190"] = 180,["191"] = 181,["192"] = 182,["193"] = 183,["194"] = 185,["195"] = 186,["198"] = 189,["199"] = 179,["200"] = 193,["201"] = 193,["202"] = 193,["203"] = 194,["204"] = 193,["205"] = 196,["206"] = 197,["207"] = 197,["208"] = 197,["209"] = 198,["210"] = 198,["211"] = 198,["212"] = 198,["213"] = 202,["214"] = 202,["215"] = 202,["216"] = 198,["217"] = 198,["218"] = 198,["219"] = 198,["220"] = 198,["221"] = 198,["222"] = 198,["223"] = 209,["224"] = 210,["225"] = 211,["227"] = 213,["228"] = 197,["229"] = 197,["230"] = 215,["231"] = 194,["232"] = 217,["233"] = 193,["234"] = 219,["235"] = 217,["236"] = 221,["237"] = 222,["238"] = 223,["239"] = 224,["240"] = 225,["241"] = 227,["242"] = 228,["245"] = 231,["246"] = 221});
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
            thisEntity:AddPolymer(thisEntity, nil, "creep_43")
            __TS__New(AI_Creep_43, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Creep_43 = __TS__Class()
AI_Creep_43.name = "AI_Creep_43"
__TS__ClassExtends(AI_Creep_43, BT_Tree)
function AI_Creep_43.prototype.____constructor(self, hUnit, tData)
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
        for ____, t in ipairs({{"creep_43_1", AI_Creep_43_1}, {"creep_43_2", AI_Creep_43_2}, {"creep_43_3", AI_Creep_43_3}}) do
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
                self.tData.target = nil
                local hTarget = FindUnitsInRadius(
                    thisEntity:GetTeamNumber(),
                    thisEntity:GetAbsOrigin(),
                    nil,
                    1000,
                    DOTA_UNIT_TARGET_TEAM_ENEMY,
                    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_CLOSEST,
                    false
                )[1]
                self.tData.target = hTarget
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
function AI_Creep_43.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Creep_43.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_Creep_43_1 = __TS__Class()
AI_Creep_43_1.name = "AI_Creep_43_1"
__TS__ClassExtends(AI_Creep_43_1, BTA_CastAblity)
function AI_Creep_43_1.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = 100
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                hAblt:GetCastRange(
                    self.hUnit:GetAbsOrigin(),
                    self.hUnit
                ),
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
    self.precondition.name = "毁灭阴影"
end
function AI_Creep_43_1.prototype.Evaluate(self)
    local i = BTA_CastAblity.prototype.Evaluate(self)
    return i
end
function AI_Creep_43_1.prototype.OnUpdate(self)
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
AI_Creep_43_2 = __TS__Class()
AI_Creep_43_2.name = "AI_Creep_43_2"
__TS__ClassExtends(AI_Creep_43_2, BTA_CastAblity)
function AI_Creep_43_2.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = 100
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                hAblt:GetCastRange(
                    self.hUnit:GetAbsOrigin(),
                    self.hUnit
                ),
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
    self.precondition.name = "声波"
end
function AI_Creep_43_2.prototype.Evaluate(self)
    local i = BTA_CastAblity.prototype.Evaluate(self)
    return i
end
function AI_Creep_43_2.prototype.OnUpdate(self)
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
AI_Creep_43_3 = __TS__Class()
AI_Creep_43_3.name = "AI_Creep_43_3"
__TS__ClassExtends(AI_Creep_43_3, BTA_CastAblity)
function AI_Creep_43_3.prototype.____constructor(self, hAblt)
    BTA_CastAblity.prototype.____constructor(self, hAblt)
    local iWeight = 100
    self.precondition = __TS__New(
        BT_Precondition,
        function()
            local tTargets = FindUnitsInRadius(
                self.hUnit:GetTeamNumber(),
                self.hUnit:GetAbsOrigin(),
                nil,
                hAblt:GetCastRange(
                    self.hUnit:GetAbsOrigin(),
                    self.hUnit
                ),
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
    self.precondition.name = "魂之挽歌"
end
function AI_Creep_43_3.prototype.Evaluate(self)
    local i = BTA_CastAblity.prototype.Evaluate(self)
    return i
end
function AI_Creep_43_3.prototype.OnUpdate(self)
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