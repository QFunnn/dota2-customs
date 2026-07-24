--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_boss_rain_of_chaos_cd", "abilities/warlock_boss/warlock_boss_rain_of_chaos.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_rain_of_chaos_passive", "abilities/warlock_boss/warlock_boss_rain_of_chaos.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_rain_of_chaos_thinker", "abilities/warlock_boss/warlock_boss_rain_of_chaos.lua", LUA_MODIFIER_MOTION_NONE)

warlock_boss_rain_of_chaos = class({})

function warlock_boss_rain_of_chaos:GetIntrinsicModifierName()
return "modifier_warlock_boss_rain_of_chaos_passive"
end
function warlock_boss_rain_of_chaos:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/warlock_death.vpcf", context )
PrecacheResource( "particle", "particles/warlock_aoe_cast.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf", context )

end


function warlock_boss_rain_of_chaos:OnAbilityPhaseStart()

self:GetCaster():EmitSound("Warlock.Ult_pre")
return true
end


function warlock_boss_rain_of_chaos:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Warlock.Ult_Voice")

CreateModifierThinker(self:GetCaster(), self, "modifier_warlock_boss_rain_of_chaos_thinker", {duration = self:GetSpecialValueFor("delay")}, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false)

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_warlock_boss_rain_of_chaos_cd", {duration = self:GetCooldownTimeRemaining()})
end



modifier_warlock_boss_rain_of_chaos_cd = class({})

function modifier_warlock_boss_rain_of_chaos_cd:IsHidden() return false end
function modifier_warlock_boss_rain_of_chaos_cd:IsPurgable() return false end



modifier_warlock_boss_rain_of_chaos_passive = class({})
function modifier_warlock_boss_rain_of_chaos_passive:IsHidden() return true end
function modifier_warlock_boss_rain_of_chaos_passive:IsPurgable() return false end
function modifier_warlock_boss_rain_of_chaos_passive:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end



function modifier_warlock_boss_rain_of_chaos_passive:DeathEvent(params)
if not IsServer() then return end
if self:GetParent() ~= params.unit then return end

self:GetParent():EmitSound("Warlock.Death_voice")
self:GetParent():EmitSound("Warlock.Death_sound")

local particle = ParticleManager:CreateParticle( "particles/warlock_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())

ParticleManager:ReleaseParticleIndex( particle )
end




modifier_warlock_boss_rain_of_chaos_thinker = class({})
function modifier_warlock_boss_rain_of_chaos_thinker:IsHidden() return false end
function modifier_warlock_boss_rain_of_chaos_thinker:IsPurgable() return false end

function modifier_warlock_boss_rain_of_chaos_thinker:OnCreated(table)
if not IsServer() then return end

self.ability = self:GetAbility()
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.damage = self.ability:GetSpecialValueFor("damage")/100
self.stun = self.ability:GetSpecialValueFor("stun")
self.radius = self.ability:GetSpecialValueFor("radius")

self.effect_cast = ParticleManager:CreateParticle("particles/warlock_aoe_cast.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )

self:StartIntervalThink(self:GetRemainingTime() - 0.5)
end


function modifier_warlock_boss_rain_of_chaos_thinker:OnIntervalThink()
if not IsServer() then return end

local seed_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(seed_particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 1, Vector(self.radius, self.radius, self.radius))
ParticleManager:ReleaseParticleIndex(seed_particle)

end

function modifier_warlock_boss_rain_of_chaos_thinker:OnDestroy(table)
if not IsServer() then return end
ParticleManager:DestroyParticle( self.effect_cast, true )
ParticleManager:ReleaseParticleIndex( self.effect_cast )

self.parent:EmitSound("Warlock.Ult_cast")

local seed_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(seed_particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 1, Vector(self.radius, self.radius, self.radius))
ParticleManager:ReleaseParticleIndex(seed_particle)

local host_team = self.caster.host_team
local stack = self.caster:GetUpgradeStack("modifier_waveupgrade_boss")
local health = self.ability:GetSpecialValueFor("golem_health_"..stack)
local damage = self.ability:GetSpecialValueFor("golem_damage_"..stack)
local armor = self.ability:GetSpecialValueFor("golem_armor_"..stack)
local magic = self.ability:GetSpecialValueFor("golem_magic_"..stack)

if host_team then
  local ids = dota1x6:FindPlayers(host_team)
  if ids then
    if #ids == 2 then
      health = health*creeps_team_health
      damage = damage*creeps_team_damage
    end
  end
end

for i = 1,stack do

  local golem = CreateUnitByName("npc_warlock_golem_custom", self.parent:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_CUSTOM_5)
  golem:SetOwner(self.caster)
  golem.mkb = self.caster.mkb
  golem.summoned = true
  golem.host_team = host_team
  golem.summoner = self.caster
  golem:AddNewModifier(golem, nil, "modifier_waveupgrade", {})

  golem:EmitSound("Warlock.Golem_spawn")

  golem:SetBaseDamageMin(damage)
  golem:SetBaseDamageMax(damage)

  golem:SetBaseMaxHealth(health)
  --golem:SetHealth(health)

  golem:SetPhysicalArmorBaseValue(armor)
  golem:SetBaseMagicalResistanceValue(magic)

  golem:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = 0.1})
end

local  enemy_for_ability = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES , FIND_CLOSEST, false)
for _,i in pairs(enemy_for_ability) do

  local damageTable = {victim = i,  damage = self.damage*i:GetMaxHealth(), damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self.caster, ability = self.ability}
  local actualy_damage = DoDamage(damageTable)

  SendOverheadEventMessage(i, 4, i, self.damage*i:GetMaxHealth(), nil)

  i:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 -i:GetStatusResistance())*self.stun})
end
   
end