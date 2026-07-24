--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sven_innate_custom", "abilities/sven/sven_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_innate_custom_buff", "abilities/sven/sven_innate_custom", LUA_MODIFIER_MOTION_NONE )


sven_innate_custom = class({})


function sven_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_sven_innate_custom"
end


function sven_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_sven.vsndevts", context )
PrecacheResource( "particle", "particles/items2_fx/vindicators_axe_damage.vpcf", context )

dota1x6:PrecacheShopItems("npc_dota_hero_sven", context)
end


modifier_sven_innate_custom = class({})
function modifier_sven_innate_custom:IsHidden() return true end
function modifier_sven_innate_custom:IsPurgable() return false end
function modifier_sven_innate_custom:RemoveOnDeath() return false end
function modifier_sven_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("radius")
self:StartIntervalThink(0.5)
end



function modifier_sven_innate_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end

local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS  + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES  + DOTA_UNIT_TARGET_FLAG_INVULNERABLE  + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD , FIND_CLOSEST, false)

local count = 0

for _,unit in pairs(units) do 
	if not unit:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") and not unit:IsTempestDouble() then 
	  count = count  + 1
	end
end

if self.parent:PassivesDisabled() then
	count = 0
end

local interval = 0.5
local low_health = false
if self.parent:HasTalent("modifier_sven_cleave_2") then
	interval = 0.25
	if self.parent:GetHealthPercent() <= self.parent:GetTalentValue("modifier_sven_cleave_2", "health") then
		low_health = true
	end
end

if (count < 2 and low_health == false) and self.parent:HasModifier("modifier_sven_innate_custom_buff") then 
	self.parent:RemoveModifierByName("modifier_sven_innate_custom_buff")
end

if (count >= 2 or low_health == true) and not self.parent:HasModifier("modifier_sven_innate_custom_buff") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_innate_custom_buff", {})
end

end


function modifier_sven_innate_custom:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_sven_innate_custom_buff")
end


modifier_sven_innate_custom_buff = class({})
function modifier_sven_innate_custom_buff:IsHidden() return false end
function modifier_sven_innate_custom_buff:IsPurgable() return false end
function modifier_sven_innate_custom_buff:OnCreated(table)

self.parent = self:GetParent()

self.outgoing = self:GetAbility():GetSpecialValueFor("outgoing") + self.parent:GetTalentValue("modifier_sven_cleave_2", "damage")
self.incoming = self:GetAbility():GetSpecialValueFor("incoming") + self.parent:GetTalentValue("modifier_sven_cleave_2", "damage")*-1
end

function modifier_sven_innate_custom_buff:GetEffectName()
return "particles/items2_fx/vindicators_axe_damage.vpcf"
end

function modifier_sven_innate_custom_buff:GetModifierIncomingDamage_Percentage()
return self.incoming
end

function modifier_sven_innate_custom_buff:GetModifierDamageOutgoing_Percentage()
return self.outgoing
end

function modifier_sven_innate_custom_buff:GetModifierSpellAmplify_Percentage()
return self.outgoing
end

function modifier_sven_innate_custom_buff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end
