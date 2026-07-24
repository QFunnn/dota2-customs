--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_8\\boss_8_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["13"] = 3,["14"] = 4,["15"] = 5,["16"] = 2,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 10,["21"] = 11,["22"] = 12,["23"] = 13,["24"] = 7,["25"] = 15,["26"] = 16,["27"] = 15,["28"] = 18,["29"] = 19,["30"] = 20,["31"] = 21,["32"] = 22,["33"] = 23,["34"] = 24,["35"] = 25,["36"] = 26,["37"] = 27,["38"] = 28,["39"] = 30,["40"] = 30,["41"] = 31,["42"] = 32,["43"] = 32,["44"] = 32,["45"] = 32,["46"] = 32,["47"] = 32,["48"] = 32,["49"] = 32,["50"] = 32,["51"] = 33,["52"] = 30,["53"] = 30,["54"] = 30,["57"] = 38,["58"] = 38,["59"] = 39,["60"] = 40,["61"] = 40,["62"] = 41,["63"] = 42,["64"] = 43,["65"] = 43,["66"] = 43,["67"] = 43,["68"] = 43,["69"] = 43,["70"] = 43,["71"] = 43,["72"] = 43,["73"] = 44,["74"] = 44,["75"] = 40,["76"] = 40,["77"] = 40,["78"] = 48,["79"] = 48,["80"] = 38,["83"] = 50,["84"] = 18,["85"] = 52,["86"] = 53,["87"] = 54,["88"] = 54,["89"] = 55,["90"] = 54,["91"] = 54,["92"] = 54,["94"] = 52,["95"] = 61,["96"] = 62,["97"] = 63,["98"] = 64,["99"] = 65,["100"] = 66,["101"] = 67,["102"] = 68,["103"] = 69,["104"] = 69,["105"] = 69,["106"] = 69,["107"] = 69,["108"] = 69,["109"] = 69,["110"] = 70,["111"] = 71,["112"] = 72,["113"] = 72,["114"] = 72,["115"] = 72,["116"] = 72,["117"] = 72,["118"] = 72,["121"] = 81,["122"] = 81,["123"] = 82,["124"] = 83,["125"] = 84,["126"] = 84,["127"] = 84,["128"] = 84,["129"] = 84,["130"] = 85,["131"] = 81,["132"] = 81,["133"] = 81,["134"] = 89,["135"] = 89,["136"] = 90,["137"] = 91,["138"] = 92,["139"] = 92,["140"] = 92,["141"] = 92,["142"] = 92,["143"] = 93,["144"] = 94,["145"] = 89,["146"] = 89,["147"] = 89,["148"] = 98,["149"] = 98,["150"] = 99,["151"] = 100,["152"] = 101,["153"] = 101,["154"] = 101,["155"] = 101,["156"] = 101,["157"] = 102,["158"] = 98,["159"] = 98,["160"] = 98,["162"] = 107,["163"] = 108,["164"] = 108,["165"] = 109,["166"] = 110,["167"] = 111,["168"] = 111,["169"] = 111,["170"] = 111,["171"] = 111,["172"] = 112,["173"] = 113,["174"] = 108,["175"] = 108,["176"] = 108,["177"] = 117,["178"] = 117,["179"] = 117,["180"] = 117,["181"] = 117,["182"] = 117,["183"] = 117,["184"] = 118,["185"] = 119,["186"] = 119,["187"] = 119,["188"] = 119,["189"] = 119,["190"] = 119,["191"] = 119,["195"] = 61,["196"] = 130,["197"] = 131,["198"] = 132,["199"] = 133,["200"] = 133,["201"] = 133,["202"] = 133,["203"] = 134,["207"] = 138,["208"] = 130,["209"] = 3,["210"] = 2,["211"] = 3});
boss_8_1 = __TS__Class()
boss_8_1.name = "boss_8_1"
__TS__ClassExtends(boss_8_1, BossAbility)
function boss_8_1.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tPos = {}
    self.tParticleID = {}
end
function boss_8_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_1/warning/circular.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_1/warning/circular_false.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_1/msg/msg.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_1/shadowraze/shadowraze.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_1/shadowraze/shadowraze1.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_1/aoe/aoe.vpcf", context)
end
function boss_8_1.prototype.GetPlaybackRateOverride(self)
    return 0.6 / self:GetCastPoint()
end
function boss_8_1.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local range = self.Values:range()
    local radius = self.Values:radius()
    local count = self.Values:count()
    self.IsFalse = not RollPercentage(self.Values:false_chance())
    self.tParticleID = {}
    self.tPos = {}
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
    do
        local i = 0
        while i < count do
            local vPostion = hCaster:GetAbsOrigin() + RandomVector(RandomInt(0, range))
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle(sParticleName, PATTACH_CUSTOMORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPostion)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        2,
                        Vector(
                            radius,
                            self:GetCastPoint(),
                            0
                        )
                    )
                    local ____self_tParticleID_0 = self.tParticleID
                    ____self_tParticleID_0[#____self_tParticleID_0 + 1] = iParticleID
                end,
                {weight = 0}
            )
            local ____self_tPos_1 = self.tPos
            ____self_tPos_1[#____self_tPos_1 + 1] = vPostion
            i = i + 1
        end
    end
    return true
end
function boss_8_1.prototype.OnAbilityPhaseInterrupted(self)
    for _, iParticleID in pairs(self.tParticleID) do
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(iParticleID, true)
            end,
            {weight = 0}
        )
    end
end
function boss_8_1.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
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
            if not self:IsPositionIntPos(hTarget) then
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
        for _, vPos in pairs(self.tPos) do
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
end
function boss_8_1.prototype.IsPositionIntPos(self, hTarget)
    local b = false
    for _, vPos in pairs(self.tPos) do
        if hTarget:IsPositionInRange(
            vPos,
            self.Values:radius()
        ) then
            b = true
            break
        end
    end
    return b
end
boss_8_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_8_1
)