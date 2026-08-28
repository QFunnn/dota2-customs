--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_desolator_golden", "modifiers/modifier_golden_unit.lua", LUA_MODIFIER_MOTION_NONE)

modifier_golden_unit = class({})

function modifier_golden_unit:IsHidden()
	return true
end

function modifier_golden_unit:IsPurgable()
	return false
end

function modifier_golden_unit:RemoveOnDeath()
	return false
end

function modifier_golden_unit:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

----------------------------------BONUS----------------------------------------------------------

function modifier_golden_unit:GetModifierProcAttack_Feedback(params)
	params.target:AddNewModifier(
		self:GetParent(),
		self,
		"modifier_desolator_golden",
		{ duration = 5, armor_reduction = (self:GetStackCount() / 100) }
	)
end

function modifier_golden_unit:GetModifierExtraHealthBonus()
	return self:GetStackCount() * 5
end

function modifier_golden_unit:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() / 100
end

function modifier_golden_unit:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end

function modifier_golden_unit:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount() / 50
end

--------------------------------------

modifier_desolator_golden = class({})

function modifier_desolator_golden:IsHidden()
	return false
end

function modifier_desolator_golden:IsDebuff()
	return true
end

function modifier_desolator_golden:IsPurgable()
	return true
end

function modifier_desolator_golden:GetTexture()
	return "all/desolator_6"
end

function modifier_desolator_golden:OnCreated(data)
	if not IsServer() then
		return
	end
	self.interval = false
	self.armor_reduction = 0
	if data.armor_reduction then
		self.armor_reduction = data.armor_reduction
	end
	self:SetHasCustomTransmitterData(true)
end

function modifier_desolator_golden:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_desolator_golden:GetModifierPhysicalArmorBonus()
	return self.armor_reduction * -1
end

function modifier_desolator_golden:GetModifierMagicalResistanceBonus()
	return self.armor_reduction * -1
end

function modifier_desolator_golden:AddCustomTransmitterData()
	return {
		armor_reduction = self.armor_reduction,
	}
end

function modifier_desolator_golden:HandleCustomTransmitterData(data)
	self.armor_reduction = data.armor_reduction
end