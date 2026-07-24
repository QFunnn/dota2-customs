--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_radiance_custom_stats", "abilities/items/item_radiance_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_radiance_custom_burn", "abilities/items/item_radiance_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_radiance_custom_toggle", "abilities/items/item_radiance_custom.lua", LUA_MODIFIER_MOTION_NONE )

item_radiance_custom = class({})

function item_radiance_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/radiance_owner.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/radiance.vpcf", context )
end

function item_radiance_custom:GetAbilityTextureName()
if self and self:GetCaster() and self:GetCaster():HasModifier("modifier_radiance_custom_toggle") then
	return "item_radiance"
end
return wearables_system:GetAbilityIconReplacement(self.caster, "item_radiance_inactive", self)
end

function item_radiance_custom:GetIntrinsicModifierName()
return "modifier_radiance_custom_stats" 
end

function item_radiance_custom:OnSpellStart()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_radiance_custom_toggle")
if mod then
	mod:Destroy()
else
	caster:AddNewModifier(caster, self, "modifier_radiance_custom_toggle", {})
end

end


modifier_radiance_custom_stats = class(mod_hidden)
function modifier_radiance_custom_stats:RemoveOnDeath() return false end
function modifier_radiance_custom_stats:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_radiance_custom_stats:OnCreated(keys)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.damage_base = self.ability:GetSpecialValueFor("damage_base")
self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")/100
self.ability.interval = self.ability:GetSpecialValueFor("think_interval")
self.ability.magic_resist = self.ability:GetSpecialValueFor("magic_resist")

self.damage = self.ability:GetSpecialValueFor("bonus_damage")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.evasion = self.ability:GetSpecialValueFor("evasion")
if not IsServer() then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_radiance_custom_toggle", {})
end

function modifier_radiance_custom_stats:OnDestroy()
if not IsServer() then return end
if not IsValid(self.parent) then return end
self.parent:RemoveModifierByName("modifier_radiance_custom_toggle")
end


function modifier_radiance_custom_stats:DeclareFunctions()
return 
{ 
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_EVASION_CONSTANT
}
end

function modifier_radiance_custom_stats:GetModifierPreAttack_BonusDamage()
return self.damage
end

function modifier_radiance_custom_stats:GetModifierEvasion_Constant()
return self.evasion
end

function modifier_radiance_custom_stats:GetModifierHealthBonus()
return self.bonus_health
end

modifier_radiance_custom_burn = class(mod_visible)
function modifier_radiance_custom_burn:GetTexture() return "item_radiance" end
function modifier_radiance_custom_burn:DeclareFunctions()
return 
{ 
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	MODIFIER_PROPERTY_TOOLTIP
} 
end

function modifier_radiance_custom_burn:OnTooltip()
return self:GetDamage()
end

function modifier_radiance_custom_burn:GetModifierMagicalResistanceBonus()
return self.magic
end

function modifier_radiance_custom_burn:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.magic = self.ability.magic_resist

if not IsServer() then return end
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

local player_id = self.caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_radiance")
local default_effect = "particles/items2_fx/radiance.vpcf"
if custom_effect_data then
    default_effect = custom_effect_data[2]
end

self.particle = ParticleManager:CreateParticle(default_effect, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 1, self.caster:GetAbsOrigin())
self:AddParticle(self.particle,false, false, -1, false, false)

EmitSoundOnEntityForPlayer("DOTA_Item.Radiance.Target.Loop", self.parent, self.parent:GetPlayerOwnerID())
self:StartIntervalThink(self.ability.interval)
end

function modifier_radiance_custom_burn:GetDamage()
if not IsValid(self.caster) then return end
return self.ability.damage_base + self.ability.damage_health*self.caster:GetMaxHealth()
end

function modifier_radiance_custom_burn:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.caster) then self:Destroy() return end

ParticleManager:SetParticleControl(self.particle, 1, self.caster:GetAbsOrigin())
self.damageTable.damage = self:GetDamage()
DoDamage(self.damageTable)
end

function modifier_radiance_custom_burn:OnDestroy()
if not IsServer() then return end
StopSoundOn("DOTA_Item.Radiance.Target.Loop", self.parent)
end


modifier_radiance_custom_toggle = class(mod_hidden)
function modifier_radiance_custom_toggle:RemoveOnDeath() return false end
function modifier_radiance_custom_toggle:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("aura_radius")
if not IsServer() then return end
local player_id = self.parent:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_radiance")
local default_effect = "particles/items2_fx/radiance_owner.vpcf"
if custom_effect_data then
    default_effect = custom_effect_data[1]
end
self.parent:GenericParticle(default_effect, self)
end

function modifier_radiance_custom_toggle:IsAura() return true end
function modifier_radiance_custom_toggle:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_radiance_custom_toggle:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_radiance_custom_toggle:GetModifierAura() return "modifier_radiance_custom_burn"end
function modifier_radiance_custom_toggle:GetAuraRadius() return self.radius end