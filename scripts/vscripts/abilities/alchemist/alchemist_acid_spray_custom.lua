--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_alchemist_acid_spray_custom_thinker", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_aura", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_aura_red", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_aura_purple", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_mixing", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_tracker", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_effects", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_armor", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_root_cd", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_acid_spray_custom_root", "abilities/alchemist/alchemist_acid_spray_custom", LUA_MODIFIER_MOTION_NONE )

alchemist_acid_spray_class = class({})

function alchemist_acid_spray_class:GetAOERadius()
return self:GetSpecialValueFor( "radius" ) + self:GetCaster():GetTalentValue("modifier_alchemist_spray_4", "radius")
end

function alchemist_acid_spray_class:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_alchemist_spray_2") then
	bonus = self:GetCaster():GetTalentValue("modifier_alchemist_spray_2", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function alchemist_acid_spray_class:OnAbilityPhaseStart()
return not self:GetCaster():HasModifier("modifier_alchemist_acid_spray_custom_mixing")
end

function alchemist_acid_spray_class:OnSpellStart()
local ability = self:GetCaster():FindAbilityByName("alchemist_acid_spray_custom")
if IsValid(self.active_mod) then
	self.active_mod:RemoveModifierByName("modifier_alchemist_acid_spray_custom_thinker")
end

self.active_mod = ability:CreateSpray(self:GetCursorPosition(), self)
end

alchemist_acid_spray_custom = class(alchemist_acid_spray_class)
alchemist_acid_spray_red_custom = class(alchemist_acid_spray_class)
alchemist_acid_spray_purple_custom = class(alchemist_acid_spray_class)



function alchemist_acid_spray_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", context )
PrecacheResource( "particle", "particles/alch_spray_red.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf", context )
PrecacheResource( "particle", "particles/alch_root_timer.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_silenced.vpcf", context )
end

function alchemist_acid_spray_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
  	magic_inc = 0,
  	regen_inc = 0,
  	status_inc = 0,
  }
end

if caster:HasTalent("modifier_alchemist_hero_4") then
	self.talents.magic_inc = caster:GetTalentValue("modifier_alchemist_hero_4", "magic")
	self.talents.regen_inc = caster:GetTalentValue("modifier_alchemist_hero_4", "heal")
	self.talents.status_inc = caster:GetTalentValue("modifier_alchemist_hero_4", "status")

end

end


function alchemist_acid_spray_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_alchemist_acid_spray_custom_tracker"
end 

function alchemist_acid_spray_custom:CreateSpray(point, ability)
if not IsServer() then return end
local duration = self:GetSpecialValueFor("duration")
local mod = CreateModifierThinker( self:GetCaster(), ability, "modifier_alchemist_acid_spray_custom_thinker", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false )

return mod
end

function alchemist_acid_spray_custom:DoDamage(target)
if not IsServer() then return end
local caster = self:GetCaster()
local damage = self:GetSpecialValueFor( "damage" )

if caster:HasTalent("modifier_alchemist_spray_1") then
	local bonus = target:GetMaxHealth()*caster:GetTalentValue("modifier_alchemist_spray_1", "damage")/100
	bonus = target:IsCreep() and math.min(bonus, caster:GetTalentValue("modifier_alchemist_spray_1", "creeps_max")) or bonus
	damage = damage + bonus
end

if caster:HasTalent("modifier_alchemist_spray_legendary") and target:IsCreep() then
	damage = damage*(1 + caster:GetTalentValue("modifier_alchemist_spray_legendary", "creeps")/100)
end

local damage_type = caster:HasTalent("modifier_alchemist_unstable_legendary") and DAMAGE_TYPE_MAGICAL or DAMAGE_TYPE_PHYSICAL
local damageTable = {victim = target, attacker = self:GetCaster(), damage = damage, damage_type = damage_type, ability = self, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK }

DoDamage(damageTable)
target:AddNewModifier(caster, self, "modifier_alchemist_acid_spray_custom_effects", {duration = 1})

if caster:HasTalent("modifier_alchemist_spray_4") and not target:HasModifier("modifier_alchemist_acid_spray_custom_root_cd") and not target:IsDebuffImmune() then
	target:EmitSound("Alch.Root_target")
	target:AddNewModifier(caster, self, "modifier_alchemist_acid_spray_custom_root_cd", {duration = caster:GetTalentValue("modifier_alchemist_spray_4", "cd")})
	target:AddNewModifier(caster, self, "modifier_alchemist_acid_spray_custom_root", {duration = caster:GetTalentValue("modifier_alchemist_spray_4", "root")*(1 - target:GetStatusResistance())})
end

target:EmitSound("Hero_Alchemist.AcidSpray.Damage")
end




modifier_alchemist_acid_spray_custom_thinker = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_thinker:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.aura_mod = "modifier_alchemist_acid_spray_custom_aura"
local effect_name = "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf"
local color_vec = Vector(0, 0, 0)

local ability_name = self.ability:GetName()
if ability_name == "alchemist_acid_spray_red_custom" then
	self.aura_mod = "modifier_alchemist_acid_spray_custom_aura_red"
	color_vec = Vector( 220, 20, 60 )
elseif ability_name == "alchemist_acid_spray_purple_custom" then
	self.aura_mod = "modifier_alchemist_acid_spray_custom_aura_purple"
	color_vec = Vector( 180, 92, 179 )
end

self.radius = self.ability:GetAOERadius()

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, 3, false)

local particle = ParticleManager:CreateParticle( effect_name, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( particle, 1, Vector( self.radius, 1, 1 ) )
ParticleManager:SetParticleControl( particle, 15, color_vec )
ParticleManager:SetParticleControl( particle, 16, Vector( ability_name ~= "alchemist_acid_spray_custom" and 1 or 0, 0, 0 ) )
self:AddParticle( particle, false, false, -1, false, false )

self.parent:EmitSound("Hero_Alchemist.AcidSpray")
end

function modifier_alchemist_acid_spray_custom_thinker:OnDestroy()
if not IsServer() then return end
if not IsValid(self.parent) then return end
self.parent:StopSound("Hero_Alchemist.AcidSpray")
UTIL_Remove( self.parent )
end

function modifier_alchemist_acid_spray_custom_thinker:IsAura() return true end
function modifier_alchemist_acid_spray_custom_thinker:GetModifierAura() return self.aura_mod end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraRadius() return self.radius end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraDuration() return 0.5 end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_alchemist_acid_spray_custom_thinker:GetAuraSearchFlags() return 0 end



acid_spray_aura_class = class({})
function acid_spray_aura_class:IsHidden() return not self.is_enemy end 
function acid_spray_aura_class:IsPurgable() return false end
function acid_spray_aura_class:OnCreated()

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self.caster:FindAbilityByName("alchemist_acid_spray_custom")

self.is_enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()

if self.is_enemy then
	self.armor = -self.ability:GetSpecialValueFor( "armor_reduction" )
	self.magic_resist = 0
	if self.caster:HasTalent("modifier_alchemist_unstable_legendary") then
		self.armor = 0
		self.magic_resist = self.caster:GetTalentValue("modifier_alchemist_unstable_legendary", "magic_resist")
	end
	self.damage_reduce = self.caster:GetTalentValue("modifier_alchemist_spray_legendary", "damage_reduce")
	self.status_reduce = self.caster:GetTalentValue("modifier_alchemist_spray_legendary", "status_reduce")
else
	self.armor = 0
	self.damage_reduce = 0
	self.status_reduce = 0
end

if not IsServer() then return end

self.armor_duration = self.caster:GetTalentValue("modifier_alchemist_spray_3", "duration", true)

if self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura") 
	and self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red") 
	and self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple") and self.is_enemy then

	self.parent:EmitSound("Alch.Triple")
end

self:StartIntervalThink(0.1)
end

function acid_spray_aura_class:OnIntervalThink()
if not IsServer() then return end

if self.is_enemy then
	self.ability:DoDamage(self.parent)
end

if self.caster:HasTalent("modifier_alchemist_spray_3") then
	self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, true), "modifier_alchemist_acid_spray_custom_armor", {duration = self.armor_duration})
end

self:StartIntervalThink(1)
end

function acid_spray_aura_class:GetEffectName()
return self.is_enemy and "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf" or nil
end



modifier_alchemist_acid_spray_custom_aura = class(acid_spray_aura_class)
function modifier_alchemist_acid_spray_custom_aura:GetTexture() return "alchemist_acid_spray" end
function modifier_alchemist_acid_spray_custom_aura:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_alchemist_acid_spray_custom_aura:GetModifierPhysicalArmorBonus()
return self.armor
end

function modifier_alchemist_acid_spray_custom_aura:GetModifierMagicalResistanceBonus()
return self.magic_resist
end

function modifier_alchemist_acid_spray_custom_aura:CheckState()
if not self.is_enemy then return end
if not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red") or not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple") then return end
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end



modifier_alchemist_acid_spray_custom_aura_red = class(acid_spray_aura_class)
function modifier_alchemist_acid_spray_custom_aura_red:GetTexture() return "spray_red" end
function modifier_alchemist_acid_spray_custom_aura_red:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_alchemist_acid_spray_custom_aura_red:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_alchemist_acid_spray_custom_aura_red:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end



modifier_alchemist_acid_spray_custom_aura_purple = class(acid_spray_aura_class)
function modifier_alchemist_acid_spray_custom_aura_purple:GetTexture() return "spray_purple" end
function modifier_alchemist_acid_spray_custom_aura_purple:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_alchemist_acid_spray_custom_aura_purple:GetModifierStatusResistanceStacking()
return self.status_reduce
end



alchemist_acid_spray_mixing = class({})

alchemist_acid_spray_mixing.current_spray = 1

function alchemist_acid_spray_mixing:CreateTalent()
self:SetLevel(1)
self:SetHidden(false)
end

function alchemist_acid_spray_mixing:OnSpellStart()
local caster = self:GetCaster()
caster:StartGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
caster:AddNewModifier(caster, self, "modifier_alchemist_acid_spray_custom_mixing", { duration = caster:GetTalentValue("modifier_alchemist_spray_legendary", "delay") } )
end


modifier_alchemist_acid_spray_custom_mixing = class(mod_visible)
function modifier_alchemist_acid_spray_custom_mixing:OnCreated( kv )
if not IsServer() then return end

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.parent:EmitSound("Alch.Mix")

self.abilities = {"alchemist_acid_spray_custom", "alchemist_acid_spray_red_custom", "alchemist_acid_spray_purple_custom"}

self.ability:SetActivated(false)
self.ability:StartCooldown(self:GetRemainingTime())
end

function modifier_alchemist_acid_spray_custom_mixing:OnDestroy()
if not IsServer() then return end

self.parent:FadeGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
self.ability:SetActivated(true)

self.parent:StopSound("Alch.Mix")

local current = self.ability.current_spray
local next = self.ability.current_spray >= #self.abilities and 1 or self.ability.current_spray + 1

self.parent:SwapAbilities(self.abilities[current], self.abilities[next], false, true )
self.ability.current_spray = next
end




modifier_alchemist_acid_spray_custom_tracker = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.mana_reduce = self.parent:GetTalentValue("modifier_alchemist_spray_2", "mana")

if not IsServer() then return end
self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end 


function modifier_alchemist_acid_spray_custom_tracker:UpdateTalent(name)
if not IsServer() then return end

if name == "modifier_alchemist_spray_2" or self.parent:HasTalent("modifier_alchemist_spray_2") then
	self.mana_reduce = self.parent:GetTalentValue("modifier_alchemist_spray_2", "mana")
end

self:SendBuffRefreshToClients()
end

function modifier_alchemist_acid_spray_custom_tracker:AddCustomTransmitterData() 
return 
{
  mana_reduce = self.mana_reduce,
} 
end

function modifier_alchemist_acid_spray_custom_tracker:HandleCustomTransmitterData(data)
self.mana_reduce = data.mana_reduce
end

function modifier_alchemist_acid_spray_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
}
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierPercentageManacostStacking()
return self.mana_reduce
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierMagicalResistanceBonus()
return self.ability.talents.magic_inc
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierStatusResistanceStacking()
return(self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura")
	or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
	or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")
	or self.parent:HasModifier("modifier_alchemist_unstable_concoction_custom")) and self.ability.talents.status_inc or 0
end

function modifier_alchemist_acid_spray_custom_tracker:GetModifierHealthRegenPercentage()
local regen = (self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura")
	or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
	or self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple")) and self.ability.talents.regen_inc or 0

if IsServer() then
	if regen > 0 and not self.heal_effect then
		self.heal_effect = self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", self)
	end
	if regen <= 0 and self.heal_effect then
		ParticleManager:Delete(self.heal_effect, 1)
		self.heal_effect = nil
	end
end

return regen
end



modifier_alchemist_acid_spray_custom_effects = class(mod_hidden)
function modifier_alchemist_acid_spray_custom_effects:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.caster:GetTalentValue("modifier_alchemist_hero_1", "slow")
self.heal_reduce = self.caster:GetTalentValue("modifier_alchemist_hero_1", "heal_reduce")

if not IsServer() then return end
self.interval = 1
self.passive = self.caster:FindAbilityByName("alchemist_corrosive_weaponry_custom")
self:StartIntervalThink(1)
end


function modifier_alchemist_acid_spray_custom_effects:OnIntervalThink()
if not IsServer() then return end

if self.passive and not self.passive:IsNull() then
	self.passive:AddStack(self.parent, 1)
end

if self.caster:GetQuest() == "Alch.Quest_5" and not self.caster:QuestCompleted() and self.parent:IsRealHero() then
	self.caster:UpdateQuest(self.interval)
end

end

function modifier_alchemist_acid_spray_custom_effects:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_alchemist_acid_spray_custom_effects:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_alchemist_acid_spray_custom_armor = class(mod_visible)
function modifier_alchemist_acid_spray_custom_armor:GetTexture() return "buffs/alchemist/spray_3" end
function modifier_alchemist_acid_spray_custom_armor:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.max = self.caster:GetTalentValue("modifier_alchemist_spray_3", "max")
self.armor = self.caster:HasTalent("modifier_alchemist_unstable_legendary") and 0 or self.caster:GetTalentValue("modifier_alchemist_spray_3", "armor")/self.max
self.magic = self.caster:HasTalent("modifier_alchemist_unstable_legendary") and self.caster:GetTalentValue("modifier_alchemist_spray_3", "magic")/self.max or 0

self.is_enemy = self.caster:GetTeamNumber() ~= self.parent:GetTeamNumber()

if self.is_enemy then
	self.armor = self.armor*-1
	self.magic = self.magic*-1
end

if not IsServer() then return end
self.RemoveForDuel = true
self:StartIntervalThink(1)
end

function modifier_alchemist_acid_spray_custom_armor:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura") 
	and not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_red")
	and not self.parent:HasModifier("modifier_alchemist_acid_spray_custom_aura_purple") then return end

if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

if self.is_enemy and self:GetStackCount() >= self.max then
	self.parent:EmitSound("Hoodwink.Acorn_armor")
	self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
end

end


function modifier_alchemist_acid_spray_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_alchemist_acid_spray_custom_armor:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.armor
end

function modifier_alchemist_acid_spray_custom_armor:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.magic
end



modifier_alchemist_acid_spray_custom_root = class({})
function modifier_alchemist_acid_spray_custom_root:IsHidden() return true end
function modifier_alchemist_acid_spray_custom_root:IsPurgable() return true end
function modifier_alchemist_acid_spray_custom_root:CheckState() return {[MODIFIER_STATE_ROOTED] = true} end
function modifier_alchemist_acid_spray_custom_root:GetEffectName() return "particles/alch_root.vpcf" end



modifier_alchemist_acid_spray_custom_root_cd = class(mod_hidden)