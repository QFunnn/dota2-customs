--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_puck_coil_wall_thinker", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_thinker", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_slow", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_speed", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_damage", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_tracker", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_heal", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_custom_resist", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_custom_status", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_coil_orb_custom_steal_jump", "abilities/puck/custom_puck_illusory_orb", LUA_MODIFIER_MOTION_NONE)



custom_puck_illusory_orb = class({})


function custom_puck_illusory_orb:CreateTalent()
local ability = self:GetCaster():FindAbilityByName("custom_puck_illusory_barrier")

if ability then 
  ability:SetHidden(false) 
  ability:UpdateVectorValues()
end

self:UpdateVectorValues()
end


function custom_puck_illusory_orb:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_puck/puck_base_attack_warmup.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_illusory_orb_linear_projectile.vpcf", context )
PrecacheResource( "particle","particles/puck_blind.vpcf", context )
PrecacheResource( "particle","particles/duel_wall.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_illusory_orb_blink_out.vpcf", context )
PrecacheResource( "particle","particles/puck_orb_slow.vpcf", context )
PrecacheResource( "particle","particles/puck_orb_speed.vpcf", context )
PrecacheResource( "particle","particles/puck/orb_cleave.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/zuus_heal.vpcf", context )
PrecacheResource( "particle","particles/puck_stun.vpcf", context )
PrecacheResource( "particle","particles/puck/orb_stack_max.vpcf", context )
PrecacheResource( "particle","particles/puck/orb_status.vpcf", context )
PrecacheResource( "particle","particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf", context )
end


local function GetAngle( x1, y1, x2, y2 )
return math.deg(math.acos((x1*x2+y1*y2)/(((x1^2+y1^2)^0.5)*((x2^2+y2^2)^0.5))))
end


function custom_puck_illusory_orb:GetManaCost(level)
if self:GetCaster():HasModifier("modifier_puck_coil_orb_custom_steal_jump") then 
  return 0
end
return self.BaseClass.GetManaCost(self,level)
end

function custom_puck_illusory_orb:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_puck_coil_orb_custom_steal_jump") then
    return "puck_ethereal_jaunt"
end
return "puck_illusory_orb"
end


function custom_puck_illusory_orb:GetBehavior()
if self:GetCaster():HasModifier("modifier_puck_coil_orb_custom_steal_jump") then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end
if self:GetCaster():HasTalent("modifier_puck_orb_7") then
  return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING
end
return DOTA_ABILITY_BEHAVIOR_POINT 
end


function custom_puck_illusory_orb:GetVectorTargetRange()
  return self:GetSpecialValueFor("radius")
end

function custom_puck_illusory_orb:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_puck_coil_orb_tracker"
end



function custom_puck_illusory_orb:GetCooldown(iLevel)
local bonus = 0
local caster = self:GetCaster()
if caster:HasModifier("modifier_puck_coil_orb_damage") and caster:HasTalent("modifier_puck_orb_4") then 
  bonus = caster:GetUpgradeStack("modifier_puck_coil_orb_damage")*caster:GetTalentValue("modifier_puck_orb_4", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end




function custom_puck_illusory_orb:DealDamage(target, data)
local caster = self:GetCaster()
target:EmitSound("Hero_Puck.IIllusory_Orb_Damage")

local damage = self:GetAbilityDamage()
local creeps_k = self:GetSpecialValueFor("creeps_damage")/100 + 1
local stun = false
if data.bonus_stack and data.bonus_stack > 0 then 

  if caster:HasTalent("modifier_puck_orb_4") then 
    local bonus = caster:GetTalentValue("modifier_puck_orb_4", "damage")*target:GetMaxHealth()/100
    if target:IsCreep() then
      bonus = caster:GetTalentValue("modifier_puck_orb_4", "creeps")
    end
    damage = damage + data.bonus_stack*bonus
  end

  if caster:HasTalent("modifier_puck_orb_6") and data.bonus_stack >= caster:GetTalentValue("modifier_puck_orb_6", "max") and data.bounced ~= 1 then 
    target:EmitSound("Puck.Shift_Stun")
    target:GenericParticle("particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf")
    local stun_mod = target:AddNewModifier(caster, self, "modifier_generic_stun", {duration = caster:GetTalentValue("modifier_puck_orb_6", "stun")*(1 - target:GetStatusResistance())})
    if stun_mod and not stun_mod:IsNull() then 
      stun = true
      stun_mod:SetEndRule(function()
        if target and not target:IsNull() then 
          target:AddNewModifier( caster, self, "modifier_puck_coil_orb_slow", { duration = caster:GetTalentValue("modifier_puck_orb_6", "duration")})
        end 
      end)
    end
  end
end

if stun == false and caster:HasTalent("modifier_puck_orb_6") then 
  target:AddNewModifier( caster, self, "modifier_puck_coil_orb_slow", { duration = caster:GetTalentValue("modifier_puck_orb_6", "duration")})
end

if target:IsCreep() then
  damage = damage*creeps_k
end

if data.bounced == 1 then 
  damage = damage*caster:GetTalentValue("modifier_puck_orb_7", "damage", true)/100
end

local damageTable = {
  victim      = target,
  damage      = damage,
  damage_type   = self:GetAbilityDamageType(),
  damage_flags  = DOTA_DAMAGE_FLAG_NONE,
  attacker    = caster,
  ability     = self
}
DoDamage(damageTable)
end





function custom_puck_illusory_orb:OnVectorCastStart(vStartLocation, vDirection)

local caster = self:GetCaster()
local target = self:GetCursorPosition()

if target == caster:GetAbsOrigin() then 
  target = caster:GetAbsOrigin() + caster:GetForwardVector()*30
end

local orb_direction = (caster:GetAbsOrigin() - target):Normalized()
local angle = GetAngle(orb_direction.x , orb_direction.y , vDirection.x , vDirection.y)/2
local rat = math.atan2( orb_direction.y, orb_direction.x )
local dat = math.atan2( vDirection.y, vDirection.x )

local l = rat < dat 
if  math.deg(math.abs(rat - dat)) > 180 then 
  l = not l
end
if l then 
  angle = -angle
end

local pos1 = self:GetVectorPosition() + RotatePosition(Vector(), QAngle(0, 90 + angle ,0), vDirection*(self:GetVectorTargetRange())) 
local pos2 = self:GetVectorPosition() + RotatePosition(Vector(), QAngle(0,-90 + angle,0), vDirection*(self:GetVectorTargetRange())) 

local thiker = CreateModifierThinker(caster, self, "modifier_puck_coil_wall_thinker",
{
  duration = caster:GetTalentValue("modifier_puck_orb_7", "duration"),
  pos1x = pos1.x,
  pos1y = pos1.y,
  pos1z = pos1.z,
  pos2x = pos2.x,
  pos2y = pos2.y,
  pos2z = pos2.z,
  vDirectionX = vDirection.x,
  vDirectionY = vDirection.y,
  vDirectionZ = vDirection.z
}, target, caster:GetTeamNumber(), false)
  
self:StartOrb(target, caster:GetAbsOrigin(), 0)
end


function custom_puck_illusory_orb:OnSpellStart()

local caster = self:GetCaster()
local target = self:GetCursorPosition()
local mod = caster:FindModifierByName("modifier_puck_coil_orb_custom_steal_jump")

if mod then
  self:Teleport()
  mod:Destroy()
  return
end

if target == caster:GetAbsOrigin() then 
  target = caster:GetAbsOrigin() + caster:GetForwardVector()*30
end

local ability = caster:FindAbilityByName("custom_puck_ethereal_jaunt")
if not ability then
  caster:AddNewModifier(caster, self, "modifier_puck_coil_orb_custom_steal_jump", {})
  self:EndCd(0)
  self:StartCooldown(0.2)
end 

self:StartOrb(target,caster:GetAbsOrigin(), 0)
end



function custom_puck_illusory_orb:Teleport()
if not self.orbs or #self.orbs <= 0 then return end
local caster = self:GetCaster()

caster:EmitSound("Hero_Puck.EtherealJaunt")

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_illusory_orb_blink_out.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin() + Vector(0, 0, 150))
ParticleManager:ReleaseParticleIndex(particle)

ProjectileManager:DestroyLinearProjectile(self.orbs_effect[#self.orbs_effect])
EntIndexToHScript(self.orbs[#self.orbs]):StopSound("Hero_Puck.Illusory_Orb")

FindClearSpaceForUnit(caster, EntIndexToHScript(self.orbs[#self.orbs]):GetAbsOrigin(), true)
ProjectileManager:ProjectileDodge(caster)
  
local caster = caster
if caster:GetQuest() == "Puck.Quest_5" then 
  local enemies = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, caster.quest.number, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO  + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
  if #enemies > 0 then 
    caster:UpdateQuest(1)
  end
end

local thinker = EntIndexToHScript(self.orbs[#self.orbs])
thinker.Destroyed = true 
thinker:Destroy()

table.remove(self.orbs, #self.orbs)
table.remove(self.orbs_effect, #self.orbs_effect)
end



function custom_puck_illusory_orb:StartOrb(target, start, bounced, stacks)
local caster = self:GetCaster()

local jaunt_ability = caster:FindAbilityByName("custom_puck_ethereal_jaunt")
if jaunt_ability then
  jaunt_ability:SetActivated(true)
end

if not self.orbs then
  self.orbs = {}
end

if not self.orbs_effect then
  self.orbs_effect = {}
end

local vector = (target - start):Normalized()
if target == start then
  target = target + vector
end

local orb_thinker = CreateUnitByName("npc_dota_companion", start, false, caster, caster,caster:GetTeamNumber())
orb_thinker:AddNewModifier(caster, self, "modifier_puck_coil_orb_thinker", {}) 
orb_thinker.angle = math.deg(math.atan2(vector.x, vector.y))
orb_thinker.vector = vector*-1
orb_thinker.Destroyed = false

local distance = self:GetSpecialValueFor("max_distance")*(1 + caster:GetTalentValue("modifier_puck_orb_3", "range")/100)
local speed = self:GetSpecialValueFor("orb_speed")*(1 + caster:GetTalentValue("modifier_puck_orb_3", "speed")/100)
local radius = self:GetSpecialValueFor("radius")

orb_thinker.max_distance = distance
orb_thinker:EmitSound("Hero_Puck.Illusory_Orb")

local velocity = ((GetGroundPosition(target, nil) - GetGroundPosition(start, nil)))
velocity.z = 0

local bonus_stack = 0

if bounced == 0 then 
  local mod = caster:FindModifierByName("modifier_puck_coil_orb_damage")
  if mod then
    bonus_stack = mod:GetStackCount()
    mod:Destroy()
  end
else 
  if stacks then 
    bonus_stack = stacks
  end
end

orb_thinker.bonus_stack = bonus_stack
local extra_data = {orb_thinker = orb_thinker:entindex(), bounced = bounced, bonus_stack = bonus_stack}

for _,enemy in pairs(caster:FindTargets(radius, start)) do 
  self:DealDamage(enemy, extra_data)
  extra_data[enemy:entindex()] = true
end

local projectile_info = {
  Source        = caster,
  Ability       = self,
  vSpawnOrigin    = start,
  bDeleteOnHit    = false,
  iUnitTargetTeam   = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType   = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
  EffectName      = "particles/units/heroes/hero_puck/puck_illusory_orb_linear_projectile.vpcf",
  fDistance       = distance,
  fStartRadius    = radius,
  fEndRadius      = radius,
  vVelocity       =  velocity:Normalized() * speed,
  bReplaceExisting  = false,
  bProvidesVision   = true,
  iVisionRadius     = self:GetSpecialValueFor("orb_vision"),
  iVisionTeamNumber   = caster:GetTeamNumber(),
  ExtraData = extra_data
}


local projectile = ProjectileManager:CreateLinearProjectile(projectile_info)
table.insert(self.orbs, orb_thinker:entindex())
table.insert(self.orbs_effect, projectile)
end


function custom_puck_illusory_orb:OnProjectileHit_ExtraData(target, location, data)
local caster = self:GetCaster()
local jaunt_ability = caster:FindAbilityByName("custom_puck_ethereal_jaunt")

if not target then 
  if data.orb_thinker then
    table.remove(self.orbs, 1)
    table.remove(self.orbs_effect, 1)

    EntIndexToHScript(data.orb_thinker):StopSound("Hero_Puck.Illusory_Orb")
    EntIndexToHScript(data.orb_thinker).Destroyed = true
    EntIndexToHScript(data.orb_thinker):Destroy()
  end

  if jaunt_ability and #self.orbs == 0 then
    jaunt_ability:SetActivated(false)
  end
  caster:RemoveModifierByName("modifier_puck_coil_orb_custom_steal_jump")
  return
end

for index,number in pairs(data) do 
  if index == target:entindex() or tostring(target:entindex()) == index then 
    return
  end
end

self:DealDamage(target, data)
end



function custom_puck_illusory_orb:OnProjectileThink_ExtraData(location, data)
if not IsServer() then return end

if data.orb_thinker then
  local thinker = EntIndexToHScript(data.orb_thinker)
  thinker:SetAbsOrigin(location)
end

self:CreateVisibilityNode(location, self:GetSpecialValueFor("orb_vision"), self:GetSpecialValueFor("vision_duration"))
end



custom_puck_ethereal_jaunt = class({})
function custom_puck_ethereal_jaunt:ProcsMagicStick() return false end
function custom_puck_ethereal_jaunt:OnUpgrade()
self:SetActivated(false)
end

function custom_puck_ethereal_jaunt:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_puck_orb_5") then 
  bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + bonus
end

function custom_puck_ethereal_jaunt:OnSpellStart()
local caster = self:GetCaster()
local orb_ability = caster:FindAbilityByName("custom_puck_illusory_orb")

if caster:IsRooted() or caster:IsLeashed() then return end

if orb_ability then
  orb_ability:Teleport()
end

if #orb_ability.orbs == 0 then 
  self:SetActivated(false)
end

if caster:HasTalent("modifier_puck_orb_5") then 
  caster:AddNewModifier(caster, orb_ability, "modifier_puck_coil_orb_custom_status", {duration = caster:GetTalentValue("modifier_puck_orb_5", "duration")})
end

if caster:HasTalent("modifier_puck_orb_2") then 
  caster:AddNewModifier(caster, orb_ability, "modifier_puck_coil_orb_heal", {duration = caster:GetTalentValue("modifier_puck_orb_2", "duration")})
end

if caster:GetName() == "npc_dota_hero_puck"  then
  caster:EmitSound("puck_puck_ability_orb_0"..RandomInt(1, 3))
end

end






custom_puck_illusory_barrier = class({})

function custom_puck_illusory_barrier:GetVectorTargetRange()
return self:GetSpecialValueFor("radius")
end

function custom_puck_illusory_barrier:OnVectorCastStart(vStartLocation, vDirection)
local caster = self:GetCaster()
local target = self:GetCursorPosition() 

if target == caster:GetAbsOrigin() then 
  target = caster:GetAbsOrigin() + caster:GetForwardVector()*30
  return
end

local pos1 = self:GetVectorPosition() + RotatePosition(Vector(), QAngle(0, 90 ,0), vDirection*(self:GetVectorTargetRange()/2)) 
local pos2 = self:GetVectorPosition() + RotatePosition(Vector(), QAngle(0,-90,0), vDirection*(self:GetVectorTargetRange()/2)) 

local thiker = CreateModifierThinker(caster, self, "modifier_puck_coil_wall_thinker",
{
  duration = caster:GetTalentValue("modifier_puck_orb_7", "duration"),
  pos1x = pos1.x,
  pos1y = pos1.y,
  pos1z = pos1.z,
  pos2x = pos2.x,
  pos2y = pos2.y,
  pos2z = pos2.z,
  vDirectionX = vDirection.x,
  vDirectionY = vDirection.y,
  vDirectionZ = vDirection.z
}, target, caster:GetTeamNumber(), false)
end






modifier_puck_coil_orb_tracker = class({})
function modifier_puck_coil_orb_tracker:IsHidden() return true end
function modifier_puck_coil_orb_tracker:IsPurgable() return false end
function modifier_puck_coil_orb_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_HEALTH_BONUS,
}
end


function modifier_puck_coil_orb_tracker:OnCreated()

self.parent = self:GetParent()
self.parent:AddAttackStartEvent_out(self)

self.ability = self:GetAbility()

self.stack_duration = self.parent:GetTalentValue("modifier_puck_orb_4", "duration", true)

self.resist_radius = self.parent:GetTalentValue("modifier_puck_orb_1", "radius", true)
self.resist_duration = self.parent:GetTalentValue("modifier_puck_orb_1", "duration", true)

self.stack_max = self.parent:GetTalentValue("modifier_puck_orb_4", "max", true)
self.parent:AddAttackEvent_out(self)

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_puck_coil_orb_tracker:PuckAttackProc()
if not IsServer() then return end

if self.parent:HasTalent("modifier_puck_orb_4") or self.parent:HasTalent("modifier_puck_orb_6") then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_puck_coil_orb_damage", {duration = self.stack_duration})
end

end


function modifier_puck_coil_orb_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

self:PuckAttackProc()
end

function modifier_puck_coil_orb_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_puck_orb_1") then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

params.target:GenericParticle("particles/puck/orb_cleave.vpcf")

for _,target in pairs(self.parent:FindTargets(self.resist_radius, params.target:GetAbsOrigin())) do 
  target:AddNewModifier(self.parent, self.ability, "modifier_puck_coil_orb_custom_resist", {duration = self.resist_duration})
end

end

function modifier_puck_coil_orb_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_puck_orb_1") then return end 
return self.parent:GetTalentValue("modifier_puck_orb_1", "range")
end 

function modifier_puck_coil_orb_tracker:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_puck_orb_3") then return end 
return self.parent:GetTalentValue("modifier_puck_orb_3", "move")
end 

function modifier_puck_coil_orb_tracker:GetModifierHealthBonus()
if not self.parent:HasTalent("modifier_puck_orb_2") then return end 
return self.parent:GetTalentValue("modifier_puck_orb_2", "health")*self.parent:GetIntellect(false)
end 


function modifier_puck_coil_orb_tracker:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_puck_orb_4") and not self.parent:HasTalent("modifier_puck_orb_6") then return end
self:UpdateJs()
end

function modifier_puck_coil_orb_tracker:UpdateJs()
local mod = self.parent:FindModifierByName("modifier_puck_coil_orb_damage")
local stack = 0
if mod then
  stack = mod:GetStackCount()
end

self.parent:UpdateUIlong({max = self.stack_max, stack = stack, style = "PuckOrb"})
end







modifier_puck_coil_orb_custom_resist = class({})
function modifier_puck_coil_orb_custom_resist:IsHidden() return false end
function modifier_puck_coil_orb_custom_resist:IsPurgable() return false end
function modifier_puck_coil_orb_custom_resist:GetTexture() return "buffs/arc_speed" end
function modifier_puck_coil_orb_custom_resist:OnCreated()
self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_puck_orb_1", "max")
self.resist = self.caster:GetTalentValue("modifier_puck_orb_1", "resist")
self:SetStackCount(1)
end

function modifier_puck_coil_orb_custom_resist:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end


function modifier_puck_coil_orb_custom_resist:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_puck_coil_orb_custom_resist:GetModifierMagicalResistanceBonus()
return self.resist*self:GetStackCount()
end






modifier_puck_coil_orb_thinker = class({})
function modifier_puck_coil_orb_thinker:IsHidden() return true end
function modifier_puck_coil_orb_thinker:IsPurgable() return false end
function modifier_puck_coil_orb_thinker:CheckState()
return 
{
  [MODIFIER_STATE_INVULNERABLE]   = true,
  [MODIFIER_STATE_OUT_OF_GAME]  = true,
  [MODIFIER_STATE_UNSELECTABLE] = true
}
end

function modifier_puck_coil_orb_thinker:OnCreated(table)
if not IsServer() then return end
self:GetParent().cd = 1
self:StartIntervalThink(0.1)
end

function modifier_puck_coil_orb_thinker:OnIntervalThink()
if not IsServer() then return end
self:GetParent().cd = 0
end




modifier_puck_coil_wall_thinker = class({})
function modifier_puck_coil_wall_thinker:IsHidden() return true end
function modifier_puck_coil_wall_thinker:IsPurgable() return false end
function modifier_puck_coil_wall_thinker:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

self.pos1 = Vector(table.pos1x, table.pos1y, table.pos1z)
self.pos2 = Vector(table.pos2x, table.pos2y, table.pos2z)

self.parent:EmitSound("Puck.Orb_wall")
self.caster_abs = self:GetCaster():GetAbsOrigin()

self.vector = (self.pos2 - self.pos1):Normalized()
self.ability = self:GetCaster():FindAbilityByName("custom_puck_illusory_orb")

self.wall = ParticleManager:CreateParticle("particles/duel_wall.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.wall, 0, self.pos1)
ParticleManager:SetParticleControl(self.wall, 1, self.pos2)
self:AddParticle(self.wall, false, false, -1, false, false)
self:StartIntervalThink(FrameTime())
end

function modifier_puck_coil_wall_thinker:OnIntervalThink()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

local thinkers = FindUnitsInLine(self.parent:GetTeamNumber(), self.pos1, self.pos2, nil, 30, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL ,DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD)

for _,thinker in pairs(thinkers) do
  if thinker ~= self.parent and thinker:HasModifier("modifier_puck_coil_orb_thinker") and thinker.cd ~= 1 and not thinker.Destroyed then 
  
    local location = thinker:GetAbsOrigin()
    local r_vector = thinker.vector
    local dir1 = RotatePosition(Vector(), QAngle(0,90,0), self.vector) 
    local dir2 = RotatePosition(Vector(), QAngle(0,-90,0), self.vector) 
    local a1 = GetAngle(r_vector.x , r_vector.y , dir1.x , dir1.y)
    local a2 = GetAngle(r_vector.x , r_vector.y , dir2.x , dir2.y)
    local dir = a1 < a2 and dir1 or dir2
    local a = a1 < a2 and a1 or a2
    local rat = math.atan2( r_vector.y, r_vector.x )
    local dat = math.atan2( dir.y, dir.x )
    local l = rat < dat 

    if math.deg(math.abs(rat - dat)) > 180 then 
      l = not l
    end

    local k = 1
    if not l then 
      k = -1
    end

    if (math.abs(a) > 80 and math.abs(a) <= 90) then return end

    local target = RotatePosition(Vector() , QAngle(0, a*k , 0), dir ) + location

    thinker:GenericParticle("particles/units/heroes/hero_puck/puck_illusory_orb_blink_out.vpcf")
    thinker:StopSound("Hero_Puck.Illusory_Orb")

    local bonus_stack = 0
    if thinker.bonus_stack then 
      bonus_stack = thinker.bonus_stack
    end

    for id, orb in pairs(self.ability.orbs) do
      if thinker:entindex() == orb then
        ProjectileManager:DestroyLinearProjectile(self.ability.orbs_effect[id])
        thinker.Destroyed = true 
        table.remove(self.ability.orbs, id)
        table.remove(self.ability.orbs_effect, id)
        thinker:Destroy()
        break
      end
    end

    local caster = self:GetCaster()
    local ability = self.ability

    Timers:CreateTimer(FrameTime(), function()
      ability:StartOrb(target, location, 1, bonus_stack)
    end)

    self:Destroy()
    break
  end
end

end

function modifier_puck_coil_wall_thinker:OnDestroy()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

UTIL_Remove(self.parent)
end



modifier_puck_coil_orb_slow = class({})
function modifier_puck_coil_orb_slow:IsHidden() return true end
function modifier_puck_coil_orb_slow:IsPurgable() return true end
function modifier_puck_coil_orb_slow:GetTexture() return "buffs/orb_slow" end
function modifier_puck_coil_orb_slow:GetEffectName() return "particles/puck_orb_slow.vpcf" end
function modifier_puck_coil_orb_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_puck_coil_orb_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_puck_orb_6", "slow")
end
function modifier_puck_coil_orb_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_puck_coil_orb_custom_status = class({})
function modifier_puck_coil_orb_custom_status:IsHidden() return false end
function modifier_puck_coil_orb_custom_status:IsPurgable() return false end
function modifier_puck_coil_orb_custom_status:GetTexture() return "buffs/surge_heal" end
function modifier_puck_coil_orb_custom_status:GetEffectName() return "particles/puck/orb_status.vpcf" end


function modifier_puck_coil_orb_custom_status:OnCreated()
self.parent = self:GetParent()

self.status = self.parent:GetTalentValue("modifier_puck_orb_5", "status")
self.damage_reduce = self.parent:GetTalentValue("modifier_puck_orb_5", "damage_reduce")
end

function modifier_puck_coil_orb_custom_status:DeclareFunctions()
return
{

  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_puck_coil_orb_custom_status:GetModifierStatusResistanceStacking() 
return self.status
end

function modifier_puck_coil_orb_custom_status:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end






modifier_puck_coil_orb_damage = class({})
function modifier_puck_coil_orb_damage:IsHidden() return false end
function modifier_puck_coil_orb_damage:IsPurgable() return false end
function modifier_puck_coil_orb_damage:GetTexture() return "buffs/orb_damage" end
function modifier_puck_coil_orb_damage:OnCreated(table)
self.caster = self:GetCaster()

self.max = self.caster:GetTalentValue("modifier_puck_orb_4", "max", true)

if not IsServer() then return end
self.RemoveForDuel = true 
self:SetStackCount(1)  
end

function modifier_puck_coil_orb_damage:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
  self.caster:EmitSound("Puck.Orb_stack_max")
  self.caster:GenericParticle("particles/puck/orb_stack_max.vpcf", self)
end

end

function modifier_puck_coil_orb_damage:OnStackCountChanged()
if not IsServer() then return end

local mod = self.caster:FindModifierByName("modifier_puck_coil_orb_tracker")
if mod then 
  mod:UpdateJs()
end

end

function modifier_puck_coil_orb_damage:OnDestroy()
if not IsServer() then return end
self:OnStackCountChanged()
end



modifier_puck_coil_orb_heal = class({})
function modifier_puck_coil_orb_heal:IsHidden() return false end
function modifier_puck_coil_orb_heal:IsPurgable() return true end
function modifier_puck_coil_orb_heal:GetTexture() return "buffs/jump_heal" end
function modifier_puck_coil_orb_heal:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.heal = self.parent:GetTalentValue("modifier_puck_orb_2", "heal") /self:GetRemainingTime()
if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_puck_coil_orb_heal:OnIntervalThink()
if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_lifesteal.vpcf")
self.parent:SendNumber(10, self.heal*self.parent:GetMaxHealth()/100)
end

function modifier_puck_coil_orb_heal:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_puck_coil_orb_heal:GetModifierHealthRegenPercentage()
return self.heal
end

function modifier_puck_coil_orb_heal:GetEffectName() return "particles/zuus_heal.vpcf" end
function modifier_puck_coil_orb_heal:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end







modifier_puck_coil_orb_custom_steal_jump = class({})
function modifier_puck_coil_orb_custom_steal_jump:IsHidden() return true end
function modifier_puck_coil_orb_custom_steal_jump:IsPurgable() return false end
function modifier_puck_coil_orb_custom_steal_jump:RemoveOnDeath() return false end
function modifier_puck_coil_orb_custom_steal_jump:OnCreated()


end

function modifier_puck_coil_orb_custom_steal_jump:OnDestroy()
if not IsServer() then return end
self:GetAbility():StartCd()
end