--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 4,["18"] = 11,["19"] = 12,["20"] = 11,["21"] = 15,["22"] = 16,["23"] = 17,["24"] = 20,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 22,["29"] = 21,["30"] = 21,["31"] = 26,["32"] = 26,["33"] = 27,["34"] = 28,["35"] = 29,["36"] = 30,["37"] = 32,["38"] = 33,["39"] = 34,["40"] = 34,["41"] = 34,["42"] = 34,["43"] = 34,["44"] = 35,["45"] = 26,["46"] = 26,["47"] = 26,["48"] = 40,["49"] = 15,["50"] = 43,["51"] = 44,["52"] = 45,["53"] = 47,["54"] = 49,["55"] = 50,["56"] = 53,["57"] = 53,["58"] = 54,["59"] = 55,["60"] = 56,["61"] = 58,["62"] = 59,["63"] = 60,["64"] = 60,["65"] = 60,["66"] = 60,["67"] = 60,["68"] = 61,["69"] = 64,["70"] = 53,["71"] = 53,["72"] = 53,["73"] = 69,["74"] = 69,["75"] = 69,["76"] = 70,["77"] = 70,["78"] = 71,["79"] = 70,["80"] = 70,["81"] = 70,["82"] = 69,["83"] = 69,["84"] = 76,["85"] = 77,["86"] = 77,["87"] = 77,["88"] = 77,["89"] = 77,["90"] = 77,["91"] = 77,["92"] = 77,["93"] = 77,["94"] = 77,["95"] = 77,["96"] = 84,["97"] = 86,["98"] = 87,["99"] = 87,["100"] = 87,["101"] = 87,["102"] = 87,["103"] = 88,["104"] = 84,["105"] = 90,["106"] = 90,["107"] = 90,["108"] = 90,["109"] = 90,["110"] = 90,["111"] = 90,["113"] = 101,["114"] = 101,["115"] = 101,["116"] = 101,["117"] = 101,["118"] = 101,["119"] = 101,["120"] = 101,["121"] = 101,["122"] = 101,["123"] = 101,["124"] = 108,["125"] = 109,["126"] = 110,["129"] = 43,["130"] = 3,["131"] = 2,["132"] = 3});
boss_6_1 = __TS__Class()
boss_6_1.name = "boss_6_1"
__TS__ClassExtends(boss_6_1, BossAbility)
function boss_6_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_1/impact/impact.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_1/target_impact/target_impact.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_1/dust_bomb_warp/dust_bomb_warp.vpcf", context)
    PrecacheResource("particle", "particles/warning/circular.vpcf", context)
end
function boss_6_1.prototype.GetPlaybackRateOverride(self)
    return 2 / self:GetCastPoint()
end
function boss_6_1.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local fRate = 1.4
    self:GameTimer(
        fCastPoint - 1 / 24 * 7 / fRate,
        function()
            hCaster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, fRate)
        end
    )
    ParticleManager_s2c:ToClient(
        function()
            local fRange = self.Values:range()
            local vTarget = self:GetCursorPosition()
            local vDir = (vTarget - hCaster:GetAbsOrigin()):Normalized()
            vTarget = hCaster:GetAbsOrigin() + vDir * fRange
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iPtclID, 0, vTarget)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                2,
                Vector(fRange, fCastPoint, 1 / fCastPoint)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
        end,
        {weight = 0}
    )
    return true
end
function boss_6_1.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vTarget = self:GetCursorPosition()
    local fRange = self.Values:range()
    local vDir = (vTarget - hCaster:GetAbsOrigin()):Normalized()
    vTarget = hCaster:GetAbsOrigin() + vDir * fRange
    ParticleManager_s2c:ToClient(
        function()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_1/impact/impact.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iPtclID, 0, vTarget)
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
            iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_1/dust_bomb_warp/dust_bomb_warp.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iPtclID, 0, vTarget)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                1,
                Vector(fRange, 0, 0)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
            ParticleManager_s2c:EmitSoundOn("Boss_6.1_Attack_1", hCaster)
        end,
        {weight = 0}
    )
    self:GameTimer(
        0.2,
        function()
            ParticleManager_s2c:ToClient(
                function()
                    ParticleManager_s2c:EmitSoundOn("Boss_6.1_Attack_2", hCaster)
                end,
                {weight = 0}
            )
        end
    )
    local fDmg = self.Values:damage_factor() * AttributeKind.Atk:Get(hCaster)
    for ____, hTarget in ipairs(FindUnitsInRadius(
        hCaster:GetTeamNumber(),
        vTarget,
        nil,
        fRange,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        FIND_CLOSEST,
        false
    )) do
        ParticleManager_s2c:ToClient(function()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_1/target_impact/target_impact.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hTarget)
            ParticleManager_s2c:SetParticleControlForward(
                iPtclID,
                1,
                hCaster:GetAbsOrigin() - hTarget:GetAbsOrigin()
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
        end)
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            damage_type = self:GetAbilityDamageType(),
            victim = hTarget,
            damage = fDmg
        })
    end
    for ____, hTarget in ipairs(FindUnitsInRadius(
        hCaster:GetTeamNumber(),
        vTarget,
        nil,
        fRange,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_CREEP,
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        FIND_ANY_ORDER,
        false
    )) do
        if hTarget:HasModifier("modifier_boss_6_4_meteor") then
            hTarget:SetForwardVector((hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized())
            hTarget:ForceKill(false)
        end
    end
end
boss_6_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_1
)