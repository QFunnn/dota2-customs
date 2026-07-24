--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_conjurers_catalyst_custom", "abilities/items/neutral/item_conjurers_catalyst_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_conjurers_catalyst_custom_burn", "abilities/items/neutral/item_conjurers_catalyst_custom", LUA_MODIFIER_MOTION_NONE)

item_conjurers_catalyst_custom = class({})

function item_conjurers_catalyst_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_conjurers_catalyst_custom"
end

function item_conjurers_catalyst_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items7_fx/misrule_focus.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf", context )
end


modifier_item_conjurers_catalyst_custom = class(mod_hidden)
function modifier_item_conjurers_catalyst_custom:RemoveOnDeath() return false end
function modifier_item_conjurers_catalyst_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")/100
self.ability.heal = self.ability:GetSpecialValueFor("heal")/100
self.ability.radius = self.ability:GetSpecialValueFor("radius")

self.parent:AddSpellEvent(self, true)
end

function modifier_item_conjurers_catalyst_custom:SpellEvent(params)
if not IsServer() then return end
if not self.ability:IsFullyCastable() then return end
if self.parent ~= params.unit then return end
if not params.target then return end

local target = params.target
if not target:IsUnit() then return end
if target:GetTeamNumber() == self.parent:GetTeamNumber() then return end

target:EmitSound("item_searing_signet.activate")

local hit_effect = ParticleManager:CreateParticle("particles/items7_fx/misrule_focus.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControl(hit_effect, 1, Vector(self.ability.radius, 0, 0)) 
ParticleManager:ReleaseParticleIndex(hit_effect)

for _,aoe_target in pairs(self.parent:FindTargets(self.ability.radius, target:GetAbsOrigin())) do
	aoe_target:RemoveModifierByName("modifier_item_conjurers_catalyst_custom_burn")
	aoe_target:AddNewModifier(self.parent, self.ability, "modifier_item_conjurers_catalyst_custom_burn", {})
end

self.ability:UseResources(false, false, false, true)
end


modifier_item_conjurers_catalyst_custom_burn = class(mod_hidden)
function modifier_item_conjurers_catalyst_custom_burn:IsPurgable() return true end
function modifier_item_conjurers_catalyst_custom_burn:OnCreated()
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage = self.ability.damage
self.damage_health = self.ability.damage_health
self.count = self.ability.duration
self.heal = self.ability.heal

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_item_conjurers_catalyst_custom_burn:OnIntervalThink()
if not IsServer() then return end
local damage = self.damage + self.damage_health*self.parent:GetMaxHealth()
if self.parent:IsCreep() then
	damage = self.damage*2
end
self.damageTable.damage = damage
local real_damage = DoDamage(self.damageTable)
local result = self.caster:CanLifesteal(self.parent)
if result then
	self.caster:GenericHeal(result*real_damage*self.heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf")
end

self.count = self.count - 1
if self.count <= 0 then
	self:Destroy()
	return
end

end

function modifier_item_conjurers_catalyst_custom_burn:GetEffectName()
return "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf"
end

function modifier_item_conjurers_catalyst_custom_burn:GetStatusEffectName()
return "particles/status_fx/status_effect_burn.vpcf"
end

function modifier_item_conjurers_catalyst_custom_burn:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL  
end