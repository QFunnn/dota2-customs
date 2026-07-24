--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_8\\boss_8_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["13"] = 3,["14"] = 5,["15"] = 2,["16"] = 6,["17"] = 7,["18"] = 8,["19"] = 9,["20"] = 6,["21"] = 11,["22"] = 12,["23"] = 11,["24"] = 14,["25"] = 15,["26"] = 16,["27"] = 17,["28"] = 18,["29"] = 19,["30"] = 20,["31"] = 21,["32"] = 22,["33"] = 22,["35"] = 23,["36"] = 23,["37"] = 24,["38"] = 25,["39"] = 26,["40"] = 27,["41"] = 28,["42"] = 29,["43"] = 29,["44"] = 29,["45"] = 29,["46"] = 29,["47"] = 29,["48"] = 29,["49"] = 29,["50"] = 29,["51"] = 30,["52"] = 30,["53"] = 23,["56"] = 22,["57"] = 22,["58"] = 22,["59"] = 35,["60"] = 35,["61"] = 36,["62"] = 37,["63"] = 37,["64"] = 37,["65"] = 37,["66"] = 37,["67"] = 37,["68"] = 37,["69"] = 37,["70"] = 37,["71"] = 38,["72"] = 38,["73"] = 38,["74"] = 38,["75"] = 38,["76"] = 38,["77"] = 38,["78"] = 38,["79"] = 38,["80"] = 39,["81"] = 39,["82"] = 39,["83"] = 39,["84"] = 39,["85"] = 39,["86"] = 39,["87"] = 39,["88"] = 39,["89"] = 40,["90"] = 35,["91"] = 35,["92"] = 35,["93"] = 44,["94"] = 14,["95"] = 46,["96"] = 47,["97"] = 48,["98"] = 48,["99"] = 49,["100"] = 50,["101"] = 48,["102"] = 48,["103"] = 48,["104"] = 54,["105"] = 54,["106"] = 55,["107"] = 56,["109"] = 54,["110"] = 54,["111"] = 54,["112"] = 46,["113"] = 62,["114"] = 63,["115"] = 64,["116"] = 65,["117"] = 66,["118"] = 67,["119"] = 68,["120"] = 69,["121"] = 70,["123"] = 71,["124"] = 71,["125"] = 72,["126"] = 73,["127"] = 74,["128"] = 75,["129"] = 76,["130"] = 76,["131"] = 76,["132"] = 76,["133"] = 76,["134"] = 77,["135"] = 78,["136"] = 78,["137"] = 78,["138"] = 78,["139"] = 78,["140"] = 78,["141"] = 78,["142"] = 78,["143"] = 78,["144"] = 78,["145"] = 78,["146"] = 78,["147"] = 90,["148"] = 90,["149"] = 90,["150"] = 78,["151"] = 78,["152"] = 78,["153"] = 98,["154"] = 99,["155"] = 100,["156"] = 101,["157"] = 71,["160"] = 62,["161"] = 104,["162"] = 105,["165"] = 108,["166"] = 109,["167"] = 110,["168"] = 111,["169"] = 112,["170"] = 113,["171"] = 114,["172"] = 115,["173"] = 116,["174"] = 117,["175"] = 118,["176"] = 119,["177"] = 120,["178"] = 121,["179"] = 122,["182"] = 125,["183"] = 126,["184"] = 127,["186"] = 129,["188"] = 104,["189"] = 132,["190"] = 133,["193"] = 136,["194"] = 137,["195"] = 138,["196"] = 139,["197"] = 139,["198"] = 139,["199"] = 139,["200"] = 139,["201"] = 139,["202"] = 139,["204"] = 147,["205"] = 148,["208"] = 132,["209"] = 152,["210"] = 153,["211"] = 152,["212"] = 3,["213"] = 2,["214"] = 3,["216"] = 156,["217"] = 156,["218"] = 157,["219"] = 158,["220"] = 159,["221"] = 158,["222"] = 161,["223"] = 162,["224"] = 161,["225"] = 166,["226"] = 167,["227"] = 166,["228"] = 157,["229"] = 156,["230"] = 157});
boss_8_3 = __TS__Class()
boss_8_3.name = "boss_8_3"
__TS__ClassExtends(boss_8_3, BossAbility)
function boss_8_3.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tParticleID = {}
end
function boss_8_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_3/warning/linear.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_3/wings/arcana_wings.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_3/meteor/meteor.vpcf", context)
end
function boss_8_3.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_6
end
function boss_8_3.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local distance = self.Values:distance()
    local iCount = self.Values:count()
    local fCastPoint = self:GetCastPoint()
    local vDirection = Vector(1, 0, 0)
    self.tParticleID = {}
    ParticleManager_s2c:ToClient(
        function()
            do
                local i = 0
                while i < iCount do
                    local vTempDiretion = Rotation2D(vDirection, 360 / iCount * i)
                    local vEndPosition = vStartPosition + vTempDiretion * 2000
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_3/warning/linear.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(iParticleID, 0, vStartPosition)
                    ParticleManager_s2c:SetParticleControl(iParticleID, 1, vEndPosition)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        2,
                        Vector(
                            self.Values:width(),
                            fCastPoint,
                            1 / fCastPoint
                        )
                    )
                    local ____self_tParticleID_0 = self.tParticleID
                    ____self_tParticleID_0[#____self_tParticleID_0 + 1] = iParticleID
                    i = i + 1
                end
            end
        end,
        {weight = 0}
    )
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_3/wings/arcana_wings.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
            ParticleManager_s2c:SetParticleControlEnt(
                self.iParticleID,
                1,
                hCaster,
                PATTACH_POINT_FOLLOW,
                "attach_hitloc",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:SetParticleControlEnt(
                self.iParticleID,
                5,
                hCaster,
                PATTACH_POINT_FOLLOW,
                "attach_attack1",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:SetParticleControlEnt(
                self.iParticleID,
                6,
                hCaster,
                PATTACH_POINT_FOLLOW,
                "attach_attack2",
                hCaster:GetAbsOrigin(),
                true
            )
            ParticleManager_s2c:EmitSoundOn("Hero_Nevermore.RequiemOfSoulsCast", hCaster)
        end,
        {weight = 0}
    )
    return true
end
function boss_8_3.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            ParticleManager_s2c:StopSoundOn("Hero_Nevermore.RequiemOfSoulsCast", hCaster)
        end,
        {weight = 0}
    )
    ParticleManager_s2c:ToClient(
        function()
            for _, iParticleID in pairs(self.tParticleID) do
                ParticleManager_s2c:DestroyParticle(iParticleID, true)
            end
        end,
        {weight = 0}
    )
end
function boss_8_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local iCount = self.Values:count()
    local speed = self.Values:speed()
    local distance = self.Values:distance()
    local width = self.Values:width()
    local vDirection = Vector(1, 0, 0)
    local flDamage = AttributeKind.Atk:Get(hCaster) * self.Values:dmg_factor()
    do
        local i = 0
        while i < iCount do
            local vTempDiretion = Rotation2D(vDirection, 360 / iCount * i)
            local tHashtable = CreateHashtable(_G)
            tHashtable.iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_3/meteor/meteor.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager:SetParticleControl(tHashtable.iParticleID, 0, vStartPosition)
            ParticleManager:SetParticleControl(
                tHashtable.iParticleID,
                1,
                vTempDiretion:Normalized() * speed
            )
            vTempDiretion.z = 0
            local tInfo = {
                Ability = self,
                Source = hCaster,
                EffectName = "",
                vSpawnOrigin = vStartPosition,
                vVelocity = vTempDiretion:Normalized() * speed,
                fDistance = distance,
                fStartRadius = width,
                fEndRadius = width,
                iUnitTargetTeam = self:GetAbilityTargetTeam(),
                iUnitTargetType = self:GetAbilityTargetType(),
                iUnitTargetFlags = self:GetAbilityTargetFlags(),
                ExtraData = {
                    hashtable_index = GetHashtableIndex(_G, tHashtable),
                    flDamage = flDamage
                },
                ParticleConfig = {weight = 0}
            }
            tHashtable.iProjectileID = ProjectileManager:CreateLinearProjectile(tInfo)
            tHashtable.vSpawnOrigin = tInfo.vSpawnOrigin
            tHashtable.fDistance = tInfo.fDistance
            tHashtable.speed = speed
            i = i + 1
        end
    end
end
function boss_8_3.prototype.OnProjectileThink_ExtraData(self, location, extraData)
    if extraData.hashtable_index == nil then
        return
    end
    local hCaster = self:GetCaster()
    local tHashtable = GetHashtableByIndex(_G, extraData.hashtable_index)
    if not IsValidPosition(_G, location) then
        local fUseDistance = (location - tHashtable.vSpawnOrigin):Length2D()
        tHashtable.fDistance = tHashtable.fDistance - fUseDistance
        local fRadius = ProjectileManager:GetLinearProjectileRadius(tHashtable.iProjectileID)
        local vDirection = (location - tHashtable.vSpawnOrigin):Normalized()
        local vReflection = GetReflection(_G, location, vDirection, fRadius) * tHashtable.speed
        tHashtable.vSpawnOrigin = location
        ProjectileManager:UpdateLinearProjectileDirection(tHashtable.iProjectileID, vReflection, tHashtable.fDistance)
        if tHashtable.iParticleID ~= nil then
            ParticleManager:DestroyParticle(tHashtable.iParticleID, true)
            tHashtable.iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_3/meteor/meteor.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager:SetParticleControl(tHashtable.iParticleID, 0, location)
            ParticleManager:SetParticleControl(tHashtable.iParticleID, 1, vReflection)
        end
    end
    if not IsValid(hCaster) or not hCaster:IsAlive() then
        if tHashtable.iParticleID ~= nil then
            ParticleManager:DestroyParticle(tHashtable.iParticleID, true)
        end
        ProjectileManager:DestroyLinearProjectile(tHashtable.iProjectileID)
    end
end
function boss_8_3.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if extraData.hashtable_index == nil then
        return
    end
    local hCaster = self:GetCaster()
    local tHashtable = GetHashtableByIndex(_G, extraData.hashtable_index)
    if IsValid(target) then
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = extraData.flDamage,
            damage_type = self:GetAbilityDamageType()
        })
    else
        if tHashtable.iParticleID ~= nil then
            ParticleManager:DestroyParticle(tHashtable.iParticleID, false)
        end
    end
end
function boss_8_3.prototype.GetIntrinsicModifierName(self)
    return "modifier_boss_8_3"
end
boss_8_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_8_3
)
modifier_boss_8_3 = __TS__Class()
modifier_boss_8_3.name = "modifier_boss_8_3"
__TS__ClassExtends(modifier_boss_8_3, BaseModifier)
function modifier_boss_8_3.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_3.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS}
end
function modifier_boss_8_3.prototype.GetActivityTranslationModifiers(self)
    return "arcana"
end
modifier_boss_8_3 = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_3
)