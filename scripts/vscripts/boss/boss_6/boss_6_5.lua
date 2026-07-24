--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_5"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 8,["17"] = 9,["18"] = 4,["19"] = 12,["20"] = 13,["21"] = 12,["22"] = 16,["23"] = 17,["24"] = 18,["25"] = 19,["26"] = 22,["27"] = 22,["28"] = 23,["29"] = 22,["30"] = 22,["31"] = 22,["32"] = 27,["33"] = 16,["34"] = 30,["35"] = 31,["36"] = 32,["37"] = 33,["38"] = 34,["39"] = 35,["40"] = 36,["41"] = 37,["42"] = 39,["43"] = 39,["44"] = 39,["45"] = 39,["46"] = 39,["47"] = 39,["48"] = 39,["49"] = 39,["50"] = 39,["51"] = 39,["52"] = 30,["53"] = 3,["54"] = 2,["55"] = 3,["57"] = 43,["58"] = 43,["59"] = 44,["60"] = 48,["61"] = 48,["62"] = 48,["63"] = 50,["64"] = 51,["65"] = 50,["66"] = 53,["67"] = 54,["68"] = 53,["69"] = 57,["70"] = 58,["71"] = 59,["72"] = 60,["73"] = 61,["75"] = 63,["76"] = 64,["77"] = 65,["79"] = 68,["80"] = 69,["81"] = 70,["82"] = 71,["83"] = 71,["84"] = 71,["85"] = 71,["86"] = 71,["87"] = 71,["88"] = 71,["89"] = 71,["90"] = 73,["91"] = 74,["93"] = 57,["94"] = 78,["95"] = 79,["96"] = 80,["97"] = 81,["98"] = 82,["100"] = 84,["101"] = 85,["102"] = 87,["103"] = 88,["105"] = 78,["106"] = 92,["107"] = 93,["108"] = 93,["109"] = 93,["110"] = 93,["111"] = 93,["112"] = 98,["113"] = 98,["114"] = 98,["115"] = 98,["116"] = 98,["117"] = 92,["118"] = 101,["119"] = 102,["120"] = 103,["121"] = 104,["122"] = 105,["123"] = 107,["124"] = 107,["125"] = 107,["126"] = 107,["127"] = 107,["128"] = 107,["129"] = 107,["130"] = 107,["131"] = 107,["132"] = 107,["133"] = 107,["134"] = 114,["135"] = 115,["136"] = 117,["137"] = 117,["138"] = 117,["139"] = 117,["140"] = 117,["141"] = 117,["142"] = 118,["143"] = 119,["145"] = 121,["146"] = 123,["147"] = 124,["148"] = 125,["149"] = 123,["150"] = 127,["151"] = 127,["152"] = 127,["153"] = 127,["154"] = 127,["155"] = 127,["156"] = 127,["157"] = 127,["158"] = 127,["159"] = 127,["160"] = 127,["161"] = 127,["162"] = 127,["163"] = 127,["164"] = 127,["165"] = 137,["166"] = 137,["167"] = 137,["168"] = 137,["169"] = 137,["170"] = 137,["171"] = 138,["172"] = 138,["173"] = 138,["174"] = 138,["175"] = 138,["176"] = 138,["177"] = 138,["180"] = 101,["181"] = 150,["182"] = 151,["183"] = 152,["185"] = 150,["186"] = 156,["187"] = 157,["188"] = 156,["189"] = 165,["190"] = 166,["191"] = 165,["192"] = 170,["193"] = 171,["194"] = 170,["195"] = 44,["196"] = 43,["197"] = 44,["199"] = 175,["200"] = 175,["201"] = 176,["202"] = 177,["203"] = 178,["204"] = 177,["205"] = 180,["206"] = 181,["207"] = 180,["208"] = 183,["209"] = 184,["210"] = 183,["211"] = 186,["212"] = 187,["213"] = 186,["214"] = 192,["215"] = 193,["216"] = 194,["217"] = 194,["218"] = 194,["219"] = 194,["221"] = 192,["222"] = 197,["223"] = 198,["224"] = 197,["225"] = 200,["226"] = 201,["227"] = 200,["228"] = 176,["229"] = 175,["230"] = 176});
boss_6_5 = __TS__Class()
boss_6_5.name = "boss_6_5"
__TS__ClassExtends(boss_6_5, BossAbility)
function boss_6_5.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_5/target_mark/target_mark.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_5/caster_cyclone/caster_cyclone.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_5/arcana_stunned/arcana_stunned.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_start.vpcf", context)
end
function boss_6_5.prototype.GetPlaybackRateOverride(self)
    return 3 / self:GetCastPoint()
end
function boss_6_5.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local hTarget = self:GetCursorTarget()
    local fCastPoint = self:GetCastPoint()
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:EmitSoundOn("Hero_Lycan.Shapeshift.Cast", hCaster)
        end,
        {weight = 0}
    )
    return true
end
function boss_6_5.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local hTarget = self:GetCursorTarget()
    local fDistance = self.Values:distance()
    local vDirection = (hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized()
    local vStartPosition = hCaster:GetAbsOrigin()
    local vEndPosition = vStartPosition + vDirection * fDistance
    local fDuration = fDistance / self.Values:speed()
    hCaster:AddNewModifier(
        hCaster,
        self,
        "modifier_boss_6_5_move",
        {
            duration = fDuration,
            vStartPosition = VectorToString(_G, vStartPosition),
            vEndPosition = VectorToString(_G, vEndPosition)
        }
    )
end
boss_6_5 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_5
)
modifier_boss_6_5_move = __TS__Class()
modifier_boss_6_5_move.name = "modifier_boss_6_5_move"
__TS__ClassExtends(modifier_boss_6_5_move, BaseModifierMotionHorizontal)
function modifier_boss_6_5_move.prototype.IsHidden(self)
    return true
end
function modifier_boss_6_5_move.prototype.GetEffectName(self)
    return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf"
end
function modifier_boss_6_5_move.prototype.GetEffectAttachType(self)
    return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_boss_6_5_move.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        if not self:ApplyHorizontalMotionController() then
            return self:Destroy()
        end
        self.vStartPosition = StringToVector(_G, params.vStartPosition)
        self.vEndPosition = StringToVector(_G, params.vEndPosition)
        self:StartIntervalThink(0.1)
    else
        local iPtclID = ParticleManager:CreateParticle("particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:ReleaseParticleIndex(iPtclID)
        iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/boss_6_5/caster_cyclone/caster_cyclone.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        self:AddParticle(
            iPtclID,
            false,
            false,
            -1,
            false,
            false
        )
        EmitSoundOn("Hero_Spirit_Breaker.NetherStrike.Begin", hParent)
        EmitSoundOn("Brewmaster_Storm.Cyclone", hParent)
    end
end
function modifier_boss_6_5_move.prototype.OnDestroy(self)
    local hParent = self:GetParent()
    if IsServer() then
        hParent:RemoveHorizontalMotionController(self)
        self:GetCaster():RemovePolymer("modifier_boss_6_5_target_debuff")
    else
        local iPtclID = ParticleManager:CreateParticle("particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:ReleaseParticleIndex(iPtclID)
        EmitSoundOn("Hero_Spirit_Breaker.NetherStrike.End", hParent)
        StopSoundOn("Brewmaster_Storm.Cyclone", hParent)
    end
end
function modifier_boss_6_5_move.prototype.UpdateHorizontalMotion(self, me, dt)
    ExecuteOrderFromTable({
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = self.vEndPosition,
        UnitIndex = me:entindex()
    })
    me:SetAbsOrigin(VectorLerp(
        self:GetElapsedTime() / self:GetDuration(),
        self.vStartPosition,
        self.vEndPosition
    ))
end
function modifier_boss_6_5_move.prototype.OnIntervalThink(self)
    local hParent = self:GetParent()
    local hAblt = self:GetAbility()
    local iTeam = hParent:GetTeamNumber()
    local fDmg = self.Values:damage_factor() * AttributeKind.Atk:Get(hParent)
    for ____, hUnit in ipairs(FindUnitsInRadius(
        iTeam,
        hParent:GetAbsOrigin(),
        nil,
        self.Values:range(),
        DOTA_UNIT_TARGET_TEAM_BOTH,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        FIND_CLOSEST,
        false
    )) do
        if hUnit:GetTeamNumber() == iTeam then
            if hUnit:FindModifierByName("modifier_boss_6_4_meteor") ~= nil then
                hParent:AddNewModifier(
                    self:GetCaster(),
                    hAblt,
                    "modifier_boss_6_5_stun",
                    {duration = self.Values:stun_duration()}
                )
                hUnit:SetForwardVector(hParent:GetForwardVector())
                hUnit:ForceKill(false)
            end
        elseif hUnit:IsRealHero() then
            ParticleManager_s2c:ToClient(function()
                local iPtclID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, hUnit)
                ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
            end)
            hUnit:AddNewModifier(
                hParent,
                hAblt,
                "modifier_knockback",
                {
                    duration = self.Values:stun_duration(),
                    knockback_duration = 0.15,
                    knockback_distance = self.Values:speed() * 0.2,
                    knockback_height = 50,
                    center_x = hParent:GetAbsOrigin().x,
                    center_y = hParent:GetAbsOrigin().y,
                    center_z = hParent:GetAbsOrigin().z,
                    should_stun = 1
                }
            )
            hUnit:AddNewModifier(
                hParent,
                hAblt,
                "modifier_stunned",
                {duration = self.Values:stun_duration()}
            )
            ApplyDamage({
                ability = hAblt,
                attacker = hParent,
                damage_type = hAblt:GetAbilityDamageType(),
                victim = hUnit,
                damage = fDmg
            })
        end
    end
end
function modifier_boss_6_5_move.prototype.OnHorizontalMotionInterrupted(self)
    if IsServer() then
        self:Destroy()
    end
end
function modifier_boss_6_5_move.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
function modifier_boss_6_5_move.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_6_5_move.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_CHANNEL_ABILITY_5
end
modifier_boss_6_5_move = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_6_5_move
)
modifier_boss_6_5_stun = __TS__Class()
modifier_boss_6_5_stun.name = "modifier_boss_6_5_stun"
__TS__ClassExtends(modifier_boss_6_5_stun, BaseModifier)
function modifier_boss_6_5_stun.prototype.IsHidden(self)
    return false
end
function modifier_boss_6_5_stun.prototype.IsStunDebuff(self)
    return true
end
function modifier_boss_6_5_stun.prototype.IsDebuff(self)
    return true
end
function modifier_boss_6_5_stun.prototype.CheckState(self)
    return {[MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_DISARMED] = true}
end
function modifier_boss_6_5_stun.prototype.OnCreated(self, params)
    if IsServer() then
        self:GetParent():StartGestureWithPlaybackRate(
            ACT_DOTA_DISABLED,
            1 / self:GetDuration() * 1.5
        )
    end
end
function modifier_boss_6_5_stun.prototype.GetEffectAttachType(self)
    return PATTACH_OVERHEAD_FOLLOW
end
function modifier_boss_6_5_stun.prototype.GetEffectName(self)
    return "particles/boss/boss_6/boss_6_5/arcana_stunned/arcana_stunned.vpcf"
end
modifier_boss_6_5_stun = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_6_5_stun
)