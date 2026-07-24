--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_shadowstrike_poison", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_slow", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_legendary_count", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_legendary_damage", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_auto_cd", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_auto_tracker", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_magic_resist", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_heal", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_fear_cd", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_shadowstrike_vision", "abilities/queen_of_pain/custom_queenofpain_shadow_strike", LUA_MODIFIER_MOTION_NONE)



custom_queenofpain_shadow_strike = class({})


function custom_queenofpain_shadow_strike:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "queenofpain_shadow_strike", self)
end


function custom_queenofpain_shadow_strike:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_shadow_strike.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_shadow_strike_body.vpcf", context )
PrecacheResource( "particle","particles/brist_proc.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_shadow_strike_debuff.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/spirit_vessel_damage.vpcf", context )
PrecacheResource( "particle","particles/queen_of_pain/dagger_stacks.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/octarine_core_lifesteal.vpcf", context ) 
PrecacheResource( "particle","particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context ) 
PrecacheResource( "particle","particles/queen_of_pain/dagger_legendary_stack.vpcf", context ) 
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_mark_overhead.vpcf", context ) 

dota1x6:PrecacheShopItems("npc_dota_hero_queenofpain", context)
end



function custom_queenofpain_shadow_strike:GetAOERadius() 
return self:GetSpecialValueFor("radius")
end


function custom_queenofpain_shadow_strike:GetManaCost(iLevel)
if self:GetCaster():HasModifier("modifier_queenofpain_blood_pact") then 
	return 0
end
return self.BaseClass.GetManaCost(self,iLevel)
end 


function custom_queenofpain_shadow_strike:GetHealthCost(level)
local caster = self:GetCaster()
if caster:HasModifier("modifier_queenofpain_blood_pact") then 
	return caster:GetTalentValue("modifier_queen_scream_7", "cost")*caster:GetMaxHealth()/100
end

end 


function custom_queenofpain_shadow_strike:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_shadowstrike_auto_tracker"
end


function custom_queenofpain_shadow_strike:GetCastPoint(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_queen_dagger_1") then 
	bonus = self:GetCaster():GetTalentValue("modifier_queen_dagger_1", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end


function custom_queenofpain_shadow_strike:GetCooldown(iLevel)
local upgrade_cooldown = 0	
if self:GetCaster():HasTalent("modifier_queen_dagger_6") then 
	upgrade_cooldown =  self:GetCaster():GetTalentValue("modifier_queen_dagger_6", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end



function custom_queenofpain_shadow_strike:ThrowDagger(target)
local caster = self:GetCaster()

local projectile_speed = self:GetSpecialValueFor("projectile_speed")*(1 + caster:GetTalentValue("modifier_queen_dagger_5", "speed")/100)

local proj_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_shadow_strike.vpcf", self)
	
local projectile =
{
	Target 				= target,
	Source 				= caster,
	Ability 			= self,
	EffectName 			= proj_name,
	iMoveSpeed			= projectile_speed,
	vSourceLoc 			= caster:GetAbsOrigin(),
	bDrawsOnMinimap 	= false,
	bDodgeable 			= true,
	bIsAttack 			= false,
	bVisibleToEnemies 	= true,
	bReplaceExisting 	= false,
	flExpireTime 		= GameRules:GetGameTime() + 20,
	bProvidesVision 	= false,
	ExtraData			= {cast = cast}
}
ProjectileManager:CreateTrackingProjectile(projectile)

end


function custom_queenofpain_shadow_strike:OnSpellStart(new_target)
local caster = self:GetCaster()
local target = nil

target = self:GetCursorTarget()
if new_target ~= nil then 
	target = new_target
end

if caster:HasTalent("modifier_queen_dagger_2") then
	caster:AddNewModifier(caster, self, "modifier_custom_shadowstrike_heal", {duration = caster:GetTalentValue("modifier_queen_dagger_2", "duration")})
end

if caster:HasTalent("modifier_queen_dagger_6") then
	caster:CdItems(caster:GetTalentValue("modifier_queen_dagger_6", "cd_items"))
end

caster:EmitSound("Hero_QueenOfPain.ShadowStrike")

local particle_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_shadow_strike_body.vpcf", self)

local caster_pfx = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControl(caster_pfx, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(caster_pfx, 1, target:GetAbsOrigin())
ParticleManager:SetParticleControl(caster_pfx, 3, Vector(projectile_speed, 0, 0))
ParticleManager:ReleaseParticleIndex(caster_pfx)

local count = 0
local max = self:GetSpecialValueFor("max_targets") + 1
for _,enemy in pairs(caster:FindTargets(self:GetSpecialValueFor("radius"), target:GetAbsOrigin())) do
	self:ThrowDagger(enemy)
	count = count + 1
	if count >= max then
		break
	end
end

end



function custom_queenofpain_shadow_strike:OnProjectileHit_ExtraData(target, location, ExtraData)
if not IsServer() then return end
if not target then return end
if target:TriggerSpellAbsorb(self) then return end

local caster = self:GetCaster()
local damage = self:GetSpecialValueFor("strike_damage")
local duration = self:GetSpecialValueFor("duration")

DoDamage({victim = target, attacker = caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})

target:AddNewModifier(caster, self, "modifier_custom_shadowstrike_poison", {duration = duration})
target:AddNewModifier(caster, self, "modifier_custom_shadowstrike_slow", {duration = duration})

if caster:HasTalent("modifier_queen_dagger_5") and not target:HasModifier("modifier_custom_shadowstrike_fear_cd") then
	target:EmitSound("Generic.Fear")
	target:GenericParticle("particles/brist_proc.vpcf")
	target:AddNewModifier(caster, self, "modifier_custom_shadowstrike_fear_cd", {duration = caster:GetTalentValue("modifier_queen_dagger_5", "cd_duration")})
	target:AddNewModifier(caster, self, "modifier_nevermore_requiem_fear", {duration  = caster:GetTalentValue("modifier_queen_dagger_5", "fear") * (1 - target:GetStatusResistance())})
end

if caster:HasTalent("modifier_queen_dagger_6") and target:IsRealHero() then
	target:AddNewModifier(caster, self, "modifier_custom_shadowstrike_vision", {duration = caster:GetTalentValue("modifier_queen_dagger_6", "vision")})
end

if caster:HasTalent("modifier_queen_dagger_7") then 
	target:AddNewModifier(caster, self, "modifier_custom_shadowstrike_legendary_count", {duration = duration})
end

end





modifier_custom_shadowstrike_poison = class({})
function modifier_custom_shadowstrike_poison:IsHidden() return true end
function modifier_custom_shadowstrike_poison:IsPurgable()  return true end

function modifier_custom_shadowstrike_poison:GetAttributes() 
if not self:GetCaster() then return end
if self:GetCaster():HasTalent("modifier_queen_dagger_7") then 
	return MODIFIER_ATTRIBUTE_MULTIPLE
else 
	return
end

end



function modifier_custom_shadowstrike_poison:OnCreated(table)
self.RemoveForDuel = true

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

if not self.ability or not self.caster then return end

self.sec_damage_total = self.ability:GetSpecialValueFor("duration_damage") + self.caster:GetTalentValue("modifier_queen_dagger_1", "damage")

if self.caster:IsIllusion() then 
	self.caster = self.caster.owner
end

if not IsServer() then return end

self.damage_interval = self.ability:GetSpecialValueFor("damage_interval")
self:StartIntervalThink(self.damage_interval)
end


function modifier_custom_shadowstrike_poison:OnDestroy()
if not IsServer() then return end
if not self.caster then return end
if not self.caster:HasTalent("modifier_queen_dagger_7") then return end

local mod = self.parent:FindModifierByName("modifier_custom_shadowstrike_legendary_count")
if not mod then return end

mod:DecrementStackCount()
if mod:GetStackCount() == 0 then 
	mod:Destroy()
end

end

function modifier_custom_shadowstrike_poison:OnIntervalThink()
if not IsServer() then return end
DoDamage({victim = self.parent, attacker = self.caster, ability = self.ability, damage = self.sec_damage_total, damage_type = DAMAGE_TYPE_MAGICAL})
self.parent:SendNumber(OVERHEAD_ALERT_BONUS_POISON_DAMAGE, self.sec_damage_total)
end






modifier_custom_shadowstrike_slow = class({})
function modifier_custom_shadowstrike_slow:IsHidden() return self:GetCaster():HasTalent("modifier_queen_dagger_7") end
function modifier_custom_shadowstrike_slow:IsPurgable() return true end
function modifier_custom_shadowstrike_slow:GetTexture() return "queenofpain_shadow_strike" end

function modifier_custom_shadowstrike_slow:OnCreated(table)
self.RemoveForDuel = true

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.max_slow = self.ability:GetSpecialValueFor("movement_slow") + self.caster:GetTalentValue("modifier_queen_dagger_5", "slow")
self.resist_duration = self.caster:GetTalentValue("modifier_queen_dagger_4", "duration", true)

if not self.ability then return end

if self.caster:IsIllusion() then 
	self.caster = self.caster.owner
end

self:SetStackCount(self.max_slow)
if not self.dagger_pfx then
    local particle_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_queenofpain/queen_shadow_strike_debuff.vpcf", self)
	self.dagger_pfx = ParticleManager:CreateParticle(particle_name, PATTACH_POINT_FOLLOW, self.caster)

	for _, cp in pairs({ 0, 2, 3 }) do
		ParticleManager:SetParticleControlEnt(self.dagger_pfx, cp, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	end
	
	self:AddParticle(self.dagger_pfx, false, false, 0, true, false)
end

if not IsServer() then return end
self:StartIntervalThink(1)
end


function modifier_custom_shadowstrike_slow:OnRefresh(table)
if not IsServer() then return end
self:SetStackCount(self.max_slow)
end


function modifier_custom_shadowstrike_slow:OnIntervalThink()
if not IsServer() then return end
self:SetStackCount(self:GetStackCount()*0.8)

if self.caster:GetQuest() == "Queen.Quest_5" and self.caster:IsRealHero() then 
	self.caster:UpdateQuest(1)
end

if self.caster:HasTalent("modifier_queen_dagger_4") then
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_shadowstrike_magic_resist", {duration = self.resist_duration})
end

end

function modifier_custom_shadowstrike_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_shadowstrike_slow:GetModifierMoveSpeedBonus_Percentage() 
return self:GetStackCount() 
end






modifier_custom_shadowstrike_legendary_count = class({})
function modifier_custom_shadowstrike_legendary_count:IsHidden() return false end
function modifier_custom_shadowstrike_legendary_count:IsPurgable() return true end
function modifier_custom_shadowstrike_legendary_count:OnCreated(table)
self.RemoveForDuel = true
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.caster:GetTalentValue("modifier_queen_dagger_7", "max", true)
self.damage_interval = self.ability:GetSpecialValueFor("damage_interval")

if not IsServer() then return end

self.particle = self.parent:GenericParticle("particles/queen_of_pain/dagger_legendary_stack.vpcf", self, true)
self:SetStackCount(1)
end


function modifier_custom_shadowstrike_legendary_count:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self.particle then 
  ParticleManager:SetParticleControl( self.particle, 1, Vector( 0, self:GetStackCount(), 0 ) )
end

end



function modifier_custom_shadowstrike_legendary_count:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()

if self:GetStackCount() < self.max then return end

local damage = 0
for _,mod in pairs(self.parent:FindAllModifiers()) do
	if mod:GetName() == "modifier_custom_shadowstrike_poison" and mod.sec_damage_total then
		damage = damage + mod:GetRemainingTime()*(mod.sec_damage_total/self.damage_interval)
		print(damage)
		mod:Destroy()
	end
end

self.parent:RemoveModifierByName("modifier_custom_shadowstrike_slow")

self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_shadowstrike_legendary_damage", {damage = damage})
end





modifier_custom_shadowstrike_legendary_damage = class({})
function modifier_custom_shadowstrike_legendary_damage:IsHidden() return true end
function modifier_custom_shadowstrike_legendary_damage:IsPurgable() return false end
function modifier_custom_shadowstrike_legendary_damage:OnCreated(table)
self.RemoveForDuel = true
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ticks = self.caster:GetTalentValue("modifier_queen_dagger_7", "ticks", true)
self.duration = self.caster:GetTalentValue("modifier_queen_dagger_7", "duration", true)
self.slow = self.caster:GetTalentValue("modifier_queen_dagger_7", "slow", true)
self.heal = self.caster:GetTalentValue("modifier_queen_dagger_7", "heal", true)/100
self.heal_creeps = self.caster:GetTalentValue("modifier_queen_dagger_7", "creeps", true)

if not IsServer() then return end
self:SetStackCount(self.ticks)

self.parent:GenericParticle("particles/units/heroes/hero_queenofpain/queen_shadow_strike_body.vpcf")

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(particle, false, false, -1, false, false)

self.parent:GenericParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_mark_overhead.vpcf", self, true)

self.parent:EmitSound("QoP.Dagger_legendary_proc")
self.parent:EmitSound("QoP.Dagger_legendary_proc2")
self.parent:EmitSound("QoP.Dagger_legendary_proc3")

self.damage = table.damage
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage = self.damage/self.ticks, damage_type = DAMAGE_TYPE_MAGICAL}

self.interval = self.duration/self.ticks
self:StartIntervalThink(self.interval)
end


function modifier_custom_shadowstrike_legendary_damage:OnIntervalThink()
if not IsServer() then return end
local real_damage = DoDamage(self.damageTable, "modifier_queen_dagger_7")
self.parent:SendNumber(9, real_damage)

if self.caster:IsAlive() and not self.parent:IsIllusion() then
	local heal = real_damage*self.heal
	if self.parent:IsCreep() then
		heal = heal/self.heal_creeps
	end
	self.caster:GenericHeal(heal, self.ability, false, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_queen_dagger_7")
end
self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:Destroy()
end

end

function modifier_custom_shadowstrike_legendary_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_shadowstrike_legendary_damage:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_custom_shadowstrike_legendary_damage:GetStatusEffectName()
return "particles/status_fx/status_effect_rupture.vpcf"
end

function modifier_custom_shadowstrike_legendary_damage:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end





modifier_custom_shadowstrike_auto_tracker = class({})
function modifier_custom_shadowstrike_auto_tracker:IsHidden() return true end
function modifier_custom_shadowstrike_auto_tracker:IsPurgable() return false end
function modifier_custom_shadowstrike_auto_tracker:DeclareFunctions()
return
{
  	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
}
end




function modifier_custom_shadowstrike_auto_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddAttackStartEvent_out(self)

self.legendary_cd = self.parent:GetTalentValue("modifier_queen_dagger_7", "cd", true)
end


function modifier_custom_shadowstrike_auto_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_queen_dagger_3") then return end 
return self.parent:GetTalentValue("modifier_queen_dagger_3", "range")
end


function modifier_custom_shadowstrike_auto_tracker:GetModifierPercentageManacostStacking()
if not self.parent:HasTalent("modifier_queen_dagger_3") then return end 
return self.parent:GetTalentValue("modifier_queen_dagger_3", "mana")
end



function modifier_custom_shadowstrike_auto_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_queen_dagger_7") then return end
if self.parent:HasModifier("modifier_custom_shadowstrike_auto_cd") then return end
if self.parent ~= params.attacker then return end
if params.no_attack_cooldown then return end
if not params.target:IsUnit() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_shadowstrike_auto_cd", {duration = self.legendary_cd})
self.parent:EmitSound("Hero_QueenOfPain.ShadowStrike")
self.ability:ThrowDagger(params.target)
end





modifier_custom_shadowstrike_auto_cd = class({})
function modifier_custom_shadowstrike_auto_cd:IsHidden() return false end
function modifier_custom_shadowstrike_auto_cd:IsPurgable() return true end
function modifier_custom_shadowstrike_auto_cd:IsDebuff() return true end
function modifier_custom_shadowstrike_auto_cd:RemoveOnDeath() return false end
function modifier_custom_shadowstrike_auto_cd:GetTexture() return "buffs/qop_dagger_auto" end




modifier_custom_shadowstrike_magic_resist = class({})
function modifier_custom_shadowstrike_magic_resist:IsHidden() return false end
function modifier_custom_shadowstrike_magic_resist:IsPurgable() return false end
function modifier_custom_shadowstrike_magic_resist:GetTexture() return "buffs/dagger_heal" end

function modifier_custom_shadowstrike_magic_resist:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.max = self.caster:GetTalentValue("modifier_queen_dagger_4", "max", true)
self.duration = self.caster:GetTalentValue("modifier_queen_dagger_4", "duration", true)

self.heal = self.caster:GetTalentValue("modifier_queen_dagger_4", "heal")/self.max
self.resist = self.caster:GetTalentValue("modifier_queen_dagger_4", "magic")/self.max
self:SetStackCount(1)
if not IsServer() then return end
self:StartIntervalThink(0.2)
end

function modifier_custom_shadowstrike_magic_resist:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasModifier("modifier_custom_shadowstrike_slow") then return end
self:SetDuration(self.duration, true)
end


function modifier_custom_shadowstrike_magic_resist:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()	

if self:GetStackCount() >= self.max then 
	self.parent:EmitSound("QoP.Dagger_resist_max")
	self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
end

end

function modifier_custom_shadowstrike_magic_resist:DeclareFunctions()
return
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_custom_shadowstrike_magic_resist:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.resist
end

function modifier_custom_shadowstrike_magic_resist:GetModifierLifestealRegenAmplify_Percentage() 
return self:GetStackCount()*self.heal
end

function modifier_custom_shadowstrike_magic_resist:GetModifierHealChange() 
return self:GetStackCount()*self.heal
end

function modifier_custom_shadowstrike_magic_resist:GetModifierHPRegenAmplify_Percentage() 
return self:GetStackCount()*self.heal
end






modifier_custom_shadowstrike_heal = class({})
function modifier_custom_shadowstrike_heal:IsHidden() return false end
function modifier_custom_shadowstrike_heal:IsPurgable() return false end
function modifier_custom_shadowstrike_heal:GetTexture() return "buffs/Crit_blood" end
function modifier_custom_shadowstrike_heal:OnCreated()
self.parent = self:GetParent()

self.move = self.parent:GetTalentValue("modifier_queen_dagger_2", "move")
self.heal = self.parent:GetTalentValue("modifier_queen_dagger_2", "heal")
self.max = self.parent:GetTalentValue("modifier_queen_dagger_2", "max")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_custom_shadowstrike_heal:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
	self.parent:GenericParticle("particles/generic_gameplay/rune_haste_owner.vpcf", self)
end

end

function modifier_custom_shadowstrike_heal:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_shadowstrike_heal:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.move
end

function modifier_custom_shadowstrike_heal:GetModifierHealthRegenPercentage()
return self:GetStackCount()*self.heal
end



modifier_custom_shadowstrike_fear_cd = class({})
function modifier_custom_shadowstrike_fear_cd:IsHidden() return true end
function modifier_custom_shadowstrike_fear_cd:IsPurgable() return false end
function modifier_custom_shadowstrike_fear_cd:RemoveOnDeath() return false end
function modifier_custom_shadowstrike_fear_cd:OnCreated()
self.RemoveForDuel = true
end


modifier_custom_shadowstrike_vision = class({})
function modifier_custom_shadowstrike_vision:IsHidden() return true end
function modifier_custom_shadowstrike_vision:IsPurgable() return false end
function modifier_custom_shadowstrike_vision:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self:StartIntervalThink(0.2)
end

function modifier_custom_shadowstrike_vision:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, 0.4, false)
end