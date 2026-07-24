--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 7,["13"] = 8,["14"] = 9,["15"] = 10,["16"] = 7,["17"] = 12,["18"] = 13,["19"] = 12,["20"] = 15,["21"] = 16,["22"] = 17,["23"] = 18,["24"] = 19,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 23,["29"] = 24,["30"] = 24,["31"] = 25,["32"] = 26,["33"] = 27,["34"] = 28,["35"] = 28,["36"] = 28,["37"] = 28,["38"] = 28,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 29,["45"] = 29,["46"] = 30,["47"] = 31,["48"] = 32,["50"] = 34,["51"] = 35,["52"] = 24,["53"] = 24,["54"] = 24,["55"] = 39,["56"] = 15,["57"] = 41,["58"] = 42,["59"] = 43,["60"] = 42,["61"] = 41,["62"] = 46,["63"] = 47,["64"] = 48,["65"] = 49,["66"] = 50,["67"] = 50,["68"] = 51,["69"] = 52,["70"] = 53,["71"] = 54,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 58,["76"] = 58,["77"] = 58,["78"] = 59,["79"] = 60,["80"] = 60,["81"] = 61,["82"] = 62,["83"] = 60,["84"] = 60,["85"] = 60,["87"] = 67,["88"] = 68,["89"] = 68,["90"] = 68,["91"] = 68,["92"] = 68,["93"] = 68,["94"] = 68,["95"] = 68,["96"] = 68,["97"] = 68,["98"] = 68,["99"] = 68,["100"] = 68,["102"] = 58,["103"] = 58,["104"] = 46,["105"] = 2,["106"] = 1,["107"] = 2,["109"] = 73,["110"] = 73,["111"] = 74,["112"] = 80,["113"] = 81,["114"] = 80,["115"] = 83,["116"] = 84,["117"] = 83,["118"] = 86,["119"] = 87,["120"] = 86,["121"] = 89,["122"] = 90,["123"] = 89,["124"] = 92,["125"] = 93,["126"] = 92,["127"] = 95,["128"] = 96,["129"] = 95,["130"] = 98,["131"] = 99,["132"] = 98,["133"] = 101,["134"] = 102,["135"] = 103,["136"] = 104,["137"] = 105,["140"] = 108,["141"] = 108,["142"] = 108,["143"] = 108,["144"] = 108,["145"] = 108,["146"] = 108,["147"] = 108,["148"] = 108,["149"] = 108,["150"] = 118,["151"] = 119,["152"] = 120,["153"] = 120,["154"] = 120,["155"] = 120,["156"] = 120,["157"] = 120,["158"] = 121,["159"] = 122,["160"] = 123,["161"] = 123,["162"] = 123,["163"] = 123,["164"] = 123,["166"] = 125,["167"] = 126,["171"] = 130,["172"] = 101,["173"] = 132,["174"] = 133,["175"] = 134,["176"] = 135,["177"] = 136,["178"] = 137,["179"] = 138,["180"] = 139,["181"] = 140,["182"] = 140,["183"] = 141,["184"] = 142,["185"] = 143,["186"] = 144,["187"] = 144,["188"] = 144,["189"] = 144,["190"] = 144,["191"] = 144,["192"] = 144,["193"] = 144,["194"] = 140,["195"] = 140,["196"] = 140,["198"] = 132,["199"] = 150,["200"] = 151,["201"] = 152,["203"] = 150,["204"] = 155,["205"] = 156,["206"] = 156,["207"] = 156,["208"] = 156,["209"] = 156,["210"] = 156,["211"] = 156,["212"] = 156,["213"] = 156,["214"] = 156,["215"] = 156,["216"] = 155,["217"] = 74,["218"] = 73,["219"] = 74,["221"] = 169,["222"] = 169,["223"] = 170,["224"] = 172,["225"] = 173,["226"] = 174,["227"] = 175,["229"] = 177,["230"] = 177,["231"] = 177,["232"] = 177,["233"] = 177,["234"] = 178,["235"] = 178,["236"] = 178,["237"] = 178,["238"] = 178,["239"] = 178,["240"] = 178,["241"] = 178,["243"] = 172,["244"] = 181,["245"] = 182,["246"] = 183,["247"] = 184,["248"] = 185,["249"] = 186,["252"] = 189,["253"] = 189,["254"] = 189,["255"] = 189,["256"] = 189,["257"] = 189,["258"] = 189,["259"] = 181,["260"] = 197,["261"] = 198,["262"] = 197,["263"] = 170,["264"] = 169,["265"] = 170});
boss_7_4 = __TS__Class()
boss_7_4.name = "boss_7_4"
__TS__ClassExtends(boss_7_4, BossAbility)
function boss_7_4.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_scepter_sticky_snare_telegraph.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_scepter_sticky_snare.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_scepter_sticky_snare_root.vpcf", context)
end
function boss_7_4.prototype.GetPlaybackRateOverride(self)
    return 0.73 / self:GetCastPoint()
end
function boss_7_4.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local fCastPoint = self:GetCastPoint()
    local vDirection = RandomVector(1)
    local width = self.Values:width()
    local distance = self.Values:distance()
    self.vStart = vPosition - vDirection * distance / 2
    self.vEnd = vPosition + vDirection * distance / 2
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/linear.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, self.vStart)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 1, self.vEnd)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(width, fCastPoint, 1 / fCastPoint)
            )
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
    return true
end
function boss_7_4.prototype.OnAbilityPhaseInterrupted(self)
    ParticleManager_s2c:ToClient(function()
        ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
    end)
end
function boss_7_4.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local iParticleID
    ParticleManager_s2c:ToClient(
        function()
            iParticleID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_broodmother/broodmother_scepter_sticky_snare_telegraph.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, self.vStart)
            ParticleManager_s2c:SetParticleControl(iParticleID, 1, self.vEnd)
            ParticleManager_s2c:EmitSoundOn("Hero_Broodmother.StickySnare", hCaster)
        end,
        {weight = 0}
    )
    hCaster:GameTimer(
        self.Values:dealy(),
        function()
            if iParticleID then
                ParticleManager_s2c:ToClient(
                    function()
                        ParticleManager_s2c:DestroyParticle(iParticleID, false)
                        ParticleManager_s2c:EmitSoundOn("Hero_Broodmother.StickySnare.Cast", hCaster)
                    end,
                    {weight = 0}
                )
            end
            if IsValid(hCaster) then
                CreateModifierThinker(
                    hCaster,
                    self,
                    "modifier_boss_7_4_thinker",
                    {
                        duration = self.Values:duration(),
                        vStart = VectorToString(_G, self.vStart),
                        vEnd = VectorToString(_G, self.vEnd)
                    },
                    vPosition,
                    hCaster:GetTeamNumber(),
                    false
                )
            end
        end
    )
end
boss_7_4 = __TS__DecorateLegacy(
    {register(_G)},
    boss_7_4
)
modifier_boss_7_4_thinker = __TS__Class()
modifier_boss_7_4_thinker.name = "modifier_boss_7_4_thinker"
__TS__ClassExtends(modifier_boss_7_4_thinker, BaseModifier)
function modifier_boss_7_4_thinker.prototype.IsHidden(self)
    return true
end
function modifier_boss_7_4_thinker.prototype.IsAura(self)
    return true
end
function modifier_boss_7_4_thinker.prototype.GetModifierAura(self)
    return ""
end
function modifier_boss_7_4_thinker.prototype.GetAuraRadius(self)
    return self.distance
end
function modifier_boss_7_4_thinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_boss_7_4_thinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_boss_7_4_thinker.prototype.GetAuraSearchFlags(self)
    return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_boss_7_4_thinker.prototype.GetAuraEntityReject(self, entity)
    if IsServer() then
        local hCaster = self:GetCaster()
        if not IsValid(hCaster) or not hCaster:IsAlive() then
            self:Destroy()
            return
        end
        local tTargets = FindUnitsInLine(
            hCaster:GetTeamNumber(),
            self.vStart,
            self.vEnd,
            nil,
            self.width,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE
        )
        for _, hTarget in pairs(tTargets) do
            if entity == hTarget then
                entity:AddNewModifier(
                    hCaster,
                    self:GetAbility(),
                    "modifier_boss_7_4_debuff",
                    {duration = self.Values:root_duration()}
                )
                local hAbility5 = hCaster:FindAbilityByName("boss_7_5")
                if IsValid(hAbility5) and hAbility5.CreateSpiderEgg then
                    hAbility5.CreateSpiderEgg(
                        hAbility5,
                        entity:GetAbsOrigin(),
                        self.count
                    )
                end
                self:Destroy()
                return true
            end
        end
    end
    return false
end
function modifier_boss_7_4_thinker.prototype.OnCreated(self, params)
    self.width = self.Values:width()
    self.distance = self.Values:distance()
    self.count = self.Values:egg_count()
    if IsServer() then
        local hParent = self:GetParent()
        self.vStart = StringToVector(_G, params.vStart)
        self.vEnd = StringToVector(_G, params.vEnd)
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_broodmother/broodmother_scepter_sticky_snare.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, self.vStart)
                ParticleManager_s2c:SetParticleControl(iParticleID, 1, self.vEnd)
                self:AddParticle_s2c(
                    iParticleID,
                    false,
                    false,
                    -1,
                    false,
                    false
                )
            end,
            {weight = 0}
        )
    end
end
function modifier_boss_7_4_thinker.prototype.OnDestroy(self)
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end
function modifier_boss_7_4_thinker.prototype.CheckState(self)
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true
    }
end
modifier_boss_7_4_thinker = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_4_thinker
)
modifier_boss_7_4_debuff = __TS__Class()
modifier_boss_7_4_debuff.name = "modifier_boss_7_4_debuff"
__TS__ClassExtends(modifier_boss_7_4_debuff, BaseModifier)
function modifier_boss_7_4_debuff.prototype.OnCreated(self, params)
    self.dmg_factor = self.Values:dmg_factor()
    if IsServer() then
        self:StartIntervalThink(self.Values:dmg_interval())
    else
        local iParticleID = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_broodmother/broodmother_scepter_sticky_snare_root.vpcf",
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
function modifier_boss_7_4_debuff.prototype.OnIntervalThink(self)
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
function modifier_boss_7_4_debuff.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true}
end
modifier_boss_7_4_debuff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_4_debuff
)