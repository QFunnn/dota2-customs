--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_cloak_of_flames_custom_aura", "abilities/items/neutral/item_cloak_of_flames_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_cloak_of_flames_custom_tracker", "abilities/items/neutral/item_cloak_of_flames_custom", LUA_MODIFIER_MOTION_NONE)

item_cloak_of_flames_custom = class({})

function item_cloak_of_flames_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items/pyrrhic_cloak_custom.vpcf", context )
PrecacheResource( "particle", "particles/items/shield_overhead.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_fire_immolation_child.vpcf", context )

end

function item_cloak_of_flames_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_cloak_of_flames_custom_tracker"
end


modifier_item_cloak_of_flames_custom_tracker = class(mod_hidden)
function modifier_item_cloak_of_flames_custom_tracker:IsHidden() return self.parent:GetHealthPercent() > self.health end
function modifier_item_cloak_of_flames_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")
self.radius = self.ability:GetSpecialValueFor("radius")
self.health = self.ability:GetSpecialValueFor("health")

if not IsServer() then return end
self:StartIntervalThink(0.5)
end

function modifier_item_cloak_of_flames_custom_tracker:OnIntervalThink()
if not IsServer() then return end

if self.parent:GetHealthPercent() <= self.health and self.parent:IsAlive() then
    if not self.particle then
        self.particle = self.parent:GenericParticle("particles/items/pyrrhic_cloak_custom.vpcf", self)
    end
else
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, false)
        ParticleManager:ReleaseParticleIndex(self.particle)
        self.particle = nil
    end
end

end

function modifier_item_cloak_of_flames_custom_tracker:GetAuraDuration() return 0.1 end
function modifier_item_cloak_of_flames_custom_tracker:GetAuraRadius() return self.radius end
function modifier_item_cloak_of_flames_custom_tracker:GetAuraSearchFlags() return 0 end
function modifier_item_cloak_of_flames_custom_tracker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_cloak_of_flames_custom_tracker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_cloak_of_flames_custom_tracker:GetModifierAura() return "modifier_item_cloak_of_flames_custom_aura" end
function modifier_item_cloak_of_flames_custom_tracker:IsAura() return true end
function modifier_item_cloak_of_flames_custom_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end

function modifier_item_cloak_of_flames_custom_tracker:GetModifierIncomingDamage_Percentage()
if self.parent:GetHealthPercent() >  self.health then return end
return self.damage_reduce
end


modifier_item_cloak_of_flames_custom_aura = class(mod_hidden)
function modifier_item_cloak_of_flames_custom_aura:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = self.ability:GetSpecialValueFor("interval")
self.health = self.ability:GetSpecialValueFor("health")
self.bonus = self.ability:GetSpecialValueFor("bonus")
self.damage = self.ability:GetSpecialValueFor("damage")*self.interval

if not IsServer() then return end 

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}

self.particle_index = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_fire_immolation_child.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle_index, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle_index, 1, self.caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
self:AddParticle(self.particle_index, false, false, -1, false, false ) 

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_item_cloak_of_flames_custom_aura:OnIntervalThink()
if not IsServer() then return end 
if not self.caster:IsAlive() then return end
self.damageTable.damage = self.damage*(self.caster:GetHealthPercent() <= self.health and self.bonus or 1)
DoDamage(self.damageTable)
end

