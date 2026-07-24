--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_snapfire_innate_custom", "abilities/snapfire/snapfire_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_innate_custom_nodamage", "abilities/snapfire/snapfire_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_innate_custom_nocount", "abilities/snapfire/snapfire_innate_custom", LUA_MODIFIER_MOTION_NONE )


snapfire_innate_custom = class({})

function snapfire_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_snapfire_innate_custom"
end

function snapfire_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_snapfire.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_snapfire", context)
end

modifier_snapfire_innate_custom = class({})
function modifier_snapfire_innate_custom:IsHidden() return true end
function modifier_snapfire_innate_custom:IsPurgable() return false end
function modifier_snapfire_innate_custom:RemoveOnDeath() return false end
function modifier_snapfire_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.chance = self.ability:GetSpecialValueFor("chance")
self.damage_inc = self.ability:GetSpecialValueFor("damage_inc")
self.radius = self.ability:GetSpecialValueFor("radius")

self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackRecordEvent_out(self)
end

function modifier_snapfire_innate_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
}
end

function modifier_snapfire_innate_custom:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

self.parent:RemoveModifierByName("modifier_snapfire_innate_custom_nodamage")

if params.no_attack_cooldown then return end
local target = params.target

for _,enemy in pairs(self.parent:FindTargets(self.radius, params.target:GetAbsOrigin())) do
  if enemy ~= target then
    self.parent:PerformAttack(enemy, true, true, true, true, true, false, false)
    break
  end
end

end

function modifier_snapfire_innate_custom:AttackRecordEvent_out(params)
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
self.parent:RemoveModifierByName("modifier_snapfire_innate_custom_nodamage")

if RollPseudoRandomPercentage(self.chance, 1216, self.parent) then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_innate_custom_nodamage", {duration = 0.1})
end

end

function modifier_snapfire_innate_custom:GetModifierDamageOutgoing_Percentage()
local bonus = self.parent:GetTalentValue("modifier_snapfire_shredder_1", "bonus")

if IsClient() or self.parent:HasModifier("modifier_snapfire_innate_custom_nocount") then
  return self.damage_inc + bonus
end

if self.parent:HasModifier("modifier_snapfire_lil_shredder_custom") then return end
if self.parent:HasModifier("modifier_snapfire_innate_custom_nodamage") then 
  return -self.damage_inc 
end
return self.damage_inc + bonus
end


function modifier_snapfire_innate_custom:GetDamage()
if RollPseudoRandomPercentage(self.chance, 1216, self.parent) then
  return -self.damage_inc 
end
return self.damage_inc + self.parent:GetTalentValue("modifier_snapfire_shredder_1", "bonus")
end


modifier_snapfire_innate_custom_nodamage = class({})
function modifier_snapfire_innate_custom_nodamage:IsHidden() return true end
function modifier_snapfire_innate_custom_nodamage:IsPurgable() return false end


modifier_snapfire_innate_custom_nocount = class({})
function modifier_snapfire_innate_custom_nocount:IsHidden() return true end
function modifier_snapfire_innate_custom_nocount:IsPurgable() return false end