--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("item_aeon_disk_custom_passive", "abilities/items/item_aeon_disk_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("item_aeon_disk_custom_cd", "abilities/items/item_aeon_disk_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("item_aeon_disk_custom_proc", "abilities/items/item_aeon_disk_custom", LUA_MODIFIER_MOTION_NONE)


item_aeon_disk_custom = class({})

function item_aeon_disk_custom:GetIntrinsicModifierName() return
"item_aeon_disk_custom_passive"
end

function item_aeon_disk_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items4_fx/combo_breaker_buff.vpcf", context )
end

item_aeon_disk_custom_passive = class(mod_hidden)
function item_aeon_disk_custom_passive:IsHidden() return true end
function item_aeon_disk_custom_passive:IsPurgable() return false end
function item_aeon_disk_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function item_aeon_disk_custom_passive:RemoveOnDeath() return false end
function item_aeon_disk_custom_passive:DeclareFunctions()
return
{
   MODIFIER_PROPERTY_HEALTH_BONUS,
   MODIFIER_PROPERTY_MANA_BONUS,
   MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function item_aeon_disk_custom_passive:GetModifierHealthBonus()
return self.bonus_health
end

function item_aeon_disk_custom_passive:GetModifierManaBonus()
return self.mana
end

function item_aeon_disk_custom_passive:GetModifierMoveSpeedBonus_Constant()
return self.move
end

function item_aeon_disk_custom_passive:OnCreated(table)

self.ability = self:GetAbility()
self.parent = self:GetParent()
self.mana = self.ability:GetSpecialValueFor("bonus_mana")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.move = self.ability:GetSpecialValueFor("move_bonus")

self.cd = self.ability:GetSpecialValueFor("cd")
self.health_pct = self.ability:GetSpecialValueFor("health_threshold_pct")
self.duration = self.ability:GetSpecialValueFor("duration")
self.heal = self.ability:GetSpecialValueFor("heal")/100

if not IsServer() then return end
if self.parent:IsRealHero() then 
	self.parent:AddDamageEvent_inc(self, true)
end

end


function item_aeon_disk_custom_passive:DamageEvent_inc(params)
if not IsServer() then return end
if not self.ability or self.ability:IsNull() then return end
if not self.ability:IsFullyCastable() then return end
if not self.parent:IsRealHero() then return end
if not self.parent:IsAlive() then return end
if not params.attacker:IsHero() then return end
if self.parent ~= params.unit then return end 
if self.parent:GetTeamNumber() == params.attacker:GetTeamNumber() then return end
if self.parent:HasModifier("modifier_death") then return end
if self.parent:GetHealthPercent() > self.health_pct then return end
if self.parent:HasModifier("item_aeon_disk_custom_cd") then return end

local damage = params.damage
local prev_health = self.parent:GetHealth() + damage

self.parent:AddNewModifier(self.parent, self.ability, "item_aeon_disk_custom_cd", {duration = self.cd})
self.parent:AddNewModifier(self.parent, self.ability, "item_aeon_disk_custom_proc", {duration = self.duration})
self.parent:EmitSound("DOTA_Item.ComboBreaker")
self.parent:Purge( false, true, false, true, true )
 
self.parent:SetHealth(math.min(prev_health, self.parent:GetMaxHealth() * self.health_pct/100))

self.parent:GenericHeal(self.parent:GetMaxHealth()*self.heal, self.ability)
end


item_aeon_disk_custom_cd = class(mod_cd)




item_aeon_disk_custom_proc = class({})
function item_aeon_disk_custom_proc:IsHidden() return false end
function item_aeon_disk_custom_proc:IsPurgable() return true end

function item_aeon_disk_custom_proc:OnCreated(table)
self.status = self:GetAbility():GetSpecialValueFor("status_resistance")
if not IsServer() then return end
local combo_breaker_particle = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControlEnt(combo_breaker_particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
self:AddParticle(combo_breaker_particle, false, false, -1, true, false)
end

function item_aeon_disk_custom_proc:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}

end

function item_aeon_disk_custom_proc:GetModifierStatusResistanceStacking() 
return self.status
end

function item_aeon_disk_custom_proc:GetAbsoluteNoDamagePhysical()
return 1
end 

function item_aeon_disk_custom_proc:GetAbsoluteNoDamagePure()
return 1
end 

function item_aeon_disk_custom_proc:GetAbsoluteNoDamageMagical()
return 1
end 

function item_aeon_disk_custom_proc:GetModifierTotalDamageOutgoing_Percentage()
return -100
end