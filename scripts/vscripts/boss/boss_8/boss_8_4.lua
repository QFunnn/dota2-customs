--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_8\\boss_8_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["13"] = 3,["14"] = 5,["15"] = 2,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 6,["20"] = 10,["21"] = 11,["22"] = 10,["23"] = 13,["24"] = 14,["25"] = 15,["26"] = 16,["27"] = 16,["28"] = 17,["29"] = 18,["30"] = 16,["31"] = 16,["32"] = 16,["33"] = 22,["34"] = 13,["35"] = 24,["36"] = 25,["37"] = 26,["38"] = 27,["39"] = 28,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 30,["44"] = 31,["45"] = 32,["46"] = 33,["47"] = 33,["48"] = 33,["49"] = 33,["50"] = 33,["51"] = 33,["52"] = 33,["53"] = 33,["54"] = 34,["55"] = 35,["56"] = 36,["57"] = 36,["58"] = 36,["59"] = 36,["60"] = 36,["61"] = 37,["62"] = 37,["63"] = 37,["64"] = 37,["65"] = 37,["66"] = 38,["67"] = 39,["68"] = 40,["69"] = 41,["70"] = 41,["73"] = 29,["74"] = 29,["75"] = 24,["76"] = 3,["77"] = 2,["78"] = 3,["80"] = 47,["81"] = 47,["82"] = 48,["83"] = 53,["84"] = 54,["85"] = 53,["86"] = 56,["87"] = 57,["88"] = 58,["89"] = 59,["90"] = 60,["91"] = 61,["92"] = 62,["93"] = 63,["94"] = 64,["96"] = 66,["98"] = 68,["99"] = 69,["100"] = 70,["101"] = 70,["102"] = 70,["103"] = 70,["104"] = 70,["105"] = 70,["106"] = 70,["107"] = 70,["110"] = 56,["111"] = 76,["112"] = 77,["113"] = 78,["114"] = 79,["115"] = 80,["116"] = 81,["117"] = 82,["120"] = 85,["121"] = 86,["122"] = 87,["123"] = 88,["124"] = 89,["125"] = 90,["127"] = 92,["128"] = 92,["129"] = 93,["130"] = 94,["131"] = 94,["132"] = 94,["133"] = 94,["134"] = 94,["135"] = 95,["136"] = 95,["137"] = 95,["138"] = 95,["139"] = 95,["140"] = 92,["141"] = 92,["142"] = 92,["143"] = 99,["144"] = 99,["145"] = 99,["146"] = 100,["149"] = 103,["150"] = 104,["151"] = 105,["152"] = 106,["153"] = 106,["154"] = 106,["155"] = 106,["156"] = 106,["157"] = 106,["158"] = 106,["159"] = 107,["160"] = 108,["161"] = 109,["162"] = 109,["163"] = 109,["164"] = 109,["165"] = 109,["166"] = 109,["167"] = 109,["170"] = 118,["171"] = 118,["172"] = 119,["173"] = 120,["174"] = 121,["175"] = 121,["176"] = 121,["177"] = 121,["178"] = 121,["179"] = 122,["180"] = 118,["181"] = 118,["182"] = 118,["183"] = 126,["184"] = 126,["185"] = 127,["186"] = 128,["187"] = 129,["188"] = 129,["189"] = 129,["190"] = 129,["191"] = 129,["192"] = 130,["193"] = 131,["194"] = 126,["195"] = 126,["196"] = 126,["197"] = 135,["198"] = 135,["199"] = 136,["200"] = 137,["201"] = 138,["202"] = 138,["203"] = 138,["204"] = 138,["205"] = 138,["206"] = 139,["207"] = 135,["208"] = 135,["209"] = 135,["211"] = 144,["212"] = 144,["213"] = 145,["214"] = 146,["215"] = 146,["216"] = 146,["217"] = 146,["218"] = 146,["219"] = 147,["220"] = 147,["221"] = 147,["222"] = 147,["223"] = 147,["224"] = 148,["225"] = 149,["226"] = 149,["227"] = 149,["228"] = 149,["229"] = 144,["230"] = 144,["231"] = 144,["232"] = 153,["233"] = 153,["234"] = 153,["235"] = 153,["236"] = 153,["237"] = 153,["238"] = 153,["239"] = 154,["240"] = 155,["241"] = 155,["242"] = 155,["243"] = 155,["244"] = 155,["245"] = 155,["246"] = 155,["249"] = 164,["250"] = 165,["251"] = 99,["252"] = 99,["253"] = 76,["254"] = 168,["255"] = 169,["256"] = 170,["257"] = 171,["258"] = 172,["259"] = 173,["260"] = 173,["261"] = 173,["262"] = 173,["263"] = 174,["267"] = 178,["268"] = 168,["269"] = 180,["270"] = 181,["271"] = 180,["272"] = 188,["273"] = 189,["274"] = 188,["275"] = 193,["276"] = 194,["277"] = 193,["278"] = 48,["279"] = 47,["280"] = 48});
boss_8_4 = __TS__Class()
boss_8_4.name = "boss_8_4"
__TS__ClassExtends(boss_8_4, BossAbility)
function boss_8_4.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tSummonIndex = {}
end
function boss_8_4.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_4/fire_cast/fire_cast.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_4/fire/fire.vpcf", context)
end
function boss_8_4.prototype.GetPlaybackRateOverride(self)
    return 2
end
function boss_8_4.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    self.IsFalse = not RollPercentage(self.Values:false_chance())
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_4/fire_cast/fire_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
        end,
        {weight = 0}
    )
    return true
end
function boss_8_4.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local atk = self.Values:atk_inherit_pct()
    local move_speed = self.Values:move_speed_inherit_pct()
    self.tSummonIndex = {}
    EachPlayer(
        _G,
        function(____, iPlayerID)
            local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
            if IsValid(hHero) then
                local vPosition = hHero:GetAbsOrigin() - hHero:GetForwardVector() * 100
                local hSummon = CreateUnitByName(
                    "boss_8_3_summon",
                    vPosition,
                    true,
                    hCaster,
                    hCaster,
                    hCaster:GetTeamNumber()
                )
                if IsValid(hSummon) then
                    hSummon:AddAbility("attribute")
                    AttributeKind.Atk.BONUS:Set(
                        hSummon,
                        AttributeKind.Atk:Get(hCaster) * atk * 0.01,
                        "BASE"
                    )
                    AttributeKind.MoveSpd.BONUS:Set(
                        hSummon,
                        AttributeKind.MoveSpd:Get(hCaster) * move_speed * 0.01,
                        "BASE"
                    )
                    AttributeKind.Atk.BONUS:UpdateClient(hSummon, "BASE")
                    AttributeKind.MoveSpd.BONUS:UpdateClient(hSummon, "BASE")
                    hSummon:AddNewModifier(hCaster, self, "modifier_boss_8_4", {iPlayerID = iPlayerID})
                    local ____self_tSummonIndex_0 = self.tSummonIndex
                    ____self_tSummonIndex_0[#____self_tSummonIndex_0 + 1] = hSummon:entindex()
                end
            end
        end
    )
end
boss_8_4 = __TS__DecorateLegacy(
    {register(_G)},
    boss_8_4
)
modifier_boss_8_4 = __TS__Class()
modifier_boss_8_4.name = "modifier_boss_8_4"
__TS__ClassExtends(modifier_boss_8_4, BaseModifier)
function modifier_boss_8_4.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_4.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    self.radius = self.Values:radius()
    self.delay_time = self.Values:delay_time()
    self.duration = self.Values:duration()
    if IsServer() then
        self.hHero = PlayerResource:GetSelectedHeroEntity(params.iPlayerID)
        if IsValid(self.hHero) then
            hParent:SetForceAttackTarget(self.hHero)
        end
        self:StartIntervalThink(self.duration)
    else
        if ParticleManager_s2c:CheckClientBlocked() then
            local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_4/fire/fire.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
end
function modifier_boss_8_4.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if not IsValid(hCaster) or not hCaster:IsAlive() or not IsValid(hAbility) then
        UTIL_Remove(hParent)
        self:StartIntervalThink(-1)
        return
    end
    local fDamage = AttributeKind.Atk:Get(hParent) * self.Values:dmg_factor()
    hParent:Hold()
    hParent:StartGesture(ACT_DOTA_CAST_ABILITY_6)
    local sParticleName = "particles/boss/boss_8/boss_8_1/warning/circular.vpcf"
    if hAbility.IsFalse then
        sParticleName = "particles/boss/boss_8/boss_8_1/warning/circular_false.vpcf"
    end
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle(sParticleName, PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                0,
                hParent:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                2,
                Vector(self.radius, self.delay_time, 0)
            )
        end,
        {weight = 0}
    )
    hParent:GameTimer(
        self.delay_time,
        function()
            if not IsValid(hParent) or not IsValid(hCaster) or not hCaster:IsAlive() then
                return
            end
            local vPosition = hParent:GetAbsOrigin()
            if hAbility.IsFalse then
                local false_radius = self.Values:false_radius()
                local tTargets = FindUnitsInRadiusWithAbility(
                    _G,
                    hCaster,
                    hAbility,
                    vPosition,
                    false_radius
                )
                for _, hTarget in pairs(tTargets) do
                    if not self:IsPositionIntPos(hTarget) then
                        ApplyDamage({
                            ability = hAbility,
                            attacker = hCaster,
                            victim = hTarget,
                            damage = fDamage,
                            damage_type = hAbility:GetAbilityDamageType()
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
                        ParticleManager_s2c:SetParticleControl(
                            iParticleID,
                            0,
                            hParent:GetAbsOrigin()
                        )
                        ParticleManager_s2c:SetParticleControl(
                            iParticleID,
                            1,
                            Vector(self.radius, self.radius, self.radius)
                        )
                        ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                        ParticleManager_s2c:StartSoundEventFromPosition(
                            "Hero_Nevermore.Shadowraze.Arcana",
                            hParent:GetAbsOrigin()
                        )
                    end,
                    {weight = 0}
                )
                local tTargets = FindUnitsInRadiusWithAbility(
                    _G,
                    hParent,
                    hAbility,
                    vPosition,
                    self.radius
                )
                for _, hTarget in pairs(tTargets) do
                    ApplyDamage({
                        ability = hAbility,
                        attacker = hCaster,
                        victim = hTarget,
                        damage = fDamage,
                        damage_type = hAbility:GetAbilityDamageType()
                    })
                end
            end
            hParent:AddNoDraw()
            UTIL_Remove(hParent)
        end
    )
end
function modifier_boss_8_4.prototype.IsPositionIntPos(self, hTarget)
    local b = false
    local hAbility = self:GetAbility()
    for _, iSummonIndex in pairs(hAbility.tSummonIndex) do
        local hSummon = EntIndexToHScript(iSummonIndex)
        if IsValid(hSummon) and hTarget:IsPositionInRange(
            hSummon:GetAbsOrigin(),
            self.radius
        ) then
            b = true
            break
        end
    end
    return b
end
function modifier_boss_8_4.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_NO_TEAM_SELECT] = true, [MODIFIER_STATE_UNSELECTABLE] = true}
end
function modifier_boss_8_4.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS}
end
function modifier_boss_8_4.prototype.GetActivityTranslationModifiers(self)
    return "arcana"
end
modifier_boss_8_4 = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_4
)