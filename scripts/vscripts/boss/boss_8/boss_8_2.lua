--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_8\\boss_8_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 6,["13"] = 6,["14"] = 9,["15"] = 10,["16"] = 9,["17"] = 12,["18"] = 13,["19"] = 14,["20"] = 15,["21"] = 16,["22"] = 17,["23"] = 18,["24"] = 20,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 22,["29"] = 22,["30"] = 22,["31"] = 22,["32"] = 22,["33"] = 22,["34"] = 22,["35"] = 22,["36"] = 23,["37"] = 20,["38"] = 20,["39"] = 20,["41"] = 28,["42"] = 28,["43"] = 29,["44"] = 30,["45"] = 30,["46"] = 30,["47"] = 30,["48"] = 30,["49"] = 31,["50"] = 31,["51"] = 31,["52"] = 31,["53"] = 31,["54"] = 31,["55"] = 31,["56"] = 31,["57"] = 31,["58"] = 28,["59"] = 28,["60"] = 28,["61"] = 35,["62"] = 12,["63"] = 37,["64"] = 38,["65"] = 38,["66"] = 39,["67"] = 38,["68"] = 38,["69"] = 38,["70"] = 37,["71"] = 44,["72"] = 45,["73"] = 46,["74"] = 47,["75"] = 48,["76"] = 49,["77"] = 50,["78"] = 51,["79"] = 52,["80"] = 53,["81"] = 53,["82"] = 53,["83"] = 53,["84"] = 53,["85"] = 53,["86"] = 53,["87"] = 54,["88"] = 55,["89"] = 56,["90"] = 56,["91"] = 56,["92"] = 56,["93"] = 56,["94"] = 56,["95"] = 56,["98"] = 65,["99"] = 65,["100"] = 66,["101"] = 67,["102"] = 68,["103"] = 68,["104"] = 68,["105"] = 68,["106"] = 68,["107"] = 69,["108"] = 65,["109"] = 65,["110"] = 65,["111"] = 73,["112"] = 73,["113"] = 74,["114"] = 75,["115"] = 76,["116"] = 76,["117"] = 76,["118"] = 76,["119"] = 76,["120"] = 77,["121"] = 78,["122"] = 73,["123"] = 73,["124"] = 73,["125"] = 82,["126"] = 82,["127"] = 83,["128"] = 84,["129"] = 85,["130"] = 85,["131"] = 85,["132"] = 85,["133"] = 85,["134"] = 86,["135"] = 82,["136"] = 82,["137"] = 82,["139"] = 91,["140"] = 91,["141"] = 92,["142"] = 93,["143"] = 94,["144"] = 94,["145"] = 94,["146"] = 94,["147"] = 94,["148"] = 95,["149"] = 96,["150"] = 91,["151"] = 91,["152"] = 91,["153"] = 100,["154"] = 100,["155"] = 100,["156"] = 100,["157"] = 100,["158"] = 100,["159"] = 100,["160"] = 101,["161"] = 102,["162"] = 102,["163"] = 102,["164"] = 102,["165"] = 102,["166"] = 102,["167"] = 102,["170"] = 44,["171"] = 3,["172"] = 2,["173"] = 3});
boss_8_2 = __TS__Class()
boss_8_2.name = "boss_8_2"
__TS__ClassExtends(boss_8_2, BossAbility)
function boss_8_2.prototype.Precache(self, context)
end
function boss_8_2.prototype.GetPlaybackRateOverride(self)
    return 0.6 / self:GetCastPoint()
end
function boss_8_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local radius = self.Values:radius()
    self.IsFalse = not RollPercentage(self.Values:false_chance())
    local sParticleName = "particles/boss/boss_8/boss_8_1/warning/circular.vpcf"
    if self.IsFalse then
        sParticleName = "particles/boss/boss_8/boss_8_1/warning/circular_false.vpcf"
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/msg/msg.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    4,
                    Vector(
                        self:GetCastPoint(),
                        0,
                        0
                    )
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
    end
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle(sParticleName, PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                0,
                hCaster:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(
                    radius,
                    self:GetCastPoint(),
                    0
                )
            )
        end,
        {weight = 0}
    )
    return true
end
function boss_8_2.prototype.OnAbilityPhaseInterrupted(self)
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
        end,
        {weight = 0}
    )
end
function boss_8_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vPos = hCaster:GetAbsOrigin()
    local radius = self.Values:radius()
    local dmg_factor = self.Values:dmg_factor()
    local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
    if self.IsFalse then
        local vPosition = hCaster:GetAbsOrigin()
        local false_radius = self.Values:false_radius()
        local tTargets = FindUnitsInRadiusWithAbility(
            _G,
            hCaster,
            self,
            vPosition,
            false_radius
        )
        for _, hTarget in pairs(tTargets) do
            if not hTarget:IsPositionInRange(vPos, radius) then
                ApplyDamage({
                    ability = self,
                    attacker = hCaster,
                    victim = hTarget,
                    damage = fDamage,
                    damage_type = self:GetAbilityDamageType()
                })
            end
        end
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/shadowraze/shadowraze.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(false_radius, false_radius, false_radius)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/shadowraze/shadowraze1.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(false_radius, false_radius, false_radius)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                ParticleManager_s2c:StartSoundEventFromPosition("Hero_Nevermore.Shadowraze.Arcana", vPosition)
            end,
            {weight = 0}
        )
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/aoe/aoe.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(false_radius, 0, 0)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
    else
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/shadowraze/shadowraze.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPos)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(radius, radius, radius)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                ParticleManager_s2c:StartSoundEventFromPosition("Hero_Nevermore.Shadowraze.Arcana", vPos)
            end,
            {weight = 0}
        )
        local tTargets = FindUnitsInRadiusWithAbility(
            _G,
            hCaster,
            self,
            vPos,
            radius
        )
        for _, hTarget in pairs(tTargets) do
            ApplyDamage({
                ability = self,
                attacker = hCaster,
                victim = hTarget,
                damage = fDamage,
                damage_type = self:GetAbilityDamageType()
            })
        end
    end
end
boss_8_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_8_2
)