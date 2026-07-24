--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_phantom_assassin_fan_of_knives_thinker", "abilities/phantom_assassin/custom_phantom_assassin_fan_of_knives", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_fan_of_knives", "abilities/phantom_assassin/custom_phantom_assassin_fan_of_knives", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_fan_of_damage", "abilities/phantom_assassin/custom_phantom_assassin_fan_of_knives", LUA_MODIFIER_MOTION_NONE)


custom_phantom_assassin_fan_of_knives              = class({})


function custom_phantom_assassin_fan_of_knives:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "phantom_assassin_fan_of_knives", self)
end

function custom_phantom_assassin_fan_of_knives:GetAOERadius() 
return self:GetSpecialValueFor("radius")
end



function custom_phantom_assassin_fan_of_knives:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin_persona/pa_persona_shard_fan_of_knives.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives_dot.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin_persona/pa_persona_shard_fan_of_knives_debuff.vpcf", context )

end


function custom_phantom_assassin_fan_of_knives:OnSpellStart()

local caster = self:GetCaster()
local radius         = self:GetSpecialValueFor("radius") 
local projectile_speed   = self:GetSpecialValueFor("projectile_speed")
local location = caster:GetAbsOrigin()
local duration       = radius / projectile_speed

if not IsServer() then return end
local ability = caster:FindAbilityByName("custom_phantom_assassin_coup_de_grace")
if ability and ability:IsTrained() then 
  caster:AddNewModifier(caster, ability, "modifier_phantom_assassin_phantom_coup_de_grace_focus",  {duration = ability:GetSpecialValueFor("duration")})
end 

caster:EmitSound("Hero_PhantomAssassin.FanOfKnives.Cast")
CreateModifierThinker(caster, self, "modifier_custom_phantom_assassin_fan_of_knives_thinker", {duration = duration}, location, caster:GetTeamNumber(), false)
end



modifier_custom_phantom_assassin_fan_of_knives_thinker = class({})


function modifier_custom_phantom_assassin_fan_of_knives_thinker:OnCreated()
self.ability  = self:GetAbility()
self.caster   = self:GetCaster()
self.parent   = self:GetParent()

self.duration = self.ability:GetSpecialValueFor("duration")
self.radius   = self.ability:GetSpecialValueFor("radius")
self.damage = self.ability:GetSpecialValueFor("damage")
self.damage_creeps = self.ability:GetSpecialValueFor("damage_creeps")

if not IsServer() then return end

local start_effect = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf", self)
self.particle = ParticleManager:CreateParticle(start_effect, PATTACH_ABSORIGIN, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 3, self:GetParent():GetAbsOrigin())
self:AddParticle(self.particle, false, false, -1, false, false)

self.hit_enemies = {}
self:StartIntervalThink(FrameTime())
end

function modifier_custom_phantom_assassin_fan_of_knives_thinker:OnIntervalThink()
if not IsServer() then return end

local radius_pct = math.min((self:GetDuration() - self:GetRemainingTime()) / self:GetDuration(), 1)
local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius * radius_pct, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)

for _, enemy in pairs(enemies) do
  if not self.hit_enemies[enemy] then
    local damage = enemy:GetMaxHealth()*self.damage/100
    if enemy:IsCreep() then 
      damage = damage/self.damage_creeps
    end

    enemy:AddNewModifier(self.caster, self.ability, "modifier_custom_phantom_assassin_fan_of_knives", {duration = self.duration*(1 - enemy:GetStatusResistance()) })
    enemy:EmitSound("Hero_PhantomAssassin.Attack")

    self.hit_enemies[enemy] = true
    
    local real_damage = DoDamage({victim = enemy, attacker = self.caster, damage = damage, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL})
    enemy:SendNumber(4, real_damage)
  end
end

end





modifier_custom_phantom_assassin_fan_of_knives = class({})
function modifier_custom_phantom_assassin_fan_of_knives:IsHidden() return false end
function modifier_custom_phantom_assassin_fan_of_knives:IsPurgable() return false end
function modifier_custom_phantom_assassin_fan_of_knives:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_custom_phantom_assassin_fan_of_knives:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end


function modifier_custom_phantom_assassin_fan_of_knives:OnCreated(table)
self.parent = self:GetParent()

if not IsServer() then return end

local particle_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives_dot.vpcf", self)

self.parent:GenericParticle(particle_name, self)

self.particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_break.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 1, self.parent:GetAbsOrigin())
self:AddParticle(self.particle, false, false, -1, false, false)
end
