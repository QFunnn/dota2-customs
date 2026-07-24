--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_soul_reaver", "items/item_soul_reaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_soul_reaver_debuff", "items/item_soul_reaver", LUA_MODIFIER_MOTION_NONE)

item_soul_reaver = class({})

function item_soul_reaver:GetIntrinsicModifierName()
	return "modifier_item_soul_reaver"
end

modifier_item_soul_reaver = class({})

function modifier_item_soul_reaver:IsHidden() return true end

function modifier_item_soul_reaver:IsPurgable() return false end
function modifier_item_soul_reaver:IsPurgeException() return false end

function modifier_item_soul_reaver:IsAura() return true end

function modifier_item_soul_reaver:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():FindAllModifiersByName("modifier_item_soul_reaver")[1] ~= self then self:SetStackCount(0) return end
	local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	if #targets > 0 then
		self:SetStackCount(1)
	else
		self:SetStackCount(0)
	end
end

function modifier_item_soul_reaver:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_item_soul_reaver:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(0)
	self:StartIntervalThink(0.1)
end

function modifier_item_soul_reaver:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_item_soul_reaver:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_soul_reaver:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_item_soul_reaver:GetModifierAura()
	return "modifier_item_soul_reaver_debuff"
end

function modifier_item_soul_reaver:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_item_soul_reaver:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end

function modifier_item_soul_reaver:GetModifierExtraHealthPercentage()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_soul_reaver:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_soul_reaver:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_soul_reaver:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_restore") * self:GetStackCount()
end

function modifier_item_soul_reaver:GetModifierBonusStats_Agility()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_agi")
    end
end

function modifier_item_soul_reaver:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_int")
    end
end

modifier_item_soul_reaver_debuff = class({})

function modifier_item_soul_reaver_debuff:IsPurgable() return false end

function modifier_item_soul_reaver_debuff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_item_soul_reaver_debuff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetAbility():GetSpecialValueFor("damage_per_second")
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_PURE})
end