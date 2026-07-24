--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 7,["16"] = 4,["17"] = 9,["18"] = 10,["19"] = 9,["20"] = 12,["21"] = 13,["22"] = 13,["23"] = 13,["24"] = 14,["25"] = 15,["26"] = 16,["28"] = 13,["29"] = 13,["30"] = 12,["31"] = 3,["32"] = 2,["33"] = 3,["35"] = 21,["36"] = 21,["37"] = 22,["38"] = 24,["39"] = 25,["40"] = 24,["41"] = 27,["42"] = 28,["43"] = 27,["44"] = 30,["45"] = 31,["46"] = 30,["47"] = 33,["48"] = 34,["49"] = 33,["50"] = 36,["51"] = 37,["52"] = 36,["53"] = 39,["54"] = 40,["55"] = 39,["56"] = 42,["57"] = 43,["58"] = 42,["59"] = 45,["60"] = 46,["61"] = 47,["62"] = 48,["63"] = 49,["64"] = 50,["65"] = 50,["66"] = 50,["67"] = 50,["68"] = 50,["69"] = 51,["70"] = 51,["71"] = 51,["72"] = 51,["73"] = 51,["74"] = 51,["75"] = 51,["76"] = 51,["78"] = 45,["79"] = 54,["80"] = 55,["81"] = 54,["82"] = 22,["83"] = 21,["84"] = 22,["86"] = 61,["87"] = 61,["88"] = 62,["89"] = 63,["90"] = 64,["91"] = 63,["92"] = 66,["93"] = 67,["94"] = 66,["95"] = 69,["96"] = 70,["97"] = 71,["98"] = 72,["100"] = 69,["101"] = 75,["102"] = 76,["103"] = 77,["104"] = 78,["105"] = 79,["106"] = 80,["107"] = 81,["110"] = 75,["111"] = 62,["112"] = 61,["113"] = 62,["115"] = 87,["116"] = 87,["117"] = 88,["118"] = 91,["119"] = 92,["120"] = 91,["121"] = 94,["122"] = 95,["123"] = 96,["124"] = 97,["125"] = 98,["126"] = 99,["128"] = 101,["129"] = 102,["130"] = 102,["131"] = 102,["132"] = 102,["133"] = 102,["134"] = 102,["135"] = 102,["136"] = 102,["137"] = 103,["138"] = 104,["139"] = 104,["140"] = 104,["141"] = 104,["142"] = 104,["143"] = 104,["144"] = 104,["145"] = 104,["147"] = 94,["148"] = 107,["149"] = 108,["150"] = 109,["151"] = 110,["152"] = 111,["153"] = 112,["154"] = 113,["157"] = 116,["158"] = 117,["159"] = 117,["160"] = 117,["161"] = 117,["162"] = 117,["163"] = 117,["164"] = 117,["166"] = 107,["167"] = 88,["168"] = 87,["169"] = 88});
boss_5_1 = __TS__Class()
boss_5_1.name = "boss_5_1"
__TS__ClassExtends(boss_5_1, BaseAbility)
function boss_5_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_5/b_5_1/b_5_1.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/b_5_1/screen_a/screen_a.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_1/fire_body/fire_body.vpcf", context)
end
function boss_5_1.prototype.GetIntrinsicModifierName(self)
    return "modifier_boss_5_1_buff"
end
function boss_5_1.prototype.OnOwnerDied(self)
    EachPlayer(
        _G,
        function(____, iPlayerID)
            local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
            if IsValid(hHero) then
                hHero:RemoveModifierByName("modifier_boss_5_1_debuff")
            end
        end
    )
end
boss_5_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_5_1
)
modifier_boss_5_1_buff = __TS__Class()
modifier_boss_5_1_buff.name = "modifier_boss_5_1_buff"
__TS__ClassExtends(modifier_boss_5_1_buff, BaseModifier)
function modifier_boss_5_1_buff.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_1_buff.prototype.IsAura(self)
    return true
end
function modifier_boss_5_1_buff.prototype.GetModifierAura(self)
    return "modifier_boss_4_1_aura"
end
function modifier_boss_5_1_buff.prototype.GetAuraRadius(self)
    return self.distance
end
function modifier_boss_5_1_buff.prototype.GetAuraSearchTeam(self)
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_boss_5_1_buff.prototype.GetAuraSearchType(self)
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_boss_5_1_buff.prototype.GetAuraSearchFlags(self)
    return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_boss_5_1_buff.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    self.distance = self.Values:distance()
    if IsClient() then
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/b_5_1/b_5_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControl(
            iParticleID,
            1,
            Vector(self.distance, 0, 0)
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
function modifier_boss_5_1_buff.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true}
end
modifier_boss_5_1_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_1_buff
)
modifier_boss_5_1_aura = __TS__Class()
modifier_boss_5_1_aura.name = "modifier_boss_5_1_aura"
__TS__ClassExtends(modifier_boss_5_1_aura, BaseModifier)
function modifier_boss_5_1_aura.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_1_aura.prototype.IsDebuff(self)
    return false
end
function modifier_boss_5_1_aura.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        hParent:RemoveModifierByName("modifier_boss_5_1_debuff")
    end
end
function modifier_boss_5_1_aura.prototype.OnDestroy(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if IsServer() then
        if IsValid(hCaster) and hCaster:IsAlive() and IsValid(hAbility) then
            hParent:AddNewModifier(hCaster, hAbility, "modifier_boss_5_1_debuff", {})
        end
    end
end
modifier_boss_5_1_aura = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_1_aura
)
modifier_boss_5_1_debuff = __TS__Class()
modifier_boss_5_1_debuff.name = "modifier_boss_5_1_debuff"
__TS__ClassExtends(modifier_boss_5_1_debuff, BaseModifier)
function modifier_boss_5_1_debuff.prototype.RemoveOnDeath(self)
    return false
end
function modifier_boss_5_1_debuff.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    self.interval = self.Values:interval()
    self.dmg_factor = self.Values:dmg_factor()
    if IsServer() then
        self:StartIntervalThink(self.interval)
    else
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/b_5_1/screen_a/screen_a.vpcf", PATTACH_CUSTOMORIGIN, nil)
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle("particles/boss/boss_5/boss_5_1/fire_body/fire_body.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
function modifier_boss_5_1_debuff.prototype.OnIntervalThink(self)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hAbility = self:GetAbility()
        local hParent = self:GetParent()
        if not IsValid(hCaster) or not hCaster:IsAlive() then
            self:Destroy()
            return
        end
        local fDamage = AttributeKind.Atk:Get(hCaster) * self.dmg_factor
        ApplyDamage({
            ability = hAbility,
            attacker = hCaster,
            victim = hParent,
            damage = fDamage,
            damage_type = hAbility:GetAbilityDamageType()
        })
    end
end
modifier_boss_5_1_debuff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_1_debuff
)