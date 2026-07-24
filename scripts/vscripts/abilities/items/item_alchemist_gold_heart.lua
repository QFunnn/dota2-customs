--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_heart", "abilities/items/item_alchemist_gold_heart", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_heart_buff", "abilities/items/item_alchemist_gold_heart", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_heart_buff_effect", "abilities/items/item_alchemist_gold_heart", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_heart_burn", "abilities/items/item_alchemist_gold_heart", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_heart = class({})

function item_alchemist_gold_heart:GetIntrinsicModifierName()
	return "modifier_item_alchemist_gold_heart"
end

function item_alchemist_gold_heart:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/huskar_lowhp.vpcf", context )
PrecacheResource( "particle","particles/econ/events/fall_2022/radiance_target_fall2022.vpcf", context )
end

function item_alchemist_gold_heart:OnSpellStart()
local caster = self:GetCaster()

caster:AddNewModifier(caster, self, "modifier_item_alchemist_gold_heart_buff", {duration = self:GetSpecialValueFor("duration")})
end

modifier_item_alchemist_gold_heart	= class(mod_hidden)
function modifier_item_alchemist_gold_heart:RemoveOnDeath()	return false end

function modifier_item_alchemist_gold_heart:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_damage =  self.ability:GetSpecialValueFor("bonus_damage")
self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.health_regen_pct = self.ability:GetSpecialValueFor("health_regen_pct")
self.active_regen = self.ability:GetSpecialValueFor("active_regen")
self.evasion = self.ability:GetSpecialValueFor("evasion")

self.aura_radius = self.ability:GetSpecialValueFor("aura_radius")
if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/radiance_owner.vpcf", self)
end

function modifier_item_alchemist_gold_heart:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	MODIFIER_PROPERTY_EVASION_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_item_alchemist_gold_heart:GetModifierBonusStats_Strength()
if self.parent:HasModifier("modifier_item_heart_custom") then return end
return self.bonus_strength
end

function modifier_item_alchemist_gold_heart:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_alchemist_gold_heart:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_alchemist_gold_heart:GetModifierEvasion_Constant()
return self.evasion
end

function modifier_item_alchemist_gold_heart:GetModifierHealthRegenPercentage()
if self.parent:HasModifier("modifier_item_heart_custom") then return end
return self.parent:HasModifier("modifier_item_alchemist_gold_heart_buff") and (self.health_regen_pct + (self.active_regen*(1 - self.parent:GetHealthPercent()/100))) or self.health_regen_pct
end

function modifier_item_alchemist_gold_heart:IsAura() return IsValid(self.parent) and not self.parent:HasModifier("modifier_radiance_custom_stats") end
function modifier_item_alchemist_gold_heart:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_alchemist_gold_heart:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_item_alchemist_gold_heart:GetModifierAura() return "modifier_item_alchemist_gold_heart_burn" end
function modifier_item_alchemist_gold_heart:GetAuraRadius() return self.aura_radius end





modifier_item_alchemist_gold_heart_buff = class(mod_visible)
function modifier_item_alchemist_gold_heart_buff:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("Alchemist.Heart_active")
self.parent:GenericParticle("particles/huskar_lowhp.vpcf", self)
self.aura_radius = self.ability:GetSpecialValueFor("aura_radius")
end

function modifier_item_alchemist_gold_heart_buff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_item_alchemist_gold_heart_buff:GetModifierModelScale()
return 20
end

function modifier_item_alchemist_gold_heart_buff:IsAura() return true end
function modifier_item_alchemist_gold_heart_buff:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_alchemist_gold_heart_buff:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_item_alchemist_gold_heart_buff:GetModifierAura() return "modifier_item_alchemist_gold_heart_buff_effect" end
function modifier_item_alchemist_gold_heart_buff:GetAuraRadius() return self.aura_radius end





modifier_item_alchemist_gold_heart_burn = class(mod_visible)
function modifier_item_alchemist_gold_heart_burn:DeclareFunctions()
return 
{ 
	MODIFIER_PROPERTY_TOOLTIP,
} 
end
function modifier_item_alchemist_gold_heart_burn:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.burn_damage = self.ability:GetSpecialValueFor("aura_damage")/100
self.active_bonus = self.ability:GetSpecialValueFor("active_bonus")

self.miss_pers = self.ability:GetSpecialValueFor("blind_pct")

self.interval = self.ability:GetSpecialValueFor("think_interval")

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

if not IsServer() then return end

self.particle = self.parent:GenericParticle("particles/items2_fx/radiance.vpcf", self)
ParticleManager:SetParticleControlEnt( self.particle, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )

self:StartIntervalThink(self.interval)

EmitSoundOnEntityForPlayer("DOTA_Item.Radiance.Target.Loop", self.parent, self.parent:GetPlayerOwnerID())
end

function modifier_item_alchemist_gold_heart_burn:OnDestroy()
if not IsServer() then return end
StopSoundOn("DOTA_Item.Radiance.Target.Loop", self.parent)
end

function modifier_item_alchemist_gold_heart_burn:OnIntervalThink()
if not IsServer() then return end
local damage = self.caster:GetMaxHealth()*self.burn_damage
self.damageTable.damage = self.caster:HasModifier("modifier_item_alchemist_gold_heart_buff") and damage*self.active_bonus or damage
DoDamage(self.damageTable)
end


function modifier_item_alchemist_gold_heart_burn:OnTooltip()
local damage = self.caster:GetMaxHealth()*self.burn_damage
return self.caster:HasModifier("modifier_item_alchemist_gold_heart_buff") and damage*self.active_bonus or damage
end




modifier_item_alchemist_gold_heart_buff_effect = class(mod_hidden)
function modifier_item_alchemist_gold_heart_buff_effect:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()

self.particle = self.parent:GenericParticle("particles/econ/events/fall_2022/radiance_target_fall2022.vpcf", self)
ParticleManager:SetParticleControlEnt( self.particle, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
end

function modifier_item_alchemist_gold_heart_buff_effect:GetStatusEffectName()
return "particles/status_fx/status_effect_burn.vpcf"
end

function modifier_item_alchemist_gold_heart_buff_effect:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end