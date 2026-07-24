--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_void_remnant_thinker", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_target", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_target_creep", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_tracker", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_slow", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_legendary_caster", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_speed", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_bonus", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_legendary_illusion", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_damage_reduce", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_auto_cd", "abilities/void_spirit/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)



void_spirit_aether_remnant_custom = class({})





function void_spirit_aether_remnant_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/void_spirit_attack_alt_blur.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/void_spirit_attack_alt_02_blur.vpcf", context )


PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/pull_legendary.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pull.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_flash.vpcf", context )
PrecacheResource( "particle","particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/void_mark_hit.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/remnant_hit.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/remnant_legendary.vpcf", context )
PrecacheResource( "particle","particles/void_step_texture.vpcf", context )
PrecacheResource( "particle","particles/void_buf2.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_puff.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/legendary_remnant_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_brewmaster/brewmaster_void_debuff.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_arcane_start.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_arcane_end.vpcf", context )
PrecacheResource( "particle","particles/void_step_speed.vpcf", context )
end



function void_spirit_aether_remnant_custom:GetManaCost(level)
if self:GetCaster():HasShard() then 
	return 0
end 
return self.BaseClass.GetManaCost(self,level)
end


function void_spirit_aether_remnant_custom:GetCastRange(vLocation, hTarget)
local upgrade = 0
if self:GetCaster():HasShard() then 
	upgrade = self:GetSpecialValueFor("shard_distance")
end
return self.BaseClass.GetCastRange(self , vLocation , hTarget) + upgrade 
end


function void_spirit_aether_remnant_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_void_remnant_tracker"
end

function void_spirit_aether_remnant_custom:GetDamage()
if not IsServer() then return end
local caster = self:GetCaster()
return self:GetSpecialValueFor( "impact_damage" ) + caster:GetTalentValue("modifier_void_remnant_1", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
end

 

function void_spirit_aether_remnant_custom:OnVectorCastStart(vStartLocation, vDirection)

local caster = self:GetCaster()

local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then 
	point = caster:GetAbsOrigin() + 10*caster:GetForwardVector()
end 

CreateModifierThinker(caster,  self, "modifier_custom_void_remnant_thinker", {auto = 0, dir_x = vDirection.x, dir_y = vDirection.y, dir_z = vDirection.z, }, point, caster:GetTeamNumber(), false)
caster:EmitSound("Hero_VoidSpirit.AetherRemnant.Cast")
end




modifier_custom_void_remnant_thinker = class({})

local STATE_RUN = 1
local STATE_DELAY = 2
local STATE_WATCH = 3
local STATE_PULL = 4

function modifier_custom_void_remnant_thinker:OnCreated( kv )

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.ability:GetSpecialValueFor( "think_interval" )
self.delay = self.ability:GetSpecialValueFor( "activation_delay" )
self.speed = self.ability:GetSpecialValueFor( "projectile_speed" )

self.width = self.ability:GetSpecialValueFor( "remnant_watch_radius" )
self.distance = self.ability:GetSpecialValueFor( "remnant_watch_distance" )

if self.caster:HasShard() then 
	self.speed = self.speed + self.ability:GetSpecialValueFor("shard_speed")
	self.delay = 0
end	

self.watch_vision = self.ability:GetSpecialValueFor( "watch_path_vision_radius" )
self.duration = self.ability:GetSpecialValueFor( "duration" )

self.pull_duration = self.ability:GetSpecialValueFor( "pull_duration" ) + self.caster:GetTalentValue("modifier_void_remnant_3", "stun")
self.pull = self.ability:GetSpecialValueFor( "pull_destination" )


if not IsServer() then return end

self.auto = kv.auto

if self.auto == 1 then
	self.pull_duration = self.caster:GetTalentValue("modifier_void_remnant_6", "stun")
end

self.damage = self.ability:GetDamage()

self.origin = self.parent:GetAbsOrigin()

self.direction = Vector( kv.dir_x, kv.dir_y, kv.dir_z )

self.target = GetGroundPosition( self.origin + self.direction * self.distance, nil )

local run_dist = (self.origin-self.caster:GetOrigin()):Length2D()
local run_delay = run_dist/self.speed

self.state = STATE_RUN

self:StartIntervalThink( run_delay )

local direction = self.origin-self.caster:GetOrigin()
direction.z = 0
direction = direction:Normalized()

self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run.vpcf", PATTACH_CUSTOMORIGIN, self.parent )
ParticleManager:SetParticleControlEnt(self.effect_cast, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin() , true)
ParticleManager:SetParticleControl(self.effect_cast, 1, direction * self.speed )
ParticleManager:SetParticleControlForward(self.effect_cast, 0, -direction )

self.parent:EmitSound( "Hero_VoidSpirit.AetherRemnant")
end


function modifier_custom_void_remnant_thinker:OnDestroy()
if not IsServer() then return end

self.parent:StopSound( "Hero_VoidSpirit.AetherRemnant.Spawn_lp" )
self.parent:EmitSound("Hero_VoidSpirit.AetherRemnant.Destroy")

if self.effect_cast then
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_flash.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 3, self.parent:GetOrigin() )
ParticleManager:ReleaseParticleIndex( self.effect_cast )

UTIL_Remove( self.parent )
end




function modifier_custom_void_remnant_thinker:OnIntervalThink()
if self.state == STATE_RUN then
	self.state = STATE_DELAY
	self:StartIntervalThink( self.delay )

	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre.vpcf", PATTACH_CUSTOMORIGIN, self.parent )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
	ParticleManager:SetParticleControlForward( self.effect_cast, 0, self.direction )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )

	return
elseif self.state == STATE_DELAY then

	self.state = STATE_WATCH
	self:StartIntervalThink( self.interval )
	self:SetDuration( self.duration, false )

	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch.vpcf", PATTACH_CUSTOMORIGIN, self.parent )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
	ParticleManager:SetParticleControl( self.effect_cast, 1, self.target )
	ParticleManager:SetParticleControlForward( self.effect_cast, 0, self.direction )
	ParticleManager:SetParticleControlForward( self.effect_cast, 2, self.direction )

	self.parent:EmitSound("Hero_VoidSpirit.AetherRemnant.Spawn_lp")

	return
elseif self.state == STATE_WATCH then
	self:WatchLogic()
else 
	self:StartIntervalThink( -1 )
end

end



function modifier_custom_void_remnant_thinker:WatchLogic()

AddFOWViewer( self.parent:GetTeamNumber(), self.origin, self.watch_vision, 0.1, true)
AddFOWViewer( self.parent:GetTeamNumber(), self.origin + self.direction*self.distance/2, self.watch_vision, 0.1, true)
AddFOWViewer( self.parent:GetTeamNumber(), self.target, self.watch_vision, 0.1, true)

local origin = self.origin + 150*self.direction

local enemies_heroes = {}
local enemies_creeps = {}
local enemies = FindUnitsInLine( self.caster:GetTeamNumber(), origin, self.target, nil, self.width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 0)

for _,unit in pairs(enemies) do
	if unit:IsRealHero() then
		table.insert(enemies_heroes, unit)
	end
	if unit:IsCreep() or unit:IsIllusion() then
		table.insert(enemies_creeps, unit)
	end
end

for _,creep in pairs(enemies_creeps) do 
	creep:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_target_creep", {duration = self.interval*3})
end

if #enemies_heroes==0 then return end

local min = 999
local min_i = 0

for i,enemy in pairs(enemies_heroes) do 
	if enemy:HasModifier("modifier_custom_void_remnant_target") then 
		table.remove(enemies_heroes,i)
	end
end

if #enemies_heroes==0 then return end

for i = 1,#enemies_heroes do
	if (enemies_heroes[i]:GetAbsOrigin() - origin):Length2D() <= min then 
		min = (enemies_heroes[i]:GetAbsOrigin() - origin):Length2D()
		min_i = i
	end
end

if min_i == 0 then return end

local enemy = enemies_heroes[min_i]
local stun_duration = self.pull_duration*(1 - enemy:GetStatusResistance())

self.caster:AddNewModifier(self.caster, self.ability, "modifier_can_not_push", {duration = 3})

self.state = STATE_PULL
self:SetDuration( stun_duration, false )

enemy:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_target", {auto = self.auto, duration = stun_duration, pos_x = self.origin.x, pos_y = self.origin.y, pull = self.pull, durat = self.pull_duration })

if self.caster:HasModifier("modifier_void_step_4") and not enemy:HasModifier("modifier_void_spirit_astral_step_spells_max") then 
	enemy:AddNewModifier(self.caster, self.ability, "modifier_void_spirit_astral_step_spells", {duration = self.caster:GetTalentValue("modifier_void_step_4", "duration")})
end

if self.caster:HasTalent("modifier_void_remnant_6") then 
	self.caster:GenericHeal(self.caster:GetMaxHealth()*self.caster:GetTalentValue("modifier_void_remnant_6", "heal", true)/100, self.ability, nil, nil, "modifier_void_remnant_6")
end 

local clone = nil

if self.caster:HasTalent("modifier_void_remnant_legendary") and self.auto == 0 then
	local duration = self.caster:GetTalentValue("modifier_void_remnant_legendary", "duration", true)
	local incoming = self.caster:GetTalentValue("modifier_void_remnant_legendary", "incoming", true) - 100

	local illusion = CreateIllusions( self.caster, self.caster, {duration=duration, outgoing_damage=-100,incoming_damage=incoming}, 1, 0, false, true)  

	for k, illusion in pairs(illusion) do
		clone = illusion

		for _,mod in pairs(self.caster:FindAllModifiers()) do
		    if mod.StackOnIllusion ~= nil and mod.StackOnIllusion == true then
		        illusion:UpgradeIllusion(mod:GetName(), mod:GetStackCount() )
		    end
		end

		illusion:SetOwner(nil)
		illusion:SetHealth(illusion:GetMaxHealth())
		illusion.owner = self.caster
		FindClearSpaceForUnit(illusion, self.origin, true)
    	illusion:AddNewModifier(illusion, nil, "modifier_chaos_knight_phantasm_illusion", {})
		illusion:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_legendary_illusion", {target = enemy:entindex()})
	end
end

local shield = self.caster:FindAbilityByName("void_spirit_resonant_pulse_custom")
if shield then
	shield:LegendaryStack()
end

local step = self.caster:FindAbilityByName("void_spirit_astral_step_custom")
if step then
	step:AutoStack(enemy)
end

if self.caster:HasTalent("modifier_void_astral_6") then
	self.caster:CdItems(self.caster:GetTalentValue("modifier_void_astral_6", "cd_items"))
end

local damageTable = {victim = enemy, attacker = self.caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability,}
DoDamage(damageTable)

local direction = enemy:GetOrigin()-self.origin
local dist = direction:Length2D()
direction.z = 0
direction = direction:Normalized()

AddFOWViewer( self.parent:GetTeamNumber(), self.origin, self.watch_vision, self.pull_duration, true)
AddFOWViewer( self.parent:GetTeamNumber(), self.origin + direction*dist/2, self.watch_vision, self.pull_duration, true)
AddFOWViewer( self.parent:GetTeamNumber(), enemy:GetOrigin(), self.watch_vision, self.pull_duration, true)

ParticleManager:DestroyParticle( self.effect_cast, false )
ParticleManager:ReleaseParticleIndex( self.effect_cast )

local direction = enemy:GetOrigin()-self.origin
direction.z = 0
direction = -direction:Normalized()


local effect = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pull.vpcf"
if clone then 
	effect = "particles/void_spirit/pull_legendary.vpcf"
end

self.effect_cast = ParticleManager:CreateParticle(effect, PATTACH_CUSTOMORIGIN, self.parent )
ParticleManager:SetParticleControlEnt(self.effect_cast, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
ParticleManager:SetParticleControlEnt(self.effect_cast, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true )
ParticleManager:SetParticleControl(self.effect_cast, 2, enemy:GetAbsOrigin() + Vector(0, 0, 150) )
ParticleManager:SetParticleControlForward( self.effect_cast, 2, direction )

if clone then
	ParticleManager:SetParticleControlEnt(self.effect_cast, 3, clone, PATTACH_POINT_FOLLOW, "attach_hitloc", clone:GetAbsOrigin(), true )
else 
	ParticleManager:SetParticleControl(self.effect_cast, 3, self.origin )
end 

self.parent:EmitSound("Hero_VoidSpirit.AetherRemnant.Triggered")
enemy:EmitSound("Hero_VoidSpirit.AetherRemnant.Target")
end






modifier_custom_void_remnant_target = class({})
function modifier_custom_void_remnant_target:IsHidden() return false end
function modifier_custom_void_remnant_target:IsStunDebuff() return true end
function modifier_custom_void_remnant_target:IsPurgable() return true end
function modifier_custom_void_remnant_target:GetStatusEffectName() return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf" end
function modifier_custom_void_remnant_target:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end

function modifier_custom_void_remnant_target:OnCreated( kv )
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.auto = kv.auto
self.target = Vector( kv.pos_x, kv.pos_y, 0 )

local dist = (self.parent:GetOrigin()-self.target):Length2D()
self.speed = kv.pull/100*dist/kv.durat

if not self.parent:IsDebuffImmune() then 
	self.parent:MoveToPosition( self.target )
end 

if self.caster:HasTalent("modifier_void_remnant_3") then 
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_damage_reduce", {duration = self.caster:GetTalentValue("modifier_void_remnant_3", "duration")})
end 

end

function modifier_custom_void_remnant_target:OnDestroy()
if not IsServer() then return end

if not self.parent:IsDebuffImmune() then 
	self.parent:Stop()
end 

if self.caster:HasTalent("modifier_void_remnant_5") and self.auto == 0 then 
	self.parent:EmitSound("VoidSpirit.Remnant_purge")
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_slow", {duration = self.caster:GetTalentValue("modifier_void_remnant_5", "duration")})
end

end

function modifier_custom_void_remnant_target:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
}
end

function modifier_custom_void_remnant_target:GetModifierMoveSpeed_Absolute()
if IsServer() then return self.speed  end
end

function modifier_custom_void_remnant_target:CheckState()
return 
{
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	[MODIFIER_STATE_TAUNTED] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end



modifier_custom_void_remnant_target_creep = class({})
function modifier_custom_void_remnant_target_creep:IsHidden() return true end
function modifier_custom_void_remnant_target_creep:IsPurgable() return false end
function modifier_custom_void_remnant_target_creep:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.creeps_interval = self.ability:GetSpecialValueFor("creeps_interval")
self.damage = self.ability:GetDamage()*self.ability:GetSpecialValueFor("creeps_damage")/100

self.damageTable = {victim = self.parent, attacker = self.caster, damage = self.damage*self.creeps_interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability, }
self:OnIntervalThink()
self:StartIntervalThink(self.creeps_interval)
end

function modifier_custom_void_remnant_target_creep:OnIntervalThink()
if not IsServer() then return end

DoDamage(self.damageTable)
end

function modifier_custom_void_remnant_target_creep:GetStatusEffectName()
return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf"
end

function modifier_custom_void_remnant_target_creep:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end








modifier_custom_void_remnant_tracker = class({})
function modifier_custom_void_remnant_tracker:IsHidden() return true end
function modifier_custom_void_remnant_tracker:IsPurgable() return false end
function modifier_custom_void_remnant_tracker:RemoveOnDeath() return false end
function modifier_custom_void_remnant_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSORB_SPELL
}
end


function modifier_custom_void_remnant_tracker:GetAbsorbSpell(params) 
if not IsServer() then return end
if not self.parent:HasTalent("modifier_void_remnant_6") then return end
if self.parent:HasModifier("modifier_custom_void_remnant_auto_cd") then return end
if not params.ability then return end
if not params.ability:GetCaster() then return end

local caster = params.ability:GetCaster()

if caster:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not caster:IsHero() then return end

local vec = caster:GetAbsOrigin() - self.parent:GetAbsOrigin()
local point = caster:GetAbsOrigin() + vec:Normalized()*150
local vDirection = (caster:GetAbsOrigin() - point):Normalized()

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_void_remnant_auto_cd", {duration = self.auto_cd})
CreateModifierThinker(self.parent, self.ability, "modifier_custom_void_remnant_thinker", {auto = 1, dir_x = vDirection.x, dir_y = vDirection.y, dir_z = vDirection.z, }, point, self.parent:GetTeamNumber(), false)
end


function modifier_custom_void_remnant_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.auto_cd = self.parent:GetTalentValue("modifier_void_remnant_6", "cd" , true)

self.move_duration = self.parent:GetTalentValue("modifier_void_remnant_2", "duration", true)

self.speed_duration = self.parent:GetTalentValue("modifier_void_remnant_4", "duration", true)
if not IsServer() then return end
self:UpdateTalent()
end



function modifier_custom_void_remnant_tracker:UpdateTalent(name)

if name == "modifier_void_remnant_legendary" or self.parent:HasTalent("modifier_void_remnant_legendary") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_void_remnant_4" or self.parent:HasTalent("modifier_void_remnant_4") then
	self.parent:AddSpellEvent(self)
end

if name == "modifier_void_remnant_2" or self.parent:HasTalent("modifier_void_remnant_2") then
	self.parent:AddSpellEvent(self)
end

end


function modifier_custom_void_remnant_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not params.target:IsUnit() then return end
if params.attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end

local attacker = params.attacker

if attacker:HasModifier("modifier_custom_void_remnant_legendary_illusion") then
	self.parent:PerformAttack(params.target, true, true, false, true, true, false, true)
end 
end


function modifier_custom_void_remnant_tracker:SpellEvent( params )
if not IsServer() then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end

if self.parent:HasTalent("modifier_void_remnant_2") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_void_remnant_bonus", {duration = self.move_duration})
end

if not self.parent:HasTalent("modifier_void_remnant_4") then return end
if self.parent.void_clone and not self.parent.void_clone:IsNull() and self.parent.void_clone:IsAlive() then 
	self.parent.void_clone:AddNewModifier(self.parent, self.ability, "modifier_custom_void_remnant_speed", {duration = self.speed_duration})
end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_void_remnant_speed", {duration = self.speed_duration})
end 




modifier_custom_void_remnant_slow = class({})
function modifier_custom_void_remnant_slow:IsHidden() return true end
function modifier_custom_void_remnant_slow:IsPurgable() return false end
function modifier_custom_void_remnant_slow:GetEffectName() return "particles/items4_fx/nullifier_mute_debuff.vpcf" end
function modifier_custom_void_remnant_slow:GetStatusEffectName() return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf" end
function modifier_custom_void_remnant_slow:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_custom_void_remnant_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_void_remnant_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move
end 

function modifier_custom_void_remnant_slow:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()

self.move = self.caster:GetTalentValue("modifier_void_remnant_5", "move")
if not IsServer() then return end
self.parent:GenericParticle("particles/items4_fx/nullifier_mute.vpcf", self ,true)
self.parent:GenericParticle("particles/void_astral_slow.vpcf", self)

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_custom_void_remnant_slow:OnIntervalThink()
if not IsServer() then return end
if self.parent:IsDebuffImmune() then return end
self.parent:Purge(true, false, false, false, false)
end

function modifier_custom_void_remnant_slow:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end




modifier_custom_void_remnant_speed = class({})
function modifier_custom_void_remnant_speed:IsHidden() return false end
function modifier_custom_void_remnant_speed:IsPurgable() return false end
function modifier_custom_void_remnant_speed:GetTexture() return "buffs/manavoid_int" end
function modifier_custom_void_remnant_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
}
end

function modifier_custom_void_remnant_speed:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.caster:GetTalentValue("modifier_void_remnant_4", "max")
self.range = self.caster:GetTalentValue("modifier_void_remnant_4", "range")
self.speed = self.caster:GetTalentValue("modifier_void_remnant_4", "speed")
self.cd = self.caster:GetTalentValue("modifier_void_remnant_4", "cd")
self.stack = self.max*self.caster:GetTalentValue("modifier_void_remnant_4", "stack")

if not IsServer() then return end 
self.parent:AddAttackFailEvent_out(self)
self:SetStackCount(self.max)
end


function modifier_custom_void_remnant_speed:OnRefresh()
if not IsServer() then return end
self:SetStackCount(math.min(self.stack, self:GetStackCount() + self.max))
end 

function modifier_custom_void_remnant_speed:GetModifierAttackRangeBonus()
return self.range
end
function modifier_custom_void_remnant_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_custom_void_remnant_speed:AttackFailEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end

if self.parent.owner and self.parent.owner:HasModifier(self:GetName()) then
	self.parent.owner:FindModifierByName(self:GetName()):ReduceStack()
end

self:ReduceStack()
end 


function modifier_custom_void_remnant_speed:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 
if self.parent ~= self.caster then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end
 
local visual_caster = self.parent
if self.parent.void_clone then
	visual_caster = self.parent.void_clone
end

for i = 1,3 do
	local particle = ParticleManager:CreateParticle( "particles/void_spirit/void_mark_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW,  visual_caster )
	ParticleManager:SetParticleControlEnt( particle, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex( particle )
end 


local hit_effect = ParticleManager:CreateParticle("particles/void_spirit/remnant_hit.vpcf", PATTACH_CUSTOMORIGIN, params.target)
ParticleManager:SetParticleControlEnt(hit_effect, 0, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)
params.target:EmitSound("Hoodwink.Scurry_attack")

self.caster:CdAbility(self.ability, self.cd)

if self.parent.void_clone and self.parent.void_clone:HasModifier(self:GetName()) then
	self.parent.void_clone:FindModifierByName(self:GetName()):ReduceStack()
end

self:ReduceStack()
end 


function modifier_custom_void_remnant_speed:ReduceStack()
if not IsServer() then return end 

self:DecrementStackCount()
if self:GetStackCount() == 0 then 
	self:Destroy()
end 

end 




modifier_custom_void_remnant_legendary_illusion = class({})
function modifier_custom_void_remnant_legendary_illusion:IsHidden() return true end
function modifier_custom_void_remnant_legendary_illusion:IsPurgable() return false end
function modifier_custom_void_remnant_legendary_illusion:GetEffectName() return "particles/void_spirit/remnant_legendary.vpcf" end
function modifier_custom_void_remnant_legendary_illusion:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_custom_void_remnant_legendary_illusion:GetStatusEffectName() return "particles/void_step_texture.vpcf" end
function modifier_custom_void_remnant_legendary_illusion:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_custom_void_remnant_legendary_illusion:OnCreated(table)

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.move = self.caster:GetTalentValue("modifier_void_remnant_legendary", "move")
self.status = self.caster:GetTalentValue("modifier_void_remnant_legendary", "status")

if not IsServer() then return end

if self.caster.void_clone and not self.caster.void_clone:IsNull() then 
	self.caster.void_clone:Kill(nil, self.caster)
end 

self.caster.void_clone = self.parent

local mod = self.caster:FindModifierByName("modifier_custom_void_remnant_speed")
if mod then 
	local new_mod = self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_speed", {duration = self.caster:GetTalentValue("modifier_void_remnant_4", "duration")})
	new_mod:SetStackCount(mod:GetStackCount())
end 

self.caster:AddNewModifier(self.caster, self.ability, "modifier_custom_void_remnant_legendary_caster", {})
self.parent:EmitSound("VoidSpirit.Remnant_legendary")

local effect_cast = ParticleManager:CreateParticle( "particles/void_buf2.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:Delete(effect_cast, 1)
self.interval = 0.1
self.target = EntIndexToHScript(table.target)
self:StartIntervalThink(0.1)
end 


function modifier_custom_void_remnant_legendary_illusion:OnIntervalThink()
if not IsServer() then return end
if not self.target or self.target:IsNull() then 
	self:Destroy()
	return
end

AddFOWViewer(self.caster:GetTeamNumber(), self.target:GetAbsOrigin(), 10, self.interval*2, false)
self.parent:SetForceAttackTarget(self.target)
end



function modifier_custom_void_remnant_legendary_illusion:OnDestroy()
if not IsServer() then return end
self.caster.void_clone = nil

self.caster:RemoveModifierByName("modifier_custom_void_remnant_legendary_caster")
self.parent:EmitSound("VoidSpirit.Remnant_legendary_death")

local point = self.parent:GetAbsOrigin()

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_puff.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect_cast, 0, point)
ParticleManager:DestroyParticle(effect_cast, false)
ParticleManager:Delete(effect_cast, 1)

local effect_cast2 = ParticleManager:CreateParticle( "particles/void_spirit/legendary_remnant_end.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect_cast2, 0, point + Vector(0, 0, 150))
ParticleManager:DestroyParticle(effect_cast2, false)
ParticleManager:Delete(effect_cast2, 1)
end 

function modifier_custom_void_remnant_legendary_illusion:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
}
end

function modifier_custom_void_remnant_legendary_illusion:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_MODEL_SCALE,
}
end


function modifier_custom_void_remnant_legendary_illusion:GetModifierModelScale()
return 15
end

function modifier_custom_void_remnant_legendary_illusion:GetModifierStatusResistanceStacking() 
return self.status
end

function modifier_custom_void_remnant_legendary_illusion:GetModifierMoveSpeedBonus_Percentage()
return self.move
end






modifier_custom_void_remnant_legendary_caster = class({})
function modifier_custom_void_remnant_legendary_caster:IsHidden() return true end
function modifier_custom_void_remnant_legendary_caster:IsPurgable() return false end
function modifier_custom_void_remnant_legendary_caster:RemoveOnDeath() return false end
function modifier_custom_void_remnant_legendary_caster:GetEffectName() return "particles/units/heroes/hero_brewmaster/brewmaster_void_debuff.vpcf" end
function modifier_custom_void_remnant_legendary_caster:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_custom_void_remnant_legendary_caster:OnCreated(table)
if not IsServer() then return end 

self.ability = self:GetParent():FindAbilityByName("void_spirit_aether_remnant_custom_legendary")

if self.ability then 
	self.ability:SetActivated(true)
end 

end

function modifier_custom_void_remnant_legendary_caster:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true
}
end

function modifier_custom_void_remnant_legendary_caster:OnDestroy()
if not IsServer() then return end 

if self.ability then 
	self.ability:SetActivated(false)
end 

end 




void_spirit_aether_remnant_custom_legendary = class({})

function void_spirit_aether_remnant_custom_legendary:CreateTalent()
self:SetHidden(false)
self:SetActivated(false)
end

function void_spirit_aether_remnant_custom_legendary:OnSpellStart()
local caster = self:GetCaster()

if not caster.void_clone or caster.void_clone:IsNull() then return end 

local dir = caster.void_clone:GetForwardVector()
local point = caster.void_clone:GetAbsOrigin() + dir*10

local effect = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect, 0, caster:GetAbsOrigin())
ParticleManager:Delete(effect, 1)

EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "VoidSpirit.Remnant_blink", caster)
FindClearSpaceForUnit(caster, caster.void_clone:GetAbsOrigin(), true)

effect = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_end.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect, 0, caster:GetAbsOrigin())
ParticleManager:Delete(effect, 1)

caster:SetForwardVector(dir)
caster:FaceTowards(point)

caster.void_clone:Kill(nil, caster)
caster:MoveToPositionAggressive(caster:GetAbsOrigin() + caster:GetForwardVector()*50)

EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "VoidSpirit.Remnant_blink_end", caster)
end





modifier_custom_void_remnant_bonus = class({})
function modifier_custom_void_remnant_bonus:IsHidden() return true end
function modifier_custom_void_remnant_bonus:IsPurgable() return false end
function modifier_custom_void_remnant_bonus:GetTexture() return "buffs/remnant_stats" end
function modifier_custom_void_remnant_bonus:GetEffectName() return "particles/void_step_speed.vpcf" end
function modifier_custom_void_remnant_bonus:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_custom_void_remnant_bonus:GetActivityTranslationModifiers()
return "haste"
end






modifier_custom_void_remnant_damage_reduce = class({})
function modifier_custom_void_remnant_damage_reduce:IsHidden() return true end
function modifier_custom_void_remnant_damage_reduce:IsPurgable() return false end
function modifier_custom_void_remnant_damage_reduce:OnCreated()
self.heal_reduce =  self:GetCaster():GetTalentValue("modifier_void_remnant_3", "heal_reduce")
self.damage_reduce =  self:GetCaster():GetTalentValue("modifier_void_remnant_3", "damage_reduce")
end

function modifier_custom_void_remnant_damage_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_void_remnant_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_custom_void_remnant_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end





modifier_custom_void_remnant_auto_cd = class({})
function modifier_custom_void_remnant_auto_cd:IsHidden() return false end
function modifier_custom_void_remnant_auto_cd:IsPurgable() return false end
function modifier_custom_void_remnant_auto_cd:IsDebuff() return true end
function modifier_custom_void_remnant_auto_cd:GetTexture() return "buffs/remnant_lowhp" end
function modifier_custom_void_remnant_auto_cd:RemoveOnDeath() return false end
function modifier_custom_void_remnant_auto_cd:OnCreated()
self.RemoveForDuel = true
end