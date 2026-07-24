--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_abaddon_font_of_avernus_custom", "abilities/abaddon/abaddon_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_abaddon_font_of_avernus_custom_heal_reduce", "abilities/abaddon/abaddon_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_abaddon_font_of_avernus_custom_regen", "abilities/abaddon/abaddon_innate_custom", LUA_MODIFIER_MOTION_NONE )

abaddon_innate_custom = class({})
abaddon_innate_custom.talents = {}

function abaddon_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_withering_mist_debuff.vpcf", context )
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_abaddon.vsndevts", context )

dota1x6:PrecacheShopItems("npc_dota_hero_abaddon", context)
end

function abaddon_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q2 = 0,
    q2_heal = 0,

    has_r2 = 0,
    r2_heal = 0,

    has_h1 = 0,
    h1_move = 0,

    has_h3 = 0,
    h3_heal = 0,
    h3_cdr = 0,
    h3_duration = caster:GetTalentValue("modifier_abaddon_hero_3", "duration", true),

    has_r7 = 0,
    r7_heal = caster:GetTalentValue("modifier_abaddon_borrowed_7", "heal", true)/100,
  }
end

if caster:HasTalent("modifier_abaddon_mist_2") then
  self.talents.has_q2 = 1
  self.talents.q2_heal = caster:GetTalentValue("modifier_abaddon_mist_2", "heal")/100
end

if caster:HasTalent("modifier_abaddon_borrowed_2") then
  self.talents.has_r2 = 1
  self.talents.r2_heal = caster:GetTalentValue("modifier_abaddon_borrowed_2", "heal")/100
end

if caster:HasTalent("modifier_abaddon_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_move = caster:GetTalentValue("modifier_abaddon_hero_1", "move")
end

if caster:HasTalent("modifier_abaddon_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_cdr = caster:GetTalentValue("modifier_abaddon_hero_3", "cdr")
  self.talents.h3_heal = caster:GetTalentValue("modifier_abaddon_hero_3", "heal")
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_abaddon_borrowed_7") then
  self.talents.has_r7 = 1
end

end

function abaddon_innate_custom:Init()
self.caster = self:GetCaster()
end

function abaddon_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_abaddon_font_of_avernus_custom"
end



modifier_abaddon_font_of_avernus_custom = class({})
function modifier_abaddon_font_of_avernus_custom:IsHidden() return true end
function modifier_abaddon_font_of_avernus_custom:IsPurgable() return false end
function modifier_abaddon_font_of_avernus_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.duration = self.ability:GetSpecialValueFor("duration")
self.health = self.ability:GetSpecialValueFor("health")

self.health_bonus = self.parent:GetTalentValue("modifier_abaddon_hero_3", "health")

if not IsServer() then return end
self.parent:AddDamageEvent_out(self, true)
end

function modifier_abaddon_font_of_avernus_custom:SpellEvent( params )
if not IsServer() then return end
if params.unit ~= self.parent then return end

if self.ability.talents.has_h3 == 1 and not params.ability:IsItem() then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_abaddon_font_of_avernus_custom_regen", {duration = self.ability.talents.h3_duration})
end

end

function modifier_abaddon_font_of_avernus_custom:DamageEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
local unit = params.unit

if not unit:IsUnit() then return end
if self.parent:GetTeamNumber() == unit:GetTeamNumber() then return end

if self.ability.talents.has_q2 == 1 or self.ability.talents.has_r2 == 1 or self.ability.talents.has_r7 == 1 then
	local result = self.parent:CheckLifesteal(params)
	if result then
		if self.ability.talents.has_q2 == 1 and params.inflictor then
			self.parent:GenericHeal(result*params.damage*self.ability.talents.q2_heal, self.ability, false, "", "modifier_abaddon_mist_2")
		end
		if not params.inflictor then
			if self.ability.talents.has_r2 == 1 then
				self.parent:GenericHeal(result*params.damage*self.ability.talents.r2_heal, self.ability, true, "", "modifier_abaddon_borrowed_2")
			end
			if self.parent:HasModifier("modifier_abaddon_borrowed_time_custom") and self.ability.talents.has_r7 == 1 then
				local heal_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
				ParticleManager:SetParticleControlEnt( heal_particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
				ParticleManager:SetParticleControl(heal_particle, 1, unit:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(heal_particle)
				self.parent:GenericHeal(result*params.damage*self.ability.talents.r7_heal, self.ability, false, "", "modifier_abaddon_borrowed_7")
			end
		end
	end
end

if self.parent:PassivesDisabled() then return end
local health = self.health + self.health_bonus

if unit:GetHealthPercent() > health then return end
unit:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, self.parent:HasTalent("modifier_abaddon_hero_7")) , "modifier_abaddon_font_of_avernus_custom_heal_reduce", {duration = self.duration})
end

function modifier_abaddon_font_of_avernus_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_abaddon_font_of_avernus_custom:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.h1_move
end

function modifier_abaddon_font_of_avernus_custom:GetModifierPercentageCooldown() 
return self.ability.talents.h3_cdr
end


modifier_abaddon_font_of_avernus_custom_heal_reduce = class({})
function modifier_abaddon_font_of_avernus_custom_heal_reduce:IsHidden() return true end
function modifier_abaddon_font_of_avernus_custom_heal_reduce:IsPurgable() return true end
function modifier_abaddon_font_of_avernus_custom_heal_reduce:OnCreated()
self.caster = self:GetCaster()
self.ability = self.caster:FindAbilityByName("abaddon_innate_custom")
if not self.ability then
	self:Destroy()
	return
end

self.heal_reduce = self.ability:GetSpecialValueFor("heal_reduce") + self.caster:GetTalentValue("modifier_abaddon_hero_3", "effect")
self.damage_reduction = self.ability:GetSpecialValueFor("damage_reduction") + self.caster:GetTalentValue("modifier_abaddon_hero_3", "effect")
end

function modifier_abaddon_font_of_avernus_custom_heal_reduce:DeclareFunctions()
return
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_abaddon_font_of_avernus_custom_heal_reduce:GetModifierLifestealRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_abaddon_font_of_avernus_custom_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_abaddon_font_of_avernus_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_abaddon_font_of_avernus_custom_heal_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduction
end

function modifier_abaddon_font_of_avernus_custom_heal_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduction
end


function modifier_abaddon_font_of_avernus_custom_heal_reduce:GetEffectName()
return "particles/units/heroes/hero_abaddon/abaddon_withering_mist_debuff.vpcf"
end




modifier_abaddon_font_of_avernus_custom_regen = class(mod_visible)
function modifier_abaddon_font_of_avernus_custom_regen:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.duration = self.ability.talents.h3_duration
self.regen = self.ability.talents.h3_heal/self.duration
if not IsServer() then return end
self:AddStack()
end

function modifier_abaddon_font_of_avernus_custom_regen:OnRefresh()
if not IsServer() then return end 
self:AddStack()
end

function modifier_abaddon_font_of_avernus_custom_regen:AddStack()
if not IsServer() then return end
self:IncrementStackCount()

Timers:CreateTimer(self.duration, function()
	if IsValid(self) then
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end)

end

function modifier_abaddon_font_of_avernus_custom_regen:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
}
end

function modifier_abaddon_font_of_avernus_custom_regen:GetModifierConstantHealthRegen()
return self:GetStackCount()*self.regen
end