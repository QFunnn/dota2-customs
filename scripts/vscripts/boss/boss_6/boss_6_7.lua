--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_7"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["13"] = 3,["14"] = 14,["15"] = 2,["16"] = 4,["17"] = 5,["18"] = 6,["19"] = 7,["20"] = 8,["21"] = 4,["22"] = 16,["23"] = 17,["24"] = 16,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 23,["29"] = 25,["30"] = 28,["31"] = 28,["32"] = 29,["33"] = 30,["34"] = 30,["35"] = 30,["36"] = 30,["37"] = 30,["38"] = 31,["39"] = 32,["40"] = 32,["41"] = 32,["42"] = 32,["43"] = 32,["44"] = 32,["45"] = 32,["46"] = 32,["47"] = 32,["48"] = 28,["49"] = 28,["50"] = 28,["51"] = 37,["52"] = 37,["53"] = 39,["54"] = 40,["55"] = 40,["56"] = 40,["57"] = 40,["58"] = 40,["59"] = 40,["60"] = 40,["61"] = 40,["62"] = 40,["63"] = 43,["64"] = 37,["65"] = 37,["66"] = 37,["67"] = 49,["68"] = 49,["69"] = 49,["70"] = 50,["71"] = 50,["72"] = 51,["73"] = 50,["74"] = 50,["75"] = 50,["76"] = 49,["77"] = 49,["78"] = 49,["79"] = 57,["80"] = 20,["81"] = 60,["82"] = 61,["83"] = 62,["84"] = 62,["85"] = 63,["86"] = 64,["87"] = 62,["88"] = 62,["89"] = 62,["90"] = 60,["91"] = 70,["92"] = 71,["93"] = 73,["94"] = 73,["95"] = 74,["96"] = 75,["97"] = 77,["98"] = 78,["99"] = 78,["100"] = 78,["101"] = 78,["102"] = 78,["103"] = 78,["104"] = 78,["105"] = 78,["106"] = 78,["107"] = 79,["108"] = 73,["109"] = 73,["110"] = 73,["111"] = 84,["112"] = 85,["113"] = 86,["114"] = 87,["115"] = 89,["116"] = 89,["117"] = 89,["118"] = 89,["119"] = 89,["120"] = 90,["121"] = 103,["122"] = 103,["123"] = 103,["124"] = 103,["125"] = 103,["126"] = 103,["127"] = 103,["128"] = 103,["129"] = 103,["130"] = 103,["131"] = 108,["132"] = 108,["133"] = 108,["134"] = 108,["135"] = 109,["136"] = 109,["137"] = 109,["138"] = 109,["139"] = 109,["140"] = 109,["143"] = 116,["144"] = 116,["145"] = 116,["146"] = 116,["147"] = 116,["148"] = 116,["149"] = 116,["150"] = 116,["151"] = 116,["152"] = 116,["153"] = 121,["154"] = 121,["155"] = 121,["156"] = 121,["157"] = 122,["158"] = 123,["159"] = 124,["163"] = 131,["164"] = 131,["165"] = 131,["166"] = 131,["167"] = 131,["168"] = 131,["169"] = 131,["170"] = 131,["171"] = 131,["172"] = 131,["173"] = 131,["174"] = 137,["175"] = 70,["176"] = 140,["177"] = 141,["178"] = 142,["179"] = 143,["182"] = 140,["183"] = 3,["184"] = 2,["185"] = 3,["187"] = 150,["188"] = 150,["189"] = 151,["191"] = 151,["192"] = 164,["193"] = 150,["194"] = 152,["195"] = 152,["196"] = 152,["197"] = 153,["198"] = 153,["199"] = 153,["200"] = 166,["201"] = 167,["202"] = 168,["203"] = 169,["204"] = 171,["205"] = 172,["206"] = 173,["207"] = 175,["208"] = 175,["209"] = 175,["210"] = 175,["211"] = 175,["212"] = 176,["213"] = 183,["214"] = 184,["216"] = 187,["217"] = 188,["218"] = 189,["219"] = 190,["220"] = 190,["221"] = 190,["222"] = 190,["223"] = 190,["224"] = 190,["225"] = 190,["226"] = 190,["227"] = 190,["228"] = 191,["229"] = 191,["230"] = 191,["231"] = 191,["232"] = 191,["233"] = 191,["234"] = 191,["235"] = 191,["237"] = 166,["238"] = 195,["239"] = 196,["240"] = 197,["241"] = 199,["242"] = 200,["243"] = 201,["246"] = 206,["247"] = 208,["248"] = 208,["249"] = 208,["250"] = 208,["251"] = 208,["252"] = 208,["253"] = 208,["254"] = 208,["255"] = 208,["256"] = 208,["257"] = 213,["258"] = 213,["259"] = 213,["260"] = 213,["261"] = 214,["262"] = 215,["263"] = 218,["264"] = 219,["265"] = 220,["266"] = 218,["267"] = 223,["268"] = 223,["269"] = 223,["270"] = 223,["271"] = 223,["272"] = 223,["273"] = 223,["277"] = 195,["278"] = 235,["279"] = 236,["280"] = 237,["281"] = 238,["283"] = 235,["284"] = 151,["285"] = 150,["286"] = 151});
boss_6_7 = __TS__Class()
boss_6_7.name = "boss_6_7"
__TS__ClassExtends(boss_6_7, BossAbility)
function boss_6_7.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tFires = {}
end
function boss_6_7.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_7/cast_mouth/cast_mouth.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_7/cast_mouth_big_fire/cast_mouth_big_fire.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_7/fire/fire.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_7/fireing_target/fireing_target.vpcf", context)
end
function boss_6_7.prototype.GetPlaybackRateOverride(self)
    return 2 / self:GetCastPoint()
end
function boss_6_7.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vTarget = self:GetCursorPosition()
    local fCastPoint = self:GetCastPoint()
    local vEnd = hCaster:GetAbsOrigin() + (vTarget - hCaster:GetOrigin()):Normalized() * self.Values:distance()
    ParticleManager_s2c:ToClient(
        function()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/warning/linear.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                0,
                hCaster:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(iPtclID, 1, vEnd)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                2,
                Vector(
                    self.Values:width(),
                    fCastPoint,
                    1 / fCastPoint
                )
            )
        end,
        {weight = 0}
    )
    ParticleManager_s2c:ToClient(
        function()
            self.iPtclID_Cast = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_7/cast_mouth/cast_mouth.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
            ParticleManager_s2c:SetParticleControlEnt(
                self.iPtclID_Cast,
                0,
                hCaster,
                PATTACH_POINT_FOLLOW,
                "attach_mouth",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:EmitSoundOn("Hero_Lycan.SummonWolves", hCaster)
        end,
        {weight = 0}
    )
    self:GameTimer(
        fCastPoint - 0.3,
        function()
            ParticleManager_s2c:ToClient(
                function()
                    ParticleManager_s2c:EmitSoundOn("Hero_Jakiro.Macropyre.Cast", hCaster)
                end,
                {weight = 0}
            )
        end,
        "sound"
    )
    return true
end
function boss_6_7.prototype.OnAbilityPhaseInterrupted(self)
    self:StopTimer("sound")
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iPtclID_Cast, true)
            self.iPtclID_Cast = nil
        end,
        {weight = 0}
    )
end
function boss_6_7.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iPtclID_Cast, true)
            self.iPtclID_Cast = nil
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_7/cast_mouth_big_fire/cast_mouth_big_fire.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
            ParticleManager_s2c:SetParticleControlEnt(
                iPtclID,
                0,
                hCaster,
                PATTACH_POINT_FOLLOW,
                "attach_mouth",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
        end,
        {weight = 0}
    )
    local vTarget = self:GetCursorPosition()
    local vStart = hCaster:GetAbsOrigin()
    local vEnd = vStart + (vTarget - hCaster:GetOrigin()):Normalized() * self.Values:distance()
    local fWidth = self.Values:width()
    local vOffset = RotatePosition(
        Vector(0, 0, 0),
        QAngle(0, 90, 0),
        (vEnd - vStart):Normalized() * fWidth
    )
    local tBounds = {vStart - vOffset, vStart + vOffset, vEnd - vOffset, vEnd + vOffset}
    for ____, hTarget in ipairs(FindUnitsInLine(
        hCaster:GetTeamNumber(),
        vStart,
        vEnd,
        nil,
        fWidth,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags()
    )) do
        if IsPointInPolygon(
            hTarget:GetAbsOrigin(),
            tBounds
        ) then
            hTarget:AddNewModifier(
                hCaster,
                self,
                "modifier_stunned",
                {duration = self.Values:stun_duration()}
            )
        end
    end
    for ____, hTarget in ipairs(FindUnitsInLine(
        hCaster:GetTeamNumber(),
        vStart,
        vEnd,
        nil,
        fWidth,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_CREEP,
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE
    )) do
        if IsPointInPolygon(
            hTarget:GetAbsOrigin(),
            tBounds
        ) then
            if hTarget:HasModifier("modifier_boss_6_4_meteor") then
                hTarget:SetForwardVector((hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized())
                hTarget:ForceKill(false)
            end
        end
    end
    local hFire = hCaster:AddPolymer(
        hCaster,
        self,
        "boss_6_7_fire",
        {
            duration = self.Values:duration(),
            pos_start = VectorToString(_G, vStart),
            pos_end = VectorToString(_G, vEnd),
            width = fWidth
        }
    )
    self.tFires[hFire] = true
end
function boss_6_7.prototype.OnDestroy(self)
    if IsServer() then
        for hFire, _ in pairs(self.tFires) do
            hFire:Destroy()
        end
    end
end
boss_6_7 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_7
)
boss_6_7_fire = __TS__Class()
boss_6_7_fire.name = "boss_6_7_fire"
__TS__ClassExtends(boss_6_7_fire, DiyPolymer)
function boss_6_7_fire.prototype.____constructor(self, ...)
    DiyPolymer.prototype.____constructor(self, ...)
    self.tDamageTargetTime = {}
end
function boss_6_7_fire.prototype.IsHidden(self)
    return true
end
function boss_6_7_fire.prototype.GetAttributes(self)
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function boss_6_7_fire.prototype.OnCreated(self, params)
    self.fWidth = tonumber(params.width)
    self.vStart = StringToVector(_G, params.pos_start)
    self.vEnd = StringToVector(_G, params.pos_end)
    if IsServer() then
        self.fDamageFactor = self.Values:damage_factor()
        self.fDamageInterval = self.Values:dmg_interval()
        local vOffset = RotatePosition(
            Vector(0, 0, 0),
            QAngle(0, 90, 0),
            (self.vEnd - self.vStart):Normalized() * self.fWidth
        )
        self.tBounds = {self.vStart - vOffset, self.vStart + vOffset, self.vEnd - vOffset, self.vEnd + vOffset}
        self:OnIntervalThink()
        self:StartIntervalThink(0.1)
    else
        local iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/boss_6_7/fire/fire.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(iPtclID, 0, self.vStart)
        ParticleManager:SetParticleControl(iPtclID, 1, self.vEnd)
        ParticleManager:SetParticleControl(
            iPtclID,
            2,
            Vector(
                self:GetRemainingTime(),
                self.fWidth,
                0
            )
        )
        self:AddParticle(
            iPtclID,
            false,
            false,
            -1,
            false,
            false
        )
    end
end
function boss_6_7_fire.prototype.OnIntervalThink(self)
    local hCaster = self:GetParent()
    local hAblt = self:GetAbility()
    if not IsValid(hCaster) or not IsValid(hAblt) then
        self:StartIntervalThink(-1)
        self:Destroy()
        return
    end
    local fDmg = self.fDamageFactor * AttributeKind.Atk:Get(hCaster)
    for ____, hTarget in ipairs(FindUnitsInLine(
        hCaster:GetTeamNumber(),
        self.vStart,
        self.vEnd,
        nil,
        self.fWidth,
        hAblt:GetAbilityTargetTeam(),
        hAblt:GetAbilityTargetType(),
        hAblt:GetAbilityTargetFlags()
    )) do
        if IsPointInPolygon(
            hTarget:GetAbsOrigin(),
            self.tBounds
        ) then
            if self.tDamageTargetTime[hTarget:entindex()] == nil or self.tDamageTargetTime[hTarget:entindex()] <= GameRules:GetGameTime() then
                self.tDamageTargetTime[hTarget:entindex()] = GameRules:GetGameTime() + self.fDamageInterval
                ParticleManager_s2c:ToClient(function()
                    local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_7/fireing_target/fireing_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
                    ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
                end)
                ApplyDamage({
                    ability = hAblt,
                    attacker = hCaster,
                    victim = hTarget,
                    damage = fDmg,
                    damage_type = DAMAGE_TYPE_PURE
                })
            end
        end
    end
end
function boss_6_7_fire.prototype.OnDestroy(self)
    if IsServer() then
        local hAblt = self:GetAbility()
        hAblt.tFires[self] = nil
    end
end
boss_6_7_fire = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    boss_6_7_fire
)