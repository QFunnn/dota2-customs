--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sandking_epicenter_custom", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_slow", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_tracker", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_legendary", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_auto_cd", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_heal_reduce", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_heal", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_absorb", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_absorb_cd", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_speed", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_epicenter_custom_shard_count", "abilities/sand_king/sandking_epicenter_custom", LUA_MODIFIER_MOTION_NONE)

sandking_epicenter_custom = class({})
		


function sandking_epicenter_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_epicenter_tell.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", context )
PrecacheResource( "particle","particles/sand_king/epicenter_legendary.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_valkyrie_fire_wreath_magic_immunity.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/vindicators_axe_armor.vpcf", context )
PrecacheResource( "particle","particles/sand_king/linken_active.vpcf", context )
PrecacheResource( "particle","particles/sand_king/linken_activea.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
end



function sandking_epicenter_custom:GetIntrinsicModifierName()
if self:GetCaster():IsRealHero() then 
	return "modifier_sandking_epicenter_custom_tracker"
end 

end

function sandking_epicenter_custom:GetCastPoint()
local bonus = 0
if self:GetCaster():HasShard() then 
  bonus = self:GetSpecialValueFor("shard_cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end


function sandking_epicenter_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sand_king_epicenter_2") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_2", "cd")
end 
return self.BaseClass.GetCooldown(self, level)  + bonus
end



function sandking_epicenter_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()
caster:EmitSound("Ability.SandKing_Epicenter.spell")

local k = 2 / self:GetSpecialValueFor("AbilityCastPoint")

if caster:HasShard() then 
	k = 2 / (self:GetSpecialValueFor("AbilityCastPoint") + self:GetSpecialValueFor("shard_cast"))
end 

caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, k)

self.particle_sandblast_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter_tell.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControlEnt(self.particle_sandblast_fx, 0, caster, PATTACH_POINT_FOLLOW, "attach_tail", caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle_sandblast_fx, 1, caster, PATTACH_POINT_FOLLOW, "attach_tail", caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle_sandblast_fx, 2, caster, PATTACH_POINT_FOLLOW, "attach_tail", caster:GetAbsOrigin(), true)

if caster:HasTalent("modifier_sand_king_epicenter_5") and not caster:HasModifier("modifier_sandking_epicenter_custom_absorb_cd") then 	
	caster:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_absorb", {})
end 

end 


function sandking_epicenter_custom:OnAbilityPhaseInterrupted()
self:GetCaster():StopSound("Ability.SandKing_Epicenter.spell")

local caster = self:GetCaster()

caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
if self.particle_sandblast_fx then 
	ParticleManager:DestroyParticle(self.particle_sandblast_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)
end 

if caster:HasTalent("modifier_sand_king_epicenter_5") and not caster:HasModifier("modifier_sandking_epicenter_custom_absorb_cd") then 
	caster:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_absorb_cd", {duration = caster:GetTalentValue("modifier_sand_king_epicenter_5", "cd")})
	caster:RemoveModifierByName("modifier_sandking_epicenter_custom_absorb")
end 

end 


function sandking_epicenter_custom:OnSpellStart()
local caster = self:GetCaster()
if caster:HasShard() then 
	caster:StopSound("Ability.SandKing_Epicenter.spell")
end 

local caster = caster
caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)

local mod = caster:FindModifierByName("modifier_sandking_epicenter_custom_absorb")

if mod then 
	mod:SetDuration(self:GetSpecialValueFor("AbilityDuration"), true)
end 

if caster:HasTalent("modifier_sand_king_epicenter_3") then 
	caster:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_heal", {duration = caster:GetTalentValue("modifier_sand_king_epicenter_3", "duration")})
end 

caster:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom", {})

if self.particle_sandblast_fx then 
	ParticleManager:DestroyParticle(self.particle_sandblast_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)
end 

caster:EmitSound("Ability.SandKing_SandStorm.start")
end 




function sandking_epicenter_custom:Pulse(pulse_loc, radius, main_skill, is_legendary)
if self:GetLevel() < 1 then return end

local caster = self:GetCaster()
local damage_ability = nil
if is_legendary then 
	damage_ability = "modifier_sand_king_epicenter_7"
end

self.particle_epicenter_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle_epicenter_fx, 0, GetGroundPosition(pulse_loc, nil))
ParticleManager:SetParticleControl(self.particle_epicenter_fx, 1, Vector(radius, radius, 1))
ParticleManager:ReleaseParticleIndex(self.particle_epicenter_fx)

local damage = self:GetSpecialValueFor("epicenter_damage")
local duration = self:GetSpecialValueFor("slow_duration")

if not main_skill then 
	EmitSoundOnLocationWithCaster(pulse_loc, "SandKing.Pulse", caster)
end

local damage_duration = caster:GetTalentValue("modifier_sand_king_epicenter_1", "duration", true)
local damage_inc = caster:GetTalentValue("modifier_sand_king_epicenter_1", "damage")
local damage_max = caster:GetTalentValue("modifier_sand_king_epicenter_1", "max")

local targets = caster:FindTargets(radius, pulse_loc)

if #targets > 0 then 

	if is_legendary then 
		local cd = self:GetEffectiveCooldown(self:GetLevel())*caster:GetTalentValue("modifier_sand_king_epicenter_7", "cd_inc")/100
		caster:CdAbility(self, cd)
	end 
	if caster:HasTalent("modifier_sand_king_epicenter_6")  then 
		caster:CdItems(caster:GetTalentValue("modifier_sand_king_epicenter_6", "cd"))
		caster:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_speed", {duration = caster:GetTalentValue("modifier_sand_king_epicenter_6", "duration")})
	end 
end

local mod = caster:FindModifierByName("modifier_sandking_epicenter_custom")

local scepter_chance = self:GetSpecialValueFor("scepter_chance")

for _,target in pairs(targets) do 

	if caster:HasTalent("modifier_sand_king_epicenter_1") or caster:HasTalent("modifier_sand_king_epicenter_4") then 
		target:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_heal_reduce", {duration = damage_duration})
	end 

	if caster:HasShard() and main_skill then 
		target:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_shard_count", {duration = self:GetSpecialValueFor("AbilityDuration") + 0.1})
	end 

	local real_damage = damage
	local mod = target:FindModifierByName("modifier_sandking_epicenter_custom_heal_reduce")

	if mod then 
		real_damage = real_damage + math.min(mod:GetStackCount(), damage_max)*damage_inc
	end 

	DoDamage({victim = target, attacker = caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL, damage = real_damage}, damage_ability)

	target:AddNewModifier(caster, self, "modifier_sandking_epicenter_custom_slow", {duration = (1 - target:GetStatusResistance())*duration})
end 

end 



modifier_sandking_epicenter_custom = class({})
function modifier_sandking_epicenter_custom:IsHidden() return false end
function modifier_sandking_epicenter_custom:IsPurgable() return false end
function modifier_sandking_epicenter_custom:RemoveOnDeath() return false end

function modifier_sandking_epicenter_custom:OnCreated(table)

self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()


self.duration = self.ability:GetSpecialValueFor("AbilityDuration")
self.pulses = self.ability:GetSpecialValueFor("epicenter_pulses") + self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_4", "max")
self.radius_init = self.ability:GetSpecialValueFor("epicenter_radius_base")
self.radius_inc = self.ability:GetSpecialValueFor("epicenter_radius_increment")
self.interval = self.duration/self.pulses
if not IsServer() then return end

if self.caster:HasScepter() then 
	local stinger = self.caster:FindAbilityByName("sandking_scorpion_strike_custom")
	if stinger and stinger:IsTrained() then 
		stinger:EndCd(0)
	end
end


if self.parent:HasShard() then 
	self.radius_inc = self.radius_inc + self.ability:GetSpecialValueFor("shard_radius")
end 

self.legendary = self.caster:FindAbilityByName("sandking_epicenter_custom_legendary")

if self.legendary then 
	self.legendary:SetActivated(false)
end 

self.parent:EmitSound("Ability.SandKing_Epicenter")
self.parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
self:StartIntervalThink(self.interval)
end 


function modifier_sandking_epicenter_custom:OnDestroy()
if not IsServer() then return end

if self.legendary then 
	self.legendary:SetActivated(true)
end 

self.parent:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
self.parent:StopSound("Ability.SandKing_Epicenter")
end 


function modifier_sandking_epicenter_custom:OnIntervalThink()
if not IsServer() then return end 

self.ability:Pulse(self.parent:GetAbsOrigin(), self.radius_init + self.radius_inc*self:GetStackCount(), true, false)

self:IncrementStackCount()

if self:GetStackCount() >= self.pulses then 
	self:Destroy()
	return
end 

end 




modifier_sandking_epicenter_custom_slow = class({})
function modifier_sandking_epicenter_custom_slow:IsHidden() return false end
function modifier_sandking_epicenter_custom_slow:IsPurgable() return true end
function modifier_sandking_epicenter_custom_slow:OnCreated()

self.slow_move = self:GetAbility():GetSpecialValueFor("epicenter_slow")
self.slow_attack = self:GetAbility():GetSpecialValueFor("epicenter_slow_as")
end 

function modifier_sandking_epicenter_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sandking_epicenter_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow_move
end


function modifier_sandking_epicenter_custom_slow:GetModifierAttackSpeedBonus_Constant()
return self.slow_attack
end




modifier_sandking_epicenter_custom_tracker = class({})
function modifier_sandking_epicenter_custom_tracker:IsHidden() return true end
function modifier_sandking_epicenter_custom_tracker:IsPurgable() return false end
function modifier_sandking_epicenter_custom_tracker:OnCreated()
self.parent = self:GetParent()
end 


function modifier_sandking_epicenter_custom_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
}
end


function modifier_sandking_epicenter_custom_tracker:GetModifierPercentageManacostStacking()
if not self.parent:HasTalent("modifier_sand_king_epicenter_2") then return end
return self.parent:GetTalentValue("modifier_sand_king_epicenter_2", "mana")
end






sandking_epicenter_custom_legendary = class({})

sandking_epicenter_custom_legendary.anim = ACT_DOTA_TELEPORT_END

function sandking_epicenter_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function sandking_epicenter_custom_legendary:GetCooldown(level)
return self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_7", "cd")
end

function sandking_epicenter_custom_legendary:OnAbilityPhaseStart()

self:GetCaster():StartGestureWithPlaybackRate(self.anim, 1.1)

self:GetCaster():EmitSound("SandKing.Epicenter_legendary_pre")
self:GetCaster():EmitSound("SandKing.Epicenter_legendary_pre2")
return true
end

function sandking_epicenter_custom_legendary:OnAbilityPhaseInterrupted()


self:GetCaster():StopSound("SandKing.Epicenter_legendary_pre")
self:GetCaster():StopSound("SandKing.Epicenter_legendary_pre2")

self:GetCaster():FadeGesture(self.anim)
end


function sandking_epicenter_custom_legendary:OnSpellStart()

self:GetCaster():FadeGesture(self.anim)

self:GetCaster():EmitSound("SandKing.Epicenter_legendary_start")

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sandking_epicenter_custom_legendary", {duration = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_7", "duration")})
end


modifier_sandking_epicenter_custom_legendary = class({})
function modifier_sandking_epicenter_custom_legendary:IsHidden() return false end
function modifier_sandking_epicenter_custom_legendary:IsPurgable() return false end

function modifier_sandking_epicenter_custom_legendary:GetEffectName() return "particles/sand_king/epicenter_legendary.vpcf" end
function modifier_sandking_epicenter_custom_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_valkyrie_fire_wreath_magic_immunity.vpcf" end
function modifier_sandking_epicenter_custom_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end

function modifier_sandking_epicenter_custom_legendary:OnCreated()

self.caster = self:GetCaster()
if not self.caster:HasTalent("modifier_sand_king_epicenter_7") then
	self:Destroy()
	return
end 

self.moving = false
self.status = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_7", "status")
self.pos = self.caster:GetAbsOrigin()
self.max_distance = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_7", "distance")
self.distance = 0

self.ability = self.caster:FindAbilityByName("sandking_epicenter_custom")

if not self.ability then self:Destroy() return end

self.radius = self:GetAbility():GetSpecialValueFor("radius")

if not IsServer() then return end 

self.ability:SetActivated(false)

self.caster:EmitSound("SandKing.Epicenter_legendary_loop")

self.particle_epicenter_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle_epicenter_fx, 0, self.caster:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle_epicenter_fx, 1, Vector(150, 150, 1))
ParticleManager:ReleaseParticleIndex(self.particle_epicenter_fx)

self:OnIntervalThink()
self:StartIntervalThink(0.03)
end 


function modifier_sandking_epicenter_custom_legendary:OnIntervalThink()
if not IsServer() then return end 

local pos = self.caster:GetAbsOrigin()

self.distance = self.distance + (pos - self.pos):Length2D()
if self.distance >= self.max_distance then 
	self.distance = 0
	EmitSoundOnLocationWithCaster(self.caster:GetAbsOrigin(), "SandKing.Epicenter_legendary_pulse", self.caster)
	self.ability:Pulse(self.caster:GetAbsOrigin(), self.radius, false, true)
end 

self.pos = pos

if not self.moving and self:GetCaster():IsMoving() then 
	self.moving = true
	self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
end 


if self.moving and not self:GetCaster():IsMoving() then 
	self.moving = false
	self:GetCaster():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
end 


end 


function modifier_sandking_epicenter_custom_legendary:OnDestroy()
if not IsServer() then return end 

self.ability:SetActivated(true)
self.caster:StopSound("SandKing.Epicenter_legendary_loop")
self:GetCaster():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
end 


function modifier_sandking_epicenter_custom_legendary:DeclareFunctions()
return
{
	--MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end


function modifier_sandking_epicenter_custom_legendary:GetModifierStatusResistanceStacking()
--return self.status
end

function modifier_sandking_epicenter_custom_legendary:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end


modifier_sandking_epicenter_custom_auto_cd = class({})
function modifier_sandking_epicenter_custom_auto_cd:IsHidden() return false end
function modifier_sandking_epicenter_custom_auto_cd:IsPurgable() return false end
function modifier_sandking_epicenter_custom_auto_cd:RemoveOnDeath() return false end
function modifier_sandking_epicenter_custom_auto_cd:IsDebuff() return true end
function modifier_sandking_epicenter_custom_auto_cd:GetTexture() return "buffs/epicenter_auto" end







modifier_sandking_epicenter_custom_heal_reduce = class({})
function modifier_sandking_epicenter_custom_heal_reduce:IsHidden() return false end
function modifier_sandking_epicenter_custom_heal_reduce:IsPurgable() return false end
function modifier_sandking_epicenter_custom_heal_reduce:GetTexture() return "buffs/epicenter_damage" end
function modifier_sandking_epicenter_custom_heal_reduce:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.heal_reduce = self.caster:GetTalentValue("modifier_sand_king_epicenter_1", "heal_reduce")
self.damage_max = self.caster:GetTalentValue("modifier_sand_king_epicenter_1", "max")

self.resist_max = self.caster:GetTalentValue("modifier_sand_king_epicenter_4", "stack")
self.resist = self.caster:GetTalentValue("modifier_sand_king_epicenter_4", "resist")

self.max = self.damage_max
if self.caster:HasTalent("modifier_sand_king_epicenter_4") then 
	self.max = self.resist_max
end

if not IsServer() then return end 
self:SetStackCount(1)
end 


function modifier_sandking_epicenter_custom_heal_reduce:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end 


function modifier_sandking_epicenter_custom_heal_reduce:DeclareFunctions()
return
{
 	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
 	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_sandking_epicenter_custom_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_sandking_epicenter_custom_heal_reduce:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_sandking_epicenter_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_sandking_epicenter_custom_heal_reduce:GetModifierMagicalResistanceBonus()
return self.resist*self:GetStackCount()
end




modifier_sandking_epicenter_custom_heal = class({})
function modifier_sandking_epicenter_custom_heal:IsHidden() return true end
function modifier_sandking_epicenter_custom_heal:IsPurgable() return false end
function modifier_sandking_epicenter_custom_heal:GetTexture() return "buffs/epicenter_heal" end
function modifier_sandking_epicenter_custom_heal:OnCreated()

self.parent = self:GetParent()
if self.parent:IsRealHero() then 
	self.parent:AddDamageEvent_out(self)
end

self.shield_talent = "modifier_sand_king_epicenter_3"
self.heal = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_3", "heal")/100
self.heal_creeps = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_3", "heal_creeps")
self.max_shield = self:GetCaster():GetMaxHealth()*self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_3", "shield")/100
self:SetStackCount(self.max_shield)

end 

function modifier_sandking_epicenter_custom_heal:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end


function modifier_sandking_epicenter_custom_heal:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return 0 end

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
     	return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end


function modifier_sandking_epicenter_custom_heal:DamageEvent_out(params)
if not IsServer() then return end
if self:GetParent() ~= params.attacker then return end
if not params.unit:IsCreep() and not params.unit:IsRealHero() then return end
if self:GetParent() == params.unit then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end

local heal = self.heal
if params.unit:IsCreep() then 
  heal = heal / self.heal_creeps
end

heal = heal*params.damage

self:GetParent():GenericHeal(heal, self:GetAbility(), true, nil)

end





modifier_sandking_epicenter_custom_absorb = class({})
function modifier_sandking_epicenter_custom_absorb:IsHidden() return true end
function modifier_sandking_epicenter_custom_absorb:IsPurgable() return false end
function modifier_sandking_epicenter_custom_absorb:OnCreated(table)

self.damage = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_5", "damage")

if not IsServer() then return end


self.effect = ParticleManager:CreateParticle( "particles/items2_fx/vindicators_axe_armor.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
self:AddParticle(self.effect,false, false, -1, false, false)

self.particle = ParticleManager:CreateParticle("particles/sand_king/linken_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControlEnt(self.particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, false, false)

self.blocked = false
end



function modifier_sandking_epicenter_custom_absorb:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSORB_SPELL,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_sandking_epicenter_custom_absorb:GetModifierIncomingDamage_Percentage()
return self.damage
end 


function modifier_sandking_epicenter_custom_absorb:GetAbsorbSpell(params) 
if params.ability:GetCaster():GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
if self.blocked == true then return end 

self.blocked = true

local particle = ParticleManager:CreateParticle("particles/sand_king/linken_activea.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, true)
	ParticleManager:ReleaseParticleIndex(self.particle)
end 

self:GetCaster():EmitSound("DOTA_Item.LinkensSphere.Activate")

--self:Destroy()

return 1 
end




modifier_sandking_epicenter_custom_absorb_cd = class({})
function modifier_sandking_epicenter_custom_absorb_cd:IsHidden() return false end
function modifier_sandking_epicenter_custom_absorb_cd:IsPurgable() return false end
function modifier_sandking_epicenter_custom_absorb_cd:RemoveOnDeath() return false end
function modifier_sandking_epicenter_custom_absorb_cd:IsDebuff() return true end
function modifier_sandking_epicenter_custom_absorb_cd:GetTexture() return "buffs/epicenter_linken" end




modifier_sandking_epicenter_custom_speed = class({})
function modifier_sandking_epicenter_custom_speed:IsHidden() return false end
function modifier_sandking_epicenter_custom_speed:IsPurgable() return false end
function modifier_sandking_epicenter_custom_speed:GetTexture() return "buffs/epicenter_speed" end
function modifier_sandking_epicenter_custom_speed:OnCreated()

self.max = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_6", "max")
self.speed = self:GetCaster():GetTalentValue("modifier_sand_king_epicenter_6", "speed")
if not IsServer() then return end 

self:SetStackCount(1)
end 

function modifier_sandking_epicenter_custom_speed:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(self.particle, false, false, -1, false, false)
end 

end

function modifier_sandking_epicenter_custom_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sandking_epicenter_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.speed*self:GetStackCount()
end




modifier_sandking_epicenter_custom_shard_count = class({})
function modifier_sandking_epicenter_custom_shard_count:IsHidden() return true end
function modifier_sandking_epicenter_custom_shard_count:IsPurgable() return false end
function modifier_sandking_epicenter_custom_shard_count:OnCreated()
self.max = self:GetAbility():GetSpecialValueFor("shard_break_count")
self.duration =  self:GetAbility():GetSpecialValueFor("shard_break")

self.proced = false
self:SetStackCount(1)
end 

function modifier_sandking_epicenter_custom_shard_count:OnRefresh()
if not IsServer() then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max and self.proced == false then 
	self.proced = true
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_break", {duration = (1 - self:GetParent():GetStatusResistance())*self.duration})
end 

end 