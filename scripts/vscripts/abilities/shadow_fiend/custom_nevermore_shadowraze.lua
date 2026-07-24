--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_shadowraze_debuff", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_combo", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_speedmax", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_tracker", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_cd", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_auto", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_combo_heroes", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_slow_stack", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_requiem_fear_cd", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowraze_perma", "abilities/shadow_fiend/custom_nevermore_shadowraze", LUA_MODIFIER_MOTION_NONE)



custom_nevermore_shadowraze_close =  class({})
custom_nevermore_shadowraze_far = class({})
custom_nevermore_shadowraze_medium = class({})




function custom_nevermore_shadowraze_close:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end


PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nvm_atk_blur.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_nevermore/nvm_atk_blur_b.vpcf", context )

PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", context )
PrecacheResource( "particle","particles/sf_double_.vpcf", context )
PrecacheResource( "particle","particles/sf_refresh_a.vpcf", context )
PrecacheResource( "particle","particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_triple.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/rune_haste_owner.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context )
PrecacheResource( "particle","particles/sf_slow_attack.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )

dota1x6:PrecacheShopItems("npc_dota_hero_nevermore", context)
end




function custom_nevermore_shadowraze_close:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_nevermore_raze_2") then
	bonus = self:GetCaster():GetTalentValue("modifier_nevermore_raze_2", "cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end

function custom_nevermore_shadowraze_medium:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_nevermore_raze_2") then
	bonus = self:GetCaster():GetTalentValue("modifier_nevermore_raze_2", "cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end

function custom_nevermore_shadowraze_far:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_nevermore_raze_2") then
	bonus = self:GetCaster():GetTalentValue("modifier_nevermore_raze_2", "cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end




function custom_nevermore_shadowraze_close:GetCooldown(iLevel)
local upgrade_cooldown = 0 
if self:GetCaster():HasTalent("modifier_nevermore_raze_2") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_nevermore_raze_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function custom_nevermore_shadowraze_medium:GetCooldown(iLevel)
local upgrade_cooldown = 0 
if self:GetCaster():HasTalent("modifier_nevermore_raze_2") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_nevermore_raze_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function custom_nevermore_shadowraze_far:GetCooldown(iLevel)
local upgrade_cooldown = 0 
if self:GetCaster():HasTalent("modifier_nevermore_raze_2") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_nevermore_raze_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end



function custom_nevermore_shadowraze_far:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_nevermore_raze_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_nevermore_raze_1", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end

function custom_nevermore_shadowraze_medium:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_nevermore_raze_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_nevermore_raze_1", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end

function custom_nevermore_shadowraze_close:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_nevermore_raze_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_nevermore_raze_1", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end


	






function custom_nevermore_shadowraze_close:GetIntrinsicModifierName()
return "modifier_custom_shadowraze_tracker"
end


function custom_nevermore_shadowraze_close:GetAbilityTextureName()
    return wearables_system:GetAbilityIconReplacement(self.caster, "nevermore_shadowraze1", self)
end

function custom_nevermore_shadowraze_close:IsHiddenWhenStolen()
	return false
end


function custom_nevermore_shadowraze_close:OnUpgrade()
	local caster = self:GetCaster()
	UpgradeShadowRazes(caster, self)
end



function custom_nevermore_shadowraze_close:OnSpellStart()
	-- Ability properties
	local caster = self:GetCaster()
	local ability = self
	local cast_response = {"nevermore_nev_ability_shadow_07", "nevermore_nev_ability_shadow_18", "nevermore_nev_ability_shadow_21"}
	local sound_raze = wearables_system:GetSoundReplacement(caster, "Hero_Nevermore.Shadowraze", self)
	caster:EmitSound(sound_raze)

	-- Ability specials
	local raze_radius = ability:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = ability:GetSpecialValueFor("shadowraze_range")


	local raze_point = caster:GetAbsOrigin() + caster:GetForwardVector() * raze_distance

	CastShadowRazeOnPoint(caster, ability, raze_point, raze_radius)

end


------------------------------------
--     SHADOW RAZE (MEDIUM)       --
------------------------------------




function custom_nevermore_shadowraze_medium:GetAbilityTextureName()
   return wearables_system:GetAbilityIconReplacement(self.caster, "nevermore_shadowraze2", self)
end

function custom_nevermore_shadowraze_medium:IsHiddenWhenStolen()
	return false
end



function custom_nevermore_shadowraze_medium:OnUpgrade()
	local caster = self:GetCaster()
	UpgradeShadowRazes(caster, self)
end



function custom_nevermore_shadowraze_medium:OnSpellStart()
	-- Ability properties
	local caster = self:GetCaster()
	local ability = self
	local cast_response = {"nevermore_nev_ability_shadow_08", "nevermore_nev_ability_shadow_20", "nevermore_nev_ability_shadow_22"}
	local sound_raze = wearables_system:GetSoundReplacement(caster, "Hero_Nevermore.Shadowraze", self)
	caster:EmitSound(sound_raze)

	-- Ability specials
	local raze_radius = ability:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = ability:GetSpecialValueFor("shadowraze_range")


	local raze_point = caster:GetAbsOrigin() + caster:GetForwardVector() * raze_distance

	CastShadowRazeOnPoint(caster, ability, raze_point, raze_radius)


end

------------------------------------
--       SHADOW RAZE (FAR)        --
------------------------------------




function custom_nevermore_shadowraze_far:GetAbilityTextureName()
   return wearables_system:GetAbilityIconReplacement(self.caster, "nevermore_shadowraze3", self)
end

function custom_nevermore_shadowraze_far:IsHiddenWhenStolen()
	return false
end



function custom_nevermore_shadowraze_far:OnUpgrade()
	local caster = self:GetCaster()
	UpgradeShadowRazes(caster, self)
end

function custom_nevermore_shadowraze_far:OnSpellStart()
	-- Ability properties
	local caster = self:GetCaster()
	local ability = self
	local cast_response = {"nevermore_nev_ability_shadow_11", "nevermore_nev_ability_shadow_19", "nevermore_nev_ability_shadow_23"}
	local sound_raze = wearables_system:GetSoundReplacement(caster, "Hero_Nevermore.Shadowraze", self)
	caster:EmitSound(sound_raze)
	local raze_radius = ability:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = ability:GetSpecialValueFor("shadowraze_range")

	local raze_point = caster:GetAbsOrigin() + caster:GetForwardVector() * raze_distance

	CastShadowRazeOnPoint(caster, ability, raze_point, raze_radius)


end


-------------------------
-- Shadowraze Handlers --
-------------------------


function CastShadowRazeOnPoint(caster, ability, point, radius, auto)

local particle_raze = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", ability)

local fear_duration = caster:GetTalentValue("modifier_nevermore_raze_5", "fear", true)
local fear_cd = caster:GetTalentValue("modifier_nevermore_raze_5", "cd", true)

local stun_duration = caster:GetTalentValue("modifier_nevermore_raze_4", "stun", true)

local particle_raze_fx = ParticleManager:CreateParticle(particle_raze, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle_raze_fx, 0, point)
ParticleManager:SetParticleControl(particle_raze_fx, 1, Vector(radius, 1, 1))
ParticleManager:ReleaseParticleIndex(particle_raze_fx)

local enemies = caster:FindTargets(radius, point) 

local creeps = 0 
local heroes = 0
local damage_ability = nil
if auto then 
	damage_ability = "modifier_nevermore_raze_4"
end

for _,enemy in pairs(enemies) do

	if enemy:IsCreep() or enemy:IsIllusion() then 
		creeps = creeps + 1
	end

	if enemy:IsRealHero() then 
		heroes = heroes + 1
	end

	if caster:HasTalent("modifier_nevermore_raze_5") and ability:GetAbilityName() == "custom_nevermore_shadowraze_close" and not auto and not enemy:HasModifier("modifier_nevermore_requiem_fear_cd") then
		enemy:AddNewModifier(caster, ability, "modifier_nevermore_requiem_fear", {duration = fear_duration * (1 - enemy:GetStatusResistance())})
		enemy:AddNewModifier(caster, ability, "modifier_nevermore_requiem_fear_cd", {duration = fear_cd})
		enemy:EmitSound("Sf.Raze_Stun")
	end	

	if auto then 
		enemy:AddNewModifier(caster, ability, "modifier_stunned", {duration = stun_duration*(1 - enemy:GetStatusResistance())})
	end

	ApplyShadowRazeDamage(caster, ability, enemy, damage_ability)
end

if #enemies > 0 then 

	if caster:HasTalent("modifier_nevermore_raze_3") then 
		caster:AddNewModifier(caster, ability, "modifier_custom_shadowraze_speedmax", {duration =  caster:GetTalentValue("modifier_nevermore_raze_3", "duration")})
	end

	if caster:HasTalent("modifier_nevermore_raze_7") then 	
		caster:AddNewModifier(caster, ability, "modifier_custom_shadowraze_combo", {duration = caster:GetTalentValue("modifier_nevermore_raze_7", "timer", true)})
	end

	local ult_ability = caster:FindAbilityByName("custom_nevermore_requiem")
	if ult_ability and heroes > 0 then 
		ult_ability:LegendaryStack(caster:GetTalentValue("modifier_nevermore_requiem_7", "raze", true))
	end

	if caster:HasTalent("modifier_nevermore_raze_6") then
		caster:CdItems(caster:GetTalentValue("modifier_nevermore_raze_6", "cd_items"))
	end

	if heroes > 0 then 
		caster:AddNewModifier(caster, ability, "modifier_custom_shadowraze_perma", {})
		caster:AddNewModifier(caster, ability, "modifier_custom_shadowraze_combo_heroes", {duration = caster:GetTalentValue("modifier_nevermore_raze_7", "timer", true)})
	end
end

end


function ApplyShadowRazeDamage(caster, ability, enemy, damage_ability)

local damage = ability:GetSpecialValueFor("shadowraze_damage") + caster:GetTalentValue("modifier_nevermore_raze_1", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
local stack_bonus_damage = ability:GetSpecialValueFor("stack_bonus_damage")
local duration = ability:GetSpecialValueFor("duration") + caster:GetTalentValue("modifier_nevermore_raze_7", "duration")

if caster:HasTalent("modifier_nevermore_raze_7") then 
	damage = damage*(1 + caster:GetTalentValue("modifier_nevermore_raze_7", "damage")/100)	
end

if enemy:HasModifier("modifier_custom_shadowraze_debuff") then
	damage = damage + enemy:FindModifierByName("modifier_custom_shadowraze_debuff"):GetStackCount() * (stack_bonus_damage )
end
	
local damageTable = {victim = enemy,damage = damage,damage_type = DAMAGE_TYPE_MAGICAL,attacker = caster,ability = ability}
local actualy_damage = DoDamage(damageTable, damage_ability)    
	
enemy:AddNewModifier(caster, ability, "modifier_custom_shadowraze_debuff", {duration = duration})

if caster:HasTalent("modifier_nevermore_raze_5") then
	enemy:AddNewModifier(caster, ability, "modifier_custom_shadowraze_slow_stack", {duration = caster:GetTalentValue("modifier_nevermore_raze_5", "duration")})
end

end



function UpgradeShadowRazes(caster, ability)
local raze_close = "custom_nevermore_shadowraze_close"
local raze_medium = "custom_nevermore_shadowraze_medium"
local raze_far = "custom_nevermore_shadowraze_far"

-- Get handles
local raze_close_handler
local raze_medium_handler
local raze_far_handler

if caster:HasAbility(raze_close) then
	raze_close_handler = caster:FindAbilityByName(raze_close)
end

if caster:HasAbility(raze_medium) then
	raze_medium_handler = caster:FindAbilityByName(raze_medium)
end

if caster:HasAbility(raze_far) then
	raze_far_handler = caster:FindAbilityByName(raze_far)
end

-- Get the level to compare
local leveled_ability_level = ability:GetLevel()

if raze_close_handler and raze_close_handler:GetLevel() < leveled_ability_level then
	raze_close_handler:SetLevel(leveled_ability_level)
end

if raze_medium_handler and raze_medium_handler:GetLevel() < leveled_ability_level then
	raze_medium_handler:SetLevel(leveled_ability_level)
end

if raze_far_handler and raze_far_handler:GetLevel() < leveled_ability_level then
	raze_far_handler:SetLevel(leveled_ability_level)
end
end




modifier_custom_shadowraze_debuff = class ({})
function modifier_custom_shadowraze_debuff:IsPurgable() return not self:GetCaster():HasTalent("modifier_nevermore_raze_7") end
function modifier_custom_shadowraze_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_TOOLTIP,
}
end

function modifier_custom_shadowraze_debuff:OnTooltip()
return self:GetStackCount() * self.damage
end


function modifier_custom_shadowraze_debuff:OnCreated(table)
self.RemoveForDuel = true
self.damage = self:GetAbility():GetSpecialValueFor("stack_bonus_damage")
self:SetStackCount(1)
end

function modifier_custom_shadowraze_debuff:OnRefresh(table)
if not IsServer() then return end 
self:IncrementStackCount()
end





modifier_custom_shadowraze_combo = class({})
function modifier_custom_shadowraze_combo:IsHidden() return false end
function modifier_custom_shadowraze_combo:IsPurgable() return false end

function modifier_custom_shadowraze_combo:OnCreated(table)
if not IsServer() then return end
self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_nevermore_raze_7", "max", true)
self:SetStackCount(1)
end

function modifier_custom_shadowraze_combo:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max  then return end
self:IncrementStackCount()

if self:GetStackCount() == 2 and self.caster:HasTalent("modifier_nevermore_raze_7") then 
	self.caster:GenericParticle("particles/sf_double_.vpcf")
end

if self:GetStackCount() >= self.max then 

	if self.caster:HasTalent("modifier_nevermore_raze_7") then 

		local ability = self.caster:FindAbilityByName("custom_nevermore_shadowraze_close")
		if ability then 
			ability:EndCd(0)
			ability:StartCooldown(0.1)
		end

		ability = self.caster:FindAbilityByName("custom_nevermore_shadowraze_medium")
		if ability then 
			ability:EndCd(0)
			ability:StartCooldown(0.1)
		end

		ability = self.caster:FindAbilityByName("custom_nevermore_shadowraze_far")
		if ability then 
			ability:EndCd(0)
			ability:StartCooldown(0.1)
		end

		local particle = ParticleManager:CreateParticle("particles/sf_refresh_a.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
		ParticleManager:SetParticleControlEnt( particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
		ParticleManager:ReleaseParticleIndex(particle)

		self.particle_head = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_triple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControl( self.particle_head, 0,  self.caster:GetOrigin())
		ParticleManager:ReleaseParticleIndex(self.particle_head)
	 	ParticleManager:DestroyParticle(self.particle_head, false)

		self.caster:EmitSound("Hero_Rattletrap.Overclock.Cast")	
	end
	self:Destroy()
end

end


modifier_custom_shadowraze_combo_heroes = class({})
function modifier_custom_shadowraze_combo_heroes:IsHidden() return true end
function modifier_custom_shadowraze_combo_heroes:IsPurgable() return false end

function modifier_custom_shadowraze_combo_heroes:OnCreated(table)
if not IsServer() then return end
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.max = self.caster:GetTalentValue("modifier_nevermore_raze_7", "max", true)
self:SetStackCount(1)
end

function modifier_custom_shadowraze_combo_heroes:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() == 2 and false and not self.caster:HasTalent("modifier_nevermore_raze_7") then 
	self.caster:GenericParticle("particles/sf_double_.vpcf")
end

if self:GetStackCount() >= self.max then 

	if self.caster:GetQuest() == "Never.Quest_5" then 
		self.caster:UpdateQuest(1)
	end

	if false and not self.caster:HasTalent("modifier_nevermore_raze_7") then 
		self.particle_head = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_triple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControl( self.particle_head, 0,  self.caster:GetOrigin())
		ParticleManager:ReleaseParticleIndex(self.particle_head)
	 	ParticleManager:DestroyParticle(self.particle_head, false)
 	end

	self:Destroy()
end

end





modifier_custom_shadowraze_speedmax = class({})

function modifier_custom_shadowraze_speedmax:IsPurgable() return true end
function modifier_custom_shadowraze_speedmax:IsHidden() return false end
function modifier_custom_shadowraze_speedmax:GetTexture() return "buffs/raze_speed" end

function modifier_custom_shadowraze_speedmax:OnCreated(table)
self.parent = self:GetParent()
self.move = self.parent :GetTalentValue("modifier_nevermore_raze_3", "speed")
self.heal = self.parent :GetTalentValue("modifier_nevermore_raze_3", "heal")
self.max = self.parent :GetTalentValue("modifier_nevermore_raze_3", "max")

if not IsServer() then return end
self:SetStackCount(1)  
end

function modifier_custom_shadowraze_speedmax:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_shadowraze_speedmax:GetEffectName()
return "particles/generic_gameplay/rune_haste_owner.vpcf"
end

function modifier_custom_shadowraze_speedmax:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end

function modifier_custom_shadowraze_speedmax:GetModifierMoveSpeedBonus_Percentage() 
return self.move*self:GetStackCount()
end

function modifier_custom_shadowraze_speedmax:GetModifierConstantHealthRegen()
return self.heal*self:GetStackCount()
end






modifier_custom_shadowraze_tracker = class({})
function modifier_custom_shadowraze_tracker:IsHidden() return true end
function modifier_custom_shadowraze_tracker:IsPurgable() return false end
function modifier_custom_shadowraze_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.parent:GetTalentValue("modifier_nevermore_raze_4", "radius", true)
self.delay = self.parent:GetTalentValue("modifier_nevermore_raze_4", "delay", true)
self:StartIntervalThink(1)
end

function modifier_custom_shadowraze_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if not self.parent:HasTalent("modifier_nevermore_raze_4") then return end
if self.parent:HasModifier("modifier_custom_shadowraze_cd") then return end
if self.parent:IsInvisible() then return end

local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius,  DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)

if #enemies > 0 then
	local cd = self.parent:GetTalentValue("modifier_nevermore_raze_4", "cd")
	CreateModifierThinker(self.parent, self.ability, "modifier_custom_shadowraze_auto", {duration = self.delay}, enemies[1]:GetAbsOrigin(), self.parent:GetTeamNumber(), false)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_shadowraze_cd", {duration = cd})
	self:StartIntervalThink(cd)
else
	self:StartIntervalThink(0.2)
end

end





modifier_custom_shadowraze_cd = class({})
function modifier_custom_shadowraze_cd:IsHidden() return false end
function modifier_custom_shadowraze_cd:IsPurgable() return false end
function modifier_custom_shadowraze_cd:GetTexture() return "buffs/raze_burn" end
function modifier_custom_shadowraze_cd:IsDebuff() return true end
function modifier_custom_shadowraze_cd:RemoveOnDeath() return false end





modifier_custom_shadowraze_auto = class({})

function modifier_custom_shadowraze_auto:IsHidden() return true end
function modifier_custom_shadowraze_auto:IsPurgable() return false end
function modifier_custom_shadowraze_auto:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.radius = self.ability:GetSpecialValueFor("shadowraze_radius")*self.caster:GetTalentValue("modifier_nevermore_raze_4", "aoe")

self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius/self:GetRemainingTime()) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )
end


function modifier_custom_shadowraze_auto:OnDestroy(table)
if not IsServer() then return end
if not self.caster then return end
if not self.caster:IsAlive() then return end

local sound_raze = wearables_system:GetSoundReplacement(self.caster, "Hero_Nevermore.Shadowraze", self)
self.parent:EmitSound(sound_raze)

CastShadowRazeOnPoint(self.caster, self.ability, self.parent:GetAbsOrigin(), self.radius, true)
end






modifier_custom_shadowraze_slow_stack = class({})
function modifier_custom_shadowraze_slow_stack:IsHidden() return false end
function modifier_custom_shadowraze_slow_stack:IsPurgable() return true end
function modifier_custom_shadowraze_slow_stack:GetTexture() return "buffs/trample_stack" end
function modifier_custom_shadowraze_slow_stack:OnCreated(table)

self.slow = self:GetCaster():GetTalentValue("modifier_nevermore_raze_5", "slow")
self.max = self:GetCaster():GetTalentValue("modifier_nevermore_raze_5", "max")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_custom_shadowraze_slow_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_shadowraze_slow_stack:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_custom_shadowraze_slow_stack:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.slow
end





modifier_nevermore_requiem_fear_cd = class({})
function modifier_nevermore_requiem_fear_cd:IsHidden() return true end
function modifier_nevermore_requiem_fear_cd:IsPurgable() return false end
function modifier_nevermore_requiem_fear_cd:RemoveOnDeath() return false end
function modifier_nevermore_requiem_fear_cd:OnCreated()
if not IsServer() then return end

self.RemoveForDuel = true
end 





modifier_custom_shadowraze_perma = class({})
function modifier_custom_shadowraze_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_nevermore_raze_6") end
function modifier_custom_shadowraze_perma:IsPurgable() return false end
function modifier_custom_shadowraze_perma:RemoveOnDeath() return false end
function modifier_custom_shadowraze_perma:GetTexture() return "buffs/wrath_perma" end
function modifier_custom_shadowraze_perma:OnCreated(table)

self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_nevermore_raze_6", "max", true)
self.cdr = self.caster:GetTalentValue("modifier_nevermore_raze_6", "cdr", true)/self.max

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_custom_shadowraze_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.caster:HasTalent("modifier_nevermore_raze_6") then return end

local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControl(particle_peffect, 0, self.caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.caster:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.caster:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_custom_shadowraze_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

end


function modifier_custom_shadowraze_perma:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_custom_shadowraze_perma:GetModifierPercentageCooldown() 
if not self.caster:HasTalent("modifier_nevermore_raze_6") then return end
return self:GetStackCount()*self.cdr
end
