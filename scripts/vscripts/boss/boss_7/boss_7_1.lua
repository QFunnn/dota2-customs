--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["12"] = 2,["13"] = 2,["14"] = 3,["16"] = 3,["17"] = 7,["18"] = 2,["19"] = 8,["20"] = 9,["21"] = 10,["22"] = 11,["23"] = 12,["24"] = 8,["25"] = 14,["26"] = 15,["27"] = 14,["28"] = 17,["29"] = 18,["30"] = 19,["31"] = 20,["32"] = 22,["33"] = 22,["34"] = 23,["35"] = 24,["36"] = 25,["37"] = 26,["38"] = 26,["39"] = 26,["40"] = 26,["41"] = 26,["42"] = 27,["43"] = 27,["44"] = 27,["45"] = 27,["46"] = 27,["47"] = 27,["48"] = 27,["49"] = 28,["50"] = 29,["51"] = 30,["53"] = 32,["54"] = 33,["55"] = 22,["56"] = 22,["57"] = 22,["58"] = 37,["59"] = 37,["60"] = 37,["61"] = 38,["62"] = 38,["63"] = 39,["64"] = 40,["65"] = 40,["66"] = 40,["67"] = 40,["68"] = 40,["69"] = 41,["70"] = 42,["71"] = 43,["72"] = 38,["73"] = 38,["74"] = 38,["75"] = 37,["76"] = 37,["77"] = 49,["78"] = 17,["79"] = 51,["80"] = 52,["81"] = 53,["82"] = 54,["83"] = 53,["84"] = 56,["85"] = 57,["86"] = 51,["87"] = 59,["88"] = 60,["89"] = 61,["90"] = 62,["91"] = 63,["92"] = 64,["93"] = 65,["94"] = 65,["95"] = 65,["96"] = 65,["97"] = 65,["98"] = 65,["99"] = 65,["100"] = 65,["101"] = 65,["102"] = 65,["103"] = 65,["104"] = 76,["105"] = 77,["106"] = 78,["107"] = 78,["108"] = 78,["109"] = 78,["111"] = 80,["112"] = 80,["113"] = 81,["114"] = 82,["115"] = 83,["116"] = 83,["117"] = 83,["118"] = 83,["119"] = 83,["120"] = 84,["121"] = 85,["122"] = 80,["123"] = 80,["124"] = 80,["125"] = 59,["126"] = 90,["127"] = 91,["128"] = 92,["129"] = 93,["130"] = 94,["131"] = 95,["132"] = 96,["133"] = 97,["134"] = 98,["135"] = 99,["136"] = 99,["137"] = 100,["138"] = 101,["139"] = 102,["140"] = 103,["141"] = 99,["142"] = 99,["143"] = 99,["144"] = 108,["145"] = 109,["148"] = 111,["149"] = 111,["150"] = 112,["151"] = 113,["152"] = 113,["153"] = 113,["154"] = 113,["155"] = 113,["156"] = 113,["157"] = 113,["158"] = 113,["159"] = 114,["160"] = 115,["161"] = 115,["162"] = 115,["163"] = 115,["164"] = 115,["165"] = 116,["166"] = 116,["167"] = 116,["168"] = 116,["169"] = 116,["170"] = 117,["171"] = 117,["172"] = 117,["173"] = 117,["174"] = 117,["175"] = 119,["176"] = 119,["177"] = 119,["178"] = 119,["179"] = 119,["180"] = 120,["181"] = 120,["182"] = 120,["183"] = 120,["184"] = 120,["185"] = 122,["186"] = 123,["187"] = 124,["188"] = 126,["189"] = 127,["190"] = 129,["191"] = 130,["192"] = 130,["194"] = 111,["197"] = 90,["198"] = 134,["199"] = 135,["200"] = 134,["201"] = 139,["202"] = 140,["203"] = 140,["204"] = 140,["205"] = 140,["206"] = 141,["207"] = 141,["208"] = 141,["209"] = 141,["210"] = 141,["211"] = 141,["212"] = 141,["214"] = 139,["215"] = 3,["216"] = 2,["217"] = 3,["219"] = 145,["220"] = 145,["221"] = 146,["222"] = 149,["223"] = 150,["224"] = 149,["225"] = 152,["226"] = 153,["227"] = 154,["228"] = 155,["229"] = 156,["231"] = 158,["232"] = 158,["233"] = 158,["234"] = 158,["235"] = 158,["236"] = 159,["237"] = 159,["238"] = 159,["239"] = 159,["240"] = 159,["241"] = 159,["242"] = 159,["243"] = 159,["245"] = 152,["246"] = 162,["247"] = 163,["248"] = 164,["249"] = 165,["250"] = 166,["251"] = 167,["254"] = 170,["255"] = 170,["256"] = 170,["257"] = 170,["258"] = 170,["259"] = 170,["260"] = 170,["261"] = 162,["262"] = 146,["263"] = 145,["264"] = 146,["266"] = 179,["267"] = 179,["268"] = 180,["269"] = 181,["270"] = 182,["271"] = 183,["272"] = 184,["274"] = 181,["275"] = 180,["276"] = 179,["277"] = 180});
boss_7_1 = __TS__Class()
boss_7_1.name = "boss_7_1"
__TS__ClassExtends(boss_7_1, DiyAbility)
function boss_7_1.prototype.____constructor(self, ...)
    DiyAbility.prototype.____constructor(self, ...)
    self.tSpiderling = {}
end
function boss_7_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_1/spray_cast/spray_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_spiderlings_spawn.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_1/spiderlings_spawn/spiderlings_spawn.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/broodmother/bm_lycosidaes/bm_lycosidaes_spiderlings_debuff.vpcf", context)
end
function boss_7_1.prototype.GetPlaybackRateOverride(self)
    return 0.7 / self:GetCastPoint()
end
function boss_7_1.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local vPostion = self:GetCursorPosition()
    ParticleManager_s2c:ToClient(
        function()
            local fRange = self.Values:radius()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vPostion)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(fRange, fCastPoint, 1 / fCastPoint)
            )
            local tSound = {
                "Boss_7_1.Cast.Start_1",
                "Boss_7_1.Cast.Start_2",
                "Boss_7_1.Cast.Start_3",
                "Boss_7_1.Cast.Start_4",
                "Boss_7_1.Cast.Start_5"
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
    self.sGameTimerID = hCaster:GameTimer(
        fCastPoint - 0.3,
        function()
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_1/spray_cast/spray_cast.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        0,
                        hCaster:GetAbsOrigin()
                    )
                    ParticleManager_s2c:SetParticleControl(iParticleID, 1, vPostion)
                    ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                    ParticleManager_s2c:EmitSoundOn("Boss_2_1.Cast", hCaster)
                end,
                {weight = 0}
            )
        end
    )
    return true
end
function boss_7_1.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(function()
        ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
    end)
    hCaster:StopTimer(self.sGameTimerID)
    hCaster:StopSound(self.sLastSound)
end
function boss_7_1.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vPostion = self:GetCursorPosition()
    local fRadius = self.Values:radius()
    local duration = self.Values:duration()
    local count = self.Values:count()
    local tTargets = FindUnitsInRadius(
        hCaster:GetTeamNumber(),
        vPostion,
        nil,
        fRadius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )
    for _, hTarget in pairs(tTargets) do
        hTarget:AddNewModifier(hCaster, self, "modifier_boss_7_1_debuff", {duration = duration})
        self:CreateSpiderling(
            hTarget:GetAbsOrigin(),
            count
        )
    end
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_1/spiderlings_spawn/spiderlings_spawn.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPostion)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                1,
                Vector(fRadius, fRadius, fRadius)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            ParticleManager_s2c:EmitSoundOn("Boss_2_1.Impact", hCaster)
        end,
        {weight = 0}
    )
end
function boss_7_1.prototype.CreateSpiderling(self, vPosition, count)
    local hCaster = self:GetCaster()
    local atk = self.Values:inherite_attack_pct()
    local hp = self.Values:inherite_hp_pct()
    local armor = self.Values:inherite_armor_pct()
    local atk_spd = self.Values:inherite_attack_speed_pct()
    local mov_spd = self.Values:inherite_move_speed_pct()
    local duration = self.Values:alive_duration()
    local max_count = self.Values:max_count()
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_broodmother/broodmother_spiderlings_spawn.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            ParticleManager_s2c:EmitSoundOn("Boss_2_1.Burst", hCaster)
        end,
        {weight = 0}
    )
    if hCaster:HasModifier("modifier_boss_7_6_stack") then
        count = count + hCaster:GetModifierStackCount("modifier_boss_7_6_stack", hCaster)
    end
    do
        local i = 0
        while i < count do
            if #self.tSpiderling < max_count then
                local hSpiderling = CreateUnitByName(
                    "summon_boss_7_1",
                    vPosition + RandomVector(RandomInt(-200, 200)),
                    true,
                    hCaster,
                    hCaster,
                    hCaster:GetTeamNumber()
                )
                hSpiderling:AddAbility("attribute")
                AttributeKind.Atk.BONUS:Set(
                    hSpiderling,
                    AttributeKind.Atk:Get(hCaster) * atk * 0.01,
                    "BASE"
                )
                AttributeKind.HpLimit.BONUS:Set(
                    hSpiderling,
                    AttributeKind.HpLimit:Get(hCaster) * hp * 0.01,
                    "BASE1"
                )
                AttributeKind.Armor.BONUS:Set(
                    hSpiderling,
                    AttributeKind.Armor:Get(hCaster) * armor * 0.01,
                    "BASE"
                )
                AttributeKind.AtkSpd.BONUS:Set(
                    hSpiderling,
                    AttributeKind.AtkSpd:Get(hCaster) * atk_spd * 0.01,
                    "BASE"
                )
                AttributeKind.MoveSpd.BONUS:Set(
                    hSpiderling,
                    AttributeKind.MoveSpd:Get(hCaster) * mov_spd * 0.01,
                    "BASE"
                )
                AttributeKind.Atk.BONUS:UpdateClient(hSpiderling, "BASE")
                AttributeKind.HpLimit.BONUS:UpdateClient(hSpiderling, "BASE1")
                AttributeKind.Armor.BONUS:UpdateClient(hSpiderling, "BASE")
                AttributeKind.AtkSpd.BONUS:UpdateClient(hSpiderling, "BASE")
                AttributeKind.MoveSpd.BONUS:UpdateClient(hSpiderling, " BASE")
                hSpiderling:AddNewModifier(hCaster, self, "modifier_summon_boss_7_1", {duration = duration})
                local ____self_tSpiderling_0 = self.tSpiderling
                ____self_tSpiderling_0[#____self_tSpiderling_0 + 1] = hSpiderling:entindex()
            end
            i = i + 1
        end
    end
end
function boss_7_1.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_DEATH] = {}}
end
function boss_7_1.prototype.OnDeath(self, event)
    if __TS__ArrayIncludes(
        self.tSpiderling,
        event.unit:entindex()
    ) then
        __TS__ArraySplice(
            self.tSpiderling,
            __TS__ArrayIndexOf(
                self.tSpiderling,
                event.unit:entindex()
            )
        )
    end
end
boss_7_1 = __TS__DecorateLegacy(
    {diy(_G)},
    boss_7_1
)
modifier_boss_7_1_debuff = __TS__Class()
modifier_boss_7_1_debuff.name = "modifier_boss_7_1_debuff"
__TS__ClassExtends(modifier_boss_7_1_debuff, BaseModifier)
function modifier_boss_7_1_debuff.prototype.IsHidden(self)
    return true
end
function modifier_boss_7_1_debuff.prototype.OnCreated(self, params)
    if IsServer() then
        self.dmg_factor = self.Values:dmg_factor()
        self.interval = self.Values:dmg_interval()
        self:StartIntervalThink(self.interval)
    else
        local iParticleID = ParticleManager:CreateParticle(
            "particles/econ/items/broodmother/bm_lycosidaes/bm_lycosidaes_spiderlings_debuff.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetParent()
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
    end
end
function modifier_boss_7_1_debuff.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if not IsValid(hCaster) or not hCaster:IsAlive() then
        self:Destroy()
        return
    end
    ApplyDamage({
        ability = hAbility,
        attacker = hCaster,
        victim = hParent,
        damage = AttributeKind.Atk:Get(hCaster) * self.dmg_factor,
        damage_type = hAbility:GetAbilityDamageType()
    })
end
modifier_boss_7_1_debuff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_1_debuff
)
modifier_summon_boss_7_1 = __TS__Class()
modifier_summon_boss_7_1.name = "modifier_summon_boss_7_1"
__TS__ClassExtends(modifier_summon_boss_7_1, BaseModifier)
function modifier_summon_boss_7_1.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:Kill(nil, nil)
    end
end
modifier_summon_boss_7_1 = __TS__DecorateLegacy(
    {register(_G)},
    modifier_summon_boss_7_1
)