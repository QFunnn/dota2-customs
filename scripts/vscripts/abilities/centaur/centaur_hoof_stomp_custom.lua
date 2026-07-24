--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_prepair", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_charge", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_charge_target", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_move", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_legendary_damage", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_tracker", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_damage_reduce", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_magic_reduce", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_hoof_stomp_custom_slow", "abilities/centaur/centaur_hoof_stomp_custom", LUA_MODIFIER_MOTION_NONE )

centaur_hoof_stomp_custom = class({})
centaur_hoof_stomp_custom.talents = {}

function centaur_hoof_stomp_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context )
PrecacheResource( "particle", "particles/centaur/stomp_charge.vpcf", context )
PrecacheResource( "particle", "particles/centaur/stomp_attack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_shard_buff_strength_counter_stack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", context )
PrecacheResource( "particle", "particles/centaur/stomp_crit.vpcf", context )
PrecacheResource( "particle", "particles/centaur/stomp_crit_hit.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength.vpcf", context )
end

function centaur_hoof_stomp_custom:UpdateTalents()
local caster = self:GetCaster()

if not self.init then
  self.talents =
  {
    q1_damage = 0,
    q1_spell = 0,

    cast_inc = 0,
    cd_inc = 0,

    has_reduce = 0,
    reduce_duration = caster:GetTalentValue("modifier_centaur_hero_1", "duration", true),
    h1_max = caster:GetTalentValue("modifier_centaur_hero_1", "max", true),
    damage_reduce = 0,
    heal_reduce = 0,

    has_q3 = 0,
    q3_damage = 0,
    q3_magic = 0,
    q3_slow_duration = caster:GetTalentValue("modifier_centaur_stomp_3", "slow_duration", true),
    q3_max = caster:GetTalentValue("modifier_centaur_stomp_3", "max", true),
    q3_damage_max = caster:GetTalentValue("modifier_centaur_stomp_3", "damage_max", true),
    q3_slow = caster:GetTalentValue("modifier_centaur_stomp_3", "slow", true),
    q3_duration = caster:GetTalentValue("modifier_centaur_stomp_3", "duration", true),
    q3_effect_duration = caster:GetTalentValue("modifier_centaur_stomp_3", "effect_duration", true),
    q3_distance = caster:GetTalentValue("modifier_centaur_stomp_3", "distance", true),

    has_q4 = 0,
    q4_cdr = caster:GetTalentValue("modifier_centaur_stomp_4", "cdr", true),
    q4_cd_items = caster:GetTalentValue("modifier_centaur_stomp_4", "cd_items", true),
    q4_slow_resist = caster:GetTalentValue("modifier_centaur_stomp_4", "slow_resist", true),

    has_q7 = 0,
    q7_effect_duration = caster:GetTalentValue("modifier_centaur_stomp_7", "effect_duration", true),
    q7_max = caster:GetTalentValue("modifier_centaur_stomp_7", "max", true),
    q7_cd_inc = caster:GetTalentValue("modifier_centaur_stomp_7", "cd_inc", true)/100,
    q7_speed = caster:GetTalentValue("modifier_centaur_stomp_7", "speed", true),
    q7_damage = caster:GetTalentValue("modifier_centaur_stomp_7", "damage", true)/100,
    q7_range = caster:GetTalentValue("modifier_centaur_stomp_7", "range", true),
    q7_hit_radius = caster:GetTalentValue("modifier_centaur_stomp_7", "hit_radius", true),
    q7_distance = caster:GetTalentValue("modifier_centaur_stomp_7", "distance", true),
  }
end

if caster:HasTalent("modifier_centaur_stomp_1") then
  self.talents.q1_damage = caster:GetTalentValue("modifier_centaur_stomp_1", "damage")
  self.talents.q1_spell = caster:GetTalentValue("modifier_centaur_stomp_1", "spell")
end

if caster:HasTalent("modifier_centaur_stomp_2") then
  self.talents.cd_inc = caster:GetTalentValue("modifier_centaur_stomp_2", "cd")
  self.talents.cast_inc = caster:GetTalentValue("modifier_centaur_stomp_2", "cast")
end

if caster:HasTalent("modifier_centaur_hero_1") then
  self.talents.has_reduce = 1
  self.talents.damage_reduce = caster:GetTalentValue("modifier_centaur_hero_1", "damage_reduce")
  self.talents.heal_reduce = caster:GetTalentValue("modifier_centaur_hero_1", "heal_reduce")
end

if caster:HasTalent("modifier_centaur_stomp_3") then
  self.talents.has_q3 = 1
  self.talents.q3_damage = caster:GetTalentValue("modifier_centaur_stomp_3", "damage")/100
  self.talents.q3_magic = caster:GetTalentValue("modifier_centaur_stomp_3", "magic")
end

if caster:HasTalent("modifier_centaur_stomp_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_centaur_stomp_7") then
  self.talents.has_q7 = 1
  self.tracker:InitLegendary()
end

end

function centaur_hoof_stomp_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "centaur_hoof_stomp", self)
end

function centaur_hoof_stomp_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_centaur_hoof_stomp_custom_tracker"
end

function centaur_hoof_stomp_custom:GetBehavior()
if self.talents.has_q7 == 1 then
  return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function centaur_hoof_stomp_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self,level)
end

function centaur_hoof_stomp_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function centaur_hoof_stomp_custom:GetCastRange(vLocation, hTarget)
local caster = self:GetCaster()
if self.talents.has_q7 == 1 then
  if IsClient() then
    return self.talents.q7_range
  else
    return 999999
  end
end
return self:GetRadius() - caster:GetCastRangeBonus()
end

function centaur_hoof_stomp_custom:GetAOERadius()
return self:GetRadius()
end

function centaur_hoof_stomp_custom:GetRadius()
return self.radius and self.radius or 0
end

function centaur_hoof_stomp_custom:ApplyReduce(target)
if not IsServer() then return end
if not self:IsTrained() then return end

if self.talents.has_q3 == 1 then
  target:AddNewModifier(self.caster, self, "modifier_centaur_hoof_stomp_custom_magic_reduce", {duration = self.talents.q3_duration})
end

if self.talents.has_reduce == 0 then return end
target:AddNewModifier(self:GetCaster(), self, "modifier_centaur_hoof_stomp_custom_damage_reduce", {duration = self.talents.reduce_duration})
end

function centaur_hoof_stomp_custom:ProcCd()
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_q4 == 0 then return end
self.caster:CdItems(self.talents.q4_cd_items)
end

function centaur_hoof_stomp_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local duration = self.windup_time + self.talents.cast_inc
self:RefundManaCost()

local distance = 0
if self.talents.has_q7 == 1 and (not target or target ~= caster) then
  local point = self:GetCursorPosition()
  local vec = point - caster:GetAbsOrigin()
  local max = self.talents.q7_range + caster:GetCastRangeBonus()

  if point == caster:GetAbsOrigin() then
    point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
  end

  if vec:Length2D() > max then
    point = caster:GetAbsOrigin() + vec:Normalized()*max
  end

  distance = (point - caster:GetAbsOrigin()):Length2D()
  vec.z = 0
  caster:FaceTowards(point)
  caster:SetForwardVector(vec:Normalized())
end
caster:AddNewModifier(caster, self, "modifier_centaur_hoof_stomp_custom_prepair", {distance = distance, duration = duration})
end

function centaur_hoof_stomp_custom:Stomp()
local caster = self:GetCaster()
local radius = self:GetRadius()
local hit_hero = false
local point = caster:GetAbsOrigin()

local pfx_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", self)
local particle_stomp_fx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(particle_stomp_fx, 0, point)
ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(radius, radius, radius))
ParticleManager:SetParticleControl(particle_stomp_fx, 2, point)
ParticleManager:SetParticleControl(particle_stomp_fx, 3, point)
ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

caster:EmitSound("Hero_Centaur.HoofStomp")

if self.talents.has_q3 == 1 then
  caster:AddNewModifier(caster, self, "modifier_centaur_hoof_stomp_custom_move", {duration = self.talents.q3_effect_duration})
end

local targets = caster:FindTargets(radius, point)
local damageTable = {attacker = caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL}

for _,target in pairs(targets) do
  damageTable.victim = target
  damageTable.damage = self:GetDamage(target)

  if target:IsRealHero() then
    hit_hero = true
    if caster:GetQuest() == "Centaur.Quest_5" and not caster:QuestCompleted() then
      caster:UpdateQuest(1)
    end
  end

  DoDamage(damageTable)
 
  if self.talents.has_q7 == 1 then
    target:AddNewModifier(caster, self, "modifier_centaur_hoof_stomp_custom_legendary_damage", {duration = self.talents.q7_effect_duration})
  end

  if self.caster.double_edge_ability then
    self.caster.double_edge_ability:ProcDouble(target, true)
  end

  self:ApplyReduce(target)
  target:AddNewModifier(caster, self, "modifier_generic_stun", {duration = self.stun_duration*(1 - target:GetStatusResistance())})
end

if #targets > 0 then
  self:ProcCd()
end

if dota1x6.event_thinker then
  local mod = dota1x6.event_thinker:FindModifierByName("modifier_event_thinker")
  if mod then
    local data = 
    {
      unit = caster,
      ability = self,
      new_pos = Vector(0, 0, 0),
      ignore_unvalid = true,
    }
    mod:OnAbilityExecuted(data)
  end
end

return hit_hero
end

function centaur_hoof_stomp_custom:GetDamage(target)
if not IsServer() then return end
local result = self.stomp_damage + self.talents.q1_damage
local mod = target:FindModifierByName("modifier_centaur_hoof_stomp_custom_legendary_damage")
if mod then
  result = result*(1 + self.talents.q7_damage*mod:GetStackCount())
end
return result
end


modifier_centaur_hoof_stomp_custom_prepair = class(mod_visible)
function modifier_centaur_hoof_stomp_custom_prepair:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:AddOrderEvent(self, true)

self.distance = table.distance
self.ability:EndCd()
self.base_time = self.ability.windup_time

local anim_k = self.base_time/self:GetRemainingTime()

if self.ability.talents.has_q7 == 1 and self.distance > 0 then
  anim_k = 0.85
end

self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, anim_k)
self.full_time = self:GetRemainingTime()

self.interval = 0.1

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_centaur_hoof_stomp_custom_prepair:OnIntervalThink()
if not IsServer() then return end

if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsSilenced() or self.parent:GetForceAttackTarget() ~= nil or self.parent:IsFeared() then
  self:Destroy()
end

end

function modifier_centaur_hoof_stomp_custom_prepair:OrderEvent( params )
if params.ability and params.ability == self.ability then return false end

if params.order_type == DOTA_UNIT_ORDER_STOP or 
  params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION or
  params.order_type == DOTA_UNIT_ORDER_CAST_POSITION or 
  params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET or 
  params.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE or 
  params.order_type == DOTA_UNIT_ORDER_CAST_TARGET then
  
  self:Destroy()
end

end

function modifier_centaur_hoof_stomp_custom_prepair:CheckState()
if self.distance <= 0 or self.ability.talents.has_q7 == 0 then return end
return
{
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
}
end

function modifier_centaur_hoof_stomp_custom_prepair:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()

if self:GetRemainingTime() >= 0.03 then
  self.ability:EndCd(0)
  self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
  return
end

if self.ability.talents.has_q7 == 1 and self.distance > 0 and not self.parent:IsLeashed() and not self.parent:IsRooted() then
  self.parent:EmitSound("Centaur.Stomp_charge1")
  self.parent:EmitSound("Centaur.Stomp_charge2")
  self.parent:EmitSound("Centaur.Stomp_charge3")
  local duration = self.distance/self.ability.talents.q7_speed
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_centaur_hoof_stomp_custom_charge", {distance = self.distance, duration = duration})
else
  self.ability:Stomp()
end

self.ability:UseResources(true, false, false, false)
end



modifier_centaur_hoof_stomp_custom_tracker = class(mod_hidden)
function modifier_centaur_hoof_stomp_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.stomp_ability = self.ability

self.ability.radius = self.ability:GetSpecialValueFor("radius")     
self.ability.stomp_damage = self.ability:GetSpecialValueFor("stomp_damage")    
self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
self.ability.windup_time = self.ability:GetSpecialValueFor("windup_time")
end

function modifier_centaur_hoof_stomp_custom_tracker:OnRefresh()
self.ability.stomp_damage = self.ability:GetSpecialValueFor("stomp_damage")    
self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
end

function modifier_centaur_hoof_stomp_custom_tracker:InitLegendary()
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end
if self.init_legendary then return end

self.init_legendary = true
self.interval = 0.2
self.pos = self.parent:GetAbsOrigin()
self.pass = 0
self:StartIntervalThink(self.interval)
end

function modifier_centaur_hoof_stomp_custom_tracker:OnIntervalThink()
if not IsServer() then return end

local pass = (self.parent:GetAbsOrigin() - self.pos):Length2D()
self.pos = self.parent:GetAbsOrigin()

if self.parent:HasModifier("modifier_centaur_hoof_stomp_custom_charge") then return end
if self.ability:GetCooldownTimeRemaining() <= 0 then 
  self.distance = 0
  return 
end

local final = self.distance + pass

if final >= self.ability.talents.q7_distance then 
    local delta = math.floor(final/self.ability.talents.q7_distance)
    for i = 1, delta do 
      self.parent:CdAbility(self.ability, nil, self.ability.talents.q7_cd_inc)
    end 
    self.distance = final - delta*self.ability.talents.q7_distance
else 
    self.distance = final
end 

end

function modifier_centaur_hoof_stomp_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
}
end

function modifier_centaur_hoof_stomp_custom_tracker:GetModifierPercentageCooldown() 
if self.ability.talents.has_q4 == 0 then return end
return self.ability.talents.q4_cdr
end

function modifier_centaur_hoof_stomp_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end

function modifier_centaur_hoof_stomp_custom_tracker:GetModifierSlowResistance_Stacking()
if self.ability.talents.has_q4 == 0 then return end
return self.ability.talents.q4_slow_resist
end



modifier_centaur_hoof_stomp_custom_charge = class(mod_hidden)
function modifier_centaur_hoof_stomp_custom_charge:OnCreated(params)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability:EndCd()
self.parent:AddOrderEvent(self, true)

self.aoe = self.ability.talents.q7_hit_radius

self.parent:GenericParticle("particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", self)
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.8)

self.speed = self.ability.talents.q7_speed
self.angle = self.parent:GetForwardVector():Normalized()
self.origin = self.parent:GetAbsOrigin()

self.bkb_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {duration = self:GetRemainingTime() + 1})

self.targets = {}

if not self:ApplyHorizontalMotionController() then
  self:Destroy()
  return
end

end

function modifier_centaur_hoof_stomp_custom_charge:UpdateHorizontalMotion( me, dt )
if self.parent:IsHexed() or self.parent:IsStunned() then 
  self:Destroy()
  return
end

local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 100, false)

local pos_p = self.angle * self.speed * dt
local next_pos = GetGroundPosition(pos + pos_p,self.parent)
self.parent:SetAbsOrigin(next_pos)

local targets = self.parent:FindTargets(self.aoe)

for _,target in pairs(targets) do 
  if not self.targets[target] and target:IsHero() then 
    self.targets[target] = true
    target:EmitSound("Hero_Centaur.Stampede.Stun")
    target:InterruptMotionControllers(false)
    target:AddNewModifier(self.parent, self.ability, "modifier_centaur_hoof_stomp_custom_charge_target", {duration = self:GetRemainingTime() + 0.1})
  end 
end 

local point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*60

for target,_ in pairs(self.targets) do
  target:SetAbsOrigin(point)
end

end

function modifier_centaur_hoof_stomp_custom_charge:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_centaur_hoof_stomp_custom_charge:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:RemoveHorizontalMotionController( self )

if self.bkb_mod and not self.bkb_mod:IsNull() then
  self.bkb_mod:Destroy()
end

self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)

local center = self.parent:GetAbsOrigin()
for target,_ in pairs(self.targets) do
  target:RemoveModifierByName("modifier_centaur_hoof_stomp_custom_charge_target")
  FindClearSpaceForUnit(target, target:GetAbsOrigin(), true)
  local knockbackProperties =
  {
    center_x = center.x,
    center_y = center.y,
    center_z = center.z,
    duration = 0.25,
    knockback_duration = 0.25,
    knockback_distance = 100,
    knockback_height = 30,
    should_stun = 1,
  }
  target:AddNewModifier( self.parent, self.ability, "modifier_knockback", knockbackProperties )
end

self.ability:Stomp()
end

function modifier_centaur_hoof_stomp_custom_charge:CheckState()
return
{
  [MODIFIER_STATE_ROOTED] = true,
  [MODIFIER_STATE_DISARMED] = true,
  [MODIFIER_STATE_SILENCED] = true
}
end

function modifier_centaur_hoof_stomp_custom_charge:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
  MODIFIER_PROPERTY_DISABLE_TURNING,
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_centaur_hoof_stomp_custom_charge:GetOverrideAnimation()
return ACT_DOTA_RUN
end

function modifier_centaur_hoof_stomp_custom_charge:GetActivityTranslationModifiers()
return "haste"
end

function modifier_centaur_hoof_stomp_custom_charge:GetModifierDisableTurning()
return 1
end

function modifier_centaur_hoof_stomp_custom_charge:OrderEvent( params )

if params.order_type==DOTA_UNIT_ORDER_STOP or params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION then
  self:Destroy()
end

end

function modifier_centaur_hoof_stomp_custom_charge:GetStatusEffectName()
return "particles/econ/items/invoker/invoker_ti7/status_effect_alacrity_ti7.vpcf"
end

function modifier_centaur_hoof_stomp_custom_charge:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end


modifier_centaur_hoof_stomp_custom_charge_target = class({})
function modifier_centaur_hoof_stomp_custom_charge_target:IsHidden() return true end
function modifier_centaur_hoof_stomp_custom_charge_target:IsPurgable() return false end
function modifier_centaur_hoof_stomp_custom_charge_target:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_centaur_hoof_stomp_custom_charge_target:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end


function modifier_centaur_hoof_stomp_custom_charge_target:CheckState()
return
{
  [MODIFIER_STATE_STUNNED] = true
}
end



modifier_centaur_hoof_stomp_custom_move = class(mod_visible)
function modifier_centaur_hoof_stomp_custom_move:GetTexture() return "buffs/centaur/stomp_3" end
function modifier_centaur_hoof_stomp_custom_move:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.interval = 0.1

self.distance = self.ability.talents.q3_distance
self.dist_count = 0
self.origin = self.parent:GetAbsOrigin()
self.count = 0

if not IsServer() then return end
self.RemoveForDuel = true
self.radius = self.ability:GetRadius()
self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_centaur_hoof_stomp_custom_move:OnIntervalThink()
if not IsServer() then return end
local dist = (self.parent:GetAbsOrigin() - self.origin):Length2D()
self.origin = self.parent:GetAbsOrigin()

self.dist_count = math.min(self.distance, (self.dist_count + dist))

if self.dist_count >= self.distance then
  self.dist_count = 0
  self.count = self.count + 1

  local particle_stomp_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", PATTACH_ABSORIGIN, self.parent)
  ParticleManager:SetParticleControl(particle_stomp_fx, 0, self.origin)
  ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(self.radius, self.radius, self.radius))
  ParticleManager:SetParticleControl(particle_stomp_fx, 2, self.origin)
  ParticleManager:SetParticleControl(particle_stomp_fx, 3, self.origin)
  ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

  self.parent:EmitSound("Hero_Centaur.HoofStomp")

  for _,target in pairs(self.parent:FindTargets(self.radius)) do
    local damage = self.ability:GetDamage(target)*self.ability.talents.q3_damage
    self.damageTable.damage = damage
    self.damageTable.victim = target
    DoDamage(self.damageTable, "modifier_centaur_stomp_3")
    target:AddNewModifier(self.parent, self.ability, "modifier_centaur_hoof_stomp_custom_slow", {duration = self.ability.talents.q3_slow_duration})
  end

  if self.count >= self.ability.talents.q3_damage_max then
    self:Destroy()
    return
  end
end

end

modifier_centaur_hoof_stomp_custom_slow = class(mod_hidden)
function modifier_centaur_hoof_stomp_custom_slow:IsPurgable() return true end
function modifier_centaur_hoof_stomp_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.slow = self.ability.talents.q3_slow
end

function modifier_centaur_hoof_stomp_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_centaur_hoof_stomp_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_centaur_hoof_stomp_custom_legendary_damage = class(mod_visible)
function modifier_centaur_hoof_stomp_custom_legendary_damage:GetTexture() return "centaur_hoof_stomp" end
function modifier_centaur_hoof_stomp_custom_legendary_damage:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max

if not IsServer() then return end
self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_shard_buff_strength_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 3, self.parent, PATTACH_OVERHEAD_FOLLOW, nil, self.parent:GetAbsOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)

self:SetStackCount(1)
end

function modifier_centaur_hoof_stomp_custom_legendary_damage:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_centaur_hoof_stomp_custom_legendary_damage:OnStackCountChanged()
if not IsServer() then return end
if not self.particle then return end
ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetStackCount(), 0, 0))
end



modifier_centaur_hoof_stomp_custom_damage_reduce = class(mod_visible)
function modifier_centaur_hoof_stomp_custom_damage_reduce:GetTexture() return "buffs/centaur/hero_1" end
function modifier_centaur_hoof_stomp_custom_damage_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.max = self.ability.talents.h1_max
self.damage_reduce = self.ability.talents.damage_reduce
self.heal_reduce = self.ability.talents.heal_reduce

if not IsServer() then return end
self:SetStackCount(1)
self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce*self:GetStackCount()
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce*self:GetStackCount()
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce*self:GetStackCount()
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:GetModifierHealChange()
return self.heal_reduce*self:GetStackCount()
end

function modifier_centaur_hoof_stomp_custom_damage_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce*self:GetStackCount()
end


modifier_centaur_hoof_stomp_custom_magic_reduce = class(mod_visible)
function modifier_centaur_hoof_stomp_custom_magic_reduce:GetTexture() return "buffs/centaur/stomp_3" end
function modifier_centaur_hoof_stomp_custom_magic_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q3_max
self.magic = self.ability.talents.q3_magic
if not IsServer() then return end
self:OnRefresh()
end

function modifier_centaur_hoof_stomp_custom_magic_reduce:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:GenericParticle("particles/hoodwink/bush_damage.vpcf", self)
end

end

function modifier_centaur_hoof_stomp_custom_magic_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_centaur_hoof_stomp_custom_magic_reduce:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.magic
end