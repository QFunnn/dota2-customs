--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_1\\boss_1_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 5,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 12,["20"] = 13,["21"] = 12,["22"] = 15,["23"] = 16,["24"] = 15,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 22,["30"] = 23,["31"] = 24,["32"] = 25,["33"] = 26,["34"] = 27,["35"] = 27,["36"] = 28,["37"] = 29,["38"] = 30,["39"] = 31,["40"] = 31,["41"] = 31,["42"] = 31,["43"] = 31,["44"] = 27,["45"] = 27,["46"] = 27,["47"] = 35,["48"] = 18,["49"] = 37,["50"] = 38,["51"] = 38,["52"] = 39,["53"] = 38,["54"] = 38,["55"] = 38,["56"] = 37,["57"] = 44,["58"] = 45,["59"] = 46,["60"] = 47,["61"] = 48,["62"] = 49,["63"] = 50,["64"] = 51,["65"] = 52,["66"] = 53,["67"] = 54,["68"] = 54,["69"] = 54,["70"] = 54,["71"] = 54,["72"] = 54,["73"] = 54,["74"] = 54,["75"] = 54,["76"] = 54,["77"] = 54,["78"] = 54,["79"] = 54,["80"] = 55,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 56,["85"] = 56,["86"] = 56,["87"] = 56,["88"] = 56,["89"] = 56,["90"] = 56,["91"] = 56,["92"] = 56,["93"] = 68,["94"] = 68,["95"] = 68,["96"] = 56,["97"] = 56,["98"] = 44,["99"] = 74,["100"] = 75,["101"] = 76,["102"] = 77,["103"] = 78,["104"] = 79,["105"] = 79,["106"] = 79,["107"] = 79,["108"] = 79,["109"] = 79,["110"] = 79,["111"] = 79,["112"] = 79,["113"] = 80,["114"] = 80,["115"] = 80,["116"] = 80,["117"] = 80,["118"] = 80,["119"] = 80,["121"] = 74,["122"] = 3,["123"] = 2,["124"] = 3,["126"] = 90,["127"] = 90,["128"] = 91,["129"] = 94,["130"] = 95,["131"] = 96,["132"] = 97,["133"] = 98,["135"] = 100,["138"] = 94,["139"] = 104,["140"] = 105,["141"] = 106,["143"] = 104,["144"] = 109,["145"] = 110,["146"] = 111,["147"] = 111,["148"] = 111,["149"] = 111,["150"] = 111,["151"] = 116,["152"] = 116,["153"] = 116,["154"] = 116,["155"] = 116,["157"] = 109,["158"] = 119,["159"] = 120,["160"] = 121,["162"] = 119,["163"] = 124,["164"] = 125,["165"] = 124,["166"] = 132,["167"] = 133,["168"] = 132,["169"] = 139,["170"] = 140,["171"] = 139,["172"] = 142,["173"] = 143,["174"] = 142,["175"] = 145,["176"] = 146,["177"] = 145,["178"] = 91,["179"] = 90,["180"] = 91,["182"] = 149,["183"] = 149,["184"] = 150,["186"] = 150,["187"] = 152,["188"] = 149,["189"] = 157,["190"] = 158,["191"] = 159,["192"] = 160,["193"] = 161,["194"] = 162,["195"] = 163,["196"] = 164,["197"] = 165,["198"] = 166,["199"] = 167,["201"] = 169,["204"] = 157,["205"] = 173,["206"] = 174,["207"] = 175,["208"] = 175,["209"] = 175,["210"] = 175,["211"] = 176,["213"] = 173,["214"] = 179,["215"] = 180,["216"] = 181,["218"] = 179,["219"] = 184,["220"] = 185,["221"] = 186,["222"] = 187,["224"] = 184,["225"] = 190,["226"] = 191,["227"] = 190,["228"] = 195,["229"] = 196,["230"] = 195,["231"] = 150,["232"] = 149,["233"] = 150});
boss_1_1 = __TS__Class()
boss_1_1.name = "boss_1_1"
__TS__ClassExtends(boss_1_1, BaseAbility)
function boss_1_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_1_1/wave/wave.vpcf", context)
    PrecacheResource("particle", "particles/warning/linear.vpcf", context)
end
function boss_1_1.prototype.GetCastPoint(self)
    return 1.5
end
function boss_1_1.prototype.GetPlaybackRateOverride(self)
    return 0.5
end
function boss_1_1.prototype.GetCastAnimation(self)
    return ACT_DOTA_OVERRIDE_ABILITY_2
end
function boss_1_1.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local vStartPosition = hCaster:GetAbsOrigin()
    local fWidth = self.Values:width()
    local fDistance = self.Values:distance()
    local vEndPosition = self:GetCursorPosition()
    local vDirection = (vEndPosition - hCaster:GetAbsOrigin()):Normalized()
    vEndPosition = hCaster:GetAbsOrigin() + vDirection * fDistance
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/linear.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vStartPosition)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 1, vEndPosition)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(fWidth, fCastPoint, 1 / fCastPoint)
            )
        end,
        {weight = 0}
    )
    return true
end
function boss_1_1.prototype.OnAbilityPhaseInterrupted(self)
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
        end,
        {weight = 0}
    )
end
function boss_1_1.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vPos = self:GetCursorPosition()
    local fDistance = self.Values:distance()
    local fSpeed = self.Values:speed()
    local fWidth = self.Values:width()
    local dmg_factor = self.Values:dmg_factor()
    local fDuration = fDistance / fSpeed
    local vDirection = (vPos - hCaster:GetAbsOrigin()):Normalized()
    vPos = hCaster:GetAbsOrigin() + vDirection * fDistance
    hCaster:AddNewModifier(
        hCaster,
        self,
        "modifier_boss_1_1_move",
        {
            duration = fDuration,
            vStartPos = VectorToString(
                _G,
                hCaster:GetAbsOrigin()
            ),
            vEndPos = VectorToString(_G, vPos)
        }
    )
    local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        Source = hCaster,
        EffectName = "particles/boss/boss_1_1/wave/wave.vpcf",
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
        }
    })
end
function boss_1_1.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    local hCaster = self:GetCaster()
    if IsValid(hCaster) and IsValid(target) then
        local fDamage = extraData.fDamage
        local vDirection = (target:GetAbsOrigin() - location):Normalized()
        target:AddNewModifier(
            hCaster,
            self,
            "modifier_boss_1_1_knockback",
            {
                duration = 0.2,
                vDirection = VectorToString(_G, vDirection)
            }
        )
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
    end
end
boss_1_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_1_1
)
modifier_boss_1_1_move = __TS__Class()
modifier_boss_1_1_move.name = "modifier_boss_1_1_move"
__TS__ClassExtends(modifier_boss_1_1_move, BaseModifierMotionHorizontal)
function modifier_boss_1_1_move.prototype.OnCreated(self, params)
    if IsServer() then
        if self:ApplyHorizontalMotionController() then
            self.vStartPos = StringToVector(_G, params.vStartPos)
            self.vEndPos = StringToVector(_G, params.vEndPos)
        else
            self:Destroy()
        end
    end
end
function modifier_boss_1_1_move.prototype.OnDestroy(self)
    if IsServer() then
        self:GetParent():RemoveHorizontalMotionController(self)
    end
end
function modifier_boss_1_1_move.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        ExecuteOrderFromTable({
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Position = self.vEndPos,
            UnitIndex = me:entindex()
        })
        me:SetAbsOrigin(VectorLerp(
            self:GetElapsedTime() / self:GetDuration(),
            self.vStartPos,
            self.vEndPos
        ))
    end
end
function modifier_boss_1_1_move.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_1_1_move.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
function modifier_boss_1_1_move.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function modifier_boss_1_1_move.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_RUN
end
function modifier_boss_1_1_move.prototype.GetActivityTranslationModifiers(self)
    return "haste"
end
function modifier_boss_1_1_move.prototype.GetOverrideAnimationRate(self)
    return 2
end
modifier_boss_1_1_move = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_1_1_move
)
modifier_boss_1_1_knockback = __TS__Class()
modifier_boss_1_1_knockback.name = "modifier_boss_1_1_knockback"
__TS__ClassExtends(modifier_boss_1_1_knockback, BaseModifierMotionHorizontal)
function modifier_boss_1_1_knockback.prototype.____constructor(self, ...)
    BaseModifierMotionHorizontal.prototype.____constructor(self, ...)
    self.fDistance = 1000
end
function modifier_boss_1_1_knockback.prototype.OnCreated(self, params)
    if IsServer() then
        if self:ApplyHorizontalMotionController() then
            local hParent = self:GetParent()
            self.vStartPosition = hParent:GetAbsOrigin()
            self.fStartTime = GameRules:GetGameTime()
            self.vDirection = StringToVector(_G, params.vDirection)
            local fDuration = self:GetDuration()
            local fAcceleration = 3000 / fDuration
            self.vAcceleration = self.vDirection * -fAcceleration
            self.vStartVelocity = self.vDirection * self.fDistance / fDuration - self.vAcceleration * fDuration / 2
        else
            self:Destroy()
        end
    end
end
function modifier_boss_1_1_knockback.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        local fTime = math.min(
            GameRules:GetGameTime() - self.fStartTime,
            self:GetDuration()
        )
        me:SetAbsOrigin(self.vStartPosition + self.vStartVelocity * fTime + fTime * fTime * self.vAcceleration / 2)
    end
end
function modifier_boss_1_1_knockback.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_1_1_knockback.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:RemoveHorizontalMotionController(self)
    end
end
function modifier_boss_1_1_knockback.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_1_1_knockback.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
modifier_boss_1_1_knockback = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_1_1_knockback
)