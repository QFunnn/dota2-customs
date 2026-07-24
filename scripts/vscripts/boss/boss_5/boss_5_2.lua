--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 5,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 12,["20"] = 13,["21"] = 14,["22"] = 15,["23"] = 16,["24"] = 17,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 25,["34"] = 25,["35"] = 25,["36"] = 25,["37"] = 25,["38"] = 26,["39"] = 26,["40"] = 26,["41"] = 26,["42"] = 26,["43"] = 21,["44"] = 21,["45"] = 21,["46"] = 31,["47"] = 12,["48"] = 33,["49"] = 34,["50"] = 34,["51"] = 35,["52"] = 34,["53"] = 34,["54"] = 34,["55"] = 33,["56"] = 40,["57"] = 41,["58"] = 42,["59"] = 43,["60"] = 44,["61"] = 45,["62"] = 46,["63"] = 47,["64"] = 48,["65"] = 49,["66"] = 50,["67"] = 50,["68"] = 50,["69"] = 50,["70"] = 50,["71"] = 50,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 50,["76"] = 50,["77"] = 50,["78"] = 62,["79"] = 62,["80"] = 62,["81"] = 50,["82"] = 50,["83"] = 50,["84"] = 70,["85"] = 70,["86"] = 71,["87"] = 72,["88"] = 70,["89"] = 70,["90"] = 70,["91"] = 40,["92"] = 77,["93"] = 78,["94"] = 79,["95"] = 80,["96"] = 81,["97"] = 82,["98"] = 83,["99"] = 84,["100"] = 85,["101"] = 86,["102"] = 86,["103"] = 86,["104"] = 86,["105"] = 86,["106"] = 86,["107"] = 86,["108"] = 86,["109"] = 86,["110"] = 86,["111"] = 91,["112"] = 91,["113"] = 91,["114"] = 91,["115"] = 91,["116"] = 91,["117"] = 91,["119"] = 77,["120"] = 3,["121"] = 2,["122"] = 3,["124"] = 101,["125"] = 101,["126"] = 102,["127"] = 105,["128"] = 106,["129"] = 105,["130"] = 108,["131"] = 109,["132"] = 110,["133"] = 111,["134"] = 112,["136"] = 114,["139"] = 108,["140"] = 118,["141"] = 119,["142"] = 120,["144"] = 118,["145"] = 123,["146"] = 124,["147"] = 125,["148"] = 126,["149"] = 127,["150"] = 128,["151"] = 129,["152"] = 130,["155"] = 123,["156"] = 134,["157"] = 135,["158"] = 136,["160"] = 134,["161"] = 139,["162"] = 140,["163"] = 139,["164"] = 147,["165"] = 148,["166"] = 147,["167"] = 152,["168"] = 153,["169"] = 152,["170"] = 102,["171"] = 101,["172"] = 102});
boss_5_2 = __TS__Class()
boss_5_2.name = "boss_5_2"
__TS__ClassExtends(boss_5_2, BaseAbility)
function boss_5_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_2/line/line.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_2/boss_5_2_a/boss_5_2_a.vpcf", context)
end
function boss_5_2.prototype.GetPlaybackRateOverride(self)
    return 0.5 / self:GetCastPoint()
end
function boss_5_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local vStartPosition = hCaster:GetAbsOrigin()
    local fWidth = self.Values:width()
    local fDistance = self.Values:distance()
    local vEndPosition = self:GetCursorPosition()
    local vDirection = (vEndPosition - vStartPosition):Normalized()
    vEndPosition = vStartPosition + vDirection * fDistance
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
function boss_5_2.prototype.OnAbilityPhaseInterrupted(self)
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
        end,
        {weight = 0}
    )
end
function boss_5_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local vEndPosition = self:GetCursorPosition()
    local fSpeed = self.Values:speed()
    local fDistance = self.Values:distance()
    local fWidth = self.Values:width()
    local dmg_factor = self.Values:dmg_factor()
    local vDirection = (vEndPosition - vStartPosition):Normalized()
    local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        Source = hCaster,
        EffectName = "particles/boss/boss_5/boss_5_2/boss_5_2_a/boss_5_2_a.vpcf",
        vSpawnOrigin = hCaster:GetAbsOrigin(),
        vVelocity = vDirection * fSpeed,
        fDistance = fDistance,
        fStartRadius = fWidth,
        fEndRadius = fWidth,
        iUnitTargetTeam = self:GetAbilityTargetTeam(),
        iUnitTargetType = self:GetAbilityTargetType(),
        iUnitTargetFlags = self:GetAbilityTargetFlags(),
        ExtraData = {
            vDirection = VectorToString(_G, vDirection),
            fDamage = fDamage
        },
        ParticleConfig = {weight = 0}
    })
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:EmitSoundOn("Hero_Lina.DragonSlave.Cast", hCaster)
            ParticleManager_s2c:EmitSoundOn("Hero_Lina.DragonSlave", hCaster)
        end,
        {weight = 0}
    )
end
function boss_5_2.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    local hCaster = self:GetCaster()
    if IsValid(hCaster) and IsValid(target) then
        local fDamage = extraData.fDamage
        local vDirection = StringToVector(_G, extraData.vDirection)
        local fKnockBackDistance = self.Values:knockback()
        local fSpeed = self.Values:speed()
        local vStartPosition = target:GetAbsOrigin()
        local vEndPosition = vStartPosition + vDirection * fKnockBackDistance
        target:AddNewModifier(
            hCaster,
            self,
            "modifier_boss_5_2_move",
            {
                duration = fKnockBackDistance / fSpeed,
                vStartPosition = VectorToString(_G, vStartPosition),
                vEndPosition = VectorToString(_G, vEndPosition)
            }
        )
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = fDamage,
            damage_type = self:GetAbilityDamageType()
        })
    end
end
boss_5_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_5_2
)
modifier_boss_5_2_move = __TS__Class()
modifier_boss_5_2_move.name = "modifier_boss_5_2_move"
__TS__ClassExtends(modifier_boss_5_2_move, BaseModifierMotionHorizontal)
function modifier_boss_5_2_move.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_2_move.prototype.OnCreated(self, params)
    if IsServer() then
        if self:ApplyHorizontalMotionController() then
            self.vStartPosition = StringToVector(_G, params.vStartPosition)
            self.vEndPosition = StringToVector(_G, params.vEndPosition)
        else
            self:Destroy()
        end
    end
end
function modifier_boss_5_2_move.prototype.OnDestroy(self)
    if IsServer() then
        self:GetParent():RemoveHorizontalMotionController(self)
    end
end
function modifier_boss_5_2_move.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        local fPercent = self:GetElapsedTime() / self:GetDuration()
        if IsValid(hCaster) and hCaster:IsAlive() then
            local vPostion = VectorLerp(fPercent, self.vStartPosition, self.vEndPosition)
            hParent:SetAbsOrigin(vPostion)
        end
    end
end
function modifier_boss_5_2_move.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_5_2_move.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
function modifier_boss_5_2_move.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_5_2_move.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
modifier_boss_5_2_move = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_2_move
)