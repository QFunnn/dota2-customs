--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sven_gods_strength_custom", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_root", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_tracker", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_legendary_stack", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_crit", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_crit_armor", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_crit_slow", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_crit_anim", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_crit_anim2", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_str_bonus", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_proc_cd", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_root_cd", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_gods_strength_custom_root_unmiss", "abilities/sven/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE )


sven_gods_strength_custom = class({})



function sven_gods_strength_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_gods_strength.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_gods_strength.vpcf", context )
PrecacheResource( "particle","particles/sven_wave.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_gods_strength.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_gods_strength_ambient.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/hook_root.vpcf", context )
PrecacheResource( "particle","particles/sven_rage.vpcf", context )
PrecacheResource( "particle","particles/mars_shield_legendary.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/sven_god_normal_cleave.vpcf", context )
PrecacheResource( "particle","particles/sven_god_cleave.vpcf", context )
PrecacheResource( "particle","particles/sven_god_cleave_2.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf", context )
PrecacheResource( "particle","particles/sven_wave_god_damage.vpcf", context )

PrecacheResource( "particle","particles/units/heroes/hero_enigma/enigma_blackhole.vpcf", context )
end


function sven_gods_strength_custom:GetCastPoint(iLevel)
local bonus = 1
if self:GetCaster():HasTalent("modifier_sven_god_5") then 
    bonus = 1 + self:GetCaster():GetTalentValue("modifier_sven_god_5", "cast")/100
end
return self.BaseClass.GetCastPoint(self)*bonus
end


function sven_gods_strength_custom:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sven_god_3") then
	bonus = self:GetCaster():GetTalentValue("modifier_sven_god_3", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function sven_gods_strength_custom:LegendaryUI()
if not IsServer() then return end

local mod = self:GetCaster():FindModifierByName("modifier_sven_gods_strength_custom_tracker")
if mod then
	mod:UpdateUI()
end

end

function sven_gods_strength_custom:LegendaryStack(count)
local caster = self:GetCaster()

if not caster:HasTalent("modifier_sven_god_7") then return end
local ability = caster:FindAbilityByName("sven_gods_strength_custom_legendary")
if not ability or ability:GetCooldownTimeRemaining() > 0 then return end

for i = 1,count do
	caster:AddNewModifier(caster, self, "modifier_sven_gods_strength_custom_legendary_stack", {duration = caster:GetTalentValue("modifier_sven_god_7", "duration", true)})
end

end


function sven_gods_strength_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sven_gods_strength_custom_tracker"
end


function sven_gods_strength_custom:ProcUlt(main)

local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_sven_gods_strength_custom")
local dota_mod = caster:FindModifierByName("modifier_sven_gods_strength")

local duration = self:GetSpecialValueFor( "gods_strength_duration" ) + caster:GetTalentValue("modifier_sven_god_3", "duration")

if main == 0 then
	duration = caster:GetTalentValue("modifier_sven_god_6", "duration")
else
	self:EndCd()
end

if caster:HasTalent("modifier_sven_god_6") then
	caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {duration = caster:GetTalentValue("modifier_sven_god_6", "bkb"), effect = 1})
end

if mod then 
	local new_duration = mod:GetRemainingTime() + duration
	mod:SetDuration(new_duration, true)

	if dota_mod then 
		dota_mod:SetDuration(new_duration, true)
	end 
else 
	mod = caster:AddNewModifier( caster, self, "modifier_sven_gods_strength_custom", { duration = duration }  )
	caster:AddNewModifier( caster, self, "modifier_sven_gods_strength", { duration = duration }  )
end

end



function sven_gods_strength_custom:OnSpellStart()
local caster = self:GetCaster()


local bkb_duration = caster:GetTalentValue("modifier_sven_god_5", "bkb")
local root = caster:GetTalentValue("modifier_sven_god_5", "root")
local radius = caster:GetTalentValue("modifier_sven_god_5", "radius")

self:ProcUlt(1)

local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_spell_gods_strength.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
ParticleManager:SetParticleControl( nFXIndex, 1, caster:GetOrigin())
ParticleManager:ReleaseParticleIndex( nFXIndex )

caster:EmitSound("Hero_Sven.GodsStrength")

if caster:GetName() == "npc_dota_hero_sven" then
	caster:EmitSound("sven_sven_ability_godstrength_0"..RandomInt(1, 2))
end

end





modifier_sven_gods_strength_custom = class({})
function modifier_sven_gods_strength_custom:IsPurgable() return false end
function modifier_sven_gods_strength_custom:IsHidden() return true end
function modifier_sven_gods_strength_custom:GetStatusEffectName() return "particles/status_fx/status_effect_gods_strength.vpcf" end
function modifier_sven_gods_strength_custom:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end
function modifier_sven_gods_strength_custom:GetHeroEffectName()	return "particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf" end
function modifier_sven_gods_strength_custom:HeroEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end


function modifier_sven_gods_strength_custom:OnCreated( table )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.gods_strength_damage = self.ability:GetSpecialValueFor( "damage" )

self.max = self.parent:GetTalentValue("modifier_sven_god_1", "max", true)
self.damage_bonus = self.parent:GetTalentValue("modifier_sven_god_1", "damage")/self.max

if not IsServer() then return end

self.RemoveForDuel = true


--[[local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_spell_gods_strength_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( nFXIndex, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon" , self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( nFXIndex, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_head" , self.parent:GetOrigin(), true )
self:AddParticle( nFXIndex, false, false, -1, false, true )
]]--

self.parent:CalculateStatBonus(true)
end



function modifier_sven_gods_strength_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
}
end

function modifier_sven_gods_strength_custom:GetModifierMoveSpeedBonus_Constant()
return	self.move
end

function modifier_sven_gods_strength_custom:GetModifierBaseDamageOutgoing_Percentage()
return self.gods_strength_damage + self:GetStackCount()*self.damage_bonus
end

function modifier_sven_gods_strength_custom:AddStack()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

local mod = self.parent:FindModifierByName("modifier_sven_gods_strength")

if mod then 
	mod:IncrementStackCount()
end 

end


function modifier_sven_gods_strength_custom:OnDestroy()
if not IsServer() then return end 

if not self.ability:IsActivated() then
	self.ability:StartCd()
end

self.parent:RemoveModifierByName("modifier_sven_gods_strength")
end 




 

modifier_sven_gods_strength_custom_root = class({})
function modifier_sven_gods_strength_custom_root:IsHidden() return false end
function modifier_sven_gods_strength_custom_root:IsPurgable() return true end
function modifier_sven_gods_strength_custom_root:GetTexture() return "buffs/hook_root" end
function modifier_sven_gods_strength_custom_root:CheckState()
return
{
    [MODIFIER_STATE_ROOTED] = true,
}
end

function modifier_sven_gods_strength_custom_root:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.parent:EmitSound("Lc.Press_Root")
self.parent:GenericParticle("particles/items3_fx/hook_root.vpcf", self)
end




modifier_sven_gods_strength_custom_tracker = class({})
function modifier_sven_gods_strength_custom_tracker:IsHidden() return true end
function modifier_sven_gods_strength_custom_tracker:IsPurgable() return false end
function modifier_sven_gods_strength_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
}

end

function modifier_sven_gods_strength_custom_tracker:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_sven_god_1") then return end
return self.parent:GetStrength()*self.parent:GetTalentValue("modifier_sven_god_1", "speed")/100
end

function modifier_sven_gods_strength_custom_tracker:GetModifierBaseAttack_BonusDamage()
if not self.parent:HasTalent("modifier_sven_god_4") then return end
return self.parent:GetStrength()*self.parent:GetTalentValue("modifier_sven_god_4", "damage")/100
end


function modifier_sven_gods_strength_custom_tracker:OnCreated(table)
self.active = 0
self.damage_count = 0
self.max = false

self.parent = self:GetParent() 
self.ability = self:GetAbility()
self.parent:AddDamageEvent_out(self)
self.parent:AddDamageEvent_inc(self)
self.parent:AddAttackEvent_out(self)

self.heal_creeps = self.parent:GetTalentValue("modifier_sven_god_2", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_sven_god_2", "bonus",  true)

self.proc_cd = self.parent:GetTalentValue("modifier_sven_god_6", "cd", true)

self.str_duration = self.parent:GetTalentValue("modifier_sven_god_4", "duration", true)

self.root_duration = self.parent:GetTalentValue("modifier_sven_god_5", "root", true)
self.root_radius = self.parent:GetTalentValue("modifier_sven_god_5", "radius", true)
self.root_cd = self.parent:GetTalentValue("modifier_sven_god_5", "cd", true)

self.legendary_max = self.parent:GetTalentValue("modifier_sven_god_7", "max", true)
self.legendary_health = self.parent:GetTalentValue("modifier_sven_god_7", "health", true)
self.legendary_ability = self.parent:FindAbilityByName("sven_gods_strength_custom_legendary")

self.visual_max = 6

if not IsServer() then return end
self:StartIntervalThink(1)
end


function modifier_sven_gods_strength_custom_tracker:UpdateUI()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sven_god_7") then return end

local stack = 0
local override = nil
local interval = -1
local mod = self.parent:FindModifierByName("modifier_sven_gods_strength_custom_legendary_stack")

if mod then
	stack = mod:GetStackCount()
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
else
	if not self.particle then
		self.particle = self.parent:GenericParticle("particles/sven_rage.vpcf", self, true)
		for i = 1,self.visual_max do 
			ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
		end
	end
end

if self.legendary_ability then
	self.legendary_ability:SetActivated(stack > 0)
end

self.parent:UpdateUIlong({stack = stack, max = self.legendary_max, override_stack = override, style = "SvenStrength"})
self:StartIntervalThink(interval)
end

function modifier_sven_gods_strength_custom_tracker:OnIntervalThink()
if not IsServer() then return end
self:UpdateUI()
end


function modifier_sven_gods_strength_custom_tracker:CheckState()
if not self.parent:HasModifier("modifier_sven_gods_strength_custom") then return end
if not self.parent:HasTalent("modifier_sven_god_5") then return end
if self.parent:HasModifier("modifier_sven_gods_strength_custom_root_cd") then return end
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end



function modifier_sven_gods_strength_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local target = params.target

if self.parent:HasTalent("modifier_sven_god_7") and not params.no_attack_cooldown then 
	self.ability:LegendaryStack(1)
end

local mod = self.parent:FindModifierByName("modifier_sven_gods_strength_custom")

if mod then
	target:EmitSound("Hero_Sven.Layer.GodsStrength")

	if self.parent:HasTalent("modifier_sven_god_1") then 
		mod:AddStack()
	end

	if self.parent:HasTalent("modifier_sven_god_5") and not self.parent:HasModifier("modifier_sven_gods_strength_custom_root_cd") and not target:HasModifier("modifier_sven_storm_bolt_custom_stun") then
		self.parent:GenericParticle("particles/sven_wave.vpcf")
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_gods_strength_custom_root_cd", {duration = self.root_cd})
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_gods_strength_custom_root_unmiss", {duration = self.root_duration})

		local targets = self.parent:FindTargets(self.root_radius)
		table.insert(targets, target)

		for _,target in pairs(targets) do 
			if not target:HasModifier("modifier_sven_gods_strength_custom_root") then
				target:AddNewModifier(self.parent, self.ability, "modifier_sven_gods_strength_custom_root", {duration = (1 - target:GetStatusResistance())*self.root_duration})
			end
		end
	end
end 

if self.parent:HasTalent("modifier_sven_god_4") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_gods_strength_custom_str_bonus", {duration = self.str_duration})
end

self.parent:CalculateStatBonus(true)
end


function modifier_sven_gods_strength_custom_tracker:DamageEvent_out( params )
if not IsServer() then return end

if self.parent:HasTalent("modifier_sven_god_2") and self.parent:CheckLifesteal(params) then
	local heal = params.damage*self.parent:GetTalentValue("modifier_sven_god_2", "heal")/100

	if self.parent:HasModifier("modifier_sven_gods_strength_custom") then
		heal = heal*self.heal_bonus
	end

	if params.unit:IsCreep() then
		heal = heal / self.heal_creeps
	end
	self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_sven_god_2")
end

end


function modifier_sven_gods_strength_custom_tracker:DamageEvent_inc( params )
if not IsServer() then return end
if self.parent ~= params.unit then return end

if not self.parent:PassivesDisabled() and not self.parent:HasModifier("modifier_death") and self.parent:HasTalent("modifier_sven_god_6")
	and self.parent:GetHealthPercent() <= self.parent:GetTalentValue("modifier_sven_god_6", "health") and not self.parent:HasModifier("modifier_sven_gods_strength_custom_proc_cd") then 

	self.parent:Purge(false, true, false, true, true)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_gods_strength_custom_proc_cd", {duration = self.proc_cd})

	self.parent:EmitSound("Sven.God_proc")
	self.parent:EmitSound("Sven.God_proc2")

	local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_peffect)

	self.ability:ProcUlt(0)
end

if not self.parent:HasTalent("modifier_sven_god_7") then return end
local final = self.damage_count + params.damage

if final >= self.legendary_health then 

    local delta = math.floor(final/self.legendary_health)
    self.ability:LegendaryStack(delta)

    self.damage_count = final - delta*self.legendary_health
else 
    self.damage_count = final
end 

end









sven_gods_strength_custom_legendary = class({})

function sven_gods_strength_custom_legendary:CreateTalent()
self:SetHidden(false)

local ability = self:GetCaster():FindAbilityByName("sven_gods_strength_custom")
if ability then
	ability:LegendaryUI()
end

end

function sven_gods_strength_custom_legendary:OnAbilityPhaseStart()
if not IsServer() then return end
local caster = self:GetCaster()

caster:AddNewModifier(caster, self, "modifier_sven_gods_strength_custom_crit_anim", {})
caster:AddNewModifier(caster, self, "modifier_sven_gods_strength_custom_crit_anim2", {})
caster:StartGesture(ACT_DOTA_ATTACK)

caster:EmitSound("Sven.Cleave_wave_pre")
caster:EmitSound("Sven.God_crit_cast")
return true
end

function sven_gods_strength_custom_legendary:OnAbilityPhaseInterrupted()
if not IsServer() then return end
local caster = self:GetCaster()

caster:RemoveModifierByName("modifier_sven_gods_strength_custom_crit_anim")
caster:RemoveModifierByName("modifier_sven_gods_strength_custom_crit_anim2")
caster:FadeGesture(ACT_DOTA_ATTACK)
end


function sven_gods_strength_custom_legendary:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("Sven.Cleave_wave_cast")
caster:EmitSound("Sven.God_crit_ground")

caster:EmitSound("Sven.God_legendary_active_voice")

caster:RemoveModifierByName("modifier_sven_gods_strength_custom_crit_anim")
caster:RemoveModifierByName("modifier_sven_gods_strength_custom_crit_anim2")

local ability = caster:FindAbilityByName("sven_gods_strength_custom")
local mod = caster:FindModifierByName("modifier_sven_gods_strength_custom_legendary_stack")

if not ability or ability:GetLevel() < 1 then return end
if not mod then return end

local max_stack = caster:GetTalentValue("modifier_sven_god_7", "max")
local rage = mod:GetStackCount()

local fxRange = 400
local direction = caster:GetForwardVector()

local fxPoint = caster:GetAbsOrigin() + (direction * fxRange)

local part = "particles/sven_god_normal_cleave.vpcf"

if rage >= max_stack then 
	caster:EmitSound("Sven.God_crit_ground_max")
	part = "particles/sven_god_cleave.vpcf"

	local particleName = "particles/sven_god_cleave_2.vpcf"
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, fxPoint)
end

local fxIndex = ParticleManager:CreateParticle(part, PATTACH_CUSTOMORIGIN,  caster )
ParticleManager:SetParticleControl(fxIndex, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControlForward(fxIndex, 0, direction)

local radius = 450
local angle = 50

local slow = caster:GetTalentValue("modifier_sven_god_7", "slow")
local crit = (caster:GetTalentValue("modifier_sven_god_7", "damage") - 100)/max_stack

local enemies = caster:FindTargets(radius) 
local origin = caster:GetOrigin()
local cast_direction =  caster:GetForwardVector()
cast_direction.z = 0

local cast_angle = VectorToAngles( cast_direction ).y

local mod_crit = caster:AddNewModifier(caster, self, "modifier_sven_gods_strength_custom_crit", {crit = crit*rage, duration = FrameTime()*2})
local mod_cleave = caster:AddNewModifier(caster, self, "modifier_no_cleave", {duration = FrameTime()*2})

for _,enemy in pairs(enemies) do
    if enemy:GetUnitName() ~= "modifier_monkey_king_wukongs_command_custom_soldier" then  

      local enemy_direction = (enemy:GetOrigin() - origin):Normalized()
      local enemy_angle = VectorToAngles( enemy_direction ).y
      local angle_diff = math.abs( AngleDiff( cast_angle, enemy_angle ) )
      if angle_diff<=angle then
     	if rage >= max_stack then 
     		enemy:AddNewModifier(caster, self, "modifier_sven_gods_strength_custom_crit_slow", {duration = slow})
      		enemy:AddNewModifier(caster, self, "modifier_sven_gods_strength_custom_crit_armor", {duration = FrameTime()})
      	end 
        caster:PerformAttack(enemy, true, true, true, true, true, false, true ) 

        enemy:RemoveModifierByName("modifier_sven_gods_strength_custom_crit_armor")

		local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf", PATTACH_WORLDORIGIN, enemy )
		ParticleManager:SetParticleControl( effect_cast, 0, enemy:GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, enemy:GetOrigin() )
		ParticleManager:SetParticleControlForward( effect_cast, 1, direction )
		ParticleManager:ReleaseParticleIndex( effect_cast )

		local particle = ParticleManager:CreateParticle( "particles/sven_wave_god_damage.vpcf", PATTACH_POINT_FOLLOW, enemy )
		ParticleManager:SetParticleControlEnt( particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:ReleaseParticleIndex( particle )
		
		enemy:EmitSound("Sven.Cry_shield_damage")
      end
    end
end

caster:RemoveModifierByName("modifier_sven_gods_strength_custom_crit")
caster:RemoveModifierByName("modifier_no_cleave")
mod:Destroy()
end



modifier_sven_gods_strength_custom_crit = class({})
function modifier_sven_gods_strength_custom_crit:IsHidden() return true end
function modifier_sven_gods_strength_custom_crit:IsPurgable() return false end
function modifier_sven_gods_strength_custom_crit:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
}
end

function modifier_sven_gods_strength_custom_crit:OnCreated(table)
if not IsServer() then return end
self.crit = table.crit + 100
end

function modifier_sven_gods_strength_custom_crit:GetCritDamage() 
return self.crit
end

function modifier_sven_gods_strength_custom_crit:GetModifierPreAttack_CriticalStrike()
return self.crit
end



modifier_sven_gods_strength_custom_crit_armor = class({})
function modifier_sven_gods_strength_custom_crit_armor:IsHidden() return true end
function modifier_sven_gods_strength_custom_crit_armor:IsPurgable() return false end
function modifier_sven_gods_strength_custom_crit_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_sven_gods_strength_custom_crit_armor:OnCreated(table)
self.armor = math.max(0, self:GetParent():GetPhysicalArmorValue(false)*self:GetCaster():GetTalentValue("modifier_sven_god_7", "armor")/100)*-1
end

function modifier_sven_gods_strength_custom_crit_armor:GetModifierPhysicalArmorBonus() 
return self.armor
end


modifier_sven_gods_strength_custom_crit_slow = class({})
function modifier_sven_gods_strength_custom_crit_slow:IsHidden() return true end
function modifier_sven_gods_strength_custom_crit_slow:IsPurgable() return true end
function modifier_sven_gods_strength_custom_crit_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_sven_gods_strength_custom_crit_slow:OnCreated(table)
self.ability = self:GetAbility()
self.attack = self.ability:GetSpecialValueFor("attack")
self.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_sven_gods_strength_custom_crit_slow:GetModifierAttackSpeedBonus_Constant() 
return self.attack
end

function modifier_sven_gods_strength_custom_crit_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_sven_gods_strength_custom_crit_anim = class({})
function modifier_sven_gods_strength_custom_crit_anim:IsHidden() return true end
function modifier_sven_gods_strength_custom_crit_anim:IsPurgable() return false end
function modifier_sven_gods_strength_custom_crit_anim:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_sven_gods_strength_custom_crit_anim:GetActivityTranslationModifiers()
return "sven_warcry"
end


modifier_sven_gods_strength_custom_crit_anim2 = class({})
function modifier_sven_gods_strength_custom_crit_anim2:IsHidden() return true end
function modifier_sven_gods_strength_custom_crit_anim2:IsPurgable() return false end
function modifier_sven_gods_strength_custom_crit_anim2:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_sven_gods_strength_custom_crit_anim2:GetActivityTranslationModifiers()
return "sven_shield"
end




modifier_sven_gods_strength_custom_str_bonus = class({})
function modifier_sven_gods_strength_custom_str_bonus:IsHidden() return false end
function modifier_sven_gods_strength_custom_str_bonus:IsPurgable() return false end
function modifier_sven_gods_strength_custom_str_bonus:GetTexture() return "buffs/spear_str" end
function modifier_sven_gods_strength_custom_str_bonus:OnCreated()

self.parent = self:GetParent()

self.max = self.parent:GetTalentValue("modifier_sven_god_4", "max")
self.str = self.parent:GetTalentValue("modifier_sven_god_4", "str")/self.max
self.bonus = self.parent:GetTalentValue("modifier_sven_god_4", "bonus")

if not IsServer() then return end 
self:SetStackCount(1)
self.parent:CalculateStatBonus(true)
end 

function modifier_sven_gods_strength_custom_str_bonus:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end

function modifier_sven_gods_strength_custom_str_bonus:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_sven_gods_strength_custom_str_bonus:GetModifierModelScale()
return self:GetStackCount()*2
end

function modifier_sven_gods_strength_custom_str_bonus:GetModifierBonusStats_Strength()
local bonus = 1
if self.parent:HasModifier("modifier_sven_gods_strength_custom") then 
	bonus = self.bonus
end 
return (self:GetStackCount()*self.str)*bonus
end


modifier_sven_gods_strength_custom_root_cd = class({})
function modifier_sven_gods_strength_custom_root_cd:IsHidden() return false end
function modifier_sven_gods_strength_custom_root_cd:IsPurgable() return false end
function modifier_sven_gods_strength_custom_root_cd:RemoveOnDeath() return false end
function modifier_sven_gods_strength_custom_root_cd:IsDebuff() return true end
function modifier_sven_gods_strength_custom_root_cd:GetTexture() return "buffs/bulwark_face" end
function modifier_sven_gods_strength_custom_root_cd:OnCreated()
self.RemoveForDuel = true
end

modifier_sven_gods_strength_custom_root_unmiss = class({})
function modifier_sven_gods_strength_custom_root_unmiss:IsHidden() return true end
function modifier_sven_gods_strength_custom_root_unmiss:IsPurgable() return false end
function modifier_sven_gods_strength_custom_root_unmiss:CheckState()
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end


modifier_sven_gods_strength_custom_proc_cd = class({})
function modifier_sven_gods_strength_custom_proc_cd:IsHidden() return false end
function modifier_sven_gods_strength_custom_proc_cd:IsPurgable() return false end 
function modifier_sven_gods_strength_custom_proc_cd:RemoveOnDeath() return false end
function modifier_sven_gods_strength_custom_proc_cd:IsDebuff() return true end
function modifier_sven_gods_strength_custom_proc_cd:GetTexture() return "buffs/god_proc" end
function modifier_sven_gods_strength_custom_proc_cd:OnCreated(table)
self.RemoveForDuel = true 
end





modifier_sven_gods_strength_custom_legendary_stack = class({})
function modifier_sven_gods_strength_custom_legendary_stack:IsHidden() return true end
function modifier_sven_gods_strength_custom_legendary_stack:IsPurgable() return false end
function modifier_sven_gods_strength_custom_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.parent:GetTalentValue("modifier_sven_god_7", "max", true)
self.range = self.parent:GetTalentValue("modifier_sven_god_7", "range", true)
self.duration = self.parent:GetTalentValue("modifier_sven_god_7", "duration", true)


if not IsServer() then return end
self.visual_max = 6
self.particle = self.parent:GenericParticle("particles/sven_rage.vpcf", self, true)

self:SetStackCount(1)
self:StartIntervalThink(0.2)
end

function modifier_sven_gods_strength_custom_legendary_stack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_sven_gods_strength_custom_legendary_stack:GetModifierModelScale()
if self:GetStackCount() < self.max then return end
return 20
end

function modifier_sven_gods_strength_custom_legendary_stack:OnIntervalThink()
if not IsServer() then return end
local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #targets > 0 then
	self:SetDuration(self.duration, true)
end

end

function modifier_sven_gods_strength_custom_legendary_stack:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then

	self.parent:EmitSound("Sven.God_legendary_active")
	self.effect_cast = ParticleManager:CreateParticle( "particles/mars_shield_legendary.vpcf", PATTACH_CUSTOMORIGIN, self.parent )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_shield", self.parent:GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon", self.parent:GetAbsOrigin(), true )
	self:AddParticle(self.effect_cast,false, false, -1, false, false)
end

end


function modifier_sven_gods_strength_custom_legendary_stack:OnStackCountChanged()
if not IsServer() then return end

self.ability:LegendaryUI()
if not self.particle then return end

for i = 1,self.visual_max do 
	if i <= math.floor(self:GetStackCount()/(self.max/self.visual_max)) then 
		ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))	
	else 
		ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
	end
end

end

function modifier_sven_gods_strength_custom_legendary_stack:OnDestroy()
if not IsServer() then return end
self.ability:LegendaryUI()
end