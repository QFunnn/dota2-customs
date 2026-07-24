--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ancient_guardian_custom", "items/item_ancient_guardian_custom", LUA_MODIFIER_MOTION_NONE)

item_ancient_guardian_custom = class({})

function item_ancient_guardian_custom:GetIntrinsicModifierName()
	return "modifier_item_ancient_guardian_custom"
end

modifier_item_ancient_guardian_custom = class({})
function modifier_item_ancient_guardian_custom:IsPurgable() return false end
function modifier_item_ancient_guardian_custom:IsHidden() return true end
function modifier_item_ancient_guardian_custom:IsPurgeException() return false end
function modifier_item_ancient_guardian_custom:IsPurgable() return false end
function modifier_item_ancient_guardian_custom:RemoveOnDeath() return false end

function modifier_item_ancient_guardian_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
	}
end

function modifier_item_ancient_guardian_custom:OnTakeDamage(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if not self:GetParent():IsRealHero() then return end
	if params.unit == self:GetParent() then return end
	if params.inflictor == nil then return end
	if params.inflictor == self:GetAbility() then return end
	if params.inflictor:IsItem() then return end
	if params.damage < self:GetAbility():GetSpecialValueFor("min_damage_to_activate") then return end
	if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():HasModifier("modifier_item_khanda_custom") then return end
	if self:GetParent():FindAllModifiersByName("modifier_item_ancient_guardian_custom")[1] ~= self then return end
	--if (self:GetParent():GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > 1200 then return end
	self:GetAbility():UseResources(false, false, false, true)
    local damage = params.unit:GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("bonus_spell_damage")
    if params.unit:IsAncient() then
        damage = damage / 2
    end
	ApplyDamage({attacker = self:GetCaster(), victim = params.unit, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PURE})

	local particle = ParticleManager:CreateParticle("particles/items_fx/phylactery_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
	ParticleManager:SetParticleControlEnt(particle, 0, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)

	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(particle_2, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle_2, 1, params.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", params.unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle_2)

	params.unit:EmitSound("Item.Phylactery.Target")
end

function modifier_item_ancient_guardian_custom:GetModifierConstantManaRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_mana")
	end
end

function modifier_item_ancient_guardian_custom:GetModifierPercentageCasttime()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("cast_point")
    end
end

function modifier_item_ancient_guardian_custom:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_health")
	end
end

function modifier_item_ancient_guardian_custom:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_ancient_guardian_custom:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end

function modifier_item_ancient_guardian_custom:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	end
end