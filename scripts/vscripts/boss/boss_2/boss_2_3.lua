--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_2\\boss_2_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 4,["14"] = 5,["15"] = 3,["16"] = 7,["17"] = 8,["18"] = 7,["19"] = 10,["20"] = 11,["21"] = 12,["22"] = 12,["23"] = 12,["24"] = 12,["25"] = 12,["26"] = 12,["27"] = 10,["28"] = 2,["29"] = 1,["30"] = 2,["32"] = 15,["33"] = 15,["34"] = 16,["35"] = 18,["36"] = 19,["37"] = 20,["38"] = 21,["39"] = 22,["41"] = 18,["42"] = 25,["43"] = 26,["44"] = 27,["45"] = 28,["46"] = 28,["47"] = 28,["48"] = 28,["49"] = 28,["50"] = 28,["51"] = 28,["52"] = 28,["53"] = 28,["54"] = 28,["55"] = 28,["56"] = 39,["57"] = 40,["58"] = 41,["59"] = 42,["60"] = 43,["61"] = 43,["62"] = 44,["63"] = 45,["64"] = 46,["65"] = 46,["66"] = 46,["67"] = 46,["68"] = 46,["69"] = 43,["70"] = 43,["71"] = 43,["72"] = 50,["73"] = 50,["74"] = 50,["75"] = 51,["76"] = 52,["77"] = 52,["78"] = 53,["79"] = 52,["80"] = 52,["81"] = 52,["84"] = 59,["85"] = 59,["86"] = 59,["87"] = 59,["88"] = 59,["89"] = 59,["90"] = 59,["91"] = 59,["92"] = 59,["93"] = 60,["94"] = 50,["95"] = 50,["98"] = 25,["99"] = 16,["100"] = 15,["101"] = 16,["103"] = 66,["104"] = 66,["105"] = 67,["106"] = 70,["107"] = 71,["108"] = 72,["109"] = 73,["110"] = 74,["111"] = 75,["112"] = 76,["113"] = 77,["114"] = 77,["115"] = 78,["116"] = 79,["117"] = 79,["118"] = 79,["119"] = 79,["120"] = 79,["121"] = 80,["122"] = 81,["123"] = 81,["124"] = 81,["125"] = 81,["126"] = 81,["127"] = 82,["128"] = 82,["129"] = 82,["130"] = 82,["131"] = 82,["132"] = 82,["133"] = 82,["134"] = 82,["135"] = 77,["136"] = 77,["137"] = 77,["138"] = 86,["140"] = 70,["141"] = 89,["142"] = 90,["143"] = 91,["144"] = 92,["145"] = 93,["146"] = 94,["147"] = 95,["150"] = 98,["151"] = 98,["152"] = 98,["153"] = 98,["154"] = 98,["155"] = 98,["156"] = 98,["157"] = 98,["158"] = 98,["159"] = 98,["160"] = 98,["161"] = 109,["162"] = 110,["163"] = 110,["164"] = 110,["165"] = 110,["166"] = 110,["167"] = 110,["168"] = 110,["170"] = 89,["171"] = 67,["172"] = 66,["173"] = 67});
boss_2_3 = __TS__Class()
boss_2_3.name = "boss_2_3"
__TS__ClassExtends(boss_2_3, BaseAbility)
function boss_2_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/circular.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/tiny/tiny_prestige/tiny_prestige_avalanche.vpcf", context)
end
function boss_2_3.prototype.GetCastPoint(self)
    return 0.1
end
function boss_2_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    hCaster:AddNewModifier(
        hCaster,
        self,
        "modifier_boss_2_3_buff",
        {duration = self.Values:duration()}
    )
end
boss_2_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_2_3
)
modifier_boss_2_3_buff = __TS__Class()
modifier_boss_2_3_buff.name = "modifier_boss_2_3_buff"
__TS__ClassExtends(modifier_boss_2_3_buff, BaseModifier)
function modifier_boss_2_3_buff.prototype.OnCreated(self, params)
    self.radius = self.Values:radius()
    if IsServer() then
        self:OnIntervalThink()
        self:StartIntervalThink(4)
    end
end
function modifier_boss_2_3_buff.prototype.OnIntervalThink(self)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    local tTargets = FindUnitsInRadius(
        hParent:GetTeamNumber(),
        hParent:GetAbsOrigin(),
        nil,
        -1,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST,
        false
    )
    if self:GetRemainingTime() > 1 then
        for _, hTarget in ipairs(tTargets) do
            local vPosition = hTarget:GetAbsOrigin()
            local iParticleID
            ParticleManager_s2c:ToClient(
                function()
                    iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        2,
                        Vector(self.radius, 1, 1 / 1)
                    )
                end,
                {weight = 0}
            )
            self:GameTimer(
                1,
                function()
                    if not IsValid(self) or not IsValid(hParent) or not hParent:IsAlive() then
                        ParticleManager_s2c:ToClient(
                            function()
                                ParticleManager_s2c:DestroyParticle(iParticleID, true)
                            end,
                            {weight = 0}
                        )
                        return
                    end
                    CreateModifierThinker(
                        hParent,
                        hAbility,
                        "modifier_boss_2_3_thinker",
                        {duration = 1.4},
                        vPosition,
                        hParent:GetTeamNumber(),
                        false
                    )
                    EmitSoundOnLocationWithCaster(vPosition, "Ability.Avalanche", hParent)
                end
            )
        end
    end
end
modifier_boss_2_3_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_2_3_buff
)
modifier_boss_2_3_thinker = __TS__Class()
modifier_boss_2_3_thinker.name = "modifier_boss_2_3_thinker"
__TS__ClassExtends(modifier_boss_2_3_thinker, BaseModifier)
function modifier_boss_2_3_thinker.prototype.OnCreated(self, params)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        self.radius = self.Values:radius()
        self.fDamage = AttributeKind.Atk:Get(hCaster) * self.Values:dmg_factor()
        local vDirection = (hParent:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized()
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/econ/items/tiny/tiny_prestige/tiny_prestige_avalanche.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    0,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControlForward(iParticleID, 0, vDirection)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(self.radius, self.radius, self.radius)
                )
                self:AddParticle_s2c(
                    iParticleID,
                    false,
                    false,
                    -1,
                    false,
                    false
                )
            end,
            {weight = 0}
        )
        self:StartIntervalThink(self.Values:dmg_interval())
    end
end
function modifier_boss_2_3_thinker.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if not IsValid(hCaster) or not hCaster:IsAlive() then
        self:StartIntervalThink(-1)
        self:Destroy()
        return
    end
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
            attacker = hCaster,
            victim = hTarget,
            damage = self.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
    end
end
modifier_boss_2_3_thinker = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_2_3_thinker
)