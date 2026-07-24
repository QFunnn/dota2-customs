--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_tracker", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_damage", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_legendary_armor", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_shard", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_scarab", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_bonus", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_heal_reduce", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_vendetta_custom_bash_cd", "abilities/nyx_assassin/nyx_assassin_vendetta_custom", LUA_MODIFIER_MOTION_NONE )

nyx_assassin_vendetta_custom = class({})
nyx_assassin_vendetta_custom.talents = {}
nyx_assassin_vendetta_custom.legendary_target = nil

function nyx_assassin_vendetta_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/thirst_cleave.vpcf", context )
PrecacheResource( "particle", "particles/neutral_fx/skeleton_spawn.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/vendetta_root.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/vendetta_bash.vpcf", context )
end

function nyx_assassin_vendetta_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
  	has_damage = 0,
  	damage_inc = 0,
  	r1_speed = 0,
  	damage_bonus = caster:GetTalentValue("modifier_nyx_vendetta_1", "bonus", true),
  	damage_duration = caster:GetTalentValue("modifier_nyx_vendetta_1", "duration", true),

    has_r2 = 0,
    r2_heal_reduce = 0,
    r2_slow = 0,
    r2_bonus = caster:GetTalentValue("modifier_nyx_vendetta_2", "bonus", true),
    r2_duration = caster:GetTalentValue("modifier_nyx_vendetta_2", "duration", true),
    r2_slow_duration = caster:GetTalentValue("modifier_nyx_vendetta_2", "slow_duration", true),
        
    has_r3 = 0,
    r3_cd = 0,
    r3_cd_legendary = 0,
    r3_damage = 0,
    r3_bva = caster:GetTalentValue("modifier_nyx_vendetta_3", "bva", true),
    r3_duration = caster:GetTalentValue("modifier_nyx_vendetta_3", "duration", true),
    
    has_r4 = 0,
    r4_chance = caster:GetTalentValue("modifier_nyx_vendetta_4", "chance", true),
    r4_stun = caster:GetTalentValue("modifier_nyx_vendetta_4", "stun", true),
    r4_range = caster:GetTalentValue("modifier_nyx_vendetta_4", "range", true),
    r4_talent_cd = caster:GetTalentValue("modifier_nyx_vendetta_4", "talent_cd", true),

  	has_legendary = 0,
  	legendary_cd = caster:GetTalentValue("modifier_nyx_vendetta_7", "cd", true),
  	legendary_attacks = caster:GetTalentValue("modifier_nyx_vendetta_7", "attacks", true),
  	legendary_armor = caster:GetTalentValue("modifier_nyx_vendetta_7", "armor", true),
  	legendary_duration = caster:GetTalentValue("modifier_nyx_vendetta_7", "duration", true),
  	legendary_linger = caster:GetTalentValue("modifier_nyx_vendetta_7", "linger", true),
  	legendary_cleave = caster:GetTalentValue("modifier_nyx_vendetta_7", "cleave", true)/100,
  	legendary_damage = caster:GetTalentValue("modifier_nyx_vendetta_7", "damage", true)/100,
  	r7_break_duration = caster:GetTalentValue("modifier_nyx_vendetta_7", "break_duration", true),
  	r7_bva = caster:GetTalentValue("modifier_nyx_vendetta_7", "bva", true),
  	r7_heal = caster:GetTalentValue("modifier_nyx_vendetta_7", "heal", true)/100,

  	has_h4 = 0,
    h4_radius = caster:GetTalentValue("modifier_nyx_hero_4", "radius", true),
  }
end

if caster:HasTalent("modifier_nyx_vendetta_1") then
	self.talents.has_damage = 1
	self.talents.damage_inc = caster:GetTalentValue("modifier_nyx_vendetta_1", "damage")
	self.talents.r1_speed = caster:GetTalentValue("modifier_nyx_vendetta_1", "speed")
end

if caster:HasTalent("modifier_nyx_vendetta_2") then
  self.talents.has_r2 = 1
  self.talents.r2_heal_reduce = caster:GetTalentValue("modifier_nyx_vendetta_2", "heal_reduce")
  self.talents.r2_slow = caster:GetTalentValue("modifier_nyx_vendetta_2", "slow")
end

if caster:HasTalent("modifier_nyx_vendetta_3") then
  self.talents.has_r3 = 1
  self.talents.r3_cd = caster:GetTalentValue("modifier_nyx_vendetta_3", "cd")
  self.talents.r3_cd_legendary = caster:GetTalentValue("modifier_nyx_vendetta_3", "cd_legendary")
  self.talents.r3_damage = caster:GetTalentValue("modifier_nyx_vendetta_3", "damage")/100
end

if caster:HasTalent("modifier_nyx_vendetta_4") then
  self.talents.has_r4 = 1
end

if caster:HasTalent("modifier_nyx_vendetta_7") then
	self.talents.has_legendary = 1
	if IsServer() and not self.tracker.interval then
		self.tracker.interval = 0.1
		caster:RemoveModifierByName("modifier_nyx_assassin_vendetta_custom")
		self:EndCd(0)
		self:StartCooldown(1)
		self.tracker:StartIntervalThink(self.tracker.interval)
	end
	caster:AddAttackRecordEvent_out(self.tracker, true)
	caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_nyx_hero_4") then
  self.talents.has_h4 = 1
end

end

function nyx_assassin_vendetta_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_nyx_assassin_vendetta_custom_tracker"
end

function nyx_assassin_vendetta_custom:GetCd(level)
local base = self.BaseClass.GetCooldown( self, level )
local bonus = self.talents.r3_cd and self.talents.r3_cd or 0
if self.talents.has_legendary == 1  then
	base = self.talents.legendary_cd
	bonus = self.talents.r3_cd_legendary and self.talents.r3_cd_legendary or 0
end
return base + bonus
end

function nyx_assassin_vendetta_custom:GetCooldown(level)
local result = self:GetCd(level)
if self.talents.has_legendary == 1 then
	result = result/self:GetCaster():GetCooldownReduction()
end
return result
end

function nyx_assassin_vendetta_custom:GetManaCost(level)
if self.talents.has_legendary == 1 then return 0 end
return self.BaseClass.GetManaCost(self,level) 
end

function nyx_assassin_vendetta_custom:GetBehavior()
local base = self.talents.has_legendary == 1 and DOTA_ABILITY_BEHAVIOR_PASSIVE or DOTA_ABILITY_BEHAVIOR_NO_TARGET
return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + base + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
end

function nyx_assassin_vendetta_custom:OnSpellStart()
local caster = self:GetCaster()
local duration = self.duration

caster:RemoveModifierByName("modifier_nyx_assassin_burrow_custom")
caster:AddNewModifier(caster, self, "modifier_nyx_assassin_vendetta_custom", {duration = duration})
end

function nyx_assassin_vendetta_custom:GetDamage()
local result = self.bonus_damage
if self.talents.has_legendary == 1 then
	result = result*self.talents.legendary_damage
end
return result
end

function nyx_assassin_vendetta_custom:PlayEffect(target)
if not IsServer() then return end
local caster = self:GetCaster()
target:EmitSound("Hero_NyxAssassin.Vendetta.Crit")

local vec = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
vec.z = 0
local effect = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf", PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(effect, 0, caster:GetAbsOrigin()) 
ParticleManager:SetParticleControlForward(effect, 0, vec) 
ParticleManager:SetParticleControlEnt(effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(effect)
end

function nyx_assassin_vendetta_custom:SpawnScarab(point)
if not IsServer() then return end	
if self.talents.has_r3 == 0 then return end
if not self:IsTrained() then return end

local caster = self:GetCaster()
local pos = point + RandomVector(220)

local unit = CreateUnitByName("npc_nyx_assassin_scarab_custom", pos, false, caster, caster, caster:GetTeamNumber())
unit:AddNewModifier(caster, self, "modifier_nyx_assassin_vendetta_custom_scarab", {})
unit:AddNewModifier(caster, self, "modifier_kill", { duration = self.talents.r3_duration })
unit:GenericParticle("particles/neutral_fx/skeleton_spawn.vpcf")
unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1.5)

unit.owner = caster

EmitSoundOnLocationWithCaster(unit:GetAbsOrigin(), "Nyx.Vendetta_scarab_spawn", caster)
unit:SetAngles(0, 0, 0)
unit:SetForwardVector(caster:GetForwardVector())
FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
end

function nyx_assassin_vendetta_custom:ProcBash(target, bash_proc)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_r4 == 0 then return end

if not bash_proc then
	if target:HasModifier("modifier_nyx_assassin_vendetta_custom_bash_cd") then return end
	if not RollPseudoRandomPercentage(self.ability.talents.r4_chance, 9953, self.parent) then return end
end

local effect = ParticleManager:CreateParticle("particles/nyx_assassin/vendetta_bash.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(effect)

target:EmitSound("Nyx.Vendetta_bash")
target:AddNewModifier(self.parent, self.ability, "modifier_bashed", {duration = self.ability.talents.r4_stun*(1 - target:GetStatusResistance())})
target:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_bash_cd", {duration = self.ability.talents.r4_talent_cd})
end


modifier_nyx_assassin_vendetta_custom_tracker = class(mod_hidden)
function modifier_nyx_assassin_vendetta_custom_tracker:GetTexture() return "buffs/nyx_assassin/vendetta_3" end
function modifier_nyx_assassin_vendetta_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.vendetta_ability = self.ability
self.base_bva = self.parent:GetBaseAttackTime(false)

self.ability.duration = self.ability:GetSpecialValueFor("duration")		
self.ability.movement_speed = self.ability:GetSpecialValueFor("movement_speed")		
self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")	
self.ability.attack_animation_bonus = self.ability:GetSpecialValueFor("attack_animation_bonus")
self.ability.attack_range_bonus = self.ability:GetSpecialValueFor("attack_range_bonus")
self.ability.break_duration = self.ability:GetSpecialValueFor("break_duration")

self.ability.shard_max_move = self.ability:GetSpecialValueFor("shard_max_move")
self.ability.shard_duration = self.ability:GetSpecialValueFor("shard_duration")
self.ability.shard_move = self.ability:GetSpecialValueFor("shard_move")

self.record = true
self.parent:AddAttackEvent_out(self)
end

function modifier_nyx_assassin_vendetta_custom_tracker:OnRefresh()
self.ability.movement_speed = self.ability:GetSpecialValueFor("movement_speed")		
self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")	
end

function modifier_nyx_assassin_vendetta_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_legendary == 0 then return end

local max = self.ability.talents.legendary_duration
local time = 0
local stack = 0

if IsValid(self.ability.legendary_target) then
	local mod = self.ability.legendary_target:FindModifierByName("modifier_nyx_assassin_vendetta_custom_legendary_armor")
	if mod then
		time = mod:GetRemainingTime()
		stack = mod:GetStackCount()*mod.armor
	else
		self.ability.legendary_target = nil
	end
end

self.parent:UpdateUIlong({max = max, stack = time, override_stack = stack, style = "NyxVendetta"})

if self.ability:GetCooldownTimeRemaining() > 0 then return end
if self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom") or not self.parent:IsAlive() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom", {})
end

function modifier_nyx_assassin_vendetta_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
}
end

function modifier_nyx_assassin_vendetta_custom_tracker:GetModifierPreAttack_BonusDamage()
return self.ability.talents.damage_inc*((self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_bonus") or self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom")) and self.ability.talents.damage_bonus or 1)
end

function modifier_nyx_assassin_vendetta_custom_tracker:GetModifierAttackSpeedBonus_Constant()
return self.ability.talents.r1_speed*((self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_bonus") or self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom")) and self.ability.talents.damage_bonus or 1)
end

function modifier_nyx_assassin_vendetta_custom_tracker:GetModifierAttackRangeBonus()
if self.ability.talents.has_r4 == 0 then return end
return self.ability.talents.r4_range
end

function modifier_nyx_assassin_vendetta_custom_tracker:GetModifierBaseAttackTimeConstant()
if self.ability.talents.has_legendary == 0 then return end
if self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_damage") then return end
return self.base_bva + self.ability.talents.r7_bva
end

function modifier_nyx_assassin_vendetta_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if params.record ~= self.record then return end
if params.inflictor then return end

local result = self.parent:CheckLifesteal(params)
if not result then return end

self.parent:GenericHeal(self.ability.talents.r7_heal*result*params.damage, self.ability, false, false, "modifier_nyx_vendetta_7")
self.record = nil
end

function modifier_nyx_assassin_vendetta_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end

local attacker = params.attacker
local target = params.target
local bash_proc = false

if attacker ~= self.parent then return end

if not params.no_attack_cooldown then
	local mod = self.parent:FindModifierByName("modifier_nyx_assassin_vendetta_custom")
	local damage_mod = self.parent:FindModifierByName("modifier_nyx_assassin_vendetta_custom_damage")
	local has_legendary = self.ability.talents.has_legendary == 1

	if damage_mod then
		damage_mod:DecrementStackCount()
		self.ability:PlayEffect(target)

		if has_legendary then
			DoCleaveAttack( self.parent, target, self.ability, self.ability.talents.legendary_cleave*params.damage, 150, 360, 650, "particles/bloodseeker/thirst_cleave.vpcf" )		
		end

		self.record = params.record

		if damage_mod:GetStackCount() <= 0 then
			damage_mod:Destroy()
			if has_legendary and target:IsUnit() then
				target:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_legendary_armor", {duration = self.ability.talents.legendary_duration})
			end
		end
	end

	if mod and not mod.ended then 
		mod.ended = true
		mod:Destroy()

		if target:IsUnit() then
			if not has_legendary then
				local damageTable = {victim = target, attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_PURE, damage = self.ability:GetDamage()}
				local real_damage = DoDamage(damageTable)
				target:SendNumber(6, real_damage)
			end

			local break_duration = self.ability.break_duration
			if has_legendary then
				break_duration = break_duration/self.ability.talents.r7_break_duration
			end 
			target:AddNewModifier(self.parent, self.ability, "modifier_generic_break", {duration = break_duration*(1 - target:GetStatusResistance())})

			self.parent:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_bonus", {duration = self.ability.talents.damage_duration})

			if self.ability.talents.has_r2 == 1 then
				target:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus", {duration = self.ability.talents.r2_duration})
			end

			bash_proc = true
			self.ability:SpawnScarab(target:GetAbsOrigin())

			if IsValid(self.parent.carapace_ability) then
				self.parent.carapace_ability:SpeedStack()
			end

			if IsValid(self.parent.impale_ability) then
				self.parent.impale_ability:AbilityHit(target)
				self.parent.impale_ability:ProcCd()
			end
		end
	end
end

if not target:IsUnit() then return end

if self.ability.talents.has_r2 == 1 then
	target:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_heal_reduce", {duration = self.ability.talents.r2_slow_duration})
end

if self.ability.talents.has_r4 == 1 then
	self.ability:ProcBash(target, bash_proc)
end

end

function modifier_nyx_assassin_vendetta_custom_tracker:AttackRecordEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
if self.ability.talents.has_legendary == 1 and not self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom") then
	self.ability:StartCd(self.ability:GetCd(self.ability:GetLevel()))
end

end


modifier_nyx_assassin_vendetta_custom = class(mod_visible)
function modifier_nyx_assassin_vendetta_custom:IsHidden() return self.ability.talents.has_legendary == 1 end
function modifier_nyx_assassin_vendetta_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move_speed = self.ability.movement_speed + (self.parent:HasShard() and self.ability.shard_move or 0)
self.anim = self.ability.attack_animation_bonus

self.remove_limit = 0
self.move_limit = nil

if self.parent:HasShard() then
	self.remove_limit = 1
	self.move_limit = self.ability.shard_max_move
	if IsServer() then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_shard", {duration = self.ability.shard_duration})
	end
end

if not IsServer() then return end
self.ability:EndCd()
self.RemoveForDuel = true

self.parent:RemoveModifierByName("modifier_nyx_assassin_vendetta_custom_damage")

self.mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_vendetta_custom_damage", {})

self.parent:EmitSound("Hero_NyxAssassin.Vendetta")

local effect = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect, 0, self.parent:GetAbsOrigin()) 
ParticleManager:ReleaseParticleIndex(effect)

self.parent:GenericParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_speed.vpcf", self)

self.allow_abilities =
{
  ["nyx_assassin_spiked_carapace_custom"] = true,
}

self.parent:AddSpellEvent(self, true)

if self.ability.talents.has_h4 == 0 then return end
self.interval = 0.2
self:StartIntervalThink(self.interval)
end

function modifier_nyx_assassin_vendetta_custom:OnIntervalThink()
if not IsServer() then return end

local min_dist = 999999
local min_player = nil

for _,player in pairs(players) do
  local dist = (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()
  if player:IsAlive() and player:GetTeamNumber() ~= self.parent:GetTeamNumber() and dist <= self.ability.talents.h4_radius and min_dist > dist then
    min_dist = dist
    min_player = player
  end
end

if not min_player then return end
AddFOWViewer(self.parent:GetTeamNumber(), min_player:GetAbsOrigin(), 50, self.interval*2, false)
end

function modifier_nyx_assassin_vendetta_custom:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
  MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
  MODIFIER_PROPERTY_MOVESPEED_LIMIT,
  MODIFIER_PROPERTY_MOVESPEED_MAX,
}
end

function modifier_nyx_assassin_vendetta_custom:GetModifierIgnoreMovespeedLimit( params )
return self.remove_limit
end

function modifier_nyx_assassin_vendetta_custom:GetModifierMoveSpeed_Max( params )
return self.move_limit
end

function modifier_nyx_assassin_vendetta_custom:GetModifierMoveSpeed_Limit()
return self.move_limit
end

function modifier_nyx_assassin_vendetta_custom:GetModifierMoveSpeedBonus_Percentage() 
return self.move_speed
end

function modifier_nyx_assassin_vendetta_custom:GetModifierAttackSpeedBonus_Constant()
if IsClient() then return end
return 300
end

function modifier_nyx_assassin_vendetta_custom:GetModifierInvisibilityLevel() 
return 1 
end

function modifier_nyx_assassin_vendetta_custom:SpellEvent( params )
if not IsServer() then return end
if self.ended then return end
if self.allow_abilities[params.ability:GetName()] then return end
if params.unit ~= self.parent then return end

self.ended = true
self:Destroy()
end

function modifier_nyx_assassin_vendetta_custom:CheckState()
local state_table = 
{
  [MODIFIER_STATE_INVISIBLE] = true,
  [MODIFIER_STATE_CANNOT_MISS] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
return state_table
end

function modifier_nyx_assassin_vendetta_custom:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:RemoveModifierByName("modifier_nyx_assassin_vendetta_custom_shard")

if IsValid(self.mod) then
	if self.ability.talents.has_legendary == 1 then
		self.mod:SetDuration(self.ability.talents.legendary_linger, true)
	else
		self.mod:Destroy()
	end
end

end


modifier_nyx_assassin_vendetta_custom_damage = class(mod_hidden)
function modifier_nyx_assassin_vendetta_custom_damage:IsHidden() return self.ability.talents.has_legendary == 0 end
function modifier_nyx_assassin_vendetta_custom_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetDamage()
self.range = self.ability.attack_range_bonus

if not IsServer() then return end
local stack = 1

if self.ability.talents.has_legendary == 1 then
	stack = self.ability.talents.legendary_attacks
end
self:SetStackCount(stack)
end

function modifier_nyx_assassin_vendetta_custom_damage:CheckState()
return 
{
    [MODIFIER_STATE_CANNOT_MISS] = true,
}
end

function modifier_nyx_assassin_vendetta_custom_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end

function modifier_nyx_assassin_vendetta_custom_damage:GetActivityTranslationModifiers()
return "vendetta"
end

function modifier_nyx_assassin_vendetta_custom_damage:GetModifierAttackRangeBonus()
return self.range
end

function modifier_nyx_assassin_vendetta_custom_damage:GetModifierPreAttack_BonusDamage(params)
if self.ability.talents.has_legendary == 0 then return end
if IsServer() and not params.target then return end
if self.parent:HasModifier("modifier_nyx_assassin_spiked_carapace_custom_attack") then return end
return self.damage
end


modifier_nyx_assassin_vendetta_custom_legendary_armor = class(mod_visible)
function modifier_nyx_assassin_vendetta_custom_legendary_armor:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.armor = self.ability.talents.legendary_armor
if not IsServer() then return end
self.RemoveForDuel = true
self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
self:AddStack()
end

function modifier_nyx_assassin_vendetta_custom_legendary_armor:OnRefresh()
if not IsServer() then return end
self:AddStack()
end

function modifier_nyx_assassin_vendetta_custom_legendary_armor:AddStack()
if not IsServer() then return end
self.parent:EmitSound("Nyx.Vendetta_legendary_armor")
self:StartIntervalThink(0.1)
end

function modifier_nyx_assassin_vendetta_custom_legendary_armor:OnIntervalThink()
if not IsServer() then return end
self:IncrementStackCount()
self.ability.legendary_target = self.parent
self:StartIntervalThink(-1)
end

function modifier_nyx_assassin_vendetta_custom_legendary_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_nyx_assassin_vendetta_custom_legendary_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end


modifier_nyx_assassin_vendetta_custom_shard = class(mod_visible)
function modifier_nyx_assassin_vendetta_custom_shard:GetTexture() return "item_aghanims_shard" end
function modifier_nyx_assassin_vendetta_custom_shard:CheckState()
return
{
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
}
end



modifier_nyx_assassin_vendetta_custom_scarab = class(mod_hidden)
function modifier_nyx_assassin_vendetta_custom_scarab:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
local health = 100
self.parent:SetBaseAttackTime(self.ability.talents.r3_bva)

self.parent:SetBaseMaxHealth(health)
--self.parent:SetHealth(health)

self.vec = RandomVector(200)
self.radius = 1000

self:OnIntervalThink()
self:StartIntervalThink(0.5)
end

function modifier_nyx_assassin_vendetta_custom_scarab:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
}
end

function modifier_nyx_assassin_vendetta_custom_scarab:GetModifierOverrideAttackDamage()
if not IsServer() then return end
return self.ability.talents.r3_damage*self.caster:GetAverageTrueAttackDamage(nil)
end 

function modifier_nyx_assassin_vendetta_custom_scarab:IsValidTarget(target)
if not IsServer() then return end 

if not IsValid(target) or not target:IsAlive() or not target:IsUnit() or target:IsCourier() or 
 ((target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius) or target:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then 
	return false 
end

return true
end 

function modifier_nyx_assassin_vendetta_custom_scarab:SetTarget(target)
if not IsServer() then return end
if not self:IsValidTarget(target) then return end
if self.target == target then return end

self.target = target
self.parent:MoveToTargetToAttack(self.target)
self.parent:SetForceAttackTarget(self.target)
end 


function modifier_nyx_assassin_vendetta_custom_scarab:MoveToCaster()
if not IsServer() then return end

self.target = nil
self.parent:SetForceAttackTarget(nil)

local point = self.caster:GetAbsOrigin() + self.vec

if (point - self.parent:GetAbsOrigin()):Length2D() > 50 then 
	self.parent:MoveToPosition(self.caster:GetAbsOrigin() + self.vec)
end

end

function modifier_nyx_assassin_vendetta_custom_scarab:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then 
	self:StartIntervalThink(-1)
	return 
end

if self.parent:GetAggroTarget() then
    self.target = self.parent:GetAggroTarget()
end

local heroes = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
local creeps = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )

if self:IsValidTarget(self.target) and self.target:IsHero() then 
    self:SetTarget(self.target)
    return
end 

if (not self:IsValidTarget(self.target) or not self.target:IsHero()) and #heroes > 0  then
	for _,hero in pairs(heroes) do
		if self:IsValidTarget(hero) then 
			self:SetTarget(hero)
        	break
		end
	end 
end

if not self:IsValidTarget(self.target) and #creeps > 0 then 
	for _,creep in pairs(creeps) do
		if self:IsValidTarget(creep) then 
			self:SetTarget(creep)
        	break
		end
	end
end 

if not self:IsValidTarget(self.target) then 
	self:MoveToCaster()
end

end

function modifier_nyx_assassin_vendetta_custom_scarab:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_UNSELECTABLE] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_UNTARGETABLE] = true
}
end

function modifier_nyx_assassin_vendetta_custom_scarab:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_nyx_assassin_vendetta_custom_scarab:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_nyx_assassin_vendetta_custom_scarab:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_nyx_assassin_vendetta_custom_scarab:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end


modifier_nyx_assassin_vendetta_custom_bonus = class(mod_hidden)


modifier_nyx_assassin_vendetta_custom_heal_reduce = class(mod_hidden)
function modifier_nyx_assassin_vendetta_custom_heal_reduce:IsPurgable() return true end
function modifier_nyx_assassin_vendetta_custom_heal_reduce:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.heal_reduce = self.ability.talents.r2_heal_reduce
self.slow = self.ability.talents.r2_slow
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", self)
end

function modifier_nyx_assassin_vendetta_custom_heal_reduce:DeclareFunctions()
return
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_nyx_assassin_vendetta_custom_heal_reduce:GetModifierMoveSpeedBonus_Percentage()
return self.slow*(self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus") and self.ability.talents.r2_bonus or 1)
end

function modifier_nyx_assassin_vendetta_custom_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce*(self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus") and self.ability.talents.r2_bonus or 1)
end

function modifier_nyx_assassin_vendetta_custom_heal_reduce:GetModifierHealChange() 
return self.heal_reduce*(self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus") and self.ability.talents.r2_bonus or 1)
end

function modifier_nyx_assassin_vendetta_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce*(self.parent:HasModifier("modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus") and self.ability.talents.r2_bonus or 1)
end

modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus = class(mod_hidden)
function modifier_nyx_assassin_vendetta_custom_heal_reduce_bonus:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

modifier_nyx_assassin_vendetta_custom_bash_cd = class(mod_hidden)