--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_meepo_ransack_custom", "heroes/hero_meepo/meepo_ransack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_ransack_custom_debuff", "heroes/hero_meepo/meepo_ransack", LUA_MODIFIER_MOTION_NONE)

meepo_ransack_custom = class({})

function meepo_ransack_custom:GetIntrinsicModifierName()
	return "modifier_meepo_ransack_custom"
end

function meepo_ransack_custom:GetCooldown(iLevel)
    return self.BaseClass.GetCooldown(self, iLevel) / self:GetCaster():GetCooldownReduction()
end

modifier_meepo_ransack_custom = class({})
function modifier_meepo_ransack_custom:IsHidden() return true end
function modifier_meepo_ransack_custom:IsPurgable() return false end
function modifier_meepo_ransack_custom:IsPurgeException() return false end
function modifier_meepo_ransack_custom:RemoveOnDeath() return false end

function modifier_meepo_ransack_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage = self.ability:GetSpecialValueFor("damage_physical")
    self.dur = self.ability:GetSpecialValueFor("duration_debuff")
end

function modifier_meepo_ransack_custom:OnRefresh()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage = self.ability:GetSpecialValueFor("damage_physical")
    self.dur = self.ability:GetSpecialValueFor("duration_debuff")
end

function modifier_meepo_ransack_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_meepo_ransack_custom:GetModifierPreAttack_BonusDamage(params)
	if not IsServer() then return end
	if params.target == nil then return end
    if params.attacker:PassivesDisabled() then return end
    if not self.ability:IsFullyCastable() then return end
    self.ability:UseResources(false, false, false, true)
	local roshan_phys_immune_resist = 1
    local roshan_phys_immune = params.target:FindAbilityByName("roshan_phys_immune")
    if roshan_phys_immune then
        roshan_phys_immune_resist = 1 - (roshan_phys_immune:GetSpecialValueFor("phys_immune") / 100)
    end
	local leech = params.target:GetMaxHealth() / 100 * self.damage
	local bonus = leech * roshan_phys_immune_resist
	if _G.Players and _G.Players.QueueAttackBonus then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "meepo_ransack_custom", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end

function modifier_meepo_ransack_custom:TakeDamageScriptModifier( params )
	if not IsServer() then return end
	if params.unit == self.parent then return end
	if params.attacker ~= self.parent then return end
	if params.attacker:PassivesDisabled() then return end
	if params.attacker:IsIllusion() then return end
	if params.no_attack_cooldown then return end
	if params.inflictor ~= nil then return end
	local leech = params.unit:GetMaxHealth() / 100 * self.damage
	self.parent:Heal(leech, self.ability)
	local duration = self.dur
    params.unit:AddNewModifier(self.parent, self.ability, "modifier_meepo_ransack_custom_debuff", {duration = duration})
end

modifier_meepo_ransack_custom_debuff = class({})

function modifier_meepo_ransack_custom_debuff:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.minus_regen = self:GetAbility():GetSpecialValueFor("minus_regen")
end

function modifier_meepo_ransack_custom_debuff:OnRefresh()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.minus_regen = self:GetAbility():GetSpecialValueFor("minus_regen")
end

function modifier_meepo_ransack_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
	}
end

function modifier_meepo_ransack_custom_debuff:GetModifierLifestealRegenAmplify_Percentage()
	return self.minus_regen
end

function modifier_meepo_ransack_custom_debuff:GetModifierHealAmplify_PercentageTarget()
	return self.minus_regen
end

function modifier_meepo_ransack_custom_debuff:GetModifierHPRegenAmplify_Percentage()
	return self.minus_regen
end

function modifier_meepo_ransack_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end