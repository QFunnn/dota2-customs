--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 4,["17"] = 9,["18"] = 10,["19"] = 9,["20"] = 12,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 18,["27"] = 19,["28"] = 20,["30"] = 21,["31"] = 21,["32"] = 22,["33"] = 23,["34"] = 24,["35"] = 24,["36"] = 24,["37"] = 24,["38"] = 24,["39"] = 24,["40"] = 24,["41"] = 24,["42"] = 25,["43"] = 26,["44"] = 27,["45"] = 27,["46"] = 27,["47"] = 27,["48"] = 27,["49"] = 28,["50"] = 28,["51"] = 28,["52"] = 28,["53"] = 28,["54"] = 29,["55"] = 30,["56"] = 31,["57"] = 32,["59"] = 21,["62"] = 12,["63"] = 3,["64"] = 2,["65"] = 3,["67"] = 37,["68"] = 37,["69"] = 38,["70"] = 40,["71"] = 41,["72"] = 40,["73"] = 43,["74"] = 44,["75"] = 45,["76"] = 46,["78"] = 48,["79"] = 49,["80"] = 49,["81"] = 49,["82"] = 49,["83"] = 49,["84"] = 49,["85"] = 49,["86"] = 49,["87"] = 49,["88"] = 50,["89"] = 51,["90"] = 52,["91"] = 52,["92"] = 52,["93"] = 52,["94"] = 52,["95"] = 52,["96"] = 52,["97"] = 52,["98"] = 52,["99"] = 53,["100"] = 53,["101"] = 53,["102"] = 53,["103"] = 53,["104"] = 53,["105"] = 53,["106"] = 53,["107"] = 53,["108"] = 54,["109"] = 54,["110"] = 54,["111"] = 54,["112"] = 54,["113"] = 54,["114"] = 54,["115"] = 54,["117"] = 43,["118"] = 57,["119"] = 58,["120"] = 59,["121"] = 60,["122"] = 61,["123"] = 62,["126"] = 65,["127"] = 66,["128"] = 66,["129"] = 66,["130"] = 66,["131"] = 66,["132"] = 66,["133"] = 66,["134"] = 67,["135"] = 68,["136"] = 69,["137"] = 69,["138"] = 69,["139"] = 69,["140"] = 69,["141"] = 69,["142"] = 69,["144"] = 77,["145"] = 77,["146"] = 78,["147"] = 79,["148"] = 79,["149"] = 79,["150"] = 79,["151"] = 79,["152"] = 80,["153"] = 80,["154"] = 80,["155"] = 80,["156"] = 80,["157"] = 81,["158"] = 82,["159"] = 77,["160"] = 77,["161"] = 77,["163"] = 87,["165"] = 57,["166"] = 90,["167"] = 91,["168"] = 90,["169"] = 96,["170"] = 97,["171"] = 96,["172"] = 99,["173"] = 100,["174"] = 99,["175"] = 38,["176"] = 37,["177"] = 38});
boss_5_3 = __TS__Class()
boss_5_3.name = "boss_5_3"
__TS__ClassExtends(boss_5_3, BaseAbility)
function boss_5_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss/boss_5_3/circle/circle.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_3/aoe/aoe.vpcf", context)
end
function boss_5_3.prototype.GetPlaybackRateOverride(self)
    return 0.5 / self:GetCastPoint()
end
function boss_5_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local iCount = self.Values:count()
    local range = self.Values:range()
    local vDirection = Vector(1, 0, 0)
    local hp = self.Values:inherite_hp_pct()
    local armor = self.Values:inherite_hp_armor()
    local duration = self.Values:duration()
    do
        local i = 0
        while i < iCount do
            local vTempDiretion = Rotation2D(vDirection, 360 / iCount * i)
            local vEndPosition = vStartPosition + vTempDiretion * range
            local hEgg = CreateUnitByName(
                "boss_5_egg",
                vEndPosition,
                true,
                hCaster,
                hCaster,
                hCaster:GetTeamNumber()
            )
            if IsValid(hEgg) then
                hEgg:AddAbility("attribute")
                AttributeKind.HpLimit.BONUS:Set(
                    hEgg,
                    AttributeKind.HpLimit:Get(hCaster) * hp * 0.01,
                    "BASE1"
                )
                AttributeKind.Armor.BONUS:Set(
                    hEgg,
                    AttributeKind.Armor:Get(hCaster) * armor * 0.01,
                    "BASE"
                )
                AttributeKind.HpLimit.BONUS:UpdateClient(hEgg, "BASE1")
                AttributeKind.Armor.BONUS:UpdateClient(hEgg, "BASE")
                hEgg:AddNewModifier(hCaster, self, "modifier_boss_5_3_buff", {duration = duration})
                hEgg:AddNewModifier(hCaster, self, "modifier_kill", {duration = duration})
            end
            i = i + 1
        end
    end
end
boss_5_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_5_3
)
modifier_boss_5_3_buff = __TS__Class()
modifier_boss_5_3_buff.name = "modifier_boss_5_3_buff"
__TS__ClassExtends(modifier_boss_5_3_buff, BaseModifier)
function modifier_boss_5_3_buff.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_3_buff.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    self.radius = self.Values:radius()
    if IsServer() then
    else
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss/boss_5_3/circle/circle.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControl(
            iParticleID,
            1,
            Vector(
                self.radius,
                self:GetDuration(),
                0
            )
        )
        ParticleManager:ReleaseParticleIndex(iParticleID)
        iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            hParent:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            hParent:GetAbsOrigin(),
            false
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
function modifier_boss_5_3_buff.prototype.OnDestroy(self)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        if not IsValid(hCaster) or not IsValid(hAbility) then
            return
        end
        if self:GetRemainingTime() <= 0 then
            local tTargets = FindUnitsInRadiusWithAbility(
                _G,
                hCaster,
                hAbility,
                hParent:GetAbsOrigin(),
                self.radius
            )
            local fDamage = AttributeKind.Atk:Get(hCaster) * self.Values:dmg_factor()
            for _, hTarget in pairs(tTargets) do
                ApplyDamage({
                    ability = hAbility,
                    attacker = hCaster,
                    victim = hTarget,
                    damage = fDamage,
                    damage_type = hAbility:GetAbilityDamageType()
                })
            end
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_3/aoe/aoe.vpcf", PATTACH_CUSTOMORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        0,
                        hParent:GetAbsOrigin()
                    )
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        1,
                        Vector(self.radius, 0, 0)
                    )
                    ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                    hParent:EmitSound("Ability.LightStrikeArray")
                end,
                {weight = 0}
            )
        end
        hParent:AddNoDraw()
    end
end
function modifier_boss_5_3_buff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE}
end
function modifier_boss_5_3_buff.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_IDLE
end
function modifier_boss_5_3_buff.prototype.GetOverrideAnimationRate(self)
    return 0.5
end
modifier_boss_5_3_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_3_buff
)