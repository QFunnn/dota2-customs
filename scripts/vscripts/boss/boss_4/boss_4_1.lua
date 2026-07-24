--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_4\\boss_4_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 8,["16"] = 5,["17"] = 10,["18"] = 11,["19"] = 10,["20"] = 13,["21"] = 14,["22"] = 13,["23"] = 16,["24"] = 17,["25"] = 16,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 22,["30"] = 23,["31"] = 24,["32"] = 25,["33"] = 26,["34"] = 27,["35"] = 28,["36"] = 28,["37"] = 29,["38"] = 30,["39"] = 31,["40"] = 32,["41"] = 32,["42"] = 32,["43"] = 32,["44"] = 32,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 36,["49"] = 37,["50"] = 19,["51"] = 39,["52"] = 40,["53"] = 40,["54"] = 41,["55"] = 40,["56"] = 40,["57"] = 40,["58"] = 39,["59"] = 46,["60"] = 47,["61"] = 48,["62"] = 49,["63"] = 50,["64"] = 51,["65"] = 52,["66"] = 53,["67"] = 54,["68"] = 55,["69"] = 56,["70"] = 56,["71"] = 56,["72"] = 56,["73"] = 56,["74"] = 56,["75"] = 56,["76"] = 56,["77"] = 56,["78"] = 56,["79"] = 56,["80"] = 56,["81"] = 56,["82"] = 57,["83"] = 58,["84"] = 58,["85"] = 58,["86"] = 58,["87"] = 58,["88"] = 58,["89"] = 58,["90"] = 58,["91"] = 58,["92"] = 58,["93"] = 58,["94"] = 58,["95"] = 70,["96"] = 70,["97"] = 70,["98"] = 58,["99"] = 58,["100"] = 46,["101"] = 76,["102"] = 77,["103"] = 78,["104"] = 79,["105"] = 80,["106"] = 81,["107"] = 81,["108"] = 81,["109"] = 81,["110"] = 81,["111"] = 81,["112"] = 81,["113"] = 81,["114"] = 81,["115"] = 82,["116"] = 82,["117"] = 82,["118"] = 82,["119"] = 82,["120"] = 82,["121"] = 82,["123"] = 76,["124"] = 3,["125"] = 2,["126"] = 3,["128"] = 92,["129"] = 92,["130"] = 93,["131"] = 94,["132"] = 95,["133"] = 96,["135"] = 99,["136"] = 100,["137"] = 100,["138"] = 100,["139"] = 100,["140"] = 100,["141"] = 100,["142"] = 100,["143"] = 100,["145"] = 94,["146"] = 103,["147"] = 104,["148"] = 103,["149"] = 110,["150"] = 111,["151"] = 110,["152"] = 113,["153"] = 114,["154"] = 113,["155"] = 116,["156"] = 117,["157"] = 116,["158"] = 93,["159"] = 92,["160"] = 93,["162"] = 120,["163"] = 120,["164"] = 121,["165"] = 124,["166"] = 125,["167"] = 126,["168"] = 127,["169"] = 128,["170"] = 129,["172"] = 131,["175"] = 134,["176"] = 135,["177"] = 135,["178"] = 135,["179"] = 135,["180"] = 135,["181"] = 135,["182"] = 135,["183"] = 135,["185"] = 124,["186"] = 138,["187"] = 139,["188"] = 140,["190"] = 138,["191"] = 143,["192"] = 144,["193"] = 145,["194"] = 145,["195"] = 145,["196"] = 145,["197"] = 145,["198"] = 150,["199"] = 150,["200"] = 150,["201"] = 150,["202"] = 150,["204"] = 143,["205"] = 153,["206"] = 154,["207"] = 155,["209"] = 153,["210"] = 158,["211"] = 159,["212"] = 158,["213"] = 166,["214"] = 167,["215"] = 166,["216"] = 173,["217"] = 174,["218"] = 173,["219"] = 176,["220"] = 177,["221"] = 176,["222"] = 179,["223"] = 180,["224"] = 179,["225"] = 121,["226"] = 120,["227"] = 121,["229"] = 183,["230"] = 183,["231"] = 184,["233"] = 184,["234"] = 186,["235"] = 183,["236"] = 191,["237"] = 192,["238"] = 193,["239"] = 194,["240"] = 195,["241"] = 196,["242"] = 197,["243"] = 198,["244"] = 199,["245"] = 200,["246"] = 201,["248"] = 203,["251"] = 191,["252"] = 207,["253"] = 208,["254"] = 209,["255"] = 209,["256"] = 209,["257"] = 209,["258"] = 210,["260"] = 207,["261"] = 213,["262"] = 214,["263"] = 215,["265"] = 213,["266"] = 218,["267"] = 219,["268"] = 220,["269"] = 221,["271"] = 218,["272"] = 224,["273"] = 225,["274"] = 224,["275"] = 229,["276"] = 230,["277"] = 229,["278"] = 184,["279"] = 183,["280"] = 184});
boss_4_1 = __TS__Class()
boss_4_1.name = "boss_4_1"
__TS__ClassExtends(boss_4_1, BaseAbility)
function boss_4_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/linear.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/primal_beast/primal_beast_2022_prestige/primal_beast_2022_prestige_onslaught_chargeup.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_4/boss_4_1/prestige/prestige.vpcf", context)
end
function boss_4_1.prototype.GetCastPoint(self)
    return 1
end
function boss_4_1.prototype.GetPlaybackRateOverride(self)
    return 1
end
function boss_4_1.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_2
end
function boss_4_1.prototype.OnAbilityPhaseStart(self)
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
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_4_1_buff", {duration = fCastPoint})
    return true
end
function boss_4_1.prototype.OnAbilityPhaseInterrupted(self)
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
        end,
        {weight = 0}
    )
end
function boss_4_1.prototype.OnSpellStart(self)
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
        "modifier_boss_4_1_move",
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
        EffectName = "",
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
function boss_4_1.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    local hCaster = self:GetCaster()
    if IsValid(hCaster) and IsValid(target) then
        local fDamage = extraData.fDamage
        local vDirection = (target:GetAbsOrigin() - location):Normalized()
        target:AddNewModifier(
            hCaster,
            self,
            "modifier_boss_4_1_knockback",
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
boss_4_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_4_1
)
modifier_boss_4_1_buff = __TS__Class()
modifier_boss_4_1_buff.name = "modifier_boss_4_1_buff"
__TS__ClassExtends(modifier_boss_4_1_buff, BaseModifier)
function modifier_boss_4_1_buff.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
    else
        local iParticleID = ParticleManager:CreateParticle("particles/econ/items/primal_beast/primal_beast_2022_prestige/primal_beast_2022_prestige_onslaught_chargeup.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
function modifier_boss_4_1_buff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function modifier_boss_4_1_buff.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_IDLE
end
function modifier_boss_4_1_buff.prototype.GetActivityTranslationModifiers(self)
    return "onslaught_windup"
end
function modifier_boss_4_1_buff.prototype.GetOverrideAnimationRate(self)
    return 3
end
modifier_boss_4_1_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_4_1_buff
)
modifier_boss_4_1_move = __TS__Class()
modifier_boss_4_1_move.name = "modifier_boss_4_1_move"
__TS__ClassExtends(modifier_boss_4_1_move, BaseModifierMotionHorizontal)
function modifier_boss_4_1_move.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        if self:ApplyHorizontalMotionController() then
            self.vStartPos = StringToVector(_G, params.vStartPos)
            self.vEndPos = StringToVector(_G, params.vEndPos)
        else
            self:Destroy()
        end
    else
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_4/boss_4_1/prestige/prestige.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
function modifier_boss_4_1_move.prototype.OnDestroy(self)
    if IsServer() then
        self:GetParent():RemoveHorizontalMotionController(self)
    end
end
function modifier_boss_4_1_move.prototype.UpdateHorizontalMotion(self, me, dt)
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
function modifier_boss_4_1_move.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_4_1_move.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
function modifier_boss_4_1_move.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function modifier_boss_4_1_move.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_RUN
end
function modifier_boss_4_1_move.prototype.GetActivityTranslationModifiers(self)
    return "onslaught_movement"
end
function modifier_boss_4_1_move.prototype.GetOverrideAnimationRate(self)
    return 2
end
modifier_boss_4_1_move = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_4_1_move
)
modifier_boss_4_1_knockback = __TS__Class()
modifier_boss_4_1_knockback.name = "modifier_boss_4_1_knockback"
__TS__ClassExtends(modifier_boss_4_1_knockback, BaseModifierMotionHorizontal)
function modifier_boss_4_1_knockback.prototype.____constructor(self, ...)
    BaseModifierMotionHorizontal.prototype.____constructor(self, ...)
    self.fDistance = 1000
end
function modifier_boss_4_1_knockback.prototype.OnCreated(self, params)
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
function modifier_boss_4_1_knockback.prototype.UpdateHorizontalMotion(self, me, dt)
    if IsServer() then
        local fTime = math.min(
            GameRules:GetGameTime() - self.fStartTime,
            self:GetDuration()
        )
        me:SetAbsOrigin(self.vStartPosition + self.vStartVelocity * fTime + fTime * fTime * self.vAcceleration / 2)
    end
end
function modifier_boss_4_1_knockback.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_4_1_knockback.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:RemoveHorizontalMotionController(self)
    end
end
function modifier_boss_4_1_knockback.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_4_1_knockback.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_FLAIL
end
modifier_boss_4_1_knockback = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_4_1_knockback
)