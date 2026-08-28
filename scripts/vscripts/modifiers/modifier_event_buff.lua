--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_event_buff = class({})

function modifier_event_buff:IsHidden()
	return false
end
function modifier_event_buff:IsPurgable()
	return false
end

function modifier_event_buff:OnCreated(kv)
	self.armor_per_stack = 0.3
	self.attack_speed_per_stack = 1
	self.mag_resist_per_stack = 0.1
end

function modifier_event_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_event_buff:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self.armor_per_stack
end

function modifier_event_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * self.attack_speed_per_stack
end

function modifier_event_buff:GetModifierMagicalResistanceBonus()
	return self:GetStackCount() * self.mag_resist_per_stack
end