--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_phantom_blur", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_smoke", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_stunready", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_heal", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_legendary_smoke", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_legendary_caster", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_legendary_target", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_damage_stack", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_invun", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_quest", "abilities/phantom_assassin/custom_phantom_assassin_blur", LUA_MODIFIER_MOTION_NONE )


    
custom_phantom_assassin_blur = class({})


function custom_phantom_assassin_blur:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_start.vpcf", context )
PrecacheResource( "particle","particles/pa_legendary_blur.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_active.vpcf", context )
PrecacheResource( "particle","particles/blur_absorb.vpcf", context )
PrecacheResource( "particle","particles/pa_blur_attack.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blur_smoke.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blur_stack.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blur_proc_damage.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blur_range_hit.vpcf", context )

end

function custom_phantom_assassin_blur:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "phantom_assassin_blur", self)
end


function custom_phantom_assassin_blur:GetIntrinsicModifierName() 
return "modifier_phantom_assassin_phantom_blur" 
end


function custom_phantom_assassin_blur:GetBehavior()
local caster = self:GetCaster()
local insta = 0
if caster:HasShard() then
  insta = DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + insta
end





function custom_phantom_assassin_blur:OnSpellStart()
  
local caster = self:GetCaster()

if caster:HasShard() then 
  caster:Purge(false, true, false, false, false)
end

local particle_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_start.vpcf", self)

caster:GenericParticle(particle_name)
ProjectileManager:ProjectileDodge(caster)

if caster:HasTalent("modifier_phantom_assassin_blur_6") then 
  caster:CdItems(caster:GetTalentValue("modifier_phantom_assassin_blur_6", "cd_items"))
  caster:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_invun", {duration = caster:GetTalentValue("modifier_phantom_assassin_blur_6", "duration")})
end

caster:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_smoke", {duration = self:GetSpecialValueFor("duration")})
end



modifier_phantom_assassin_phantom_blur = class({})

function modifier_phantom_assassin_phantom_blur:IsHidden() return true end
function modifier_phantom_assassin_phantom_blur:IsPurgable() return false end

function modifier_phantom_assassin_phantom_blur:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()


self.range_inc = self.parent:GetTalentValue("modifier_phantom_assassin_blur_5", "range", true)
self.range_bonus = self.parent:GetTalentValue("modifier_phantom_assassin_blur_5", "bonus", true)
self.range_distance = self:GetCaster():GetTalentValue("modifier_phantom_assassin_blur_5", "distance", true)

self.legendary_damage = self.parent:GetTalentValue("modifier_phantom_assassin_blur_7", "damage", true)/100
self.legendary_evasion = self.parent:GetTalentValue("modifier_phantom_assassin_blur_7", "evasion", true)
self.legendary_creeps = self.parent:GetTalentValue("modifier_phantom_assassin_blur_7", "max_creeps", true)

self.stun_duration = self.parent:GetTalentValue("modifier_phantom_assassin_blur_5", "stun", true)

self.cd_inc = self.parent:GetTalentValue("modifier_phantom_assassin_blur_6", "cd_inc", true)

self.speed_bonus = self.parent:GetTalentValue("modifier_phantom_assassin_blur_3", "bonus", true)

self.parent:AddAttackEvent_out(self)
end



function modifier_phantom_assassin_phantom_blur:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end


function modifier_phantom_assassin_phantom_blur:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end 
local target = params.target

if not target:IsHero() and not target:IsCreep() and not target:IsBuilding() then return end

if self.parent:HasTalent("modifier_phantom_assassin_blur_6") and target:IsUnit() then 
  self.parent:CdAbility(self.ability, self.cd_inc)
end

local stun_mod = self.parent:FindModifierByName("modifier_phantom_assassin_phantom_stunready")

if self.parent:HasTalent("modifier_phantom_assassin_blur_5") and (mod or stun_mod) and not params.no_attack_cooldown then 
  for i = 1,3 do
    local particle = ParticleManager:CreateParticle( "particles/phantom_assassin/blur_range_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW,  self.parent )
    ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex( particle )
  end 
end

if stun_mod and not params.no_attack_cooldown then 

  target:EmitSound("PA.Blur_attack")

  local effect_cast = ParticleManager:CreateParticle( "particles/pa_blur_attack.vpcf", PATTACH_OVERHEAD_FOLLOW, target )
  ParticleManager:SetParticleControl( effect_cast, 0,  target:GetOrigin() )
  ParticleManager:SetParticleControl( effect_cast, 1,  target:GetOrigin() )
  ParticleManager:SetParticleControlForward(effect_cast, 1, (self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Normalized())
  ParticleManager:ReleaseParticleIndex(effect_cast)

  local dir = (self.parent:GetAbsOrigin() - params.target:GetAbsOrigin()):Normalized()
  local distance = (self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Length2D()
  local real_dist = math.max(0, math.min(self.range_distance, distance - 120))

  if real_dist ~= 0 then 
    params.target:AddNewModifier(self.parent, self.ability, "modifier_generic_knockback",
    {
      duration = 0.15,
      distance = real_dist,
      height = 0,
      direction_x = dir.x,
      direction_y = dir.y,
      IsFlail = 1,
    })
  end

  params.target:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = self.stun_duration*(1 - target:GetStatusResistance())})
  stun_mod:Destroy()
end

local mod = self.parent:FindModifierByName("modifier_phantom_assassin_phantom_smoke")
if mod and not params.no_attack_cooldown then 
  mod:Destroy()
end

local legendary_mod = self.parent:FindModifierByName("modifier_phantom_assassin_phantom_legendary_caster")
if not legendary_mod then return end 

local random = RollPseudoRandomPercentage(self.legendary_evasion*self.parent:GetEvasion() ,7227,self.parent)
if not random then return end

local damage = self.legendary_damage*target:GetMaxHealth()
if target:IsCreep() then 
  damage = math.min(damage, self.legendary_creeps)
end

local real_damage = DoDamage({ victim = target, attacker = self.parent, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_phantom_assassin_blur_7")
target:SendNumber(6, real_damage)

local particle = ParticleManager:CreateParticle( "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bladekeeper.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target )
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

local trail_pfx = ParticleManager:CreateParticle("particles/phantom_assassin/blur_proc_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControl(trail_pfx, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(trail_pfx, 1, target:GetAbsOrigin())
ParticleManager:SetParticleControlForward(trail_pfx, 1, ( target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized())
ParticleManager:ReleaseParticleIndex(trail_pfx)

target:EmitSound("PA.Blur_legendary_damage")
end




function modifier_phantom_assassin_phantom_blur:GetModifierAttackRangeBonus() 
if not self.parent:HasTalent("modifier_phantom_assassin_blur_5") then return end
local bonus = self.range_inc
if self.parent:HasModifier("modifier_phantom_assassin_phantom_smoke") then 
  bonus = bonus*self.range_bonus
end
return bonus
end



function modifier_phantom_assassin_phantom_blur:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_phantom_assassin_blur_3") then return end
local bonus = self.parent:GetTalentValue("modifier_phantom_assassin_blur_3", "speed")
if self.parent:HasModifier("modifier_phantom_assassin_phantom_smoke") or self.parent:HasModifier("modifier_phantom_assassin_phantom_heal") then 
  bonus = bonus*self.speed_bonus
end
return bonus
end







modifier_phantom_assassin_phantom_smoke = class({})

function modifier_phantom_assassin_phantom_smoke:IsHidden()  return false end
function modifier_phantom_assassin_phantom_smoke:IsPurgable() return false end


function modifier_phantom_assassin_phantom_smoke:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()


self.vanish_radius = self.ability:GetSpecialValueFor("radius")
self.delay = self.ability:GetSpecialValueFor("delay") + self.parent:GetTalentValue("modifier_phantom_assassin_blur_1", "delay")
self.shard_damage = self.ability:GetSpecialValueFor("shard_damage")

self.speed_bonus = self.ability:GetSpecialValueFor("active_movespeed_bonus") + self.parent:GetTalentValue("modifier_phantom_assassin_blur_2", "speed")

if not IsServer() then return end


if self.parent:HasTalent("modifier_phantom_assassin_blur_5") then 
  self.stun_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_stunready", {duration = self:GetRemainingTime()})
end

if self.parent:HasShard() then 
  self.parent:GenericParticle("particles/blur_absorb.vpcf", self)
end

self.RemoveForDuel = true
self.ability:EndCd()

local particle_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf", self)

self.parent:GenericParticle(particle_name, self)
self.parent:EmitSound("Hero_PhantomAssassin.Blur")

self.ended = false

self:OnIntervalThink()
self:StartIntervalThink(FrameTime())
end

function modifier_phantom_assassin_phantom_smoke:SetEnd()
if not IsServer() then return end
if self.ended == true then return end
self.ended = true
self:SetDuration(self.delay, true)
self:StartIntervalThink(-1)
end


function modifier_phantom_assassin_phantom_smoke:OnIntervalThink()
if self.ended == true then return end

local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.vanish_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false) 
  
local count =  0

for _,unit in pairs(enemies) do 
  if unit:IsCourier() or (unit:IsCreep() and unit:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5) then

  else
    count = count + 1
    break
  end
end


if count == 0 then return end
self:SetEnd()
end


function modifier_phantom_assassin_phantom_smoke:OnDestroy()

if self.stun_mod and not self.stun_mod:IsNull() then 
  self.stun_mod:SetDuration(self.parent:GetTalentValue("modifier_phantom_assassin_blur_5", "effect_duration"), true)
end

if not IsServer() then return end

self.parent:EmitSound("Hero_PhantomAssassin.Blur.Break")
self.ability:StartCd()

if self.parent:HasTalent("modifier_phantom_assassin_blur_2") or self.parent:HasTalent("modifier_phantom_assassin_blur_3") then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_heal", {duration = self.parent:GetTalentValue("modifier_phantom_assassin_blur_2", "duration", true)})
end

if self.parent:GetQuest() == "Phantom.Quest_7" then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_quest", {duration = self.parent.quest.number})
end

if self.parent:HasTalent("modifier_phantom_assassin_blur_7") or self.parent:HasTalent("modifier_phantom_assassin_blur_4") then 
  CreateModifierThinker( self.parent, self.ability, "modifier_phantom_assassin_phantom_legendary_smoke", {duration = self.parent:GetTalentValue("modifier_phantom_assassin_blur_7", "duration", true)}, self.parent:GetAbsOrigin(), self.parent:GetTeamNumber(), false )
end

end


function modifier_phantom_assassin_phantom_smoke:CheckState()
return 
{
  [MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES ] = true,
  [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
  [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
}
end

function modifier_phantom_assassin_phantom_smoke:GetPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_phantom_assassin_phantom_smoke:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_phantom_assassin_phantom_smoke:GetModifierInvisibilityLevel()
return 1
end


function modifier_phantom_assassin_phantom_smoke:GetModifierMoveSpeedBonus_Percentage()
return self.speed_bonus
end

function modifier_phantom_assassin_phantom_smoke:GetModifierIncomingDamage_Percentage()
if not self.parent:HasShard() then return end
return self.shard_damage
end

function modifier_phantom_assassin_phantom_smoke:GetStatusEffectName()
return "particles/status_fx/status_effect_phantom_assassin_active_blur.vpcf"
end


function modifier_phantom_assassin_phantom_smoke:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end





modifier_phantom_assassin_phantom_stunready = class({})
function modifier_phantom_assassin_phantom_stunready:IsPurgable() return false end
function modifier_phantom_assassin_phantom_stunready:IsHidden() return false end
function modifier_phantom_assassin_phantom_stunready:GetTexture() return "buffs/Blur_silence" end

function modifier_phantom_assassin_phantom_stunready:CheckState()
return
{
  [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_phantom_assassin_phantom_stunready:OnCreated()
self.RemoveForDuel = true
end












modifier_phantom_assassin_phantom_heal = class({})
function modifier_phantom_assassin_phantom_heal:IsHidden() return false end
function modifier_phantom_assassin_phantom_heal:IsPurgable() return false end
function modifier_phantom_assassin_phantom_heal:GetTexture() return "buffs/Blur_heal" end

function modifier_phantom_assassin_phantom_heal:OnCreated(table)
self.parent = self:GetParent()
self.speed = self:GetAbility():GetSpecialValueFor("active_movespeed_bonus") + self.parent:GetTalentValue("modifier_phantom_assassin_blur_2", "speed")
self.heal = self.parent:GetTalentValue("modifier_phantom_assassin_blur_2", "heal")/self:GetRemainingTime()

if not IsServer() then return end 
self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", self)
end

function modifier_phantom_assassin_phantom_heal:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_phantom_assassin_phantom_heal:GetModifierHealthRegenPercentage()
if not self.parent:HasTalent("modifier_phantom_assassin_blur_2") then return end
return self.heal
end

function modifier_phantom_assassin_phantom_heal:GetModifierMoveSpeedBonus_Percentage()
if not self.parent:HasTalent("modifier_phantom_assassin_blur_2") then return end
return self.speed 
end





modifier_phantom_assassin_phantom_speed = class({})
function modifier_phantom_assassin_phantom_speed:IsHidden() return true end
function modifier_phantom_assassin_phantom_speed:IsPurgable() return false end






modifier_phantom_assassin_phantom_legendary_smoke = class({})
function modifier_phantom_assassin_phantom_legendary_smoke:IsHidden() return true end
function modifier_phantom_assassin_phantom_legendary_smoke:IsPurgable() return false end
function modifier_phantom_assassin_phantom_legendary_smoke:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end 
if self.ability.smoke and not self.ability.smoke:IsNull() then 
  self.ability.smoke:RemoveModifierByName("modifier_phantom_assassin_phantom_legendary_smoke")
end

self.ability.smoke = self.parent

self.point = self.parent:GetAbsOrigin()
self.radius = self.caster:GetTalentValue("modifier_phantom_assassin_blur_7", "radius", true)

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "PA.Blur_smoke", self.caster)
EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "PA.Blur_smoke2", self.caster)

self.particle = ParticleManager:CreateParticle("particles/phantom_assassin/blur_smoke.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle, 0, self.point)
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self.radius, self.radius))
ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetRemainingTime(), 0, 0))
self:AddParticle(self.particle, false, false, -1, false, false)  

if not self.caster:HasTalent("modifier_phantom_assassin_blur_4") then return end

self.interval = 0.1
self.linger = 0.5
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_phantom_assassin_phantom_legendary_smoke:IsAura() return self.caster:HasTalent("modifier_phantom_assassin_blur_7") end
function modifier_phantom_assassin_phantom_legendary_smoke:GetAuraDuration() return 0 end
function modifier_phantom_assassin_phantom_legendary_smoke:GetAuraRadius() return self.radius end
function modifier_phantom_assassin_phantom_legendary_smoke:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_phantom_assassin_phantom_legendary_smoke:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_phantom_assassin_phantom_legendary_smoke:GetModifierAura() return "modifier_phantom_assassin_phantom_legendary_caster" end

function modifier_phantom_assassin_phantom_legendary_smoke:OnDestroy()
if not IsServer() then return end 
self.ability.smoke = nil
end

function modifier_phantom_assassin_phantom_legendary_smoke:OnIntervalThink()
if not IsServer() then return end 

for _,target in pairs(self.caster:FindTargets(self.radius, self.point)) do
  target:AddNewModifier(self.caster, self.ability, "modifier_phantom_assassin_phantom_legendary_target", {duration = self.linger})
end

end





modifier_phantom_assassin_phantom_legendary_caster = class({})
function modifier_phantom_assassin_phantom_legendary_caster:IsHidden() return false end
function modifier_phantom_assassin_phantom_legendary_caster:IsPurgable() return false end
function modifier_phantom_assassin_phantom_legendary_caster:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.evasion = self.parent:GetTalentValue("modifier_phantom_assassin_blur_7", "evasion")
if not IsServer() then return end

self:OnIntervalThink()
self:StartIntervalThink(0.2)
end


function modifier_phantom_assassin_phantom_legendary_caster:OnIntervalThink()
if not IsServer() then return end
self:SetStackCount(self.parent:GetEvasion()*self.evasion)
end


function modifier_phantom_assassin_phantom_legendary_caster:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_TOOLTIP
}
end


function modifier_phantom_assassin_phantom_legendary_caster:OnTooltip()
return self:GetStackCount()
end

function modifier_phantom_assassin_phantom_legendary_caster:NoDamage(params, type)
if not IsServer() then return end
if self.parent:HasModifier("modifier_death") then return 0 end
if not params.attacker then return 0 end 
if not params.attacker:IsUnit() then return 0 end
if params.damage_type ~= type then return 0 end 

local random = RollPseudoRandomPercentage(self.parent:GetEvasion()*self.evasion,7226,self.parent)

if not random then return 0 end

self.parent:EmitSound("PA.Blur_legendary_evasion") 
self.parent:GenericParticle("particles/pa_legendary_blur.vpcf")

return 1
end


function modifier_phantom_assassin_phantom_legendary_caster:GetAbsoluteNoDamagePhysical(params)
return self:NoDamage(params, DAMAGE_TYPE_PHYSICAL)
end

function modifier_phantom_assassin_phantom_legendary_caster:GetAbsoluteNoDamagePure(params)
return self:NoDamage(params, DAMAGE_TYPE_PURE)
end

function modifier_phantom_assassin_phantom_legendary_caster:GetAbsoluteNoDamageMagical(params)
return self:NoDamage(params, DAMAGE_TYPE_MAGICAL)
end

function modifier_phantom_assassin_phantom_legendary_caster:GetStatusEffectName()
return "particles/status_fx/status_effect_muerta_parting_shot.vpcf"
end

function modifier_phantom_assassin_phantom_legendary_caster:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end






modifier_phantom_assassin_phantom_legendary_target = class({})
function modifier_phantom_assassin_phantom_legendary_target:IsHidden() return true end
function modifier_phantom_assassin_phantom_legendary_target:IsPurgable() return false end
function modifier_phantom_assassin_phantom_legendary_target:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_duration = self.caster:GetTalentValue("modifier_phantom_assassin_blur_4", "effect_duration")
self.slow = self.caster:GetTalentValue("modifier_phantom_assassin_blur_4", "slow")
if not IsServer() then return end 

self:StartIntervalThink(1)
end

function modifier_phantom_assassin_phantom_legendary_target:OnIntervalThink(table)
if not IsServer() then return end
self.parent:AddNewModifier(self.caster, self.ability, "modifier_phantom_assassin_phantom_damage_stack", {duration = self.damage_duration})
end


function modifier_phantom_assassin_phantom_legendary_target:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_phantom_assassin_phantom_legendary_target:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_phantom_assassin_phantom_legendary_target:GetStatusEffectName()
return "particles/status_fx/status_effect_lone_druid_savage_roar.vpcf"
end

function modifier_phantom_assassin_phantom_legendary_target:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end











modifier_phantom_assassin_phantom_damage_stack = class({})
function modifier_phantom_assassin_phantom_damage_stack:IsHidden() return false end
function modifier_phantom_assassin_phantom_damage_stack:IsPurgable() return false end 
function modifier_phantom_assassin_phantom_damage_stack:GetTexture() return "buffs/tree_regen" end
function modifier_phantom_assassin_phantom_damage_stack:OnCreated(table)

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.damage = self.caster:GetTalentValue("modifier_phantom_assassin_blur_4", "damage")
self.max = self.caster:GetTalentValue("modifier_phantom_assassin_blur_4", "max")

if not IsServer() then return end

self.RemoveForDuel = true

self.effect_cast = ParticleManager:CreateParticle( "particles/phantom_assassin/blur_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)

self:SetStackCount(1)
end

function modifier_phantom_assassin_phantom_damage_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end

function modifier_phantom_assassin_phantom_damage_stack:DeclareFunctions()
return
  {
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end

function modifier_phantom_assassin_phantom_damage_stack:GetModifierIncomingDamage_Percentage(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end 
return self:GetStackCount()*self.damage
end

function modifier_phantom_assassin_phantom_damage_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self.effect_cast then 
  ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end

end



modifier_phantom_assassin_phantom_invun = class({})
function modifier_phantom_assassin_phantom_invun:IsHidden() return true end
function modifier_phantom_assassin_phantom_invun:IsPurgable() return false end
function modifier_phantom_assassin_phantom_invun:CheckState()
return
{
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
}
end

function modifier_phantom_assassin_phantom_invun:GetStatusEffectName()
return "particles/status_fx/status_effect_muerta_parting_shot.vpcf"
end

function modifier_phantom_assassin_phantom_invun:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA 
end



modifier_phantom_assassin_phantom_quest = class({})
function modifier_phantom_assassin_phantom_quest:IsHidden() return true end
function modifier_phantom_assassin_phantom_quest:IsPurgable() return false end