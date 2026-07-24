--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_warpath_custom", "heroes/npc_dota_hero_bristleback_custom/bristleback_warpath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_warpath_custom_buff", "heroes/npc_dota_hero_bristleback_custom/bristleback_warpath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_warpath_custom_buff_count", "heroes/npc_dota_hero_bristleback_custom/bristleback_warpath_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_warpath_custom = class({})
bristleback_warpath_custom.modifier_bristleback_20 = {2,4}
bristleback_warpath_custom.modifier_bristleback_2 = {2,3,4}
bristleback_warpath_custom.modifier_bristleback_1 = 4

function bristleback_warpath_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_smash.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_warpath_dust.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_warpath.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_legion_commander_duel.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf", context )
end

function bristleback_warpath_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_bristleback_20") then
		return "bristleback_20"
	end
	return "bristleback_warpath"
end

function bristleback_warpath_custom:GetIntrinsicModifierName() return "modifier_bristleback_warpath_custom" end

modifier_bristleback_warpath_custom = class({})
function modifier_bristleback_warpath_custom:IsHidden() return true end
function modifier_bristleback_warpath_custom:IsPurgable() return false end

function modifier_bristleback_warpath_custom:IncStacks()
 	if not IsServer() then return end
	local max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    if self:GetCaster():HasModifier("modifier_bristleback_1") then
        max_stacks = max_stacks + self:GetAbility().modifier_bristleback_1
    end
	local duration = self:GetAbility():GetSpecialValueFor("stack_duration")
 	local mod = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_warpath_custom_buff", {duration = duration})
	if not mod then return end
	if mod:GetStackCount() < max_stacks then 
    	mod:IncrementStackCount() 
    	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_warpath_custom_buff_count", {duration = duration})
	else 
		for _,all_counts in ipairs(self:GetParent():FindAllModifiersByName("modifier_bristleback_warpath_custom_buff_count")) do 
			all_counts:Destroy()
			mod:IncrementStackCount() 
			self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_warpath_custom_buff_count", {duration = duration})
			break
		end
	end
end

modifier_bristleback_warpath_custom_buff = class({})
function modifier_bristleback_warpath_custom_buff:IsHidden() return false end
function modifier_bristleback_warpath_custom_buff:IsPurgable() return false end
function modifier_bristleback_warpath_custom_buff:GetEffectName() return "particles/units/heroes/hero_bristleback/bristleback_warpath_dust.vpcf" end

function modifier_bristleback_warpath_custom_buff:OnCreated()
  	self.ability  = self:GetAbility()
  	self.caster   = self:GetCaster()
  	self.parent   = self:GetParent()
  	self.damage_per_stack   = self.ability:GetSpecialValueFor("damage_per_stack")
  	self.move_speed_per_stack = self.ability:GetSpecialValueFor("move_speed_per_stack")
end

function modifier_bristleback_warpath_custom_buff:DeclareFunctions()
    return 
	{
    	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    	MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_bristleback_warpath_custom_buff:GetModifierPreAttack_BonusDamage()
	if self.parent:IsIllusion() then return end
	if self:GetParent():PassivesDisabled() then return end
	self.damage_per_stack = self.ability:GetSpecialValueFor("damage_per_stack") 
	return self.damage_per_stack * self:GetStackCount()
end

function modifier_bristleback_warpath_custom_buff:GetModifierBonusStats_Strength()
    if self:GetCaster():HasModifier("modifier_bristleback_2") then
        return self:GetAbility().modifier_bristleback_2[self:GetCaster():GetTalentLevel("modifier_bristleback_2")] * self:GetStackCount()
    end
    return 0
end

function modifier_bristleback_warpath_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	if self:GetParent():PassivesDisabled() then return end
  	return self:GetAbility():GetSpecialValueFor("move_speed_per_stack") * self:GetStackCount()
end

function modifier_bristleback_warpath_custom_buff:GetModifierModelScale()
  	return self:GetStackCount() * 3
end

function modifier_bristleback_warpath_custom_buff:GetModifierSpellAmplify_Percentage()
	if self:GetCaster():HasModifier("modifier_bristleback_20") then
  		return self:GetAbility().modifier_bristleback_20[self:GetCaster():GetTalentLevel("modifier_bristleback_20")] * self:GetStackCount()
	end
	return 0
end

modifier_bristleback_warpath_custom_buff_count = class({})
function modifier_bristleback_warpath_custom_buff_count:IsHidden() return true end
function modifier_bristleback_warpath_custom_buff_count:IsPurgable() return false end
function modifier_bristleback_warpath_custom_buff_count:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bristleback_warpath_custom_buff_count:GetEffectName() return "particles/units/heroes/hero_bristleback/bristleback_warpath_dust.vpcf" end

function modifier_bristleback_warpath_custom_buff_count:OnCreated(table)
	if not IsServer() then return end
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_warpath.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.particle, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.particle, 4, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetAbsOrigin(), true)
	self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_bristleback_warpath_custom_buff_count:OnDestroy()
	if not IsServer() then return end
	local mod = self:GetParent():FindModifierByName("modifier_bristleback_warpath_custom_buff")
	if mod then 
  		mod:DecrementStackCount()
	end
end