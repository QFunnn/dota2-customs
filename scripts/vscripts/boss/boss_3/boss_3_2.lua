--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_3\\boss_3_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 7,["16"] = 8,["17"] = 7,["18"] = 10,["19"] = 11,["20"] = 10,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 18,["27"] = 19,["28"] = 20,["29"] = 21,["30"] = 22,["31"] = 22,["32"] = 23,["33"] = 24,["34"] = 25,["35"] = 26,["36"] = 26,["37"] = 26,["38"] = 26,["39"] = 26,["40"] = 27,["41"] = 27,["42"] = 27,["43"] = 27,["44"] = 27,["45"] = 22,["46"] = 22,["47"] = 22,["48"] = 32,["49"] = 13,["50"] = 34,["51"] = 35,["52"] = 35,["53"] = 36,["54"] = 35,["55"] = 35,["56"] = 35,["57"] = 34,["58"] = 41,["59"] = 42,["60"] = 43,["61"] = 44,["62"] = 45,["63"] = 46,["64"] = 47,["65"] = 48,["66"] = 49,["67"] = 50,["68"] = 51,["69"] = 52,["70"] = 52,["71"] = 52,["72"] = 52,["73"] = 52,["74"] = 52,["75"] = 52,["76"] = 52,["77"] = 52,["78"] = 52,["79"] = 52,["80"] = 52,["81"] = 52,["82"] = 52,["83"] = 68,["85"] = 69,["86"] = 69,["87"] = 70,["88"] = 71,["89"] = 72,["90"] = 72,["91"] = 72,["92"] = 72,["93"] = 72,["94"] = 72,["95"] = 72,["96"] = 72,["97"] = 73,["98"] = 74,["99"] = 75,["100"] = 75,["101"] = 75,["102"] = 75,["103"] = 75,["104"] = 75,["105"] = 75,["106"] = 75,["107"] = 75,["108"] = 75,["110"] = 69,["113"] = 41,["114"] = 79,["115"] = 80,["116"] = 81,["117"] = 82,["118"] = 82,["119"] = 82,["120"] = 82,["121"] = 82,["122"] = 82,["123"] = 82,["125"] = 79,["126"] = 2,["127"] = 1,["128"] = 2,["130"] = 92,["131"] = 92,["132"] = 93,["133"] = 96,["134"] = 97,["135"] = 98,["136"] = 99,["137"] = 100,["138"] = 101,["139"] = 102,["141"] = 104,["144"] = 96,["145"] = 108,["146"] = 109,["147"] = 108,["148"] = 111,["149"] = 112,["150"] = 111,["151"] = 114,["152"] = 115,["153"] = 114,["154"] = 117,["155"] = 118,["156"] = 117,["157"] = 120,["158"] = 121,["159"] = 122,["160"] = 122,["161"] = 122,["162"] = 122,["163"] = 122,["165"] = 120,["166"] = 125,["167"] = 126,["168"] = 127,["170"] = 125,["171"] = 130,["172"] = 131,["173"] = 132,["174"] = 133,["175"] = 134,["177"] = 130,["178"] = 137,["179"] = 138,["180"] = 137,["181"] = 145,["182"] = 146,["183"] = 145,["184"] = 152,["185"] = 153,["186"] = 152,["187"] = 155,["188"] = 156,["189"] = 155,["190"] = 158,["191"] = 159,["192"] = 158,["193"] = 93,["194"] = 92,["195"] = 93});
boss_3_2 = __TS__Class()
boss_3_2.name = "boss_3_2"
__TS__ClassExtends(boss_3_2, BaseAbility)
function boss_3_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/circular.vpcf", context)
end
function boss_3_2.prototype.GetCastPoint(self)
    return 1
end
function boss_3_2.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_1
end
function boss_3_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local fCastPoint = self:GetCastPoint()
    local vStartPosition = hCaster:GetAbsOrigin()
    local fDistance = self.Values:distance()
    local fWidth = self.Values:width()
    local vDirection = (vPosition - vStartPosition):Normalized()
    local vEndPosition = vStartPosition + vDirection * fDistance
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_2/line/line.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vEndPosition)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 1, vStartPosition)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                3,
                Vector(fWidth, fWidth, 0)
            )
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                5,
                Vector(fCastPoint, 0, 0)
            )
        end,
        {weight = 0}
    )
    return true
end
function boss_3_2.prototype.OnAbilityPhaseInterrupted(self)
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
        end,
        {weight = 0}
    )
end
function boss_3_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local vEndPosition = self:GetCursorPosition()
    local fSpeed = self.Values:speed()
    local fDistance = self.Values:distance()
    local fWidth = self.Values:width()
    local dmg_factor = self.Values:dmg_factor()
    local vDirection = (vEndPosition - vStartPosition):Normalized()
    local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
    vEndPosition = vStartPosition + vDirection * fDistance
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        Source = hCaster,
        EffectName = "",
        vSpawnOrigin = hCaster:GetAbsOrigin(),
        vVelocity = vDirection * fSpeed,
        fDistance = fDistance,
        fStartRadius = fWidth,
        fEndRadius = fWidth,
        iUnitTargetTeam = self:GetAbilityTargetTeam(),
        iUnitTargetType = self:GetAbilityTargetType(),
        iUnitTargetFlags = self:GetAbilityTargetFlags(),
        ExtraData = {fDamage = fDamage}
    })
    local fDuration = fDistance / fSpeed
    do
        local i = 0
        while i < 5 do
            local vPos = vStartPosition + Rotation2D(vDirection, 90 * (i % 2 == 0 and -1 or 1)) * 200 * math.ceil(i / 2)
            local vEndPos = vPos + vDirection * fDistance
            local hSummon = CreateUnitByName(
                "summon_boss_3_2",
                vPos,
                true,
                hCaster,
                hCaster,
                hCaster:GetTeamNumber()
            )
            if IsValid(hSummon) then
                hSummon:SetForwardVector(vDirection)
                hSummon:AddNewModifier(
                    hCaster,
                    self,
                    "modifier_boss_3_2_summon",
                    {
                        duration = fDuration,
                        vStartPosition = VectorToString(_G, vPos),
                        vEndPosition = VectorToString(_G, vEndPos)
                    }
                )
            end
            i = i + 1
        end
    end
end
function boss_3_2.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = extraData.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
    end
end
boss_3_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_3_2
)
modifier_boss_3_2_summon = __TS__Class()
modifier_boss_3_2_summon.name = "modifier_boss_3_2_summon"
__TS__ClassExtends(modifier_boss_3_2_summon, BaseModifierMotionHorizontal)
function modifier_boss_3_2_summon.prototype.OnCreated(self, params)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        if self:ApplyHorizontalMotionController() then
            self.vStartPosition = StringToVector(_G, params.vStartPosition)
            self.vEndPosition = StringToVector(_G, params.vEndPosition)
        else
            self:Destroy()
        end
    end
end
function modifier_boss_3_2_summon.prototype.GetEffectName(self)
    return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf"
end
function modifier_boss_3_2_summon.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_boss_3_2_summon.prototype.GetStatusEffectName(self)
    return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf"
end
function modifier_boss_3_2_summon.prototype.StatusEffectPriority(self)
    return MODIFIER_PRIORITY_HIGH
end
function modifier_boss_3_2_summon.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        me:SetAbsOrigin(VectorLerp(
            self:GetElapsedTime() / self:GetDuration(),
            self.vStartPosition,
            self.vEndPosition
        ))
    end
end
function modifier_boss_3_2_summon.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_3_2_summon.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:AddNoDraw()
        UTIL_Remove(hParent)
    end
end
function modifier_boss_3_2_summon.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true}
end
function modifier_boss_3_2_summon.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS}
end
function modifier_boss_3_2_summon.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_RUN_STATUE
end
function modifier_boss_3_2_summon.prototype.GetOverrideAnimationRate(self)
    return 2.5
end
function modifier_boss_3_2_summon.prototype.GetActivityTranslationModifiers(self)
    return "aggressive"
end
modifier_boss_3_2_summon = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_3_2_summon
)