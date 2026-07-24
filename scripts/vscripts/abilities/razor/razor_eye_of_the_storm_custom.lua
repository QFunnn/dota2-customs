--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_eye_of_the_storm_custom", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_debuff", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_tracker", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_cloud", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_legendary", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_slow", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_damage", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_cd", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_root", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_attack_proc", "abilities/razor/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)

razor_eye_of_the_storm_custom = class({})
		



function razor_eye_of_the_storm_custom:CreateTalent()
local mod = self:GetCaster():FindModifierByName("modifier_razor_eye_of_the_storm_custom_tracker")
if mod then
	mod:UpdateJs()
end

end


function razor_eye_of_the_storm_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )
PrecacheResource( "particle","particles/razor/razor_rain_storm_new.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_nullifier.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", context )
PrecacheResource( "particle","particles/razor/storm_legendary.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/rune_doubledamage_owner.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_troll_warlord_battletrance.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/gleipnir_root.vpcf", context )

end



function razor_eye_of_the_storm_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "razor_eye_of_the_storm", self)
end

function razor_eye_of_the_storm_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_razor_eye_of_the_storm_custom_tracker"
end

function razor_eye_of_the_storm_custom:GetBehavior()
local bonus = 0 
if self:GetCaster():HasTalent("modifier_razor_eye_6") then 
	bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end

function razor_eye_of_the_storm_custom:GetCastRange(vLocation, hTarget)
return self:GetSpecialValueFor( "radius" ) + self:GetCaster():GetTalentValue("modifier_razor_eye_5", "radius") - self:GetCaster():GetCastRangeBonus()
end

function razor_eye_of_the_storm_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_razor_eye_3") then
	bonus = self:GetCaster():GetTalentValue("modifier_razor_eye_3", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function razor_eye_of_the_storm_custom:OnSpellStart()
local caster = self:GetCaster()
 
if caster:HasTalent("modifier_razor_eye_6") then 
	caster:AddNewModifier(caster, self, "modifier_razor_eye_of_the_storm_custom_damage", {duration = caster:GetTalentValue("modifier_razor_eye_6", "duration")})

	caster:EmitSound("Brewmaster_Storm.DispelMagic")
	caster:Purge(false, true, false, true, true)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
end 

local duration = self:GetSpecialValueFor( "duration" ) + self:GetCaster():GetTalentValue("modifier_razor_eye_3", "duration")
caster:AddNewModifier(caster, self, "modifier_razor_eye_of_the_storm_custom",  { duration = duration } )
end




modifier_razor_eye_of_the_storm_custom = class({})
function modifier_razor_eye_of_the_storm_custom:IsHidden() return false end
function modifier_razor_eye_of_the_storm_custom:IsPurgable() return false end
 
function modifier_razor_eye_of_the_storm_custom:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddDamageEvent_out(self)

self.radius = self.ability:GetSpecialValueFor( "radius" ) + self.parent:GetTalentValue("modifier_razor_eye_5", "radius")
self.damage = self.ability:GetSpecialValueFor( "damage" ) + self.parent:GetTalentValue("modifier_razor_eye_1", "damage")
self.interval = self.ability:GetSpecialValueFor( "strike_interval" )

self.attack_damage = self.parent:GetTalentValue("modifier_razor_eye_1", "attack_damage")
self.attack_damage_max = self.parent:GetTalentValue("modifier_razor_eye_1", "max", true)

self.max_targets = 1
if self.parent:HasScepter() then 
	self.interval  = self.interval + self.ability:GetSpecialValueFor("scepter_interval")
	self.max_targets  = self.max_targets + self.ability:GetSpecialValueFor("scepter_targets")
end 

self.attack_count = 0
self.attack_max = self.parent:GetTalentValue("modifier_razor_eye_4", "max")
self.speed_bonus = self.parent:GetTalentValue("modifier_razor_eye_4", "speed")

if not IsServer() then return end
self.ability:EndCd()
self.RemoveForDuel = true

self.cloud_unit = CreateUnitByName("npc_dota_companion", self.parent:GetAbsOrigin(), false, self.parent, nil, self.parent:GetTeam())
self.cloud_unit:AddNewModifier(self.parent, self.ability, "modifier_phased", {})
self.cloud_unit:AddNewModifier(self.parent, self.ability, "modifier_razor_eye_of_the_storm_custom_cloud", {})

self.abilityDamageType = self.ability:GetAbilityDamageType()
  
self.damageTable = { attacker = self.parent, damage = self.damage, damage_type = self.abilityDamageType, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK }
 

self.bonus = self.parent:GetTalentValue("modifier_razor_eye_7", "bonus")
self.legendary_heal = self.parent:GetTalentValue("modifier_razor_eye_7", "heal")/100
self.legendary_heal_creeps = self.parent:GetTalentValue("modifier_razor_eye_7", "creeps")
self:SetStackCount(0)

self.root_duration = self.parent:GetTalentValue("modifier_razor_eye_5", "root")
self.root_cd = self.parent:GetTalentValue("modifier_razor_eye_5", "cd")

if self.parent:HasTalent("modifier_razor_eye_7") then 
	local ability = self.parent:FindAbilityByName("razor_eye_of_the_storm_custom_legendary")
	if ability and ability:IsHidden() then 
		self.parent:SwapAbilities(self.ability:GetName(), ability:GetName(), false, true)
	end 
	local mod = self.parent:FindModifierByName("modifier_razor_eye_of_the_storm_custom_tracker")
	if mod then 
		mod:UpdateJs()
	end 
end 

self:StartIntervalThink( self.interval  )
self:PlayEffects1()
end

 
function modifier_razor_eye_of_the_storm_custom:OnDestroy()
if not IsServer() then return end 

self.ability:StartCd()

if self.cloud_unit and not self.cloud_unit:IsNull() then 
	UTIL_Remove(self.cloud_unit)
end 

if self.parent:HasTalent("modifier_razor_eye_7") then 
	local ability = self.parent:FindAbilityByName("razor_eye_of_the_storm_custom_legendary")
	if ability and not ability:IsHidden() then 
		self.parent:SwapAbilities(self.ability:GetName(), ability:GetName(),  true, false)
	end 
end 

local mod = self.parent:FindModifierByName("modifier_razor_eye_of_the_storm_custom_tracker")
if mod then 
	mod:SetStackCount(0)
	mod:UpdateJs()
end 

self.parent:RemoveModifierByName("modifier_razor_eye_of_the_storm_custom_legendary")
self.parent:EmitSound("Hero_Razor.StormEnd")
self.parent:StopSound("Hero_Razor.Storm.Loop")
end


function modifier_razor_eye_of_the_storm_custom:Show()
if not IsServer() then return end
if self.effect_cast then return end
local particle_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/razor/razor_rain_storm_new.vpcf", self)

self.effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(self.radius, 1, 1) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )
end 


function modifier_razor_eye_of_the_storm_custom:Hide()
if not IsServer() then return end

if self.effect_cast then 
	ParticleManager:DestroyParticle(self.effect_cast, false)
 	ParticleManager:ReleaseParticleIndex(self.effect_cast)
 	self.effect_cast = nil
end

end 

  
function modifier_razor_eye_of_the_storm_custom:OnIntervalThink()
if not IsServer() then return end
self.interval = self.ability:GetSpecialValueFor( "strike_interval" )

if self.parent:HasScepter() then 
	self.interval  = self.interval + self.ability:GetSpecialValueFor("scepter_interval")
end 

if self.parent:HasTalent("modifier_razor_eye_7") and self.bonus ~= 0 and self.parent:HasTalent("modifier_razor_eye_of_the_storm_custom_legendary") then 
	self.interval = self.interval/self.bonus
end 

local targets = {}
local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
local creeps = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

local targets = {}
local link_target = nil
local mod = self.parent:FindModifierByName("modifier_razor_static_link_custom")

if mod and mod.target and (self.parent:GetAbsOrigin() - mod.target:GetAbsOrigin()):Length2D() <= self.radius then 
	link_target = mod.target
 	table.insert(targets, mod.target)
end 

for _,hero in pairs(heroes) do 

	if #targets < self.max_targets then
		if not link_target or link_target ~= hero then 
 			table.insert(targets, hero)
 		end 
	else 
		break
	end 
end 

for _,creep in pairs(creeps) do 
	if #targets < self.max_targets then
		if (not link_target or link_target ~= creep) and creep:GetUnitName() ~= "npc_teleport" then 
 			table.insert(targets, creep)
 		end 
	else 
		break
	end 
end 
if #targets > 0 then 
	self:IncrementStackCount()	
	local attack = false
	if self.parent:HasTalent("modifier_razor_eye_4") then
		self.attack_count = self.attack_count + 1
		if self.attack_count >= self.attack_max then
			self.attack_count = 0
			attack = true
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_razor_eye_of_the_storm_custom_attack_proc", {duration = FrameTime()})
		end
	end	

	for _,enemy in pairs(targets) do 
		self:Hit(enemy, attack)
	end

	if self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom_attack_proc") then
		self.parent:RemoveModifierByName("modifier_razor_eye_of_the_storm_custom_attack_proc")
	end
end
self:StartIntervalThink(self.interval)
end
 

function modifier_razor_eye_of_the_storm_custom:Hit(enemy, perform_attack)
if not IsServer() then return end

self.damageTable.victim = enemy
DoDamage( self.damageTable )

enemy:AddNewModifier(self.parent, self.ability,  "modifier_razor_eye_of_the_storm_custom_debuff", { duration = self:GetRemainingTime()})

if not enemy:HasTalent("modifier_razor_eye_of_the_storm_custom_cd") and self.parent:HasTalent("modifier_razor_eye_5") and self.root_cd > 0 then 
	enemy:AddNewModifier(self.parent, self.ability, "modifier_razor_eye_of_the_storm_custom_root", {duration = (1 - enemy:GetStatusResistance())*self.root_duration})
	enemy:AddNewModifier(self.parent, self.ability, "modifier_razor_eye_of_the_storm_custom_cd", {duration = self.root_cd})
	enemy:EmitSound("Razor.Storm_root")
end

if self.parent:HasTalent("modifier_razor_eye_4") and perform_attack then 

    local particle_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf", self)
	local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_whip", self.parent:GetAbsOrigin(), true  )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true  )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy ) )

	self.parent:PerformAttack(enemy, true, true, true, true, false, false, true)
	enemy:EmitSound("Razor.Storm_attack")
end 

self:PlayEffects2( enemy)
end 



function modifier_razor_eye_of_the_storm_custom:PlayEffects1()
if not IsServer() then return end
self:Show()
self.parent:EmitSound("Hero_Razor.Storm.Cast")
self.parent:EmitSound("Hero_Razor.Storm.Loop")
end


function modifier_razor_eye_of_the_storm_custom:PlayEffects2( enemy )
if not IsServer() then return end
local particle_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf", self)

local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_ABSORIGIN_FOLLOW, self.cloud_unit )
ParticleManager:SetParticleControl( effect_cast, 0, self.cloud_unit:GetAbsOrigin() )
ParticleManager:SetParticleControlEnt( effect_cast, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true  )
ParticleManager:ReleaseParticleIndex( effect_cast )
enemy:EmitSound("Hero_razor.lightning")
end

function modifier_razor_eye_of_the_storm_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_razor_eye_of_the_storm_custom:DamageEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom_legendary") then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = params.damage*self.legendary_heal 

if params.unit:IsCreep() then 
	heal = heal/self.legendary_heal_creeps
end 

self.parent:GenericHeal(heal, self.ability, false, "", "modifier_razor_eye_7")
end

function modifier_razor_eye_of_the_storm_custom:GetModifierPreAttack_BonusDamage()
if not self.parent:HasTalent("modifier_razor_eye_1") then return end
return self.attack_damage*math.min(self.attack_damage_max, self:GetStackCount())
end

function modifier_razor_eye_of_the_storm_custom:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_razor_eye_4") then return end
return self.speed_bonus*self:GetStackCount()
end

function modifier_razor_eye_of_the_storm_custom:GetAuraRadius()
return self.radius
end

function modifier_razor_eye_of_the_storm_custom:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_razor_eye_of_the_storm_custom:GetAuraSearchType() 
return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end


function modifier_razor_eye_of_the_storm_custom:GetModifierAura()
return "modifier_razor_eye_of_the_storm_custom_slow"
end

function modifier_razor_eye_of_the_storm_custom:IsAura()
return self.parent:IsRealHero() and self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom_legendary")
end





modifier_razor_eye_of_the_storm_custom_slow = class({})
function modifier_razor_eye_of_the_storm_custom_slow:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_slow:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_razor_eye_7", "slow")
end

function modifier_razor_eye_of_the_storm_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_razor_eye_of_the_storm_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_razor_eye_of_the_storm_custom_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_nullifier.vpcf"
end

function modifier_razor_eye_of_the_storm_custom_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end






modifier_razor_eye_of_the_storm_custom_debuff = class({})
function modifier_razor_eye_of_the_storm_custom_debuff:IsHidden() return false end
function modifier_razor_eye_of_the_storm_custom_debuff:IsPurgable() return false end
 
function modifier_razor_eye_of_the_storm_custom_debuff:OnCreated( kv )
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.armor = self.ability:GetSpecialValueFor("armor_reduction")
self.heal_reduce = self.ability:GetSpecialValueFor("scepter_heal_reduce")
self.heal_reduce_max = self.ability:GetSpecialValueFor("scepter_heal_reduce_max")

if not IsServer() then return end 
self.RemoveForDuel = true
self:SetStackCount(1)
end

function modifier_razor_eye_of_the_storm_custom_debuff:OnRefresh( kv )
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_razor_eye_of_the_storm_custom_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
 	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
 	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_razor_eye_of_the_storm_custom_debuff:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.armor
end

function modifier_razor_eye_of_the_storm_custom_debuff:GetModifierLifestealRegenAmplify_Percentage() 
if not self.caster:HasScepter() then return end
return self.heal_reduce*math.min(self.heal_reduce_max, self:GetStackCount())
end

function modifier_razor_eye_of_the_storm_custom_debuff:GetModifierHealChange()
if not self.caster:HasScepter() then return end 
return self.heal_reduce*math.min(self.heal_reduce_max, self:GetStackCount())
end

function modifier_razor_eye_of_the_storm_custom_debuff:GetModifierHPRegenAmplify_Percentage()
if not self.caster:HasScepter() then return end 
return self.heal_reduce*math.min(self.heal_reduce_max, self:GetStackCount())
end









modifier_razor_eye_of_the_storm_custom_cloud = class({})
function modifier_razor_eye_of_the_storm_custom_cloud:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_cloud:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_cloud:CheckState()
return	
{
	[MODIFIER_STATE_NO_TEAM_MOVE_TO] 	= true,
	[MODIFIER_STATE_NO_TEAM_SELECT] 	= true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	[MODIFIER_STATE_ATTACK_IMMUNE] 		= true,
	[MODIFIER_STATE_MAGIC_IMMUNE] 		= true,
	[MODIFIER_STATE_INVULNERABLE] 		= true,
	[MODIFIER_STATE_UNSELECTABLE] 		= true,
	[MODIFIER_STATE_INVULNERABLE] 		= true,
	[MODIFIER_STATE_NOT_ON_MINIMAP] 	= true,
	[MODIFIER_STATE_NO_HEALTH_BAR] 		= true,
	[MODIFIER_STATE_FLYING] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
}
end

function modifier_razor_eye_of_the_storm_custom_cloud:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetCaster()
self.cloud_unit = self:GetParent()
self:SetStackCount(500)
self:OnIntervalThink()
self:StartIntervalThink(0.01)
end 

function modifier_razor_eye_of_the_storm_custom_cloud:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_VISUAL_Z_DELTA,
}
end

function modifier_razor_eye_of_the_storm_custom_cloud:GetVisualZDelta()
return self:GetStackCount()
end


function modifier_razor_eye_of_the_storm_custom_cloud:OnIntervalThink()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end
self.cloud_unit:SetAbsOrigin(GetGroundPosition(self.parent:GetAbsOrigin(), nil))
end 

function modifier_razor_eye_of_the_storm_custom_cloud:OnDestroy()
if not IsServer() then return end 

if self.unit and not self.unit:IsNull() then 
	UTIL_Remove(self.unit)
	self.unit = nil
end 
end





razor_eye_of_the_storm_custom_legendary = class({})


function razor_eye_of_the_storm_custom_legendary:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_razor_eye_7", "cd")
end 

function razor_eye_of_the_storm_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_razor_eye_of_the_storm_custom_tracker")

if not mod then return end 
local stack = mod:GetStackCount()
if mod:GetStackCount() == 0 then return end
mod:SetStackCount(0)

local min = caster:GetTalentValue("modifier_razor_eye_7", "duration_min")
local max = caster:GetTalentValue("modifier_razor_eye_7", "duration_max")
local stack_max = caster:GetTalentValue("modifier_razor_eye_7", "max")

local duration = min + (max - min)*(stack/stack_max)
caster:AddNewModifier(caster, self, "modifier_razor_eye_of_the_storm_custom_legendary", {duration = duration})
end



modifier_razor_eye_of_the_storm_custom_legendary = class({})
function modifier_razor_eye_of_the_storm_custom_legendary:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_legendary:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_legendary:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.legendary_ability = self:GetAbility()

self.legendary_ability:EndCd()

self.mod = self.parent:FindModifierByName("modifier_razor_eye_of_the_storm_custom")
self.tracker = self.parent:FindModifierByName("modifier_razor_eye_of_the_storm_custom_tracker")

if not self.mod then 
	self:Destroy()
	return
end 

self.mod:Hide()

self.parent:EmitSound("Razor.Storm_legendary_start2")
self.parent:EmitSound("Razor.Storm_legendary_start")
self.parent:EmitSound("Razor.Storm_legendary_vo")

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", PATTACH_WORLDORIGIN, nil)

local z_pos = 3000
local target_point = self.parent:GetAbsOrigin()

ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, z_pos))
ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, target_point.z))
ParticleManager:ReleaseParticleIndex(particle)

ParticleManager:SetParticleControl(particle2, 0, Vector(target_point.x, target_point.y, z_pos))
ParticleManager:SetParticleControl(particle2, 1, Vector(target_point.x, target_point.y, target_point.z))
ParticleManager:ReleaseParticleIndex(particle2)

local ability = self.parent:FindAbilityByName("razor_eye_of_the_storm_custom")

if not ability then 
	self:Destroy()
	return
end

self.radius = ability:GetSpecialValueFor( "radius" ) + self.parent:GetTalentValue("modifier_razor_eye_5", "radius")

local effect_cast = ParticleManager:CreateParticle( "particles/razor/storm_legendary.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius, 1, 1) )
ParticleManager:SetParticleControl( effect_cast, 2, self.parent:GetAbsOrigin() )
self:AddParticle( effect_cast, false, false, -1, false, false )

self.max_count = 0.3
self.interval = 0.1
self.count = self.max_count 

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end 

function modifier_razor_eye_of_the_storm_custom_legendary:OnDestroy()
if not IsServer() then return end
self.legendary_ability:UseResources(false, false, false, true)

if not self.mod then return end 

self.parent:StopSound("Razor.Storm_legendary_start")
self.parent:EmitSound("Razor.Storm_legendary_end")
self.mod:Show()

if self.tracker and not self.tracker:IsNull() then
	self.tracker:UpdateJs()
end

end 


function modifier_razor_eye_of_the_storm_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_razor_eye_of_the_storm_custom_legendary:GetModifierModelScale()
return 20
end 

function modifier_razor_eye_of_the_storm_custom_legendary:OnIntervalThink()
if not IsServer() then return end 
self.count = self.count + self.interval 

if self.tracker and not self.tracker:IsNull() then
	self.tracker:UpdateJs()
end

if self.count < self.max_count then return end 
self.count = 0

for i = 1,RandomInt(1,2) do 
	self:Strike()
end

end 

function modifier_razor_eye_of_the_storm_custom_legendary:Strike()
if not IsServer() then return end
if not self.mod then 
	self:Destroy()
	return
end 

if not self.mod.cloud_unit or self.mod.cloud_unit:IsNull() then return end 

local point = self.parent:GetAbsOrigin() + RandomVector(RandomInt(100, 500))
local particle_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf", self)
local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_ABSORIGIN_FOLLOW, self.mod.cloud_unit )
ParticleManager:SetParticleControl( effect_cast, 0, self.mod.cloud_unit:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, point )
ParticleManager:ReleaseParticleIndex( effect_cast )
end 

function modifier_razor_eye_of_the_storm_custom_legendary:GetEffectName()
return "particles/generic_gameplay/rune_doubledamage_owner.vpcf"
end

function modifier_razor_eye_of_the_storm_custom_legendary:GetStatusEffectName()
return "particles/status_fx/status_effect_troll_warlord_battletrance.vpcf"
end

function modifier_razor_eye_of_the_storm_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end





modifier_razor_eye_of_the_storm_custom_tracker = class({})
function modifier_razor_eye_of_the_storm_custom_tracker:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_tracker:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_duration = self.parent:GetTalentValue("modifier_razor_eye_6", "duration", true)

self.range_bonus = self.parent:GetTalentValue("modifier_razor_eye_5", "range", true)

self.move_bonus = self.parent:GetTalentValue("modifier_razor_eye_2", "bonus", true)

if not IsServer() then return end 

self.parent:AddAttackEvent_out(self)

self.max = self.parent:GetTalentValue("modifier_razor_eye_7", "max", true)
self.max_time = self.parent:GetTalentValue("modifier_razor_eye_7", "duration_max", true)
self.ability  = self.parent:FindAbilityByName("razor_eye_of_the_storm_custom_legendary")

if not self.ability then return end
self.ability:SetActivated(false)
self:SetStackCount(0)
end 


function modifier_razor_eye_of_the_storm_custom_tracker:UpdateJs()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_razor_eye_7") then return end 

local max = self.max
local stack = self:GetStackCount()
local active = 0
local zero = nil
local no_min = nil
local mod = self.parent:FindModifierByName("modifier_razor_eye_of_the_storm_custom_legendary")
if mod then
	max = self.max_time
	stack = mod:GetRemainingTime()
	zero = 1
	active = 1
end
if self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom") then
	no_min = 1
end
self.parent:UpdateUIlong({max = max, stack = stack, use_zero = zero, active = active, no_min = no_min, style = "RazorEye"})
end


function modifier_razor_eye_of_the_storm_custom_tracker:OnStackCountChanged(iStackCount)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_razor_eye_7") then return end 
if not self.ability then return end 
self.ability:SetActivated(self:GetStackCount() > 0)
self:UpdateJs()
end 


function modifier_razor_eye_of_the_storm_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
  	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_razor_eye_of_the_storm_custom_tracker:GetModifierStatusResistanceStacking() 
if not self.parent:HasTalent("modifier_razor_eye_2") then return end
local bonus = self.parent:GetTalentValue("modifier_razor_eye_2", "status")
if self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom") then
	bonus = bonus*self.move_bonus
end
return bonus
end

function modifier_razor_eye_of_the_storm_custom_tracker:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_razor_eye_2") then return end
local bonus = self.parent:GetTalentValue("modifier_razor_eye_2", "move")
if self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom") then
	bonus = bonus*self.move_bonus
end
return bonus
end

function modifier_razor_eye_of_the_storm_custom_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_razor_eye_5") then return end 
return self.range_bonus
end 

function modifier_razor_eye_of_the_storm_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local mod = self.parent:FindModifierByName("modifier_razor_eye_of_the_storm_custom_damage")

if mod and self.parent:HasModifier("modifier_razor_eye_of_the_storm_custom") then 
	self.parent:AddNewModifier(self.parent, self:GetAbility(), mod:GetName(), {duration = self.damage_duration})
end 

if not self.parent:HasTalent("modifier_razor_eye_7") then return end 
if not self.parent:HasTalent("modifier_razor_eye_of_the_storm_custom") then return end
if self.parent:HasTalent("modifier_razor_eye_of_the_storm_custom_legendary") then return end 
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end 





modifier_razor_eye_of_the_storm_custom_damage = class({})
function modifier_razor_eye_of_the_storm_custom_damage:IsHidden() return false end
function modifier_razor_eye_of_the_storm_custom_damage:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_damage:GetTexture() return "buffs/eye_damage" end
function modifier_razor_eye_of_the_storm_custom_damage:OnCreated()
self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_razor_eye_6", "damage")
if not IsServer() then return end 
self.buff_particles = {}

self.buff_particles[1] = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[1], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[1], false, false, -1, true, false)
ParticleManager:SetParticleControl( self.buff_particles[1], 3, Vector( 255, 255, 255 ) )

self.buff_particles[2] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[2], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[2], false, false, -1, true, false)

self.buff_particles[3] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[3], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[3], false, false, -1, true, false)
end 

function modifier_razor_eye_of_the_storm_custom_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_razor_eye_of_the_storm_custom_damage:GetModifierIncomingDamage_Percentage()
return self.damage
end



modifier_razor_eye_of_the_storm_custom_cd = class({})
function modifier_razor_eye_of_the_storm_custom_cd:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_cd:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_cd:RemoveOnDeath() return false end
function modifier_razor_eye_of_the_storm_custom_cd:OnCreated()
self.RemoveForDuel = true
end



modifier_razor_eye_of_the_storm_custom_root = class({})
function modifier_razor_eye_of_the_storm_custom_root:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_root:IsPurgable() return true end
function modifier_razor_eye_of_the_storm_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end
function modifier_razor_eye_of_the_storm_custom_root:GetEffectName() return "particles/items3_fx/gleipnir_root.vpcf" end




modifier_razor_eye_of_the_storm_custom_attack_proc = class({})
function modifier_razor_eye_of_the_storm_custom_attack_proc:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_attack_proc:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_attack_proc:OnCreated()
self.damage = self:GetParent():GetTalentValue("modifier_razor_eye_4", "damage") - 100
end

function modifier_razor_eye_of_the_storm_custom_attack_proc:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_razor_eye_of_the_storm_custom_attack_proc:GetModifierDamageOutgoing_Percentage()
return self.damage
end