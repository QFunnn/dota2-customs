--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skywrath_mage_scepter_shield_custom", "abilities/skywrath_mage/skywrath_mage_scepter_shield_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_scepter_shield_custom_slow", "abilities/skywrath_mage/skywrath_mage_scepter_shield_custom", LUA_MODIFIER_MOTION_NONE )



skywrath_mage_scepter_shield_custom = class({})

function skywrath_mage_scepter_shield_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/skywrath/scepter_shield.vpcf", context )
PrecacheResource( "particle", "particles/skywrath/scepter_shield_break.vpcf", context )
end

function skywrath_mage_scepter_shield_custom:GetManaCost(level)
return self:GetCaster():GetMana()*self:GetSpecialValueFor("cost")/100
end


function skywrath_mage_scepter_shield_custom:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

if not caster:HasModifier("modifier_skywrath_mage_mystic_flare_custom_legendary_caster") and not caster:IsStunned() then
  caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
end
caster:AddNewModifier(caster, self, "modifier_skywrath_mage_scepter_shield_custom", {duration = duration})
end



modifier_skywrath_mage_scepter_shield_custom = class({})
function modifier_skywrath_mage_scepter_shield_custom:IsHidden() return false end
function modifier_skywrath_mage_scepter_shield_custom:IsPurgable() return false end
function modifier_skywrath_mage_scepter_shield_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor("damage")/100
self.radius = self.ability:GetSpecialValueFor("radius")
self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.knock_duration = self.ability:GetSpecialValueFor("knock_duration")
self.max_shield = self.ability:GetSpecialValueFor("mana_shield")*self.parent:GetMaxMana()/100
self.destroyed = false

if not IsServer() then return end
self.ability:EndCd()
self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
self.parent:EmitSound("Sky.Scepter_shield")
self.parent:EmitSound("Sky.Scepter_shield2")
local effect_cast = ParticleManager:CreateParticle( "particles/skywrath/scepter_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle( effect_cast, false, false, -1, false, false )
end

function modifier_skywrath_mage_scepter_shield_custom:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()

self.parent:StopSound("Sky.Scepter_shield")
self.parent:EmitSound("Sky.Scepter_shield_break")

if self.destroyed == false then return end 
self.parent:EmitSound("Sky.Scepter_shield_break2")
self.parent:EmitSound("Sky.Scepter_shield_break3")

local center = self.parent:GetAbsOrigin()
local damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.max_shield*self.damage}
for _,target in pairs(self.parent:FindTargets(self.radius)) do 
  damageTable.victim = target
  DoDamage(damageTable)

  local vec = target:GetAbsOrigin() - center
  local max_point = center + vec:Normalized()*self.radius
  local dist = math.max((max_point - target:GetAbsOrigin()):Length2D(), 50)

  local knockback = 
  {
    should_stun = 0,
    knockback_duration = self.knock_duration,
    duration = self.knock_duration,
    knockback_distance = dist,
    knockback_height = 0,
    center_x = center.x,
    center_y = center.y,
    center_z = center.z,
    should_stun = 0,
  }

  target:GenericParticle("particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf")
  target:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_scepter_shield_custom_slow", {duration = self.slow_duration})
  local mod = target:AddNewModifier(self.parent, self.ability, "modifier_knockback", knockback)
  if mod then 
    target:GenericParticle("particles/skymage/bolt_slow.vpcf", mod)
  end
end

local effect_cast = ParticleManager:CreateParticle( "particles/skywrath/scepter_shield_break.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(effect_cast)
end


function modifier_skywrath_mage_scepter_shield_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end


function modifier_skywrath_mage_scepter_shield_custom:GetModifierIncomingDamageConstant( params )

if IsClient() then 
  if params.report_max then 
    return self.max_shield
  else 
      return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end




modifier_skywrath_mage_scepter_shield_custom_slow = class({})
function modifier_skywrath_mage_scepter_shield_custom_slow:IsHidden() return true end
function modifier_skywrath_mage_scepter_shield_custom_slow:IsPurgable() return true end
function modifier_skywrath_mage_scepter_shield_custom_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_skywrath_mage_scepter_shield_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_skywrath_mage_scepter_shield_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end