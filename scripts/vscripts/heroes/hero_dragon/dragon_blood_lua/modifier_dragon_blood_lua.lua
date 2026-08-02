--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_blood_lua = class({})

function modifier_dragon_blood_lua:IsHidden()
	return true
end

function modifier_dragon_blood_lua:IsDebuff()
	return false
end

function modifier_dragon_blood_lua:IsPurgable()
	return false
end

function modifier_dragon_blood_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_dragon_blood_lua:GetModifierConstantHealthRegen()
	if not self:GetParent():PassivesDisabled() then
		self.regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
		local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_7")
		if talent and talent:GetLevel() > 0 then
			self.regen = self.regen + 4
		end
		return self.regen * self:GetCaster():GetLevel()
	end
end

function modifier_dragon_blood_lua:GetModifierPhysicalArmorBonus()
	if not self:GetParent():PassivesDisabled() then
		self.armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
		local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_7")
		if talent and talent:GetLevel() > 0 then
			self.armor = self.armor + 0.6
		end
		return self.armor * self:GetCaster():GetLevel()
	end
end