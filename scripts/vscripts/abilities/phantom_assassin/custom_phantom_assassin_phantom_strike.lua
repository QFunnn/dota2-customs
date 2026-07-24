--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_buff", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_passive", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_slow", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_turn_slow", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_legendary_agility", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_legendary_illusion", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_strike_haste", "abilities/phantom_assassin/custom_phantom_assassin_phantom_strike", LUA_MODIFIER_MOTION_NONE )


  
custom_phantom_assassin_phantom_strike = class({})


function custom_phantom_assassin_phantom_strike:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bladekeeper.vpcf", context )
PrecacheResource( "particle","particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit_blur.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/manta_phase.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context )
PrecacheResource( "particle","particles/pa_blink_buff.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blink_cleave.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blink_speed.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/blink_resist.vpcf", context )

end




function custom_phantom_assassin_phantom_strike:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "phantom_assassin_phantom_strike", self)
end

function custom_phantom_assassin_phantom_strike:GetIntrinsicModifierName() 
return "modifier_phantom_assassin_phantom_strike_passive" 
end


function custom_phantom_assassin_phantom_strike:GetManaCost(level)
if self:GetCaster():HasTalent("modifier_phantom_assassin_blink_5") then
  return 0
end
return self.BaseClass.GetManaCost(self,level)
end


function custom_phantom_assassin_phantom_strike:GetCastRange(vLocation, hTarget)

if self:GetCaster():HasTalent("modifier_phantom_assassin_blink_6") and not hTarget and IsServer() then 
  return 9999999
end

return self.BaseClass.GetCastRange(self , vLocation , hTarget) + self:RangeBonus() 
end


function custom_phantom_assassin_phantom_strike:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_phantom_assassin_blink_5") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_phantom_assassin_blink_5", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function custom_phantom_assassin_phantom_strike:GetCastPoint()
if self:GetCaster():HasTalent("modifier_phantom_assassin_blink_5") then 
  return 0
end
return self.BaseClass.GetCastPoint(self) 
end


function custom_phantom_assassin_phantom_strike:RangeBonus()
local upgrade = 0
if self:GetCaster():HasTalent("modifier_phantom_assassin_blink_1") then 
  upgrade = self:GetCaster():GetTalentValue("modifier_phantom_assassin_blink_1", "range")
end
return upgrade
end


function custom_phantom_assassin_phantom_strike:GetBehavior()
local aoe = 0
local point = 0
local caster = self:GetCaster()
if caster:HasTalent("modifier_phantom_assassin_blink_4") then 
  aoe = DOTA_ABILITY_BEHAVIOR_AOE
end
if caster:HasTalent("modifier_phantom_assassin_blink_6") then
  point = DOTA_ABILITY_BEHAVIOR_POINT
end
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + aoe + point
end


function custom_phantom_assassin_phantom_strike:GetAOERadius()
if not self:GetCaster():HasTalent("modifier_phantom_assassin_blink_4") then return end 
return self:GetCaster():GetTalentValue("modifier_phantom_assassin_blink_4", "radius")
end


function custom_phantom_assassin_phantom_strike:GetCastAnimation()
if self:GetCaster():HasTalent("modifier_phantom_assassin_blink_5") then
  return 0
end
return ACT_DOTA_CAST_ABILITY_2
end


function custom_phantom_assassin_phantom_strike:CastFilterResultTarget( hTarget )
if self:GetCaster() == hTarget then
  return UF_FAIL_CUSTOM
end
local result = UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, self:GetCaster():GetTeamNumber())

if result ~= UF_SUCCESS then
  return result
end
return UF_SUCCESS
end


function custom_phantom_assassin_phantom_strike:GetCustomCastErrorTarget( hTarget )
if self:GetCaster() == hTarget then
  return "#dota_hud_error_cant_cast_on_self"
end
return ""
end


function custom_phantom_assassin_phantom_strike:ProcDamage(point, unit)
local caster = self:GetCaster()
local targets = caster:FindTargets(caster:GetTalentValue("modifier_phantom_assassin_blink_4", "radius"), point)


if #targets == 0 then return end

EmitSoundOnLocationWithCaster(point, "PA.Blink_proc", caster)

local damage = caster:GetTalentValue("modifier_phantom_assassin_blink_4", "damage")*caster:GetAgility()/100
local heal = damage*caster:GetTalentValue("modifier_phantom_assassin_blink_4", "heal")/100

if unit:IsRealHero() then 
  unit:GenericHeal(heal, self, true, nil, "modifier_phantom_assassin_blink_4")
else 
  damage = 0
end

for _,target in pairs(targets) do

  local particle = ParticleManager:CreateParticle( "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bladekeeper.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target )
  ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
  ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
  ParticleManager:ReleaseParticleIndex(particle)

  local trail_pfx = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit_blur.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
  ParticleManager:SetParticleControl(trail_pfx, 0, caster:GetAbsOrigin())
  ParticleManager:SetParticleControl(trail_pfx, 1, target:GetAbsOrigin())
  ParticleManager:SetParticleControlForward(trail_pfx, 1, ( target:GetAbsOrigin() - unit:GetAbsOrigin()):Normalized())
  ParticleManager:ReleaseParticleIndex(trail_pfx)
  DoDamage( {victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self}, "modifier_phantom_assassin_blink_4" )
end

end





function custom_phantom_assassin_phantom_strike:UseBlink(unit, target, point)
if not IsServer() then return end

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration") + caster:GetTalentValue("modifier_phantom_assassin_blink_2", "duration") 
local blinkPosition = nil
local new_point = nil

if target then 
  if target:GetTeamNumber()~=unit:GetTeamNumber() then
    if target:TriggerSpellAbsorb( self ) then 
      return 
    end
  end


  local blinkDistance = 50
  local blinkDirection = (unit:GetOrigin() - target:GetOrigin()):Normalized() * blinkDistance
  blinkPosition = target:GetOrigin() + blinkDirection
  new_point = target:GetAbsOrigin()

  if caster:HasTalent("modifier_phantom_assassin_blink_5") then 
    blinkPosition = target:GetAbsOrigin() - target:GetForwardVector()*75

    if caster == unit then 
      target:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_strike_turn_slow", {duration = caster:GetTalentValue("modifier_phantom_assassin_blink_5", "duration")})
    end
  end 
else 
  blinkPosition = point
  new_point = point
end

unit:RemoveModifierByName("modifier_phantom_assassin_phantom_strike_buff")
unit:AddNewModifier(unit, self, "modifier_phantom_assassin_phantom_strike_buff", { duration = duration } )

local origin = unit:GetAbsOrigin()

self:PlayEffectsStart(origin)

unit:SetOrigin( blinkPosition )
FindClearSpaceForUnit( unit, blinkPosition, true )

if caster:HasTalent("modifier_phantom_assassin_blink_4") then
  self:ProcDamage(new_point, unit)
end

if unit:HasTalent("modifier_phantom_assassin_blink_6") then
  unit:AddNewModifier(unit, self, "modifier_phantom_assassin_phantom_strike_haste", {duration = caster:GetTalentValue("modifier_phantom_assassin_blink_6", "duration")})
end
unit:MoveToPositionAggressive(unit:GetAbsOrigin())
self:PlayEffectsEnd(unit)
end


function custom_phantom_assassin_phantom_strike:PlayEffectsStart(origin )
local caster = self:GetCaster()
local particle_cast_start = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf", self)

local effect_cast_start = ParticleManager:CreateParticle( particle_cast_start, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast_start, 0, origin )
ParticleManager:ReleaseParticleIndex( effect_cast_start )

EmitSoundOnLocationWithCaster( origin, "Hero_PhantomAssassin.Strike.Start", caster )
end


function custom_phantom_assassin_phantom_strike:PlayEffectsEnd(unit)
local caster = self:GetCaster()
local particle_cast_end = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf", self)

local effect_cast_end = ParticleManager:CreateParticle( particle_cast_end, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast_end, 0, unit:GetOrigin() )
ParticleManager:ReleaseParticleIndex( effect_cast_end )

EmitSoundOnLocationWithCaster( unit:GetAbsOrigin(), "Hero_PhantomAssassin.Strike.End", caster )
end





function custom_phantom_assassin_phantom_strike:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local point = nil

if not target and caster:HasTalent("modifier_phantom_assassin_blink_6") then 
  point = self:GetCursorPosition()
  if point == caster:GetAbsOrigin() then 
    point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
  end

  local vec = point - caster:GetAbsOrigin()
  local range = (caster:GetCastRangeBonus() + self:RangeBonus() + self:GetSpecialValueFor("AbilityCastRange")) * (caster:GetTalentValue("modifier_phantom_assassin_blink_6", "range")/100)

  if vec:Length2D() > range then 
    point = caster:GetAbsOrigin() + range*vec:Normalized()
  end
end

self:UseBlink(caster, target, point)
end








modifier_phantom_assassin_phantom_strike_passive = class({})
function modifier_phantom_assassin_phantom_strike_passive:IsHidden() return true end
function modifier_phantom_assassin_phantom_strike_passive:IsPurgable() return false end


function modifier_phantom_assassin_phantom_strike_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.cleave = self.ability:GetSpecialValueFor("cleave_damage")/100

self.slow_duration = self:GetCaster():GetTalentValue("modifier_phantom_assassin_blink_1", "duration", true)

self.legendary_radius = self.parent:GetTalentValue("modifier_phantom_assassin_blink_7", "radius", true)
self.legendary_damage = self.parent:GetTalentValue("modifier_phantom_assassin_blink_7", "damage", true)
self.legendary_incoming = self.parent:GetTalentValue("modifier_phantom_assassin_blink_7", "incoming", true)
self.legendary_duration = self.parent:GetTalentValue("modifier_phantom_assassin_blink_7", "duration", true)
self.legendary_duration_creeps = self.parent:GetTalentValue("modifier_phantom_assassin_blink_7", "agi_duration_creeps", true)
self.legendary_duration_heroes = self.parent:GetTalentValue("modifier_phantom_assassin_blink_7", "agi_duration_heroes", true)

self.proc_max = self.parent:GetTalentValue("modifier_phantom_assassin_blink_4", "max", true)

self.parent:AddAttackEvent_out(self)
self.parent:AddSpellEvent(self)

end 



function modifier_phantom_assassin_phantom_strike_passive:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end


function modifier_phantom_assassin_phantom_strike_passive:GetModifierHealthBonus()
if not self.parent:HasTalent("modifier_phantom_assassin_blink_3") then return end 
return self.parent:GetAgility()*self.parent:GetTalentValue("modifier_phantom_assassin_blink_3", "health")
end


function modifier_phantom_assassin_phantom_strike_passive:AttackEvent_out(params)
if not IsServer() then return end
if not params.target:IsUnit() then return end
local attacker = params.attacker

if attacker:HasModifier("modifier_phantom_assassin_phantom_strike_legendary_illusion") then 
  local duration = self.legendary_duration_heroes
  if params.target:IsCreep() then 
    duration = self.legendary_duration_creeps
  end
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_strike_legendary_agility", {duration = duration})
end


local mod = attacker:FindModifierByName("modifier_phantom_assassin_phantom_strike_buff")

if mod and self.parent:HasTalent("modifier_phantom_assassin_blink_1") then 
  params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_strike_slow", {duration = self.slow_duration})
end

if self.parent ~= attacker then return end
if not mod then return end 

if self.parent:HasTalent("modifier_phantom_assassin_blink_4") and mod.proc_count < self.proc_max then 
  mod.proc_count = mod.proc_count + 1
  if mod.proc_count >= self.proc_max then 
    self.ability:ProcDamage(params.target:GetAbsOrigin(), self.parent)
  end
end

params.target:EmitSound("Hero_Sven.GreatCleave")
DoCleaveAttack( self.parent, params.target, self.ability, self.cleave*params.damage, 150, 360, 500, "particles/phantom_assassin/blink_cleave.vpcf" )
end



function modifier_phantom_assassin_phantom_strike_passive:SpellEvent(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_blink_7") then return end
if params.unit ~= self.parent then return end
if params.ability:IsItem() then return end

local is_dagger = params.ability:GetName() == "custom_phantom_assassin_stifling_dagger"

local target = nil
local cursor_target = params.target

if is_dagger or (params.ability == self.ability and cursor_target and cursor_target:GetTeamNumber() ~= self.parent:GetTeamNumber() ) then 
  target = cursor_target
else 
  target = self.parent:RandomTarget(self.legendary_radius + self.ability:RangeBonus()) 
end

if not target then return end

if is_dagger then 
  self.delay_target = target
  self:StartIntervalThink(0.4)
else 
  self:LegendaryProc(target)
end

end




function modifier_phantom_assassin_phantom_strike_passive:LegendaryProc(target)
if not IsServer() then return end 

local illusions = CreateIllusions( self.parent, self.parent, {Duration = self.legendary_duration, outgoing_damage = self.legendary_damage - 100 ,incoming_damage = self.legendary_incoming - 100}, 1, 1, false, true )
for _,illusion in pairs(illusions) do

  illusion:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_strike_legendary_illusion", {target = target:entindex()})

  illusion.owner = self.parent
  self.ability:UseBlink(illusion, target)

  for _,mod in pairs(self.parent:FindAllModifiers()) do
    if mod.StackOnIllusion ~= nil and mod.StackOnIllusion == true then
        illusion:UpgradeIllusion(mod:GetName(), mod:GetStackCount() )
    end
  end
end

end




function modifier_phantom_assassin_phantom_strike_passive:OnIntervalThink()
if not IsServer() then return end 

if self.delay_target and not self.delay_target:IsNull() then
  self:LegendaryProc(self.delay_target)
end

self:StartIntervalThink(-1)
end






modifier_phantom_assassin_phantom_strike_legendary_illusion = class({})
function modifier_phantom_assassin_phantom_strike_legendary_illusion:IsHidden() return true end
function modifier_phantom_assassin_phantom_strike_legendary_illusion:IsPurgable() return false end
function modifier_phantom_assassin_phantom_strike_legendary_illusion:CheckState()
return
{
  [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
}
end

function modifier_phantom_assassin_phantom_strike_legendary_illusion:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()

self.target = EntIndexToHScript(table.target)
self.parent:SetForceAttackTarget(self.target)

self:StartIntervalThink(FrameTime())
end


function modifier_phantom_assassin_phantom_strike_legendary_illusion:OnIntervalThink()
if not IsServer() then return end 

if not self.target or self.target:IsNull() or not self.target:IsAlive() then 
  self.parent:SetForceAttackTarget(nil)
  self:StartIntervalThink(-1)
end

end




modifier_phantom_assassin_phantom_strike_buff = class({})
function modifier_phantom_assassin_phantom_strike_buff:IsHidden() return false end
function modifier_phantom_assassin_phantom_strike_buff:IsPurgable() return true end
function modifier_phantom_assassin_phantom_strike_buff:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
  MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS
}
end


function modifier_phantom_assassin_phantom_strike_buff:GetModifierIncomingSpellDamageConstant(params)
if not self.parent:HasTalent("modifier_phantom_assassin_blink_3") then return end

if IsClient() then 
  if params.report_max then 
    return self.max_shield 
  else 
    return self:GetStackCount()
  end 
end

if not IsServer() then return end
if self:GetStackCount() <= 0 then return end
local incoming = params.damage
if self.parent:HasModifier("modifier_phantom_assassin_phantom_strike_legendary_illusion") and self.parent.owner then 
  incoming = incoming * self.parent.owner:GetTalentValue("modifier_phantom_assassin_blink_7", "incoming")/100
end

local damage = math.min(incoming, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)

return -damage
end


function modifier_phantom_assassin_phantom_strike_buff:GetActivityTranslationModifiers()
return "phantom_attack"
end

function modifier_phantom_assassin_phantom_strike_buff:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_phantom_assassin_phantom_strike_buff:GetModifierBonusStats_Agility()
return self.agi
end

function modifier_phantom_assassin_phantom_strike_buff:OnCreated(table)
self.proc_count = 0
self.parent = self:GetParent()

self.shield_talent = "modifier_phantom_assassin_blink_3"
self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
self.max_shield = self.parent:GetTalentValue("modifier_phantom_assassin_blink_3", "shield")
self.agi = self.parent:GetTalentValue("modifier_phantom_assassin_blink_2", "agi")

if not IsServer() then return end 

self.parent:CalculateStatBonus(true)
self:SetStackCount(self.max_shield)
end




modifier_phantom_assassin_phantom_strike_slow = class({})
function modifier_phantom_assassin_phantom_strike_slow:IsHidden() return true end
function modifier_phantom_assassin_phantom_strike_slow:IsPurgable() return true end
function modifier_phantom_assassin_phantom_strike_slow:GetEffectName()
return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end

function modifier_phantom_assassin_phantom_strike_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_phantom_assassin_phantom_strike_slow:OnCreated(table)
self.move = self:GetCaster():GetTalentValue("modifier_phantom_assassin_blink_1", "slow")
end

function modifier_phantom_assassin_phantom_strike_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move
end





modifier_phantom_assassin_phantom_strike_turn_slow = class({})
function modifier_phantom_assassin_phantom_strike_turn_slow:IsHidden() return true end
function modifier_phantom_assassin_phantom_strike_turn_slow:IsPurgable() return true end
function modifier_phantom_assassin_phantom_strike_turn_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
}
end


function modifier_phantom_assassin_phantom_strike_turn_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_phantom_assassin_blink_5", "slow")
end

function modifier_phantom_assassin_phantom_strike_turn_slow:GetModifierTurnRate_Percentage()
return self.slow
end




modifier_phantom_assassin_phantom_strike_legendary_agility = class({})
function modifier_phantom_assassin_phantom_strike_legendary_agility:IsHidden() return false end
function modifier_phantom_assassin_phantom_strike_legendary_agility:IsPurgable() return false end
function modifier_phantom_assassin_phantom_strike_legendary_agility:GetTexture() return "buffs/Blade_dance_speed" end
function modifier_phantom_assassin_phantom_strike_legendary_agility:OnCreated(table)

self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.caster:GetTalentValue("modifier_phantom_assassin_blink_7", "max")
self.agi = (self.caster:GetTalentValue("modifier_phantom_assassin_blink_7", "agi")/self.max)/100

if not IsServer() then return end
self:SetStackCount(1)
self.RemoveForDuel = true
self.caster:AddPercentStat({agi = self.agi*self:GetStackCount()}, self)
end


function modifier_phantom_assassin_phantom_strike_legendary_agility:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
self.caster:AddPercentStat({agi = self.agi*self:GetStackCount()}, self)
end


function modifier_phantom_assassin_phantom_strike_legendary_agility:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_phantom_assassin_phantom_strike_legendary_agility:OnTooltip()
return self.agi*self:GetStackCount()*100
end

function modifier_phantom_assassin_phantom_strike_legendary_agility:OnDestroy()
if not IsServer() then return end 
self.caster:CalculateStatBonus(true)
end


modifier_phantom_assassin_phantom_strike_haste = class({})
function modifier_phantom_assassin_phantom_strike_haste:IsHidden() return true end
function modifier_phantom_assassin_phantom_strike_haste:IsPurgable() return false end
function modifier_phantom_assassin_phantom_strike_haste:OnCreated()
self.parent = self:GetParent()
self.move = self.parent:GetTalentValue("modifier_phantom_assassin_blink_6", "move")
if not IsServer() then return end 

self:StartIntervalThink(0.1)
end


function modifier_phantom_assassin_phantom_strike_haste:OnIntervalThink()
if not IsServer() then return end
self.parent:EmitSound("PA.Blink_haste")
self.parent:GenericParticle("particles/phantom_assassin/blink_speed.vpcf", self)
self.parent:GenericParticle("particles/phantom_assassin/blink_resist.vpcf", self)
self:StartIntervalThink(-1)
end

function modifier_phantom_assassin_phantom_strike_haste:CheckState()
return
{
  [MODIFIER_STATE_UNSLOWABLE] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_phantom_assassin_phantom_strike_haste:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_phantom_assassin_phantom_strike_haste:GetModifierMoveSpeedBonus_Percentage()
return self.move
end