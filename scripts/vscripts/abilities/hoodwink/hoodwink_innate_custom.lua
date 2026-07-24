--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_hoodwink_innate_custom", "abilities/hoodwink/hoodwink_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_innate_custom_cd", "abilities/hoodwink/hoodwink_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_innate_custom_shield_cd", "abilities/hoodwink/hoodwink_innate_custom", LUA_MODIFIER_MOTION_NONE )

hoodwink_innate_custom = class({})
hoodwink_innate_custom.talents = {}

function hoodwink_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_hoodwink.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_hoodwink", context)
end

function hoodwink_innate_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
  	h3_magic = 0,
  	h3_status = 0,

    has_q2 = 0,
    q2_heal = 0,

    has_r1 = 0,
    r1_heal = 0,

    has_h5 = 0,
    h5_health = caster:GetTalentValue("modifier_hoodwink_hero_5", "health", true),
    h5_shield = caster:GetTalentValue("modifier_hoodwink_hero_5", "shield", true)/100,
    h5_talent_cd = caster:GetTalentValue("modifier_hoodwink_hero_5", "talent_cd", true),
    h5_chance = caster:GetTalentValue("modifier_hoodwink_hero_5", "chance", true),
    h5_duration = caster:GetTalentValue("modifier_hoodwink_hero_5", "duration", true),
  }
end

if caster:HasTalent("modifier_hoodwink_hero_3") then
	self.talents.h3_magic = caster:GetTalentValue("modifier_hoodwink_hero_3", "magic")
	self.talents.h3_status = caster:GetTalentValue("modifier_hoodwink_hero_3", "status")
end

if caster:HasTalent("modifier_hoodwink_hero_5") then
	self.talents.h7_cd = caster:GetTalentValue("modifier_hoodwink_hero_7", "cd")
end

if caster:HasTalent("modifier_hoodwink_acorn_2") then
  self.talents.has_q2 = 1
  self.talents.q2_heal = caster:GetTalentValue("modifier_hoodwink_acorn_2", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_hoodwink_sharp_1") then
  self.talents.has_r1 = 1
  self.talents.r1_heal = caster:GetTalentValue("modifier_hoodwink_sharp_1", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_hoodwink_hero_5") then
  self.talents.has_h5 = 1
  caster:AddDamageEvent_inc(self.tracker, true)
end

end

function hoodwink_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_hoodwink_innate_custom"
end

modifier_hoodwink_innate_custom = class({})
function modifier_hoodwink_innate_custom:IsHidden() return self:GetStackCount() ~= 0 end
function modifier_hoodwink_innate_custom:IsPurgable() return false end
function modifier_hoodwink_innate_custom:RemoveOnDeath() return false end
function modifier_hoodwink_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.chance = self.ability:GetSpecialValueFor("chance")
self.radius = self.ability:GetSpecialValueFor("radius")
self.cd = self.ability:GetSpecialValueFor("cd")
self.damage = self.ability:GetSpecialValueFor("damage")

if not IsServer() then return end

self.interval = 0.1

self:OnIntervalThink()
self:StartIntervalThink( self.interval )
end

function modifier_hoodwink_innate_custom:DamageEvent_out(params)
if not IsServer() then return end
local result = self.parent:CheckLifesteal(params)
if not result then return end

if self.ability.talents.has_q2 == 1 and not params.inflictor then
	self.parent:GenericHeal(self.ability.talents.q2_heal*params.damage*result, self.ability, true, nil, "modifier_hoodwink_acorn_2")
end

if self.ability.talents.has_r1 == 1 and params.inflictor then
	self.parent:GenericHeal(self.ability.talents.r1_heal*params.damage*result, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_hoodwink_sharp_1")
end

end

function modifier_hoodwink_innate_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.ability.talents.has_h5 == 0 then return end
if self.parent ~= params.unit then return end
if self.parent:PassivesDisabled() then return end
if self.parent:GetHealthPercent() > self.ability.talents.h5_health then return end
if self.parent:HasModifier("modifier_death") then return end
if self.parent:HasModifier("modifier_hoodwink_innate_custom_shield_cd") then return end

if IsValid(self.shield_mod) then
	self.shield_mod:Destroy()
end

self.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield", 
{
	duration = self.ability.talents.h5_duration,
	max_shield = self.parent:GetMaxHealth()*self.ability.talents.h5_shield,
	start_full = 1,
	shield_talent = "modifier_hoodwink_hero_5"
})

if self.shield_mod then
	self.shield_mod:NewDamageFunction(function(params)
		local result = {}
		if not IsValid(self.parent) then return result end
		local mod = self.parent:FindModifierByName("modifier_hoodwink_innate_custom")
		if mod and mod.GetModifierTotal_ConstantBlock then
			local block = mod:GetModifierTotal_ConstantBlock(params)
			if block then
				result.damage = params.damage
				result.shield_damage = 0
				result.ignore_info = true
			end
		end
		return result
	end)

	self.parent:EmitSound("Hoodwink.Shield")
	self.particle = ParticleManager:CreateParticle("particles/hoodwink/scurry_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
	self.shield_mod:AddParticle(self.particle,false, false, -1, false, false)
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_hoodwink_innate_custom_shield_cd", {duration = self.ability.talents.h5_talent_cd})
end

function modifier_hoodwink_innate_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_hoodwink_innate_custom:GetModifierMagicalResistanceBonus()
if self:GetStackCount() ~= 0 then return end
return self.ability.talents.h3_magic
end

function modifier_hoodwink_innate_custom:GetModifierStatusResistanceStacking()
if self:GetStackCount() ~= 0 then return end
return self.ability.talents.h3_status
end

function modifier_hoodwink_innate_custom:GetModifierTotal_ConstantBlock(params)
if not IsServer() then return end

if not IsValid(self.shield_mod) then
	if self:GetStackCount() ~= 0 then return end
	if self.parent:HasModifier("modifier_hoodwink_innate_custom_cd") then return end
end

if params.target ~= self.parent then return end
if params.damage < self.damage then return end

local chance = self.chance + (self.ability.talents.has_h5 == 1 and self.ability.talents.h5_chance or 0)
if not RollPseudoRandomPercentage(chance, 769, self.parent) then return end
local damage = params.damage

self.parent:AddNewModifier(self.parent, self.ability, "modifier_hoodwink_innate_custom_cd", {duration = self.cd})
self.parent:EmitSound("Hoodwink.Innate_proc") 

self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})
self.parent:GenericParticle("particles/butterfly_proc.vpcf")
return damage
end

function modifier_hoodwink_innate_custom:OnIntervalThink()
if not IsServer() then return end
local stack = 1

if not self.parent:HasModifier("modifier_hoodwink_scurry_custom_buff") then 
	local trees = GridNav:GetAllTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )
	if #trees>0 then
	 	stack = 0 
	end
else 
	stack = 0
end 

if self.parent:PassivesDisabled() then
	stack = 1
end

if self:GetStackCount() ~= stack then
	self:SetStackCount( stack )
	if stack == 0 then
		if not self.effect_cast then
      local pfx_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_hoodwink/hoodwink_scurry_passive.vpcf", self)
			self.effect_cast = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, self.parent )
      if pfx_name == "particles/units/heroes/hero_hoodwink/hoodwink_scurry_passive.vpcf" then
    		ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self.radius, 0, 0 ) )
      else
          ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(75, 0, 0 ) )
      end
			self:AddParticle( self.effect_cast, false, false, -1, false, false  )
		end
	else
		if self.effect_cast then
			ParticleManager:DestroyParticle( self.effect_cast, false )
			ParticleManager:ReleaseParticleIndex( self.effect_cast )
			self.effect_cast = nil
		end
	end
end

end


modifier_hoodwink_innate_custom_cd = class(mod_hidden)
modifier_hoodwink_innate_custom_shield_cd = class(mod_cd)