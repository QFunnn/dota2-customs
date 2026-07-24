--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_weaver_snare_thinker", "heroes/npc_dota_hero_weaver_custom/weaver_weaver_snare", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_weaver_snare_cooldown", "heroes/npc_dota_hero_weaver_custom/weaver_weaver_snare", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_weaver_snare_rooted", "heroes/npc_dota_hero_weaver_custom/weaver_weaver_snare", LUA_MODIFIER_MOTION_NONE)

weaver_weaver_snare = class({})

weaver_weaver_snare.modifier_weaver_6 = {200,400}

function weaver_weaver_snare:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function weaver_weaver_snare:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/weaver_snare_custom.vpcf", context )
end

function weaver_weaver_snare:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:GetCaster():EmitSound("Hero_Broodmother.SpinWebCast")
    CreateModifierThinker(self:GetCaster(), self, "modifier_weaver_weaver_snare_thinker", {duration = self:GetSpecialValueFor("duration")}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_weaver_weaver_snare_thinker = class({})

function modifier_weaver_weaver_snare_thinker:OnCreated()
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local particle = ParticleManager:CreateParticle("particles/weaver_snare_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, Vector(radius/2,radius/2,radius/2))
    self:StartIntervalThink(0.1)
end

function modifier_weaver_weaver_snare_thinker:OnIntervalThink()
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if not unit:HasModifier("modifier_weaver_weaver_snare_cooldown") then
            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_weaver_weaver_snare_cooldown", {duration = self:GetAbility():GetSpecialValueFor("interval_cooldown")})
            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_weaver_weaver_snare_rooted", {duration = self:GetAbility():GetSpecialValueFor("root_duration") * (1-unit:GetStatusResistance())})
            if self:GetCaster():HasModifier("modifier_weaver_6") then
                ApplyDamage({ victim = unit, damage = self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_weaver_6[self:GetCaster():GetTalentLevel("modifier_weaver_6")], damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self:GetAbility()})
            end
        end
    end
end

modifier_weaver_weaver_snare_rooted = class({})
function modifier_weaver_weaver_snare_rooted:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true,
    }
end
function modifier_weaver_weaver_snare_rooted:GetEffectName()
    return "particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf"
end
function modifier_weaver_weaver_snare_rooted:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

modifier_weaver_weaver_snare_cooldown = class({})
function modifier_weaver_weaver_snare_cooldown:IsHidden() return true end
function modifier_weaver_weaver_snare_cooldown:IsPurgable() return false end