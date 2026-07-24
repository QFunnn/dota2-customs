--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_daedalus", "abilities/items/item_alchemist_gold_daedalus", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_daedalus_debuff", "abilities/items/item_alchemist_gold_daedalus", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_daedalus_bonus", "abilities/items/item_alchemist_gold_daedalus", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_daedalus_leash", "abilities/items/item_alchemist_gold_daedalus", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_daedalus = class({})

function item_alchemist_gold_daedalus:GetIntrinsicModifierName()
return "modifier_item_alchemist_gold_daedalus"
end


function item_alchemist_gold_daedalus:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

local projectile =
{
  Target = target,
  Source = caster,
  Ability = self,
  EffectName = "particles/items/celestial_spear_proj.vpcf",
  iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
  vSourceLoc = caster:GetAbsOrigin(),
  bDodgeable = true,
  bProvidesVision = false,
}

caster:AddNewModifier(caster, self, "modifier_item_alchemist_gold_daedalus_bonus", {duration = self:GetSpecialValueFor("bonus_duration")})

local hProjectile = ProjectileManager:CreateTrackingProjectile( projectile )
caster:EmitSound("Celestial_spear.Cast")
end 

function item_alchemist_gold_daedalus:OnProjectileHit(hTarget, vLocation)
if not hTarget then return end 
if not IsServer() then return end
if hTarget:TriggerSpellAbsorb(self) then return end
local caster = self:GetCaster()

local hit_effect = ParticleManager:CreateParticle("particles/econ/items/dragon_knight/dk_persona/dk_persona_dragon_tail_dragon_form_proj_impact.vpcf", PATTACH_CUSTOMORIGIN, hTarget)
ParticleManager:SetParticleControlEnt(hit_effect, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 3, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)

local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, hTarget)
ParticleManager:SetParticleControlEnt(hit_effect, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)


hTarget:EmitSound("Items.Spear_hit")
hTarget:EmitSound("Item.StarEmblem.Enemy")

hTarget:AddNewModifier(caster, self, "modifier_item_alchemist_gold_daedalus_leash", {duration = self:GetSpecialValueFor("leash_duration")*(1 - hTarget:GetStatusResistance())})
end 


modifier_item_alchemist_gold_daedalus	= class(mod_hidden)
function modifier_item_alchemist_gold_daedalus:RemoveOnDeath()	return false end

function modifier_item_alchemist_gold_daedalus:OnCreated()

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_speed = self.ability:GetSpecialValueFor("bonus_speed")
self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")

self.crit_chance = self.ability:GetSpecialValueFor("crit_chance")
self.bonus_chance = self.ability:GetSpecialValueFor("chance_bonus")
self.crit_multiplier = self.ability:GetSpecialValueFor("crit_multiplier")
self.corruption_duration = self.ability:GetSpecialValueFor("corruption_duration")
self.record = nil
end

function modifier_item_alchemist_gold_daedalus:GetCritDamage() return self.crit_multiplier end
function modifier_item_alchemist_gold_daedalus:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT

}
end

function modifier_item_alchemist_gold_daedalus:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_alchemist_gold_daedalus:GetModifierAttackSpeedBonus_Constant()
return self.bonus_speed
end

function modifier_item_alchemist_gold_daedalus:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end


function modifier_item_alchemist_gold_daedalus:GetModifierProcAttack_Feedback(params)
if params.attacker ~= self.parent then return end
if not params.target:IsUnit() then return end
if not self.parent:IsRealHero() then return end
if self.parent:HasModifier("modifier_item_celestial_spear_custom") or self.parent:HasModifier("modifier_item_desolator_custom") then return end

local target = params.target

target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_item_alchemist_gold_daedalus_debuff", {duration = self.corruption_duration})
target:EmitSound("Item_Desolator.Target")

local mod = target:FindModifierByName("modifier_item_alchemist_gold_daedalus_debuff")
if mod and params.record == self.record then 
	target:EmitSound("DOTA_Item.Daedelus.Crit")
	mod:IncrementStackCount()
end

end

function modifier_item_alchemist_gold_daedalus:GetModifierPreAttack_CriticalStrike( params )
if not IsServer() then return end

local chance = self.parent:HasModifier("modifier_item_alchemist_gold_daedalus_bonus") and (self.crit_chance + self.bonus_chance) or self.crit_chance

local random = RollPseudoRandomPercentage(chance, 109, self.parent)
if not random then return end

self.record = params.record
return self.crit_multiplier
end




modifier_item_alchemist_gold_daedalus_debuff	= class(mod_visible)
function modifier_item_alchemist_gold_daedalus_debuff:GetTexture() return "items/gold_crit" end
function modifier_item_alchemist_gold_daedalus_debuff:OnCreated()
if not IsServer() then return end

self.ability = self:GetCaster():FindItemInInventory("item_alchemist_gold_daedalus")
if not self.ability or self.ability:IsNull() then return end

self.corruption_armor = self.ability:GetSpecialValueFor("corruption_armor")
self.crit_armor = self.ability:GetSpecialValueFor("crit_armor")

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end


function modifier_item_alchemist_gold_daedalus_debuff:AddCustomTransmitterData() 
return 
{
  corruption_armor = self.corruption_armor,
  crit_armor = self.crit_armor
} 
end

function modifier_item_alchemist_gold_daedalus_debuff:HandleCustomTransmitterData(data)
self.corruption_armor = data.corruption_armor
self.crit_armor = data.crit_armor
end

function modifier_item_alchemist_gold_daedalus_debuff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_alchemist_gold_daedalus_debuff:GetModifierPhysicalArmorBonus()
return (self.corruption_armor + self:GetStackCount()*self.crit_armor)*-1
end






modifier_item_alchemist_gold_daedalus_leash = class({})

function modifier_item_alchemist_gold_daedalus_leash:IsHidden() return true end
function modifier_item_alchemist_gold_daedalus_leash:IsPurgable() return false end
function modifier_item_alchemist_gold_daedalus_leash:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.RemoveForDuel = true
self.center = self.parent:GetAbsOrigin() - (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()*60

self.effect_cast = ParticleManager:CreateParticle( "particles/huskar_disarm_coil.vpcf", PATTACH_WORLDORIGIN, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.center )
self:AddParticle(self.effect_cast,false,false,-1,false,false)

self.break_radius = self.ability:GetSpecialValueFor("break_radius")

local effect_cast_2 = ParticleManager:CreateParticle( "particles/items/celestial_spear_leash.vpcf", PATTACH_ABSORIGIN, self.parent )
ParticleManager:SetParticleControl( effect_cast_2, 0, self.center )
ParticleManager:SetParticleControlEnt(effect_cast_2,1,self.parent,PATTACH_POINT_FOLLOW,"attach_hitloc",self.parent:GetOrigin(),true)
self:AddParticle(effect_cast_2,false,false,-1,false,false)

self:StartIntervalThink(FrameTime())
end

function modifier_item_alchemist_gold_daedalus_leash:CheckState()
return
{
   [MODIFIER_STATE_TETHERED] = true
}

end 



function modifier_item_alchemist_gold_daedalus_leash:OnIntervalThink()
if not IsServer() then return end 
if (self.parent:GetAbsOrigin() - self.center):Length2D() <= self.break_radius then return end 

local direction = self.parent:GetOrigin()-self.center
direction.z = 0
direction = direction:Normalized()

local center = self.parent:GetAbsOrigin() + direction*10

local knockbackProperties =
{
    center_x = center.x,
    center_y = center.y,
    center_z = center.z,
    duration = 0.2,
    knockback_duration = 0.2,
    knockback_distance = (self.parent:GetOrigin()-self.center):Length2D(),
    knockback_height = 0,
    isStun = true,
}
self.parent:AddNewModifier( self.caster, self.ability, "modifier_knockback", knockbackProperties )

self.parent:EmitSound("Celestial_spear.Break")
self:Destroy()
end 



modifier_item_alchemist_gold_daedalus_bonus = class(mod_visible)