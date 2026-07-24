--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_veil_of_discord_custom", "abilities/items/item_veil_of_discord_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_veil_of_discord_custom_damage_inc", "abilities/items/item_veil_of_discord_custom", LUA_MODIFIER_MOTION_NONE)

item_veil_of_discord_custom = class({})

function item_veil_of_discord_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/veil_of_discord.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/veil_of_discord_debuff.vpcf", context )
end

function item_veil_of_discord_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("DOTA_Item.VeilofDiscord.Activate")

local particle = ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(self.debuff_radius, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

for _,target in pairs(caster:FindTargets(self.debuff_radius)) do
	target:AddNewModifier(caster, self, "modifier_item_veil_of_discord_custom_damage_inc", {duration = self.resist_debuff_duration})
end

end

function item_veil_of_discord_custom:GetIntrinsicModifierName()
return "modifier_item_veil_of_discord_custom"
end

modifier_item_veil_of_discord_custom = class({})
function modifier_item_veil_of_discord_custom:IsHidden() return true end
function modifier_item_veil_of_discord_custom:IsPurgable() return false end
function modifier_item_veil_of_discord_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
}
end

function modifier_item_veil_of_discord_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_veil_of_discord_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_veil_of_discord_custom:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_out(self, true)
end 

self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.ability.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
self.ability.spell_lifesteal = self.ability:GetSpecialValueFor("spell_lifesteal")/100
self.ability.spell_amp = self.ability:GetSpecialValueFor("spell_amp")
self.ability.debuff_radius = self.ability:GetSpecialValueFor("debuff_radius")
self.ability.resist_debuff_duration = self.ability:GetSpecialValueFor("resist_debuff_duration")
end

function modifier_item_veil_of_discord_custom:DamageEvent_out(params)
if not IsServer() then return end
local result = self.parent:CheckLifesteal(params, 1)
if not result then return end
if (params.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return end
self.parent:GenericHeal(params.damage * self.ability.spell_lifesteal * result, self.ability, false, "particles/items3_fx/octarine_core_lifesteal.vpcf") 
end


modifier_item_veil_of_discord_custom_damage_inc = class(mod_visible)
function modifier_item_veil_of_discord_custom_damage_inc:IsPurgable() return true end
function modifier_item_veil_of_discord_custom_damage_inc:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.damage = self.ability.spell_amp
if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/veil_of_discord_debuff.vpcf", self)
end

function modifier_item_veil_of_discord_custom_damage_inc:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_item_veil_of_discord_custom_damage_inc:GetModifierIncomingDamage_Percentage(params)
if self.parent:HasModifier("modifier_item_bloodstone_custom_damage_inc") then return end
if IsServer() and (not params.inflictor or Not_spell_damage[params.inflictor:GetName()]) then return end
return self.damage
end