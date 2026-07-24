--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_3\\boss_3_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 4,["17"] = 9,["18"] = 10,["19"] = 9,["20"] = 12,["21"] = 14,["22"] = 12,["23"] = 16,["24"] = 17,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 24,["34"] = 24,["35"] = 24,["36"] = 24,["37"] = 21,["38"] = 21,["39"] = 21,["40"] = 28,["41"] = 29,["42"] = 29,["43"] = 29,["44"] = 29,["45"] = 29,["46"] = 29,["47"] = 29,["48"] = 29,["49"] = 29,["50"] = 30,["51"] = 16,["52"] = 32,["53"] = 33,["54"] = 34,["55"] = 34,["56"] = 35,["57"] = 34,["58"] = 34,["59"] = 34,["61"] = 32,["62"] = 41,["63"] = 42,["64"] = 43,["65"] = 44,["66"] = 44,["67"] = 44,["68"] = 44,["69"] = 44,["70"] = 44,["71"] = 44,["73"] = 41,["74"] = 2,["75"] = 1,["76"] = 2,["78"] = 54,["79"] = 54,["80"] = 55,["81"] = 66,["82"] = 67,["83"] = 68,["84"] = 69,["85"] = 70,["86"] = 71,["87"] = 72,["88"] = 73,["89"] = 74,["90"] = 75,["91"] = 76,["92"] = 77,["93"] = 78,["94"] = 79,["95"] = 80,["96"] = 81,["98"] = 83,["101"] = 66,["102"] = 87,["103"] = 88,["104"] = 89,["105"] = 90,["106"] = 91,["107"] = 92,["108"] = 93,["109"] = 93,["110"] = 94,["111"] = 95,["112"] = 96,["113"] = 96,["114"] = 96,["115"] = 96,["116"] = 96,["117"] = 97,["118"] = 93,["119"] = 93,["120"] = 93,["121"] = 101,["122"] = 101,["123"] = 101,["124"] = 101,["125"] = 101,["126"] = 101,["127"] = 101,["128"] = 101,["129"] = 101,["130"] = 101,["131"] = 101,["132"] = 112,["133"] = 113,["134"] = 113,["135"] = 113,["136"] = 113,["137"] = 113,["138"] = 113,["139"] = 113,["141"] = 121,["143"] = 122,["144"] = 122,["145"] = 123,["146"] = 124,["147"] = 124,["148"] = 124,["149"] = 124,["150"] = 124,["151"] = 124,["152"] = 124,["153"] = 124,["154"] = 124,["155"] = 124,["156"] = 124,["157"] = 124,["158"] = 124,["159"] = 124,["160"] = 122,["164"] = 87,["165"] = 143,["166"] = 144,["167"] = 145,["168"] = 145,["169"] = 145,["170"] = 145,["171"] = 145,["173"] = 143,["174"] = 148,["175"] = 149,["176"] = 150,["178"] = 148,["179"] = 153,["180"] = 154,["181"] = 155,["183"] = 153,["184"] = 158,["185"] = 159,["186"] = 160,["188"] = 158,["189"] = 163,["190"] = 164,["191"] = 163,["192"] = 169,["193"] = 170,["194"] = 169,["195"] = 172,["196"] = 173,["197"] = 172,["198"] = 55,["199"] = 54,["200"] = 55});
boss_3_1 = __TS__Class()
boss_3_1.name = "boss_3_1"
__TS__ClassExtends(boss_3_1, BaseAbility)
function boss_3_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/circular.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_3/boss_3_1/boom/boom.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_3/boss_3_1/projectile/projectile.vpcf", context)
end
function boss_3_1.prototype.GetCastPoint(self)
    return 1
end
function boss_3_1.prototype.GetCastAnimation(self)
    return ACT_INVALID
end
function boss_3_1.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local fCastPoint = self:GetCastPoint()
    local fRadius = self.Values:radius()
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vPosition)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(fRadius, fCastPoint, 1 / fCastPoint)
            )
        end,
        {weight = 0}
    )
    local duration = self.Values:duration()
    hCaster:AddNewModifier(
        hCaster,
        self,
        "modifier_boss_3_1_jump",
        {
            duration = duration,
            vPosition = VectorToString(_G, vPosition)
        }
    )
    return true
end
function boss_3_1.prototype.OnAbilityPhaseInterrupted(self)
    if self.iParticleID ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            end,
            {weight = 0}
        )
    end
end
function boss_3_1.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            damage = extraData.fDamage,
            victim = target,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
    end
end
boss_3_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_3_1
)
modifier_boss_3_1_jump = __TS__Class()
modifier_boss_3_1_jump.name = "modifier_boss_3_1_jump"
__TS__ClassExtends(modifier_boss_3_1_jump, BaseModifierMotionBoth)
function modifier_boss_3_1_jump.prototype.OnCreated(self, params)
    if IsServer() then
        local hParent = self:GetParent()
        self.radius = self.Values:radius()
        self.vStartPosition = hParent:GetAbsOrigin()
        self.vEndPosition = StringToVector(_G, params.vPosition)
        self.height = self.Values:height()
        self.fDamage = AttributeKind.Atk:Get(hParent) * self.Values:dmg_factor()
        self.speed = self.Values:speed()
        self.width = self.Values:width()
        self.distance = self.Values:distance()
        if self:ApplyVerticalMotionController() and self:ApplyHorizontalMotionController() then
            local vUpVector = hParent:GetUpVector()
            local fHeightOffset = self.vEndPosition.z - self.vStartPosition.z
            self.vAcceleration = -vUpVector * 8 * self.height / (self:GetDuration() * self:GetDuration())
            self.vStartVerticalVelocity = Vector(0, 0, fHeightOffset) / self:GetDuration() - self.vAcceleration * self:GetDuration() / 2
        else
            self:Destroy()
        end
    end
end
function modifier_boss_3_1_jump.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        hParent:RemoveHorizontalMotionController(self)
        hParent:RemoveVerticalMotionController(self)
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_3/boss_3_1/boom/boom.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, self.vEndPosition)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(self.radius, 0, 0)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        local tTargets = FindUnitsInRadius(
            hParent:GetTeamNumber(),
            hParent:GetAbsOrigin(),
            nil,
            self.radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_CLOSEST,
            false
        )
        for _, hTarget in ipairs(tTargets) do
            ApplyDamage({
                ability = hAbility,
                attacker = hTarget,
                victim = hTarget,
                damage = self.fDamage,
                damage_type = DAMAGE_TYPE_PHYSICAL
            })
        end
        local vDirection = hParent:GetForwardVector()
        do
            local i = 0
            while i < 4 do
                vDirection = Rotation2D(vDirection, 90 * i)
                ProjectileManager:CreateLinearProjectile({
                    Ability = hAbility,
                    Source = hParent,
                    EffectName = "particles/boss/boss_3/boss_3_1/projectile/projectile.vpcf",
                    vSpawnOrigin = self.vEndPosition,
                    vVelocity = self.speed * vDirection,
                    fDistance = self.distance,
                    fStartRadius = self.width,
                    fEndRadius = self.width,
                    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
                    ExtraData = {fDamage = self.fDamage}
                })
                i = i + 1
            end
        end
    end
end
function modifier_boss_3_1_jump.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        me:SetAbsOrigin(VectorLerp(
            self:GetElapsedTime() / self:GetDuration(),
            self.vStartPosition,
            self.vEndPosition
        ))
    end
end
function modifier_boss_3_1_jump.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_3_1_jump.prototype.UpdateVerticalMotion(self, me, dt)
    if IsServer() then
        me:SetAbsOrigin(self.vStartPosition + self.vStartVerticalVelocity * self:GetElapsedTime() + 0.5 * self.vAcceleration * (self:GetElapsedTime() * self:GetElapsedTime()))
    end
end
function modifier_boss_3_1_jump.prototype.OnVerticalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_3_1_jump.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function modifier_boss_3_1_jump.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_RUN_STATUE
end
function modifier_boss_3_1_jump.prototype.GetOverrideAnimationRate(self)
    return 2.5
end
modifier_boss_3_1_jump = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_3_1_jump
)