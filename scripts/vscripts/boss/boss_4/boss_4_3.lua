--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_4\\boss_4_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 4,["15"] = 7,["16"] = 8,["17"] = 7,["18"] = 10,["19"] = 11,["20"] = 10,["21"] = 13,["22"] = 14,["23"] = 15,["24"] = 16,["25"] = 17,["26"] = 18,["27"] = 19,["28"] = 20,["29"] = 21,["31"] = 22,["32"] = 22,["33"] = 23,["34"] = 24,["35"] = 24,["36"] = 24,["37"] = 24,["38"] = 24,["39"] = 24,["40"] = 24,["41"] = 24,["42"] = 24,["43"] = 22,["46"] = 26,["47"] = 26,["48"] = 27,["49"] = 26,["50"] = 26,["51"] = 26,["52"] = 13,["53"] = 32,["54"] = 33,["55"] = 34,["56"] = 34,["57"] = 34,["58"] = 34,["59"] = 34,["60"] = 34,["61"] = 34,["62"] = 34,["63"] = 34,["64"] = 34,["65"] = 34,["66"] = 45,["67"] = 45,["68"] = 45,["69"] = 45,["70"] = 34,["71"] = 34,["72"] = 32,["73"] = 52,["74"] = 53,["75"] = 54,["76"] = 55,["77"] = 55,["78"] = 55,["79"] = 55,["80"] = 55,["81"] = 55,["82"] = 55,["84"] = 63,["87"] = 64,["88"] = 65,["89"] = 66,["90"] = 67,["92"] = 68,["93"] = 68,["94"] = 69,["95"] = 70,["96"] = 70,["97"] = 70,["98"] = 70,["99"] = 70,["100"] = 70,["101"] = 70,["102"] = 70,["103"] = 70,["104"] = 68,["108"] = 52,["109"] = 3,["110"] = 2,["111"] = 3});
boss_4_3 = __TS__Class()
boss_4_3.name = "boss_4_3"
__TS__ClassExtends(boss_4_3, BaseAbility)
function boss_4_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_tectonic_shift_projectile.vpcf", context)
end
function boss_4_3.prototype.GetCastPoint(self)
    return 0.5
end
function boss_4_3.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_3
end
function boss_4_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local iCount = self.Values:count()
    local vStartPosition = hCaster:GetAbsOrigin()
    local vDirection = hCaster:GetForwardVector()
    local distance = self.Values:distance()
    local width = self.Values:width()
    local speed = self.Values:speed()
    local fDamage = AttributeKind.Atk:Get(hCaster) * self.Values:dmg_factor()
    do
        local i = 0
        while i < iCount do
            local vTempDiretion = Rotation2D(vDirection, 360 / iCount * i)
            self:_OnLine(
                vStartPosition,
                vTempDiretion,
                distance,
                width,
                speed,
                fDamage,
                1
            )
            i = i + 1
        end
    end
    ParticleManager_s2c:ToClient(
        function()
            EmitSoundOnLocationWithCaster(vStartPosition, "sounds/weapons/hero/primal_beast/roar_layer.vsnd", hCaster)
        end,
        {weight = 0}
    )
end
function boss_4_3.prototype._OnLine(self, vStartPosition, vDirection, distance, width, speed, fDamage, count)
    local hCaster = self:GetCaster()
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        Source = hCaster,
        EffectName = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_tectonic_shift_projectile.vpcf",
        vSpawnOrigin = vStartPosition,
        fDistance = distance,
        fStartRadius = width,
        fEndRadius = width,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = vDirection * speed,
        ExtraData = {
            fDamage = fDamage,
            Count = count,
            vDirection = VectorToString(_G, vDirection)
        }
    })
end
function boss_4_3.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = extraData.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
    else
        if extraData.Count > 1 then
            return
        end
        local distance = self.Values:distance()
        local width = self.Values:width()
        local speed = self.Values:speed()
        local vDirection = StringToVector(_G, extraData.vDirection)
        do
            local i = 0
            while i < 2 do
                local vTempDiretion = Rotation2D(vDirection, 30 * (i % 2 == 0 and 1 or -1))
                self:_OnLine(
                    location,
                    vTempDiretion,
                    distance,
                    width,
                    speed,
                    extraData.fDamage,
                    2
                )
                i = i + 1
            end
        end
    end
end
boss_4_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_4_3
)