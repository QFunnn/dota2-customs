--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 4,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 13,["20"] = 14,["21"] = 17,["22"] = 17,["23"] = 18,["24"] = 20,["25"] = 21,["26"] = 21,["27"] = 21,["28"] = 21,["29"] = 21,["30"] = 22,["31"] = 22,["32"] = 22,["33"] = 22,["34"] = 22,["35"] = 22,["36"] = 22,["37"] = 22,["38"] = 22,["39"] = 23,["40"] = 17,["41"] = 17,["42"] = 17,["43"] = 28,["44"] = 13,["45"] = 31,["46"] = 32,["47"] = 33,["48"] = 35,["49"] = 38,["50"] = 38,["51"] = 39,["52"] = 40,["53"] = 40,["54"] = 40,["55"] = 40,["56"] = 40,["57"] = 41,["58"] = 43,["59"] = 44,["60"] = 46,["61"] = 47,["62"] = 48,["63"] = 48,["64"] = 48,["65"] = 48,["66"] = 48,["67"] = 49,["68"] = 51,["69"] = 38,["70"] = 38,["71"] = 38,["72"] = 57,["73"] = 57,["74"] = 57,["75"] = 57,["76"] = 57,["77"] = 57,["78"] = 57,["79"] = 57,["80"] = 57,["81"] = 68,["82"] = 69,["83"] = 69,["84"] = 69,["85"] = 69,["86"] = 69,["87"] = 69,["88"] = 69,["89"] = 69,["90"] = 69,["91"] = 69,["92"] = 69,["93"] = 76,["94"] = 76,["95"] = 76,["96"] = 76,["97"] = 76,["98"] = 76,["99"] = 76,["100"] = 85,["101"] = 85,["104"] = 89,["105"] = 89,["106"] = 89,["107"] = 89,["108"] = 89,["109"] = 89,["110"] = 89,["111"] = 89,["112"] = 89,["113"] = 89,["114"] = 89,["115"] = 96,["116"] = 97,["117"] = 98,["120"] = 31,["121"] = 3,["122"] = 2,["123"] = 3});
boss_6_3 = __TS__Class()
boss_6_3.name = "boss_6_3"
__TS__ClassExtends(boss_6_3, BossAbility)
function boss_6_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_3/cast/cast.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_3/cast_cyclone/cast_cyclone.vpcf", context)
end
function boss_6_3.prototype.GetPlaybackRateOverride(self)
    return 2 / self:GetCastPoint()
end
function boss_6_3.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(
        function()
            local fCastPoint = self:GetCastPoint()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                0,
                hCaster:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                2,
                Vector(
                    self.Values:range(),
                    fCastPoint,
                    1 / fCastPoint
                )
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
        end,
        {weight = 0}
    )
    return true
end
function boss_6_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vTarget = hCaster:GetAbsOrigin()
    local fRange = self.Values:range()
    ParticleManager_s2c:ToClient(
        function()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_3/cast/cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                1,
                Vector(fRange, 0, 0)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
            iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_3/cast_cyclone/cast_cyclone.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
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
    local tKnockback = {
        duration = self.Values:knockback_duration(),
        knockback_duration = self.Values:knockback_duration(),
        knockback_distance = self.Values:knockback(),
        knockback_height = self.Values:knockback_z(),
        center_x = vTarget.x,
        center_y = vTarget.y,
        center_z = vTarget.z
    }
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
        if hTarget ~= nil then
            hTarget:AddNewModifier(hCaster, self, "modifier_knockback", tKnockback)
        end
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
boss_6_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_3
)