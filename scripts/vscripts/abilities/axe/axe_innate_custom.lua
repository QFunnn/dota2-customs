--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_coat_of_blood_custom", "abilities/axe/axe_innate_custom", LUA_MODIFIER_MOTION_NONE )

axe_innate_custom = class({})
axe_innate_custom.talents = {}


function axe_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "model", "models/items/axe/axe_carnival/axe_carnival_base.vmdl", context )
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_axe.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/axe_vo_custom.vsndevts", context ) 
end

function axe_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w3 = 0,
    w3_heal = 0,

    has_r2 = 0,
    r2_heal = 0,
    r2_bonus = caster:GetTalentValue("modifier_axe_culling_2", "bonus", true),
    r2_health = caster:GetTalentValue("modifier_axe_culling_2", "health", true),

    has_h6 = 0,
    h6_max = caster:GetTalentValue("modifier_axe_hero_6", "max", true),
    h6_cdr = caster:GetTalentValue("modifier_axe_hero_6", "cdr", true),
    h6_heal = caster:GetTalentValue("modifier_axe_hero_6", "heal", true),
    h6_bonus = caster:GetTalentValue("modifier_axe_hero_6", "bonus", true),
  }
end

if caster:HasTalent("modifier_axe_hunger_3") then
  self.talents.has_w3 = 1
  self.talents.w3_heal = caster:GetTalentValue("modifier_axe_hunger_3", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_axe_culling_2") then
  self.talents.has_r2 = 1
  self.talents.r2_heal = caster:GetTalentValue("modifier_axe_culling_2", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_axe_hero_6") then
  self.talents.has_h6 = 1
  if IsServer() and not self.think_init then
  	self.think_init = true
  	self.tracker:StartIntervalThink(1)
  end
end

end



function axe_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_axe_coat_of_blood_custom"
end

modifier_axe_coat_of_blood_custom = class(mod_visible)
function modifier_axe_coat_of_blood_custom:RemoveOnDeath() return false end
function modifier_axe_coat_of_blood_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent:AddDeathEvent(self, true)

self.armor = self.ability:GetSpecialValueFor("armor")
self.str = self.ability:GetSpecialValueFor("str")
self.max = self.ability:GetSpecialValueFor("max")

if not IsServer() then return end 
self:SetStackCount(0)
end

function modifier_axe_coat_of_blood_custom:DamageEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local result = self.parent:CheckLifesteal(params)
if not result then return end

if not params.inflictor and self.ability.talents.has_r2 == 1 then
	local effect = ""
	local heal = params.damage*result*self.ability.talents.r2_heal
	if params.unit:GetHealthPercent() >= self.ability.talents.r2_health then
		heal = heal*self.ability.talents.r2_bonus
		effect = nil
	end
	self.parent:GenericHeal(heal, self.ability, true, effect, "modifier_axe_culling_2")
	return
end
if self.ability.talents.has_w3 == 0 then return end
self.parent:GenericHeal(params.damage*self.ability.talents.w3_heal*result, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_axe_hunger_3")
end

function modifier_axe_coat_of_blood_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
}
end

function modifier_axe_coat_of_blood_custom:GetModifierPercentageCooldown()
if self.ability.talents.has_h6 == 0 then return end
return self.ability.talents.h6_cdr*(self:GetStackCount() >= self.ability.talents.h6_max and self.ability.talents.h6_bonus or 1)
end

function modifier_axe_coat_of_blood_custom:GetModifierHealthRegenPercentage()
if self.ability.talents.has_h6 == 0 then return end
return self.ability.talents.h6_heal*(self:GetStackCount() >= self.ability.talents.h6_max and self.ability.talents.h6_bonus or 1)
end

function modifier_axe_coat_of_blood_custom:GetModifierBonusStats_Strength()
return self.str*self:GetStackCount()
end

function modifier_axe_coat_of_blood_custom:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end

function modifier_axe_coat_of_blood_custom:DeathEvent(params)
if not IsServer() then return end 
if not params.attacker then return end
if params.attacker ~= self.parent then return end
if not params.unit:IsValidKill(self.parent) then return end

self:AddStack()
end

function modifier_axe_coat_of_blood_custom:AddStack()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end

function modifier_axe_coat_of_blood_custom:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.ability.talents.h6_max then return end

self.parent:GenericParticle("particles/brist_lowhp_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")

self:StartIntervalThink(-1)
end 
