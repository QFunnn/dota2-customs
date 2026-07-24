--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_puck_innate_custom", "abilities/puck/puck_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_puck_innate_custom_auto_cd", "abilities/puck/puck_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_puck_innate_custom_auto_damage", "abilities/puck/puck_innate_custom", LUA_MODIFIER_MOTION_NONE )


puck_innate_custom = class({})


function puck_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_puck_innate_custom"
end

function puck_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_puck.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_puck", context)
end


modifier_puck_innate_custom = class({})
function modifier_puck_innate_custom:IsHidden() return true end
function modifier_puck_innate_custom:IsPurgable() return false end
function modifier_puck_innate_custom:RemoveOnDeath() return false end
function modifier_puck_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddAttackStartEvent_out(self)

self.ability = self:GetAbility()

self.auto_duration = self.parent:GetTalentValue("modifier_puck_coil_4", "duration", true)

self.cd_items = self.parent:GetTalentValue("modifier_puck_coil_6", "cd_items", true)

self.mana = self.ability:GetSpecialValueFor("mana")/100
self.chance = self.ability:GetSpecialValueFor("chance")
self.parent:AddSpellEvent(self)
end



function modifier_puck_innate_custom:PuckAttackProc()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_puck_coil_4") then return end
if self.parent:HasModifier("modifier_puck_innate_custom_auto_cd") then return end

self:Proc()
self.parent:AddNewModifier(self.parent, self.ability, "modifier_puck_innate_custom_auto_cd", {duration = self.parent:GetTalentValue("modifier_puck_coil_4", "cd")})
end

function modifier_puck_innate_custom:AttackStartEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

self:PuckAttackProc()
end


function modifier_puck_innate_custom:SpellEvent(params)
if not IsServer() then return end 
if self.parent:PassivesDisabled() then return end
if params.unit ~= self.parent then return end 
if params.ability:IsItem() then return end
if self.parent:HasModifier("modifier_custom_puck_waning_rift_legendary_charge") and params.ability:GetName() == "custom_puck_waning_rift" then return end

if not RollPseudoRandomPercentage(self.chance,1223, self.parent) then return end
self:Proc()
end

function modifier_puck_innate_custom:Proc()
if not IsServer() then return end 
local mana = self.parent:GetMaxMana()*self.mana
local heal = mana

local mana_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_chakra_magic.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(mana_particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(mana_particle, 1, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(mana_particle)
self.parent:EmitSound("Puck.Rift_Mana")

self.parent:GenericHeal(heal, self.ability)
self.parent:GiveMana(mana)
self.parent:SendNumber(11, mana)
if self.parent:HasTalent("modifier_puck_coil_4") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_puck_innate_custom_auto_damage", {duration = self.auto_duration})
end

if self.parent:HasTalent("modifier_puck_coil_6") then
	self.parent:CdItems(self.cd_items)
end

end



modifier_puck_innate_custom_auto_cd = class({})
function modifier_puck_innate_custom_auto_cd:IsHidden() return false end
function modifier_puck_innate_custom_auto_cd:IsPurgable() return false end
function modifier_puck_innate_custom_auto_cd:IsDebuff() return true end






modifier_puck_innate_custom_auto_damage = class({})
function modifier_puck_innate_custom_auto_damage:IsHidden() return false end
function modifier_puck_innate_custom_auto_damage:IsPurgable() return false end
function modifier_puck_innate_custom_auto_damage:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage = self.caster:GetTalentValue("modifier_puck_coil_4", "damage")

if not IsServer() then return end

self.RemoveForDuel = true
self:AddStack(table.duration)
end


function modifier_puck_innate_custom_auto_damage:AddStack(duration)
if not IsServer() then return end

self.max_timer = self:GetRemainingTime()

Timers:CreateTimer(duration, function() 
  if self and not self:IsNull() then 
    self:DecrementStackCount()
    if self:GetStackCount() <= 0 then 
      self:Destroy()
    end 
  end 
end)

self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end 


function modifier_puck_innate_custom_auto_damage:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table.duration)
end


function modifier_puck_innate_custom_auto_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_puck_innate_custom_auto_damage:GetModifierSpellAmplify_Percentage()
return self.damage*self:GetStackCount()
end
