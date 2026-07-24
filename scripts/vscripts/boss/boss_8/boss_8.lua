--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_8\\boss_8"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 4,["14"] = 5,["15"] = 6,["16"] = 7,["17"] = 8,["18"] = 3,["19"] = 11,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 15,["25"] = 15,["26"] = 15,["27"] = 15,["28"] = 15,["29"] = 15,["30"] = 15,["31"] = 15,["32"] = 16,["33"] = 16,["34"] = 16,["35"] = 16,["36"] = 16,["37"] = 16,["38"] = 16,["39"] = 16,["40"] = 16,["41"] = 17,["42"] = 17,["43"] = 17,["44"] = 17,["45"] = 17,["46"] = 17,["47"] = 17,["48"] = 17,["49"] = 17,["50"] = 18,["51"] = 18,["52"] = 18,["53"] = 18,["54"] = 18,["55"] = 18,["56"] = 18,["57"] = 18,["58"] = 19,["59"] = 20,["60"] = 20,["61"] = 20,["62"] = 20,["63"] = 20,["64"] = 20,["65"] = 20,["66"] = 20,["67"] = 20,["68"] = 21,["69"] = 21,["70"] = 21,["71"] = 21,["72"] = 21,["73"] = 21,["74"] = 21,["75"] = 21,["76"] = 21,["77"] = 22,["78"] = 22,["79"] = 22,["80"] = 22,["81"] = 22,["82"] = 22,["83"] = 22,["84"] = 22,["85"] = 22,["86"] = 23,["87"] = 23,["88"] = 23,["89"] = 23,["90"] = 23,["91"] = 23,["92"] = 23,["93"] = 23,["94"] = 23,["95"] = 24,["96"] = 24,["97"] = 24,["98"] = 24,["99"] = 24,["100"] = 24,["101"] = 24,["102"] = 24,["103"] = 24,["104"] = 25,["105"] = 25,["106"] = 25,["107"] = 25,["108"] = 25,["109"] = 25,["110"] = 25,["111"] = 25,["112"] = 25,["113"] = 26,["114"] = 26,["115"] = 26,["116"] = 26,["117"] = 26,["118"] = 26,["119"] = 26,["120"] = 26,["121"] = 27,["122"] = 28,["123"] = 28,["124"] = 28,["125"] = 28,["126"] = 28,["127"] = 28,["128"] = 28,["129"] = 28,["130"] = 28,["131"] = 29,["132"] = 29,["133"] = 29,["134"] = 29,["135"] = 29,["136"] = 29,["137"] = 29,["138"] = 29,["139"] = 29,["140"] = 30,["141"] = 30,["142"] = 30,["143"] = 30,["144"] = 30,["145"] = 30,["146"] = 30,["147"] = 30,["148"] = 30,["149"] = 31,["150"] = 31,["151"] = 31,["152"] = 31,["153"] = 31,["154"] = 31,["155"] = 31,["156"] = 31,["157"] = 31,["158"] = 32,["159"] = 32,["160"] = 32,["161"] = 32,["162"] = 32,["163"] = 32,["164"] = 32,["165"] = 32,["166"] = 32,["167"] = 33,["168"] = 33,["169"] = 33,["170"] = 33,["171"] = 33,["172"] = 33,["173"] = 33,["174"] = 33,["175"] = 33,["176"] = 34,["177"] = 34,["178"] = 34,["179"] = 34,["180"] = 34,["181"] = 34,["182"] = 34,["183"] = 34,["184"] = 34,["185"] = 35,["186"] = 35,["187"] = 35,["188"] = 35,["189"] = 35,["190"] = 35,["191"] = 35,["192"] = 35,["193"] = 36,["194"] = 37,["195"] = 37,["196"] = 37,["197"] = 37,["198"] = 37,["199"] = 37,["200"] = 37,["201"] = 37,["202"] = 37,["203"] = 38,["204"] = 38,["205"] = 38,["206"] = 38,["207"] = 38,["208"] = 38,["209"] = 38,["210"] = 38,["211"] = 39,["212"] = 40,["213"] = 40,["214"] = 40,["215"] = 40,["216"] = 40,["217"] = 40,["218"] = 40,["219"] = 40,["221"] = 11,["222"] = 44,["223"] = 45,["224"] = 45,["225"] = 45,["226"] = 45,["227"] = 45,["228"] = 44,["229"] = 51,["230"] = 52,["231"] = 53,["232"] = 51,["233"] = 55,["234"] = 56,["235"] = 56,["236"] = 56,["237"] = 56,["238"] = 57,["239"] = 58,["241"] = 55,["242"] = 2,["243"] = 1,["244"] = 2});
boss_8 = __TS__Class()
boss_8.name = "boss_8"
__TS__ClassExtends(boss_8, DiyPolymer)
function boss_8.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_8/desolation_ambient.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/shoulder_ambient.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/arcana_ambient.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/arcana_loadout.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/arcana_loadout_ribbon.vpcf", context)
end
function boss_8.prototype.OnCreated(self)
    if IsClient() then
        local hParent = self:GetParent()
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/desolation_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_arm_L",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_arm_R",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            3,
            hParent,
            PATTACH_ABSORIGIN_FOLLOW,
            nil,
            hParent:GetAbsOrigin(),
            false
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/shoulder_ambient.vpcf", PATTACH_CUSTOMORIGIN, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_shoulder_l",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_shoulder_r",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            2,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_arm_l",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            3,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_arm_r",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            4,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            5,
            hParent,
            PATTACH_ABSORIGIN_FOLLOW,
            nil,
            hParent:GetAbsOrigin(),
            false
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/arcana_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_wing_R0",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            2,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_wing_R1",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            3,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_wing_R2",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            4,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_wing_L0",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            5,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_wing_L1",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            6,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_wing_L2",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            7,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_head",
            hParent:GetAbsOrigin(),
            false
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/arcana_loadout.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hParent,
            PATTACH_ABSORIGIN_FOLLOW,
            "attach_hitloc",
            hParent:GetAbsOrigin(),
            false
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/arcana_loadout_ribbon.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
function boss_8.prototype.DDeclareFunctions(self)
    return {
        [MODIFIER_EVENT_ON_ABILITY_EXECUTED] = {source = self:GetParent()},
        [MODIFIER_EVENT_ON_ABILITY_END_CHANNEL] = {source = self:GetParent()},
        [MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS] = "arcana"
    }
end
function boss_8.prototype.OnAbilityEndChannel(self, event)
    local bt = BT_Manager:GetUnitBT(self:GetParent())
    bt:UpdateAbltCastTime()
end
function boss_8.prototype.OnAbilityExecuted(self, event)
    if bit.band(
        event.ability:GetBehaviorInt(),
        DOTA_ABILITY_BEHAVIOR_CHANNELLED
    ) ~= DOTA_ABILITY_BEHAVIOR_CHANNELLED then
        local bt = BT_Manager:GetUnitBT(self:GetParent())
        bt:UpdateAbltCastTime()
    end
end
boss_8 = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    boss_8
)