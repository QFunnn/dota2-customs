--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_creep_44"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 5,["12"] = 8,["13"] = 9,["16"] = 10,["17"] = 10,["18"] = 10,["19"] = 11,["20"] = 12,["21"] = 10,["22"] = 10,["23"] = 8,["24"] = 17,["25"] = 17,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 27,["30"] = 27,["31"] = 27,["33"] = 21,["34"] = 26,["35"] = 30,["36"] = 31,["38"] = 36,["39"] = 37,["40"] = 38,["41"] = 41,["42"] = 42,["43"] = 43,["44"] = 43,["47"] = 47,["48"] = 48,["49"] = 48,["50"] = 48,["51"] = 49,["52"] = 50,["53"] = 51,["54"] = 51,["57"] = 53,["58"] = 48,["59"] = 48,["60"] = 55,["61"] = 56,["62"] = 57,["63"] = 57,["66"] = 62,["67"] = 62,["68"] = 62,["69"] = 63,["70"] = 64,["71"] = 64,["72"] = 64,["73"] = 64,["74"] = 64,["75"] = 64,["76"] = 64,["77"] = 64,["78"] = 64,["79"] = 64,["80"] = 64,["81"] = 75,["82"] = 76,["83"] = 77,["85"] = 79,["86"] = 62,["87"] = 62,["88"] = 81,["89"] = 82,["90"] = 82,["93"] = 87,["94"] = 87,["96"] = 90,["97"] = 27,["98"] = 94,["99"] = 95,["100"] = 94,["101"] = 98,["102"] = 100,["103"] = 101,["104"] = 21,["105"] = 98,["106"] = 107,["107"] = 107,["108"] = 107,["109"] = 108,["110"] = 107,["111"] = 110,["112"] = 111,["113"] = 111,["114"] = 111,["115"] = 112,["116"] = 112,["117"] = 112,["118"] = 112,["119"] = 116,["120"] = 116,["121"] = 116,["122"] = 112,["123"] = 112,["124"] = 112,["125"] = 112,["126"] = 112,["127"] = 112,["128"] = 112,["129"] = 123,["130"] = 124,["131"] = 125,["133"] = 127,["134"] = 111,["135"] = 111,["136"] = 129,["137"] = 108});
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
            thisEntity:AddPolymer(thisEntity, nil, "creep_44")
            __TS__New(AI_Creep_44, thisEntity)
        end
    )
end
function UpdateOnRemove(self)
end
AI_Creep_44 = __TS__Class()
AI_Creep_44.name = "AI_Creep_44"
__TS__ClassExtends(AI_Creep_44, BT_Tree)
function AI_Creep_44.prototype.____constructor(self, hUnit, tData)
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
        for ____, t in ipairs({{"creep_44_1", AI_Creep_44_1}}) do
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
function AI_Creep_44.prototype.UpdateAbltCastTime(self)
    self.tData.fCastTime = GameRules:GetGameTime()
end
function AI_Creep_44.prototype.OnUpdate(self)
    self.tData.target = nil
    self.tData.target_pos = nil
    return BT_Tree.prototype.OnUpdate(self)
end
AI_Creep_44_1 = __TS__Class()
AI_Creep_44_1.name = "AI_Creep_44_1"
__TS__ClassExtends(AI_Creep_44_1, BTA_CastAblity)
function AI_Creep_44_1.prototype.____constructor(self, hAblt)
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
    self.precondition.name = "冲击波"
end