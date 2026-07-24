--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bloodseeker_rupture_custom", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_rupture_custom_caster", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_rupture_custom_tracker", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_rupture_custom_legendary", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_rupture_custom_legendary_damage", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_rupture_custom_legendary_knockback", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_bloodseeker_rupture_custom_damage", "abilities/bloodseeker/bloodseeker_rupture_custom", LUA_MODIFIER_MOTION_NONE)

bloodseeker_rupture_custom = class({})
bloodseeker_rupture_custom.talents  = {}

function bloodseeker_rupture_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker_ground.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_rupture.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/bloodrage_stack_main.vpcf", context )
PrecacheResource( "particle", "particles/bs_pull_target.vpcf", context )
PrecacheResource( "particle", "particles/bs_pull.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_charge_mark.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/rupture_duration_overhead.vpcf", context )
PrecacheResource( "particle", "particles/sand_king/sandking_caustic_finale_explode_custom.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/rupture_proc_damage.vpcf", context )
PrecacheResource( "particle", "particles/phantom_assassin/crit_shield.vpcf", context )
PrecacheResource( "particle", "particles/brist_proc.vpcf", context )
end

function bloodseeker_rupture_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true

  self.talents =
  {
    has_damage = 0,
    damage_inc = 0,
    damage_max = caster:GetTalentValue("modifier_bloodseeker_rupture_1", "max", true),

    cd_inc = 0,
    r2_range = 0,

    has_stack = 0,
    heal_reduce = 0,
    stack_damage = 0,
    stack_radius = caster:GetTalentValue("modifier_bloodseeker_rupture_3", "radius", true),
    stack_damage_type = caster:GetTalentValue("modifier_bloodseeker_rupture_3", "damage_type", true),

    has_r4 = 0,
    r4_cdr = caster:GetTalentValue("modifier_bloodseeker_rupture_4", "cdr", true),
    cd_items = caster:GetTalentValue("modifier_bloodseeker_rupture_4", "cd_items", true)/100,
    r4_slow_resist = caster:GetTalentValue("modifier_bloodseeker_rupture_4", "slow_resist", true),

    has_fear = 0,
    cast_inc = caster:GetTalentValue("modifier_bloodseeker_hero_6", "cast", true),
    fear_duration = caster:GetTalentValue("modifier_bloodseeker_hero_6", "fear", true),

    has_legendary = 0,
    legendary_cd = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "talent_cd", true),
    legendary_duration = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "duration", true),
    legendary_damage = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "damage", true),
    legendary_damage_reduce = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "damage_reduce", true),
    legendary_cd_inc = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "cd_inc", true),
    legendary_cd_distance = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "cd_distance", true),
  }
end

if caster:HasTalent("modifier_bloodseeker_rupture_1") then
  self.talents.has_damage = 1
  self.talents.damage_inc = caster:GetTalentValue("modifier_bloodseeker_rupture_1", "damage")/100
end

if caster:HasTalent("modifier_bloodseeker_rupture_2") then
  self.talents.cd_inc = caster:GetTalentValue("modifier_bloodseeker_rupture_2", "cd")
  self.talents.r2_range = caster:GetTalentValue("modifier_bloodseeker_rupture_2", "range")
end

if caster:HasTalent("modifier_bloodseeker_rupture_3") then
  self.talents.has_stack = 1
  self.talents.heal_reduce = caster:GetTalentValue("modifier_bloodseeker_rupture_3", "heal_reduce")
  self.talents.stack_damage = caster:GetTalentValue("modifier_bloodseeker_rupture_3", "damage")/100
end

if caster:HasTalent("modifier_bloodseeker_rupture_4") then
  self.talents.has_r4 = 1
end

if caster:HasTalent("modifier_bloodseeker_hero_6") then
  self.talents.has_fear = 1
end

if caster:HasTalent("modifier_bloodseeker_rupture_7") then
  self.talents.has_legendary = 1
  if not self.legendary_init then
    self.legendary_init = true
    self.tracker.pos = caster:GetAbsOrigin()
    self.tracker:StartIntervalThink(0.3)
  end
end

end

function bloodseeker_rupture_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "bloodseeker_rupture", self)
end

function bloodseeker_rupture_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_bloodseeker_rupture_custom_tracker"
end

function bloodseeker_rupture_custom:GetCastPoint()
return self.cast_point + (self.talents.has_fear == 1 and self.talents.cast_inc or 0)
end

function bloodseeker_rupture_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function bloodseeker_rupture_custom:GetCastAnimation()
if self.talents.has_fear == 1 then 
	return 0
end 
return ACT_DOTA_CAST_ABILITY_6
end

function bloodseeker_rupture_custom:OnAbilityPhaseStart()
if self.talents.has_fear == 1 then 
  self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, 1.4)
end
return true
end

function bloodseeker_rupture_custom:OnAbilityPhaseInterrupted()
if self.talents.has_fear == 0 then return end 
self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_6)
end

function bloodseeker_rupture_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end
local duration = self.duration

if not caster:HasScepter() then
	duration = duration * (1 - target:GetStatusResistance())
end

target:AddNewModifier(caster, self, "modifier_bloodseeker_rupture_custom", {duration = duration})
caster:AddNewModifier(caster, self, "modifier_bloodseeker_rupture_custom_caster", {target = target:entindex()})

caster:EmitSound("hero_bloodseeker.rupture.cast")
target:EmitSound("hero_bloodseeker.rupture")
end


modifier_bloodseeker_rupture_custom = class(mod_visible)
function modifier_bloodseeker_rupture_custom:GetStatusEffectName() return "particles/status_fx/status_effect_rupture.vpcf" end
function modifier_bloodseeker_rupture_custom:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA end
function modifier_bloodseeker_rupture_custom:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.movement_damage_pct = self.ability.movement_damage_pct
self.no_damage_distance = self.ability.no_damage_distance
self.hp_pct = self.ability.hp_pct

self.heal_reduce = self.ability.talents.heal_reduce

if not IsServer() then return end

self.damage_stack = 0
self.scepter_count = 0
if self.caster:HasScepter() or self.ability.talents.has_fear == 1 then
  self.parent:AddSpellEvent(self, true)
end

self.parent:EmitSound("hero_bloodseeker.rupture_FP")
self.RemoveForDuel = true
self.origin = self.parent:GetAbsOrigin()
self.max_duration = self:GetRemainingTime()

if self.ability.talents.has_stack == 1 then
	self.parent:AddDamageEvent_inc(self, true)
	if not self.ability:IsHidden() then
		self.caster:SwapAbilities(self.ability:GetName(), "bloodseeker_rupture_custom_recast", false, true)
		self.caster:FindAbilityByName("bloodseeker_rupture_custom_recast"):StartCooldown(0.5)
	end
end

if self.ability.talents.has_fear == 1 then
	self.parent:AddDamageEvent_inc(self, true)
end

DoDamage({ attacker = self.caster, victim = self.parent, damage = self.parent:GetMaxHealth() * self.hp_pct, damage_type = DAMAGE_TYPE_PURE, ability = self.ability })

if self.caster.bloodrage_ability then
  self.caster.bloodrage_ability:ProcShard(self.parent)
end

self.parent:GenericParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf")
self.timer_particle = self.parent:GenericParticle("particles/units/heroes/hero_bloodseeker/rupture_duration_overhead.vpcf", self, true)

local particle_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", self)
local particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(particle, false, false, -1, false, false)

self.interval = 0.2
self.creeps_damage = self.ability.creeps_damage*self.interval
self.elapsed = 0
self.count = 0
self.is_invun = false

self:OnIntervalThink(true)
self:StartIntervalThink(self.interval)
end

function modifier_bloodseeker_rupture_custom:OnIntervalThink(first)
if not IsServer() then return end

if not first then
  self.elapsed = self.elapsed + self.interval
end

ParticleManager:SetParticleControl(self.timer_particle, 1, Vector((self.elapsed/self.max_duration)*100, 0, 0))

if self.ability.talents.has_stack == 1 and not self.proc_damage then
	self.caster:UpdateUIshort({max_time = self.max_duration, time = self:GetRemainingTime(), stack = self:GetStackCount(), priority = 2, style = "BloodseekerRupture"})
end

self.count = self.count + self.interval
if self.count >= 1 - FrameTime() then
  self.count = 0
  if self.ability.talents.has_damage == 1 and self.damage_stack < self.ability.talents.damage_max then
    self.damage_stack = self.damage_stack + 1
  end
  if self.caster.bath_ability then
    self.caster.bath_ability:ApplyHealth(self.parent)
  end
end

local bonus_damage = 1 + self.ability.talents.damage_inc*(self.damage_stack/self.ability.talents.damage_max)

if self.parent:IsCreep() then 
	DoDamage({victim = self.parent, attacker = self.caster, damage = self.creeps_damage*bonus_damage, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self.ability})
	return
end 

if not self.is_invun then
  local current_origin = self.parent:GetAbsOrigin()
  local distance = (self.origin - current_origin):Length2D()
  if distance < self.ability.no_damage_distance then
  	local damage = distance * (self.movement_damage_pct*bonus_damage)
  	if damage > 0 then
  		DoDamage({victim = self.parent, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self.ability})
      if self.caster.bloodrage_ability then
        self.caster.bloodrage_ability:ProcShard(self.parent)
      end
  	end
  end
end

if self.parent:IsInvulnerable() then
  self.is_invun = true
else
  self.is_invun = false
end

self.origin = self.parent:GetAbsOrigin()
end

function modifier_bloodseeker_rupture_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if self.ability.talents.has_stack == 1 and params.attacker:FindOwner() == self.caster and not self.proc_damage then
	self:SetStackCount(self:GetStackCount() + params.damage*self.ability.talents.stack_damage)
end

end

function modifier_bloodseeker_rupture_custom:ProcDamage()
if not IsServer() then return end
if self.ability.talents.has_stack == 0 then return end
if self.proc_damage then return end
self.proc_damage = true

self.caster:UpdateUIshort({hide = 1, hide_full = 1, priority = 2, style = "BloodseekerRupture"})

if self.ability:IsHidden() then
	self.caster:SwapAbilities(self.ability:GetName(), "bloodseeker_rupture_custom_recast", true, false)
end

self.parent:EmitSound("Bloodseeker.Rupture_damage")
self.parent:EmitSound("Bloodseeker.Rupture_damage2")
self.parent:GenericParticle("particles/bloodseeker/rupture_proc_damage.vpcf", self)

local damage = self:GetStackCount()
local damage_table = {attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.stack_damage_type, damage = damage, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION}
for _,target in pairs(self.caster:FindTargets(self.ability.talents.stack_radius, self.parent:GetAbsOrigin())) do
	damage_table.victim = target
	local real_damage = DoDamage(damage_table, "modifier_bloodseeker_rupture_3")
	if target == self.parent then
		target:SendNumber(6, real_damage)
	end
	local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sandking_caustic_finale_explode_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
self:SetStackCount(0)
end

function modifier_bloodseeker_rupture_custom:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

if self.ability.talents.has_fear == 1 and not self.proc_fear and not self.parent:IsInvulnerable() then
  self.proc_fear = true
  self.parent:EmitSound("Generic.Fear")
  self.parent:AddNewModifier(self.caster, self.ability, "modifier_nevermore_requiem_fear", {duration  = self.ability.talents.fear_duration * (1 - self.parent:GetStatusResistance())})
end

if not self.caster:HasScepter() then return end
if self.scepter_count >= self.ability.scepter_max then return end

self.parent:EmitSound("BS.Rupture_duration")
self.parent:GenericParticle("particles/brist_proc.vpcf") 
self.max_duration = self.max_duration + self.ability.scepter_duration
self:SetDuration(self:GetRemainingTime() + self.ability.scepter_duration, true)
self.scepter_count = self.scepter_count + 1
end

function modifier_bloodseeker_rupture_custom:OnDestroy()
if not IsServer() then return end
self:ProcDamage()
self.parent:StopSound("hero_bloodseeker.rupture_FP")
self.caster:RemoveModifierByName("modifier_bloodseeker_rupture_custom_caster")
end

function modifier_bloodseeker_rupture_custom:DeclareFunctions()
return
{
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_bloodseeker_rupture_custom:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_bloodseeker_rupture_custom:GetModifierHealChange()
return self.heal_reduce
end

function modifier_bloodseeker_rupture_custom:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end






modifier_bloodseeker_rupture_custom_tracker = class(mod_hidden)
function modifier_bloodseeker_rupture_custom_tracker:OnCreated()
self.ability  = self:GetAbility()
self.parent   = self:GetParent()
self.ability.tracker = self
self.ability:UpdateTalents()

self.legendary_ability = self.parent:FindAbilityByName("bloodseeker_rupture_custom_legendary")
if self.legendary_ability then
	self.legendary_ability:UpdateTalents()
end

self.ability.cast_point = self.ability:GetSpecialValueFor("AbilityCastPoint")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.no_damage_distance = self.ability:GetSpecialValueFor("no_damage_distance")
self.ability.movement_damage_pct = self.ability:GetSpecialValueFor("movement_damage_pct") / 100
self.ability.hp_pct = self.ability:GetSpecialValueFor("hp_pct") / 100
self.ability.creeps_damage = self.ability:GetSpecialValueFor("creeps_damage")
self.ability.creeps_cd = self.ability:GetSpecialValueFor("creeps_cd")
self.ability.scepter_duration = self.ability:GetSpecialValueFor("scepter_duration")
self.ability.scepter_max = self.ability:GetSpecialValueFor("scepter_max")

self.pos = self.parent:GetAbsOrigin()
self.distance = 0
end 

function modifier_bloodseeker_rupture_custom_tracker:OnRefresh()
self.ability.movement_damage_pct = self.ability:GetSpecialValueFor("movement_damage_pct") / 100
self.ability.creeps_damage = self.ability:GetSpecialValueFor("creeps_damage")
end

function modifier_bloodseeker_rupture_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.legendary_ability then return end
if self.ability.talents.has_legendary == 0 then return end

local pass = (self.parent:GetAbsOrigin() - self.pos):Length2D()
self.pos = self.parent:GetAbsOrigin()

if self.legendary_ability:GetCooldownTimeRemaining() <= 0 then 
  self.distance = 0
  return 
end

local final = self.distance + pass
local legendary_distance = self.ability.talents.legendary_cd_distance

if final >= legendary_distance then 
    local delta = math.floor(final/legendary_distance)
    for i = 1, delta do 
      self.parent:CdAbility(self.legendary_ability, self.ability.talents.legendary_cd_inc)
    end 
    self.distance = final - delta*legendary_distance
else 
    self.distance = final
end 

end

function modifier_bloodseeker_rupture_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
  MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
}
end

function modifier_bloodseeker_rupture_custom_tracker:GetModifierPercentageCooldown()
if self.ability.talents.has_r4 == 0 then return end
return self.ability.talents.r4_cdr
end

function modifier_bloodseeker_rupture_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.r2_range
end


modifier_bloodseeker_rupture_custom_caster = class(mod_hidden)
function modifier_bloodseeker_rupture_custom_caster:RemoveOnDeath() return false end
function modifier_bloodseeker_rupture_custom_caster:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end

self.interval = 1

if self.ability.talents.has_r4 == 1 then
	self.parent:GenericParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_thirst_owner.vpcf", self)
end

self.ability:EndCd()
self.target = EntIndexToHScript(table.target)
self.is_creeps = self.target:IsCreep()
self:StartIntervalThink(self.interval)
end

function modifier_bloodseeker_rupture_custom_caster:OnIntervalThink()
if not IsServer() then return end

if self.ability.talents.has_r4 == 1 then
  self.parent:CdItems(self.ability.talents.cd_items*self.interval)
end

if not IsValid(self.target) or not self.target:HasModifier("modifier_bloodseeker_rupture_custom") then
	self:Destroy()
	return
end

local mod = self.target:FindModifierByName("modifier_bloodseeker_rupture_custom")
self:SetDuration(mod:GetRemainingTime(), true)
end

function modifier_bloodseeker_rupture_custom_caster:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()

if self.is_creeps then
  self.ability:EndCd(0)
  self.ability:StartCooldown(self.ability.creeps_cd)
end

end

function modifier_bloodseeker_rupture_custom_caster:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING
}
end

function modifier_bloodseeker_rupture_custom_caster:GetModifierSlowResistance_Stacking()
if self.ability.talents.has_r4 == 0 then return end
return self.ability.talents.r4_slow_resist
end




bloodseeker_rupture_custom_recast = class({})

function bloodseeker_rupture_custom_recast:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "bloodseeker_rupture", self)
end

function bloodseeker_rupture_custom_recast:OnSpellStart()
local caster = self:GetCaster()
local caster_mod = caster:FindModifierByName("modifier_bloodseeker_rupture_custom_caster")
if not caster_mod or not IsValid(caster_mod.target) then return end

local target_mod = caster_mod.target:FindModifierByName("modifier_bloodseeker_rupture_custom")
if not target_mod then return end
target_mod:ProcDamage()
end


bloodseeker_rupture_custom_legendary = class({})
bloodseeker_rupture_custom_legendary.talents = {}
function bloodseeker_rupture_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function bloodseeker_rupture_custom_legendary:UpdateTalents()
local caster = self:GetCaster()
if not self.init and caster:HasTalent("modifier_bloodseeker_rupture_7") then
  self.init = true
  if IsServer() and not self:IsTrained() then
  	self:SetLevel(1)
  end
  self.talents.legendary_duration = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "duration", true)
  self.talents.legendary_damage = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "damage", true)
  self.talents.legendary_cd = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "talent_cd", true)
  self.talents.legendary_damage_reduce = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "damage_reduce", true)
  self.talents.legendary_damage_creeps = caster:GetTalentValue("modifier_bloodseeker_rupture_7", "creeps", true)
end

end

function bloodseeker_rupture_custom_legendary:GetChannelTime()
return self.talents.legendary_duration
end

function bloodseeker_rupture_custom_legendary:GetCooldown()
return self.talents.legendary_cd
end

function bloodseeker_rupture_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if caster:GetUnitName() ~= "npc_dota_hero_bloodseeker" then return end
if not caster:HasTalent("modifier_bloodseeker_rupture_7") then return end

if target:TriggerSpellAbsorb(self) then 
	caster:Stop()
	return
end

caster:EmitSound("BS.Rupture_legendary_cast")
caster:AddNewModifier(caster, self, "modifier_bloodseeker_rupture_custom_legendary", {duration = self.talents.legendary_duration, target = target:entindex()})
end

function bloodseeker_rupture_custom_legendary:OnChannelFinish(bInterrupted)
if not IsServer() then return end
self:GetCaster():RemoveModifierByName("modifier_bloodseeker_rupture_custom_legendary")
end




modifier_bloodseeker_rupture_custom_legendary = class(mod_hidden)
function modifier_bloodseeker_rupture_custom_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_gods_strength.vpcf" end
function modifier_bloodseeker_rupture_custom_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA end
function modifier_bloodseeker_rupture_custom_legendary:OnCreated(table)
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage_reduce = self.ability.talents.legendary_damage_reduce

if not IsServer() then return end
self.target = EntIndexToHScript(table.target)
self.target:AddNewModifier(self.caster, self.ability, "modifier_bloodseeker_rupture_custom_legendary_damage", {duration = self:GetRemainingTime()})
AddFOWViewer(self.target:GetTeamNumber(), self.caster:GetAbsOrigin(), 150, self:GetRemainingTime(), false)

self.knockback_count = self.ability:GetSpecialValueFor("knockback_count") + 1
self.knockback_duration = self.ability:GetSpecialValueFor("knockback_duration")
self.knockback_cd = self.ability:GetSpecialValueFor("knockback_cd")
self.knockback_distance = ((self.caster:GetAbsOrigin() - self.target:GetAbsOrigin()):Length2D() - 100)/self.knockback_count
self.damageTable = {victim = self.target, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE, damage = self.ability.talents.legendary_damage_creeps/self.knockback_count}

self.caster:GenericParticle("particles/phantom_assassin/crit_shield.vpcf", self)
self.target:GenericParticle("particles/bs_pull_target.vpcf", self)

self.effect_cast = ParticleManager:CreateParticle( "particles/bs_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster )
ParticleManager:SetParticleControlEnt(self.effect_cast, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
ParticleManager:SetParticleControlEnt(self.effect_cast, 1, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
self:AddParticle(self.effect_cast, false, false, -1, false, false)

self:OnIntervalThink()
self:StartIntervalThink(self.knockback_cd + self.knockback_duration)
end

function modifier_bloodseeker_rupture_custom_legendary:OnIntervalThink()
if not IsServer() then return end
self.target:EmitSound("BS.Rupture_legendary")

self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, 1.4)

if not IsValid(self.target) then return end
if not self.target:HasModifier("modifier_bloodseeker_rupture_custom_legendary_damage") then
	self.target:AddNewModifier(self.caster, self.ability, "modifier_bloodseeker_rupture_custom_legendary_damage", {duration = self:GetRemainingTime()})
end

if self.target:IsCreep() then
  DoDamage(self.damageTable)
end

self.target:AddNewModifier(self.caster, self.ability, "modifier_bloodseeker_rupture_custom_legendary_knockback", {distance = self.knockback_distance, duration = self.knockback_duration})
end

function modifier_bloodseeker_rupture_custom_legendary:OnDestroy()
if not IsServer() then return end
if not IsValid(self.target) then return end
self.target:RemoveModifierByName("modifier_bloodseeker_rupture_custom_legendary_damage")
end

function modifier_bloodseeker_rupture_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	MODIFIER_PROPERTY_MODEL_SCALE,
}
end 

function modifier_bloodseeker_rupture_custom_legendary:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end

function modifier_bloodseeker_rupture_custom_legendary:GetModifierModelScale() 
return 20
end


modifier_bloodseeker_rupture_custom_legendary_knockback = class(mod_hidden)
function modifier_bloodseeker_rupture_custom_legendary_knockback:OnCreated(params)
if not IsServer() then return end
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.parent:StartGesture(ACT_DOTA_FLAIL)

self.knockback_duration = self.ability:GetSpecialValueFor("knockback_duration")

self.knockback_distance = params.distance
self.dir = (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
self.position = self.parent:GetAbsOrigin() + self.dir*self.knockback_distance

self.knockback_speed = self.knockback_distance / self.knockback_duration

if self:ApplyHorizontalMotionController() == false then 
  self:Destroy()
  return
end

end

function modifier_bloodseeker_rupture_custom_legendary_knockback:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local distance = (self.position - me:GetOrigin()):Normalized()
me:SetOrigin( me:GetOrigin() + distance * self.knockback_speed * dt )
GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.parent:GetHullRadius(), true )
end

function modifier_bloodseeker_rupture_custom_legendary_knockback:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_bloodseeker_rupture_custom_legendary_knockback:GetOverrideAnimation()
 return ACT_DOTA_FLAIL
end

function modifier_bloodseeker_rupture_custom_legendary_knockback:OnDestroy()
if not IsServer() then return end
self.parent:FadeGesture(ACT_DOTA_FLAIL)

if self.parent:IsInvulnerable() then return end

self.parent:RemoveHorizontalMotionController( self )

self.vec = self.parent:GetForwardVector()
self.vec.z = 0
self.parent:SetForwardVector(self.vec)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + self.vec*10)
FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
end


modifier_bloodseeker_rupture_custom_legendary_damage = class(mod_hidden)
function modifier_bloodseeker_rupture_custom_legendary_damage:OnCreated()
self.damage = self:GetAbility().talents.legendary_damage
self.caster = self:GetCaster()
self.parent = self:GetParent()
end

function modifier_bloodseeker_rupture_custom_legendary_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end 

function modifier_bloodseeker_rupture_custom_legendary_damage:GetModifierIncomingDamage_Percentage(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end
if self.parent:IsCreep() then return end
return self.damage
end

function modifier_bloodseeker_rupture_custom_legendary_damage:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end
