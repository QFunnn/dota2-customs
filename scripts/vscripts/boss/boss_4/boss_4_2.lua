--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_4\\boss_4_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 4,["16"] = 8,["17"] = 9,["18"] = 10,["19"] = 11,["20"] = 8,["21"] = 2,["22"] = 1,["23"] = 2,["25"] = 14,["26"] = 14,["27"] = 15,["28"] = 20,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 25,["34"] = 26,["36"] = 20,["37"] = 29,["38"] = 30,["39"] = 30,["40"] = 30,["41"] = 30,["42"] = 30,["43"] = 29,["44"] = 36,["45"] = 37,["46"] = 38,["47"] = 39,["48"] = 40,["49"] = 41,["50"] = 42,["51"] = 42,["52"] = 43,["53"] = 44,["54"] = 44,["55"] = 44,["56"] = 44,["57"] = 44,["58"] = 45,["59"] = 45,["60"] = 45,["61"] = 45,["62"] = 45,["63"] = 46,["64"] = 47,["65"] = 47,["66"] = 47,["67"] = 47,["68"] = 47,["69"] = 42,["70"] = 42,["71"] = 42,["72"] = 51,["73"] = 52,["74"] = 53,["75"] = 53,["76"] = 53,["77"] = 53,["78"] = 53,["79"] = 53,["80"] = 53,["81"] = 53,["82"] = 53,["83"] = 53,["84"] = 53,["85"] = 64,["86"] = 65,["87"] = 65,["88"] = 65,["89"] = 65,["90"] = 65,["91"] = 65,["92"] = 65,["95"] = 36,["96"] = 15,["97"] = 14,["98"] = 15});
boss_4_2 = __TS__Class()
boss_4_2.name = "boss_4_2"
__TS__ClassExtends(boss_4_2, BaseAbility)
function boss_4_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/linear.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf", context)
end
function boss_4_2.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local duration = self.Values:duration()
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_4_2_buff", {duration = duration})
end
boss_4_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_4_2
)
modifier_boss_4_2_buff = __TS__Class()
modifier_boss_4_2_buff.name = "modifier_boss_4_2_buff"
__TS__ClassExtends(modifier_boss_4_2_buff, DiyModifier)
function modifier_boss_4_2_buff.prototype.OnCreated(self, params)
    if IsServer() then
        local hParent = self:GetParent()
        self.vStartPos = hParent:GetAbsOrigin()
        self.distance = self.Values:distance()
        self.radius = self.Values:radius()
        self.dmg_factor = self.Values:dmg_factor()
    end
end
function modifier_boss_4_2_buff.prototype.DDeclareFunctions(self)
    return {
        [MODIFIER_EVENT_ON_UNIT_MOVED] = {source = self:GetParent()},
        [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_RUN,
        [MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS] = "heavy_steps"
    }
end
function modifier_boss_4_2_buff.prototype.OnUnitMoved(self, event)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    local vPos = event.new_pos
    local fDistance = (vPos - self.vStartPos):Length2D()
    if IsValid(hAbility) and fDistance >= self.distance then
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf", PATTACH_CUSTOMORIGIN, nil)
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
                EmitSoundOnLocationWithCaster(
                    hParent:GetAbsOrigin(),
                    "Hero_PrimalBeast.Trample",
                    hParent
                )
            end,
            {weight = 0}
        )
        self.vStartPos = vPos
        local fDamage = AttributeKind.Atk:Get(hParent) * self.dmg_factor
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
                attacker = hParent,
                victim = hTarget,
                damage = fDamage,
                damage_type = DAMAGE_TYPE_PHYSICAL
            })
        end
    end
end
modifier_boss_4_2_buff = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_4_2_buff
)