--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_ice_spire_custom", "heroes/npc_dota_hero_lich_custom/lich_ice_spire_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_ice_spire_custom_aura", "heroes/npc_dota_hero_lich_custom/lich_ice_spire_custom", LUA_MODIFIER_MOTION_NONE)

lich_ice_spire_custom = class({})

function lich_ice_spire_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
    local pilar = CreateUnitByName("npc_dota_lich_ice_spire", point, true, nil, nil, self:GetCaster():GetTeamNumber())
    ResolveNPCPositions( pilar:GetAbsOrigin(), 128 )
    EmitSoundOnLocationWithCaster(point, "Hero_Lich.IceSpire", self:GetCaster())
    local health = self:GetSpecialValueFor("max_hero_attacks")
    pilar:AddNewModifier(self:GetCaster(), self, "modifier_lich_ice_spire_custom", {duration = duration})
    pilar:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})
end

modifier_lich_ice_spire_custom = class({})
function modifier_lich_ice_spire_custom:IsHidden() return true end
function modifier_lich_ice_spire_custom:IsPurgable() return false end
function modifier_lich_ice_spire_custom:OnCreated()
    if not IsServer() then return end
    self.health = self:GetParent():GetMaxHealth()
    self.damage = self.health / self:GetAbility():GetSpecialValueFor("max_hero_attacks")
    self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_spire.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 4, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 5, Vector(self.aura_radius,self.aura_radius,self.aura_radius))  
    self:AddParticle(particle, false, false, -1, true, false)
end

function modifier_lich_ice_spire_custom:HealPilar()
    if not IsServer() then return end
    self.health = math.min(self:GetParent():GetMaxHealth(), self.health + 1)
    self:GetParent():SetHealth(self.health)
end

function modifier_lich_ice_spire_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
         
        MODIFIER_PROPERTY_HEALTHBAR_PIPS,
        MODIFIER_EVENT_ON_DEATH
    } 
end

function modifier_lich_ice_spire_custom:OnDeath(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end

    local lich_frost_nova_custom = self:GetCaster():FindAbilityByName("lich_frost_nova_custom")
    if lich_frost_nova_custom and lich_frost_nova_custom:GetLevel() > 0 then
        lich_frost_nova_custom:CastFrostNova(nil, self:GetParent():GetAbsOrigin())
    end

    self:Destroy()
end

function modifier_lich_ice_spire_custom:GetModifierHealthBarPips(data)
    return 2
end 

function modifier_lich_ice_spire_custom:GetAbsoluteNoDamageMagical() return 1 end
function modifier_lich_ice_spire_custom:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_lich_ice_spire_custom:GetAbsoluteNoDamagePure() return 1 end

function modifier_lich_ice_spire_custom:OnAttackLanded( params )
    if not IsServer() then return end
    if self:GetParent() ~= params.target then return end
    local damage = self.damage
    if not params.attacker:IsHero() then
        damage = 1
    end
    self.health = self.health - damage
    if self.health <= 0 then 
        self:GetParent():Kill(self:GetAbility(), params.attacker)
    else
        self:GetParent():SetHealth(self.health)
    end
end

function modifier_lich_ice_spire_custom:IsAura()
    return true
end

function modifier_lich_ice_spire_custom:GetModifierAura()
    return "modifier_lich_ice_spire_custom_aura"
end

function modifier_lich_ice_spire_custom:GetAuraRadius()
    return self.aura_radius
end

function modifier_lich_ice_spire_custom:GetAuraDuration()
    return self:GetAbility():GetSpecialValueFor("slow_duration")
end

function modifier_lich_ice_spire_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_lich_ice_spire_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_lich_ice_spire_custom_aura = class({})

function modifier_lich_ice_spire_custom_aura:IsPurgable()
    return false
end

function modifier_lich_ice_spire_custom_aura:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_spire_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetAuraOwner():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_lich_ice_spire_custom_aura:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
    return funcs
end

function modifier_lich_ice_spire_custom_aura:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_movespeed")
end