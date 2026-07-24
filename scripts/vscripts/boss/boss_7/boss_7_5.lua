--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7_5"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 8,["16"] = 5,["17"] = 10,["18"] = 11,["19"] = 10,["20"] = 13,["21"] = 14,["22"] = 13,["23"] = 16,["24"] = 17,["25"] = 18,["26"] = 19,["28"] = 16,["29"] = 22,["30"] = 23,["31"] = 24,["32"] = 25,["33"] = 26,["34"] = 26,["35"] = 26,["36"] = 27,["37"] = 28,["38"] = 29,["39"] = 30,["41"] = 26,["42"] = 26,["43"] = 33,["44"] = 33,["45"] = 34,["46"] = 34,["47"] = 34,["48"] = 34,["49"] = 34,["50"] = 34,["51"] = 34,["52"] = 35,["53"] = 36,["54"] = 37,["56"] = 39,["57"] = 40,["58"] = 33,["59"] = 33,["60"] = 33,["61"] = 22,["62"] = 45,["63"] = 46,["64"] = 47,["65"] = 48,["66"] = 49,["67"] = 50,["68"] = 50,["69"] = 50,["70"] = 50,["71"] = 50,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 50,["76"] = 51,["77"] = 51,["78"] = 51,["79"] = 51,["80"] = 51,["81"] = 51,["82"] = 51,["83"] = 45,["84"] = 59,["85"] = 60,["86"] = 61,["87"] = 62,["88"] = 63,["89"] = 63,["90"] = 64,["91"] = 65,["92"] = 66,["93"] = 67,["94"] = 63,["95"] = 63,["96"] = 63,["97"] = 71,["99"] = 59,["100"] = 74,["101"] = 74,["102"] = 74,["104"] = 75,["105"] = 76,["106"] = 77,["107"] = 79,["108"] = 80,["111"] = 82,["112"] = 82,["113"] = 83,["114"] = 83,["115"] = 83,["116"] = 83,["117"] = 83,["118"] = 83,["119"] = 83,["120"] = 83,["121"] = 84,["122"] = 85,["123"] = 85,["124"] = 85,["125"] = 85,["126"] = 85,["127"] = 86,["128"] = 87,["129"] = 87,["130"] = 87,["131"] = 87,["132"] = 87,["133"] = 88,["134"] = 88,["135"] = 88,["136"] = 88,["137"] = 88,["138"] = 90,["139"] = 91,["140"] = 93,["142"] = 82,["145"] = 74,["146"] = 2,["147"] = 1,["148"] = 2,["150"] = 98,["151"] = 98,["152"] = 99,["153"] = 101,["154"] = 102,["155"] = 103,["156"] = 104,["158"] = 101,["159"] = 107,["160"] = 108,["161"] = 109,["162"] = 110,["163"] = 111,["164"] = 112,["165"] = 113,["168"] = 116,["169"] = 117,["170"] = 118,["171"] = 119,["172"] = 120,["173"] = 120,["174"] = 121,["175"] = 122,["176"] = 123,["177"] = 120,["178"] = 120,["179"] = 120,["181"] = 107,["182"] = 129,["183"] = 130,["184"] = 129,["185"] = 99,["186"] = 98,["187"] = 99});
boss_7_5 = __TS__Class()
boss_7_5.name = "boss_7_5"
__TS__ClassExtends(boss_7_5, BossAbility)
function boss_7_5.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_5/lizard_blobs_arced/lizard_blobs_arced.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_5/ultimate_impact/ultimate_impact.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_5/summon_familiars/summon_familiars.vpcf", context)
end
function boss_7_5.prototype.GetCastPoint(self)
    return 0
end
function boss_7_5.prototype.GetPlaybackRateOverride(self)
    return 1 / (self:GetChannelTime() / self.Values:egg_count())
end
function boss_7_5.prototype.OnChannelFinish(self, interrupted)
    if interrupted then
        local hCaster = self:GetCaster()
        hCaster:StopTimer(self.sGameTimerID)
    end
end
function boss_7_5.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local egg_count = self.Values:egg_count()
    local interval = self:GetChannelTime() / self.Values:egg_count()
    self.sGameTimerID = hCaster:GameTimer(
        0,
        function()
            self:_OnSpellStart()
            egg_count = egg_count - 1
            if egg_count > 0 then
                return interval
            end
        end
    )
    ParticleManager_s2c:ToClient(
        function()
            local tSound = {
                "Boss_7.Start_10",
                "Boss_7.Start_11",
                "Boss_7.Start_12",
                "Boss_7.Start_13",
                "Boss_7.Start_14"
            }
            local sSound = tSound[RandomInt(0, #tSound - 1) + 1]
            while self.sLastSound == sSound do
                sSound = tSound[RandomInt(0, #tSound - 1) + 1]
            end
            self.sLastSound = sSound
            ParticleManager_s2c:EmitSoundOn(sSound, hCaster)
        end,
        {weight = 0}
    )
end
function boss_7_5.prototype._OnSpellStart(self)
    local hCaster = self:GetCaster()
    local radius = self.Values:radius()
    local vStart = hCaster:GetAbsOrigin()
    local vPosition = vStart + RandomVector(RandomInt(0, radius))
    local hThinker = CreateModifierThinker(
        hCaster,
        self,
        "modifier_boss_7_5_thinker",
        {},
        vPosition,
        hCaster:GetTeamNumber(),
        false
    )
    ProjectileManager:CreateTrackingProjectile({
        Target = hThinker,
        Ability = self,
        vSourceLoc = vStart,
        EffectName = "particles/boss/boss_7/boss_7_5/lizard_blobs_arced/lizard_blobs_arced.vpcf",
        iMoveSpeed = 1000
    })
end
function boss_7_5.prototype.OnProjectileHit(self, target, location)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        UTIL_Remove(target)
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_5/ultimate_impact/ultimate_impact.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, location)
                ParticleManager_s2c:SetParticleControl(iParticleID, 3, location)
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        self:CreateSpiderEgg(location)
    end
end
function boss_7_5.prototype.CreateSpiderEgg(self, location, count)
    if count == nil then
        count = 1
    end
    local hCaster = self:GetCaster()
    local inherite_hp_pct = self.Values:inherite_hp_pct()
    local inherite_armor_pct = self.Values:inherite_armor_pct()
    if hCaster:HasModifier("modifier_boss_7_6_stack") then
        count = count + hCaster:GetModifierStackCount("modifier_boss_7_6_stack", hCaster)
    end
    do
        local i = 0
        while i < count do
            local hEgg = CreateUnitByName(
                "summon_boss_7_5",
                location + RandomInt(-200, 200),
                true,
                hCaster,
                hCaster,
                hCaster:GetTeamNumber()
            )
            if IsValid(hEgg) then
                FindClearSpaceForUnit(
                    hEgg,
                    hEgg:GetAbsOrigin(),
                    true
                )
                hEgg:AddAbility("attribute")
                AttributeKind.HpLimit.BONUS:Set(
                    hEgg,
                    AttributeKind.HpLimit:Get(hCaster) * inherite_hp_pct * 0.01,
                    "BASE1"
                )
                AttributeKind.Armor.BONUS:Set(
                    hEgg,
                    AttributeKind.Armor:Get(hCaster) * inherite_armor_pct * 0.01,
                    "BASE"
                )
                AttributeKind.HpLimit.BONUS:UpdateClient(hEgg, "BASE1")
                AttributeKind.Armor.BONUS:UpdateClient(hEgg, "BASE")
                hEgg:AddNewModifier(hCaster, self, "modifier_boss_7_5_egg", {})
            end
            i = i + 1
        end
    end
end
boss_7_5 = __TS__DecorateLegacy(
    {register(_G)},
    boss_7_5
)
modifier_boss_7_5_egg = __TS__Class()
modifier_boss_7_5_egg.name = "modifier_boss_7_5_egg"
__TS__ClassExtends(modifier_boss_7_5_egg, BaseModifier)
function modifier_boss_7_5_egg.prototype.OnCreated(self, params)
    if IsServer() then
        self.count = self.Values:count()
        self:StartIntervalThink(self.Values:interval())
    end
end
function modifier_boss_7_5_egg.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if not IsValid(hCaster) or not hCaster:IsAlive() then
        UTIL_Remove(hParent)
        self:StartIntervalThink(-1)
        return
    end
    local hAbility1 = hCaster:FindAbilityByName("boss_7_1")
    if IsValid(hAbility1) and hAbility1.CreateSpiderling then
        local vPosition = hParent:GetAbsOrigin()
        hAbility1.CreateSpiderling(hAbility1, vPosition, self.count)
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_5/summon_familiars/summon_familiars.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
    end
end
function modifier_boss_7_5_egg.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
modifier_boss_7_5_egg = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_5_egg
)