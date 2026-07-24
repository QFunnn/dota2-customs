--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 8,["16"] = 9,["17"] = 8,["18"] = 12,["19"] = 13,["20"] = 14,["21"] = 16,["22"] = 18,["23"] = 19,["24"] = 22,["25"] = 22,["26"] = 23,["27"] = 25,["28"] = 26,["29"] = 27,["30"] = 27,["31"] = 27,["32"] = 27,["33"] = 27,["34"] = 28,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 33,["39"] = 12,["40"] = 36,["41"] = 37,["42"] = 38,["43"] = 40,["44"] = 42,["45"] = 43,["46"] = 46,["47"] = 46,["48"] = 47,["49"] = 48,["50"] = 49,["51"] = 50,["52"] = 52,["53"] = 53,["54"] = 54,["55"] = 54,["56"] = 54,["57"] = 54,["58"] = 54,["59"] = 55,["60"] = 57,["61"] = 46,["62"] = 46,["63"] = 46,["64"] = 63,["65"] = 64,["66"] = 64,["67"] = 64,["68"] = 64,["69"] = 64,["70"] = 64,["71"] = 64,["72"] = 64,["73"] = 64,["74"] = 64,["75"] = 64,["76"] = 71,["77"] = 71,["78"] = 71,["79"] = 71,["80"] = 71,["81"] = 71,["82"] = 71,["84"] = 81,["85"] = 81,["86"] = 81,["87"] = 81,["88"] = 81,["89"] = 81,["90"] = 81,["91"] = 81,["92"] = 81,["93"] = 81,["94"] = 81,["95"] = 88,["96"] = 89,["97"] = 90,["100"] = 36,["101"] = 3,["102"] = 2,["103"] = 3});
boss_6_2 = __TS__Class()
boss_6_2.name = "boss_6_2"
__TS__ClassExtends(boss_6_2, BossAbility)
function boss_6_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_2/hit/hit.vpcf", context)
end
function boss_6_2.prototype.GetPlaybackRateOverride(self)
    return 2 / self:GetCastPoint()
end
function boss_6_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vTarget = self:GetCursorPosition()
    local fRange = self.Values:range()
    local vDir = (vTarget - hCaster:GetAbsOrigin()):Normalized()
    vTarget = hCaster:GetAbsOrigin() - vDir * fRange
    ParticleManager_s2c:ToClient(
        function()
            local fCastPoint = self:GetCastPoint()
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
function boss_6_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vTarget = self:GetCursorPosition()
    local fRange = self.Values:range()
    local vDir = (vTarget - hCaster:GetAbsOrigin()):Normalized()
    vTarget = hCaster:GetAbsOrigin() - vDir * fRange
    ParticleManager_s2c:ToClient(
        function()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_2/hit/hit.vpcf", PATTACH_ABSORIGIN, hCaster)
            ParticleManager_s2c:SetParticleControlForward(iPtclID, 0, vTarget)
            ParticleManager_s2c:SetParticleControlForward(iPtclID, 0, -vDir)
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
            iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_1/dust_bomb_warp/dust_bomb_warp.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iPtclID, 0, vTarget)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                1,
                Vector(fRange, 0, 0)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
            ParticleManager_s2c:EmitSoundOn("Boss_6.2_Cast", hCaster)
        end,
        {weight = 0}
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
boss_6_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_2
)