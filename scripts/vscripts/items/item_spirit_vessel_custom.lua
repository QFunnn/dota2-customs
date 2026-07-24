--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_spirit_vessel_custom", "items/item_spirit_vessel_custom", LUA_MODIFIER_MOTION_NONE )

item_spirit_vessel_custom = class({})

function item_spirit_vessel_custom:GetIntrinsicModifierName()
	return "modifier_item_spirit_vessel_custom"
end

function item_spirit_vessel_custom:OnSpellStart()
	if not IsServer() then return end

	local duration = self:GetSpecialValueFor("duration")
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:EmitSound("DOTA_Item.UrnOfShadows.Activate")

	local particle_fx = ParticleManager:CreateParticle("particles/items4_fx/spirit_vessel_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle_fx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_fx, 1, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)

	if target:GetTeam() == caster:GetTeam() then
		target:AddNewModifier(caster, self, "modifier_item_spirit_vessel_heal", {duration = duration })
	else
		target:AddNewModifier(caster, self, "modifier_item_spirit_vessel_damage", {duration = duration * (1 - target:GetStatusResistance()) })
	end
end

modifier_item_spirit_vessel_custom = class({})
function modifier_item_spirit_vessel_custom:IsHidden() return true end
function modifier_item_spirit_vessel_custom:IsPurgable() return false end
function modifier_item_spirit_vessel_custom:RemoveOnDeath()	return false end
function modifier_item_spirit_vessel_custom:IsPurgable() return false end
function modifier_item_spirit_vessel_custom:IsPurgeException() return false end

function modifier_item_spirit_vessel_custom:DeclareFunctions()
	local decFuns =
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
	return decFuns
end

function modifier_item_spirit_vessel_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_spirit_vessel_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_spirit_vessel_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_spirit_vessel_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_spirit_vessel_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_spirit_vessel_custom:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end