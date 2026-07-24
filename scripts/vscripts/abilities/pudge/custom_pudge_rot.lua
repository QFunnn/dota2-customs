--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_pudge_rot","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_slow","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_tracker","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_legendary_aura","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_legendary_aura_buff","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_poison","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_poison_cd","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_rot_shield","abilities/pudge/custom_pudge_rot", LUA_MODIFIER_MOTION_NONE)

custom_pudge_rot = class({})

function custom_pudge_rot:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "pudge_rot", self)
end


function custom_pudge_rot:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/pudge_rot.vpcf", context )
PrecacheResource( "particle","particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot.vpcf", context )
PrecacheResource( "particle","particles/pudge_legendary.vpcf", context )
PrecacheResource( "particle","particles/pudge_rot.vpcf", context )
PrecacheResource( "particle","particles/pudge_poison.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_drow/rot_silence_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_centaur/centaur_shard_buff_strength_counter_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_enigma/pudge_pull.vpcf", context )
PrecacheResource( "particle","particles/pudge_rot.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/muerta/resist_stackb.vpcf", context )
PrecacheResource( "particle","particles/pudge/rot_shield.vpcf", context )

end

function custom_pudge_rot:ResetToggleOnRespawn() return true end


function custom_pudge_rot:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_pudge_rot_tracker"
end


function custom_pudge_rot:GetCastRange()
local caster = self:GetCaster()
local bonus = 0
if caster:HasScepter() then
	bonus = self:GetSpecialValueFor("scepter_rot_radius_bonus")
end
if caster:HasTalent("modifier_pudge_rot_1") then
	bonus = bonus + caster:GetTalentValue("modifier_pudge_rot_1", "radius")
end
return self:GetSpecialValueFor("rot_radius") + bonus - caster:GetCastRangeBonus()
end


function custom_pudge_rot:OnToggle()
local caster = self:GetCaster()

if self:GetToggleState() then
    caster:AddNewModifier( caster, self, "modifier_custom_pudge_rot", {} )
else
    caster:RemoveModifierByName("modifier_custom_pudge_rot")
end

end



modifier_custom_pudge_rot = class({})
function modifier_custom_pudge_rot:IsPurgable() return false end
function modifier_custom_pudge_rot:IsHidden() return false end


function modifier_custom_pudge_rot:CreateEffect(name)
if not IsServer() then return end
local rot_particle = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/pudge_rot.vpcf", self)
if name then
	rot_particle = name
end
if self.pfx then
	ParticleManager:DestroyParticle(self.pfx, true)
	ParticleManager:ReleaseParticleIndex(self.pfx)
	self.pfx = nil
end
self.pfx = ParticleManager:CreateParticle(rot_particle, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.rot_radius, 1, self.rot_radius))
self:AddParticle(self.pfx, false, false, -1, false, false)	
end


function modifier_custom_pudge_rot:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.rot_radius = self.ability:GetSpecialValueFor("rot_radius") + self.parent:GetTalentValue("modifier_pudge_rot_1", "radius")
self.rot_tick = self.ability:GetSpecialValueFor("rot_tick")
self.rot_damage = self.ability:GetSpecialValueFor("rot_damage")
self.last_rot_time = 0
self.normal_particle = true

if self.parent:HasScepter() then
	self.rot_radius = self.rot_radius + self.ability:GetSpecialValueFor("scepter_rot_radius_bonus")
	self.rot_damage = self.rot_damage + self.ability:GetSpecialValueFor("scepter_rot_damage_bonus")
end
self.legendary_max = self.parent:GetTalentValue("modifier_pudge_rot_legendary", "max", true)
self.legendary_damage = self.parent:GetTalentValue("modifier_pudge_rot_legendary", "damage_inc", true)/100

self.damage_bonus = self.parent:GetTalentValue("modifier_pudge_rot_2", "damage")/100 + 1
self.self_bonus = self.parent:GetTalentValue("modifier_pudge_rot_2", "self_damage")/100 + 1 

self.stack_max = self.parent:GetTalentValue("modifier_pudge_rot_3", "max", true)
self.move_bonus = self.parent:GetTalentValue("modifier_pudge_rot_3", "move")/self.stack_max
self.armor_bonus = self.parent:GetTalentValue("modifier_pudge_rot_3", "armor")/self.stack_max

self.mana_burn = (self.parent:GetTalentValue("modifier_pudge_rot_5", "mana")/100)*self.rot_tick

self.shield_duration = self.parent:GetTalentValue("modifier_pudge_rot_6", "duration", true)
self.shield_max = self.parent:GetTalentValue("modifier_pudge_rot_6", "max", true)

if not IsServer() then return end

self.rot_sound = wearables_system:GetSoundReplacement(self:GetCaster(), "Hero_Pudge.Rot", self)
self.parent:EmitSound(self.rot_sound)

if not self.parent:IsStunned() then
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_ROT)
end

self.legendary_count = 0
self.legendary_stack = 0

self.shield_count = 0

self.stack_count = 0

if self.parent:HasTalent("modifier_pudge_rot_legendary") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_pudge_rot_legendary_aura", {})
	self.count_effect = self.parent:GenericParticle("particles/units/heroes/hero_centaur/centaur_shard_buff_strength_counter_stack.vpcf", self, true)
	ParticleManager:SetParticleControlEnt(self.count_effect, 3, self.parent, PATTACH_OVERHEAD_FOLLOW, nil , self.parent:GetAbsOrigin(), true )
end

self:CreateEffect()
self:StartIntervalThink(self.rot_tick)
end


function modifier_custom_pudge_rot:OnIntervalThink()
if not IsServer() then return end

local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.rot_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)

local damage = self.rot_damage*self.rot_tick

if self.legendary_stack > 0 then
	damage = damage + self.legendary_stack*self.parent:GetMaxHealth()*self.legendary_damage*self.rot_tick
end

local self_damage = damage*self.self_bonus
local target_damage = damage*self.damage_bonus

if self_damage ~= 0 then 
	DoDamage({ victim = self.parent, attacker = self.parent, damage = self_damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL, ability = self.ability })
end

local hit_target = false

for _, enemy in pairs(units) do
	if not enemy:IsOutOfGame() or enemy:HasModifier("modifier_custom_pudge_dismember_devour") then 
		if self.parent:HasTalent("modifier_pudge_rot_5") then 
			enemy:Script_ReduceMana(enemy:GetMaxMana()*self.mana_burn, self.ability) 
		end 
		hit_target = true
		DoDamage({ victim = enemy, attacker = self.parent, damage = target_damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self.ability })
	end
end

self.stack_count = self.stack_count + self.rot_tick
if self.stack_count >= 0.99 then
	self.stack_count = 0
	if (self.parent:HasTalent("modifier_pudge_rot_3") or self.parent:HasTalent("modifier_pudge_rot_6")) and self:GetStackCount() < self.stack_max then
		self:IncrementStackCount()
	end

	if self.parent:HasTalent("modifier_pudge_rot_6") and not self.parent:HasModifier("modifier_custom_pudge_rot_shield") then
		self.shield_count = self.shield_count + 1
		if self.shield_count >= self.shield_max then
			self.shield_count = 0
			self.parent:EmitSound("Pudge.Rot_shield")
			self.parent:GenericParticle("particles/pudge/rot_shield.vpcf")
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_pudge_rot_shield", {duration = self.shield_duration})
		end
	end
end

if self.parent:HasTalent("modifier_pudge_rot_legendary") then
	local active = 0
	if self.legendary_stack >= self.legendary_max then
		active = 1
	end
	self.parent:UpdateUIshort({max_time = self.legendary_max, time = self.legendary_stack, stack = self.legendary_stack, active = active, style = "PudgeRot"})
	if hit_target == true and active == 0 then
		self.legendary_count = self.legendary_count + self.rot_tick
		if self.legendary_count >= 0.99 then
			self.legendary_count = 0
			self.legendary_stack = self.legendary_stack + 1
			if self.count_effect then
				ParticleManager:SetParticleControl(self.count_effect, 2, Vector(self.legendary_stack, 0 , 0))
			end
			if self.legendary_stack >= self.legendary_max then
				self:CreateEffect("particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot.vpcf")
				self.parent:GenericParticle("particles/items4_fx/ascetic_cap.vpcf", self)
                if self.parent:GetModelName() == "models/heroes/pudge_cute/pudge_cute.vmdl" then
                    self.parent:StopSound("Hero_Pudge.Rot.Persona")
                end
				self.parent:StopSound(self.rot_sound)
				self.parent:EmitSound("Rot.Legendary_active")
				self.parent:EmitSound("Rot.Legendary_loop")

				local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
				ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
				ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(particle_peffect)

				local mod = self.parent:FindModifierByName("modifier_custom_pudge_rot_legendary_aura")
				if mod then
					mod:SetStackCount(1)
				end
			end
		end
	end
end

end

function modifier_custom_pudge_rot:OnDestroy()
if not IsServer() then return end

self.parent:RemoveModifierByName("modifier_custom_pudge_rot_legendary_aura")
self.parent:UpdateUIshort({hide = 1, style = "PudgeRot"})

self.parent:StopSound(self.rot_sound)
self.parent:StopSound("Rot.Legendary_loop")
end


function modifier_custom_pudge_rot:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,	
}
end

function modifier_custom_pudge_rot:GetModifierPhysicalArmorBonus()
if not self.parent:HasTalent("modifier_pudge_rot_3") then return end
return self:GetStackCount()*self.armor_bonus
end

function modifier_custom_pudge_rot:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_pudge_rot_3") then return end
return self:GetStackCount()*self.move_bonus
end

function modifier_custom_pudge_rot:IsAura()	return true  end
function modifier_custom_pudge_rot:IsAuraActiveOnDeath() return false end
function modifier_custom_pudge_rot:GetAuraRadius() return self.rot_radius end
function modifier_custom_pudge_rot:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_custom_pudge_rot:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_custom_pudge_rot:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_custom_pudge_rot:GetModifierAura() return "modifier_custom_pudge_rot_slow" end




modifier_custom_pudge_rot_legendary_aura = class({})
function modifier_custom_pudge_rot_legendary_aura:IsHidden() return true end
function modifier_custom_pudge_rot_legendary_aura:IsPurgable() return false end
function modifier_custom_pudge_rot_legendary_aura:OnCreated(table)
self.parent = self:GetParent()

self.legendary_status = self.parent:GetTalentValue("modifier_pudge_rot_legendary", "status", true)
self.legendary_pull_cd = self.parent:GetTalentValue("modifier_pudge_rot_legendary", "cd", true) - FrameTime()
self.legendary_radius = self.parent:GetTalentValue("modifier_pudge_rot_legendary", "radius", true)
self.legendary_knock_duration = self.parent:GetTalentValue("modifier_pudge_rot_legendary", "knock_duration", true)

if not IsServer() then return end
self:StartIntervalThink(self.legendary_pull_cd)
end

function modifier_custom_pudge_rot_legendary_aura:OnIntervalThink()
if not IsServer() then return end

for _,unit in pairs(self.parent:FindTargets(self.legendary_radius)) do 
	if not unit:IsCreep() then
		self.parent:PullTarget(unit, self.ability, self.legendary_knock_duration)
		unit:EmitSound("Pudge.Rot_legendary_pull")
	end
end 

end

function modifier_custom_pudge_rot_legendary_aura:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_custom_pudge_rot_legendary_aura:GetModifierStatusResistanceStacking()
if self:GetStackCount() == 0 then return end
return self.legendary_status
end

function modifier_custom_pudge_rot_legendary_aura:IsAura()	return true  end
function modifier_custom_pudge_rot_legendary_aura:GetAuraRadius() return self.legendary_radius end
function modifier_custom_pudge_rot_legendary_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO end
function modifier_custom_pudge_rot_legendary_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_custom_pudge_rot_legendary_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_custom_pudge_rot_legendary_aura:GetModifierAura() return "modifier_custom_pudge_rot_legendary_aura_buff" end



modifier_custom_pudge_rot_legendary_aura_buff = class({})
function modifier_custom_pudge_rot_legendary_aura_buff:IsHidden() return true end
function modifier_custom_pudge_rot_legendary_aura_buff:IsPurgable() return false end
function modifier_custom_pudge_rot_legendary_aura_buff:OnCreated(table)
if not IsServer() then return end
self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_enigma/pudge_pull.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControlEnt(self.pfx, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
self:AddParticle(self.pfx, false, false, -1, false, false)	
end




modifier_custom_pudge_rot_slow = class({})
function modifier_custom_pudge_rot_slow:IsHidden() return false end
function modifier_custom_pudge_rot_slow:IsPurgable() return false end
function modifier_custom_pudge_rot_slow:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_pudge_rot_slow:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_reduce = 0
if self.caster:HasScepter() then
	self.heal_reduce = self.ability:GetSpecialValueFor("scepter_healing_reduction")
end

self.spell_reduce = self.caster:GetTalentValue("modifier_pudge_rot_6", "spell")

self.slow = self.ability:GetSpecialValueFor("rot_slow") + self.caster:GetTalentValue("modifier_pudge_rot_1", "slow")

self.resist_duration = self.caster:GetTalentValue("modifier_pudge_rot_4", "duration", true)
self.resist_interval = self.caster:GetTalentValue("modifier_pudge_rot_4", "timer", true)

self.silence_duration = self.caster:GetTalentValue("modifier_pudge_rot_5", "silence", true)

if not IsServer() then return end
if not self.caster:HasTalent("modifier_pudge_rot_4") and not self.caster:HasTalent("modifier_pudge_rot_5") then return end
self.interval = 0.5
self.count = 0
self:StartIntervalThink(self.interval)
end

function modifier_custom_pudge_rot_slow:OnIntervalThink()
if not IsServer() then return end
if self.parent:HasModifier("modifier_custom_pudge_rot_poison_cd") then return end

self.count = self.count + self.interval

if self.count < 0.99 then return end
self.count = 0
self:IncrementStackCount()

if self:GetStackCount() < self.resist_interval then return end
self:SetStackCount(0)

self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_pudge_rot_poison_cd", {duration = self.resist_duration})

if self.caster:HasTalent("modifier_pudge_rot_4") then
	self.parent:GenericParticle("particles/pudge_poison.vpcf")
	self.parent:EmitSound("Pudge.Rot_poison")
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_pudge_rot_poison", {duration = self.resist_duration})
end

if self.caster:HasTalent("modifier_pudge_rot_5") then
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_generic_silence", {duration = (1 - self.parent:GetStatusResistance())*self.silence_duration})
	self.parent:EmitSound("Pudge.Rot_Silence")
end

end

function modifier_custom_pudge_rot_slow:GetModifierSpellAmplify_Percentage() 
if not self.caster:HasTalent("modifier_pudge_rot_6") then return end
return self.spell_reduce 
end

function modifier_custom_pudge_rot_slow:GetModifierLifestealRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_custom_pudge_rot_slow:GetModifierHealChange()
return self.heal_reduce
end

function modifier_custom_pudge_rot_slow:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_custom_pudge_rot_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


function modifier_custom_pudge_rot_slow:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self:GetStackCount() > 0 and not self.parent:HasModifier("modifier_custom_pudge_meat_hook_stack") then
	if not self.particle then
		self.particle = self.parent:GenericParticle("particles/units/heroes/hero_drow/rot_silence_stack.vpcf", self, true)
	end

	ParticleManager:SetParticleControl( self.particle, 1, Vector( 0, self:GetStackCount(), 0 ) )
else
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, false)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
end

end


modifier_custom_pudge_rot_tracker = class({})
function modifier_custom_pudge_rot_tracker:IsHidden() return true end
function modifier_custom_pudge_rot_tracker:IsPurgable() return false end
function modifier_custom_pudge_rot_tracker:OnCreated()
self.parent = self:GetParent()

self.heal_creeps = self.parent:GetTalentValue("modifier_pudge_rot_4", "creeps", true)
self.parent:AddDamageEvent_out(self)
end

function modifier_custom_pudge_rot_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_pudge_rot_4") then return end
if not params.unit:HasModifier("modifier_custom_pudge_rot_poison") then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = self.parent:GetTalentValue("modifier_pudge_rot_4", "heal")*params.damage/100

if params.unit:IsCreep() then 
	heal = heal/self.heal_creeps
end

self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_pudge_rot_4")
end


modifier_custom_pudge_rot_poison = class({})
function modifier_custom_pudge_rot_poison:IsHidden() return false end
function modifier_custom_pudge_rot_poison:GetTexture() return "buffs/goo_ground" end
function modifier_custom_pudge_rot_poison:IsPurgable() return false end
function modifier_custom_pudge_rot_poison:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.magic = self.caster:GetTalentValue("modifier_pudge_rot_4", "magic")

if not IsServer() then return end

if not self.caster:HasTalent("modifier_pudge_rot_5") then
	self.parent:GenericParticle("particles/muerta/resist_stackb.vpcf", self, true)
end

self.pfx = ParticleManager:CreateParticle("particles/pudge_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.pfx, 1, Vector(150, 1, 150))
self:AddParticle(self.pfx, false, false, -1, false, false)	
end

function modifier_custom_pudge_rot_poison:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}

end 
function modifier_custom_pudge_rot_poison:GetModifierMagicalResistanceBonus()
return self.magic
end 



modifier_custom_pudge_rot_poison_cd = class({})
function modifier_custom_pudge_rot_poison_cd:IsHidden() return true end
function modifier_custom_pudge_rot_poison_cd:IsPurgable() return false end





modifier_custom_pudge_rot_shield = class({})
function modifier_custom_pudge_rot_shield:IsHidden() return true end
function modifier_custom_pudge_rot_shield:IsPurgable() return false end
function modifier_custom_pudge_rot_shield:OnCreated(table)
self.parent = self:GetParent()

self.shield_talent = "modifier_pudge_rot_6"
self.max_shield = self.parent:GetTalentValue("modifier_pudge_rot_6", "shield")*self.parent:GetMaxHealth()/100

if not IsServer() then return end
self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
end

function modifier_custom_pudge_rot_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_custom_pudge_rot_shield:GetModifierIncomingDamageConstant( params )

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
