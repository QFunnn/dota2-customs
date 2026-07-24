--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_4\\boss_4_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 4,["16"] = 8,["17"] = 9,["18"] = 8,["19"] = 11,["20"] = 13,["21"] = 11,["22"] = 15,["23"] = 16,["24"] = 17,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 20,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 23,["33"] = 23,["34"] = 23,["35"] = 23,["36"] = 20,["37"] = 20,["38"] = 20,["39"] = 27,["40"] = 28,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 28,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 28,["49"] = 29,["50"] = 15,["51"] = 31,["52"] = 32,["53"] = 33,["54"] = 33,["55"] = 34,["56"] = 33,["57"] = 33,["58"] = 33,["60"] = 31,["61"] = 2,["62"] = 1,["63"] = 2,["65"] = 41,["66"] = 41,["67"] = 42,["68"] = 50,["69"] = 51,["70"] = 52,["71"] = 53,["72"] = 54,["73"] = 55,["74"] = 56,["75"] = 57,["76"] = 58,["77"] = 59,["78"] = 60,["79"] = 61,["80"] = 62,["82"] = 64,["85"] = 50,["86"] = 68,["87"] = 69,["88"] = 70,["89"] = 71,["90"] = 72,["91"] = 73,["92"] = 74,["93"] = 74,["94"] = 75,["95"] = 76,["96"] = 77,["97"] = 77,["98"] = 77,["99"] = 77,["100"] = 77,["101"] = 78,["102"] = 74,["103"] = 74,["104"] = 74,["105"] = 82,["106"] = 82,["107"] = 82,["108"] = 82,["109"] = 82,["110"] = 82,["111"] = 82,["112"] = 82,["113"] = 82,["114"] = 82,["115"] = 82,["116"] = 93,["117"] = 94,["118"] = 94,["119"] = 94,["120"] = 94,["121"] = 94,["122"] = 94,["123"] = 94,["125"] = 102,["127"] = 68,["128"] = 105,["129"] = 106,["130"] = 107,["131"] = 107,["132"] = 107,["133"] = 107,["134"] = 107,["136"] = 105,["137"] = 110,["138"] = 111,["139"] = 112,["141"] = 110,["142"] = 115,["143"] = 116,["144"] = 117,["146"] = 115,["147"] = 120,["148"] = 121,["149"] = 122,["151"] = 120,["152"] = 125,["153"] = 126,["154"] = 125,["155"] = 131,["156"] = 132,["157"] = 131,["158"] = 134,["159"] = 135,["160"] = 134,["161"] = 42,["162"] = 41,["163"] = 42,["165"] = 138,["166"] = 138,["167"] = 139,["168"] = 141,["169"] = 142,["170"] = 143,["171"] = 144,["172"] = 145,["174"] = 141,["175"] = 148,["176"] = 149,["177"] = 150,["178"] = 151,["179"] = 152,["180"] = 152,["181"] = 152,["182"] = 152,["183"] = 152,["184"] = 152,["185"] = 152,["186"] = 152,["187"] = 152,["188"] = 152,["189"] = 152,["190"] = 163,["191"] = 163,["192"] = 164,["193"] = 165,["194"] = 166,["195"] = 166,["196"] = 166,["197"] = 166,["198"] = 166,["199"] = 167,["200"] = 163,["201"] = 163,["202"] = 163,["203"] = 171,["204"] = 172,["205"] = 172,["206"] = 172,["207"] = 172,["208"] = 172,["209"] = 172,["210"] = 172,["211"] = 179,["212"] = 180,["213"] = 181,["214"] = 181,["215"] = 181,["216"] = 181,["217"] = 181,["218"] = 181,["219"] = 181,["220"] = 181,["221"] = 181,["224"] = 148,["225"] = 193,["226"] = 194,["227"] = 193,["228"] = 198,["229"] = 199,["230"] = 198,["231"] = 203,["232"] = 204,["233"] = 203,["234"] = 139,["235"] = 138,["236"] = 139});
boss_4_4 = __TS__Class()
boss_4_4.name = "boss_4_4"
__TS__ClassExtends(boss_4_4, BaseAbility)
function boss_4_4.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_tectonic_shift_projectile.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_4/boss_4_4/hit/hit.vpcf", context)
end
function boss_4_4.prototype.GetCastPoint(self)
    return 1
end
function boss_4_4.prototype.GetCastAnimation(self)
    return ACT_INVALID
end
function boss_4_4.prototype.OnAbilityPhaseStart(self)
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
        "modifier_boss_4_4_jump",
        {
            duration = duration,
            vPosition = VectorToString(_G, vPosition)
        }
    )
    return true
end
function boss_4_4.prototype.OnAbilityPhaseInterrupted(self)
    if self.iParticleID ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            end,
            {weight = 0}
        )
    end
end
boss_4_4 = __TS__DecorateLegacy(
    {register(_G)},
    boss_4_4
)
modifier_boss_4_4_jump = __TS__Class()
modifier_boss_4_4_jump.name = "modifier_boss_4_4_jump"
__TS__ClassExtends(modifier_boss_4_4_jump, BaseModifierMotionBoth)
function modifier_boss_4_4_jump.prototype.OnCreated(self, params)
    if IsServer() then
        local hParent = self:GetParent()
        self.radius = self.Values:radius()
        self.vStartPosition = hParent:GetAbsOrigin()
        self.vEndPosition = StringToVector(_G, params.vPosition)
        self.height = self.Values:height()
        self.fDamage = AttributeKind.Atk:Get(hParent) * self.Values:dmg_factor()
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
function modifier_boss_4_4_jump.prototype.OnDestroy(self)
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
        hParent:AddNewModifier(hParent, hAbility, "modifier_boss_4_4_buff", {duration = 10})
    end
end
function modifier_boss_4_4_jump.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        me:SetAbsOrigin(VectorLerp(
            self:GetElapsedTime() / self:GetDuration(),
            self.vStartPosition,
            self.vEndPosition
        ))
    end
end
function modifier_boss_4_4_jump.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_4_4_jump.prototype.UpdateVerticalMotion(self, me, dt)
    if IsServer() then
        me:SetAbsOrigin(self.vStartPosition + self.vStartVerticalVelocity * self:GetElapsedTime() + 0.5 * self.vAcceleration * (self:GetElapsedTime() * self:GetElapsedTime()))
    end
end
function modifier_boss_4_4_jump.prototype.OnVerticalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_4_4_jump.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function modifier_boss_4_4_jump.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function modifier_boss_4_4_jump.prototype.GetOverrideAnimationRate(self)
    return 2.5
end
modifier_boss_4_4_jump = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_4_4_jump
)
modifier_boss_4_4_buff = __TS__Class()
modifier_boss_4_4_buff.name = "modifier_boss_4_4_buff"
__TS__ClassExtends(modifier_boss_4_4_buff, BaseModifier)
function modifier_boss_4_4_buff.prototype.OnCreated(self, params)
    if IsServer() then
        local hParent = self:GetParent()
        self.fDamage = AttributeKind.Atk:Get(hParent) * self.Values:dmg_factor()
        self:StartIntervalThink(0.75)
    end
end
function modifier_boss_4_4_buff.prototype.OnIntervalThink(self)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    local vPosition = hParent:GetAbsOrigin() + hParent:GetForwardVector() * 300
    local tTargets = FindUnitsInRadius(
        hParent:GetTeamNumber(),
        vPosition,
        nil,
        1000,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST,
        false
    )
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_4/boss_4_4/hit/hit.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                1,
                Vector(1000, 1000, 1000)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
        end,
        {weight = 0}
    )
    for _, hTarget in ipairs(tTargets) do
        ApplyDamage({
            ability = hAbility,
            attacker = hParent,
            victim = hTarget,
            damage = self.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
        local vTarget = hTarget:GetAbsOrigin()
        if IsValid(hTarget) and hTarget:IsAlive() then
            hTarget:AddNewModifier(hParent, hAbility, "modifier_knockback", {
                duration = 0.5,
                knockback_duration = 0.5,
                knockback_distance = 0,
                knockback_height = 600,
                center_x = vTarget.x,
                center_y = vTarget.y,
                center_z = vTarget.z
            })
        end
    end
end
function modifier_boss_4_4_buff.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true}
end
function modifier_boss_4_4_buff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_4_4_buff.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_CHANNEL_ABILITY_5
end
modifier_boss_4_4_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_4_4_buff
)