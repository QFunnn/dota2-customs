--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_6"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayFindIndex = ____lualib.__TS__ArrayFindIndex
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["14"] = 3,["15"] = 10,["16"] = 2,["17"] = 4,["18"] = 5,["19"] = 6,["20"] = 4,["21"] = 12,["22"] = 13,["23"] = 14,["24"] = 15,["25"] = 16,["27"] = 18,["29"] = 20,["30"] = 12,["31"] = 23,["32"] = 24,["33"] = 23,["34"] = 27,["35"] = 28,["36"] = 29,["37"] = 30,["38"] = 32,["39"] = 32,["40"] = 34,["41"] = 37,["42"] = 38,["43"] = 38,["44"] = 38,["45"] = 38,["46"] = 38,["47"] = 38,["48"] = 38,["49"] = 38,["50"] = 38,["51"] = 39,["52"] = 32,["53"] = 32,["54"] = 32,["55"] = 44,["56"] = 46,["57"] = 27,["58"] = 49,["59"] = 50,["60"] = 51,["61"] = 52,["62"] = 53,["64"] = 55,["66"] = 49,["67"] = 59,["68"] = 60,["69"] = 61,["70"] = 63,["71"] = 65,["72"] = 65,["73"] = 65,["74"] = 65,["75"] = 65,["76"] = 65,["77"] = 65,["78"] = 65,["79"] = 66,["80"] = 67,["81"] = 59,["82"] = 70,["83"] = 71,["84"] = 73,["85"] = 74,["86"] = 75,["90"] = 70,["91"] = 82,["92"] = 84,["93"] = 85,["94"] = 85,["95"] = 85,["96"] = 86,["97"] = 87,["98"] = 88,["99"] = 88,["100"] = 88,["101"] = 88,["102"] = 89,["105"] = 85,["106"] = 85,["107"] = 93,["108"] = 94,["110"] = 82,["111"] = 3,["112"] = 2,["113"] = 3,["115"] = 101,["116"] = 101,["117"] = 102,["118"] = 103,["119"] = 103,["120"] = 103,["121"] = 104,["122"] = 104,["123"] = 104,["124"] = 106,["125"] = 107,["126"] = 108,["127"] = 109,["129"] = 111,["130"] = 112,["131"] = 112,["132"] = 112,["133"] = 112,["134"] = 112,["135"] = 112,["136"] = 112,["137"] = 112,["139"] = 106,["140"] = 116,["141"] = 117,["142"] = 118,["144"] = 116,["145"] = 102,["146"] = 101,["147"] = 102,["149"] = 124,["150"] = 124,["151"] = 125,["153"] = 125,["154"] = 136,["155"] = 124,["156"] = 126,["157"] = 126,["158"] = 126,["159"] = 141,["160"] = 142,["161"] = 143,["162"] = 144,["163"] = 146,["164"] = 147,["166"] = 150,["167"] = 151,["168"] = 152,["169"] = 153,["170"] = 155,["171"] = 157,["172"] = 159,["173"] = 160,["175"] = 162,["178"] = 165,["179"] = 166,["180"] = 166,["181"] = 166,["182"] = 166,["183"] = 166,["184"] = 166,["185"] = 166,["186"] = 166,["187"] = 166,["188"] = 167,["189"] = 168,["190"] = 168,["191"] = 168,["192"] = 168,["193"] = 168,["195"] = 170,["196"] = 170,["197"] = 170,["198"] = 170,["199"] = 170,["200"] = 170,["201"] = 170,["202"] = 170,["204"] = 141,["205"] = 174,["206"] = 175,["207"] = 176,["208"] = 177,["209"] = 178,["210"] = 179,["212"] = 181,["215"] = 184,["216"] = 185,["217"] = 186,["218"] = 187,["219"] = 188,["222"] = 174,["223"] = 193,["224"] = 194,["225"] = 196,["226"] = 198,["227"] = 199,["229"] = 201,["233"] = 206,["234"] = 208,["235"] = 209,["236"] = 210,["237"] = 211,["238"] = 211,["239"] = 211,["240"] = 211,["241"] = 211,["242"] = 211,["243"] = 212,["245"] = 215,["248"] = 218,["250"] = 221,["251"] = 222,["252"] = 223,["253"] = 224,["254"] = 227,["255"] = 227,["256"] = 227,["257"] = 227,["258"] = 227,["259"] = 227,["260"] = 227,["261"] = 227,["262"] = 227,["263"] = 227,["264"] = 227,["265"] = 234,["266"] = 235,["267"] = 236,["268"] = 238,["269"] = 239,["270"] = 240,["272"] = 242,["273"] = 243,["274"] = 245,["275"] = 246,["278"] = 249,["279"] = 249,["280"] = 249,["281"] = 249,["282"] = 249,["283"] = 249,["284"] = 249,["285"] = 251,["286"] = 252,["287"] = 253,["288"] = 253,["289"] = 253,["290"] = 253,["291"] = 253,["292"] = 253,["293"] = 253,["298"] = 266,["299"] = 267,["300"] = 268,["301"] = 269,["302"] = 271,["303"] = 271,["304"] = 271,["305"] = 271,["306"] = 271,["307"] = 271,["308"] = 271,["309"] = 271,["310"] = 272,["311"] = 274,["312"] = 277,["313"] = 278,["314"] = 279,["315"] = 280,["316"] = 281,["318"] = 283,["320"] = 285,["322"] = 288,["323"] = 292,["325"] = 294,["328"] = 193,["329"] = 299,["330"] = 300,["331"] = 300,["332"] = 300,["333"] = 300,["334"] = 300,["335"] = 300,["336"] = 300,["337"] = 299,["338"] = 309,["339"] = 310,["340"] = 309,["341"] = 317,["342"] = 318,["343"] = 319,["344"] = 321,["346"] = 323,["349"] = 326,["350"] = 317,["351"] = 125,["352"] = 124,["353"] = 125});
boss_6_6 = __TS__Class()
boss_6_6.name = "boss_6_6"
__TS__ClassExtends(boss_6_6, BossAbility)
function boss_6_6.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tCyclones = {}
end
function boss_6_6.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_6/target_mark/target_mark.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_6/cyclone/cyclone.vpcf", context)
end
function boss_6_6.prototype.CastFilterResult(self)
    if IsServer() then
        self.hCursorTarget = self:FindTarget()
        if self.hCursorTarget ~= nil then
            return UF_SUCCESS
        end
        return UF_FAIL_CUSTOM
    end
    return UF_SUCCESS
end
function boss_6_6.prototype.GetPlaybackRateOverride(self)
    return 3 / self:GetCastPoint()
end
function boss_6_6.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local hTarget = self.hCursorTarget
    local fCastPoint = self:GetCastPoint()
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:EmitSoundOn("Hero_Lycan.Howl", hCaster)
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/warning/circular_2/circular_2.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                2,
                Vector(
                    hTarget:GetModelRadius(),
                    fCastPoint,
                    0
                )
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
        end,
        {weight = 0}
    )
    hTarget:AddPolymer(hCaster, self, "modifier_boss_6_6_target_debuff", nil)
    return true
end
function boss_6_6.prototype.OnAbilityPhaseInterrupted(self)
    local hTarget = self.hCursorTarget
    local hPlm = hTarget:FindPolymer("modifier_boss_6_6_target_debuff")
    if hPlm == nil or hPlm:GetStackCount() <= 1 then
        hTarget:RemovePolymer("modifier_boss_6_6_target_debuff")
    else
        hPlm:DecrementStackCount()
    end
end
function boss_6_6.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local hTarget = self.hCursorTarget
    local vPos = (hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized() * 300 + hCaster:GetAbsOrigin()
    local hCyclone = CreateUnitByName(
        "npc_dummy_unit",
        vPos,
        false,
        hCaster,
        hCaster,
        hCaster:GetTeamNumber()
    )
    hCyclone:AddNewModifier(hTarget, self, "modifier_boss_6_6_cyclone", nil)
    self.tCyclones[hCyclone:GetEntityIndex()] = hCyclone
end
function boss_6_6.prototype.OnDestroy(self)
    if IsServer() then
        for _, hCyclone in pairs(self.tCyclones) do
            if IsValid(hCyclone) then
                hCyclone:ForceKill(false)
            end
        end
    end
end
function boss_6_6.prototype.FindTarget(self, tIgnore)
    local t = {}
    EachPlayer(
        _G,
        function(____, iPlayerID)
            local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
            if hHero ~= nil and hHero:IsAlive() then
                if tIgnore == nil or __TS__ArrayFindIndex(
                    tIgnore,
                    function(____, v) return v == hHero end
                ) == -1 then
                    t[#t + 1] = hHero
                end
            end
        end
    )
    if #t > 0 then
        return t[RandomInt(0, #t - 1) + 1]
    end
end
boss_6_6 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_6
)
modifier_boss_6_6_target_debuff = __TS__Class()
modifier_boss_6_6_target_debuff.name = "modifier_boss_6_6_target_debuff"
__TS__ClassExtends(modifier_boss_6_6_target_debuff, DiyPolymer)
function modifier_boss_6_6_target_debuff.prototype.IsHidden(self)
    return false
end
function modifier_boss_6_6_target_debuff.prototype.IsDebuff(self)
    return true
end
function modifier_boss_6_6_target_debuff.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        self:SetStackCount(1)
    else
        local iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/boss_6_6/target_mark/target_mark.vpcf", PATTACH_OVERHEAD_FOLLOW, hParent)
        self:AddParticle(
            iPtclID,
            false,
            false,
            -1,
            false,
            true
        )
    end
end
function modifier_boss_6_6_target_debuff.prototype.OnRefresh(self, params)
    if IsServer() then
        self:IncrementStackCount()
    end
end
modifier_boss_6_6_target_debuff = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    modifier_boss_6_6_target_debuff
)
modifier_boss_6_6_cyclone = __TS__Class()
modifier_boss_6_6_cyclone.name = "modifier_boss_6_6_cyclone"
__TS__ClassExtends(modifier_boss_6_6_cyclone, DiyModifier)
function modifier_boss_6_6_cyclone.prototype.____constructor(self, ...)
    DiyModifier.prototype.____constructor(self, ...)
    self.tDamageTargetTime = {}
end
function modifier_boss_6_6_cyclone.prototype.IsHidden(self)
    return true
end
function modifier_boss_6_6_cyclone.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        hParent:SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
        if self:GetCaster() ~= hParent then
            self.hTarget = self:GetCaster()
        end
        self.fSpeed = self.Values:speed()
        self.fSpeedA = self.Values:speed_a()
        self.fRange = self.Values:range()
        self.fDamageInterval = self.Values:dmg_interval()
        self:StartIntervalThink(0.1)
        if params.is_cleave == 1 then
            self:SetStackCount(1)
            self.vCleavePos = StringToVector(_G, params.cleave_pos)
        else
            self.fCleaveTime = self.Values:cleave_time()
        end
    else
        local iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/boss_6_6/cyclone/cyclone.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControl(
            iPtclID,
            2,
            Vector(
                self.Values:range(),
                0,
                0
            )
        )
        if self:GetStackCount() == 1 then
            ParticleManager:SetParticleControl(
                iPtclID,
                61,
                Vector(1, 0, 0)
            )
        end
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
function modifier_boss_6_6_cyclone.prototype.OnDestroy(self)
    if IsServer() then
        if IsValid(self.hTarget) then
            local hPlm = self.hTarget:FindPolymer("modifier_boss_6_6_target_debuff")
            if hPlm == nil or hPlm:GetStackCount() <= 1 then
                self.hTarget:RemovePolymer("modifier_boss_6_6_target_debuff")
            else
                hPlm:DecrementStackCount()
            end
        end
        local hParent = self:GetParent()
        if IsValid(hParent) then
            local hAblt = self:GetAbility()
            hAblt.tCyclones[hParent:GetEntityIndex()] = nil
            hParent:ForceKill(false)
        end
    end
end
function modifier_boss_6_6_cyclone.prototype.OnIntervalThink(self)
    local hParent = self:GetParent()
    if self.vCleavePos ~= nil then
        if (hParent:GetAbsOrigin() - self.vCleavePos):Length2D() < 32 then
            self.vCleavePos = nil
        else
            hParent:MoveToPosition(self.vCleavePos)
        end
        return
    end
    if not IsValid(self.hTarget) or not self.hTarget:IsAlive() then
        local hAblt = self:GetAbility()
        self.hTarget = hAblt:FindTarget()
        if self.hTarget then
            self.hTarget:AddPolymer(
                hAblt:GetCaster(),
                hAblt,
                "modifier_boss_6_6_target_debuff",
                nil
            )
            hParent:MoveToPosition(self.hTarget:GetAbsOrigin())
        else
            hParent:MoveToPosition(hParent:GetAbsOrigin())
        end
    else
        hParent:MoveToPosition(self.hTarget:GetAbsOrigin())
    end
    local hAblt = self:GetAbility()
    local hCaster = hAblt:GetCaster()
    local iTeam = hParent:GetTeamNumber()
    local fDmg = self.Values:damage_factor() * AttributeKind.Atk:Get(hCaster)
    for ____, hUnit in ipairs(FindUnitsInRadius(
        iTeam,
        hParent:GetAbsOrigin(),
        nil,
        self.fRange,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        FIND_CLOSEST,
        false
    )) do
        if IsValid(hUnit) and hUnit ~= hParent then
            if hUnit:GetTeamNumber() == iTeam then
                if hUnit:FindModifierByName("modifier_boss_6_4_meteor") ~= nil then
                    hUnit:SetForwardVector(hParent:GetForwardVector())
                    hUnit:ForceKill(false)
                    return self:Destroy()
                else
                    local hMdf = hUnit:FindModifierByName("modifier_boss_6_6_cyclone")
                    if hMdf ~= nil and hMdf.vCleavePos == nil then
                        hUnit:ForceKill(false)
                        return self:Destroy()
                    end
                end
            elseif UnitFilter(
                hUnit,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
                DOTA_UNIT_TARGET_FLAG_NONE,
                iTeam
            ) == UF_SUCCESS then
                if self.tDamageTargetTime[hUnit:entindex()] == nil or self.tDamageTargetTime[hUnit:entindex()] <= GameRules:GetGameTime() then
                    self.tDamageTargetTime[hUnit:entindex()] = GameRules:GetGameTime() + self.fDamageInterval
                    ApplyDamage({
                        ability = hAblt,
                        attacker = hCaster,
                        damage_type = hAblt:GetAbilityDamageType(),
                        victim = hUnit,
                        damage = fDmg
                    })
                end
            end
        end
    end
    if self.fCleaveTime ~= nil then
        if self.fCleaveTime <= 0.1 then
            self.fCleaveTime = nil
            local hAblt = self:GetAbility()
            local hCyclone = CreateUnitByName(
                "npc_dummy_unit",
                hParent:GetAbsOrigin(),
                false,
                hCaster,
                hCaster,
                hCaster:GetTeamNumber()
            )
            hAblt.tCyclones[hCyclone:GetEntityIndex()] = hCyclone
            local vPos
            local hTarget = hAblt:FindTarget({self.hTarget}) or self.hTarget
            if hTarget ~= nil then
                local vDir = (hTarget:GetAbsOrigin() - hParent:GetAbsOrigin()):Normalized()
                if vDir.x == 0 and vDir.y == 0 then
                    vDir = hTarget:GetForwardVector()
                end
                vPos = vDir * self.fRange * 2 + hParent:GetAbsOrigin()
            else
                vPos = RandomVector(self.fRange * 2) + hParent:GetAbsOrigin()
            end
            local hMdf = hCyclone:AddNewModifier(hTarget or hCyclone, hAblt, "modifier_boss_6_6_cyclone", {is_cleave = true, cleave_pos = vPos})
            hMdf.fSpeed = self.fSpeed + self:GetElapsedTime() * self.fSpeedA
        else
            self.fCleaveTime = self.fCleaveTime - 0.1
        end
    end
end
function modifier_boss_6_6_cyclone.prototype.CheckState(self)
    return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_TEAM_SELECT] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
    }
end
function modifier_boss_6_6_cyclone.prototype.DDeclareFunctions(self)
    return {[""] = {MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE}}
end
function modifier_boss_6_6_cyclone.prototype.GetModifierMoveSpeed_Absolute(self)
    if IsServer() then
        if self.vCleavePos ~= nil then
            return (self:GetParent():GetAbsOrigin() - self.vCleavePos):Length2D() * 10
        else
            return self.fSpeed + self:GetElapsedTime() * self.fSpeedA
        end
    end
    return 0
end
modifier_boss_6_6_cyclone = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_6_6_cyclone
)