--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 7,["13"] = 8,["14"] = 7,["15"] = 10,["16"] = 11,["17"] = 10,["18"] = 13,["19"] = 14,["20"] = 15,["21"] = 16,["22"] = 17,["23"] = 18,["24"] = 19,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 23,["29"] = 24,["31"] = 25,["32"] = 25,["33"] = 26,["34"] = 27,["35"] = 28,["36"] = 28,["37"] = 29,["38"] = 29,["39"] = 30,["40"] = 31,["41"] = 31,["42"] = 31,["43"] = 31,["44"] = 31,["45"] = 32,["46"] = 33,["47"] = 33,["48"] = 33,["49"] = 33,["50"] = 33,["51"] = 34,["52"] = 34,["53"] = 35,["54"] = 36,["55"] = 37,["56"] = 38,["58"] = 40,["59"] = 41,["60"] = 29,["61"] = 29,["62"] = 29,["63"] = 25,["66"] = 46,["67"] = 13,["68"] = 48,["69"] = 49,["70"] = 50,["71"] = 50,["72"] = 51,["73"] = 52,["75"] = 50,["76"] = 50,["77"] = 50,["78"] = 57,["79"] = 48,["80"] = 59,["81"] = 60,["82"] = 61,["83"] = 62,["84"] = 63,["85"] = 64,["86"] = 65,["87"] = 66,["88"] = 66,["89"] = 67,["90"] = 66,["91"] = 66,["92"] = 66,["93"] = 71,["94"] = 72,["95"] = 73,["96"] = 73,["97"] = 73,["98"] = 73,["99"] = 73,["100"] = 73,["101"] = 73,["102"] = 73,["103"] = 73,["104"] = 73,["105"] = 73,["106"] = 73,["107"] = 73,["108"] = 73,["109"] = 73,["111"] = 59,["112"] = 94,["113"] = 95,["114"] = 96,["115"] = 97,["116"] = 98,["117"] = 99,["118"] = 100,["119"] = 100,["120"] = 100,["121"] = 100,["122"] = 100,["124"] = 102,["125"] = 102,["126"] = 102,["127"] = 102,["128"] = 102,["129"] = 102,["130"] = 102,["132"] = 94,["133"] = 3,["134"] = 2,["135"] = 3});
boss_7_2 = __TS__Class()
boss_7_2.name = "boss_7_2"
__TS__ClassExtends(boss_7_2, BossAbility)
function boss_7_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_2/projectile/projectile.vpcf", context)
end
function boss_7_2.prototype.GetPlaybackRateOverride(self)
    return 0.73 / self:GetCastPoint()
end
function boss_7_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local width = self.Values:width()
    local min_count = self.Values:min_count()
    local max_count = self.Values:max_count()
    local count = RandomInt(min_count, max_count)
    local fCastPoint = self:GetCastPoint()
    local distance = self.Values:distance()
    local vDiretion = RandomVector(1)
    local vStart = hCaster:GetAbsOrigin()
    self.tParticleID = {}
    self.tEnd = {}
    do
        local i = 0
        while i < count do
            local vTempDirection = Rotation2D(vDiretion, 360 / count * i)
            local vPostion = vStart + vTempDirection * distance
            local ____self_tEnd_0 = self.tEnd
            ____self_tEnd_0[#____self_tEnd_0 + 1] = vPostion
            ParticleManager_s2c:ToClient(
                function()
                    local iPtclID = ParticleManager_s2c:CreateParticle("particles/warning/linear.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(
                        iPtclID,
                        0,
                        hCaster:GetAbsOrigin()
                    )
                    ParticleManager_s2c:SetParticleControl(iPtclID, 1, vPostion)
                    ParticleManager_s2c:SetParticleControl(
                        iPtclID,
                        2,
                        Vector(width, fCastPoint, 1 / fCastPoint)
                    )
                    local ____self_tParticleID_1 = self.tParticleID
                    ____self_tParticleID_1[#____self_tParticleID_1 + 1] = iPtclID
                    local tSound = {"Boss_7.Start_6", "Boss_7.Start_7", "Boss_7.Start_8", "Boss_7.Start_9"}
                    local sSound = tSound[RandomInt(0, #tSound - 1) + 1]
                    while self.sLastSound == sSound do
                        sSound = tSound[RandomInt(0, #tSound - 1) + 1]
                    end
                    self.sLastSound = sSound
                    ParticleManager_s2c:EmitSoundOn(sSound, hCaster)
                end,
                {weight = 0}
            )
            i = i + 1
        end
    end
    return true
end
function boss_7_2.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(
        function()
            for _, iParticleID in pairs(self.tParticleID) do
                ParticleManager_s2c:DestroyParticle(iParticleID, true)
            end
        end,
        {weight = 0}
    )
    hCaster:StopSound(self.sLastSound)
end
function boss_7_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vStart = hCaster:GetAbsOrigin()
    local speed = self.Values:speed()
    local distance = self.Values:distance()
    local width = self.Values:width()
    local fDamage = AttributeKind.Atk:Get(hCaster) * self.Values:dmg_factor()
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:EmitSoundOn("Boss_2_2.Cast", hCaster)
        end,
        {weight = 0}
    )
    for _, vEnd in pairs(self.tEnd) do
        local vDire = (vEnd - vStart):Normalized()
        ProjectileManager:CreateLinearProjectile({
            Ability = self,
            Source = hCaster,
            EffectName = "particles/boss/boss_7/boss_7_2/projectile/projectile.vpcf",
            vSpawnOrigin = hCaster:GetAbsOrigin(),
            vVelocity = vDire * speed,
            fDistance = distance,
            fStartRadius = width,
            fEndRadius = width,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
            ExtraData = {fDamage = fDamage},
            ParticleConfig = {weight = 0}
        })
    end
end
function boss_7_2.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        local fDamage = extraData.fDamage
        local hAbility = hCaster:FindAbilityByName("boss_7_1")
        if IsValid(hAbility) and hAbility.CreateSpiderling then
            hAbility.CreateSpiderling(
                hAbility,
                target:GetAbsOrigin(),
                self.Values:count()
            )
        end
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = fDamage,
            damage_type = self:GetAbilityDamageType()
        })
    end
end
boss_7_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_7_2
)