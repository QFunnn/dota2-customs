--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_quelling_ring", "items/item_quelling_ring", LUA_MODIFIER_MOTION_NONE)

item_quelling_ring = class({})

function item_quelling_ring:GetAOERadius()
	return self:GetSpecialValueFor("trees_destoy")
end

function item_quelling_ring:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorPosition()
	GridNav:DestroyTreesAroundPoint(target, self:GetSpecialValueFor("trees_destoy"), true)
end

function item_quelling_ring:GetIntrinsicModifierName()
	return "modifier_item_quelling_ring"
end

modifier_item_quelling_ring = class({})

function modifier_item_quelling_ring:IsHidden() return true end

function modifier_item_quelling_ring:IsPurgable() return false end
function modifier_item_quelling_ring:IsPurgeException() return false end

function modifier_item_quelling_ring:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_quelling_ring:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	}
end

function modifier_item_quelling_ring:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_quelling_ring:GetModifierProcAttack_BonusDamage_Physical( keys )
	if not IsServer() then return end
	if keys.target and not keys.target:IsHero() and not keys.target:IsOther() and not keys.target:IsBuilding() and not string.find(keys.target:GetUnitName(), "npc_dota_lone_druid_bear") and keys.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		if self:GetParent():FindAllModifiersByName("modifier_item_quelling_ring")[1] ~= self then return end
		return self:GetAbility():GetSpecialValueFor("bonus_damage_creep")
	end
end