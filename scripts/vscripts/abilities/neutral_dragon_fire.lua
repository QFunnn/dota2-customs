--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_fire_ability", "abilities/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_fire_thinker", "abilities/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_fire_slow", "abilities/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_fire_slow", "abilities/neutral_dragon_fire", LUA_MODIFIER_MOTION_NONE)




neutral_dragon_fire = class({})

function neutral_dragon_fire:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_dragon_fire_ability" 
end 


modifier_dragon_fire_ability = class({})

function modifier_dragon_fire_ability:IsPurgable() return false end

function modifier_dragon_fire_ability:IsHidden() return true end

function modifier_dragon_fire_ability:OnCreated(table)
if not IsServer() then return end

self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.target = nil
end


function modifier_dragon_fire_ability:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
  self.target = target

end

self:GetParent():EmitSound("n_black_dragon.Fireball.Cast")
self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.7, effect = 1, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end


function modifier_dragon_fire_ability:EndCast()
if not IsServer() then return end
if not self.target or self.target:IsNull() then return end

CreateModifierThinker(self:GetParent(), self:GetAbility(), "modifier_dragon_fire_thinker", {duration =  self.duration}, self.target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
end 





modifier_dragon_fire_thinker = class({})

function modifier_dragon_fire_thinker:IsHidden() return false end
function modifier_dragon_fire_thinker:IsPurgable() return false end

function modifier_dragon_fire_thinker:IsAura()
 return self:GetCaster() and not self:GetCaster():IsNull()
end

function modifier_dragon_fire_thinker:GetAuraDuration() return 1 end
function modifier_dragon_fire_thinker:GetAuraRadius() return self.radius end

function modifier_dragon_fire_thinker:OnCreated(table)
if not IsServer() then return end

self.radius = self:GetAbility():GetSpecialValueFor("radius")

self.nFXIndex = ParticleManager:CreateParticle("particles/dragon_fireball.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.nFXIndex, 0, self:GetParent():GetOrigin())
ParticleManager:SetParticleControl(self.nFXIndex, 1, self:GetParent():GetOrigin())
ParticleManager:SetParticleControl(self.nFXIndex, 2, Vector(self.radius, 0, 0))
self:AddParticle(self.nFXIndex, false, false, -1, false, false)

self.parent = self:GetParent()

self.parent:EmitSound("Ember.Fire_burn")
end

function modifier_dragon_fire_thinker:OnDestroy()
if not IsServer() then return end 

self.parent:StopSound("Ember.Fire_burn")
end 



function modifier_dragon_fire_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_dragon_fire_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_dragon_fire_thinker:GetModifierAura() return "modifier_dragon_fire_slow" end



modifier_dragon_fire_slow = class({})

function modifier_dragon_fire_slow:IsPurgable() return false end
function modifier_dragon_fire_slow:IsHidden() return false end 

function modifier_dragon_fire_slow:OnCreated(table)
if not self:GetAbility() then return end

self.interval = self:GetAbility():GetSpecialValueFor("interval")
self.slow = self:GetAbility():GetSpecialValueFor("slow")
self.damage_inc = self:GetAbility():GetSpecialValueFor("damage_inc")
self.damage = self:GetAbility():GetSpecialValueFor("damage")

self.caster = self:GetCaster()
self.parent = self:GetParent()

self.interval = 0.20

if not IsServer() then return end

self.count = -self.interval

self.parent:EmitSound("Ember.Fire_burn_target")

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_dragon_fire_slow:OnIntervalThink()
if not IsServer() then return end

if self:GetCaster() and not self:GetCaster():IsNull() then 
  DoDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage*self.interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()}) 
end

self.count = self.count + self.interval
if self.count < 1 then return end 

self.count = 0

self:IncrementStackCount()    
end


function modifier_dragon_fire_slow:OnDestroy()
if not IsServer() then return end 

self.parent:StopSound("Ember.Fire_burn_target")
end 


function modifier_dragon_fire_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end



function modifier_dragon_fire_slow:GetModifierMoveSpeedBonus_Percentage() 
return self:GetStackCount()*self.slow
end 
  
 
function modifier_dragon_fire_slow:GetModifierIncomingDamage_Percentage() 
return self:GetStackCount()*self.damage_inc 
end


function modifier_dragon_fire_slow:GetEffectName()
  return "particles/units/heroes/hero_phoenix/phoenix_icarus_dive_burn_debuff.vpcf"
end
function modifier_dragon_fire_slow:GetStatusEffectName()
    return "particles/status_fx/status_effect_burn.vpcf"
end

function modifier_dragon_fire_slow:StatusEffectPriority()
    return MODIFIER_PRIORITY_HIGH 
end






