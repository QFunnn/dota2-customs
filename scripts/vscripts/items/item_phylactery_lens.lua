--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_phylactery_lens", "items/item_phylactery_lens", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_phylactery_lens_debuff", "items/item_phylactery_lens", LUA_MODIFIER_MOTION_NONE)

item_phylactery_lens = class({})

function item_phylactery_lens:GetIntrinsicModifierName()
	return "modifier_item_phylactery_lens"
end

modifier_item_phylactery_lens = class({})
function modifier_item_phylactery_lens:IsPurgable() return false end
function modifier_item_phylactery_lens:IsHidden() return true end
function modifier_item_phylactery_lens:IsPurgeException() return false end
function modifier_item_phylactery_lens:IsPurgable() return false end
function modifier_item_phylactery_lens:RemoveOnDeath() return false end

function modifier_item_phylactery_lens:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS
	}
end

function modifier_item_phylactery_lens:OnTakeDamage(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if not self:GetParent():IsRealHero() then return end
	if params.unit == self:GetParent() then return end
	if params.inflictor == nil then return end
	if params.inflictor == self:GetAbility() then return end
	if params.inflictor:IsItem() then return end
	if params.damage < self:GetAbility():GetSpecialValueFor("min_damage_to_activate") then return end
	if not self:GetAbility():IsFullyCastable() then return end
	if self:GetParent():FindAllModifiersByName("modifier_item_phylactery_lens")[1] ~= self then return end
	if self:GetParent():HasModifier("modifier_item_phylactery") then return end

	self:GetAbility():UseResources(false, false, false, true)
	ApplyDamage({attacker = self:GetCaster(), victim = params.unit, ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("bonus_spell_damage"), damage_type = DAMAGE_TYPE_MAGICAL})
	params.unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_phylactery_lens_debuff", {duration = self:GetAbility():GetSpecialValueFor("slow_duration")})
	
	local particle = ParticleManager:CreateParticle("particles/items_fx/phylactery_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
	ParticleManager:SetParticleControlEnt(particle, 0, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)

	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(particle_2, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle_2, 1, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle_2)


	params.unit:EmitSound("Item.Phylactery.Target")
end

function modifier_item_phylactery_lens:GetModifierManaBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_mana")
	end
end

function modifier_item_phylactery_lens:GetModifierHealthBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_health")
	end
end

function modifier_item_phylactery_lens:GetModifierConstantManaRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("mana_regen")
	end
end

function modifier_item_phylactery_lens:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_phylactery_lens:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_phylactery_lens:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_phylactery_lens:GetModifierCastRangeBonus()
	return self:GetAbility():GetSpecialValueFor("cast_range_bonus")
end

modifier_item_phylactery_lens_debuff = class({})

function modifier_item_phylactery_lens_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_item_phylactery_lens_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("slow")
end