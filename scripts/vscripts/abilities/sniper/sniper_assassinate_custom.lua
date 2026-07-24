--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_assassinate_custom", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_legendary_unit", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_legendary_slow", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_legendary_stack", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_kill_stack", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_kill_tracker", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_heal_reduce", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_damage_reduction", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_slow", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_mark", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_attack", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_attack_damage", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_tracker", "abilities/sniper/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )



sniper_assassinate_custom = class({})


sniper_assassinate_custom.storedTargets = {}
sniper_assassinate_custom.thinkers = {}

function sniper_assassinate_custom:CreateTalent()
self:ToggleAutoCast()
end

function sniper_assassinate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_assassinate.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/econ/items/sniper/sniper_fall20_immortal/sniper_legendary_assassinate.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/sniper_assassinate_stack.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/silver_edge.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_break.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_charge_mark.vpcf", context )
PrecacheResource( "particle","particles/sniper_ult_mark.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_break.vpcf", context )

end

function sniper_assassinate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sniper_assassinate_custom_tracker"
end

function sniper_assassinate_custom:GetCastPoint(iLevel)
return self:GetCast()
end

function sniper_assassinate_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_sniper_assassinate_5") then 
	bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE + bonus
end

function sniper_assassinate_custom:GetCast()
local bonus = 0
if self:GetCaster():HasTalent("modifier_sniper_assassinate_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_sniper_assassinate_1", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function sniper_assassinate_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_sniper_assassinate_3") then  
	upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_sniper_assassinate_3", "cd")
end 
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function sniper_assassinate_custom:GetAOERadius()
return self:GetSpecialValueFor("aoe_radius")
end

function sniper_assassinate_custom:OnAbilityPhaseStart()

local caster = self:GetCaster()
caster:EmitSound("Ability.AssassinateLoad")

local cast_k = 0.5/self:GetCast()
caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, cast_k)

self.storedTargets = {}
local point = self:GetCursorPosition()
local enemies = FindUnitsInRadius(caster:GetTeamNumber(), point, caster, self:GetSpecialValueFor("aoe_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
    
for _,enemy in pairs(enemies) do
    enemy:AddNewModifier(caster,self,"modifier_sniper_assassinate_custom", {duration = self:GetSpecialValueFor("debuff_duration")})
    table.insert(self.storedTargets, enemy)
end
return true
end


function sniper_assassinate_custom:OnAbilityPhaseInterrupted()

self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_4)

if not self.storedTargets then return end
if #self.storedTargets == 0 then return end

for i,target in pairs(self.storedTargets) do 
	target:RemoveModifierByName("modifier_sniper_assassinate_custom")
end

self.storedTargets = {}
end






function sniper_assassinate_custom:OnSpellStart(new_target)
local caster = self:GetCaster()
local mouse_target = self:GetCursorTarget()
if new_target then 
	mouse_target = new_target
end

caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)

EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(),"Ability.Assassinate",caster)
  
local targets_array = {}

local speed = self:GetSpecialValueFor("projectile_speed")

if #self.storedTargets > 0 then 
	for i,target in pairs(self.storedTargets) do 
		targets_array[#targets_array + 1] = target
	end
	self.storedTargets = {}
else 
	targets_array[1] = mouse_target
end

if caster:HasTalent("modifier_sniper_assassinate_5") and self:GetAutoCastState() then
	local duration = caster:GetTalentValue("modifier_sniper_assassinate_5", "knock_duration")
	local distance = caster:GetTalentValue("modifier_sniper_assassinate_5", "range_self")
	local point = caster:GetAbsOrigin() + caster:GetForwardVector()*50

	local knockback =	
	{
    should_stun = 0,
    knockback_duration = duration,
    duration = duration,
    knockback_distance = distance,
    knockback_height = 50,
    center_x = point.x,
    center_y = point.y,
    center_z = point.z,
	}
	caster:AddNewModifier(caster, self, "modifier_knockback", knockback)
end


local projTable = 
{
  EffectName = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf",
  Ability = self,
  Source = caster,
  bDodgeable = not caster:HasTalent("modifier_sniper_assassinate_6"),
  vSpawnOrigin = caster:GetAbsOrigin(),
  iMoveSpeed = speed, 
  iVisionRadius = 100,
  iVisionTeamNumber = caster:GetTeamNumber(),
  bProvidesVision = true,
  iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
}

for _,target in pairs(targets_array) do
	local sound_thinker = CreateModifierThinker( caster,  self,  "modifier_sniper_assassinate_custom_legendary_unit", {duration = self:GetSpecialValueFor("distance")/speed}, caster:GetAbsOrigin(), caster:GetTeamNumber(),  false )
	sound_thinker:EmitSound("Hero_Sniper.AssassinateProjectile")

	local length = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()

	projTable.Target = target
	projTable.ExtraData =   
	{
	  thinker = sound_thinker:entindex(),
	  length = length,
	}

	table.insert(self.thinkers, sound_thinker:entindex())
  ProjectileManager:CreateTrackingProjectile(projTable)
end

end



function sniper_assassinate_custom:OnProjectileThink_ExtraData(location, data)
if not IsServer() then return end

if data.thinker and EntIndexToHScript(data.thinker) and not EntIndexToHScript(data.thinker):IsNull() then 
	EntIndexToHScript(data.thinker):SetAbsOrigin(location)
end

end




function sniper_assassinate_custom:OnProjectileHit_ExtraData(hTarget, vLocation, data)
if not hTarget then return end

local caster = self:GetCaster()
local ability = self
local target = hTarget
  
target:RemoveModifierByName("modifier_sniper_assassinate_custom")

if data.thinker and EntIndexToHScript(data.thinker) and not EntIndexToHScript(data.thinker):IsNull() then 
	EntIndexToHScript(data.thinker):StopSound("Hero_Sniper.AssassinateProjectile")
	UTIL_Remove(EntIndexToHScript(data.thinker))
end

if not caster:HasTalent("modifier_sniper_assassinate_6") then
	if target:TriggerSpellAbsorb(self) then return end
end

if caster:HasTalent("modifier_sniper_assassinate_6") and not target:IsDebuffImmune() then
	target:Purge(true, false, false, false, false)
	target:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_slow", {duration = caster:GetTalentValue("modifier_sniper_assassinate_6", "duration", true)})
end


target:EmitSound("Hero_Sniper.AssassinateDamage")

local damage = self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_sniper_assassinate_2", "damage")*caster:GetAverageTrueAttackDamage(nil)/100

local count = 1 
local mod = target:FindModifierByName("modifier_sniper_assassinate_custom_legendary_stack")

if mod and mod.damage then 
	damage = damage*(1 + mod:GetStackCount()*mod.damage/100)
	count = count + mod:GetStackCount()
	mod:Destroy()
end

if target:IsValidKill(caster) then 
	target:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_kill_tracker", {duration = self:GetSpecialValueFor("scepter_duration")})
end

if caster:HasTalent("modifier_sniper_assassinate_2") then 
	target:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_heal_reduce", {duration = caster:GetTalentValue("modifier_sniper_assassinate_2", "duration")})
end


if caster:HasTalent("modifier_sniper_assassinate_5") then
	local duration = caster:GetTalentValue("modifier_sniper_assassinate_5", "knock_duration")
	local distance = caster:GetTalentValue("modifier_sniper_assassinate_5", "range_knock")
	local max_dist = caster:GetTalentValue("modifier_sniper_assassinate_5", "distance_max")
	local point = caster:GetAbsOrigin()

	distance = math.max(50, (1 - data.length/max_dist)*distance)

	local knockback =	
	{
    should_stun = 0,
    knockback_duration = duration,
    duration = duration,
    knockback_distance = distance,
    knockback_height = 50,
    center_x = point.x,
    center_y = point.y,
    center_z = point.z,
	}
	target:AddNewModifier(caster, caster:BkbAbility(self, true), "modifier_sniper_assassinate_custom_damage_reduction", {duration = caster:GetTalentValue("modifier_sniper_assassinate_5", "duration", true)})
	target:AddNewModifier(caster, caster:BkbAbility(self, true), "modifier_knockback", knockback)
end

if caster:HasTalent("modifier_sniper_assassinate_4") then 
	target:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_mark", {duration = caster:GetTalentValue("modifier_sniper_assassinate_4", "duration")})
end

local damageTable = {  victim = target, attacker = caster, ability = self, damage = damage,  damage_type = self:GetAbilityDamageType(), }
DoDamage(damageTable)

local duration = 0.03
if caster:HasScepter() then 
	duration = self:GetSpecialValueFor("scepter_stun_duration")
end

target:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_attack", {count = count})
target:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*duration})
end


modifier_sniper_assassinate_custom = class({})
function modifier_sniper_assassinate_custom:IsHidden() return false end
function modifier_sniper_assassinate_custom:IsPurgable() return false end
function modifier_sniper_assassinate_custom:GetAuraRadius() return 10 end
function modifier_sniper_assassinate_custom:IsAura() return true end
function modifier_sniper_assassinate_custom:GetModifierAura() return "modifier_truesight" end

function modifier_sniper_assassinate_custom:GetAuraSearchFlags()
return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_sniper_assassinate_custom:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_sniper_assassinate_custom:GetAuraSearchType()
return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sniper_assassinate_custom:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.effect_cast = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent, self.caster:GetTeamNumber() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)
self:StartIntervalThink(0.1)
end

function modifier_sniper_assassinate_custom:OnIntervalThink()
if not IsServer() then return end 
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(),10,0.1,true)
end





sniper_assassinate_custom_legendary = class({})

sniper_assassinate_custom_legendary.projectiles = {}
sniper_assassinate_custom_legendary.thinkers = {}

function sniper_assassinate_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function sniper_assassinate_custom_legendary:OnAbilityPhaseStart()
self:GetCaster():EmitSound("Sniper.Assassinate_legendary_cast")
return true
end

function sniper_assassinate_custom_legendary:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_sniper_assassinate_7", "cd")
end

function sniper_assassinate_custom_legendary:OnProjectileThink_ExtraData(location, data)
if not IsServer() then return end

if data.thinker and EntIndexToHScript(data.thinker) and not EntIndexToHScript(data.thinker):IsNull() then 
	EntIndexToHScript(data.thinker):SetAbsOrigin(location)
end

end

function sniper_assassinate_custom_legendary:OnProjectileHit_ExtraData(hTarget, vLocation, data)
if not hTarget then return end
if not data.index or not self.projectiles or not self.projectiles[data.index] then return end

local enemy = hTarget
local caster = self:GetCaster()

if self.projectiles[data.index] == 0 then 
	caster:CdAbility(self, self:GetCooldownTimeRemaining()*self:GetSpecialValueFor("hit_cd")/100)
	self.projectiles[data.index] = 1
end

enemy:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_legendary_slow", {duration = self:GetSpecialValueFor("slow_duration")})
enemy:AddNewModifier(caster, self, "modifier_sniper_assassinate_custom_legendary_stack", {duration = self:GetSpecialValueFor("stack_duration")})

local particle_aoe_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
ParticleManager:SetParticleControlEnt( particle_aoe_fx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle_aoe_fx, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:DestroyParticle(particle_aoe_fx, false)
ParticleManager:ReleaseParticleIndex(particle_aoe_fx) 

local damage = self:GetSpecialValueFor("damage")*enemy:GetHealth()/100

if enemy:IsCreep() then 
	damage = self:GetSpecialValueFor("damage_creeps")
end

EmitSoundOnLocationWithCaster(enemy:GetAbsOrigin(), "Sniper.Assassinate_legendary_damage", nil)
local damageTable = {  victim = enemy, attacker = caster, damage = damage, ability = self, damage_type = DAMAGE_TYPE_MAGICAL, }
DoDamage(damageTable)
end


function sniper_assassinate_custom_legendary:OnSpellStart()
local caster = self:GetCaster()

local vect = self:GetCursorPosition() - caster:GetAbsOrigin()
local dir = vect:Normalized()
local point = caster:GetAbsOrigin() + dir*(self:GetSpecialValueFor("distance") + caster:GetCastRangeBonus())

local sound_thinker = CreateModifierThinker( caster,  self,  "modifier_sniper_assassinate_custom_legendary_unit", {duration = self:GetSpecialValueFor("distance")/self:GetSpecialValueFor("projectile_speed")}, caster:GetAbsOrigin(), caster:GetTeamNumber(),  false )
sound_thinker:EmitSound("Sniper.Assassinate_legendary_proj")

local index = #self.projectiles + 1

self.projectiles[index] = 0

ProjectileManager:CreateLinearProjectile({
	EffectName = "particles/econ/items/sniper/sniper_fall20_immortal/sniper_legendary_assassinate.vpcf",
	Ability = self,
	vSpawnOrigin = caster:GetAbsOrigin(),
	fStartRadius = self:GetSpecialValueFor("projectile_width"),
	fEndRadius = self:GetSpecialValueFor("projectile_width"),
	vVelocity = dir * self:GetSpecialValueFor("projectile_speed"),
	fDistance = self:GetSpecialValueFor("distance") + caster:GetCastRangeBonus(),
	Source = caster,
	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	bProvidesVision = true,
	iVisionTeamNumber = caster:GetTeamNumber(),
	iVisionRadius = self:GetSpecialValueFor("projectile_width")*2,
	ExtraData =   
	{
		index = index, 
		thinker = sound_thinker:entindex(),
	},
})

table.insert(self.thinkers, sound_thinker:entindex())
caster:EmitSound("Sniper.Assassinate_legendary_shot")
end


modifier_sniper_assassinate_custom_legendary_unit = class({})
function modifier_sniper_assassinate_custom_legendary_unit:IsHidden() return true end
function modifier_sniper_assassinate_custom_legendary_unit:IsPurgable() return false end


modifier_sniper_assassinate_custom_legendary_slow = class({})
function modifier_sniper_assassinate_custom_legendary_slow:IsHidden() return true end
function modifier_sniper_assassinate_custom_legendary_slow:IsPurgable() return true end
function modifier_sniper_assassinate_custom_legendary_slow:GetEffectName() return "particles/items2_fx/sange_maim.vpcf" end
function modifier_sniper_assassinate_custom_legendary_slow:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.slow = self:GetAbility():GetSpecialValueFor("slow")

if not IsServer() then return end
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_sniper_assassinate_custom_legendary_slow:OnIntervalThink()
if not IsServer() then return end 
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, 0.1, true)
end

function modifier_sniper_assassinate_custom_legendary_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sniper_assassinate_custom_legendary_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_sniper_assassinate_custom_legendary_stack = class({})
function modifier_sniper_assassinate_custom_legendary_stack:IsHidden() return false end
function modifier_sniper_assassinate_custom_legendary_stack:IsPurgable() return false end
function modifier_sniper_assassinate_custom_legendary_stack:OnCreated(table)

self.RemoveForDuel = true
self.damage = self:GetCaster():GetTalentValue("modifier_sniper_assassinate_7", "damage")
self.max = self:GetCaster():GetTalentValue("modifier_sniper_assassinate_7", "max")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_sniper_assassinate_custom_legendary_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end


function modifier_sniper_assassinate_custom_legendary_stack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_sniper_assassinate_custom_legendary_stack:OnTooltip()
return self.damage*self:GetStackCount()
end


function modifier_sniper_assassinate_custom_legendary_stack:OnStackCountChanged(iStackCount)
if self:GetStackCount() == 0 then return end
if not self.effect_cast then 

	local particle_cast = "particles/sniper_assassinate_stack.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )

	self:AddParticle(self.effect_cast,false, false, -1, false, false)
else 

  ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )

end

end



modifier_sniper_assassinate_custom_kill_tracker = class({})
function modifier_sniper_assassinate_custom_kill_tracker:IsHidden() return true end
function modifier_sniper_assassinate_custom_kill_tracker:IsPurgable() return false end
function modifier_sniper_assassinate_custom_kill_tracker:RemoveOnDeath() return false end


function modifier_sniper_assassinate_custom_kill_tracker:OnCreated()

self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.caster = self:GetCaster()
self.ability = self:GetAbility()
end


function modifier_sniper_assassinate_custom_kill_tracker:DeathEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if self.parent:IsReincarnating() then return end

if self.caster:GetQuest() == "Sniper.Quest_8" then 
	self.caster:UpdateQuest(1)
end
self.caster:AddNewModifier(self.caster, self.ability, "modifier_sniper_assassinate_custom_kill_stack",  {})

self:Destroy()
end


modifier_sniper_assassinate_custom_kill_stack = class({})
function modifier_sniper_assassinate_custom_kill_stack:IsHidden() return false end
function modifier_sniper_assassinate_custom_kill_stack:IsPurgable() return false end
function modifier_sniper_assassinate_custom_kill_stack:RemoveOnDeath() return false end
function modifier_sniper_assassinate_custom_kill_stack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_sniper_assassinate_custom_kill_stack:OnTooltip()
return self:GetStackCount()
end

function modifier_sniper_assassinate_custom_kill_stack:GetModifierPercentageCooldown()
if not self.parent:HasScepter() then return 0 end 
return self.cdr*self:GetStackCount()
end
   
function modifier_sniper_assassinate_custom_kill_stack:GetModifierSpellAmplify_Percentage() 
if not self.parent:HasScepter() then return 0 end 
return self.damage*self:GetStackCount()
end

function modifier_sniper_assassinate_custom_kill_stack:GetModifierDamageOutgoing_Percentage()
if not self.parent:HasScepter() then return 0 end 
return self.damage*self:GetStackCount()
end


function modifier_sniper_assassinate_custom_kill_stack:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability:GetSpecialValueFor("scepter_max")
self.damage = self.ability:GetSpecialValueFor("scepter_damage")
self.cdr = self.ability:GetSpecialValueFor("scepter_cdr")

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_sniper_assassinate_custom_kill_stack:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end

function modifier_sniper_assassinate_custom_kill_stack:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasScepter() then return end
if self:GetStackCount() < self.max then return end

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end





modifier_sniper_assassinate_custom_heal_reduce = class({})
function modifier_sniper_assassinate_custom_heal_reduce:IsHidden() return true end
function modifier_sniper_assassinate_custom_heal_reduce:IsPurgable() return false end
function modifier_sniper_assassinate_custom_heal_reduce:DeclareFunctions()
return
{
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_sniper_assassinate_custom_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_sniper_assassinate_custom_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_sniper_assassinate_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_sniper_assassinate_custom_heal_reduce:OnCreated(table)
self.heal_reduce = self:GetCaster():GetTalentValue("modifier_sniper_assassinate_2", "heal_reduce")
end



modifier_sniper_assassinate_custom_slow = class({})
function modifier_sniper_assassinate_custom_slow:IsHidden() return false end
function modifier_sniper_assassinate_custom_slow:IsPurgable() return false end
function modifier_sniper_assassinate_custom_slow:GetTexture() return "buffs/assassinate_slow" end
function modifier_sniper_assassinate_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_sniper_assassinate_custom_slow:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.move_slow = self.caster:GetTalentValue("modifier_sniper_assassinate_6", "slow")

if not IsServer() then return end
self.parent:EmitSound("Sniper.Assassinate_purge")
self.parent:GenericParticle("particles/items4_fx/nullifier_mute.vpcf", self, true)
self.parent:GenericParticle("particles/items4_fx/nullifier_mute_debuff.vpcf", self, true)
self:StartIntervalThink(0.05)
end

function modifier_sniper_assassinate_custom_slow:OnIntervalThink()
if not IsServer() then return end
if self.parent:IsDebuffImmune() then return end

self.parent:Purge(true, false, false, false, false)
end


function modifier_sniper_assassinate_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move_slow
end





modifier_sniper_assassinate_custom_damage_reduction = class({})
function modifier_sniper_assassinate_custom_damage_reduction:IsHidden() return true end
function modifier_sniper_assassinate_custom_damage_reduction:IsPurgable() return false end
function modifier_sniper_assassinate_custom_damage_reduction:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_sniper_assassinate_custom_damage_reduction:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage = self.caster:GetTalentValue("modifier_sniper_assassinate_5", "damage_reduce")
end


function modifier_sniper_assassinate_custom_damage_reduction:GetModifierDamageOutgoing_Percentage()
return self.damage
end

function modifier_sniper_assassinate_custom_damage_reduction:GetModifierSpellAmplify_Percentage()
return self.damage
end

function modifier_sniper_assassinate_custom_damage_reduction:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_sniper_assassinate_custom_damage_reduction:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sniper_assassinate_custom_damage_reduction:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_sniper_assassinate_custom_damage_reduction:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end





modifier_sniper_assassinate_custom_mark = class({})
function modifier_sniper_assassinate_custom_mark:IsHidden() return false end
function modifier_sniper_assassinate_custom_mark:IsPurgable() return false end
function modifier_sniper_assassinate_custom_mark:GetTexture() return "buffs/pulverize_kill" end
function modifier_sniper_assassinate_custom_mark:GetEffectName() return "particles/lc_odd_charge_mark.vpcf" end
function modifier_sniper_assassinate_custom_mark:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_sniper_assassinate_custom_mark:OnCreated(table)
if not IsServer() then return end

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal = self.caster:GetTalentValue("modifier_sniper_assassinate_4", "heal")
self.heal_creeps = self.caster:GetTalentValue("modifier_sniper_assassinate_4", "heal_creeps")
self.damage = self.caster:GetTalentValue("modifier_sniper_assassinate_4", "damage")/100

self:SetStackCount(0)
self:StartIntervalThink(0.1)
end

function modifier_sniper_assassinate_custom_mark:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, 0.1, true)
end


function modifier_sniper_assassinate_custom_mark:OnDestroy()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if self:GetStackCount() < 1 then return end

self.parent:EmitSound("Sniper.Assassinate_mark_damage")

local effect = ParticleManager:CreateParticle("particles/sniper_ult_mark.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:DestroyParticle(effect, false)
ParticleManager:ReleaseParticleIndex(effect) 

local damageTable = {  victim = self.parent, attacker = self.caster, ability = self.ability, damage = self:GetStackCount(),  damage_type = DAMAGE_TYPE_PURE, }
local real_damage = DoDamage(damageTable, "modifier_sniper_assassinate_4")

if self.parent:IsIllusion() then return end

local heal = real_damage*self.heal/100
if self.parent:IsCreep() then 
	heal = heal/self.heal_creeps
end 

self.caster:GenericHeal(heal, self.ability, nil, nil, "modifier_sniper_assassinate_4")
end






modifier_sniper_assassinate_custom_attack = class({})
function modifier_sniper_assassinate_custom_attack:IsHidden() return true end
function modifier_sniper_assassinate_custom_attack:IsPurgable() return false end
function modifier_sniper_assassinate_custom_attack:OnCreated(table)
if not IsServer() then return end 

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self:SetStackCount(table.count)

self:StartIntervalThink(0.1)
end 

function modifier_sniper_assassinate_custom_attack:OnIntervalThink()
if not IsServer() then return end 

self.caster:AddNewModifier(self.caster, self.ability, "modifier_sniper_assassinate_custom_attack_damage", {duration = FrameTime()})
self.caster:PerformAttack(self.parent, true, true, true, true, false, false, true)
self.caster:RemoveModifierByName("modifier_sniper_assassinate_custom_attack_damage")
self:DecrementStackCount()

if self:GetStackCount() < 1 then 
	self:Destroy()
end

end 

modifier_sniper_assassinate_custom_attack_damage = class(mod_hidden)
function modifier_sniper_assassinate_custom_attack_damage:OnCreated()
self.damage = self:GetAbility():GetSpecialValueFor("attack_factor") - 100
end

function modifier_sniper_assassinate_custom_attack_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_sniper_assassinate_custom_attack_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end




modifier_sniper_assassinate_custom_tracker = class({})
function modifier_sniper_assassinate_custom_tracker:IsHidden() return true end
function modifier_sniper_assassinate_custom_tracker:IsPurgable() return false end
function modifier_sniper_assassinate_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddDamageEvent_out(self)
end

function modifier_sniper_assassinate_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
}
end

function modifier_sniper_assassinate_custom_tracker:GetActivityTranslationModifiers()
return "ultimate_scepter"
end

function modifier_sniper_assassinate_custom_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_sniper_assassinate_1") then return end 
return self.parent:GetTalentValue("modifier_sniper_assassinate_1", "range")
end

function modifier_sniper_assassinate_custom_tracker:GetModifierPercentageManacostStacking()
if not self.parent:HasTalent("modifier_sniper_assassinate_3") then return end
return self.parent:GetTalentValue("modifier_sniper_assassinate_3", "mana")
end


function modifier_sniper_assassinate_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sniper_assassinate_4") then return end
if self.parent ~= params.attacker then return end
if not params.unit:IsUnit() then return end

local mod = params.unit:FindModifierByName("modifier_sniper_assassinate_custom_mark")

if mod and mod.damage then
	mod:SetStackCount(mod:GetStackCount() + params.damage*mod.damage)
end

end
