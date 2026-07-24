--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sandking_caustic_finale_custom", "abilities/sand_king/sandking_caustic_finale_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_caustic_finale_custom_slow", "abilities/sand_king/sandking_caustic_finale_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_caustic_finale_custom_legendary", "abilities/sand_king/sandking_caustic_finale_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_caustic_finale_custom_lowhp", "abilities/sand_king/sandking_caustic_finale_custom", LUA_MODIFIER_MOTION_NONE)



sandking_caustic_finale_custom = class({})


		
function sandking_caustic_finale_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/sand_king/finale_legendary_hit.vpcf", context )
PrecacheResource( "particle","particles/sand_king/sandking_caustic_finale_explode_custom.vpcf", context )
PrecacheResource( "particle","particles/sand_king/finale_legendary_hit.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_stack.vpcf", context )
PrecacheResource( "particle","particles/sand_king/finale_legendary_poison.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_poison_venomancer.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_venomancer/venomancer_venomous_gale_impact.vpcf", context )
PrecacheResource( "particle","particles/sand_king/finale_legendary.vpcf", context )
PrecacheResource( "particle","particles/sand_king/finale_legendary_explode.vpcf", context )
PrecacheResource( "particle","particles/sand_king/finale_double_hit.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/mars_revenge_proc.vpcf", context )
PrecacheResource( "particle","particles/lc_lowhp.vpcf", context )

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_sand_king.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_sand_king", context)
end



function sandking_caustic_finale_custom:GetBehavior()
if self:GetCaster():HasTalent("modifier_sand_king_finale_7") and false then
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function sandking_caustic_finale_custom:GetCastRange(vLocation, hTarget)
if self:GetCaster():HasTalent("modifier_sand_king_finale_7") and false then
	return self:GetCaster():GetTalentValue("modifier_sand_king_finale_7", "range")
end
return 
end

function sandking_caustic_finale_custom:GetCooldown(iLevel)
if self:GetCaster():HasTalent("modifier_sand_king_finale_7") and false then
	return self:GetCaster():GetTalentValue("modifier_sand_king_finale_7", "cd")
end
return 
end



function sandking_caustic_finale_custom:OnAbilityPhaseStart()
self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.7)
return true
end

function sandking_caustic_finale_custom:OnAbilityPhaseInterrupted()
self:GetCaster():RemoveGesture(ACT_DOTA_ATTACK)
end


function sandking_caustic_finale_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sandking_caustic_finale_custom"
end


function sandking_caustic_finale_custom:OnSpellStart()
if true then return end

local target = self:GetCursorTarget()

for i = 1,3 do 
	local particle = ParticleManager:CreateParticle( "particles/sand_king/finale_legendary_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex( particle )
end

self:GetCaster():EmitSound("SandKing.Finale_legerndary_caster")

target:AddNewModifier(self:GetCaster(), self, "modifier_sandking_caustic_finale_custom_legendary", {duration = self:GetCaster():GetTalentValue("modifier_sand_king_finale_7", "duration")})
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sandking_caustic_finale_custom_legendary_caster", {duration = self:GetCaster():GetTalentValue("modifier_sand_king_finale_7", "duration")})

end 




function sandking_caustic_finale_custom:ProcTalents(unit)
local caster = self:GetCaster()
if caster:HasTalent("modifier_sand_king_finale_5")  then 
	local heal = caster:GetTalentValue("modifier_sand_king_finale_5", "heal")*caster:GetMaxHealth()/100

	if caster:GetHealthPercent() <= caster:GetTalentValue("modifier_sand_king_finale_5", "health") then 
		heal = heal*caster:GetTalentValue("modifier_sand_king_finale_5", "bonus")
	end 

	caster:GenericHeal(heal, self, nil, nil, "modifier_sand_king_finale_5")
end 

end 


function sandking_caustic_finale_custom:ApplyEffect(target)
if not IsServer() then return end
local caster = self:GetCaster()
if caster:PassivesDisabled() then return end

target:AddNewModifier(caster, self, "modifier_sandking_caustic_finale_custom_slow", {duration = self:GetSpecialValueFor("caustic_finale_duration")})
end 


function sandking_caustic_finale_custom:GetDamage()
local damage = self:GetSpecialValueFor("caustic_finale_damage")
if self:GetCaster():HasTalent("modifier_sand_king_finale_1") then 
	damage = damage + self:GetCaster():GetTalentValue("modifier_sand_king_finale_1","damage")
end 
return damage
end


function sandking_caustic_finale_custom:DealDamage(unit)
if not IsServer() then return end

local caster = self:GetCaster()
local damage = self:GetDamage()
local radius = self:GetSpecialValueFor("caustic_finale_radius")

self:ProcTalents(unit)

local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sandking_caustic_finale_explode_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
ParticleManager:SetParticleControlEnt( effect_cast, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex( effect_cast )

unit:EmitSound("Ability.SandKing_CausticFinale")

local targets = caster:FindTargets(radius, unit:GetAbsOrigin())

local damage_table = {attacker = caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL}

for _,target in pairs(targets) do
	damage_table.victim = target
	local real_damage = DoDamage(damage_table)
end 

end 



modifier_sandking_caustic_finale_custom = class({})

function modifier_sandking_caustic_finale_custom:IsHidden()
return not self:GetParent():HasTalent("modifier_sand_king_finale_5") or self:GetParent():GetHealthPercent() > self.low_health
end

function modifier_sandking_caustic_finale_custom:GetTexture() return "buffs/finale_lowhp" end
function modifier_sandking_caustic_finale_custom:IsPurgable() return false end
function modifier_sandking_caustic_finale_custom:OnCreated(table)

self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage_reduce = self.caster:GetTalentValue("modifier_sand_king_finale_5", "damage_reduce", true)
self.lowhp_bonus = self.caster:GetTalentValue("modifier_sand_king_finale_5", "bonus", true)
self.low_health = self.caster:GetTalentValue("modifier_sand_king_finale_5", "health", true)

self.caster:AddAttackEvent_out(self)

if not IsServer() then return end
self:UpdateTalent()
end 


function modifier_sandking_caustic_finale_custom:UpdateTalent(name)

if name == "modifier_sand_king_finale_5" or self.caster:HasTalent("modifier_sand_king_finale_5") then
	self:StartIntervalThink(0.2)
end

end


function modifier_sandking_caustic_finale_custom:AttackEvent_out(params)
if not IsServer() then return end 
if self.caster ~= params.attacker then return end 
if not params.target:IsUnit() then return end

self:GetAbility():ApplyEffect(params.target)
end 



function modifier_sandking_caustic_finale_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_sandking_caustic_finale_custom:GetModifierIncomingDamage_Percentage()
if not self.caster:HasTalent("modifier_sand_king_finale_5") then return end
local bonus = self.damage_reduce
if self.caster:GetHealthPercent() <= self.low_health then
	bonus = bonus*self.lowhp_bonus
end
return bonus
end


function modifier_sandking_caustic_finale_custom:OnIntervalThink()
if not IsServer() then return end

if self.parent:GetHealthPercent() <= self.low_health and not self.particle then 
	self.parent:EmitSound("Lc.Moment_Lowhp")
	self.particle = ParticleManager:CreateParticle( "particles/lc_lowhp.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 1, self.parent:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 2, self.parent:GetAbsOrigin() )
end

if self.parent:GetHealthPercent() > self.low_health and self.particle then
  ParticleManager:DestroyParticle(self.particle, false)
  ParticleManager:ReleaseParticleIndex(self.particle)
  self.particle = nil
end

end













modifier_sandking_caustic_finale_custom_slow = class({})
function modifier_sandking_caustic_finale_custom_slow:IsHidden() return true end
function modifier_sandking_caustic_finale_custom_slow:IsPurgable() return true end
function modifier_sandking_caustic_finale_custom_slow:GetTexture() return "sandking_caustic_finale" end
function modifier_sandking_caustic_finale_custom_slow:OnCreated()

self.ability = self:GetCaster():FindAbilityByName("sandking_caustic_finale_custom")

if not self.ability then 
	self:Destroy()
	return
end 

self.max = self.ability:GetSpecialValueFor("max_attacks")
self.parent = self:GetParent()

if not IsServer() then return end
self:SetStackCount(1)
end 

function modifier_sandking_caustic_finale_custom_slow:OnRefresh(table)
if not IsServer() then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
	self:SetStackCount(0)
	self.ability:DealDamage(self:GetParent())
end

end 

function modifier_sandking_caustic_finale_custom_slow:HideParticle()
if not IsServer() then return end 

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, true)
	ParticleManager:ReleaseParticleIndex(self.particle)
	self.particle = nil
end 

end 

function modifier_sandking_caustic_finale_custom_slow:ShowParticle()
if not IsServer() then return end 
if self:GetStackCount() == 0 then return end

if not self.particle then 
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
	self:AddParticle(self.particle, false, false, -1, false, false)
end

ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end 


function modifier_sandking_caustic_finale_custom_slow:OnStackCountChanged(iStackCount)
if not IsServer() then return end 
if self.parent:HasModifier("modifier_sandking_caustic_finale_custom_legendary") then return end

if self:GetStackCount() > 0 and not self.parent:HasModifier("modifier_sandking_scorpion_strike_custom_legendary_stack") then 
	self:ShowParticle()
else 
	self:HideParticle()
end 

end 


function modifier_sandking_caustic_finale_custom_slow:OnDestroy()
if not IsServer() then return end 

if not self:GetParent():IsAlive() then 
	self.ability:DealDamage(self:GetParent())
end 

end 






