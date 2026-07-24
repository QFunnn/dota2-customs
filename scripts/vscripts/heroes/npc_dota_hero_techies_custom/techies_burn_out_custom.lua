--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_burn_out_custom", "heroes/npc_dota_hero_techies_custom/techies_burn_out_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_burn_out_custom_thinker", "heroes/npc_dota_hero_techies_custom/techies_burn_out_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_burn_out_custom_debuff", "heroes/npc_dota_hero_techies_custom/techies_burn_out_custom", LUA_MODIFIER_MOTION_NONE)

techies_burn_out_custom = class({})

function techies_burn_out_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly_debuff.vpcf", context)
end

function techies_burn_out_custom:GetHealthCost()
    return self:GetCaster():GetHealth() / 100 * self:GetSpecialValueFor("health_cost")
end

function techies_burn_out_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local modifier_techies_burn_out_custom = self:GetCaster():FindModifierByName("modifier_techies_burn_out_custom")
    if modifier_techies_burn_out_custom then
        modifier_techies_burn_out_custom:Destroy()
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_techies_burn_out_custom", {duration = duration})
end

modifier_techies_burn_out_custom = class({})
function modifier_techies_burn_out_custom:IsPurgable() return false end
function modifier_techies_burn_out_custom:IsPurgeException() return false end

function modifier_techies_burn_out_custom:OnCreated()
    self.bonus_ms = self:GetAbility():GetSpecialValueFor("bonus_ms")
    self.width = self:GetAbility():GetSpecialValueFor("width")
    if not IsServer() then return end
    self.damage_spots = {}
    self.last_point = self:GetParent():GetAbsOrigin()
    self.distance = self:GetAbility():GetSpecialValueFor("width")
    local nfx = ParticleManager:CreateParticle("particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly.vpcf", PATTACH_POINT, self:GetParent())
	ParticleManager:SetParticleControlEnt(nfx, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(nfx, 3, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(nfx, 11, Vector(1, 0, 0))
    self:AddParticle(nfx, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_techies_burn_out_custom:OnIntervalThink()
    if not IsServer() then return end
    GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), self.width, true)
    local distance = (self:GetParent():GetAbsOrigin() - self.last_point):Length2D()
    self.last_point = self:GetParent():GetAbsOrigin()
    self.distance = self.distance + distance
    if self.distance >= self.width then
        self.distance = 0
        CreateModifierThinker(self:GetParent(), self:GetAbility(), "modifier_techies_burn_out_custom_thinker", {duration = self:GetRemainingTime()}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    end
end

function modifier_techies_burn_out_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_techies_burn_out_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus_ms
end

modifier_techies_burn_out_custom_thinker = class({})
function modifier_techies_burn_out_custom_thinker:IsHidden() return true end
function modifier_techies_burn_out_custom_thinker:IsPurgable() return false end
function modifier_techies_burn_out_custom_thinker:IsAura() return true end
function modifier_techies_burn_out_custom_thinker:GetModifierAura() return "modifier_techies_burn_out_custom_debuff" end
function modifier_techies_burn_out_custom_thinker:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("width") end
function modifier_techies_burn_out_custom_thinker:GetAuraDuration() return 2 end
function modifier_techies_burn_out_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_techies_burn_out_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_techies_burn_out_custom_thinker:GetAuraSearchFlags() return 0 end

modifier_techies_burn_out_custom_debuff = class({})
function modifier_techies_burn_out_custom_debuff:OnCreated()
    if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetParent():IsHero() then
        local particle = ParticleManager:CreateParticle("particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        self:AddParticle(particle, false, false, -1, false, false)
    end
    self:StartIntervalThink(0.5)
    self:OnIntervalThink()
end
function modifier_techies_burn_out_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = (self:GetCaster():GetMaxHealth() / 100 * self.damage) * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end