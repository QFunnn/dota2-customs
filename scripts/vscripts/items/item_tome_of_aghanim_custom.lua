--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_tome_of_aghanim_custom", "items/item_tome_of_aghanim_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_tome_of_aghanim_custom_consume", "items/item_tome_of_aghanim_custom", LUA_MODIFIER_MOTION_NONE)

item_tome_of_aghanim_custom = class({})

function item_tome_of_aghanim_custom:GetIntrinsicModifierName()
	return "modifier_item_tome_of_aghanim_custom"
end

modifier_item_tome_of_aghanim_custom = class({})
function modifier_item_tome_of_aghanim_custom:IsPurgable() return false end
function modifier_item_tome_of_aghanim_custom:IsPurgeException() return false end
function modifier_item_tome_of_aghanim_custom:RemoveOnDeath() return false end

function modifier_item_tome_of_aghanim_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_item_tome_of_aghanim_custom:GetModifierIncomingDamage_Percentage()
	local count = self:GetParent():GetStrength() / self:GetAbility():GetSpecialValueFor("str_to_bonus")
	count = math.min(count, 5)
	return self:GetAbility():GetSpecialValueFor("str_damage_reduce") * count * -1
end

function modifier_item_tome_of_aghanim_custom:GetModifierTotalDamageOutgoing_Percentage()
	local count = self:GetParent():GetAgility() / self:GetAbility():GetSpecialValueFor("agi_to_bonus")
	count = math.min(count, 5)
	return self:GetAbility():GetSpecialValueFor("agi_damage_bonus") * count
end

function modifier_item_tome_of_aghanim_custom:GetModifierSpellAmplify_Percentage()
	local count = self:GetParent():GetIntellect(false) / self:GetAbility():GetSpecialValueFor("int_to_bonus")
	count = math.min(count, 25)
	return self:GetAbility():GetSpecialValueFor("int_damage_amplify") * count
end

modifier_item_tome_of_aghanim_custom_consume = modifier_item_tome_of_aghanim_custom