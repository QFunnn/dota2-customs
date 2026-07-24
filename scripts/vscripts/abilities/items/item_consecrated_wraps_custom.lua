--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_consecrated_wraps_custom", "abilities/items/item_consecrated_wraps_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_consecrated_wraps_custom_active", "abilities/items/item_consecrated_wraps_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_consecrated_wraps_custom_shield_cd", "abilities/items/item_consecrated_wraps_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_consecrated_wraps_custom_shield", "abilities/items/item_consecrated_wraps_custom", LUA_MODIFIER_MOTION_NONE)

item_consecrated_wraps_custom = class({})

function item_consecrated_wraps_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items8_fx/consecrated_wraps_onhit.vpcf", context )
PrecacheResource( "particle", "particles/items8_fx/consecrated_wraps_stack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
end

function item_consecrated_wraps_custom:GetIntrinsicModifierName()
return "modifier_item_consecrated_wraps_custom"
end

modifier_item_consecrated_wraps_custom = class(mod_hidden)
function modifier_item_consecrated_wraps_custom:RemoveOnDeath() return false end
function modifier_item_consecrated_wraps_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_HEALTH_BONUS,
  MODIFIER_PROPERTY_MANA_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
}
end

function modifier_item_consecrated_wraps_custom:GetModifierMagicalResistanceBonus()
if self.parent:HasModifier("modifier_item_pipe_custom") then return end
if self.parent:HasModifier("modifier_item_spell_breaker") then return end
if self.parent:HasModifier("modifier_item_mage_slayer") then return end
local bonus = 0
if self.parent:HasModifier("modifier_item_consecrated_wraps_custom_active") then 
	bonus = self.parent:GetUpgradeStack("modifier_item_consecrated_wraps_custom_active") * self.ability.resist_bonus
end 
return self.ability.bonus_spell_resist + bonus
end

function modifier_item_consecrated_wraps_custom:GetModifierHealthBonus()
return self.ability.bonus_health 
end

function modifier_item_consecrated_wraps_custom:GetModifierManaBonus()
return self.ability.bonus_mana
end

function modifier_item_consecrated_wraps_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_all_stats
end

function modifier_item_consecrated_wraps_custom:GetModifierBonusStats_Agility()
return self.ability.bonus_all_stats
end

function modifier_item_consecrated_wraps_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_all_stats
end

function modifier_item_consecrated_wraps_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.ability.tracker = self

self.ability.bonus_spell_resist = self.ability:GetSpecialValueFor("bonus_spell_resist")
self.ability.bonus_all_stats = self.ability:GetSpecialValueFor("bonus_all_stats")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.ability.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
self.ability.shield = self.ability:GetSpecialValueFor("shield")
self.ability.resist_bonus = self.ability:GetSpecialValueFor("resist_bonus")
self.ability.resist_max = self.ability:GetSpecialValueFor("resist_max")
self.ability.shield_cd = self.ability:GetSpecialValueFor("shield_cd")
self.ability.move_bonus = self.ability:GetSpecialValueFor("move_bonus")
self.ability.stack_duration = self.ability:GetSpecialValueFor("stack_duration")

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self.parent:RemoveModifierByName("modifier_item_consecrated_wraps_custom_shield")
self:StartIntervalThink(self.ability.shield_cd)
end 

function modifier_item_consecrated_wraps_custom:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_item_consecrated_wraps_custom_shield")
self.parent:RemoveModifierByName("modifier_item_consecrated_wraps_custom_active")
end

function modifier_item_consecrated_wraps_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if self.parent:HasModifier("modifier_item_consecrated_wraps_custom_shield_cd") then return end
if self.parent:HasModifier("modifier_item_consecrated_wraps_custom_shield") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_consecrated_wraps_custom_shield", {})
end

modifier_item_consecrated_wraps_custom_active = class(mod_visible)
function modifier_item_consecrated_wraps_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.resist_max
self.resist = self.ability.resist_bonus
self.move = self.ability.move_bonus
if not IsServer() then return end
self:OnRefresh()
end

function modifier_item_consecrated_wraps_custom_active:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:GenericParticle("particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", self)
end

end

function modifier_item_consecrated_wraps_custom_active:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_TOOLTIP,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
} 
end

function modifier_item_consecrated_wraps_custom_active:OnTooltip()
return self:GetStackCount()*self.resist
end

function modifier_item_consecrated_wraps_custom_active:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.move
end



modifier_item_consecrated_wraps_custom_shield = class(mod_hidden)
function modifier_item_consecrated_wraps_custom_shield:OnCreated( params )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_shield = self.ability.shield
self.shield = self.max_shield
self.shield_cd = self.ability.shield_cd

if not IsServer() then return end
local particle = ParticleManager:CreateParticle("particles/items8_fx/consecrated_wraps_stack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)  
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 2, Vector(10, 0, 0))
self:AddParticle(particle, false, false, -1, false, false  )

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end

function modifier_item_consecrated_wraps_custom_shield:OnIntervalThink()
if not IsServer() then return end
self.shield = self.max_shield
self:SendBuffRefreshToClients()
self:StartIntervalThink(-1)
end

function modifier_item_consecrated_wraps_custom_shield:OnDestroy()
if not IsServer() then return end
if not self.destroyed then return end
if not self.parent:IsAlive() then return end
if not IsValid(self.ability) then return end

local particle = ParticleManager:CreateParticle("particles/items8_fx/consecrated_wraps_onhit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)  
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_consecrated_wraps_custom_active", {duration = self.ability.stack_duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_consecrated_wraps_custom_shield_cd", {duration = self.shield_cd})
end

function modifier_item_consecrated_wraps_custom_shield:AddCustomTransmitterData() 
return 
{ 
  shield = self.shield,
}
end

function modifier_item_consecrated_wraps_custom_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_item_consecrated_wraps_custom_shield:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_item_consecrated_wraps_custom_shield:GetModifierIncomingDamageConstant(params)

if IsClient() then 
  if params.report_max then 
    return self.max_shield 
  else 
    return self.shield
  end 
end

if not IsServer() then return end
if self.shield <= 0 then return end

local damage = math.min(params.damage, self.shield)

self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = math.max(0, self.shield - damage)
self:SendBuffRefreshToClients()

self:StartIntervalThink(self.shield_cd)

if self.shield <= 0 then
  self.destroyed = true
  self:Destroy()
end
return -damage
end


modifier_item_consecrated_wraps_custom_shield_cd = class(mod_hidden)
function modifier_item_consecrated_wraps_custom_shield_cd:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_item_consecrated_wraps_custom_shield_cd:OnDestroy()
if not IsServer() then return end
if not IsValid(self.ability, self.ability.tracker) then return end
self.ability.tracker:OnIntervalThink()
end