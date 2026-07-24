--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


necrolyte_sadist_custom = class({})

LinkLuaModifier("modifier_ghost_shroud_custom_active", "heroes/hero_necrolyte/necrolyte_sadist_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ghost_shroud_custom_aura", "heroes/hero_necrolyte/necrolyte_sadist_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ghost_shroud_custom_aura_debuff", "heroes/hero_necrolyte/necrolyte_sadist_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ghost_shroud_custom_buff", "heroes/hero_necrolyte/necrolyte_sadist_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ghost_shroud_custom_debuff", "heroes/hero_necrolyte/necrolyte_sadist_custom", LUA_MODIFIER_MOTION_NONE)

function necrolyte_sadist_custom:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level)
end

function necrolyte_sadist_custom:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local duration = self:GetSpecialValueFor("duration")
		local radius = self:GetSpecialValueFor("slow_aoe")
		local healing_amp_pct = self:GetSpecialValueFor("heal_bonus")
		local slow_pct = self:GetSpecialValueFor("movement_speed")
		caster:EmitSound("Hero_Necrolyte.SpiritForm.Cast")
		caster:StartGesture(ACT_DOTA_NECRO_GHOST_SHROUD)
		caster:AddNewModifier(caster, self, "modifier_ghost_shroud_custom_active", { duration = duration })
		caster:AddNewModifier(caster, self, "modifier_ghost_shroud_custom_aura", { duration = duration, radius = radius, healing_amp_pct = healing_amp_pct, slow_pct = slow_pct})
		caster:AddNewModifier(caster, self, "modifier_ghost_shroud_custom_aura_debuff", { duration = duration, radius = radius, healing_amp_pct = healing_amp_pct, slow_pct = slow_pct})
	end
end

modifier_ghost_shroud_custom_active = class({})

function modifier_ghost_shroud_custom_active:IsHidden() return false end
function modifier_ghost_shroud_custom_active:IsPurgable() return true end

function modifier_ghost_shroud_custom_active:GetEffectName()
	return "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf"
end

function modifier_ghost_shroud_custom_active:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

function modifier_ghost_shroud_custom_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION
	}
end

function modifier_ghost_shroud_custom_active:GetModifierMagicalResistanceDirectModification( params )
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_ghost_shroud_custom_active:GetAbsoluteNoDamagePhysical()
	if self:GetCaster() == self:GetParent() then return 1
	else return nil end
end

function modifier_ghost_shroud_custom_active:GetModifierMPRegenAmplify_Percentage()
	return self.healing_amp_pct
end

function modifier_ghost_shroud_custom_active:GetModifierMPRestoreAmplify_Percentage()
	return self.healing_amp_pct
end

function modifier_ghost_shroud_custom_active:CheckState()
	return
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
	}
end

function modifier_ghost_shroud_custom_active:OnCreated()
	self.healing_amp_pct	= self:GetAbility():GetSpecialValueFor("heal_bonus")
end

modifier_ghost_shroud_custom_aura = class({})

function modifier_ghost_shroud_custom_aura:IsHidden() return false end
function modifier_ghost_shroud_custom_aura:IsPurgable() return false end
function modifier_ghost_shroud_custom_aura:IsAura() return true end

function modifier_ghost_shroud_custom_aura:OnCreated( params )
	if IsServer() then
		self.radius = params.radius
		self.healing_amp_pct = params.healing_amp_pct
		self.slow_pct = params.slow_pct
	end
end

function modifier_ghost_shroud_custom_aura:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_spirit.vpcf"
end

function modifier_ghost_shroud_custom_aura:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_ghost_shroud_custom_aura:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

function modifier_ghost_shroud_custom_aura:GetAuraEntityReject(target)
	if IsServer() then
		return false
	end
end

function modifier_ghost_shroud_custom_aura:GetAuraRadius()
	return self.radius
end

function modifier_ghost_shroud_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_ghost_shroud_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_ghost_shroud_custom_aura:GetAuraSearchType()
	return self:GetAbility():GetAbilityTargetType()
end

function modifier_ghost_shroud_custom_aura:GetModifierAura()
	return "modifier_ghost_shroud_custom_buff"
end

modifier_ghost_shroud_custom_buff = class({})

function modifier_ghost_shroud_custom_buff:IsHidden()
	if self:GetParent() == self:GetCaster() then return true end
	return false
end
function modifier_ghost_shroud_custom_buff:IsDebuff()	return false end

function modifier_ghost_shroud_custom_buff:OnCreated()
	self.healing_amp_pct = self:GetAbility():GetSpecialValueFor("heal_bonus")
	
	if self:GetCaster() ~= self:GetParent() then
		self.healing_amp_pct = self.healing_amp_pct * 0.5
	end
end

function modifier_ghost_shroud_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_ghost_shroud_custom_buff:GetModifierHealAmplify_PercentageTarget()
	return self.healing_amp_pct
end

function modifier_ghost_shroud_custom_buff:GetModifierHPRegenAmplify_Percentage()
	return self.healing_amp_pct
end

modifier_ghost_shroud_custom_aura_debuff = class({})

function modifier_ghost_shroud_custom_aura_debuff:IsHidden() return true end
function modifier_ghost_shroud_custom_aura_debuff:IsPurgable() return false end
function modifier_ghost_shroud_custom_aura_debuff:IsAura() return true end

function modifier_ghost_shroud_custom_aura_debuff:OnCreated( params )
	if IsServer() then
		self.radius = params.radius
	end
end

function modifier_ghost_shroud_custom_aura_debuff:GetAuraRadius()
	return self.radius
end

function modifier_ghost_shroud_custom_aura_debuff:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_ghost_shroud_custom_aura_debuff:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_ghost_shroud_custom_aura_debuff:GetAuraSearchType()
	return self:GetAbility():GetAbilityTargetType()
end

function modifier_ghost_shroud_custom_aura_debuff:GetModifierAura()
	return "modifier_ghost_shroud_custom_debuff"
end

modifier_ghost_shroud_custom_debuff = class({})

function modifier_ghost_shroud_custom_debuff:IsHidden() return false end
function modifier_ghost_shroud_custom_debuff:IsDebuff() return true end

function modifier_ghost_shroud_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_spirit_debuff.vpcf"
end

function modifier_ghost_shroud_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_ghost_shroud_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("movement_speed") * (-1)
	end
end