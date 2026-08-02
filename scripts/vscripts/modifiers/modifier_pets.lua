--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_pets = class({})

function modifier_pets:IsHidden()
	return true
end

function modifier_pets:IsPurgable()
	return false
end

function modifier_pets:CheckState()
	local parent = self:GetParent()
	if not parent or parent:IsNull() then
		return {}
	end
	local is_jackpot = parent:GetUnitName() == "jackpot_pet" or parent:GetUnitName() == "jackpot_pet2"

	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING] = not is_jackpot,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
	return state
end