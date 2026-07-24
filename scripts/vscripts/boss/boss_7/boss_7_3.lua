--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 7,["13"] = 8,["14"] = 9,["15"] = 10,["16"] = 11,["17"] = 12,["18"] = 7,["19"] = 14,["20"] = 15,["21"] = 14,["22"] = 17,["23"] = 18,["24"] = 19,["25"] = 20,["26"] = 21,["27"] = 22,["28"] = 22,["29"] = 23,["30"] = 24,["31"] = 25,["32"] = 25,["33"] = 25,["34"] = 25,["35"] = 25,["36"] = 26,["37"] = 26,["38"] = 26,["39"] = 26,["40"] = 26,["41"] = 26,["42"] = 26,["43"] = 27,["44"] = 28,["45"] = 29,["47"] = 31,["48"] = 32,["49"] = 22,["50"] = 22,["51"] = 22,["52"] = 36,["53"] = 17,["54"] = 38,["55"] = 39,["56"] = 40,["57"] = 41,["58"] = 40,["59"] = 43,["60"] = 38,["61"] = 45,["62"] = 46,["63"] = 47,["64"] = 48,["65"] = 49,["66"] = 50,["67"] = 51,["68"] = 51,["69"] = 52,["70"] = 53,["71"] = 54,["72"] = 55,["73"] = 56,["74"] = 57,["75"] = 58,["76"] = 59,["77"] = 60,["78"] = 60,["79"] = 60,["80"] = 60,["81"] = 60,["82"] = 60,["83"] = 60,["84"] = 60,["85"] = 60,["86"] = 61,["87"] = 62,["88"] = 62,["89"] = 62,["90"] = 62,["91"] = 62,["92"] = 63,["93"] = 63,["94"] = 63,["95"] = 63,["96"] = 63,["97"] = 64,["98"] = 65,["99"] = 51,["100"] = 51,["101"] = 51,["102"] = 69,["103"] = 69,["104"] = 69,["105"] = 69,["106"] = 69,["107"] = 69,["108"] = 69,["109"] = 69,["110"] = 69,["111"] = 45,["112"] = 3,["113"] = 2,["114"] = 3,["116"] = 72,["117"] = 72,["118"] = 73,["119"] = 75,["120"] = 76,["121"] = 75,["122"] = 78,["123"] = 79,["124"] = 78,["125"] = 81,["126"] = 82,["127"] = 81,["128"] = 84,["129"] = 85,["130"] = 84,["131"] = 87,["132"] = 88,["133"] = 87,["134"] = 90,["135"] = 91,["136"] = 90,["137"] = 93,["138"] = 94,["139"] = 93,["140"] = 96,["141"] = 97,["142"] = 98,["143"] = 99,["144"] = 100,["145"] = 101,["146"] = 101,["147"] = 101,["148"] = 101,["149"] = 101,["150"] = 102,["151"] = 102,["152"] = 102,["153"] = 102,["154"] = 102,["155"] = 103,["156"] = 103,["157"] = 103,["158"] = 103,["159"] = 103,["160"] = 104,["161"] = 104,["162"] = 104,["163"] = 104,["164"] = 104,["165"] = 105,["166"] = 105,["167"] = 105,["168"] = 105,["169"] = 105,["170"] = 106,["171"] = 106,["172"] = 106,["173"] = 106,["174"] = 106,["175"] = 107,["176"] = 107,["177"] = 107,["178"] = 107,["179"] = 107,["180"] = 108,["181"] = 108,["182"] = 108,["183"] = 108,["184"] = 108,["185"] = 109,["186"] = 109,["187"] = 109,["188"] = 109,["189"] = 109,["190"] = 110,["191"] = 110,["192"] = 110,["193"] = 110,["194"] = 110,["195"] = 111,["196"] = 111,["197"] = 111,["198"] = 111,["199"] = 111,["200"] = 112,["201"] = 112,["202"] = 112,["203"] = 112,["204"] = 112,["205"] = 113,["206"] = 113,["207"] = 113,["208"] = 113,["209"] = 113,["210"] = 114,["211"] = 114,["212"] = 114,["213"] = 114,["214"] = 114,["215"] = 114,["216"] = 114,["217"] = 114,["219"] = 96,["220"] = 117,["221"] = 118,["222"] = 119,["224"] = 117,["225"] = 122,["226"] = 123,["227"] = 123,["228"] = 123,["229"] = 123,["230"] = 123,["231"] = 123,["232"] = 123,["233"] = 123,["234"] = 123,["235"] = 123,["236"] = 123,["237"] = 122,["238"] = 73,["239"] = 72,["240"] = 73,["242"] = 136,["243"] = 136,["244"] = 137,["245"] = 138,["246"] = 139,["247"] = 140,["248"] = 140,["249"] = 140,["250"] = 140,["251"] = 140,["252"] = 141,["253"] = 141,["254"] = 141,["255"] = 141,["256"] = 141,["257"] = 141,["258"] = 141,["259"] = 141,["261"] = 138,["262"] = 144,["263"] = 145,["264"] = 144,["265"] = 137,["266"] = 136,["267"] = 137});
boss_7_3 = __TS__Class()
boss_7_3.name = "boss_7_3"
__TS__ClassExtends(boss_7_3, BossAbility)
function boss_7_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_3/blink_start/blink_start.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_3/blink_end/blink_end.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_spin_web_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_web.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_broodmother/broodmother_silken_bola_root.vpcf", context)
end
function boss_7_3.prototype.GetPlaybackRateOverride(self)
    return 0.4 / self:GetCastPoint()
end
function boss_7_3.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vPostion = self:GetCursorPosition()
    local fCastPoint = self:GetCastPoint()
    local fRadius = self.Values:radius()
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vPostion)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(fRadius, fCastPoint, 1 / fCastPoint)
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
function boss_7_3.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(function()
        ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
    end)
    hCaster:StopSound(self.sLastSound)
end
function boss_7_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local vPostion = self:GetCursorPosition()
    local fRadius = self.Values:radius()
    local duration = self.Values:duration()
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_3/blink_start/blink_start.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vStartPosition)
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            FindClearSpaceForUnit(hCaster, vPostion, true)
            iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_3/blink_end/blink_end.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPostion)
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            iParticleID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_broodmother/broodmother_spin_web_cast.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControlEnt(
                iParticleID,
                0,
                hCaster,
                PATTACH_POINT,
                "attach_attack1",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:SetParticleControl(iParticleID, 1, vPostion)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                2,
                Vector(fRadius, fRadius, fRadius)
            )
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                3,
                Vector(fRadius, fRadius, fRadius)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            ParticleManager_s2c:EmitSoundOn("Boss_2_3.Cast", hCaster)
        end,
        {weight = 0}
    )
    CreateModifierThinker(
        hCaster,
        self,
        "modifier_boss_7_3_thinker",
        {duration = duration},
        vPostion,
        hCaster:GetTeamNumber(),
        false
    )
end
boss_7_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_7_3
)
modifier_boss_7_3_thinker = __TS__Class()
modifier_boss_7_3_thinker.name = "modifier_boss_7_3_thinker"
__TS__ClassExtends(modifier_boss_7_3_thinker, BaseModifier)
function modifier_boss_7_3_thinker.prototype.IsHidden(self)
    return true
end
function modifier_boss_7_3_thinker.prototype.IsAura(self)
    return true
end
function modifier_boss_7_3_thinker.prototype.GetModifierAura(self)
    return "modifier_boss_7_3_debuff"
end
function modifier_boss_7_3_thinker.prototype.GetAuraRadius(self)
    return self.radius
end
function modifier_boss_7_3_thinker.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_boss_7_3_thinker.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_boss_7_3_thinker.prototype.GetAuraSearchFlags(self)
    return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_boss_7_3_thinker.prototype.OnCreated(self, params)
    self.radius = self.Values:radius()
    if IsClient() then
        local hParent = self:GetParent()
        local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_broodmother/broodmother_web.vpcf", PATTACH_ABSORIGIN, hParent)
        ParticleManager:SetParticleControl(
            iParticleID,
            1,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            2,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            3,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            4,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            5,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            10,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            11,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            12,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            13,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            14,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            15,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            16,
            Vector(self.radius, self.radius, self.radius)
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            17,
            Vector(self.radius, self.radius, self.radius)
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
function modifier_boss_7_3_thinker.prototype.OnDestroy(self)
    if IsServer() then
        UTIL_Remove(self:GetParent())
    end
end
function modifier_boss_7_3_thinker.prototype.CheckState(self)
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
modifier_boss_7_3_thinker = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_3_thinker
)
modifier_boss_7_3_debuff = __TS__Class()
modifier_boss_7_3_debuff.name = "modifier_boss_7_3_debuff"
__TS__ClassExtends(modifier_boss_7_3_debuff, DiyModifier)
function modifier_boss_7_3_debuff.prototype.OnCreated(self, params)
    if IsClient() then
        local iParticleID = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_broodmother/broodmother_silken_bola_root.vpcf",
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
function modifier_boss_7_3_debuff.prototype.DDeclareFunctions(self)
    return {[AttributeKind.MoveSpd.PCT] = -self.Values:reduce_move_speed_pct()}
end
modifier_boss_7_3_debuff = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_7_3_debuff
)