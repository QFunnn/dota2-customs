--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_khanda_custom", "items/item_khanda_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_khanda_custom_debuff", "items/item_khanda_custom", LUA_MODIFIER_MOTION_NONE)

item_khanda_custom = class({})

function item_khanda_custom:GetIntrinsicModifierName()
	return "modifier_item_khanda_custom"
end

modifier_item_khanda_custom = class({})
function modifier_item_khanda_custom:IsPurgable() return false end
function modifier_item_khanda_custom:IsHidden() return true end
function modifier_item_khanda_custom:IsPurgeException() return false end
function modifier_item_khanda_custom:IsPurgable() return false end
function modifier_item_khanda_custom:RemoveOnDeath() return false end

function modifier_item_khanda_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_khanda_custom:OnTakeDamage(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if not self:GetParent():IsRealHero() then return end
	if params.unit == self:GetParent() then return end
	if params.inflictor == nil then return end
	if params.inflictor == self:GetAbility() then return end
	if params.inflictor:IsItem() then return end
	
	if params.damage < self:GetAbility():GetSpecialValueFor("min_damage_to_activate") then return end

	if not self:GetAbility():IsFullyCastable() then return end

	if self:GetParent():FindAllModifiersByName("modifier_item_khanda_custom")[1] ~= self then return end

	self:GetAbility():UseResources(false, false, false, true)

    local damage = self:GetAbility():GetSpecialValueFor("bonus_spell_damage") + (self:GetParent():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility():GetSpecialValueFor("spell_crit_multiplier"))

	ApplyDamage({attacker = self:GetCaster(), victim = params.unit, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})

	params.unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_khanda_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("slow_duration") * (1-params.unit:GetStatusResistance())})
	
	local particle = ParticleManager:CreateParticle("particles/items_fx/phylactery_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
	ParticleManager:SetParticleControlEnt(particle, 0, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)

	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(particle_2, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle_2, 1, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle_2)

	params.unit:EmitSound("Item.Phylactery.Target")
end

function modifier_item_khanda_custom:GetModifierManaBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_mana")
	end
end

function modifier_item_khanda_custom:GetModifierHealthBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_health")
	end
end

function modifier_item_khanda_custom:GetModifierConstantManaRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	end
end

function modifier_item_khanda_custom:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	end
end

function modifier_item_khanda_custom:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_khanda_custom:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_khanda_custom:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

modifier_item_khanda_custom_debuff = class({})

function modifier_item_khanda_custom_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_item_khanda_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_item_khanda_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_PASSIVES_DISABLED] = true,
    }
end