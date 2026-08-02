--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_item_crimson_guard_extra_custom = class({})
function modifier_item_crimson_guard_extra_custom:OnCreated()
	self.damage = self:GetAbility():GetSpecialValueFor("incoming_damage")
end
function modifier_item_crimson_guard_extra_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_crimson_guard_extra_custom:GetModifierIncomingDamage_Percentage(params)
	if params.damage_type == DAMAGE_TYPE_PHYSICAL then
		return self.damage
	end
end