--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_arcane_ring_custom", "items/item_arcane_ring_custom", LUA_MODIFIER_MOTION_NONE)

item_arcane_ring_custom = class({})

function item_arcane_ring_custom:GetIntrinsicModifierName()
	return "modifier_item_arcane_ring_custom"
end

function item_arcane_ring_custom:OnSpellStart()
	if not IsServer() then return end
	local mana = self:GetCaster():GetMaxMana() / 100 * self:GetSpecialValueFor("mana_restore")
	self:GetCaster():EmitSound("DOTA_Item.ArcaneRing.Cast")
	local particle = ParticleManager:CreateParticle("particles/items_fx/arcane_boots.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
  	ParticleManager:ReleaseParticleIndex(particle)
  	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(particle_2)
	self:GetCaster():GiveMana(mana)
end

modifier_item_arcane_ring_custom = class({})

function modifier_item_arcane_ring_custom:IsHidden() return true end
function modifier_item_arcane_ring_custom:IsPurgable() return false end
function modifier_item_arcane_ring_custom:IsPurgeException() return false end
function modifier_item_arcane_ring_custom:RemoveOnDeath() return false end

function modifier_item_arcane_ring_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_arcane_ring_custom:GetModifierBonusStats_Intellect()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end

function modifier_item_arcane_ring_custom:GetModifierPhysicalArmorBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end