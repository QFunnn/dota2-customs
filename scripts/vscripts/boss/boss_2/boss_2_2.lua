--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_2\\boss_2_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 8,["16"] = 5,["17"] = 10,["18"] = 11,["19"] = 10,["20"] = 13,["21"] = 14,["22"] = 13,["23"] = 16,["24"] = 17,["25"] = 16,["26"] = 19,["27"] = 20,["28"] = 19,["29"] = 22,["30"] = 23,["31"] = 24,["32"] = 25,["33"] = 26,["34"] = 27,["35"] = 28,["36"] = 29,["37"] = 29,["38"] = 30,["39"] = 31,["40"] = 32,["41"] = 32,["42"] = 32,["43"] = 32,["44"] = 32,["45"] = 33,["46"] = 34,["47"] = 34,["48"] = 34,["49"] = 34,["50"] = 34,["51"] = 34,["52"] = 34,["53"] = 34,["54"] = 34,["55"] = 35,["56"] = 29,["57"] = 29,["58"] = 29,["59"] = 39,["60"] = 22,["61"] = 41,["62"] = 42,["63"] = 43,["64"] = 43,["65"] = 44,["66"] = 43,["67"] = 43,["68"] = 43,["70"] = 41,["71"] = 50,["72"] = 51,["73"] = 52,["74"] = 53,["75"] = 54,["76"] = 55,["77"] = 56,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 56,["82"] = 56,["83"] = 56,["84"] = 56,["85"] = 56,["86"] = 56,["87"] = 56,["88"] = 67,["89"] = 68,["90"] = 69,["91"] = 70,["92"] = 71,["94"] = 73,["95"] = 73,["97"] = 75,["98"] = 75,["99"] = 75,["100"] = 76,["101"] = 77,["102"] = 77,["103"] = 77,["104"] = 77,["105"] = 77,["106"] = 77,["107"] = 77,["108"] = 77,["109"] = 77,["110"] = 77,["111"] = 77,["112"] = 88,["113"] = 89,["114"] = 90,["115"] = 91,["119"] = 95,["120"] = 96,["121"] = 96,["122"] = 96,["123"] = 97,["124"] = 98,["126"] = 96,["127"] = 96,["128"] = 75,["129"] = 75,["130"] = 102,["132"] = 50,["133"] = 105,["134"] = 106,["135"] = 107,["136"] = 108,["137"] = 109,["138"] = 110,["139"] = 111,["140"] = 112,["141"] = 113,["142"] = 114,["143"] = 114,["144"] = 114,["145"] = 114,["146"] = 114,["147"] = 114,["148"] = 114,["149"] = 114,["150"] = 114,["151"] = 114,["152"] = 114,["153"] = 114,["154"] = 126,["155"] = 127,["156"] = 128,["157"] = 129,["158"] = 129,["159"] = 129,["160"] = 129,["161"] = 130,["162"] = 131,["165"] = 105,["166"] = 135,["167"] = 136,["168"] = 137,["169"] = 138,["170"] = 139,["171"] = 140,["172"] = 141,["173"] = 142,["174"] = 143,["175"] = 144,["176"] = 145,["179"] = 146,["180"] = 147,["181"] = 148,["182"] = 149,["183"] = 150,["187"] = 154,["188"] = 155,["189"] = 155,["190"] = 156,["191"] = 157,["192"] = 158,["193"] = 158,["194"] = 158,["195"] = 158,["196"] = 158,["197"] = 159,["198"] = 155,["199"] = 155,["200"] = 155,["201"] = 163,["202"] = 163,["203"] = 163,["204"] = 163,["205"] = 163,["206"] = 163,["207"] = 163,["208"] = 163,["209"] = 163,["210"] = 163,["211"] = 163,["212"] = 174,["213"] = 175,["214"] = 175,["215"] = 175,["216"] = 175,["217"] = 175,["218"] = 175,["219"] = 175,["220"] = 182,["221"] = 183,["222"] = 184,["223"] = 184,["224"] = 184,["225"] = 184,["226"] = 184,["227"] = 184,["228"] = 184,["229"] = 184,["230"] = 184,["231"] = 184,["232"] = 194,["235"] = 197,["237"] = 135,["238"] = 2,["239"] = 1,["240"] = 2,["242"] = 201,["243"] = 201,["244"] = 202,["246"] = 202,["247"] = 203,["248"] = 204,["249"] = 205,["250"] = 201,["251"] = 206,["252"] = 207,["253"] = 208,["254"] = 209,["258"] = 206,["259"] = 214,["260"] = 215,["261"] = 216,["262"] = 217,["263"] = 218,["264"] = 219,["265"] = 220,["266"] = 220,["267"] = 220,["268"] = 220,["269"] = 220,["271"] = 214,["272"] = 223,["273"] = 224,["274"] = 223,["275"] = 230,["276"] = 231,["277"] = 230,["278"] = 235,["279"] = 236,["280"] = 235,["281"] = 238,["282"] = 239,["283"] = 240,["284"] = 241,["285"] = 242,["286"] = 243,["287"] = 244,["289"] = 246,["291"] = 248,["293"] = 238,["294"] = 251,["295"] = 252,["296"] = 253,["297"] = 254,["298"] = 255,["299"] = 256,["300"] = 257,["301"] = 258,["303"] = 260,["304"] = 261,["305"] = 262,["307"] = 264,["309"] = 251,["310"] = 267,["311"] = 268,["312"] = 269,["314"] = 267,["315"] = 272,["316"] = 273,["317"] = 274,["319"] = 272,["320"] = 202,["321"] = 201,["322"] = 202,["324"] = 278,["325"] = 278,["326"] = 279,["327"] = 280,["328"] = 281,["329"] = 280,["330"] = 283,["331"] = 284,["332"] = 283,["333"] = 289,["334"] = 290,["335"] = 289,["336"] = 292,["337"] = 293,["338"] = 292,["339"] = 279,["340"] = 278,["341"] = 279});
boss_2_2 = __TS__Class()
boss_2_2.name = "boss_2_2"
__TS__ClassExtends(boss_2_2, BaseAbility)
function boss_2_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/circular.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_2/boss_2_1/blur/blur.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_2/boss_2_1/boom/boom.vpcf", context)
end
function boss_2_2.prototype.GetAOERadius(self)
    return self.Values:radius()
end
function boss_2_2.prototype.GetCastPoint(self)
    return 1
end
function boss_2_2.prototype.GetPlaybackRateOverride(self)
    return 0.5
end
function boss_2_2.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_6
end
function boss_2_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local vPosition = self:GetCursorPosition()
    local radius = self.Values:radius()
    local vDirection = (vPosition - hCaster:GetAbsOrigin()):Normalized()
    vPosition = hCaster:GetAbsOrigin() + vDirection * 450
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vPosition)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(radius, fCastPoint, 1 / fCastPoint)
            )
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_2/boss_2_1/blur/blur.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControlEnt(
                iParticleID,
                0,
                hCaster,
                PATTACH_POINT_FOLLOW,
                "attach_attack2",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
        end,
        {weight = 0}
    )
    return true
end
function boss_2_2.prototype.OnAbilityPhaseInterrupted(self)
    if self.iParticleID ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            end,
            {weight = 0}
        )
    end
end
function boss_2_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local radius = self.Values:radius()
    local vDirection = (vPosition - hCaster:GetAbsOrigin()):Normalized()
    vPosition = hCaster:GetAbsOrigin() + vDirection * 450
    local tTargets = FindUnitsInRadius(
        hCaster:GetTeamNumber(),
        vPosition,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST,
        false
    )
    if #tTargets > 0 then
        for _, hTarget in ipairs(tTargets) do
            hTarget:AddNewModifier(hCaster, self, "modifier_boss_2_2_debuff", {duration = 5})
            if self.tGrabTarget == nil then
                self.tGrabTarget = {}
            end
            local ____self_tGrabTarget_0 = self.tGrabTarget
            ____self_tGrabTarget_0[#____self_tGrabTarget_0 + 1] = hTarget
        end
        self:GameTimer(
            0.23,
            function()
                hCaster:StartGesture(ACT_DOTA_CAST_ABILITY_5)
                local tTargets = FindUnitsInRadius(
                    hCaster:GetTeamNumber(),
                    hCaster:GetAbsOrigin(),
                    nil,
                    -1,
                    DOTA_UNIT_TARGET_TEAM_ENEMY,
                    DOTA_UNIT_TARGET_HERO,
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_CLOSEST,
                    false
                )
                local vPos = hCaster:GetAbsOrigin() + hCaster:GetForwardVector() * 800
                for _, hTarget in ipairs(tTargets) do
                    if not hTarget:HasModifier("modifier_boss_2_2_debuff") then
                        vPos = hTarget:GetAbsOrigin()
                        break
                    end
                end
                hCaster:FaceTowards(vPos)
                self:GameTimer(
                    0.567,
                    function()
                        for _, hTarget in ipairs(self.tGrabTarget) do
                            self:_OnSpellStart(hTarget, vPos)
                        end
                    end
                )
            end
        )
        hCaster:AddNewModifier(hCaster, self, "modifier_boss_2_2_buff", {duration = 5})
    end
end
function boss_2_2.prototype._OnSpellStart(self, hTarget, vPosition)
    if IsValid(hTarget) then
        local hCaster = self:GetCaster()
        local vSpawnLocation = hCaster:GetAttachmentOrigin(hCaster:ScriptLookupAttachment("attach_attack2"))
        local vDirection = (vPosition - vSpawnLocation):Normalized()
        vDirection.z = 0
        local radius = self.Values:radius()
        local speed = self.Values:speed()
        local fDistance = (vPosition - vSpawnLocation):Length2D()
        local tInfo = {
            EffectName = "",
            Source = hCaster,
            Ability = self,
            vSpawnOrigin = vSpawnLocation,
            fStartRadius = radius,
            fEndRadius = radius,
            vVelocity = vDirection * speed,
            fDistance = fDistance,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
        }
        local hModifier = hTarget:FindModifierByName("modifier_boss_2_2_debuff")
        if IsValid(hModifier) then
            hModifier.nProjHandle = ProjectileManager:CreateLinearProjectile(tInfo)
            hModifier.flHeight = vSpawnLocation.z - GetGroundHeight(
                hCaster:GetAbsOrigin(),
                hCaster
            )
            hModifier.flTime = fDistance / speed
            hCaster:RemoveModifierByName("modifier_boss_2_2_buff")
        end
    end
end
function boss_2_2.prototype.OnProjectileHit(self, target, location)
    if not IsValid(target) then
        local hCaster = self:GetCaster()
        local dmg_factor = self.Values:dmg_factor()
        local fRadius = self.Values:radius()
        local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
        local knockback_duration = self.Values:knockback_duration()
        local knockback_distance = self.Values:knockback_distance()
        local knockback_height = self.Values:knockback_height()
        local stun_duration = self.Values:stun_duration()
        if self.tGrabTarget == nil then
            return
        end
        for _, hTarget in ipairs(self.tGrabTarget) do
            if IsValid(hTarget) then
                local hModifier = hTarget:FindModifierByName("modifier_boss_2_2_debuff")
                if IsValid(hModifier) then
                    hModifier:Destroy()
                end
            end
        end
        self.tGrabTarget = nil
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_2/boss_2_1/boom/boom.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, location)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(fRadius, fRadius, fRadius)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        local tTargets = FindUnitsInRadius(
            hCaster:GetTeamNumber(),
            location,
            nil,
            fRadius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_CLOSEST,
            false
        )
        for _, hTarget in ipairs(tTargets) do
            ApplyDamage({
                ability = self,
                attacker = hCaster,
                victim = hTarget,
                damage = fDamage,
                damage_type = DAMAGE_TYPE_PHYSICAL
            })
            if hTarget:IsAlive() then
                local vCenter = hCaster:GetAbsOrigin()
                hTarget:AddNewModifier(hCaster, self, "modifier_knockback", {
                    center_x = vCenter.x,
                    center_y = vCenter.y,
                    center_z = vCenter.z,
                    should_stun = false,
                    duration = knockback_duration,
                    knockback_duration = knockback_duration,
                    knockback_distance = knockback_distance,
                    knockback_height = knockback_height
                })
                hTarget:AddNewModifier(hCaster, self, "modifier_stunned_custom", {duration = stun_duration})
            end
        end
        return false
    end
end
boss_2_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_2_2
)
modifier_boss_2_2_debuff = __TS__Class()
modifier_boss_2_2_debuff.name = "modifier_boss_2_2_debuff"
__TS__ClassExtends(modifier_boss_2_2_debuff, BaseModifierMotionBoth)
function modifier_boss_2_2_debuff.prototype.____constructor(self, ...)
    BaseModifierMotionBoth.prototype.____constructor(self, ...)
    self.nProjHandle = -1
    self.flTime = 0
    self.flHeight = 0
end
function modifier_boss_2_2_debuff.prototype.OnCreated(self, params)
    if IsServer() then
        if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
            self:Destroy()
            return
        end
    end
end
function modifier_boss_2_2_debuff.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        hParent:RemoveHorizontalMotionController(self)
        hParent:RemoveVerticalMotionController(self)
        FindClearSpaceForUnit(
            hParent,
            hParent:GetAbsOrigin(),
            true
        )
    end
end
function modifier_boss_2_2_debuff.prototype.CheckState(self)
    return {[MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_OUT_OF_GAME] = true}
end
function modifier_boss_2_2_debuff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_2_2_debuff.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
function modifier_boss_2_2_debuff.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        local vLocation
        if self.nProjHandle == -1 then
            vLocation = hCaster:GetAttachmentOrigin(hCaster:ScriptLookupAttachment("attach_attack2"))
        else
            vLocation = ProjectileManager:GetLinearProjectileLocation(self.nProjHandle)
        end
        me:SetAbsOrigin(vLocation)
    end
end
function modifier_boss_2_2_debuff.prototype.UpdateVerticalMotion(self, me, dt)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        local vMyPos = me:GetAbsOrigin()
        if self.nProjHandle == -1 then
            local vLocation = hCaster:GetAttachmentOrigin(hCaster:ScriptLookupAttachment("attach_attack2"))
            vMyPos.z = vLocation.z
        else
            local flGroundHeight = GetGroundHeight(vMyPos, me)
            local flHeightChange = dt * self.flTime * self.flHeight * 1.3
            vMyPos.z = math.max(vMyPos.z - flHeightChange, flGroundHeight)
        end
        me:SetAbsOrigin(vMyPos)
    end
end
function modifier_boss_2_2_debuff.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_2_2_debuff.prototype.OnVerticalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
modifier_boss_2_2_debuff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_2_2_debuff
)
modifier_boss_2_2_buff = __TS__Class()
modifier_boss_2_2_buff.name = "modifier_boss_2_2_buff"
__TS__ClassExtends(modifier_boss_2_2_buff, BaseModifier)
function modifier_boss_2_2_buff.prototype.IsHidden(self)
    return true
end
function modifier_boss_2_2_buff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE}
end
function modifier_boss_2_2_buff.prototype.GetActivityTranslationModifiers(self)
    return "tree"
end
function modifier_boss_2_2_buff.prototype.GetModifierTurnRate_Percentage(self)
    return -90
end
modifier_boss_2_2_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_2_2_buff
)