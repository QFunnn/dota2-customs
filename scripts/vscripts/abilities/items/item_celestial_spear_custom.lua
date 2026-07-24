--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_celestial_spear_custom", "abilities/items/item_celestial_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_celestial_spear_custom_armor", "abilities/items/item_celestial_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_celestial_spear_custom_leash", "abilities/items/item_celestial_spear_custom", LUA_MODIFIER_MOTION_NONE)


item_celestial_spear_custom = class({})

function item_celestial_spear_custom:GetIntrinsicModifierName()
	return "modifier_item_celestial_spear_custom"
end


function item_celestial_spear_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/items/celestial_spear_proj.vpcf", context )
PrecacheResource( "particle","particles/econ/items/dragon_knight/dk_persona/dk_persona_dragon_tail_dragon_form_proj_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/items_fx/desolator_projectile.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/star_emblem_caster.vpcf", context )
PrecacheResource( "particle","particles/huskar_disarm_coil.vpcf", context )
PrecacheResource( "particle","particles/items/celestial_spear_leash.vpcf", context )

end



function item_celestial_spear_custom:OnSpellStart()
if not IsServer() then return end 

local target = self:GetCursorTarget()

local projectile =
{
  Target = target,
  Source = self:GetCaster(),
  Ability = self,
  EffectName = "particles/items/celestial_spear_proj.vpcf",
  iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
  vSourceLoc = self:GetCaster():GetAbsOrigin(),
  bDodgeable = true,
  bProvidesVision = false,
}

local hProjectile = ProjectileManager:CreateTrackingProjectile( projectile )

self:GetCaster():EmitSound("Celestial_spear.Cast")

end 



function item_celestial_spear_custom:OnProjectileHit(hTarget, vLocation)
if not hTarget then return end 
if not IsServer() then return end
if hTarget:TriggerSpellAbsorb(self) then return end

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

hTarget:AddNewModifier(self:GetCaster(), self, "modifier_item_celestial_spear_custom_leash", {duration = self:GetSpecialValueFor("leash_duration")*(1 - hTarget:GetStatusResistance())})
end 


modifier_item_celestial_spear_custom = class({})
function modifier_item_celestial_spear_custom:IsHidden() return true end
function modifier_item_celestial_spear_custom:IsPurgable() return false end
function modifier_item_celestial_spear_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_celestial_spear_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PROJECTILE_NAME,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_celestial_spear_custom:OnCreated()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.caster:AddAttackEvent_out(self, true)

self.ability.armor_reduce = self.ability:GetSpecialValueFor("corruption_armor")
self.corruption_duration = self.ability:GetSpecialValueFor("corruption_duration")
self.speed = self.ability:GetSpecialValueFor("bonus_speed")
self.damage = self.ability:GetSpecialValueFor("bonus_damage")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
end 

function modifier_item_celestial_spear_custom:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_item_celestial_spear_custom:GetModifierPreAttack_BonusDamage()
return self.damage
end

function modifier_item_celestial_spear_custom:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_celestial_spear_custom:GetPriority()
return MODIFIER_PRIORITY_NORMAL
end

function modifier_item_celestial_spear_custom:GetModifierProjectileName()
return "particles/items_fx/desolator_projectile.vpcf"
end

function modifier_item_celestial_spear_custom:AttackEvent_out(params)
if params.attacker ~= self.caster then return end
if not params.target:IsUnit() then return end

local target = params.target

target:AddNewModifier(self.caster, self.caster:BkbAbility(nil, true), "modifier_item_celestial_spear_custom_armor", {armor = self.ability.armor_reduce, duration = self.corruption_duration})
target:EmitSound("Item_Desolator.Target")

end



modifier_item_celestial_spear_custom_armor = class({})
function modifier_item_celestial_spear_custom_armor:IsPurgable() return true end
function modifier_item_celestial_spear_custom_armor:IsHidden() return true end
function modifier_item_celestial_spear_custom_armor:GetTexture() return "item_desolator" end
function modifier_item_celestial_spear_custom_armor:OnCreated(table)
if not IsServer() then return end
self:SetStackCount(table.armor)
end

function modifier_item_celestial_spear_custom_armor:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_celestial_spear_custom_armor:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*-1
end





modifier_item_celestial_spear_custom_leash = class({})

function modifier_item_celestial_spear_custom_leash:IsHidden() return true end
function modifier_item_celestial_spear_custom_leash:IsPurgable() return false end
function modifier_item_celestial_spear_custom_leash:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.RemoveForDuel = true
self.center = self.parent:GetAbsOrigin() - (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()*60

self.effect_cast = ParticleManager:CreateParticle( "particles/huskar_disarm_coil.vpcf", PATTACH_WORLDORIGIN, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.center )
self:AddParticle(self.effect_cast,false,false,-1,false,false)

self.break_radius = self:GetAbility():GetSpecialValueFor("break_radius")

local effect_cast_2 = ParticleManager:CreateParticle( "particles/items/celestial_spear_leash.vpcf", PATTACH_ABSORIGIN, self.parent )
ParticleManager:SetParticleControl( effect_cast_2, 0, self.center )
ParticleManager:SetParticleControlEnt(effect_cast_2,1,self.parent,PATTACH_POINT_FOLLOW,"attach_hitloc",self.parent:GetOrigin(),true)
self:AddParticle(effect_cast_2,false,false,-1,false,false)

self:StartIntervalThink(FrameTime())
end

function modifier_item_celestial_spear_custom_leash:CheckState()
return
{
   [MODIFIER_STATE_TETHERED] = true
}

end 

function modifier_item_celestial_spear_custom_leash:OnIntervalThink()
if not IsServer() then return end 
if (self.parent:GetAbsOrigin() - self.center):Length2D() <= self.break_radius then return end 
if self.parent:IsInvulnerable() then return end

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