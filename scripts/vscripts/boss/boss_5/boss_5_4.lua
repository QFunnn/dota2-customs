--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 6,["13"] = 7,["14"] = 8,["15"] = 9,["16"] = 6,["17"] = 11,["18"] = 12,["19"] = 13,["20"] = 14,["21"] = 15,["22"] = 16,["23"] = 17,["25"] = 18,["26"] = 18,["27"] = 19,["28"] = 20,["29"] = 20,["30"] = 21,["31"] = 22,["32"] = 22,["33"] = 22,["34"] = 22,["35"] = 22,["36"] = 23,["37"] = 23,["38"] = 23,["39"] = 23,["40"] = 23,["41"] = 24,["42"] = 25,["43"] = 25,["44"] = 25,["45"] = 25,["46"] = 25,["47"] = 25,["48"] = 25,["49"] = 25,["50"] = 25,["51"] = 26,["52"] = 26,["53"] = 26,["55"] = 27,["56"] = 27,["57"] = 28,["58"] = 29,["59"] = 29,["60"] = 29,["61"] = 30,["62"] = 31,["63"] = 32,["64"] = 33,["65"] = 33,["66"] = 33,["67"] = 33,["68"] = 33,["69"] = 32,["70"] = 29,["71"] = 29,["72"] = 27,["75"] = 26,["76"] = 26,["77"] = 38,["78"] = 38,["79"] = 20,["80"] = 20,["81"] = 20,["82"] = 18,["85"] = 43,["86"] = 43,["87"] = 44,["88"] = 45,["89"] = 45,["90"] = 45,["91"] = 45,["92"] = 45,["93"] = 43,["94"] = 43,["95"] = 43,["96"] = 49,["97"] = 50,["98"] = 11,["99"] = 52,["100"] = 53,["101"] = 54,["103"] = 55,["104"] = 55,["105"] = 56,["106"] = 56,["107"] = 57,["108"] = 56,["109"] = 56,["110"] = 56,["111"] = 55,["114"] = 62,["115"] = 62,["116"] = 63,["117"] = 62,["118"] = 62,["119"] = 62,["120"] = 67,["121"] = 52,["122"] = 69,["123"] = 70,["124"] = 69,["125"] = 72,["126"] = 73,["127"] = 74,["129"] = 75,["130"] = 75,["131"] = 76,["132"] = 76,["133"] = 77,["134"] = 76,["135"] = 76,["136"] = 76,["137"] = 75,["140"] = 82,["141"] = 82,["142"] = 83,["143"] = 82,["144"] = 82,["145"] = 82,["146"] = 87,["147"] = 72,["148"] = 89,["149"] = 90,["150"] = 91,["151"] = 92,["152"] = 89,["153"] = 3,["154"] = 2,["155"] = 3,["157"] = 95,["158"] = 95,["159"] = 96,["160"] = 107,["161"] = 108,["162"] = 107,["163"] = 110,["164"] = 111,["165"] = 110,["166"] = 113,["167"] = 114,["168"] = 115,["169"] = 116,["170"] = 117,["171"] = 118,["172"] = 119,["173"] = 120,["174"] = 121,["175"] = 122,["176"] = 123,["177"] = 124,["178"] = 125,["180"] = 126,["181"] = 126,["182"] = 127,["183"] = 128,["184"] = 129,["185"] = 129,["186"] = 129,["187"] = 129,["188"] = 129,["189"] = 129,["190"] = 129,["191"] = 129,["192"] = 129,["193"] = 130,["194"] = 130,["195"] = 130,["196"] = 130,["197"] = 130,["198"] = 130,["199"] = 130,["200"] = 130,["201"] = 130,["202"] = 126,["205"] = 132,["206"] = 133,["207"] = 134,["209"] = 113,["210"] = 137,["211"] = 138,["212"] = 139,["213"] = 140,["214"] = 141,["215"] = 142,["217"] = 143,["218"] = 143,["219"] = 144,["220"] = 145,["221"] = 146,["222"] = 146,["223"] = 146,["224"] = 146,["225"] = 146,["226"] = 146,["227"] = 146,["228"] = 146,["229"] = 146,["230"] = 147,["231"] = 147,["232"] = 147,["233"] = 147,["234"] = 147,["235"] = 147,["236"] = 147,["237"] = 147,["238"] = 147,["239"] = 148,["240"] = 148,["241"] = 149,["242"] = 149,["243"] = 149,["244"] = 149,["245"] = 149,["246"] = 150,["247"] = 150,["248"] = 150,["249"] = 150,["250"] = 150,["251"] = 148,["252"] = 148,["253"] = 148,["254"] = 154,["255"] = 154,["256"] = 154,["257"] = 154,["258"] = 154,["259"] = 154,["260"] = 154,["261"] = 154,["262"] = 155,["263"] = 156,["264"] = 157,["265"] = 157,["266"] = 157,["267"] = 157,["268"] = 157,["269"] = 157,["270"] = 157,["271"] = 164,["272"] = 164,["273"] = 165,["274"] = 166,["275"] = 166,["276"] = 166,["277"] = 166,["278"] = 166,["279"] = 167,["280"] = 164,["281"] = 164,["282"] = 164,["284"] = 143,["287"] = 174,["288"] = 175,["289"] = 176,["290"] = 177,["291"] = 178,["293"] = 180,["294"] = 181,["299"] = 137,["300"] = 187,["301"] = 188,["303"] = 187,["304"] = 96,["305"] = 95,["306"] = 96});
boss_5_4 = __TS__Class()
boss_5_4.name = "boss_5_4"
__TS__ClassExtends(boss_5_4, BaseAbility)
function boss_5_4.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_4/sunray/sunray.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_4/a/a.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_4/hit/hit.vpcf", context)
end
function boss_5_4.prototype.OnAbilityPhaseStart(self)
    self.tParticleIDs = {}
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local iCount = self.Values:count()
    local dis = self.Values:distance()
    local vDir = Vector(0, 0, 1)
    do
        local i = 0
        while i < iCount do
            local index = i
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_4/sunray/sunray.vpcf", PATTACH_ABSORIGIN, hCaster)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        0,
                        vStartPosition + Vector(0, 0, 256)
                    )
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        1,
                        vStartPosition + Vector(0, 0, dis)
                    )
                    ParticleManager_s2c:SetParticleControl(iParticleID, 4, vStartPosition)
                    ParticleManager_s2c:SetParticleControlEnt(
                        iParticleID,
                        9,
                        hCaster,
                        PATTACH_POINT_FOLLOW,
                        "attach_hitloc",
                        hCaster:GetAbsOrigin(),
                        true
                    )
                    self:GameTimer(
                        1,
                        function()
                            do
                                local j = 1
                                while j <= 90 do
                                    local count = j
                                    self:GameTimer(
                                        self:GetCastPoint() / 2 / 90 * count,
                                        function()
                                            local vTempDiretion = RotateY(_G, vDir, count)
                                            vTempDiretion = RotateZ(_G, vTempDiretion, 360 / iCount * index)
                                            ParticleManager_s2c:ToClient(function()
                                                ParticleManager_s2c:SetParticleControl(
                                                    iParticleID,
                                                    1,
                                                    hCaster:GetAbsOrigin() + vTempDiretion * dis + Vector(0, 0, 256)
                                                )
                                            end)
                                        end
                                    )
                                    j = j + 1
                                end
                            end
                        end
                    )
                    local ____self_tParticleIDs_0 = self.tParticleIDs
                    ____self_tParticleIDs_0[#____self_tParticleIDs_0 + 1] = iParticleID
                end,
                {weight = 0}
            )
            i = i + 1
        end
    end
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_4/a/a.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                1,
                Vector(500, 0, 0)
            )
        end,
        {weight = 0}
    )
    hCaster:EmitSound("Hero_Phoenix.SunRay.Loop")
    return true
end
function boss_5_4.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    local iCount = self.Values:count()
    do
        local i = 0
        while i < iCount do
            ParticleManager_s2c:ToClient(
                function()
                    ParticleManager_s2c:DestroyParticle(self.tParticleIDs[i + 1], false)
                end,
                {weight = 0}
            )
            i = i + 1
        end
    end
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, false)
        end,
        {weight = 0}
    )
    hCaster:EmitSound("Hero_Phoenix.SunRay.Stop")
end
function boss_5_4.prototype.GetChannelTime(self)
    return self.Values:change_count() * self.Values:change_interval()
end
function boss_5_4.prototype.OnChannelFinish(self, interrupted)
    local hCaster = self:GetCaster()
    local iCount = self.Values:count()
    do
        local i = 0
        while i < iCount do
            ParticleManager_s2c:ToClient(
                function()
                    ParticleManager_s2c:DestroyParticle(self.tParticleIDs[i + 1], false)
                end,
                {weight = 0}
            )
            i = i + 1
        end
    end
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, false)
        end,
        {weight = 0}
    )
    hCaster:EmitSound("Hero_Phoenix.SunRay.Stop")
end
function boss_5_4.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local change_interval = self.Values:change_interval()
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_5_4_turn", {duration = change_interval})
end
boss_5_4 = __TS__DecorateLegacy(
    {register(_G)},
    boss_5_4
)
modifier_boss_5_4_turn = __TS__Class()
modifier_boss_5_4_turn.name = "modifier_boss_5_4_turn"
__TS__ClassExtends(modifier_boss_5_4_turn, BaseModifier)
function modifier_boss_5_4_turn.prototype.IsHidden(self)
    return false
end
function modifier_boss_5_4_turn.prototype.DestroyOnExpire(self)
    return false
end
function modifier_boss_5_4_turn.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        local vStartPosition = hParent:GetAbsOrigin()
        self.dis = self.Values:distance()
        self.iDirection = RandomInt(0, 100) > 50 and 1 or -1
        self.fRollSpeed = self.Values:roll_speed()
        self.iWidth = self.Values:width()
        self.fChangeCount = self.Values:change_count()
        self.fCount = self.Values:count()
        self.vDirection = Vector(1, 0, 0)
        self.dmg_factor = self.Values:dmg_factor()
        self.fAngleSpeed = self.fRollSpeed / (2 * math.pi * self.dis) * 360 * (1 / 30)
        do
            local i = 0
            while i < self.fCount do
                local vTempDiretion = Rotation2D(self.vDirection, 360 / self.fCount * i)
                local vEndPosition = vStartPosition + vTempDiretion * self.dis
                DebugDrawLine(
                    vStartPosition + Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    vEndPosition + Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    255,
                    255,
                    255,
                    true,
                    FrameTime()
                )
                DebugDrawLine(
                    vStartPosition - Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    vEndPosition - Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    255,
                    255,
                    255,
                    true,
                    FrameTime()
                )
                i = i + 1
            end
        end
        self.fTime = GameRules:GetGameTime() + self:GetDuration()
        self:OnIntervalThink()
        self:StartIntervalThink(0)
    end
end
function modifier_boss_5_4_turn.prototype.OnIntervalThink(self)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        local vStartPosition = hParent:GetAbsOrigin()
        self.vDirection = Rotation2D(self.vDirection, self.fAngleSpeed * self.iDirection)
        do
            local i = 0
            while i < self.fCount do
                local vTempDiretion = Rotation2D(self.vDirection, 360 / self.fCount * i)
                local vEndPosition = vStartPosition + vTempDiretion * self.dis
                DebugDrawLine(
                    vStartPosition + Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    vEndPosition + Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    255,
                    255,
                    255,
                    true,
                    FrameTime()
                )
                DebugDrawLine(
                    vStartPosition - Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    vEndPosition - Rotation2D(vTempDiretion, 90) * self.iWidth / 2,
                    255,
                    255,
                    255,
                    true,
                    FrameTime()
                )
                ParticleManager_s2c:ToClient(
                    function()
                        ParticleManager_s2c:SetParticleControl(
                            hAbility.tParticleIDs[i + 1],
                            0,
                            vStartPosition + Vector(0, 0, 256)
                        )
                        ParticleManager_s2c:SetParticleControl(
                            hAbility.tParticleIDs[i + 1],
                            1,
                            vEndPosition + Vector(0, 0, 256)
                        )
                    end,
                    {weight = 0}
                )
                local tTargets = FindUnitsInLineWithAbility(
                    _G,
                    hParent,
                    hAbility,
                    vStartPosition,
                    vEndPosition,
                    self.iWidth
                )
                local fDamage = AttributeKind.Atk:Get(hParent) * self.dmg_factor
                for _, hTarget in pairs(tTargets) do
                    ApplyDamage({
                        ability = hAbility,
                        attacker = hParent,
                        victim = hTarget,
                        damage = fDamage,
                        damage_type = hAbility:GetAbilityDamageType()
                    })
                    ParticleManager_s2c:ToClient(
                        function()
                            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_4/hit/hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
                            ParticleManager_s2c:SetParticleControl(
                                iParticleID,
                                1,
                                vStartPosition + Vector(0, 0, 256)
                            )
                            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                        end,
                        {weight = 0}
                    )
                end
                i = i + 1
            end
        end
        if self.fTime <= GameRules:GetGameTime() then
            self.fChangeCount = self.fChangeCount - 1
            if self.fChangeCount > 0 then
                self.fTime = GameRules:GetGameTime() + self:GetDuration()
                self.iDirection = RandomInt(0, 100) > 50 and 1 or -1
            else
                self:StartIntervalThink(-1)
                self:Destroy()
                return
            end
        end
    end
end
function modifier_boss_5_4_turn.prototype.OnDestroy(self)
    if IsServer() then
    end
end
modifier_boss_5_4_turn = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_4_turn
)