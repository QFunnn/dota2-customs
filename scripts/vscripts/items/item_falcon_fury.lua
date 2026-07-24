--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_falcon_fury", "items/item_falcon_fury", LUA_MODIFIER_MOTION_NONE)

item_falcon_fury = class({})

function item_falcon_fury:GetIntrinsicModifierName()
	return "modifier_item_falcon_fury"
end

function item_falcon_fury:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	GridNav:DestroyTreesAroundPoint(point, self:GetSpecialValueFor("active_radius"), true)
end

function item_falcon_fury:GetAOERadius()
	return self:GetSpecialValueFor("active_radius")
end

modifier_item_falcon_fury = class({})

function modifier_item_falcon_fury:AllowIllusionDuplicate()	return false end
function modifier_item_falcon_fury:IsPurgable()	return false end
function modifier_item_falcon_fury:RemoveOnDeath() return false end
function modifier_item_falcon_fury:IsHidden() return true end
function modifier_item_falcon_fury:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_falcon_fury:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		 
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
	return funcs
end

function modifier_item_falcon_fury:GetModifierPreAttack_BonusDamage(keys)
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_damage")
	end
end

function modifier_item_falcon_fury:GetModifierConstantManaRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	end
end

function modifier_item_falcon_fury:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	end
end

function modifier_item_falcon_fury:GetModifierHealthBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("health_bonus")
	end
end

function modifier_item_falcon_fury:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
	local damage = params.damage / 100 * self:GetAbility():GetSpecialValueFor("cleave_damage_percent")
	if not params.target:IsHero() then
		damage = params.damage / 100 * self:GetAbility():GetSpecialValueFor("cleave_damage_percent_creep")
	end
	DoCleaveAttack(params.attacker, params.target, self:GetAbility(), damage, self:GetAbility():GetSpecialValueFor("cleave_starting_width"),self:GetAbility():GetSpecialValueFor("cleave_ending_width"), self:GetAbility():GetSpecialValueFor("cleave_distance"), "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf")
end