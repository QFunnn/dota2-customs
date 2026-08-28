--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sasori_red_secret", "heroes/akatsuki/sasori", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sasori_poison", "heroes/akatsuki/sasori", LUA_MODIFIER_MOTION_NONE)

sasori_red_secret_technique = class({})

function sasori_red_secret_technique:GetIntrinsicModifierName()
	return "modifier_sasori_red_secret"
end

---------------------------------------------------------------------------

modifier_sasori_red_secret = class({})

function modifier_sasori_red_secret:IsHidden()
	return true
end
function modifier_sasori_red_secret:IsPurgable()
	return false
end
function modifier_sasori_red_secret:IsPermanent()
	return true
end

function modifier_sasori_red_secret:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_sasori_red_secret:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
	end
end

function modifier_sasori_red_secret:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_sasori_red_secret:OnAttackLanded(data)
	if not IsServer() then
		return
	end
	if data.attacker ~= self:GetParent() then
		return
	end
	local target = data.target
	if not target or target:IsNull() or not target:IsAlive() then
		return
	end

	local caster = self:GetParent()
	local duration = self:GetAbility():GetSpecialValueFor("poison_duration")
	local max_stacks = self:GetAbility():GetSpecialValueFor("max_poison_stacks")

	local existing = target:FindModifierByName("modifier_sasori_poison")
	if existing then
		if existing:GetStackCount() < max_stacks then
			existing:SetStackCount(existing:GetStackCount() + 1)
			existing:ForceRefresh()
		end
	else
		local mod = target:AddNewModifier(caster, self:GetAbility(), "modifier_sasori_poison", { duration = duration })
		if mod then
			mod:SetStackCount(1)
		end
	end
end

---------------------------------------------------------------------------

modifier_sasori_poison = class({})

function modifier_sasori_poison:IsHidden()
	return false
end
function modifier_sasori_poison:IsDebuff()
	return true
end
function modifier_sasori_poison:IsPurgable()
	return false
end

function modifier_sasori_poison:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_sasori_poison:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local dmg_pct = self:GetAbility():GetSpecialValueFor("poison_dps_per_stack") / 100
	local dmg = caster:GetAverageTrueAttackDamage(caster) * dmg_pct * self:GetStackCount()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = caster,
		damage = dmg,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end

function modifier_sasori_poison:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_sasori_poison:GetModifierHealAmplify_Percentage()
	return -self:GetAbility():GetSpecialValueFor("heal_reduction_per_stack") * self:GetStackCount()
end

function modifier_sasori_poison:GetModifierHPRegenAmplify_Percentage()
	return -self:GetAbility():GetSpecialValueFor("heal_reduction_per_stack") * self:GetStackCount()
end

function modifier_sasori_poison:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_nova_debuff.vpcf"
end

function modifier_sasori_poison:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end