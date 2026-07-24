--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_snapfire_lil_shredder_custom", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_debuff", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_tracker", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_armor", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_silence_cd", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_legendary_spell", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_legendary_spell", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_lil_shredder_custom_slow", "abilities/snapfire/snapfire_lil_shredder_custom", LUA_MODIFIER_MOTION_NONE )



snapfire_lil_shredder_custom = class({})



function snapfire_lil_shredder_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items4_fx/ascetic_cap.vpcf", context ) 
PrecacheResource( "particle","particles/beast_ult_count.vpcf", context )
PrecacheResource( "particle","particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_shells_projectile.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_shells_buff.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/medallion_of_courage_b.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/black_powder_bag.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_silenced.vpcf", context )
PrecacheResource( "particle","particles/bristleback/armor_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )

end






function snapfire_lil_shredder_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_snapfire_lil_shredder_custom_tracker"
end


function snapfire_lil_shredder_custom:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_snapfire_shredder_2") then 
  bonus = self:GetCaster():GetTalentValue("modifier_snapfire_shredder_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end


function snapfire_lil_shredder_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetDuration()

if caster:HasTalent("modifier_snapfire_shredder_7") then
  duration = caster:GetTalentValue("modifier_snapfire_shredder_7", "effect_duration")
end

caster:RemoveModifierByName("modifier_snapfire_lil_shredder_custom_legendary_spell")

if caster:HasTalent("modifier_snapfire_shredder_5") then 
  caster:Purge(false, true, false, false, false)
  caster:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
end

caster:AddNewModifier( caster,   self, "modifier_snapfire_lil_shredder_custom", { duration = duration } )
end




modifier_snapfire_lil_shredder_custom = class({})
function modifier_snapfire_lil_shredder_custom:IsHidden() return false end
function modifier_snapfire_lil_shredder_custom:IsPurgable() return false end
function modifier_snapfire_lil_shredder_custom:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddRecordDestroyEvent(self)
self.parent:AddAttackStartEvent_out(self)

self.attacks = self.ability:GetSpecialValueFor( "buffed_attacks" )
self.as_bonus = self.ability:GetSpecialValueFor( "attack_speed_bonus" )
self.range_bonus = self.ability:GetSpecialValueFor( "attack_range_bonus" )
self.bat = self.ability:GetSpecialValueFor( "base_attack_time" )
self.attack_damage = self.ability:GetSpecialValueFor("attack_damage") + self.parent:GetTalentValue("modifier_snapfire_shredder_1", "damage")
self.base_damage = self.ability:GetSpecialValueFor("damage")

self.aoe_attacks = self.ability:GetSpecialValueFor("aoe_attacks")
self.duration = self.ability:GetSpecialValueFor( "armor_duration" )

if not IsServer() then return end

self.scatter_ability = self.parent:FindAbilityByName("snapfire_scatterblast_custom")
self.scatter_count = 0

self.overheat = 0

self.heal_base = self.parent:GetTalentValue("modifier_snapfire_shredder_5", "heal", true)/100
self.heal_bonus = self.parent:GetTalentValue("modifier_snapfire_shredder_5", "bonus", true)
self.heal_health = self.parent:GetTalentValue("modifier_snapfire_shredder_5","health", true)

self.slow_duration = self.parent:GetTalentValue("modifier_snapfire_shredder_2", "duration", true)

self.silence = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "silence", true)
self.silence_cd = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "cd", true)
self.max_dist = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "knock_max", true)
self.min_dist = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "knock_min", true)
self.knock_duration = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "knock_duration", true)
self.range_max = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "dist_max", true)

if not self.parent:HasTalent("modifier_snapfire_shredder_7") then 
  self:SetStackCount( self.attacks )
else
  self.particle = self.parent:GenericParticle("particles/beast_ult_count.vpcf", self, true)

  self.max = self.parent:GetTalentValue("modifier_snapfire_shredder_7", "max")
  self.decay = self.parent:GetTalentValue("modifier_snapfire_shredder_7", "decay")
  self.stun = self.parent:GetTalentValue("modifier_snapfire_shredder_7", "stun")
  self.attack = self.parent:GetTalentValue("modifier_snapfire_shredder_7", "attack")

  self:StartIntervalThink(0.1)
  self:UpdateEffect()
end
self.RemoveForDuel = true
self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3)
self.records = {}

self.ability:EndCd()
self.parent:EmitSound("Hero_Snapfire.ExplosiveShells.Cast")

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_snapfire/hero_snapfire_shells_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( effect_cast, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_vent_01_fx", Vector(0,0,0),  true )
ParticleManager:SetParticleControlEnt( effect_cast, 4, self.parent, PATTACH_POINT_FOLLOW, "attach_vent_02_fx", Vector(0,0,0),  true  )
ParticleManager:SetParticleControlEnt( effect_cast, 5,  self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc",  Vector(0,0,0), true  )
self:AddParticle( effect_cast, false,  false,  -1, false, false )
end


function modifier_snapfire_lil_shredder_custom:OnIntervalThink()
if not IsServer() then return end

self.overheat = (math.max(0, self.overheat - self.decay*0.1))
self:UpdateEffect()
  
if self.overheat >= self.max then 
  self.parent:EmitSound("Troll.Fervor_legendary_stun")
  self.parent:EmitSound("Snapfire.Shredder_stun")
  local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
  ParticleManager:SetParticleControl( effect_cast, 0,  self.parent:GetOrigin() )
  ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
  ParticleManager:ReleaseParticleIndex(effect_cast)

  self.parent:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = ( 1 - self.parent:GetStatusResistance())*self.stun})
  self:Destroy()
end

end


function modifier_snapfire_lil_shredder_custom:UpdateEffect()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_shredder_7") then return end

self.parent:UpdateUIshort({max_time = self.max, active = self.overheat >= 60, time = self.overheat, stack_icon = self:GetRemainingTime(), stack_icon_zero = 1, style = "SnapfireLil"})

if not self.particle then return end

local count = math.floor(self.overheat/20)

for i = 1,5 do 
  if i <= count then 
    ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0)) 
  else 
    ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0)) 
  end
end

end


function modifier_snapfire_lil_shredder_custom:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()

if self.spell_mod and not self.spell_mod:IsNull() then
  self.spell_mod:SetDuration(self.parent:GetTalentValue("modifier_snapfire_shredder_7", "duration", true), true)
end

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_3)
self.parent:StopSound("Hero_Snapfire.ExplosiveShells.Cast")

if not self.parent:HasTalent("modifier_snapfire_shredder_7") then return end
self.parent:UpdateUIshort({hide = 1, style = "SnapfireLil"})
end

function modifier_snapfire_lil_shredder_custom:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
  MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
}
end

function modifier_snapfire_lil_shredder_custom:GetModifierFixedAttackRate()
if self.parent:HasModifier("modifier_tower_incoming_speed") then return end
if not self.parent:HasTalent("modifier_snapfire_shredder_7") then return end
return 0.23
end

function modifier_snapfire_lil_shredder_custom:GetActivityTranslationModifiers()
return "explosive_shells"
end

function modifier_snapfire_lil_shredder_custom:AttackStartEvent_out( params )
if params.attacker~=self.parent then return end
if not self:HaveBonus() then return end

self.records[params.record] = true
  
self.parent:EmitSound("Hero_Snapfire.ExplosiveShellsBuff.Attack")

local projectile =
{
  Target = params.target,
  Source = self.parent,
  Ability = self.ability,
  EffectName = "particles/units/heroes/hero_snapfire/hero_snapfire_shells_projectile.vpcf",
  iMoveSpeed = self.parent:GetProjectileSpeed(),
  vSourceLoc = self.parent:GetAbsOrigin(),
  bDodgeable = true,
  bProvidesVision = false,
}

local hProjectile = ProjectileManager:CreateTrackingProjectile( projectile )

if params.no_attack_cooldown then return end

if self.scatter_ability and self.scatter_ability:IsTrained() then 
  self.scatter_count = self.scatter_count + 1
  if self.scatter_count >= self.parent:GetTalentValue("modifier_snapfire_scatter_7", "count", true) then 
    self.scatter_count = 0

    if self.parent:HasTalent("modifier_snapfire_scatter_7") then
      self.scatter_ability:OnSpellStart(self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*10, 1)
    end

    if self.parent:HasTalent("modifier_snapfire_scatter_6") then
      self.parent:CdItems(self.parent:GetTalentValue("modifier_snapfire_scatter_6", "cd_items"))
    end
  end
end

if self.parent:HasTalent("modifier_snapfire_shredder_7") then 
  self.overheat = self.overheat + self.attack
  self:UpdateEffect()
end

if self.parent:HasTalent("modifier_snapfire_shredder_4") or self.parent:HasTalent("modifier_snapfire_shredder_7") then 
  self.spell_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_lil_shredder_custom_legendary_spell", {})
end

if self.parent:HasTalent("modifier_snapfire_shredder_5") then 
  local heal = self.parent:GetMaxHealth()*self.heal_base
  local number = true
  if self.parent:GetHealthPercent() <= self.heal_health then
    heal = heal*self.heal_bonus
    number = false
  end
  self.parent:GenericHeal(heal, self.ability, number, nil, "modifier_snapfire_shredder_5")
end

if self:GetStackCount()>0 and not self.parent:HasTalent("modifier_snapfire_shredder_7") then
  self:DecrementStackCount()
end

end


function modifier_snapfire_lil_shredder_custom:ProcAttack( params )
if not IsServer() then return end
if self.parent ~= params.attacker then return end
local target = params.target
target:EmitSound("Hero_Snapfire.ExplosiveShellsBuff.Target")

if not self.records[params.record] then return end
target:AddNewModifier( self.parent,  self.ability, "modifier_snapfire_lil_shredder_custom_debuff", { duration = self.duration } )

if self.parent:HasTalent("modifier_snapfire_shredder_2") then
  target:AddNewModifier(self.parent, self.ability,  "modifier_snapfire_lil_shredder_custom_slow", {duration = self.slow_duration})
end

if not self.parent:HasTalent("modifier_snapfire_shredder_6") then return end
if target:HasModifier("modifier_snapfire_lil_shredder_custom_silence_cd") then return end

target:EmitSound("Snapfire.Shredder_silence")
target:AddNewModifier(self.parent, self.ability, "modifier_generic_silence", {duration = (1 - target:GetStatusResistance())*self.silence})
target:AddNewModifier(self.parent, self.ability, "modifier_snapfire_lil_shredder_custom_silence_cd", {duration = self.silence_cd})

local dist = (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()
local dist_k = math.max(0, math.min(1, (1 - dist/self.range_max)))
local knock_dist = self.min_dist + (self.max_dist - self.min_dist)*dist_k

target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_knockback",
{
  should_stun = 0,
  knockback_duration = self.knock_duration,
  duration = self.knock_duration,
  knockback_distance = knock_dist,
  knockback_height = 0,
  center_x = self.parent:GetAbsOrigin().x,
  center_y = self.parent:GetAbsOrigin().y,
  center_z = self.parent:GetAbsOrigin().z,
})

local effect_cast = ParticleManager:CreateParticle( "particles/items3_fx/black_powder_bag.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControl( effect_cast, 0, target:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
ParticleManager:ReleaseParticleIndex(effect_cast)
end



function modifier_snapfire_lil_shredder_custom:RecordDestroyEvent( params )
  if self.records[params.record] then
    self.records[params.record] = nil
    if next(self.records)==nil and not self:HaveBonus() then
      self:Destroy()
    end
  end
end

function modifier_snapfire_lil_shredder_custom:GetModifierOverrideAttackDamage(params)
if not self:HaveBonus() then return end
local k = 1
local mod = self.parent:FindModifierByName("modifier_snapfire_innate_custom")
if mod then
  k = 1 + mod:GetDamage()/100
end
return (self.base_damage + self.attack_damage*self.parent:GetAverageTrueAttackDamage(nil)/100)*k
end

function modifier_snapfire_lil_shredder_custom:GetModifierAttackRangeBonus()
if not self:HaveBonus() then return end
return self.range_bonus
end

function modifier_snapfire_lil_shredder_custom:GetModifierAttackSpeedBonus_Constant()
if not self:HaveBonus() then return end
return self.as_bonus
end

function modifier_snapfire_lil_shredder_custom:GetModifierBaseAttackTimeConstant()
if not self:HaveBonus() then return end
return self.bat
end

function modifier_snapfire_lil_shredder_custom:HaveBonus()
return self:GetStackCount() > 0 or self.parent:HasTalent("modifier_snapfire_shredder_7")
end





modifier_snapfire_lil_shredder_custom_tracker = class({})
function modifier_snapfire_lil_shredder_custom_tracker:IsHidden() return true end
function modifier_snapfire_lil_shredder_custom_tracker:IsPurgable() return false end
function modifier_snapfire_lil_shredder_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_snapfire_lil_shredder_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.range_bonus = self.parent:GetTalentValue("modifier_snapfire_shredder_6", "range", true)

self.armor_duration = self.parent:GetTalentValue("modifier_snapfire_shredder_3", "duration", true)

self.heal_status = self.parent:GetTalentValue("modifier_snapfire_shredder_5", "status", true)
self.status_bonus = self.parent:GetTalentValue("modifier_snapfire_shredder_5", "bonus", true)
self.status_health = self.parent:GetTalentValue("modifier_snapfire_shredder_5", "health", true)

self.parent:AddAttackEvent_out(self)
self.parent:AddSpellEvent(self)

self:StartIntervalThink(1)
end


function modifier_snapfire_lil_shredder_custom_tracker:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_snapfire_lil_shredder_custom")
end

function modifier_snapfire_lil_shredder_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_shredder_5") then return end

if not self.particle and self.parent:GetHealthPercent() <= self.status_health then
  self.particle = self.parent:GenericParticle("particles/items4_fx/ascetic_cap.vpcf", self)
end

if self.particle and self.parent:GetHealthPercent() > self.status_health then
  ParticleManager:DestroyParticle(self.particle, false)
  ParticleManager:ReleaseParticleIndex(self.particle)
  self.particle = nil
end

self:StartIntervalThink(0.2)
end


function modifier_snapfire_lil_shredder_custom_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_snapfire_shredder_6") then return end 
return self.range_bonus
end

function modifier_snapfire_lil_shredder_custom_tracker:GetModifierStatusResistanceStacking()
if not self.parent:HasTalent("modifier_snapfire_shredder_5") then return end 
local bonus = self.heal_status
if self.parent:GetHealthPercent() <= self.status_health then
  bonus = bonus*self.status_bonus
end
return bonus
end

function modifier_snapfire_lil_shredder_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

if self.parent:HasTalent("modifier_snapfire_shredder_3") then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_lil_shredder_custom_armor", {duration = self.armor_duration})
end

local mod = self.parent:FindModifierByName("modifier_snapfire_lil_shredder_custom")
if not mod then return end

mod:ProcAttack(params)
end


function modifier_snapfire_lil_shredder_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_shredder_4") then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end
if params.ability:GetName() == "snapfire_gobble_up_custom" and self.parent:HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble_caster") then return end

local mod = self.parent:FindModifierByName("modifier_snapfire_lil_shredder_custom")
if not mod then return end
local stack = self.parent:GetTalentValue("modifier_snapfire_shredder_4", "attack")

if self.parent:HasTalent("modifier_snapfire_shredder_7") then
  mod:SetDuration(mod:GetRemainingTime() + stack, true)
else
  mod:SetStackCount(mod:GetStackCount() + stack)
end

end




modifier_snapfire_lil_shredder_custom_debuff = class({})
function modifier_snapfire_lil_shredder_custom_debuff:IsHidden() return false end
function modifier_snapfire_lil_shredder_custom_debuff:IsPurgable() return false end
function modifier_snapfire_lil_shredder_custom_debuff:OnCreated( kv )
self.armor = -self:GetAbility():GetSpecialValueFor( "armor_reduction_per_attack" )
self.max_timer = self:GetRemainingTime()
if not IsServer() then return end
self:AddStack()
end

function modifier_snapfire_lil_shredder_custom_debuff:OnRefresh( kv )
if not IsServer() then return end
self:AddStack()
end

function modifier_snapfire_lil_shredder_custom_debuff:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_snapfire_lil_shredder_custom_debuff:GetModifierPhysicalArmorBonus()
return self.armor * self:GetStackCount()
end

function modifier_snapfire_lil_shredder_custom_debuff:AddStack()
if not IsServer() then return end

Timers:CreateTimer(self.max_timer, function() 
  if self and not self:IsNull() then 
    self:DecrementStackCount()
    if self:GetStackCount() <= 0 then 
      self:Destroy()
    end 
  end 
end)

self:IncrementStackCount()
end 




modifier_snapfire_lil_shredder_custom_armor = class({})
function modifier_snapfire_lil_shredder_custom_armor:IsHidden() return false end
function modifier_snapfire_lil_shredder_custom_armor:IsPurgable() return false end
function modifier_snapfire_lil_shredder_custom_armor:GetTexture() return "buffs/shredder_armor" end
function modifier_snapfire_lil_shredder_custom_armor:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_snapfire_shredder_3", "max", true)
self.armor = self.parent:GetTalentValue("modifier_snapfire_shredder_3", "armor")/self.max
self.move = self.parent:GetTalentValue("modifier_snapfire_shredder_3", "move")/self.max

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_snapfire_lil_shredder_custom_armor:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:EmitSound("Snapfire.Lil_armor")
  self.parent:GenericParticle("particles/bristleback/armor_buff.vpcf", self)
end

end

function modifier_snapfire_lil_shredder_custom_armor:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_snapfire_lil_shredder_custom_armor:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.armor
end

function modifier_snapfire_lil_shredder_custom_armor:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.move 
end




modifier_snapfire_lil_shredder_custom_silence_cd = class({})
function modifier_snapfire_lil_shredder_custom_silence_cd:IsHidden() return true end
function modifier_snapfire_lil_shredder_custom_silence_cd:IsPurgable() return false end



modifier_snapfire_lil_shredder_custom_legendary_spell = class({})
function modifier_snapfire_lil_shredder_custom_legendary_spell:IsHidden() return false end
function modifier_snapfire_lil_shredder_custom_legendary_spell:IsPurgable() return false end
function modifier_snapfire_lil_shredder_custom_legendary_spell:GetTexture() return "buffs/fireblast_damage" end
function modifier_snapfire_lil_shredder_custom_legendary_spell:OnCreated()
self.parent = self:GetParent()

self.max_str = self.parent:GetTalentValue("modifier_snapfire_shredder_4", "max", true)
self.str = self.parent:GetTalentValue("modifier_snapfire_shredder_4", "str")/self.max_str

self.damage = self.parent:GetTalentValue("modifier_snapfire_shredder_7", "spell", true)
self.max_spell = self.parent:GetTalentValue("modifier_snapfire_shredder_7", "spell_max", true)

self.max = self.max_str
if self.parent:HasTalent("modifier_snapfire_shredder_7") then
  self.max = self.max_spell
end

if not IsServer() then return end
self:SetStackCount(1)
self.parent:CalculateStatBonus(true)
end

function modifier_snapfire_lil_shredder_custom_legendary_spell:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end

function modifier_snapfire_lil_shredder_custom_legendary_spell:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}
end

function modifier_snapfire_lil_shredder_custom_legendary_spell:GetModifierSpellAmplify_Percentage()
if not self.parent:HasTalent("modifier_snapfire_shredder_7") then return end
return self.damage*math.min(self.max_spell, self:GetStackCount())
end

function modifier_snapfire_lil_shredder_custom_legendary_spell:GetModifierBonusStats_Strength()
if not self.parent:HasTalent("modifier_snapfire_shredder_4") then return end
return self.str*math.min(self.max_str, self:GetStackCount())
end



modifier_snapfire_lil_shredder_custom_slow = class({})
function modifier_snapfire_lil_shredder_custom_slow:IsHidden() return true end
function modifier_snapfire_lil_shredder_custom_slow:IsPurgable() return true end
function modifier_snapfire_lil_shredder_custom_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_snapfire_shredder_2", "slow")
end

function modifier_snapfire_lil_shredder_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_snapfire_lil_shredder_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_snapfire_lil_shredder_custom_slow:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_snapfire_lil_shredder_custom_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_snapfire_lil_shredder_custom_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_snapfire_lil_shredder_custom_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end