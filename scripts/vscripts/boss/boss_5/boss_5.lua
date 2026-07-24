--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 4,["14"] = 5,["15"] = 6,["16"] = 7,["17"] = 8,["18"] = 9,["19"] = 10,["20"] = 3,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 17,["27"] = 17,["28"] = 17,["29"] = 17,["30"] = 17,["31"] = 17,["32"] = 17,["33"] = 18,["34"] = 19,["35"] = 19,["36"] = 19,["37"] = 19,["38"] = 19,["39"] = 19,["40"] = 19,["41"] = 19,["42"] = 20,["43"] = 21,["44"] = 21,["45"] = 21,["46"] = 21,["47"] = 21,["48"] = 21,["49"] = 21,["50"] = 21,["51"] = 22,["52"] = 23,["53"] = 23,["54"] = 23,["55"] = 23,["56"] = 23,["57"] = 23,["58"] = 23,["59"] = 23,["60"] = 23,["61"] = 24,["62"] = 24,["63"] = 24,["64"] = 24,["65"] = 24,["66"] = 24,["67"] = 24,["68"] = 24,["69"] = 25,["70"] = 26,["71"] = 26,["72"] = 26,["73"] = 26,["74"] = 26,["75"] = 26,["76"] = 26,["77"] = 26,["78"] = 27,["79"] = 28,["80"] = 28,["81"] = 28,["82"] = 28,["83"] = 28,["84"] = 28,["85"] = 28,["86"] = 28,["87"] = 28,["88"] = 29,["89"] = 29,["90"] = 29,["91"] = 29,["92"] = 29,["93"] = 30,["94"] = 30,["95"] = 30,["96"] = 30,["97"] = 30,["98"] = 30,["99"] = 30,["100"] = 30,["101"] = 31,["102"] = 32,["103"] = 32,["104"] = 32,["105"] = 32,["106"] = 32,["107"] = 32,["108"] = 32,["109"] = 32,["110"] = 32,["111"] = 33,["112"] = 33,["113"] = 33,["114"] = 33,["115"] = 33,["116"] = 33,["117"] = 33,["118"] = 33,["119"] = 33,["120"] = 34,["121"] = 34,["122"] = 34,["123"] = 34,["124"] = 34,["125"] = 34,["126"] = 34,["127"] = 34,["129"] = 13,["130"] = 38,["131"] = 39,["132"] = 39,["133"] = 39,["134"] = 39,["135"] = 38,["136"] = 45,["137"] = 46,["138"] = 47,["139"] = 45,["140"] = 49,["141"] = 50,["142"] = 50,["143"] = 50,["144"] = 50,["145"] = 51,["146"] = 52,["148"] = 49,["149"] = 2,["150"] = 1,["151"] = 2});
boss_5 = __TS__Class()
boss_5.name = "boss_5"
__TS__ClassExtends(boss_5, DiyPolymer)
function boss_5.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_5/neck.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/belt.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/arms.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/lina_headflame.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/gold_ambient.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/lina_ti6_ambient.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/lina_flame_hand_dual_headflame.vpcf", context)
end
function boss_5.prototype.OnCreated(self)
    if IsClient() then
        local hParent = self:GetParent()
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/neck.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/belt.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/arms.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/lina_headflame.vpcf", PATTACH_CUSTOMORIGIN, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_head",
            hParent:GetAbsOrigin(),
            true
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/gold_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/lina_ti6_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_neck",
            hParent:GetAbsOrigin(),
            true
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            5,
            Vector(1, 1, 1)
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/lina_flame_hand_dual_headflame.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_attack1",
            hParent:GetAbsOrigin(),
            true
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_attack2",
            hParent:GetAbsOrigin(),
            true
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
    end
end
function boss_5.prototype.DDeclareFunctions(self)
    return {
        [MODIFIER_EVENT_ON_ABILITY_EXECUTED] = {source = self:GetParent()},
        [MODIFIER_EVENT_ON_ABILITY_END_CHANNEL] = {source = self:GetParent()}
    }
end
function boss_5.prototype.OnAbilityEndChannel(self, event)
    local bt = BT_Manager:GetUnitBT(self:GetParent())
    bt:UpdateAbltCastTime()
end
function boss_5.prototype.OnAbilityExecuted(self, event)
    if bit.band(
        event.ability:GetBehaviorInt(),
        DOTA_ABILITY_BEHAVIOR_CHANNELLED
    ) ~= DOTA_ABILITY_BEHAVIOR_CHANNELLED then
        local bt = BT_Manager:GetUnitBT(self:GetParent())
        bt:UpdateAbltCastTime()
    end
end
boss_5 = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    boss_5
)